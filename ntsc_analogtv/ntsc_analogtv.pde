// This is Processing/Java port of XAnalogTV hack from XScreensaver 5.32 oryginally written by Trevor Blackwell in 2003.
// http://www.jwz.org/xscreensaver/
// https://www.youtube.com/watch?v=VmM1KkFsry0
// Licence at the end of the file

// How to use:
// Put your image(s) into sketch folder and set variables below: imagename and optionally secondimage (can be set to null)
// Run script and:
//   Click mouse to set random settings
//   Press space to save to PNG
//   Press ENTER to reset to default setting
//   Press 'i' for interactive mode
// Have fun :)
//
// Tweaking: see variables below, change parameters as stated in comment, experiment. This affects default setting.
//
// How does it work? It's complicated :)
// To make things short.
// image -> NTSC signal and frame (color burst, sync hsync and vsync bars)
// reception object keeps signal and its parameters (level, offset, etc)
// tv takes signal, tries to sync, add all the noise, ghosting, shifting, etc. than decode signal to YIQ and at last RGB.
// If you want more info, see original code (analogtv.c, xanalogtv.c, be patient)
//   see java code (see inside GenerateMeLibs.jar in code folder)
//   or ask me on generateme.blog@gmail.com 

import generateme.analogtv.*;

// CONFIGURATION BEGIN

String filename = "test"; // should have 4:3 ratio
String fileext = ".jpg";
String foldername = "./";

//String secondimage = "people.jpg"; // if you want to mix with second image, put its name here, full path here
String secondimage = null;

// General settings
int W = 600; // width of the screen, height is 75% of width to have 4:3 ratio
float NOISE = 0.06; // TV noise, value range: (0.0,1.0)

boolean interactive_mode = false; // press i and move mouse to adjust level (x axis) and signal loss (y axis)

// Reception settings
int OFS = 0; // initial signal offset, set randomly to see signal synchronization process, value range: (0.0,tv.ANALOGTV_SIGNAL_LEN)
float LEVEL = 1.0; // signal level, range: (0.0,5.0) (high saturation)
float MULTIPATH = 0.5; // signal ghosting ratio, range: (0.0,1.0) (maybe even 2.0, higher values can cause program error, but signal change is more dramatic)
int FREQERR = 0; // continuously change signal offset (each frame) by FREQERR, range: (-tv.ANALOGTV_SIGNAL_LEN,tv.ANALOGTV_SIGNAL_LEN)
float HFLOSS = 0; // signal self-interference (I guess :) ) ratio, value: (-2.0,5.0)
float HFLOSS2 = 0; // autochange of hfloss, range: (-5.0,5.0) do_hfloss2 should be true and multipath should be higher than 0.0
boolean DO_HFLOSS2 = false;
boolean COLOR_SYNC = true; // do color synchronization (color burst in signal)
boolean DISABLE_SYNC = false; // do not synchronize signal
boolean SECOND_RECEPTION = true; // add second signal, setup 'secondimage' variable to add image instead of noise

// TV settings
float TINT_CONTROL = 0; // chroma shift, range: (0.0,360.0) 
float BRIGHTNESS_CONTROL = 0.05; // brightness, range: (0.0,0.5)
float COLOR_CONTROL = 0.7; // color, range: (0.0,5.0)
float CONTRAST_CONTROL = 1.5; // contrast, range (0.0,5.0)
float SQUISH_CONTROL = 0.05; // squeeze right side of the screen, range (0.0,0.3)
float HORIZ_DESYNC = 5; // shift top of the screen, range (-5,5)
boolean FLUTTER_HORIZ_DESYNC = true; // flutter of top side of the screen
boolean SHRINK_ENABLE = true; // random screen shrinking
float HEIGHT_CONTROL = 1; // squeeze screen vertically, range (0.8,1.0)
float WIDTH_CONTROL = 1.0; // squeeze screen horizontally, range (0.8,1.0)
int CHANNEL_CHANGE_CYCLES = 200000; // channel change simulation parameter, must be divisible by 4
int POWERUP = 0; // "time" from switching tv on, set to 1000 to have tv on instantly 
float SQUEEZEBOTTOM = 5; // squeeze bottom of the screen, range (-10,10)
boolean TELETEXT = true; // add teletext stripes

// CONFIGURATION END

// TV object
TV tv;
// Signal objects
Reception rec1; // image
Reception rec2; // noise

String sessionid;

void setup() {
  sessionid = hex((int)random(0xffff),4);
  size(W,3*W/4);
  background(0);
  noStroke();
  
  tv = new TV(this, width, height);
  tv.powerup = POWERUP;
  
  reset();
  frameRate(30);
}

void reset() {
  tv.tint_control = TINT_CONTROL;
  tv.brightness_control = BRIGHTNESS_CONTROL;
  tv.color_control = COLOR_CONTROL;
  tv.contrast_control = CONTRAST_CONTROL;
  tv.squish_control = SQUISH_CONTROL;
  tv.flutter_horiz_desync = FLUTTER_HORIZ_DESYNC;
  tv.shrink_enable = SHRINK_ENABLE;
  tv.height_control = HEIGHT_CONTROL;
  tv.width_control = WIDTH_CONTROL;
  tv.channel_change_cycles = CHANNEL_CHANGE_CYCLES;
  tv.squeezebottom = SQUEEZEBOTTOM;
  tv.horiz_desync = HORIZ_DESYNC;
  
  rec1 = new Reception(this);
  rec1.ofs = OFS;
  rec1.level = LEVEL;
  rec1.multipath = MULTIPATH;
  rec1.freqerr = FREQERR;
  rec1.hfloss = HFLOSS;
  rec1.hfloss2 = HFLOSS2;
  rec1.do_hfloss2 = DO_HFLOSS2;
  tv.setup_sync(rec1.signal,COLOR_SYNC, DISABLE_SYNC);
  tv.set_image(rec1.signal,loadImage(foldername+filename+fileext));
  if(TELETEXT) tv.setup_teletext(rec1.signal);
 
  rec2 = new Reception(this);
  rec2.level = 0.1;
  tv.setup_sync(rec2.signal,true,true);
  if(secondimage != null)
    tv.set_image(rec2.signal,loadImage(secondimage));
  
  tv.clear_receptions();
  tv.add_reception(rec1);
  if(SECOND_RECEPTION) tv.add_reception(rec2);
  n=NOISE;
}

void randomize() {
  tv.tint_control = random(1)<0.1?random(360):0;
  tv.brightness_control = random(0.01,0.2);
  tv.color_control = random(3);
  tv.contrast_control = random(0.5,2);
  tv.squish_control = random(0.05);
  tv.flutter_horiz_desync = random(1)<0.5;
  tv.shrink_enable = random(1)<0.5;
  tv.height_control = HEIGHT_CONTROL;
  tv.width_control = WIDTH_CONTROL;
  tv.channel_change_cycles = 4*(int)random(30000,50000);
  tv.squeezebottom = random(-10,10);
  tv.horiz_desync = random(-5,5);
  
  rec1 = new Reception(this);
  rec1.ofs = (int)random(TV.ANALOGTV_SIGNAL_LEN);
  rec1.level = sqrt(random(1))<0.8?random(0.5):random(3);
  rec1.multipath = random(1)<0.5?random(2):0;
  rec1.freqerr = (int)random(-5,5);
  rec1.hfloss = random(1)<0.2?random(-2,5):random(-1,1);
  rec1.hfloss2 = random(-2,5);
  rec1.do_hfloss2 = random(1)<0.2?true:false;
  tv.setup_sync(rec1.signal,random(1)<0.8, random(1)<0.2);
  if(random(1)<0.9) tv.set_image(rec1.signal,loadImage(foldername+filename+fileext));
  if(random(1)<0.5) tv.setup_teletext(rec1.signal);
 
  rec2 = new Reception(this);
  rec2.level = random(1);
  tv.setup_sync(rec2.signal,random(1)<0.8, random(1)<0.2);
  if(secondimage != null && random(1)<0.5) {
    tv.set_image(rec2.signal,loadImage(secondimage));
    if(random(1)<0.5) tv.setup_teletext(rec2.signal);
  } else if(random(1)<0.3)
    tv.set_image(rec2.signal,loadImage(foldername+filename+fileext));
  
  tv.clear_receptions();
  boolean onlynoise = random(1)<0.2;
  if(!onlynoise) tv.add_reception(rec1);
  if(random(1)<0.5 || onlynoise) tv.add_reception(rec2);
  n=random(random(1)<0.05?1:0.2);
}

float powerup_step = 1.0/15.0;
float n = NOISE;
void draw() {
  background(0);
  
  tv.powerup += powerup_step;
  try {
    if(interactive_mode) {
      rec1.level = map(mouseX,0,width-1,0,3);
      rec1.hfloss = map(mouseY,0,height-1,-1,1);
    }
    tv.draw(n);
  } catch (Exception e) { e.printStackTrace(); }
}

void mousePressed() {
  randomize();
}

int save_seq = 10000;

void keyPressed() {
  noLoop();
  switch(keyCode) {
    case ENTER: reset(); break;
    case RETURN: reset(); break;
    case 32: saveFrame(foldername + filename + "/res_" + sessionid + "_"+(save_seq++)+"_"+filename+fileext);
    default: break;
  }
  if(key == 'i') {
    interactive_mode = !interactive_mode;
    println("interactive mode: " + interactive_mode);
  }
  loop(); 
}

/*
 * Permission to use, copy, modify, distribute, and sell this software and its
 * documentation for any purpose is hereby granted without fee, provided that
 * the above copyright notice appear in all copies and that both that
 * copyright notice and this permission notice appear in supporting
 * documentation.  No representations are made about the suitability of this
 * software for any purpose.  It is provided "as is" without express or
 * implied warranty.
*/

// Drift pixels and blend, repeat
// Tomasz Sulej, generateme.blog@gmail.com, http://generateme.tumblr.com
// Licence: http://unlicense.org/

// Usage:
//   * press SPACE to save

// set up filename
String filename = "test";
String fileext = ".jpg";
String foldername = "./";

int max_display_size = 800; // viewing window size (regardless image size)

// config
int channel = HUE; // channel data used for shift
float channel_off = 60; // channel value offset
int iteration_no = 50; // number of iterations 10-100
int direction = UP; // UP, DOWN, LEFT, RIGHT
boolean image_mix = false; // mix with original image or current buffer
boolean automate_channel_offset = false; // if true, change channel_offset every iteration
float scale = 0.03; // 0.01 - 0.1, step size (0.01: 2px, 0.1:25px)
float feedback = 0.9; // 0.9 - 0.999 ; blend ratio with original image 

boolean do_blend = false; // blend image after process
int blend_mode = OVERLAY; // blend type

// working buffer
PGraphics buffer;

// image
PImage img, imgb;

String sessionid;
float acho_step;

void setup() {
  sessionid = hex((int)random(0xffff),4);
  img = loadImage(foldername+filename+fileext);
  imgb = img.get();
  
  buffer = createGraphics(img.width, img.height);
  buffer.beginDraw();
  buffer.noStroke();
  buffer.smooth(8);
  buffer.background(0);
  buffer.image(img,0,0);
  buffer.endDraw();
  
  // calculate window size
  float ratio = (float)img.width/(float)img.height;
  int neww, newh;
  if(ratio < 1.0) {
    neww = (int)(max_display_size * ratio);
    newh = max_display_size;
  } else {
    neww = max_display_size;
    newh = (int)(max_display_size / ratio);
  }

  surface.setResizable(true);
  surface.setSize(neww, newh);
  
  scale = abs(scale);
  acho_step = 256.0 / iteration_no;
  println(acho_step);
}

void draw() {
  if(iteration_no>0) {
    processImage(); 
    iteration_no--;
    println("steps left: "+iteration_no);
  } else {
    if(do_blend) {
      buffer.beginDraw();  
      buffer.blend(img,0,0,img.width,img.height,0,0,buffer.width,buffer.height,blend_mode);
      buffer.endDraw();
    }
    image(buffer,0,0,width,height);
    noLoop();
  }
}

void processImage() {
  buffer.beginDraw();
    
   for(int x=0;x<img.width;x++) {
    for(int y=0;y<img.height;y++) {
      color c = image_mix?img.get(x,y):buffer.get(x,y);
      color c2;
      if(direction == UP || direction == DOWN) {
        c2 = imgb.get(x,((int)(y+img.height+( (channel_off+getChannel(c,channel))%255 )*(direction==DOWN?-1.0:1.0)*scale))%img.height);
      } else {
        c2 = imgb.get(((int)(x+img.width+( (channel_off+getChannel(c,channel))%255)*(direction==RIGHT?-1.0:1.0)*scale))%img.width,y);
      }
      buffer.set(x,y,lerpColor(c,c2,feedback) );
    }
  } 
    
  buffer.endDraw();
  image(buffer,0,0,width,height);
  imgb = buffer.get();
  if(automate_channel_offset) channel_off += acho_step;
}

void keyPressed() {
  // SPACE to save
  if(keyCode == 32) {
    String fn = foldername + filename + "/res_" + sessionid + hex((int)random(0xffff),4)+"_"+filename+fileext;
    buffer.save(fn);
    println("Image "+ fn + " saved");
  }
}

//

final static int[] blends = {ADD, SUBTRACT, DARKEST, LIGHTEST, DIFFERENCE, EXCLUSION, MULTIPLY, SCREEN, OVERLAY, HARD_LIGHT, SOFT_LIGHT, DODGE, BURN};

// ALL Channels, Nxxx stand for negative (255-value)
// channels to work with
final static int RED = 0;
final static int GREEN = 1;
final static int BLUE = 2;
final static int HUE = 3;
final static int SATURATION = 4;
final static int BRIGHTNESS = 5;
final static int NRED = 6;
final static int NGREEN = 7;
final static int NBLUE = 8;
final static int NHUE = 9;
final static int NSATURATION = 10;
final static int NBRIGHTNESS = 11;

float getChannel(color c, int channel) {
  int ch = channel>5?channel-6:channel;
  float cc;
  
  switch(ch) {
    case RED: cc = red(c); break;
    case GREEN: cc = green(c); break;
    case BLUE: cc = blue(c); break;
    case HUE: cc = hue(c); break;
    case SATURATION: cc = saturation(c); break;
    default: cc= brightness(c); break;
  }
  
  return channel>5?255-cc:cc;
}

// Distortion of the image based on vvvv shader from glitchpack, http://vvvv.org/contribution/acid-glitch-shaders by idvyr
// Tomasz Sulej, generateme.blog@gmail.com, http://generateme.tumblr.com
// Licence: http://unlicense.org/

// Usage:
//   * press SPACE to save
//   * move mouse around image

// set up filename
String filename = "DfJpdFD copy";
String fileext = ".jpg";
String foldername = "./../";

int max_display_size = 1000; // viewing window size (regardless image size)

boolean do_blend = false; // blend image after process
int blend_mode = OVERLAY; // blend type
int channel = BRIGHTNESS; // channel used in processing (R,G,B) or (H,S,B)
float scalex = 0.05; // from 0.01 to 1
float scaley = 0.1; // from 0.01 to 1
boolean shift_hue = true;
float shift_amt = 0.1; // from 0 to 1

// working buffer
PGraphics buffer;

// image
PImage img;

String sessionid;

void setup() {
  sessionid = hex((int)random(0xffff),4);
  img = loadImage(foldername+filename+fileext);
  
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

  surface.setSize(neww,newh);
  
  // prepare distortion pattern
  for(int i=0;i<512;i++) {
    distort[0][i] = (int)random(-128,128);
    distort[1][i] = (int)random(-128,128);
  }

}

int[][] distort = new int[2][512];
final static float tick = 1.0/512.0;

void draw() {
  processImage();
}

void randomMe() {
  do_blend = random(1)<0.1;
  blend_mode = blends[(int)random(blends.length)];
  channel = (int)random(12);
  scalex = random(1)<0.7?random(0.01,0.1):random(1);
  scaley = random(1)<0.7?random(0.05,0.2):random(1);
  shift_hue = random(1)<0.3;
  shift_amt = random(0.7);
}

void processImage() {
  float neww = map(mouseX,0,width,1,img.width/4);
  float newh = map(mouseY,0,height,1,img.height/4);
    
  float totalnum = neww+newh;
  float times = (totalnum/floor(totalnum/neww));
  float offx = (totalnum%neww)/times;
  float ratiox = neww/img.width;
  
  buffer.beginDraw();  
    
  for(int y=0;y<img.height;y++) {
    float yy = y/(float)img.height;
    for(int x=0;x<img.width;x++) {
      float xx = x/(float)img.width;
      
      float offy = floor(newh*yy);
      float fx = xx*ratiox+offx*offy;
      
      float shift = fx%1.0;
      float st = shift/tick;
      int no1 = floor(st)%512;
      int no2 = ceil(st)%512;      
      float l = st-(float)no1;
      
      float cx = lerp(distort[0][no1],distort[0][no2],l);
      float cy = lerp(distort[1][no1],distort[1][no2],l);
      
      float rx =getChannel(img.get(x,y),channel);
      int sx = (int)((img.width+x+cx*rx*scalex*0.1)%img.width);
      int sy = (int)((img.height+y+cy*scaley)%img.height);
      
      color c=img.get(sx,sy);
      
      if(shift_hue) {
        colorMode(HSB,255);
        c = color((hue(c)+shift_amt*255*noise(newh+y))%255.0,constrain(saturation(c)*1.2,0,255),constrain(brightness(c),0,255));
        colorMode(RGB,255);
      }
    //  buffer.fill(lerpColor(c,img.get(x,y),0.2));
      buffer.fill(c);
      buffer.rect(x,y,1,1);
    }
  }  
    
  if(do_blend)
    buffer.blend(img,0,0,img.width,img.height,0,0,buffer.width,buffer.height,blend_mode);
    
  buffer.endDraw();
  image(buffer,0,0,width,height);
}

void keyPressed() {
  // SPACE to save
  if(keyCode == 32) {
    String fn = foldername + filename + "/res_" + sessionid + hex((int)random(0xffff),4)+"_"+filename+fileext;
    buffer.save(fn);
    println("Image "+ fn + " saved");
  }
}

void mouseClicked() {
  randomMe();
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

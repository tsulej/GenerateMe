// Image filter based on median filter
// Tomasz Sulej, generateme.blog@gmail.com, http://generateme.tumblr.com
// Licence: http://unlicense.org/

// Usage:
//   * press SPACE to save
//   * 0-8, choose position from sorted pixel data (4 for real median filter)

// set up filename
String filename = "test";
String fileext = ".jpg";
String foldername = "./";

int max_display_size = 1000; // viewing window size (regardless image size)

boolean do_blend = false; // blend image after process
int blend_mode = OVERLAY; // blend type

int position = 3; // value from 0 to 8, 4 - median filter
int channel = BRIGHTNESS;

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

  size(neww,newh);
  
  chan_data = new int[img.width][img.height];
}

void draw() {
  processImage();
}

int[][] chan_data;
int[] tmp = new int[9];

void processImage() {
  buffer.beginDraw();

  for(int x=0;x<img.width;x++) {
    for(int y=0;y<img.height;y++) {
      color c = buffer.get(x,y) & 0x00ffffff;
      chan_data[x][y] = ((((int)getChannel(c,channel)) & 0xff) << 24) | c;            
    }
  }
  
  
  for(int x=1;x<img.width-1;x++) {
    for(int y=1;y<img.height-1;y++) {
      tmp[0] = chan_data[x-1][y-1];
      tmp[1] = chan_data[x][y-1];
      tmp[2] = chan_data[x+1][y-1];
      
      tmp[3] = chan_data[x-1][y];
      tmp[4] = chan_data[x][y];
      tmp[5] = chan_data[x+1][y];

      tmp[6] = chan_data[x-1][y+1];
      tmp[7] = chan_data[x][y+1];
      tmp[8] = chan_data[x+1][y+1];

      int[] s = sort(tmp);
      buffer.fill( (s[position] & 0x00ffffff) | 0xff000000 );
      buffer.rect(x,y,1,1);      
    } //<>//
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
  if(keyCode >= 48 && keyCode <= 56) {
    position = keyCode - 48;
    println("Position = " + position);
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

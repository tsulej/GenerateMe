// Blend images with a target
// Tomasz Sulej, generateme.blog@gmail.com, http://generateme.tumblr.com
// Licence: http://unlicense.org/

// Usage:
//   * press SPACE to save
//   * click for random change of parameters

// set up filename of the target
String filename = "test";
String fileext = ".jpg";
String foldername = "./";

// how to blend COLOR or channel VALUE?
int mode = BLEND_COLOR; // BLEND_VALUE or BLEND_COLOR
// if channel VALUE set what channel
int VALUE_FOR_BLEND = BRIGHTNESS; // only if BLEND_VALUE chosen

// do you want random number of source used
boolean random_source = false; 

int max_display_size = 1000; // viewing window size (regardless image size)

boolean started = false;

boolean do_blend = false; // blend image after process
int blend_mode = OVERLAY; // blend type

// set up source image set
// using below variables filenames from the set are constructed
//   example: my images have names: bl1000.jpg, bl1001.jpg etc...
//            and are located in 'bl/' folder
//            I have 6 of them, with constant prefix: "bl/bl100" (pattern_prefix)
//            then every file has one sequence digit from 0 to 5 (pattern_init and pattern_length)
//            with 'pattern_size' digits for the sequence (here: one digit)
//            at the end 'file_ext' is added
//   below setting produce six names: bl/bl1000.jpg, bl/bl1001.jpg, bl/bl1002.jpg, bl/bl1003.jpg, bl/bl1004.jpg, bl/bl1005.jpg
final static String pattern_prefix = "bl/bl100";
final static String file_ext = ".jpg";
final static int pattern_init = 0; // starting number
final static int pattern_length = 6; // how many images from the set, don't use more than 10
final static int pattern_size = 1; // number of digits

final static int BLEND_COLOR = 0;
final static int BLEND_VALUE = 1;

// working buffer
PGraphics buffer;

// image
PImage img;

String sessionid;

PImage[] sset = new PImage[pattern_length]; 

void setup() {
  sessionid = hex((int)random(0xffff), 4);
  img = loadImage(foldername+filename+fileext);
  img.loadPixels();

  buffer = createGraphics(img.width, img.height);
  buffer.beginDraw();
  buffer.loadPixels();

  // calculate window size
  float ratio = (float)img.width/(float)img.height;
  int neww, newh;
  if (ratio < 1.0) {
    neww = (int)(max_display_size * ratio);
    newh = max_display_size;
  } else {
    neww = max_display_size;
    newh = (int)(max_display_size / ratio);
  }

  surface.setResizable(true);
  surface.setSize(neww, newh);

  for (int i=0; i<pattern_length; i++) {
    String suf = nf(i+pattern_init, pattern_size);
    String fname = pattern_prefix + suf + file_ext;
    sset[i] = loadImage(fname);
    sset[i].loadPixels();
    println(fname + " loaded");
  }
}

void draw() {
  if (!started) {
    processImage();
    started = true;
  }
  // fill for iterative processing
}

void mouseClicked() {
  random_source = true;
  mode = random(1)<0.5?BLEND_COLOR:BLEND_VALUE;
  if(mode == BLEND_VALUE) VALUE_FOR_BLEND = (int)random(6);
  do_blend = random(1)<0.1;
  blend_mode = blends[(int)random(blends.length)];
  processImage();
}

PVector getVector(color c) {
  PVector v = new PVector();
  v.x = (c >> 16) &0xff;
  v.y = (c >> 8) &0xff;
  v.z = c &0xff;
  return v;
}

void processImage() {


  int[] idx = new int[pattern_length];
  for (int i=0; i<pattern_length; i++) idx[i] = i;
  int nidx = pattern_length;
  if (random_source) {
    nidx = (int)random(2, pattern_length+1);
    for (int i=0; i<pattern_length-1; i++) {
      int ri = (int)random(i+1, pattern_length);
      int tmp = idx[i];
      idx[i] = idx[ri];
      idx[ri] = tmp;
    }
  }
  println("Using " + nidx + " images.");

  for (int x=0; x<img.width; x++) {
    for (int y=0; y<img.height; y++) {
      int p = y*img.width+x;
      color c = img.pixels[p];
      PVector cv = getVector(c);
      float cval = getChannel(c,VALUE_FOR_BLEND);
      float currd = 1.0e10;
      color currc = c;
      for (int i=0; i<nidx; i++) {
        PImage _img = sset[idx[i]];
        int _x = (int)map(x, 0, img.width-1, 0, _img.width-1);
        int _y = (int)map(y, 0, img.height-1, 0, _img.height-1);
        int _p = _y * _img.width + _x;
        color _c = _img.pixels[_p];
        float d = currd;
        if (mode == BLEND_COLOR) {
          d = cv.dist(getVector(_c));
        } else {
          d = abs(cval - getChannel(_c,VALUE_FOR_BLEND));
        }
        if (d<currd) {
          currd = d;
          currc = _c;
        }
      }
      buffer.pixels[p] = currc;
    }
  }

  // END CODE HERE!
  buffer.updatePixels();

  if (do_blend)
    buffer.blend(img, 0, 0, img.width, img.height, 0, 0, buffer.width, buffer.height, blend_mode);

  image(buffer, 0, 0, width, height);
}

void keyPressed() {
  // SPACE to save
  if (keyCode == 32) {
    String fn = foldername + filename + "/res_" + sessionid + hex((int)random(0xffff), 4)+"_"+filename+fileext;
    buffer.save(fn);
    println("Image "+ fn + " saved");
  }
}

//

final static int[] blends = {
  ADD, SUBTRACT, DARKEST, LIGHTEST, DIFFERENCE, EXCLUSION, MULTIPLY, SCREEN, OVERLAY, HARD_LIGHT, SOFT_LIGHT, DODGE, BURN
};

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
  case RED: 
    cc = red(c); 
    break;
  case GREEN: 
    cc = green(c); 
    break;
  case BLUE: 
    cc = blue(c); 
    break;
  case HUE: 
    cc = hue(c); 
    break;
  case SATURATION: 
    cc = saturation(c); 
    break;
  default: 
    cc= brightness(c); 
    break;
  }

  return channel>5?255-cc:cc;
}

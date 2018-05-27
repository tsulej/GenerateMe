// Draw vertical threads on the image
// Tomasz Sulej, generateme.blog@gmail.com, http://generateme.tumblr.com
// Licence: http://unlicense.org/

// Usage:
//   * press SPACE to save
//   * click to change parameters

// set up filename
String filename = "test";
String fileext = ".jpg";
String foldername = "./";

boolean glow = false; // make image glow
int stepsize_init = 500; // maximum segment length
int stepsize_final = 20; // minimum segment length
float stepsize_ratio = 0.7; // segment length reduction ratio (0 - fast, 1-v. slow)

float stroke_size = 1.0; // width of the line
boolean make_dots = false; // make dots on line segments

// configuration of "curtain" style
float v_step_exp = 2.0; // exponent for vertical step 0.5-2.0
int v_step_channel = NBRIGHTNESS; // channel used for vertical step
float h_step_exp = 2.0; // 0.5-2.0
int h_step_channel = NBRIGHTNESS;
boolean h_step_sin = false; // linear (false) or sinusoidal (true)
float h_step_ratio = 5; // -6..-1 and 1..6

boolean ch_v_byte = false; // interpret channel value as byte

color bckg_color = color(0,0,0); // background color

int max_display_size = 800; // viewing window size (regardless image size)

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
  buffer.noFill();
  buffer.smooth(8);
  buffer.background(bckg_color);
  buffer.strokeWeight(stroke_size);
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

  surface.setSize(neww, newh);

  reinit();
}

void reinit() {
  ss_current = stepsize_init;
  ss_ratio = map(constrain(stepsize_ratio,0,1),0,1,0.9,0.99);
  dodot = make_dots ? 0 : -1;
}

void draw() {
  processImage();
}

int ss_current;
float ss_ratio;
int dodot;

final color WHITE = color(255,255,255);

PImage _img = null;

int getVStep(int x, int y, int size) {
  float b = getChannel(img.get(x, y),v_step_channel);
  if(ch_v_byte) b = 128+(int)((byte)(int(b)));
  float s = pow(map(b, 0, 255, 0, 1),v_step_exp);
  return 1+(int)(s*size);
}

int getHStep(int x, int y, int size) {
  float b = getChannel(img.get(x, y),h_step_channel);
  if(ch_v_byte) b = 128+(int)((byte)(int(b)));
  if(h_step_sin) {
    float s = sin(pow(map(b, 0, 255, 0, 1),h_step_exp)*TWO_PI-PI);
    return (int)(s*size);
  } else {
    float s = pow(map(b, 0, 255, 0, 1),h_step_exp);
    return (int)(s*size-size/2);
  }
}

void processImage() {
  println("Segment size=" + ss_current);

  if(glow) {
    _img = buffer.get();
    _img.filter(BLUR,1);
  }

  buffer.beginDraw();

  // START CODE HERE! use buffer to draw/manipulate

  for(int i=0;i<50;i++) {
    int py = 0;
    int x = (int)random(buffer.width);
    int px = x;
    int y = 0;

     while (y<img.height) {
      y += getVStep(x, y, ss_current);
      x += getHStep(x, y, (int)(ss_current/h_step_ratio));
      buffer.stroke(lerpColor(img.get(x,y),WHITE,0.2), 20);
      buffer.line(px, py, x, y+dodot);
      px = x;
      py = y;
    }
  }


  // END CODE HERE!

  if(glow) {
    buffer.blend(_img, 0, 0, buffer.width, buffer.height, 0, 0, buffer.width, buffer.height, LIGHTEST);
  }

  buffer.endDraw();
  image(buffer,0,0,width,height);

  // change stepsize
  ss_current = max(stepsize_final,(int)(ss_current * ss_ratio));
}

void randomizer() {
  glow = random(1)<0.5;
  stepsize_init = (int)random(img.width/4,img.width/2);
  stepsize_final = (int)random(15,30);
  stepsize_ratio = random(1);
  stroke_size = random(0.8,3);
  make_dots = random(1)<0.5;
  v_step_exp = random(0.4,2.2);
  h_step_exp = random(0.4,2.2);
  h_step_sin = random(1)<0.5;
  h_step_ratio = (random(1)<0.5?1:-1) * random(1,6);
  v_step_channel = (int)random(12);
  h_step_channel = (int)random(12);
  ch_v_byte = random(1)<0.5;
}

void mousePressed() {
  buffer.beginDraw();
  buffer.background(bckg_color);
  buffer.endDraw();
  randomizer();
  reinit();
}

void keyPressed() {
  // SPACE to save
  if(keyCode == 32) {
    String fn = foldername + filename + "/res_" + sessionid + hex((int)random(0xffff),4)+"_"+filename+fileext;
    buffer.save(fn);
    println("Image "+ fn + " saved");
  }
}

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

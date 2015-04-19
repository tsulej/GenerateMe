// Image Lens. Treat image as a lens using channel value as curvature.
// Tomasz Sulej, generateme.blog@gmail.com, 2015, CC-BY-SA 3.0

// Configuration:
// * set filename of your image (filename variable)
// * if you want use different image as as lens, set its filename to lensfilename variable
//   or null if image to process and lens shoud be the same
// * other variables:
//    - bendx, bendy: curvature factor for x and y
//    - types: lens types (experiment, just few different algorithms, list below)
//    - channels: RGB, HSB + negatives - what channels use as a lens curvature, list below
// Always put 2 values (one for x and one for y)

// Usage:
//   SPACE - to save
//   ENTER - go into interactive mode, move mouse to change bendx, bendy
//   Click - to make random change
//   c - to change colourlovers pattern (if enabled)

// hint: if you work on some channel only (leaving rest untouched)
//       find line with fill(n) - there are hidden other options as a comments

// filename
String filename = "test"; // image to process
String fileext = ".jpg";
String foldername = "./";

String lensfilename = null; // use different image to use as lens (null = use same as image to process), full path please!
//String lensfilename = "./lens1.jpg"; 

int max_display_size = 800; // viewing window size (regardless image size)

// set to true to use colour lovers random pattern
// http://www.colourlovers.com/patterns
boolean use_clpattern = false;
// <1.0 bigger pattern, >1.0 smaller pattern
float pattern_factor = 4.1;

// parameters
float bendx = 0.1; // from 0 to 1
float bendy = 0.1; // from 0 to 1
float[] power_vals = { 2, 0.5 }; // two values of power from 0.1 to 10, one for x and second for y
int[] types = { LINEAR, POWER }; // always to types one for x second for y
int[] channels = { BRIGHTNESS, SATURATION }; // as above

// config ends

// lens type
final static int LINEAR = 0;
final static int POWER = 1;
final static int POLAR = 2;
final static int SINUSOIDAL = 3;

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

//////////////

PImage img;
PImage limg;

boolean interactive = false; // move mouse to set bend when active, ENTER to activate

float[] facts = new float[2];

// working buffer
PGraphics buffer;

String sessionid;

void setup() {
  sessionid = hex((int)random(0xffff),4);
  img = loadImage(foldername+filename+fileext);
  img.loadPixels();
  
  if(lensfilename != null) {
    limg = loadImage(lensfilename);
    limg.loadPixels();
  } else 
    limg=img;
  
  buffer = createGraphics(img.width, img.height);
  buffer.beginDraw();
  buffer.noStroke();
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

  if(use_clpattern) getCLPattern();

  facts[0] = bendx * img.width;
  facts[1] = bendy * img.height;

  drawMe();
}

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

int getShift(color c, int idx) {
  float cc = getChannel(c,channels[idx]);
 
  switch(types[idx]) {
    case LINEAR:
      return (int)(facts[idx] * cc/255.0);
    case POWER:
      return (int)(facts[idx]*map(pow(cc/255.0,power_vals[idx]),0,1,-1,1));
    case SINUSOIDAL:
      return (int)(facts[idx]*sin(map(cc,0,255,-PI,PI)));
    default: { // POLAR
      float c1 = idx==0?cc:getChannel(c,channels[1]);
      float c2 = idx==1?cc:getChannel(c,channels[0]);
      float ang = map(c1,0,255,0,TWO_PI);
      float r = map(c2,0,255,0,facts[0]);
      return (int)(idx==0?r*cos(ang):r*sin(ang));
    }   
  }
}

void drawMe() {
    buffer.beginDraw();
    buffer.background(0);

    for(int x=0;x<img.width;x++) {
      
      int lx;
      if(use_clpattern) lx = ((int)(x*pattern_factor))%limg.width;
      else              lx = (int)map(x,0,img.width-1,0,limg.width-1);
      
      for(int y=0;y<img.height;y++) {
        
        int ly;
        if(use_clpattern) ly = ((int)(y*pattern_factor))%limg.height;
        else              ly = (int)map(y,0,img.height-1,0,limg.height-1);
        
        color c = limg.pixels[lx+ly*limg.width];
        
        int posx = (x+getShift(c, 0)+2*img.width)%img.width;
        int posy = (y+getShift(c, 1)+2*img.height)%img.height;
        
        color n = img.pixels[posx+posy*img.width];
        
        buffer.fill(n);
       //  fill(red(c),green(c),blue(n)); // work only on blue channel
       //  fill(red(n), abs(green(c)-green(n)), blue(n)); // green channel is blended using difference method  
        buffer.rect(x,y,1,1);
      }
    }
    
   buffer.endDraw(); 
   image(buffer,0,0,width,height);
}

void draw() {
  if(interactive) {
    facts[0] = (int)map(mouseX,0,width,0,img.width);
    facts[1] = (int)map(mouseY,0,height,0,img.height);
    
    drawMe();
  }
}

void mouseClicked() {
  power_vals[0] = random(8);
  power_vals[1] = random(8);
  channels[0] = (int)random(12);
  channels[1] = (int)random(12);
  types[0] = (int)random(4);
  types[1] = (int)random(4);
  facts[0] = (int)map(mouseX,0,width,0,img.width);
  facts[1] = (int)map(mouseY,0,height,0,img.height);
  
  drawMe();
}

void keyPressed() {
  if(keyCode == ENTER || keyCode == RETURN) {
    interactive = !interactive;
    println("interactive mode: " + (interactive?"on":"off"));
  }
  
  if(keyCode == 32) {
    buffer.save(foldername + filename + "/res_" + sessionid + hex((int)random(0xffff),4)+"_"+filename+fileext);
    println("image saved");
  }
  
  if(key == 'c' && use_clpattern) {
    getCLPattern();
    println("pattern changed");
    drawMe();
  }
}

void getCLPattern() {
  int n = (int)random(1,4719052);
  print("Loading pattern from ColourLovers number: "+n+"...");
  
  String pad="";
  if(n<1000) pad = "0";
  else {
    String nn = ""+n;
    pad = nn.substring(0,nn.length()-3);
  }
  
  String clname = "http://colourlovers.com.s3.amazonaws.com/images/patterns/"+pad+"/"+n+".png";
  try {
    limg = loadImage(clname, "png");
  } catch(Exception e) {
    getCLPattern();
  }

  if(limg.width <=0) getCLPattern();
  
  println(" done");
}

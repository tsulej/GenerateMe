// Original: http://www.openprocessing.org/sketch/145401
// adaptation to images, Tomasz Sulej, generateme.blog@gmail.com
// Licence CC-BY-SA 3.0
 
// put image filename here:
String imagefilename = "test.jpg";
 
// choose channel  
int channel = HUE; 
 
// run, after 30 iterations result will be saved automatically
// or click mouse when ready
 
/////////////////////////////////////

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

int n=2000;
float [] cx=new float[n];
float [] cy=new float[n];
 
PImage img;
int len;
 
void setup() {
  img = loadImage(imagefilename);
  
  size(img.width,img.height);
  len = (width<height?width:height)/6;
  
  background(0);
  for (int i=0;i<n;i++) {
    cx[i]=random(width);
    cy[i]=random(height);
  }
  
  smooth(8);
  strokeWeight(0.3);
}
 
int tick = 0;
 
void draw() {  
  for (int i=1;i<n;i++) {
    color c = img.get((int)cx[i], (int)cy[i]);
    stroke(c);
    point(cx[i], cy[i]);
    // you can choose channels: red(c), blue(c), green(c), hue(c), saturation(c) or brightness(c)
    cy[i]+=sin(map(getChannel(c),0,255,0,TWO_PI));
    cx[i]+=cos(map(getChannel(c),0,255,0,TWO_PI));
  }
 
  if (frameCount>len) {
    frameCount=0;
    println("iteration: " + tick++);
    for (int i=0;i<n;i++) {
      cx[i]=random(width);
      cy[i]=random(height);
    }
    
    if(tick == 30) saveFrame("res_"+(int)random(10000,99999)+"_"+imagefilename);
  }
}
 
float getChannel(color c) {
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
  
void mouseClicked() {
  saveFrame("res_"+(int)random(10000,99999)+"_"+imagefilename);
}

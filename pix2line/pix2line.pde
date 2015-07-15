// Pixels to lines, snapped to noise grid //<>//
// Tomasz Sulej, generateme.blog@gmail.com, http://generateme.tumblr.com
// Licence: http://unlicense.org/

// This sketch traverses line by line and draws a vline when choosen channel changes value beyond set tolerance
// First point in line selects line color. Lines are snapped left into the random grid made from noise function

// Usage:
//   * press SPACE to save
//   * click for random change
//   * press 'g' to toggle grid size change during randomization

// set up filename
String filename = "test";
String fileext = ".jpg";
String foldername = "./";

int max_display_size = 800; // viewing window size (regardless image size)

// configuration
// average noise grid size, examples of generated grids are in grid_examples folder
int nx = 30; // 1 - width
int ny = 20; // 1 - height

// tolerance of channel value change, this is kind of edge detection sensivity
int tolerance = 50; // 1 (every channel value change starts new line) - 255 (one color line)
// channel to test
int channel = BRIGHTNESS;

// fill the gaps between grids, if false fill them with background_color
boolean whole = true; // true or false
// color to fill grid gaps
color background_color = color(188, 188, 188);

// skip grid size change during random, press G to change it
boolean skip_grid = true;

boolean do_blend = false; // blend image after process
int blend_mode = OVERLAY; // blend type

// working buffer
PGraphics buffer;

// image
PImage img;

String sessionid;

void setup() {
  sessionid = hex((int)random(0xffff), 4);
  img = loadImage(foldername+filename+fileext);

  buffer = createGraphics(img.width, img.height);
  buffer.beginDraw();
  buffer.noStroke();
  buffer.noFill();
  buffer.background(0);
  buffer.endDraw();

  // calculate window size
  float ratio = (float)img.width/(float)img.height;
  int neww, newh;
  if (ratio < 1.0) {
    neww = (int)(max_display_size * ratio);
    newh = max_display_size;
  } 
  else {
    neww = max_display_size;
    newh = (int)(max_display_size / ratio);
  }

  size(neww, newh);
  grid = new int[img.width][img.height];

  processImage();
}

void mouseClicked() {
  // randomize
  if(!skip_grid) {
    nx = (int)random(1,img.width/5);
    ny = (int)random(1,img.height/5);
  }
  tolerance = random(1)<0.8 ? (int)random(5,80) : (int)random(5,250);
  whole = random(1)<0.5;
  channel = (int)random(6);
  
  do_blend = random(1)<0.1;
  blend_mode = blends[ (int)random(blends.length) ];
  
  background_color = img.get( (int)map(mouseX,0,width-1,0,img.width-1), (int)map(mouseY,0,height-1,0,img.height-1) );
  
  println("");
  println("nx="+nx);
  println("ny="+ny);
  println("tolerance="+tolerance);
  println("whole="+whole);
  println("channel="+channel);
  println("do_blend="+do_blend);
  println("blend_mode="+blend_mode);
  println("background_color=#" + hex(0xffffff & background_color,6));
  
  processImage();
}

void draw() {
  // fill for iterative processing
}

int[][] grid;

void processImage() {
  print("Processing...");
  buffer.beginDraw();
  buffer.background(background_color);
  // START CODE HERE! use buffer to draw/manipulate

  noiseSeed( (long)random(MAX_INT) );

  float scale = random(2);
  int nnx = int(scale*nx)+1;
  int nny = int(scale*ny)+1;

  for (int y=0; y<buffer.height; y++) {
    grid[0][y] = 0;
    boolean current = noise(0, y/ny) < 0.5 ? true : false;
    int currx = 0; 
    for (int x=1; x<buffer.width; x++) {
      int yy = (int(nnx*(1.0+noise(x/nnx)))*(x/nnx));
      int xx = (int(nny*(1.0+noise(y/nny)))*(y/nny));

      boolean here = noise( (x+xx)/nx, (y+yy)/ny ) < 0.5 ? true : false;

      if (current != here) {
        currx = x;
        current = here;
      }
      grid[x][y] = currx;
    }
  }

  processLines();

  // END CODE HERE!

  if (do_blend)
    buffer.blend(img, 0, 0, img.width, img.height, 0, 0, buffer.width, buffer.height, blend_mode);

  buffer.endDraw();
  image(buffer, 0, 0, width, height);
  println("done.");
}

void processLines() {
  for (int y=0; y<buffer.height; y++) {
    color currentc = img.get(0, y);
    float currentb = getChannel(currentc, channel);
    int lastx = 0;
    int x=1;
    for (; x<buffer.width; x++) {
      color c = img.get(x, y);
      float b = getChannel(c, channel);

      if ( abs(currentb - b) >= tolerance) {
        buffer.stroke( currentc );
        int myx = (whole && lastx < grid[x][y]) ? lastx : grid[x][y];
        buffer.line( myx, y, x, y );
        currentc = c;
        currentb = b;
        lastx = x;
      }
    }
    x--;
    buffer.stroke( currentc );
    int myx = lastx < grid[x][y] ? lastx : grid[x][y];
    buffer.line( myx, y, x, y );
  }
}

void keyPressed() {
  // SPACE to save
  if (keyCode == 32) {
    String fn = foldername + filename + "/res_" + sessionid + hex((int)random(0xffff), 4)+"_"+filename+fileext;
    buffer.save(fn);
    println("Image "+ fn + " saved");
  } else if(key == 'g') {
    skip_grid = !skip_grid;
    println("skip grid size change = " + (skip_grid ? "true" : "false") );
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

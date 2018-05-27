// Wrong QuickSort algorithm
// Based on following code by Mick Kellogg, http://www.openprocessing.org/sketch/53609
// Tomasz Sulej, generateme.blog@gmail.com, http://generateme.tumblr.com
// Licence: CC-BY-SA

// Usage:
//   * press SPACE to save
//   * click to change mode
//   * move mouse to choose line size to sort (length equals x*y)
//       - top-left region - short lines
//       - middle - long, bigger parts of image

// set up filename
String filename = "test";
String fileext = ".jpg";
String foldername = "./";

int max_display_size = 800; // viewing window size (regardless image size)

boolean mode = L; // L or R, which sort part is broken

boolean do_blend = false; // blend image after process
int blend_mode = OVERLAY; // blend type

static final boolean L = true;
static final boolean R = false;

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

  surface.setSize(neww, newh);
  
  len = img.width * img.height;
  processImage((int)random(len-1)+1);
}

int len;

void draw() {
  float x = map(mouseX, 0, width-1,0,1);
  float y = map(mouseY, 0, height-1,0,1);
  int vall = (int)map(x*y,0,1,1,len-1);
  processImage(vall);
}

float random_point = 0.5;
void mouseMoved() {
  random_point = random(0.1,0.9);
}

void processImage(int v) {
  buffer.beginDraw();
  buffer.image(img,0,0);
  buffer.endDraw();

  buffer.loadPixels();

  int x = 0;
  while(x<len) {
    if(x+v<len) quicksort(buffer.pixels, x, x+v);
    else quicksort(buffer.pixels, x, len-1);
    x+=v;
  }

  buffer.updatePixels();

  if(do_blend) {
    buffer.beginDraw();
    buffer.blend(img,0,0,img.width,img.height,0,0,buffer.width,buffer.height,blend_mode);
    buffer.endDraw();
  }

  image(buffer,0,0,width,height);
}

void mouseClicked() {
  mode = !mode;
  if(mode) println("Sort mode: L"); else println("Sort mode: R");
  mouseMoved();
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
int partition(int x[], int left, int right) {
  int i = left;
  int j = right;
  int temp;
  int pivot = x [(int)map(random_point,0,1,left,right)];
  while (i<= j) {
    while(x[i] < pivot) {
      i++;
    }
    while (x[j] > pivot) {
      j--;
    }
    if (i <= j) {
      temp = x[i];
      x[i] = x [j];
      x[j] = temp;
      i++;
      j--;
    }
  }
  return i;
}

void quicksort(int x[], int left, int right) {
  if(left<right) {
    int index = partition(x, left, right);
    if(mode) {
      if(left < index-1) quicksort(x, left, index-1);
      if(right < index) quicksort(x, index, right);
    } else {
      if(left > index-1) quicksort(x, left, index-1);
      if(right > index) quicksort(x, index, right);
    }
  }
}

final static int[] blends = {ADD, SUBTRACT, DARKEST, LIGHTEST, DIFFERENCE, EXCLUSION, MULTIPLY, SCREEN, OVERLAY, HARD_LIGHT, SOFT_LIGHT, DODGE, BURN};

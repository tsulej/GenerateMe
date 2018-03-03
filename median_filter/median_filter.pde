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
int channel = HUE;
int iters = 2 ; // number of iterations on image before refreshing view
int batch_iters = 100; // number of iterations per frame in batch processing

// working buffer
PGraphics buffer;

// image
PImage img;

String sessionid;

void setup() {
  sessionid = hex((int)random(0xffff), 4);
  img = loadImage(foldername+filename+fileext);

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

  size(neww, newh);
  reinit();
}

void reinit() {
  chan_data = new int[img.width][img.height];
  target = new int[img.width][img.height];
  buffer = createGraphics(img.width, img.height);
  buffer.beginDraw();
  buffer.noStroke();
  buffer.smooth(8);
  buffer.background(0);
  buffer.image(img, 0, 0);
  buffer.endDraw();
  buffer.loadPixels();

  for (int y=0; y<img.height; y++) {
    int off = y*img.width;
    for (int x=0; x<img.width; x++) {
      color c = buffer.pixels[x+off] & 0x00ffffff;
      chan_data[x][y] = (((getChannel(c, channel)) & 0xff) << 24) | c;
      target[x][y] = chan_data[x][y];
    }
  }
}

void draw() {
  try {
    if (doBatch) { 
      batchStep();
    } else { 
      processImage(iters);
    }
  } 
  catch (Exception e) {
    e.printStackTrace();
    noLoop();
  }
}

void batchCallback(float time) {
  /// every image this functions is called
  /// time ranges from 0 (first image) to 1 (last image)
  /// set global variables or whatever you want
}

int[][] chan_data, target;
int[] tmp = new int[9];

int time = 0;
void processImage(int iters) throws Exception {
  //  int currtime = millis();

  for (int i=0; i<iters; i++) {
    run_and_wait(chan_data, target, position);
    int[][] tmp = target;
    target = chan_data;
    chan_data = tmp;
  }

  for (int y=0; y<img.height; y++) {
    int off = y*img.width;
    for (int x=0; x<img.width; x++) {
      buffer.pixels[x+off] = chan_data[x][y] | 0xff000000;
    }
  }

  buffer.updatePixels();

  if (do_blend) {
    buffer.beginDraw();
    buffer.blend(img, 0, 0, img.width, img.height, 0, 0, buffer.width, buffer.height, blend_mode);
    buffer.endDraw();
  }

  image(buffer, 0, 0, width, height);

  //buffer.save("../TTT/fra/"+nf(time,6)+".jpg");
  time++;

  //  println(millis()-currtime);
}

void keyPressed() {
  if (key == 'b' && !doBatch) {
    batchProcess();
  }
  // SPACE to save
  if (keyCode == 32) {
    String fn = foldername + filename + "/res_" + sessionid + hex((int)random(0xffff), 4)+"_"+filename+fileext;
    buffer.save(fn);
    println("Image "+ fn + " saved");
  }
  if (keyCode >= 48 && keyCode <= 56) {
    position = keyCode - 48;
    println("Position = " + position);
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

int getChannel(color c, int channel) {
  int ch = channel>5?channel-6:channel;
  int cc;

  switch(ch) {
  case RED: 
    cc = ((c>>16) & 0xff); 
    break;
  case GREEN: 
    cc = ((c>>8) & 0xff); 
    break;
  case BLUE: 
    cc = (c &0xff); 
    break;
  case HUE: 
    cc = (int)hue(c); 
    break;
  case SATURATION: 
    cc = (int)saturation(c); 
    break;
  default: 
    cc= (int)brightness(c); 
    break;
  }

  return channel>5?255-cc:cc;
}

void batchStep() throws Exception {
  File n = batchList[batchIdx];
  String name = n.getAbsolutePath(); 
  if (name.endsWith(fileext)) {
    print(n.getName()+"... ");
    img = loadImage(name);
    img.loadPixels();
    reinit();
    batchCallback((float)batchIdx / batchFiles);
    processImage(batch_iters);
    buffer.save(foldername+batchUID+"/"+n.getName());
    println("saved");
  }
  batchIdx++;
  if (batchIdx >= batchList.length) {
    doBatch = false;
    println("results saved in "+ foldername+batchUID + " folder");
  }
}

File[] batchList;
int batchIdx = 0;
String batchUID;
boolean doBatch = false;
float batchFiles = 0;
void batchProcess() {
  batchUID = sessionid + hex((int)random(0xffff), 4);
  File dir = new File(sketchPath+'/'+foldername);
  batchList = dir.listFiles();
  batchIdx = 0;
  batchFiles = 0;
  for (File n : batchList) {
    if (n.getName().endsWith(fileext)) batchFiles=batchFiles+1.0;
  }
  println("Processing "+int(batchFiles)+" images from folder: " + foldername);
  doBatch = true;
}


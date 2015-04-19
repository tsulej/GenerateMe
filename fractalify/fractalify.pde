/* Make fractal from your image
 * Sketch draws mandelbrot/julia fractal using channel data to initalize/modify 'z' and 'c' variables.
 * a lot of randomness here: channel selection (RGBHSB), colouring, blending, posterizing, fract type (mandel/julia), some factors
 */

// Author, Tomasz Sulej, generateme.tumblr.com
// email: generateme.blog@gmail.com
// licence: <http://unlicense.org>

/* set image name below 
 * click mouse button to random change
 * press SPACE to save image
 */
 
// yes, it's rather slow 

String filename = "test";
String fileext = ".jpg";
String foldername = "./";

int max_display_size = 800; // viewing window size (regardless image size)

////////////////////////////////////////
int type;
int variant;
float fact1;
float fact2;
int chan1,chan2,chan3,chan4,chan5;
int[] order = {0,1,2};
int[] blendmethods = {ADD, SUBTRACT, DARKEST, LIGHTEST, DIFFERENCE, EXCLUSION, MULTIPLY, SCREEN, OVERLAY, HARD_LIGHT, SOFT_LIGHT, DODGE, BURN};
boolean doblend, doposterize;
PImage img;
boolean negative;

// working buffer
PGraphics buffer;

String sessionid;

void setup() {
  sessionid = hex((int)random(0xffff),4);
  img = loadImage(foldername+filename+fileext);
  
  buffer = createGraphics(img.width, img.height);
  buffer.beginDraw();
  buffer.noStroke();
  buffer.smooth(8);
  buffer.background(0);
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
  
  mouseClicked();        
}

void draw() {}

void keyPressed() {
  buffer.save(foldername + filename + "/res_" + sessionid + hex((int)random(0xffff),4)+"_"+filename+fileext);
  println("image saved");
}

void mouseClicked() {
  buffer.beginDraw();
  print("drawing... ");
  
  type=random(1)<0.5?0:1;
  variant=random(1)<0.5?0:1;
  fact1 = random(0.8,1.3);
  fact2 = random(0.8,1.3);
  chan1 = (int)random(6);
  chan2 = (int)random(6);
  chan3 = (int)random(6);
  chan4 = (int)random(6);
  chan5 = (int)random(6);
  doblend = random(1)<0.5;
  doposterize = random(1)<0.2;
  negative = random(1)<0.5;
  randomOrder();

  float zx,zy,cx,cy;
  
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c = img.get(x,y);
      
      if(type == 0) {
        zx = fact1*map(sqrt(getChan(chan1,c)*getChan(chan2,c)),0,1,-1,1);
        zy = fact1*map(sqrt(getChan(chan3,c)*getChan(chan4,c)),0,1,-1,1);
        cx = map(x,0,img.width,-1.4,1.4);
        cy = map(y,0,img.height,1.4,1.4);
      } else {
        cx = fact1*map(sqrt(getChan(chan1,c)*getChan(chan2,c)),0,1,-1,1);
        cy = fact1*map(sqrt(getChan(chan3,c)*getChan(chan4,c)),0,1,-1,1);
        zx = map(x,0,img.width,-1.4,1.4);
        zy = map(y,0,img.height,-1.4,1.4);
      }
      
      if(variant == 0) {
        cx *= fact2*sin(getChan(chan5,c)*2*TWO_PI);
        cy *= fact2*cos(getChan(chan5,c)*2*TWO_PI);
      } else {
        zx *= sin(getChan(chan5,c)*2*TWO_PI);
        zy *= cos(getChan(chan5,c)*2*TWO_PI);
      }
      
      int iter = 500;
      while((sq(zx)+sq(zy))<4.0 && iter-->0) {
        float tmp = sq(zx)-sq(zy)+cx;
        zy = 2.0 * zx * zy + cy;
        zx = tmp;
      }
      zx = map(zx,0,1.4,0,255);
      zy = map(zy,0,1.4,0,255);
      
      float c1 = order[0]==0?zx%255:order[0]==1?zy%255:51*(iter%6);
      float c2 = order[1]==0?zx%255:order[1]==1?zy%255:51*(iter%6);
      float c3 = order[2]==0?zx%255:order[2]==1?zy%255:51*(iter%6);
      
      buffer.fill(c1,c2,c3);
      buffer.rect(x,y,1,1);
    }
  }
     
 if(doblend) buffer.blend(img, 0,0,img.width,img.height,0,0,img.width,img.height,blendmethods[(int)random(blendmethods.length)]);   
 if(doposterize) buffer.filter(POSTERIZE,(int)random(3,13));   
 
 buffer.endDraw();
 image(buffer,0,0,width,height);
 
 println("done");   
}

void randomOrder() {
  order[0] = (int)random(3);
  order[1] = (int)random(3);
  order[2] = (int)random(3);
}

float getChan(int no, color c) {
  float t;
  switch(no) {
    case 0: t = red(c); break;
    case 1: t = green(c); break;
    case 2: t = blue(c); break;
    case 3: t = hue(c); break;
    case 4: t = saturation(c); break;
    default: t = brightness(c); break; 
  }
  return negative?map(t,0,255,1,0):map(t,0,255,0,1);
}

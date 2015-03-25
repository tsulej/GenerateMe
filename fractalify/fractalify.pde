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

String imagename = "test.jpg";

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

void setup() {
  img = loadImage(imagename);
  size(img.width,img.height);
  background(0);
  noStroke();
  smooth(8);
  
  mouseClicked();        
}

void draw() {}

void keyPressed() {
  int r = (int)random(1000,9999);
  save("res_"+r+"_"+imagename);
}

void mouseClicked() {
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
  
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      color c = img.get(x,y);
      
      if(type == 0) {
        zx = fact1*map(sqrt(getChan(chan1,c)*getChan(chan2,c)),0,1,-1,1);
        zy = fact1*map(sqrt(getChan(chan3,c)*getChan(chan4,c)),0,1,-1,1);
        cx = map(x,0,width,-1.4,1.4);
        cy = map(y,0,height,1.4,1.4);
      } else {
        cx = fact1*map(sqrt(getChan(chan1,c)*getChan(chan2,c)),0,1,-1,1);
        cy = fact1*map(sqrt(getChan(chan3,c)*getChan(chan4,c)),0,1,-1,1);
        zx = map(x,0,width,-1.4,1.4);
        zy = map(y,0,height,-1.4,1.4);
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
      
      fill(c1,c2,c3);
      rect(x,y,1,1);
    }
  }
     
 if(doblend) blend(img, 0,0,width,height,0,0,width,height,blendmethods[(int)random(blendmethods.length)]);   
 if(doposterize) filter(POSTERIZE,(int)random(3,13));   
 
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

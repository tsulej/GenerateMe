// Decay image
// Original source: xscreensaver 5.32, authors: David Wald (1988), Vivek Khera (1993), JWZ (1997), R. Schultz (1999)
// Not exact port to Processing, Tomasz Sulej, generateme.blog@gmail.com, 2015
// Licence at the end of file

// Set file name
// press: i - to change drag method between in/out
//        SPACE - to save
//        ENTER - to decay automaticly
// drag clicked mouse to decay in or out

String filename = "test";
String fileext = ".jpg";
String foldername = "./";

int max_display_size = 800; // viewing window size (regardless image size)

//

PImage img;

// working buffer
PGraphics buffer;

String sessionid;

void setup() {
  sessionid = hex((int)random(0xffff),4);
  img = loadImage(foldername+filename+fileext);
  
  buffer = createGraphics(img.width, img.height);
  buffer.beginDraw();
  buffer.image(img,0,0); 
  
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

  surface.setSize(neww,newh);
  surface.setResizable(true);
  
  frameRate(100); 
  
  printStats();
}

boolean auto = true;

void draw() {
  buffer.beginDraw();
  if(auto) doDecay();
  buffer.endDraw();
  image(buffer,0,0,width,height);
}

boolean in = true;

void mouseDragged() {
  noLoop();
  buffer.beginDraw();
  doBias(in,(int)map(mouseX,0,width,0,img.width),(int)map(mouseY,0,height,0,img.height));
  buffer.endDraw();
  image(buffer,0,0,width,height);
  loop();
}

void keyPressed() {
  if(key == 'i') in = !in;
  if(keyCode == RETURN || keyCode == ENTER) auto = !auto;
  if(keyCode == 32) { buffer.save(foldername + filename + "/res_" + sessionid + hex((int)random(0xffff),4)+"_"+filename+fileext); print("saved... "); };
  printStats();
}

void printStats() {
  println("method: " + (in?"in":"out") + "; "+(auto?"auto":""));
}

void doDecay() {
  int a = (random(1)<0.05)?(int)random(6):(int)random(2);
  switch(a) {
    case 0: doBias(); break;
    case 1: doFuzz(); break;
    case 2: doStretchV(); break;
    case 3: doSqueezeV(); break;
    case 4: doStretchH(); break;
    case 5: doSqueezeV(); break;
    default: doBias();
  }
}

static final int L = 0;
static final int R = 1;
static final int U = 2;
static final int D = 3;

static final int[][] bias = {
    { L,L,L,L, R,R,R,R, U,U,U,U, D,D,D,D },
    { L,L,L,L, R,R,R,R, U,U,U,U, U,U,D,D },
    { L,L,L,L, R,R,R,R, U,U,D,D, D,D,D,D },
    { L,L,L,L, L,L,R,R, U,U,U,U, D,D,D,D },
    { L,L,R,R, R,R,R,R, U,U,U,U, D,D,D,D },
    
    { L,L,L,L, L,L,L,R, U,U,U,U, U,U,U,D },
    { L,L,L,L, L,L,L,R, U,D,D,D, D,D,D,D },
    { L,R,R,R, R,R,R,R, U,U,U,U, U,U,U,D },
    { L,R,R,R, R,R,R,R, U,D,D,D, D,D,D,D }
};

void doBias(boolean in, int mx, int my) {
  int left = (int)random(img.width-1);
  int top = (int)random(img.height);
  int w = (int)random(img.width-left);
  int h = (int)random(img.height-top);
  int toleft = left;
  int totop = top;
  
  int biasno = 0;
  
  if(in) {
    if      (top>my && left>mx) biasno = 5;
    else if (top>my && left<mx) biasno = 7;
    else if (top<my && left>mx) biasno = 6;
    else                        biasno = 8;
  } else {
    if      (top>my && left>mx) biasno = 8;
    else if (top>my && left<mx) biasno = 6;
    else if (top<my && left>mx) biasno = 7;
    else                        biasno = 5;
  }
  
  switch( bias[biasno][(int)random(16)] ) {
    case L: {toleft = left-2;break;}
    case R: {toleft = left+2;break;}
    case U: {totop = top-2;break;}
    case D: {totop = top+2; break;}
    default: {toleft = left-1; totop=top+1;}break;
  }
  
  PImage timg = buffer.get(left,top,w,h);
  buffer.image(timg,toleft,totop);
}

void doBias() {
  int left = (int)random(img.width-1);
  int top = (int)random(img.height);
  int w = (int)random(img.width-left);
  int h = (int)random(img.height-top);
  int toleft = left;
  int totop = top;
  
  switch( bias[(int)random(9)][(int)random(16)] ) {
    case L: {toleft = left-1;break;}
    case R: {toleft = left+1;break;}
    case U: {totop = top-1;break;}
    case D: {totop = top+1; break;}
    default: {toleft = left-1; totop=top+1;}break;
  }
  
  PImage timg = buffer.get(left,top,w,h);
  buffer.image(timg,toleft,totop); 
}

boolean fuzz_toggle = true;
void doFuzz() {
  int left = (int)random(img.width-1);
  int top = (int)random(img.height-1);
  int h,w,totop,toleft;
  
  // bad code, bad... 
  if(fuzz_toggle) {
    totop = top;
    h = 1;
    toleft = (int)random(img.width-1);
    if(toleft>left) {
      w = toleft-left;
      toleft = left;
      left++;
    } else {
      w = left-toleft;
      left = toleft;
      toleft++;
    }
  } else {
    toleft = left;
    w = 1;
    totop = (int)random(img.height-1);
    if(totop>top) {
      h = totop-top;
      totop = top;
      top++;
    } else {
      h = top-totop;
      top = totop;
      totop++;
    }
  }
  fuzz_toggle = !fuzz_toggle;
  
  PImage timg = buffer.get(left,top,w,h);
  buffer.image(timg,toleft,totop);  
}

void doStretchV() {
  int top = (int)random(img.height);

  PImage timg = buffer.get(0,img.height-top-2,img.width,top+1);
  buffer.image(timg,0,img.height-top-1);
}

void doSqueezeV() {
  int top = (int)random(img.height);

  PImage timg = buffer.get(0,img.height-top-1,img.width,top+1);
  buffer.image(timg,0,img.height-top-2);
}

void doStretchH() {
  int left = (int)random(img.width);

  PImage timg = buffer.get(img.width-left-2,0,left+1,img.height);
  buffer.image(timg,img.width-left-1,0);
}

void doSqueezeH() {
  int left = (int)random(img.width);

  PImage timg = buffer.get(img.width-left-1,0,left+1,img.height);
  buffer.image(timg,img.width-left-2,0);
}

/*
 * Permission to use, copy, modify, distribute, and sell this software and its
 * documentation for any purpose is hereby granted without fee, provided that
 * the above copyright notice appear in all copies and that both that
 * copyright notice and this permission notice appear in supporting
 * documentation.  No representations are made about the suitability of this
 * software for any purpose.  It is provided "as is" without express or
 * implied warranty.
*/

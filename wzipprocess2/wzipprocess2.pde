// wzip - a preprocessor for lossy data compression, originally: Copyright (C) 1997 Andreas Franzen
// Processing port, Tomasz Sulej, generateme.blog@gmail.com
// Haar wavelet transformation to glitch your raw images, operates on bytes, use different scaling factors (see below)

// Licence GNU GPL 2.0

// move mouse around the image
// * press ENTER/RETURN to change scale for scaling factors
// * press SPACE to toggle between RGBRGB... (HSBHSB...) or RRR...GGG...BBB... (HHH...SSS...BBB...) raws
// * click to save

String filename = "test.jpg"; // file name of your raw
boolean do_hsb = true; // do operate on HSB channels

// logic below

float scalingfactorin;
float scalingfactorout;

final static float sqrt05 = sqrt(0.5);

float[] raw, raw1,raw2,raw3;
float[] in, w, out;
float[] in1,in2,in3,out1,out2,out3;
int n,n2,s;

boolean option1 = true;
float sc = 160;

void setup() {
  PImage img = loadImage(filename);
  size(img.width, img.height);
  noStroke();
  background(0);
  
  s = img.width*img.height;
  raw = new float[s*3];
  raw1 = new float[s];
  raw2 = new float[s];
  raw3 = new float[s];
  
  if(do_hsb) colorMode(HSB,255); else colorMode(RGB,255);
  
  int iter=0;
  int iter2 = 0;
  for(int y=0;y<height;y++) {
    for(int x=0;x<width;x++) {
      color c = img.get(x,y);
      float r,g,b;
      if(do_hsb) {
        r = hue(c)>127?hue(c)-256:hue(c);
        g = saturation(c)>127?saturation(c)-256:saturation(c);
        b = brightness(c)>127?brightness(c)-256:brightness(c);
      } else {
        r = red(c)>127?red(c)-256:red(c);
        g = green(c)>127?green(c)-256:green(c);
        b = blue(c)>127?blue(c)-256:blue(c);
      }
      raw[iter++] = r;
      raw[iter++] = g;
      raw[iter++] = b;
      raw1[iter2] = r;
      raw2[iter2] = g;
      raw3[iter2] = b;
      iter2++;
    }
  }
  
  n = (int)pow(2,ceil(log(s*3)/log(2)));
  n2 = (int)pow(2,ceil(log(s)/log(2)));

  in = new float[n];
  w = new float[n];
  out = new float[n];  
  out1 = new float[n2];
  out2 = new float[n2];
  out3 = new float[n2];
  in1 = new float[n2];
  in2 = new float[n2];
  in3 = new float[n2];

  arrayCopy(raw,0,in,0,raw.length);
  for(int i=raw.length;i<n;i++) in[i] = raw[raw.length-1];

  arrayCopy(raw1,0,in1,0,s);
  arrayCopy(raw2,0,in2,0,s);
  arrayCopy(raw3,0,in3,0,s);

  for(int i=s;i<n2;i++) {
    in1[i] = raw1[s-1];
    in2[i] = raw2[s-1];
    in3[i] = raw3[s-1];
  }

  printOption();
  printScale();

}

float clamp(float c) {
  return(abs(c<0?256+c:c)%255.0);
}

void option2() {
  wtrafo(in1,n2);
  wbtrafo(out1,n2);
  
  wtrafo(in2,n2);
  wbtrafo(out2,n2);
  
  wtrafo(in3,n2);
  wbtrafo(out3,n2);
  
  for(int i=0;i<s;i++) {
    float r = clamp(out1[i]);
    float g = clamp(out2[i]);
    float b = clamp(out3[i]);
    fill(r,g,b);
    rect(i%width,i/width,1,1); 
  }
  
}

void option1() {
  wtrafo(in,n);
  wbtrafo(out,n);
  
  float r=0,g=0,b=0;
  int state = 0;
  
  for(int i=0;i<raw.length;i++) {
    float c = clamp(out[i]);
    switch(state) {
      case 0: r = c; break;
      case 1: g = c; break;
      case 2: b = c; break;
      default: {
        r = c;
        fill(r,g,b);
        rect(floor(i/3.0)%width,floor(i/3.0)/width,1,1);
        state = 0;
      }
    }
    state++;    
  }
}

void draw() {
  scalingfactorin = map(mouseX,0,width,0,sc);
  scalingfactorout = map(mouseY,0,height,0,sc);
  
  if(option1) option1();
  else option2();  
}

void printOption() {
  String str1,str2;
  if(do_hsb) {
    str1 = "HSBHSBHSB...";
    str2 = "HHH...SSS...BBB...";
  } else {
    str1 = "RGBRGBRGB...";
    str2 = "RRR...GGG...BBB..."; //<>//
  }
  if(option1) println("channels combined: " + str1);
    else println("channels separated: " + str2);
}

void printScale() {
  println("Scale: 0.."+sc);
}

void keyPressed() {
  if(keyCode == 32) {
    option1 = !option1;
    printOption();
  } else if(keyCode == ENTER || keyCode == RETURN) {
    if(sc < 10) sc = 10;
    else if(sc<100) sc *=2;
    else if(sc<1000) sc+=200;
    else sc = 1;
    printScale();
  }
}

void mouseClicked() {
  saveFrame("res_####_" + filename);
  println("image saved");
}

void wbtrafo(float[] y, int n) {
  float[] d = new float[n];
  d[n-2] = w[n-1];
  int b1 = n-4;
  int b2 = n-2;
  int a=1;
  while(a<n/2) {
    for(int i=0;i<a;i++) {
      d[2*i+b1]=(d[i+b2]+w[i+b2])*sqrt05;
      d[2*i+1+b1]=(d[i+b2]-w[i+b2])*sqrt05;
    }
    b2=b1;
    b1=b1-4*a;
    a*=2;
  }
  
  for(int i=0;i<a;i++) {
      y[2*i]=(d[i]+w[i])*sqrt05;
      y[2*i+1]=(d[i]-w[i])*sqrt05;
  }
  
  for(int i=0;i<n;i++) y[i] *= scalingfactorout;
}

void wtrafo(float[] y, int n) {
  float[] d = new float[n];
  int a = n/2;
  for(int i=0;i<a;i++) {
    w[i] = (y[2*i]-y[2*i+1])*sqrt05;
    d[i] = (y[2*i]+y[2*i+1])*sqrt05;
  }
  int b1 = 0;
  int b2 = a;
  a/=2;
  while(a>0) {
    for(int i=0;i<a;i++) {
      w[i+b2]=(d[2*i+b1]-d[2*i+1+b1])*sqrt05;
      d[i+b2]=(d[2*i+b1]+d[2*i+1+b1])*sqrt05;
    }
    b1=b2;
    b2=b2+a;
    a/=2;
  }
  w[b2] = d[b1];
  
  for(int i=0;i<n-1;i++) w[i] = (int)(w[i]/scalingfactorin);
  if(w[n-1]>0) w[n-1] = (int)(w[n-1]/scalingfactorin+0.5);
  else w[n-1] = (int)(w[n-1]/scalingfactorin-0.5);
}

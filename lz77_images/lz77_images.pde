// Template for processing scripts
// Tomasz Sulej, generateme.blog@gmail.com, http://generateme.tumblr.com
// Licence: http://unlicense.org/

// Usage:
//   * press SPACE to save
//   * click to random setup

// set up filename
String filename = "test";
String fileext = ".jpg";
String foldername = "./";

int max_display_size = 1000; // viewing window size (regardless image size)

boolean do_blend = false; // blend image after process
int blend_mode = OVERLAY; // blend type

// choose colorspace
int colorspace = HSB; // HSB or RGB
// set compressor attributes for each channel in chosen colorspace
//   first number is length of dictionary in LZ77 - values 100 - 4000
//   second number is length of word (ahead buffer) in LZ77 - about 5% - 50% of dictionary size 
int[][] compressor_attributes = { {2000, 250},   // channel 1 (H or R)
                                  {50, 10},   // channel 2 (S or G)
                                  {100, 100} };  // channel 3 (B or B)
// set number of glitches made for each channel
//   first number is actual number of random change in compressed channel
//   second number is amount of change (values from 0.01 to 4)
float[][] number_of_glitches = { {5000,2},       // channel 1
                                 {500, 1},     // channel 2
                                 {50, 0.1} };   // channel 3

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
  
  cr = new byte[img.width*img.height];
  cb = new byte[img.width*img.height];
  cg = new byte[img.width*img.height];
  
  processImage();
}

void draw() {
  // fill for iterative processing
}

LZ77 comp1, comp2, comp3;
byte[] cr,cb,cg;

void processImage() {
  buffer.beginDraw();
  
  print("Preparing... ");
  
  comp1 = new LZ77( compressor_attributes[0][0], compressor_attributes[0][1] );
  comp2 = new LZ77( compressor_attributes[1][0], compressor_attributes[1][1] );
  comp3 = new LZ77( compressor_attributes[2][0], compressor_attributes[2][1] );
  
  img.loadPixels();
  int iter=0;
  for(int i=0;i<img.pixels.length;i++) {
    color c = img.pixels[i];
    if(colorspace == HSB) {
      cr[iter]= (byte)hue(c);
      cg[iter]= (byte)saturation(c);
      cb[iter]= (byte)brightness(c);
    } else {
      cr[iter]= (byte)red(c);
      cg[iter]= (byte)green(c);
      cb[iter]= (byte)blue(c);
    }
    iter++;
  }
  println("done");
  
  print("Glitching channel 1... ");
  comp1.doCompress(cr);  
  comp1.glitch( (int)number_of_glitches[0][0], number_of_glitches[0][1] );
  comp1.doDecompress(cr);
  println("done");
  
  print("Glitching channel 2... ");
  comp2.doCompress(cg);  
  comp2.glitch( (int)number_of_glitches[1][0], number_of_glitches[1][1] );
  comp2.doDecompress(cg);
  println("done");
  
  print("Glitching channel 3... ");
  comp3.doCompress(cb);  
  comp3.glitch( (int)number_of_glitches[2][0], number_of_glitches[2][1] );
  comp3.doDecompress(cb);
  println("done");
  
  buffer.loadPixels();
  if(colorspace == HSB) colorMode(HSB); else colorMode(RGB);
  iter=0;
  for(int i=0;i<buffer.pixels.length;i++) {
    float r = cr[iter];
    r = r>=0?r:r+256;
    float g = cg[iter];
    g = g>=0?g:g+256;
    float b = cb[iter];
    b = b>=0?b:b+256;
    
    buffer.pixels[i] = color(r,g,b);
    iter++;
  }
  
  buffer.updatePixels();
  
  if(do_blend)
    buffer.blend(img,0,0,img.width,img.height,0,0,buffer.width,buffer.height,blend_mode);
    
  buffer.endDraw();
  image(buffer,0,0,width,height);
}

void mouseClicked() {
  println("");
  println("Config:");
  colorspace = random(1)<0.4?RGB:HSB;
  println("Colorspace: " + (colorspace==RGB?"RGB":"HSB"));
  do_blend = random(1)<0.2;
  blend_mode = blends[(int)random(blends.length)];
  for(int i=0;i<3;i++) {
    compressor_attributes[i][0] = (int)random(100,3000);
    compressor_attributes[i][1] = (int)(random(0.1,0.5)*compressor_attributes[i][0]);
    number_of_glitches[i][0] = (int)random(20,1000);
    number_of_glitches[i][1] = random(0.1,2);
    println("Channel "+(i+1)+" = ("+compressor_attributes[i][0]+","+compressor_attributes[i][1]+")"
            + ", glitches = ("+number_of_glitches[i][0]+","+number_of_glitches[i][1]+")");
  }
  processImage();
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

final static int[] blends = {ADD, SUBTRACT, DARKEST, LIGHTEST, DIFFERENCE, EXCLUSION, MULTIPLY, SCREEN, OVERLAY, HARD_LIGHT, SOFT_LIGHT, DODGE, BURN};

// LZ77

class Tuple {
  public int offset, len;
  byte chr;
  public Tuple(int o, int l, byte c) {
    offset = o; len = l; chr = c;
  }
}

class LZ77 {
  int windowWidth;
  int lookAheadWidht;
  
  public LZ77(int ww, int law) {
    windowWidth = ww;
    lookAheadWidht = law;
  }
  
  ArrayList<Tuple> clist = new ArrayList<Tuple>();
  
  public void glitch(int no, float fac) {
    for(int i=0;i<no;i++) {
      Tuple r = clist.get( (int)random(clist.size()));
      int what = (int)random(3);
      switch(what) {
        case 0: r.chr = (byte)random(256); break;
        case 1: r.offset = (int)random(2*windowWidth*fac); break;
        default: r.len = (int)random(2*lookAheadWidht*fac);
      }
    }
  }
  
  public void doCompress(byte[] buff) {
    int currByte = 1;

    // first is always byte
    clist.add( new Tuple(0,0,buff[0]) );
    
    while(currByte < buff.length) {
      int bend = constrain(currByte-windowWidth,0,buff.length);
      int boff = 0;
      int blen = 0;
      
      if(currByte<buff.length-1)
      for(int i = currByte-1; i>=bend;i--) {
        if(buff[currByte] == buff[i]) {
          
          int tboff = abs(i-currByte);
          int tblen = 1;
          int laEnd = constrain(currByte+lookAheadWidht,0,buff.length-1);
          int mi = currByte+1;
          
          while(mi<laEnd && (i+mi-currByte)<currByte) {
            if(buff[mi] == buff[i+mi-currByte]) {
              mi++;
              tblen++;
            } else {
              break;
            }
          }
          
          if(tblen>blen) {
            blen = tblen;
            boff = tboff;
          }
          
        }
      }
      
      currByte +=blen+1;
     // println("currchar = " + (currByte-1)+",blen = " + blen);
      clist.add( new Tuple(boff,blen,buff[currByte-1]) );
     // println(boff + ", " + blen + ", " + buff[currByte-1]); 
    }
    //println("clist " + clist.size()*2);
  }

  void doDecompress(byte[] buff) {
    int i = 0;
    for(Tuple t: clist) {
      if(i>=buff.length) break;
      if(t.offset == 0) {
        buff[i++] = t.chr;
      } else {
        int start = i-t.offset;
        int end = start + t.len;
        for(int c = start; c<end;c++) {
          int pos = constrain(c,0,buff.length-1);
          buff[constrain(i++,0,buff.length-1)] = buff[pos];
          if(i>=buff.length) break;
        }
        if(i>=buff.length) break;
        buff[i++] = t.chr;
      }
    }
  }
 
}

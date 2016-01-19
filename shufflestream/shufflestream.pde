// Chunk shuffler
// generateme.blog@gmail.com, http://generateme.tumblr.com
// shuffle/reorganize data chunks based on rules
// still something is wrong

import java.util.Collections;
import java.io.*;

int[] pattern_a = { 64,80,200 }; // sizes of subchunks
int[] pattern_b = { 4,8,12,16 }; // sizes of subchunks
int[] pattern_b_rule = { 3,2,0,1 }; // permutation order

// rules, recursive (first make first rule, on chunks produced by first rule apply second rule, and so on...
// remember, chunk sizes should be less in next steps than minimum current
Rule[] rules = {
  divide(1200*30), // divide stream to chunks
  shuffle(200*40), // divide previous chunk to smaller chunks and shuffle 
  shuffle_pattern(pattern_a), // divide previous chunks according to pattern and shuffle
  permutate_pattern(pattern_b,pattern_b_rule), // as above with permutation instead of shuffle
};

// do not touch number of bytes/pixels from beginning and end of the file
int skip_header = 0;
int skip_footer = 0;

// how much data from the stream process at once
int max_chunk_size = 1000000;

// file name
String filename = "test.jpg";
// different processing algorithm for images...
boolean isImage = true;

// do not touch below this line

Rule shuffle_pattern(int[] p) { return new Rule(SHUFFLE, p); }
Rule permutate_pattern(int[] p, int[] r) { return new Rule(PERMUTATE,p,r); }
Rule shuffle(int w) { return new Rule(SHUFFLE_G, w); }
Rule divide(int w) { return new Rule(DIVIDE_G, w); }

void setup() {
  if(isImage) {
    PImage img = loadImage(filename);
    processImage(img);
    size(img.width,img.height);
    image(img,0,0);
  } else {
    try {
      InputStream in = createInput(filename);
      BufferedOutputStream out = new BufferedOutputStream(createOutput("res_"+filename));
      if(skip_header>0 && in.available()>skip_header) {
        byte[] b = new byte[skip_header];
        in.read(b);
        out.write(b);
      }
      int cnt = 0;
      while( (cnt=(in.available()-skip_footer))>0) {
        int l = max_chunk_size;
        if(cnt<l) l = cnt;
        byte[] b = new byte[l];
        in.read(b);
        arrayCopy(processRules(b,0),0,b,0,b.length);
        out.write(b);
      }
      if(skip_footer>0) {
        byte[] b = new byte[skip_footer];
        in.read(b);
        out.write(b);
      }
      out.flush();
      out.close();
      in.close();
      
    } catch(Exception e) {
      e.printStackTrace();
    }
    println("done");
    exit();
  }
}

void processImage(PImage img) {
  img.loadPixels(); 
  color[] buf = new color[img.pixels.length-skip_header-skip_footer];
  arrayCopy(img.pixels,skip_header,buf,0,img.pixels.length-skip_header-skip_footer);
  arrayCopy(bytes2pixels(processRules(pixels2bytes(buf),0)),0,img.pixels,skip_header,buf.length);
  img.updatePixels();
  img.save("res_"+filename);
}

byte[] pixels2bytes(color[] px) {
  byte[] result = new byte[4*px.length];
  for(int i=0,j=0;i<result.length;i+=4,j++) {
    result[i+3] = (byte)((px[j] << 24) >>> 24);
    result[i+2] = (byte)((px[j] << 16) >>> 24);
    result[i+1] = (byte)((px[j] << 8) >>> 24);
    result[i] = (byte)(px[j] >>> 24);
  }
  return result;
}

color[] bytes2pixels(byte[] px) {
  color[] result = new color[px.length/4];
  for(int i=0,j=0;i<px.length;i+=4,j++) {
    result[j] = (px[i+3]&0xff) | ((px[i+2]&0xff)<<8) | ((px[i+1]&0xff)<<16) | ((px[i]&0xff)<<24);
  }
  return result;
}

byte[] processRules(byte[] pix, int depth) {
  byte[] result = new byte[pix.length];
  if(depth >= rules.length) return pix;
  
    ArrayList<Chunk> chunks = new ArrayList<Chunk>();
    Rule rule = rules[depth];
    if(rule.method == DIVIDE_G || rule.method == SHUFFLE_G) {
      int idx = 0;
      while(idx<pix.length) {
        int l = rule.len;
        if((idx+rule.len)>=pix.length)
        l = pix.length-idx;

        Chunk chunk = new Chunk();
        chunk.ch = new byte[l];
        arrayCopy(pix,idx,chunk.ch,0,l);
        
        chunks.add(chunk);

        idx+=l;
      }
    }
    if(rule.method == SHUFFLE_G) Collections.shuffle(chunks);
    if(rule.method == SHUFFLE || rule.method == PERMUTATE) {
      int idx = 0;
      int pidx = 0;
      ArrayList<Chunk> pchunks = new ArrayList<Chunk>(rule.p1.length);
      while(idx<pix.length) {
        int l = rule.p1[pidx];
        if((idx+rule.p1[pidx])>=pix.length)
        l = pix.length-idx;

        Chunk chunk = new Chunk();
        chunk.ch = new byte[l];
        arrayCopy(pix,idx,chunk.ch,0,l);
        
        pchunks.add(chunk);
        pidx++;
        
        if(pidx == rule.p1.length) {
          if(rule.method == SHUFFLE) {
            Collections.shuffle(pchunks);
            chunks.addAll(pchunks);
          }
          if(rule.method == PERMUTATE) {
            for(int i : rule.p2) {
              chunks.add(pchunks.get(i));
            } 
          }
          pchunks.clear();
          pidx = 0;
        }
              
        idx+=l;
      }
    }

    for(Chunk chunk : chunks) {
      chunk.ch = processRules(chunk.ch,depth+1);
    }    
    
    int idx=0;
    for(Chunk chunk : chunks) {
      arrayCopy(chunk.ch,0,result,idx,chunk.ch.length);
      idx+=chunk.ch.length;
    }

  
  return result;
}

class Chunk {
  byte[] ch;
}

final static int SHUFFLE = 0; // shuffle with pattern
final static int SHUFFLE_G = 1; // shuffle globally
final static int PERMUTATE = 2; // permutate pattern
final static int DIVIDE_G = 3; // divide globally

class Rule {
  int[] p1,p2;
  int method;
  int len;
  
  public Rule(int method, int[] p) {
    this(method,p,p);
  }
  
  public Rule(int method, int w) {
    this.method = method;
    this.len = w;
  }
  
  public Rule(int method, int[] p1, int[] p2) {
    this.method = method;
    this.p1 = p1;
    this.p2 = p2;
  }
}

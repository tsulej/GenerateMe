// lz77 pure compressor/decompressor without CRC checking
// Tomasz Sulej, generateme.blog@gmail.com, http://generateme.tumblr.com
// licence: <http://unlicense.org>

import java.io.BufferedOutputStream;
import java.io.DataOutputStream;

// Configuration
int method = COMPRESS; // raw_filename -> lz77_filename 
//int method = DECOMPRESS; // lz77_filename -> raw_filename
String raw_filename = "test.raw"; // file name to compress, save as lz77_filename
String lz77_filename = "test.lz77"; // file name to decompress, save as raw_filename

// compress configuration
int type = LARGE; // SMALL or LARGE, small dictionary and ahead buffer, use the same settings for compressor and decompressor
int compress_factor = 7; // 0 - 8 for LARGE, 0-3 - for SMALL

// do not touch below

final static int COMPRESS = 0;
final static int DECOMPRESS = 1;
final static int SMALL = 0;
final static int LARGE = 1;

void setup() {
  size(100,100);
  
  int dictsize, aheadsize;
  if(type == LARGE) {
    compress_factor = constrain(compress_factor,0,8);
    dictsize = compress_factor+4;
    aheadsize = 12-compress_factor;
  } else {
    compress_factor = constrain(compress_factor,0,3);
    dictsize = compress_factor+2;
    aheadsize = 6-compress_factor;
  }  
  
  int dict = (int)pow(2,dictsize)-1;
  int ahead = (int)pow(2,aheadsize)-1;
  
  LZ77 c = new LZ77(dict,ahead);
  
  if(method == COMPRESS) {
    print("Compressing " + raw_filename + "... ");
    byte[] b = loadBytes(raw_filename);
    c.doCompress(b);
    
    try {
      DataOutputStream out = new DataOutputStream(new BufferedOutputStream(createOutput(lz77_filename)));
      for(Tuple t: c.clist) {
        int d = (t.offset & dict) | ( (t.len & ahead) << dictsize ) ;
        
        out.writeByte( (byte)(d & 0xff) );
        if(type == LARGE) {
          out.writeByte( (byte)((d >> 8) & 0xff) );
        }
        out.writeByte( t.chr );
      }
      out.flush();
      out.close();
      println("done.");
    } catch( Exception e) {
      e.printStackTrace();
    }
    
  } else {
    print("Decompressing " + lz77_filename + "... ");
    byte[] b = loadBytes(lz77_filename);
    c.clist.clear();
    
    int blen = 0;
    for(int iter=0;iter<b.length-(1+type);iter+=(2+type)) {
      int d = (b[iter] & 0xff) | ( type == LARGE ? (b[iter+1]&0xff)<<8 : 0 );
      int offset = (d & dict);
      int len = (d >> dictsize) & ahead;
      blen += len + 1;
      Tuple t = new Tuple(offset,len,b[iter+1+type]);
      c.clist.add(t);
    }
    byte[] buff = new byte[blen];
    c.doDecompress(buff);
    
    saveBytes("d_"+raw_filename,buff);
    
    println("done.");
  }
  
}


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
  
  public ArrayList<Tuple> clist = new ArrayList<Tuple>();
  
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
      clist.add( new Tuple(boff,blen,buff[currByte-1]) ); 
    }

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

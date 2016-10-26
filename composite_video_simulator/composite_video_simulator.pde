// Composite Video Simulator
// Tomasz Sulej, generateme.blog@gmail.com, http://generateme.tumblr.com
// Licence: http://unlicense.org/

// This is port of the code made by Jonathan Campbell
// original source is located here: https://github.com/joncampbell123/composite-video-simulator
// Software made by Jonathan is based on ffmpeg and is able to process your video file (video + audio)
// Check out also his page: http://hackipedia.org/

// This is fourth script from the analog series, check out:
// * NTSC TV Simulator: https://github.com/tsulej/GenerateMe/tree/master/ntsc_analogtv
// * Frequency Modulator: https://github.com/tsulej/GenerateMe/tree/master/fm
// * Sonification: https://github.com/SonifyIt/sonification

// Explanation of the process. Your image (line by line) are treated as a signal, which goes following path:
// 1. Convert signal to YIQ color space. Y is luma (brighntess), I and Q are chroma and encode color
// 2. Lowpass filter on chroma
// 3. QAM to pack all three channels into one signal (composite video)
// 4. Amplify high frequencies of the signal
// 5. Add noise to the signal
// 6. Demodulate to get luma and chroma back
// 7. Simulate tape by applying FM on luma (and add noise)
// 8. Add chroma noise
// 9. Add noise to hue (rotate I and Q)
// 10. Luma low pass filter + slightly amplify higher freqs
// 11. Chroma low pass with delay
// 12. Blur chroma vertically
// 13. Sharpen luma
// 14. Modulate and demodulate (QAM) - simulate just another device to device connection
// 15. Simulate more device-to-device connections
// 16. Lowpass filter on chroma once more
// 17. Convert back to RGB
// 18. Apply RGB TV scanlines
// 19. done...
// You can turn on/off most of the options, you can adjust several parameters below

// Experiment and enjoy

// Usage:
//   * press SPACE to save

// set up filename
String filename = "test";
String fileext = ".jpg";
String foldername = "./";

int max_display_size = 1000; // viewing window size (regardless image size)

///// CONFIG START

boolean composite_in_chroma_lowpass = true; // low pass filter on input chroma values
int subcarrier_amplitude = 40; // values: 1-200
int subcarrier_amplitude_back = subcarrier_amplitude + 0; // values similar to subcarrier_amplitude
int video_scanline_phase_shift = 0; // 0,90,180,270
int video_scanline_phase_shift_offset = 0; // 0, 90, 180, 270
float composite_preemphasis = 1; // signal amplification: 1-100 
float composite_preemphasis_cut = 315000000 / 88.0; // filter cutoff
int video_noise = 4000; // luma noise
int video_chroma_noise = 4000; // chroma noise
int video_chroma_phase_noise = 15; // hue noise
boolean composite_out_chroma_lowpass = true; // filter output
boolean composite_out_chroma_lowpass_lite = false; // true = lite filter, false = strong filter
float video_chroma_loss = 0.24; // loss of color probability
boolean vhs_svideo_out = true; // use composite video as output
int[] emulating_vhs = VHS_SP; // VHS_SP, VHS_LP, VHS_EP
boolean vhs_chroma_vert_blend = true; // blend colors
boolean vhs_sharpen = true; // sharpen image
float vhs_out_sharpen = 2; // sharpen amount
int video_recombine = 0; // number of device-to-device connections
float scanlines_scale = 1.5; // 0 - no scanlines, >1 blur
boolean fm = true; // add FM (tape) errors
float fm_omega = 0.62; // carrier - experiment 0.001 - 40
float fm_phase = 2; // bandwidth - experiment 0.001 - 40
float fm_lightness = 0.62; // adjust lighntess when FM
int fm_quantize = 0; // quantize FM signal, 0 - off, 2 - dramatic, 20 - better, 100 - best
boolean fm_noise = true; // and tape error noise
float fm_noise_start = 0.92; // error start - percentage of the image
float fm_noise_stop = 1; // error stop - % of image (0 - top, 1 - bottom)

///// END

final static int[] VHS_SP = { 
  2400000, 320000, 9
};
final static int[] VHS_LP = { 
  1900000, 300000, 12
};
final static int[] VHS_EP = { 
  1400000, 280000, 14
};
final static int[] NONE = null;

boolean do_blend = false; // blend image after process
int blend_mode = OVERLAY; // blend type

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

  size(neww,newh);
  
  processImage();
}

void draw() {
  // fill for iterative processing
}

void processImage() {
 
  // START CODE HERE! use buffer to draw/manipulate
  
  img.loadPixels();
  buffer.pixels = composite_layer(img.pixels,img.width,img.height);
  buffer.updatePixels();
  
  // END CODE HERE!
  
  buffer.beginDraw();
  
  if(do_blend)
    buffer.blend(img,0,0,img.width,img.height,0,0,buffer.width,buffer.height,blend_mode);
    
  println("render scanlines");
  
  if(scanlines_scale>1)
    renderScanLines();  
    
  buffer.endDraw();
  image(buffer,0,0,width,height);
}

void keyPressed() {
  // SPACE to save
  if(keyCode == 32) {
    String fn = foldername + filename + "/res_" + sessionid + hex((int)random(0xffff),4)+"_"+filename+fileext;
    buffer.save(fn);
    println("Image "+ fn + " saved");
  }
}

int[] composite_layer(int[] src, int w, int h) {
  int[] dst = new int[w*h];

  int[] fY = new int[w*h];
  int[] fI = new int[w*h];
  int[] fQ = new int[w*h];

  println("to YIQ");

  for (int i=0; i<src.length; i++) {
    int r = (src[i] >> 16) & 0xff;
    int g = (src[i] >> 8) & 0xff;
    int b = (src[i]) & 0xff;
    PVector res = RGB_to_YIQ(new PVector(r, g, b));
    fY[i] = (int)res.x;
    fI[i] = (int)res.y;
    fQ[i] = (int)res.z;
  }

  println("composite chroma lowpass");

  if (composite_in_chroma_lowpass) {
    composite_lowpass(fI, fQ, w, h);
  }

  println("chroma to luma");

  chroma_into_luma(fY, fI, fQ, w, h);

  println("preemphasis");

  if (composite_preemphasis != 0.0 && composite_preemphasis_cut > 0) {
    LowpassFilter pre = new LowpassFilter();
    pre.setFilter((315000000.0 * 4.0) / 88.0, composite_preemphasis_cut);

    for (int y=0; y<h; y++) {
      int off = y * w;
      float s;

      pre.resetFilter(16);
      for (int x=0; x<w; x++) {
        int xx = x + off;
        s = fY[xx];
        s += pre.highpass(s) * composite_preemphasis;
        fY[xx] = (int)s;
      }
    }
  }

  println("video noise");

  if (video_noise != 0) {
    int noise = 0;
    int noise_mod = video_noise * 2 + 1;
    //int noise_mod = (video_noise * 255) / 100;
    for (int i=0; i<fY.length; i++) {
      fY[i] += noise;
      noise += (((int)random(MAX_INT)) % (noise_mod)) - video_noise;
      noise >>= 1;
    }
  }

  // head switching was here
  
  println("chroma from luma");
  
  chroma_from_luma(fY, fI, fQ, w, h);

  println("fm");

  float omega = fm_omega;
  float phase = fm_phase;
  float max_phase = phase;
  float min_phase = -phase;

  if (fm) {
    LowpassFilter lpf = new LowpassFilter();
    LowpassFilter lpf2 = new LowpassFilter();
    LowpassFilter lpf3 = new LowpassFilter();
    lpf.setFilter(emulating_vhs[0], emulating_vhs[1]);
    lpf2.setFilter(emulating_vhs[0], emulating_vhs[1]);
    lpf3.setFilter(emulating_vhs[0], emulating_vhs[1]);

    for (int y=0; y<h; y++) {
      float sig_int = 0; // signal integral
      float pre_m = 0; // previous modulated value
      int off = y * w;

      lpf.resetFilter();
      lpf2.resetFilter();
      lpf3.resetFilter();

      for (int x=0; x<w; x++) {
        float ncs = map(fY[x+off], -50000, 100000, min_phase,max_phase);
        
        sig_int += ncs; // integrate
        float m = sin(x*omega + sig_int); // modulate

        if(fm_quantize > 0) {
          m = map((int)map(m, -1, 1, 0, fm_quantize), 0, fm_quantize, -1, 1);
        }

        float dem = abs(m-pre_m); // differentiate (first step of demodulation)
        
        int ystart = (int)(fm_noise_start * h);
        int ystop = (int)(fm_noise_stop * h);
        if(y > ystart && y < ystop && fm_noise) { // fm noise, set demodulation value to maximum
          if(random(1)<0.1) {
          float s = map(tan(map(y,ystart,ystop,-HALF_PI,PI)),-1,1,0,0.2);
          
          if(random(1)<s*noise(x/100.0,y/10.0)) {
            dem = random(1,3);
           }
          }
        }
        
        pre_m = m;

        float fdem = dem;
        fdem = lpf.lowpass(fdem); // envelope detection
        fdem = lpf2.lowpass(fdem);
        fdem = lpf3.lowpass(fdem);

        int v = (int)map(2*(fdem-omega*fm_lightness), min_phase, max_phase, -50000, 100000); // adjust and map back
        fY[x+off] = v;
      }
    }
  }

  println("chroma noise");

  if (video_chroma_noise != 0) {
    int noiseU = 0;
    int noiseV = 0;
    int noise_mod = video_chroma_noise * 2 + 1;
    //int noise_mod = (video_noise * 255) / 100;
    for (int i=0; i<fI.length; i++) {
      fI[i] += noiseU;
      fQ[i] += noiseV;
      noiseU += (((int)random(MAX_INT)) % (noise_mod)) - video_noise;
      noiseU >>= 1;
      noiseV += (((int)random(MAX_INT)) % (noise_mod)) - video_noise;
      noiseV >>= 1;
    }
  }

  println("chroma phase noise");

  if (video_chroma_phase_noise != 0) {
    int noise = 0;
    int noise_mod = (video_chroma_phase_noise*2)+1;
    for (int y=0; y<h; y++) {
      noise += (((int)random(MAX_INT)) % (noise_mod)) - video_chroma_phase_noise;
      noise >>= 1;
      float pi = (noise * PI) / 100.0;
      float sinpi = sin(pi);
      float cospi = cos(pi);

      int off = y * w;
      for (int x=0; x<w; x++) {
        float u = fI[x+off];
        float v = fQ[x+off];

        fI[x+off] = (int)((u * cospi) - (v * sinpi));
        fQ[x+off] = (int)((u * sinpi) + (v * cospi));
      }
    }
  }

  if (emulating_vhs != null) {
    int luma_cut = emulating_vhs[0];
    int chroma_cut = emulating_vhs[1];
    int chroma_delay = emulating_vhs[2];

    println("vhs luma lowpass");

    // luma lowpass
    LowpassFilter[] lp = new LowpassFilter[3];
    lp[0] = new LowpassFilter();
    lp[1] = new LowpassFilter();
    lp[2] = new LowpassFilter();
    LowpassFilter pre = new LowpassFilter();
    for (int f=0; f<3; f++) {
      lp[f].setFilter((315000000.0 * 4.0) / 88.0, luma_cut);
    }
    pre.setFilter((315000000.0 * 4.0) / 88.0, luma_cut/3);

    for (int y=0; y<h; y++) {
      for (int f=0; f<3; f++) {
        lp[f].resetFilter(16);
      }
      pre.resetFilter(16);

      int off = y*w;
      for (int x=0; x<w; x++) {
        float s = fY[x+off];
        for (int f=0; f<3; f++) {
          s = lp[f].lowpass(s);
        }
        s += pre.highpass(s) * 1.6;
        fY[x+off] = (int)s;
      }
    } 

    println("vhs chroma lowpass");
  
    // chroma lowpass
    LowpassFilter[] lpU = new LowpassFilter[3];
    lpU[0] = new LowpassFilter();
    lpU[1] = new LowpassFilter();
    lpU[2] = new LowpassFilter();
    LowpassFilter[] lpV = new LowpassFilter[3];
    lpV[0] = new LowpassFilter();
    lpV[1] = new LowpassFilter();
    lpV[2] = new LowpassFilter();

    for (int f=0; f<3; f++) {
      lpU[f].setFilter((315000000.0 * 4.0) / 88.0, chroma_cut);
      lpV[f].setFilter((315000000.0 * 4.0) / 88.0, chroma_cut);
    }

    for (int y=0; y<h; y++) {
      for (int f=0; f<3; f++) {
        lpU[f].resetFilter(0);
        lpV[f].resetFilter(0);
      }

      int off = y*w;
      for (int x=0; x<w; x++) {
        float s = fI[x+off];
        for (int f=0; f<3; f++) {
          s = lpU[f].lowpass(s);
        }
        if (x >= chroma_delay) fI[x+off-chroma_delay] = (int)s;

        s = fQ[x+off];
        for (int f=0; f<3; f++) {
          s = lpV[f].lowpass(s);
        }
        if (x >= chroma_delay) fQ[x+off-chroma_delay] = (int)s;
      }
    } 

    println("chroma vert blend");

    if (vhs_chroma_vert_blend) {
      int[] delayU = new int[w];
      int[] delayV = new int[w];

      for (int y=0; y<h; y++) {
        int off = y*w;

        for (int x=0; x<w; x++) {
          int cU = fI[x+off];
          int cV = fQ[x+off];
          fI[x+off] = (delayU[x]+cU+1)>>1;
          fQ[x+off] = (delayV[x]+cV+1)>>1;
          delayU[x] = cU;
          delayV[x] = cV;
        }
      }
    }

    println("vhs sharpen");

    if (vhs_sharpen) {
      for (int f=0; f<3; f++) {
        lp[f].setFilter((315000000.0 * 4.0) / 88.0, luma_cut * 4);
      }

      for (int y=0; y<h; y++) {
        for (int f=0; f<3; f++) {
          lp[f].resetFilter(0);
        }

        int off = y*w;
        for (int x=0; x<w; x++) {
          float s = fY[x+off];
          float ts = s;
          for (int f=0; f<3; f++) {
            ts = lp[f].lowpass(ts);
          }
          fY[x+off] = (int)(s + ((s-ts) * vhs_out_sharpen * 2.0));
        }
      }
    }

    println("svideo out");

    if (!vhs_svideo_out) {
      chroma_into_luma(fY, fI, fQ, w, h);
      chroma_from_luma(fY, fI, fQ, w, h);
    }
  }

  println("chroma loss");

  if (video_chroma_loss != 0) {
    for (int y=0; y<h; y++) {
      int off = y * w;

      //if ((((int)random(MAX_INT))%100000) < video_chroma_loss) {
      if (noise(y/20.0)< video_chroma_loss) {
        for (int x=off; x<off+w; x++) {
          fI[x] = 0;
          fQ[x] = 0;
        }
      }
    }
  }

  println("composite recombination");

  for (int i=0; i<video_recombine; i++) {
    chroma_into_luma(fY, fI, fQ, w, h);
    chroma_from_luma(fY, fI, fQ, w, h);
  }

  println("composite chroma lowpass out");

  if (composite_out_chroma_lowpass) {
    if (composite_out_chroma_lowpass_lite)
      composite_lowpass_tv(fI, fQ, w, h);
    else
      composite_lowpass(fI, fQ, w, h);
  }

  println("from YIQ");

  for (int i=0; i<src.length; i++) {
    PVector res = YIQ_to_RGB(new PVector(fY[i], fI[i], fQ[i]));
    int r = (int)res.x << 16;
    int g = (int)res.y << 8;
    int b = (int)res.z;
    dst[i] = 0xff000000 | r | g | b;
  }

  println("done");

  return dst;
}

int[] Umult = { 
  1, 0, -1, 0
};
int[] Vmult = { 
  0, 1, 0, -1
};

void chroma_into_luma(int[] fY, int[] fI, int[] fQ, int w, int h) {
  int xi;

  for (int y=0; y<h; y++) {

    if (video_scanline_phase_shift == 90)
      xi = (video_scanline_phase_shift_offset + (y >> 1)) & 3;
    else if (video_scanline_phase_shift == 180)
      xi = ((y & 2) + video_scanline_phase_shift_offset) & 3;
    else if (video_scanline_phase_shift == 270)
      xi = (video_scanline_phase_shift_offset - (y >> 1)) & 3;
    else
      xi = video_scanline_phase_shift_offset & 3;

    int off = y * w;

    for (int x=0; x<w; x++) {
      int sxi = (x+xi)&3;
      int xx = x + off;
      int chroma;

      chroma  = fI[xx] * subcarrier_amplitude * Umult[sxi];
      chroma += fQ[xx] * subcarrier_amplitude * Vmult[sxi];
      fY[xx] += (chroma / 50);
      fI[xx] = 0;
      fQ[xx] = 0;
    }
  }
}

void chroma_from_luma(int[] fY, int[] fI, int[] fQ, int w, int h) {
  int[] chroma = new int[w];
  int x, y;
  int xi;

  for (y=0; y<h; y++) {
    int off = y * w;
    int[] delay = { 
      0, 0, 0, 0
    };
    int sum = 0;
    int c;

    delay[2] = fY[off];
    sum += delay[2];
    delay[3] = fY[off+1];
    sum += delay[3];

    for (x=0; x<w; x++) {

      if ((x+2) < w) 
        c = fY[off+x+2];
      else 
        c = 0;

      sum -= delay[0];
      for (int j=0; j<3; j++) {
        delay[j] = delay[j+1];
      }    
      delay[3] = c;
      sum += delay[3];
      fY[x+off] = sum >> 2;
      chroma[x] = c - fY[x+off];
    }

    if (video_scanline_phase_shift == 90)
      xi = (video_scanline_phase_shift_offset + (y >> 1)) & 3;
    else if (video_scanline_phase_shift == 180)
      xi = ((y & 2) + video_scanline_phase_shift_offset) & 3;
    else if (video_scanline_phase_shift == 270)
      xi = (video_scanline_phase_shift_offset - (y >> 1)) & 3;
    else
      xi = video_scanline_phase_shift_offset & 3;

    for (x= ( (4-xi)&3); (x+3)<w; x+=4) {
      chroma[x+2] = -chroma[x+2];
      chroma[x+3] = -chroma[x+3];
    }

    for (x=0; x<w; x++) {
      chroma[x] = (chroma[x] * 50) / subcarrier_amplitude_back;
    }

    for (x=0; (x+xi+1)<w; x+=2) {
      fI[x+off] = -chroma[x+xi];
      fQ[x+off] = -chroma[x+xi+1];
    }

    for (; x<w; x+=2) {
      fI[x+off] = 0;
      fQ[x+off] = 0;
    }

    for (x=0; (x+2)<w; x+=2) {
      fI[x+off+1] = (fI[x+off] + fI[x+off+2]) >> 1;
      fQ[x+off+1] = (fQ[x+off] + fQ[x+off+2]) >> 1;
    }

    for (; x<w; x++) {
      fI[x+off] = 0;
      fQ[x+off] = 0;
    }
  }
}

void composite_lowpass(int[] fI, int[] fQ, int w, int h) {
  LowpassFilter[] lp = new LowpassFilter[3];
  lp[0] = new LowpassFilter();
  lp[1] = new LowpassFilter();
  lp[2] = new LowpassFilter();

  for (int p=0; p<2; p++) {
    int[] P = p==0 ? fI : fQ;
    float cutoff = p==0 ? 1300000.0 : 600000.0;
    int delay = p==0 ? 2 : 4;

    for (int f=0; f<3; f++) {
      lp[f].setFilter((315000000.0 * 4.0) / 88.0, cutoff);
    }

    for (int y=0; y<h; y++) {
      int off = y * w;

      for (int f=0; f<3; f++) {
        lp[f].resetFilter();
      }

      for (int x=0; x<w; x++) {
        float s = P[x+off];

        for (int f=0; f<3; f++) {
          s = lp[f].lowpass(s);
        }

        if (x >= delay) P[x+off-delay] = (int)s;
      }
    }
  }
}

void composite_lowpass_tv(int[] fI, int[] fQ, int w, int h) {
  LowpassFilter[] lp = new LowpassFilter[3];
  lp[0] = new LowpassFilter();
  lp[1] = new LowpassFilter();
  lp[2] = new LowpassFilter();

  float cutoff = 2600000.0;
  int delay = 1;

  for (int f=0; f<3; f++) {
    lp[f].setFilter((315000000.0 * 4.0) / 88.0, cutoff);
  }

  for (int p=0; p<2; p++) {
    int[] P = p==0 ? fI : fQ;

    for (int y=0; y<h; y++) {
      int off = y * w;

      for (int f=0; f<3; f++) {
        lp[f].resetFilter();
      }

      for (int x=0; x<w; x++) {
        float s = P[x+off];

        for (int f=0; f<3; f++) {
          s = lp[f].lowpass(s);
        }

        if (x >= delay) P[x+off-delay] = (int)s;
      }
    }
  }
}


PVector RGB_to_YIQ(PVector in) {
  float dY = (0.3*in.x)+(0.59*in.y)+(0.11*in.z);

  PVector res = new PVector();
  res.x = 256.0 * dY;
  res.y = 256.0 * ((-0.27 * (in.z - dY)) + (0.74 * (in.x - dY)));
  res.z = 256.0 * (( 0.41 * (in.z - dY)) + (0.48 * (in.x - dY)));

  return res;
}

PVector YIQ_to_RGB(PVector in) {
  int r = constrain((int)((in.x + ( 0.956 * in.y) + ( 0.621 * in.z)) / 256.0), 0, 255);
  int g = constrain((int)((in.x + (-0.272 * in.y) + (-0.647 * in.z)) / 256.0), 0, 255);
  int b = constrain((int)((in.x + (-1.106 * in.y) + ( 1.703 * in.z)) / 256.0), 0, 255);

  return new PVector(r, g, b);
}

class LowpassFilter {
  float timeInterval;
  float cutoff;
  float alpha;
  float prev;
  float tau;
  
  public LowpassFilter() {
    timeInterval = 0.0;
    cutoff = 0.0;
    alpha = 0.0;
    prev = 0.0;
    tau = 0.0;
  }
  
  void setFilter(float rate, float hz) {
    timeInterval = 1.0/rate;
    tau = 1.0 / (hz * TWO_PI);
    cutoff = hz;
    alpha = timeInterval / (tau + timeInterval);
  }
  
  void resetFilter(float val) { prev = val; }
  void resetFilter() { resetFilter(0); }
  
  float lowpass(float sample) {
    float stage1 = sample * alpha;
    float stage2 = prev - (prev * alpha);
    prev = (stage1 + stage2);
    return prev;
  }
  
  float highpass(float sample) {
    return sample - lowpass(sample);
  }
}

void renderScanLines() {
  PImage l1 = buffer.get();
  l1.resize((int)(buffer.width/scanlines_scale), (int)(buffer.height/scanlines_scale));
  l1.resize(buffer.width, buffer.height);
  PImage l2 = l1.get();

  l1.loadPixels();
  for (int i=0; i<l1.pixels.length; i++) {
    color c = l1.pixels[i];
    l1.pixels[i] = color(red(c), green(c)/1.8, blue(c)/10.0);
  }
  l1.updatePixels();
  buffer.image(l1, 0, 0);

  // RGB scan lines 
  for (int y=0; y<buffer.height; y+=3) {
    buffer.stroke( color(random(200, 220), 0, 0), 42);
    buffer.line(0, y, buffer.width, y);
    buffer.stroke( color(0, random(200, 220), 0), 42);
    buffer.line(0, y+1, buffer.width, y+1);
    buffer.stroke( color(0, 0, random(200, 220)), 42);
    buffer.line(0, y+2, buffer.width, y+2);
  }

  // layer 2, moved one pixel
  l2.loadPixels();
  for (int i=0; i<l2.pixels.length; i++) {
    color c = l2.pixels[i];
    l2.pixels[i] = color(red(c)/5.5, green(c)/1.8, blue(c));
  }
  l2.updatePixels();
  buffer.blend(l2, 0, 0, buffer.width, buffer.height, 1, 0, buffer.width, buffer.height, ADD);
}


// FM - frequency modulator
// 2016 Tomasz Sulej, generateme.blog@gmail.com, http://generateme.tumblr.com
// Licence: http://unlicense.org/

// Frequency modulation and demodulation of the image
// process goes in following way:
// - convert RGB into desired colorspace (GS - grayscale)
// For every channel
// - modulate signal
// - quantize and dequantize signal (if quantval > 0)
// - demodulate signal using derivative method
// - apply 3 lowpass filters in a chain to remove carrier (if possible)
// Combine channels and convert back to RGB 

// Usage:
//   * move mouse X axis - change the carrier wave frequency
//   * move mouse Y axis - change bandwidth
//   * press N to negate image
//   * press SPACE to save

// set up filename
String filename = "test";
String fileext = ".jpg";
String foldername = "./";

// configuration
int colorspace = RGB;
final static boolean first_channel_only = false; // for L.. or Y.. colorspaces set true to modulate only luma;
final static int quantval = 30; // 0 - off, less - more glitch, more - more precision
final static boolean lowpass1_on = true; // on/off of first low pass filter
final static boolean lowpass2_on = true; // on/off of second low pass filter
final static boolean lowpass3_on = true; // on/off of third low pass filter

// better don't touch it, lowpass filters are run in cascade
float lowpass1_cutoff = 0.25; // percentage of rate
float lowpass2_cutoff = 0.1;
float lowpass3_cutoff = 0.05;

int max_display_size = 1000; // viewing window size (regardless image size)

boolean do_blend = false; // blend image after process
int blend_mode = OVERLAY; // blend type

// working buffer
PGraphics buffer;

// image
PImage img;

String sessionid;

// local variables
float min_omega, max_omega;
float min_phase_mult=0.05;
float max_phase_mult=50.0;
LowpassFilter lpf1, lpf2, lpf3;
int[][] pxls;
boolean negate = false;

void setup() {
  sessionid = hex((int)random(0xffff), 4);
  img = loadImage(foldername+filename+fileext);

  buffer = createGraphics(img.width, img.height);
  buffer.beginDraw();
  buffer.noStroke();
  buffer.smooth(8);
  buffer.background(0);
  buffer.image(img, 0, 0);
  buffer.endDraw();

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

  img.loadPixels();

  min_omega = TWO_PI/(0.05*img.width);
  max_omega = TWO_PI/(300.0*img.width);

  float rate = 100000.0;

  lpf1 = new LowpassFilter(rate, lowpass1_cutoff*rate);
  lpf2 = new LowpassFilter(rate, lowpass2_cutoff*rate);
  lpf3 = new LowpassFilter(rate, lowpass3_cutoff*rate);
  
  pxls = new int[3][img.pixels.length];
  for (int i=0; i<img.pixels.length; i++) {
    int cl = toColorspace(img.pixels[i],colorspace);
    pxls[0][i] = (cl >> 16) & 0xff;
    pxls[1][i] = (cl >> 8) & 0xff;
    pxls[2][i] = (cl) & 0xff;
  }
}

float omega, min_phase, max_phase;
void draw() {
  omega = map(mouseX, 0, width, 0, 1);
  omega = map(sqrt(omega), 0, 1, min_omega, max_omega);
  float phase = map(mouseY, 0, height, 0, 1);
  phase = map(sq(phase), 0, 1, min_phase_mult, max_phase_mult);
  max_phase = phase * omega;
  min_phase = -max_phase;

  processImage();
}

void processImage() {
  buffer.beginDraw();
  buffer.loadPixels();

  int [][] dest_pxls = new int[3][img.pixels.length];
  
  if(first_channel_only) {
    arrayCopy(pxls[1],dest_pxls[1]);
    arrayCopy(pxls[2],dest_pxls[2]);
  }
  
  for (int i=0; i<(first_channel_only?1:3); i++) {
    for (int y=0; y<img.height; y++) {
      int off = y * img.width;
      
      //reset filters each line 
      lpf1.resetFilter(map(pxls[i][off], 0, 255, min_phase, max_phase));
      lpf2.resetFilter(map(pxls[i][off], 0, 255, min_phase, max_phase));
      lpf3.resetFilter(map(pxls[i][off], 0, 255, min_phase, max_phase));

      float sig_int = 0; // integral of the signal
      float pre_m = 0; // previous value of modulated signal

      for (int x=0; x<img.width; x++) {
        
        /////////////////////////
        // FM part starts here
        /////////////////////////
        
        float sig = map(pxls[i][x+off], 0, 255, min_phase, max_phase); // current signal value
        sig_int += sig; // current value of signal integral

        float m = cos(omega * x + sig_int); // modulate signal

        if ( quantval > 0) { 
          m = map((int)map(m, -1, 1, 0, quantval), 0, quantval, -1, 1); // quantize
        }

        float dem = abs(m-pre_m); // demodulate signal, derivative
        pre_m = m; // remember current value

        // lowpass filter chain
        if (lowpass1_on) dem = lpf1.lowpass(dem);
        if (lowpass2_on) dem = lpf2.lowpass(dem);
        if (lowpass3_on) dem = lpf3.lowpass(dem);

        // remap signal back to channel value
        int v = constrain( (int)map(2*(dem-omega), min_phase, max_phase, 0, 255), 0, 255);
        
        //////////////////////
        // FM part ends here
        //////////////////////
        
        dest_pxls[i][x+off] = negate?255-v:v;
      }
    }
  }
  
  for (int i=0; i<buffer.pixels.length; i++) {
    buffer.pixels[i] = fromColorspace(0xff000000 | (dest_pxls[0][i] << 16) |  (dest_pxls[1][i] << 8) |  (dest_pxls[2][i]),colorspace);
  }
  
  buffer.updatePixels();

  if (do_blend)
    buffer.blend(img, 0, 0, img.width, img.height, 0, 0, buffer.width, buffer.height, blend_mode);

  buffer.endDraw();
  image(buffer, 0, 0, width, height);
}

void mousePressed() {
  float omega = map(mouseX, 0, width, 0, 1);
  omega = map(sqrt(omega), 0, 1, min_omega, max_omega);
  float phase = map(mouseY, 0, height, 0, 1);
  phase = map(sq(phase), 0, 1, min_phase_mult, max_phase_mult);
  float max_phase = phase * omega;
  println("Carrier: 2PI * t * " + (omega/TWO_PI));
  println("Phase shift (max signal amplitude): " + max_phase);
}

void keyPressed() {
  // SPACE to save
  if (keyCode == 32) {
    String fn = foldername + filename + "/res_" + sessionid + hex((int)random(0xffff), 4)+"_"+filename+fileext;
    buffer.save(fn);
    println("Image "+ fn + " saved");
  }
  if(key == 'n') {
    negate = !negate;
  }
}

//

final static int[] blends = {
  ADD, SUBTRACT, DARKEST, LIGHTEST, DIFFERENCE, EXCLUSION, MULTIPLY, SCREEN, OVERLAY, HARD_LIGHT, SOFT_LIGHT, DODGE, BURN
};

class LowpassFilter {
  float alpha;
  float prev;

  public LowpassFilter(float rate, float hz) {
    alpha = 0.0;
    prev = 0.0;
    setFilter(rate, hz);
  }

  void setFilter(float rate, float hz) {
    float timeInterval = 1.0/rate;
    float tau = 1.0 / (hz * TWO_PI);
    alpha = timeInterval / (tau + timeInterval);
  }

  void resetFilter(float val) { 
    prev = val;
  }

  void resetFilter() { 
    resetFilter(0);
  }

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


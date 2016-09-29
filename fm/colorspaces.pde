final static int COLORSPACES = 16;

final static int OHTA = 0;
// RGB == 1; defined in processing
final static int CMY = 2;
// HSB == 3; defined in processing
final static int XYZ = 4;
final static int YXY = 5;
final static int HCL = 6;
final static int LUV = 7;
final static int LAB = 8;
final static int HWB = 9;
final static int RGGBG = 10;
final static int YPbPr = 11;
final static int YCbCr = 12;
final static int YDbDr = 13;
final static int GS = 14;
final static int YUV = 15;

// name
String getColorspaceName(int cs) {
  switch(cs) {
  case OHTA: 
    return "OHTA";
  case CMY: 
    return "CMY"; 
  case XYZ: 
    return "XYZ";
  case YXY: 
    return "YXY";
  case HCL: 
    return "HCL";
  case LUV: 
    return "LUV";
  case LAB: 
    return "LAB";
  case HWB: 
    return "HWB";  
  case HSB:
    return "HSB";
  case RGGBG:
    return "R-GGB-G";
  case YPbPr:
    return "YPbPr";
  case YCbCr:
    return "YCbCr";
  case YDbDr:
    return "YDbDr";
  case GS:
    return "Greyscale";
  case YUV:
    return "YUV";
  default: 
    return "RGB";
  }
}

// colorspace converters
color fromColorspace(color c, int cs) {
  switch(cs) {
  case OHTA: 
    return fromOHTA(c);
  case CMY: 
    return fromCMY(c); 
  case XYZ: 
    return fromXYZ(c);
  case YXY: 
    return fromYXY(c);
  case HCL: 
    return fromHCL(c);
  case LUV: 
    return fromLUV(c);
  case LAB: 
    return fromLAB(c);
  case HWB: 
    return fromHWB(c);
  case HSB:
    return fromHSB(c);
  case RGGBG:
    return fromRGGBG(c);
  case YPbPr:
    return fromYPbPr(c);
  case YCbCr:
    return fromYCbCr(c);
  case YDbDr:
    return fromYDbDr(c);
  case GS:
    return tofromGS(c);
  case YUV:
    return fromYUV(c);  
  default: 
    return c;
  }
}

color toColorspace(color c, int cs) {
  switch(cs) {
  case OHTA: 
    return toOHTA(c); 
  case CMY: 
    return toCMY(c);
  case XYZ: 
    return toXYZ(c);
  case YXY: 
    return toYXY(c);
  case HCL: 
    return toHCL(c);
  case LUV: 
    return toLUV(c);
  case LAB: 
    return toLAB(c);
  case HWB: 
    return toHWB(c);
  case HSB:
    return toHSB(c);
  case RGGBG:
    return toRGGBG(c);
  case YPbPr:
    return toYPbPr(c);
  case YCbCr:
    return toYCbCr(c);
  case YDbDr:
    return toYDbDr(c);
  case YUV:
    return toYUV(c);
  case GS:
    return tofromGS(c); 
  default: 
    return c;
  }
}

// Colorspace converters

final int getR(color c) { 
  return (c & 0xff0000) >> 16;
}
final int getG(color c) { 
  return (c & 0xff00) >> 8;
}
final int getB(color c) { 
  return c & 0xff;
}

final int getLuma(color c) { 
  return constrain((int)(0.2126*getR(c)+0.7152*getG(c)+0.0722*getB(c)), 0, 255);
}

int getChannel(color c, int ch) {
  switch(ch) {
  case 0 : 
    return getR(c);
  case 1 : 
    return getG(c);
  case 2 : 
    return getB(c);
  default: 
    return 0;
  }
}

// normalized versions
final float getNR(color c) { 
  return r255[(c & 0xff0000) >> 16];
}
final float getNG(color c) { 
  return r255[(c & 0xff00) >> 8];
}
final float getNB(color c) { 
  return r255[c & 0xff];
}
final float getNLuma(color c) { 
  return r255[getLuma(c)];
}

color blendRGB(color c, int r, int g, int b) {
  return (c & 0xff000000) | (constrain(r, 0, 255) << 16) |  (constrain(g, 0, 255) << 8 ) | constrain(b, 0, 255);
}

color blendRGB(color c, float r, float g, float b) {
  return blendRGB(c, (int)(r*255), (int)(g*255), (int)(b*255));
}

/**************
 * Greyscale
 **************/

color tofromGS(color c) {
  int l = getLuma(c);
  return blendRGB(c, l, l, l);
}

/**************
 * YUV
 **************/

final static float Umax = 0.436 * 255.0;
final static float Vmax = 0.615 * 255.0;

color toYUV(color c) {
  int R = getR(c);
  int G = getG(c);  
  int B = getB(c);
  
  int Y =  (int)(  0.299*R+0.587*G+0.114*B);
  int U = (int)map(-0.14713*R-0.28886*G+0.436*B,-Umax,Umax,0,255);
  int V = (int)map(0.615*R-0.51499*G-0.10001*B,-Vmax,Vmax,0,255);

  return blendRGB(c, Y, U, V);
}

color fromYUV(color c) {
  int Y = getR(c);  
  float U = map(getG(c),0,255,-Umax,Umax);
  float V = map(getB(c),0,255,-Vmax,Vmax);
  
  int R = (int)(Y + 1.13983*V);
  int G = (int)(Y - 0.39465*U - 0.58060*V);
  int B = (int)(Y + 2.03211*U);
  
  return blendRGB(c, R, G, B);
}

/**************
 * YDbDr
 **************/

color toYDbDr(color c) {
  int R = getR(c);
  int G = getG(c);  
  int B = getB(c);
  
  int Y =  (int)(  0.299*R+0.587*G+0.114*B);
  int Db = (int)(127.5+(-0.450*R-0.883*G+1.333*B)/2.666);
  int Dr = (int)(127.5+(-1.333*R+1.116*G+0.217*B)/2.666);

  return blendRGB(c, Y, Db, Dr);
}

color fromYDbDr(color c) {
  int Y = getR(c);  
  float Db = (getG(c)-127.5)*2.666;
  float Dr = (getB(c)-127.5)*2.666;
  
  int R = (int)(Y + 9.2303716147657e-05*Db-0.52591263066186533*Dr);
  int G = (int)(Y - 0.12913289889050927*Db+0.26789932820759876*Dr);
  int B = (int)(Y + 0.66467905997895482*Db-7.9202543533108e-05*Dr);
  
  return blendRGB(c, R, G, B);
}

/**************
 * YCbCr
 **************/

color toYCbCr(color c) {
  int R = getR(c);
  int G = getG(c);  
  int B = getB(c);
  
  int Y =  (int)( 0.2988390*R+0.5868110*G+0.1143500*B);
  int Cb = (int)(-0.168736*R-0.3312640*G+0.5000000*B+127.5);
  int Cr = (int)( 0.5000000*R-0.4186880*G-0.0813120*B+127.5);

  return blendRGB(c, Y, Cb, Cr);
}

color fromYCbCr(color c) {
  int Y = getR(c);  
  float Cb = getG(c) - 127.5;
  float Cr = getB(c) - 127.5;
  
  int R = (int)(Y + 1.402*Cr)+1; // some fix
  int G = (int)(Y-0.344136*Cb-0.714136*Cr);
  int B = (int)(Y+1.772000*Cb)+1; // some fix
  
  return blendRGB(c, R, G, B);
}

/**************
 * YPbPr
 **************/

color toYPbPr(color c) {
  int R = getR(c);  
  int B = getB(c);
  
  int Y = getLuma(c);
  int Pb = B - Y;
  int Pr = R - Y;
  if(Pb<0) Pb+=256;
  if(Pr<0) Pr+=256;
  return blendRGB(c, Y, Pb, Pr);
}

color fromYPbPr(color c) {
  int Y = getR(c);  
  int B = getG(c) + Y;
  int R = getB(c) + Y;
  if(R>255) R-=256;
  if(B>255) B-=256;
  
  int G = (int)((Y-0.2126*R-0.0722*B)/0.7152);
  
  return blendRGB(c, R, G, B);
}


/**************
 * R-G,G,B-G
 **************/

color toRGGBG(color c) {
  int G = getG(c);  
  int R = getR(c)-G;
  int B = getB(c)-G;
  if(R<0) R+=256;
  if(B<0) B+=256;
  return blendRGB(c, R, G, B);
}

color fromRGGBG(color c) {
  int G = getG(c);  
  int R = getR(c)+G;
  int B = getB(c)+G;
  if(R>255) R-=256;
  if(B>255) B-=256;
  return blendRGB(c, R, G, B);
}

/**************
 * HWB
 **************/

color toHSB(color c) {
  int R = getR(c);
  int G = getG(c);
  int B = getB(c);

  int _min = min(R, G, B);
  int _max = max(R, G, B);
  float delta = _max-_min;
  float saturation = delta/_max;
  float brightness = r255[_max];
  if (delta == 0.0) return blendRGB(c, 0.0, saturation, brightness);
  float hue = 0;
  if (R == _max) hue = (G-B)/delta;
  else if (G == _max) hue = 2.0 + (B-R)/delta;
  else hue = 4.0 + (R-G)/delta;
  hue /= 6.0;
  if (hue < 0.0) hue += 1.0;
  return blendRGB(c, hue, saturation, brightness);
}

color fromHSB(color c) {
  float S = getNG(c);
  float B = getNB(c);
  if (S == 0.0) return blendRGB(c, B, B, B); 

  float h = 6.0 * getNR(c);
  float f = h-floor(h);
  float p = B*(1.0-S);
  float q = B*(1.0-S*f);
  float t = B*(1.0-(S*(1.0-f))); 

  float r, g, b;
  switch((int)h) {
  case 1: 
    r=q; 
    g=B; 
    b=p; 
    break;
  case 2: 
    r=p; 
    g=B; 
    b=t; 
    break;
  case 3: 
    r=p; 
    g=q; 
    b=B; 
    break;
  case 4: 
    r=t; 
    g=p; 
    b=B; 
    break;
  case 5: 
    r=B; 
    g=p; 
    b=q; 
    break;
  default: 
    r=B; 
    g=t; 
    b=p; 
    break;
  }
  return blendRGB(c, r, g, b);
}



/**************
 * HWB
 **************/

color toHWB(color c) {
  int R = getR(c);
  int G = getG(c);
  int B = getB(c);

  int w = min(R, G, B);
  int v = max(R, G, B);

  int hue;
  if (v == w) hue = 255;
  else {
    float f = ((R == w) ? G-B : ((G == w) ? B-R : R-G));
    float p = (R == w) ? 3.0 : ((G == w) ? 5.0 : 1.0);
    hue = (int)map((p-f/(v-w))/6.0, 0, 1, 0, 254);
  }
  return blendRGB(c, hue, w, 255-v);
}

color fromHWB(color c) {
  int H = getR(c);
  int B = 255-getB(c);
  if (H == 255) return blendRGB(c, B, B, B);
  else {
    float hue = map(H, 0, 254, 0, 6);
    float v = r255[B];
    float whiteness = getNG(c);
    int i = (int)floor(hue);
    float f = hue-i;
    if ((i&0x01)!= 0) f=1.0-f;
    float n = whiteness+f*(v-whiteness);
    float r, g, b;
    switch(i) {
    case 1: 
      r=n; 
      g=v; 
      b=whiteness; 
      break;
    case 2: 
      r=whiteness; 
      g=v; 
      b=n; 
      break;
    case 3: 
      r=whiteness; 
      g=n; 
      b=v; 
      break;
    case 4: 
      r=n; 
      g=whiteness; 
      b=v; 
      break;
    case 5: 
      r=v; 
      g=whiteness; 
      b=n; 
      break;
    default: 
      r=v; 
      g=n; 
      b=whiteness; 
      break;
    }
    return blendRGB(c, r, g, b);
  }
}

/**************
 * Lab
 **************/

final static float D65X=0.950456;
final static float D65Y=1.0;
final static float D65Z=1.088754;
final static float CIEEpsilon=(216.0/24389.0);
final static float CIEK=(24389.0/27.0);
final static float CIEK2epsilon = CIEK * CIEEpsilon;
final static float D65FX_4 = 4.0*D65X/(D65X+15.0*D65Y+3.0*D65Z);
final static float D65FY_9 = 9.0*D65Y/(D65X+15.0*D65Y+3.0*D65Z);
final static float RANGE_X = 100.0 * (0.4124+0.3576+0.1805);
final static float RANGE_Y = 100.0;
final static float RANGE_Z = 100.0 * (0.0193+0.1192+0.9505);
final static float mepsilon = 1.0e-10;
final static float corrratio = 1.0/2.4;
final static float One_Third = 1.0/3.0;
final static float one_hsixteen = 1.0/116.0;

color toLAB(color c) {
  PVector xyz = _toXYZ(getNR(c), getNG(c), getNB(c));
  xyz.div(100.0);
  xyz.x /= D65X;
  xyz.y /= D65Y;
  xyz.z /= D65Z;
  float x, y, z;

  if (xyz.x > CIEEpsilon) {
    x = pow(xyz.x, One_Third);
  } else {
    x= (CIEK*xyz.x+16.0)*one_hsixteen;
  }

  if (xyz.y > CIEEpsilon) {
    y = pow(xyz.y, One_Third);
  } else {
    y = (CIEK*xyz.y+16.0)*one_hsixteen;
  }

  if (xyz.z > CIEEpsilon) {
    z = pow(xyz.z, One_Third);
  } else {
    z = (CIEK*xyz.z+16.0)*one_hsixteen;
  }

  float L = 255.0*(((116.0*y)-16.0)*0.01);
  float a = 255.0*(0.5*(x-y)+0.5);
  float b = 255.0*(0.5*(y-z)+0.5);

  return blendRGB(c, round(L), round(a), round(b));
}

color fromLAB(color c) {
  float L = 100*getNR(c);
  float a = getNG(c)-0.5;
  float b = getNB(c)-0.5;

  float y = (L+16.0)*one_hsixteen;
  float x = y+a;
  float z = y-b;

  float xxx=x*x*x;
  if (xxx>CIEEpsilon) {
    x = xxx;
  } else {
    x = (116.0*x-16.0)/CIEK;
  }

  float yyy=y*y*y;
  if (yyy>CIEEpsilon) {
    y = yyy;
  } else {
    y = L/CIEK;
  }

  float zzz=z*z*z;
  if (zzz>CIEEpsilon) {
    z = zzz;
  } else {
    z = (116.0*z-16.0)/CIEK;
  }

  return _fromXYZ(c, RANGE_X*x, RANGE_Y*y, RANGE_Z*z);
}

/**************
 * Luv
 **************/

final float PerceptibleReciprocal(float x) {
  float sgn = x < 0.0 ? -1.0 : 1.0;
  if ((sgn * x) >= mepsilon) return (1.0 / x);
  return (sgn/mepsilon);
} 

color toLUV(color c) {
  PVector xyz = _toXYZ(getNR(c), getNG(c), getNB(c));
  xyz.div(100.0);
  float d = xyz.y; // / D65Y;
  float L;
  if (d > CIEEpsilon) L = 116.0*pow(d, One_Third)-16.0;
  else L = CIEK * d;
  float alpha = PerceptibleReciprocal(xyz.x + 15.0 * xyz.y + 3.0 * xyz.z);
  float L13 = 13.0 * L;
  float u = L13 * ((4.0 * alpha * xyz.x)-D65FX_4);
  float v = L13 * ((9.0 * alpha * xyz.y)-D65FY_9);
  L /= 100.0;
  u=(u+134.0)/354.0;
  v=(v+140.0)/262.0;
  return blendRGB(c, round(L*255), round(u*255), round(v*255));
}

color fromLUV(color c) {
  float L = 100.0*getNR(c);
  float u = 354.0*getNG(c)-134.0;
  float v = 262.0*getNB(c)-140.0;
  float X, Y, Z;
  if (L > CIEK2epsilon) Y = pow((L+16.0)*one_hsixteen, 3.0);
  else Y = L/CIEK;
  float L13 = 13.0*L;
  float L52 = 52.0*L;
  float Y5 = 5.0*Y;
  float L13u = L52/(u+L13*D65FX_4);
  X=((Y*((39.0*L/(v+L13*D65FY_9))-5.0))+Y5)/((((L13u)-1.0)/3.0)+One_Third);
  Z=(X*(((L13u)-1.0)/3.0))-Y5;
  return _fromXYZ(c, 100*X, 100*Y, 100*Z);
}

/**************
 * HCL
 **************/

color toHCL(color c) {
  float r = getNR(c);
  float g = getNG(c);
  float b = getNB(c);
  float max = max(r, max(g, b));
  float chr = max - min(r, min(g, b));
  float h = 0.0;
  if ( chr != 0) {
    if (r == max) {
      h = ((g-b)/chr+6.0) % 6.0;
    } else if (g == max) {
      h = (b-r)/chr + 2.0;
    } else {
      h = (r-g)/chr + 4.0;
    }
  }
  return blendRGB(c, round((h/6.0)*255), round(chr*255), round(255*(0.298839*r+0.586811*g+0.114350*b)));
}

color fromHCL(color c) {
  float h = 6.0*getNR(c);
  float chr = getNG(c);
  float l = getNB(c);
  float x = chr*(1.0-abs((h%2.0)-1.0));
  float r = 0.0;
  float g = 0.0;
  float b = 0.0;
  if ((0.0 <= h) && (h < 1.0)) {
    r=chr;
    g=x;
  } else if ((1.0 <= h) && (h < 2.0)) {
    r=x;
    g=chr;
  } else if ((2.0 <= h) && (h < 3.0)) {
    g=chr;
    b=x;
  } else if ((3.0 <= h) && (h < 4.0)) {
    g=x;
    b=chr;
  } else if ((4.0 <= h) && (h < 5.0)) {
    r=x;
    b=chr;
  } else {//if ((5.0 <= h) && (h < 6.0)) {
    r=chr;
    b=x;
  }
  float m = l - (0.298839*r+0.586811*g+0.114350*b);
  return blendRGB(c, round(255*(r+m)), round(255*(g+m)), round(255*(b+m)));
}

/**************
 * Yxy
 **************/

color toYXY(color c) {
  PVector xyz = _toXYZ(getNR(c), getNG(c), getNB(c));
  float sum = xyz.x + xyz.y + xyz.z;
  float x = xyz.x > 0 ? xyz.x / sum : 0.0;
  float y = xyz.y > 0 ? xyz.y / sum : 0.0;
  return blendRGB(c, 
  (int)map(xyz.y, 0, RANGE_Y, 0, 255), 
  (int)map(x, 0.0, 1.0, 0, 255), 
  (int)map(y, 0.0, 1.0, 0, 255));
}

color fromYXY(color c) {
  float Y = map(getR(c), 0, 255, 0, RANGE_Y);
  float x = map(getG(c), 0, 255, 0, 1.0);
  float y = map(getB(c), 0, 255, 0, 1.0);
  float divy = Y / (y>0 ? y : 1.0e-6);

  return _fromXYZ(c, x * divy, Y, (1-x-y)*divy);
}

/**************
 * XYZ
 **************/

// FIXME: range from 0 to 1
float correctionxyz(float n) {
  return (n > 0.04045 ? pow((n + 0.055) / 1.055, 2.4) : n / 12.92) * 100.0;
}

PVector _toXYZ(float rr, float gg, float bb) {
  float r = correctionxyz(rr);
  float g = correctionxyz(gg);
  float b = correctionxyz(bb);
  return new PVector(r * 0.4124 + g * 0.3576 + b * 0.1805, 
  r * 0.2126 + g * 0.7152 + b * 0.0722, 
  r * 0.0193 + g * 0.1192 + b * 0.9505);
}

color toXYZ(color c) {
  PVector xyz = _toXYZ(getNR(c), getNG(c), getNB(c));
  return blendRGB(c, 
  (int)map(xyz.x, 0, RANGE_X, 0, 255), 
  (int)map(xyz.y, 0, RANGE_Y, 0, 255), 
  (int)map(xyz.z, 0, RANGE_Z, 0, 255));
}

float recorrectionxyz(float n) {
  return n > 0.0031308 ? 1.055 * pow(n, corrratio) - 0.055 : 12.92 * n;
}

// FIXME: range from 0 to 1
color _fromXYZ(color c, float xx, float yy, float zz) {
  float x = xx/100.0;
  float y = yy/100.0;
  float z = zz/100.0;

  int r = round(255.0*recorrectionxyz(x * 3.2406 + y * -1.5372 + z * -0.4986));
  int g = round(255.0*recorrectionxyz(x * -0.9689 + y * 1.8758 + z * 0.0415));
  int b = round(255.0*recorrectionxyz(x * 0.0557 + y * -0.2040 + z * 1.0570));

  return blendRGB(c, r, g, b);
}

color fromXYZ(color c) {
  float x = map(getR(c), 0, 255, 0, RANGE_X);
  float y = map(getG(c), 0, 255, 0, RANGE_Y);
  float z = map(getB(c), 0, 255, 0, RANGE_Z);

  return _fromXYZ(c, x, y, z);
}

/**************
 * CMY
 **************/

color toCMY(color c) {
  return blendRGB(c, 255-getR(c), 255-getG(c), 255-getB(c));
}

color fromCMY(color c) {
  return toCMY(c);
}

/**************
 * OHTA
 **************/

color fromOHTA(color c) {
  int I1 = getR(c);
  float I2 = map(getG(c), 0, 255, -127.5, 127.5);
  float I3 = map(getB(c), 0, 255, -127.5, 127.5);

  int R = (int)(I1+1.00000*I2-0.66668*I3);
  int G = (int)(I1+1.33333*I3);
  int B = (int)(I1-1.00000*I2-0.66668*I3);

  return blendRGB(c, R, G, B);
}

color toOHTA(color c) {
  int R = getR(c);
  int G = getG(c);
  int B = getB(c);

  int I1 = (int)(0.33333*R+0.33334*G+0.33333*B);
  int I2 = (int)map(0.5*(R-B), -127.5, 127.5, 0, 255);
  int I3 = (int)map(-0.25000*R+0.50000*G-0.25000*B, -127.5, 127.5, 0, 255);

  return blendRGB(c, I1, I2, I3);
}

////
// 1/n table for n=0..255 - to speed up color conversions things
final static float[] r255 = {
  0.0, 0.003921569, 0.007843138, 0.011764706, 0.015686275, 0.019607844, 0.023529412, 0.02745098, 0.03137255, 0.03529412, 0.039215688, 
  0.043137256, 0.047058824, 0.050980393, 0.05490196, 0.05882353, 0.0627451, 0.06666667, 0.07058824, 0.07450981, 0.078431375, 0.08235294, 
  0.08627451, 0.09019608, 0.09411765, 0.09803922, 0.101960786, 0.105882354, 0.10980392, 0.11372549, 0.11764706, 0.12156863, 0.1254902, 
  0.12941177, 0.13333334, 0.13725491, 0.14117648, 0.14509805, 0.14901961, 0.15294118, 0.15686275, 0.16078432, 0.16470589, 0.16862746, 
  0.17254902, 0.1764706, 0.18039216, 0.18431373, 0.1882353, 0.19215687, 0.19607843, 0.2, 0.20392157, 0.20784314, 0.21176471, 0.21568628, 
  0.21960784, 0.22352941, 0.22745098, 0.23137255, 0.23529412, 0.23921569, 0.24313726, 0.24705882, 0.2509804, 0.25490198, 0.25882354, 
  0.2627451, 0.26666668, 0.27058825, 0.27450982, 0.2784314, 0.28235295, 0.28627452, 0.2901961, 0.29411766, 0.29803923, 0.3019608, 0.30588236, 
  0.30980393, 0.3137255, 0.31764707, 0.32156864, 0.3254902, 0.32941177, 0.33333334, 0.3372549, 0.34117648, 0.34509805, 0.34901962, 0.3529412, 
  0.35686275, 0.36078432, 0.3647059, 0.36862746, 0.37254903, 0.3764706, 0.38039216, 0.38431373, 0.3882353, 0.39215687, 0.39607844, 0.4, 
  0.40392157, 0.40784314, 0.4117647, 0.41568628, 0.41960785, 0.42352942, 0.42745098, 0.43137255, 0.43529412, 0.4392157, 0.44313726, 
  0.44705883, 0.4509804, 0.45490196, 0.45882353, 0.4627451, 0.46666667, 0.47058824, 0.4745098, 0.47843137, 0.48235294, 0.4862745, 0.49019608, 
  0.49411765, 0.49803922, 0.5019608, 0.5058824, 0.50980395, 0.5137255, 0.5176471, 0.52156866, 0.5254902, 0.5294118, 0.53333336, 0.5372549, 
  0.5411765, 0.54509807, 0.54901963, 0.5529412, 0.5568628, 0.56078434, 0.5647059, 0.5686275, 0.57254905, 0.5764706, 0.5803922, 0.58431375, 
  0.5882353, 0.5921569, 0.59607846, 0.6, 0.6039216, 0.60784316, 0.6117647, 0.6156863, 0.61960787, 0.62352943, 0.627451, 0.6313726, 0.63529414, 
  0.6392157, 0.6431373, 0.64705884, 0.6509804, 0.654902, 0.65882355, 0.6627451, 0.6666667, 0.67058825, 0.6745098, 0.6784314, 0.68235296, 
  0.6862745, 0.6901961, 0.69411767, 0.69803923, 0.7019608, 0.7058824, 0.70980394, 0.7137255, 0.7176471, 0.72156864, 0.7254902, 0.7294118, 
  0.73333335, 0.7372549, 0.7411765, 0.74509805, 0.7490196, 0.7529412, 0.75686276, 0.7607843, 0.7647059, 0.76862746, 0.77254903, 0.7764706, 
  0.78039217, 0.78431374, 0.7882353, 0.7921569, 0.79607844, 0.8, 0.8039216, 0.80784315, 0.8117647, 0.8156863, 0.81960785, 0.8235294, 0.827451, 
  0.83137256, 0.8352941, 0.8392157, 0.84313726, 0.84705883, 0.8509804, 0.85490197, 0.85882354, 0.8627451, 0.8666667, 0.87058824, 0.8745098, 
  0.8784314, 0.88235295, 0.8862745, 0.8901961, 0.89411765, 0.8980392, 0.9019608, 0.90588236, 0.9098039, 0.9137255, 0.91764706, 0.92156863, 
  0.9254902, 0.92941177, 0.93333334, 0.9372549, 0.9411765, 0.94509804, 0.9490196, 0.9529412, 0.95686275, 0.9607843, 0.9647059, 0.96862745, 
  0.972549, 0.9764706, 0.98039216, 0.9843137, 0.9882353, 0.99215686, 0.99607843, 1.0
};

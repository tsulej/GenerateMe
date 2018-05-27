# GenerateMe
Processing scripts used to generative glitch / art / design

  * http://generateme.tumblr.com
  * https://github.com/Clojure2D/clojure2d

generateme.blog@gmail.com

clone recursively ```git clone --recursive https://github.com/tsulej/GenerateMe.git```

Detailed instructions inside scripts, examples included
All below works on latest Processing 2 only! For Processing 3 versions see bottom.

List:
  * decayscreen - decay image, based on XScreenSaver hack with the same name
  * drawing_generative - draw image using strokes based on channel value
  * drawing_strokes - draw image using lines (aka robot drawing)
  * fractalify - draw mandelbrot/julia fractals using channel data from image
  * imagelens - use image channel data to displace pixels. You can use different image as lens and to process.
  * mirrorimage - mirror parts of the image to other parts, 24 modes for rectangular (12 for squared) images
  * ntsc_analogtv - xanalogtv XScreenSaver hack ported to processing
  * slitscan - simulate errors during scanning (more digital way)
  * wzipprocess2 - recompress image using wzip method (Haar wavelet transformation)
  * imageslicer - few algorithms based on segmentation of the image
  * cutsort - cut image to lines of random length, sort (or not) and encode image, decode to get glitched result
  * distorter - another way to pixel displacement
  * lz77 - two script to compress/decompress image/binary with random glitch compressed data
  * median_filter - median filter with option to choose other points (not only median)
  * wrongqsort - cut image to lines/parts and use buggy QuickSort to sort pixels
  * wavelets - wavelet compression tool
  * pngglitch - corrupt PNG files (using hacked decoder)
  * ultimateSort - partly sort thresholded pixels with various algorithms
  * moire - random moire patterns generator / simulator
  * pix2line - convert pixels into lines snapped to noise grid
  * pixeldrifter - drift pixels using channel data
  * watmap - divide target image into regions and map with most matching part from source set
  * blendimages - blend source image set into target
  * threadraw - draw vertical threads based on image (similar to generative draw)
  * decompose_paint - decompose image into sqares/rectangles and fill it with some pattern
  * imsyntex - reconstruct image using texture synthesis algorithm
  * fm - frequency modulation and demodulation
  * composite_video_simulator - very precise VHS/Composite Video/Tape simulation, based on: https://github.com/joncampbell123/composite-video-simulator
  * Obj2Raw - convert OBJ vertex data to RAW 8 bit signed (for sonification purposes)
  * granularresynth - Granular (re)synthesis of any RAW using other RAWs for visual/audio
  * -> sonification - image sonification
  * -> GLIC - glitch image codec
  * TEMPLATE - clean template sketch with some predefined functions

## Processing 3

By https://github.com/romanrandom:

  * pixeldrifter
  * pngglitch
  * Obj2Raw
  
By https://github.com/philhudson91:
 
  * threadraw
  * ultimateSort
  * watmap
  * wavelets
  * wrongqsort
  * wzipprocess2

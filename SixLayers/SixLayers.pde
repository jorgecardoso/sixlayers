import processing.video.*;
import processing.opengl.*;

 /*******************
  * Constants
  *******************/

/*
 * The width and height of the high-resolution exported image.
 */
int HIGH_RES_HEIGHT = 5000;
int HIGH_RES_WIDTH = 5000;

/*
 * The maximum number of 'pixels' that are drawn to represent the picture.
 */
int MAX_PIXELS = 250*250;


float imgPercentToDraw = 1f;

/*
 * The size and origin of the pixel block to use.
 */
int blockOriginX = 0;
int blockOriginY = 0;
int blockWidth = 250;
int blockHeight = 250;

/*
 * The maximum z depth of the image
 */
float maxHeight = 100;

/*
 * The gradient colors
 */
color startColor = #000000;
color endColor = #ffffff;

/*
 * The background color
 */
color backgroundColor = #000000;


/*
 * The image that is going to tbe processed.
 */
PImage img;
Movie movie;

boolean isMovie = false;


/*
 * The stroke weight
 */
float strokeThickness = 1;



String elements[] = {"none", "two points", "four points", "two lines", "empty triangle", "empty square", "filled triangle", "filled square"};

int [] layers = {6, 6, 6, 6, 6, 6};

/*
 * Randomize elements if possible
 */
boolean []randomize = {true, true, true, true, true, true};

float []randomizeLevel = {10, 10, 10, 10, 10, 10};

/*
 * The zoom level
 */
float zoom = 2;

/*
 * The current rotation
 */
float rotX, rotY;




/*
 * How many pixels we skip
 */
int gridSeparation = 1;

/*
 * Whether to animate
 */
boolean animate =false;
long animationCurrentFrame = 0;
int animationNumKeyFrames = 10;
float animationDuration = 100; // frames
float animationRotationX[];
float animationRotationY[];
float animationHeight[];
float animationZoom[];
float animationImagePercenttoDraw[];
float animationBlockOriginX[];
float animationBlockOriginY[];
float animationStartColorRed[];
float animationStartColorGreen[];
float animationStartColorBlue[];
float animationStartColorAlpha[];
float animationEndColorRed[];
float animationEndColorGreen[];
float animationEndColorBlue[];
float animationEndColorAlpha[];

/*
 * Target animation position
 */
float targetX, targetY;

boolean doFill, doStroke=true;

boolean isBrightness=true;



//int skip  = 4;

boolean saveNow = false;
boolean saveNowHigh = false;
boolean saveFramebyFrame = false;


boolean isTriangle = false;


PGraphics oldGraphics;
int oldWidth, oldHeight;


float rX[];
float rY[];

/*
 * Indicates if we are recording the movie
 */
boolean recording;

/*
 * The MovieMaker object
 */
MovieMaker movieMaker;


String headsUpMessage = "";
long headsUpMessageStart;
long headsUpMessageDuration = 2000;

void setup() {
  size(1200, 800, OPENGL);
  oldWidth = width;
  oldHeight = height;
  frame.setResizable(true);

  img = loadImage("lamb.jpg");
  
 calculateGridSeparation();
 randomizePixels();
  
  //loadParametersFromLocalStorage();
  
  frameRate(30);
  //hint(ENABLE_OPENGL_4X_SMOOTH);
  //hint(ENABLE_OPENGL_2X_SMOOTH);
  //hint(ENABLE_DEPTH_TEST);
  hint(DISABLE_OPENGL_ERROR_REPORT);
  smooth();
  
  
  makeGui();
  
  animationRotationX = new float[animationNumKeyFrames];
  animationRotationY = new float[animationNumKeyFrames];
  animationHeight = new float[animationNumKeyFrames];
  animationZoom = new float[animationNumKeyFrames];
  animationImagePercenttoDraw  = new float[animationNumKeyFrames];
  animationBlockOriginX = new float[animationNumKeyFrames];
  animationBlockOriginY = new float[animationNumKeyFrames];
  animationStartColorRed = new float[animationNumKeyFrames];
  animationStartColorGreen = new float[animationNumKeyFrames];
  animationStartColorBlue = new float[animationNumKeyFrames];
  animationStartColorAlpha = new float[animationNumKeyFrames];
  
  animationEndColorRed = new float[animationNumKeyFrames];
  animationEndColorGreen = new float[animationNumKeyFrames];
  animationEndColorBlue = new float[animationNumKeyFrames];
  animationEndColorAlpha = new float[animationNumKeyFrames];

  clearKeyFrames(animationRotationX);
  clearKeyFrames(animationRotationY);
  clearKeyFrames(animationHeight);
  clearKeyFrames(animationZoom);
  clearKeyFrames(animationImagePercenttoDraw);
  clearKeyFrames(animationBlockOriginX);
  clearKeyFrames(animationBlockOriginY);
  clearKeyFrames(animationStartColorRed);
  clearKeyFrames(animationStartColorGreen);
  clearKeyFrames(animationStartColorBlue); 
  clearKeyFrames(animationStartColorAlpha);
  clearKeyFrames(animationEndColorRed);
  clearKeyFrames(animationEndColorGreen);
  clearKeyFrames(animationEndColorBlue);    
  clearKeyFrames(animationEndColorAlpha);  
  

}

void clearKeyFrames(float []keyFrameValues) {
  for (int i = 0; i < keyFrameValues.length; i++) {
    keyFrameValues[i] = -1;
  }
}



void resize(int w, int h)
{
  println(w + " " +h);
  //size(w,h);
  //frame.setSize(w,h);
}



void calculateGridSeparation() {
  int w, h;
  if (isMovie) {
    w = movie.width;
    h = movie.height;
  } else {
    w = img.width;
    h = img.height;
  }
  blockWidth = int(imgPercentToDraw*w);
  blockHeight = int(imgPercentToDraw*h);
  if (blockOriginX+blockWidth >= w) {
    
    blockOriginX = w-blockWidth;
  } 
  if (blockOriginY+blockHeight >=h) {
    blockOriginY = h-blockHeight;
  }
  
  gridSeparation = int(sqrt(blockWidth*blockHeight/MAX_PIXELS)+1);
 // println(blockWidth + " " + blockHeight + " " + gridSeparation);
}

void randomizePixels() {
  int l;
  if (isMovie) {
   l = movie.pixels.length;
  } else {
   l = img.pixels.length;
  }
  
   rX = new float[l];
  rY = new float[l];
 for (int i = 0; i < l; i++) {
    //int y = i/img.width;
    //int x = i%img.width;
    rX[i] = random(-1, 1); //int(constrain(x + random(-50, 50), 0, img.width-1));
    rY[i] = random(-1, 1); //int(constrain(y + random(-50, 50), 0, img.height-1));
  }
}

void animateProperties() {
   float [] r;
    r = getAnimationValue(animationCurrentFrame, animationRotationX);
    
    if (r[0] > 0) {
      rotX = r[1];
    }
    
    r = getAnimationValue(animationCurrentFrame, animationRotationY);
    if (r[0] > 0) {
      rotY = r[1];
    }
    
    r = getAnimationValue(animationCurrentFrame, animationHeight);
    if (r[0] > 0) {
      maxHeight = r[1];
    }
    
    r = getAnimationValue(animationCurrentFrame, animationZoom);
    if (r[0] > 0) {
      zoom = r[1];
    }
    
    r = getAnimationValue(animationCurrentFrame, animationImagePercenttoDraw);
    if (r[0] > 0) {
      imgPercentToDraw = r[1];
      calculateGridSeparation();
    }    
    //println("Image percent: " + imgPercentToDraw);
    
    r = getAnimationValue(animationCurrentFrame, animationBlockOriginX);
    if (r[0] > 0) {
      blockOriginX = floor(r[1]);
    }   
    //println("Block origin x: " + blockOriginX);
    r = getAnimationValue(animationCurrentFrame, animationBlockOriginY);
    if (r[0] > 0) {
      blockOriginY = floor(r[1]);
    }      
    //println("Block origin y: " + blockOriginY);
    
    float cr=0, cg=0, cb=0, ca=0;
    r = getAnimationValue(animationCurrentFrame, animationStartColorRed);
    if (r[0] > 0) {
      cr = int(r[1]);
    }      
    r = getAnimationValue(animationCurrentFrame, animationStartColorBlue);
    if (r[0] > 0) {
      cb = int(r[1]);
    }
    r = getAnimationValue(animationCurrentFrame, animationStartColorGreen);
    if (r[0] > 0) {
      cg = int(r[1]);
    }
    r = getAnimationValue(animationCurrentFrame, animationStartColorAlpha);
    if (r[0] > 0) {
      ca = int(r[1]);
    }
    startColor = color(cr, cg, cb, ca);    
    //println("Start color: " +startColor); 

    r = getAnimationValue(animationCurrentFrame, animationEndColorRed);
    if (r[0] > 0) {
      cr = int(r[1]);
    }      
    r = getAnimationValue(animationCurrentFrame, animationEndColorBlue);
    if (r[0] > 0) {
      cb = int(r[1]);
    }
    r = getAnimationValue(animationCurrentFrame, animationEndColorGreen);
    if (r[0] > 0) {
      cg = int(r[1]);
    }
    r = getAnimationValue(animationCurrentFrame, animationEndColorAlpha);
    if (r[0] > 0) {
      ca = int(r[1]);
    }
    endColor = color(cr, cg, cb, ca);
    //println("End color:" + endColor);
}

void saveAnimationProperties(int keyFrame) {
  animationRotationX[keyFrame] = rotX;
  animationRotationY[keyFrame] = rotY;
  animationHeight[keyFrame] = maxHeight;
  animationZoom[keyFrame] = zoom;
  animationImagePercenttoDraw[keyFrame] = imgPercentToDraw;
  animationBlockOriginX[keyFrame] = blockOriginX;
  animationBlockOriginY[keyFrame] = blockOriginY;
  animationStartColorRed[keyFrame] = red(startColor);
  animationStartColorGreen[keyFrame] = green(startColor);
  animationStartColorBlue[keyFrame] = blue(startColor);
  animationStartColorAlpha[keyFrame] = alpha(startColor);
  animationEndColorRed[keyFrame] = red(endColor);
  animationEndColorGreen[keyFrame] = green(endColor);
  animationEndColorBlue[keyFrame] = blue(endColor); 
  animationEndColorAlpha[keyFrame] = alpha(endColor); 
}


void loadAnimationProperties(int keyFrame) {
  rotX = animationRotationX[keyFrame];
  rotY = animationRotationY[keyFrame];
  maxHeight = animationHeight[keyFrame];
  zoom = animationZoom[keyFrame];
  imgPercentToDraw = animationImagePercenttoDraw[keyFrame];
  blockOriginX = int(animationBlockOriginX[keyFrame]);
  blockOriginY = int(animationBlockOriginY[keyFrame]);
  startColor=color(animationStartColorRed[keyFrame], animationStartColorGreen[keyFrame], animationStartColorBlue[keyFrame], animationStartColorAlpha[keyFrame]);
  endColor=color(animationEndColorRed[keyFrame], animationEndColorGreen[keyFrame], animationEndColorBlue[keyFrame], animationEndColorAlpha[keyFrame]); 
}

void resetAnimationProperties(int keyFrame) {
  animationRotationX[keyFrame] = -1;
  animationRotationY[keyFrame] = -1;
  animationHeight[keyFrame] = -1;
  animationZoom[keyFrame] = -1;
  animationImagePercenttoDraw[keyFrame] = -1;
  animationBlockOriginX[keyFrame] = -1;
  animationBlockOriginY[keyFrame] = -1;
  animationStartColorRed[keyFrame] = -1;
  animationStartColorGreen[keyFrame] = -1;
  animationStartColorBlue[keyFrame] = -1;
  animationStartColorAlpha[keyFrame] = -1;
  animationEndColorRed[keyFrame] = -1;
  animationEndColorGreen[keyFrame] = -1;
  animationEndColorBlue[keyFrame] = -1;
  animationEndColorAlpha[keyFrame] = -1;
}

 
float[] getAnimationValue(long animationCurrentFrame, float []keyFrameValues) {
  int keyFrameA = floor(map(animationCurrentFrame, 0, animationDuration-1, 0, animationNumKeyFrames-1));
  int i;
    for (i = keyFrameA; i >= 0; i--) {
      if (keyFrameValues[i] != -1) {
        keyFrameA = i;
        break;
      }
    }
    if (i < 0) {
      return new float[]{-1, 0};
    }
    
    int keyFrameB = keyFrameA + 1;
    for (i = keyFrameB; i < animationNumKeyFrames; i++) {
      if (keyFrameValues[i] != -1) {
        keyFrameB = i;
        break;
      }
    }
    
    if (i >= animationNumKeyFrames ) {
      return new float[]{-1, 0};
    }
    
    //int keyFrameB = ceil(map(currentMillis, 0, animationDuration, 0, animationNumKeyFrames));
    
    long keyFrameATime = (long)(map(keyFrameA, 0, animationNumKeyFrames-1, 0, animationDuration-1));
    long keyFrameBTime = (long)(map(keyFrameB, 0, animationNumKeyFrames-1, 0, animationDuration-1));
    println("KeyFrameA: " + keyFrameA + " time: " + keyFrameATime + " value:" + keyFrameValues[keyFrameA] + " KeyFrameB:" + keyFrameB + " time: " +keyFrameBTime + " value: " +keyFrameValues[keyFrameB] );
    return new float[] {1, lerp(keyFrameValues[keyFrameA], keyFrameValues[keyFrameB], map(animationCurrentFrame-keyFrameATime, 0, keyFrameBTime-keyFrameATime, 0, 1))};
    
}

synchronized void draw() { 
   long current = millis();
   
  
  checkLayers();
  colorMode(RGB);
  background(backgroundColor);
 
 
  if (animate) {

    if (animationCurrentFrame > animationDuration) {
      finishAnimation();
      return;
    } 
    println("Current frame: " + animationCurrentFrame);
   
    
    animateProperties();

    animationCurrentFrame++;
  }

  pushMatrix();
  translate(width/2, height/2);
  rotateY(rotY);
  rotateX(rotX);
  scale(zoom);
  
  drawLayers();
 

  popMatrix();
 
 
  if (saveNowHigh) {
    g.endDraw();
    g.save("screen-high-"+System.currentTimeMillis()+".png");
    g = oldGraphics;
    this.width = oldWidth;
    this.height = oldHeight;

    saveNowHigh = false;
    return;
  } else if (saveNow) {
    saveFrame();
    saveNow = false;
    
  } else if (recording) {
    movieMaker.addFrame();
    /*
     * Tell the user we are recording, so he/she does not forget
     */
    fill(255, 0, 0);
    text("RECORDING VIDEO", width/2, height/2);
  } else if (saveFramebyFrame) {
    
    saveFrame("frame-####.png");
    fill(255, 0, 0);
    text("RECORDING FRAMES", width/2, height/2);
  
  } else  if ( current - headsUpMessageStart < headsUpMessageDuration ) {
    pushStyle();
    fill(255, 0, 0);
    textSize(40);
    text(headsUpMessage, width/2-textWidth(headsUpMessage)/2, height/4);
    popStyle();
  } else {
    fill(255);
    textSize(14);
    text("FPS: " + frameRate, 10, 10);
  }
}





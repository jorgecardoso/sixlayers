import controlP5.*;

int TWO_POINTS = 0;
int FOUR_POINTS = 1;
int TWO_LINES = 2;
int EMPTY_TRIANGLE=3;
int EMTPY_SQUARE = 4;
int FILLED_TRIANGLE = 5;
int FILLED_SQUARE = 6;


ControlP5 controlP5;
ControlWindow controlWindow;

ListBox list1, list2, list3, list4, list5, list6;
Toggle toggleRandomize[];
Slider sliderRandomizeLevel[];
Slider sliderImgPercentToDraw, sliderMaxPixels;
Slider2D slider2DPosition;

controlP5.Button animateButton, exportAnimationVideoButton, exportAnimationFrameByFrame, screenShotButton, highDefScreenShotButton;

ColorPicker colorPickerBackgroundColor, colorPickerStartColor, colorPickerEndColor;

Timeline tl;

void makeGui() {
  controlP5 = new ControlP5(this);
  controlWindow = controlP5.addControlWindow("controlP5window",0,0,300,900)
                     .hideCoordinates()
                     .setBackground(color(40))
                     ;
  controlWindow.tab("default").setLabel("Parameters");
  
  controlP5.tab("Layers").moveTo(controlWindow);//.setLabel("Layers").moveTo(controlWindow);

  controlWindow.activateTab("default");
  
  /*
   * Layers
   */
  toggleRandomize = new Toggle[randomize.length];
  sliderRandomizeLevel = new Slider[randomize.length];
  
  int y = 50;
  int ytoggle = 10;
  int yslider = 30;
  int sep = 130;
  list1 = controlP5.addListBox("Layer 1",20,y,100,120).moveTo(controlP5.tab("Layers"));
  configureList(list1);
  toggleRandomize[0] = controlP5.addToggle("Randomize 1", randomize[0], 150, y-ytoggle, 10, 10).moveTo(controlP5.tab("Layers"));
  sliderRandomizeLevel[0] = controlP5.addSlider("Random amount 1", 0, 100, randomizeLevel[0], 150, y+yslider, 50, 10).moveTo(controlP5.tab("Layers"));
  
  y += sep;
  list2 = controlP5.addListBox("Layer 2",20,y,100,120).moveTo(controlP5.tab("Layers"));
  configureList(list2);
  toggleRandomize[1] = controlP5.addToggle("Randomize 2", randomize[1], 150, y-ytoggle, 10, 10).moveTo(controlP5.tab("Layers"));
  sliderRandomizeLevel[1] = controlP5.addSlider("Random amount 2", 0, 100, randomizeLevel[1], 150, y+yslider, 50, 10).moveTo(controlP5.tab("Layers"));
  
  y += sep;
  list3 = controlP5.addListBox("Layer 3",20,y,100,120).moveTo(controlP5.tab("Layers"));
  configureList(list3);
  toggleRandomize[2] = controlP5.addToggle("Randomize 3", randomize[2], 150, y-ytoggle, 10, 10).moveTo(controlP5.tab("Layers"));
  sliderRandomizeLevel[2] = controlP5.addSlider("Random amount 3", 0, 100, randomizeLevel[2], 150, y+yslider, 50, 10).moveTo(controlP5.tab("Layers"));

  y += sep;
  list4 = controlP5.addListBox("Layer 4",20,y,100,120).moveTo(controlP5.tab("Layers"));
  configureList(list4);
  toggleRandomize[3] = controlP5.addToggle("Randomize 4", randomize[3], 150, y-ytoggle, 10, 10).moveTo(controlP5.tab("Layers"));
  sliderRandomizeLevel[3] = controlP5.addSlider("Random amount 4", 0, 100, randomizeLevel[3], 150, y+yslider, 50, 10).moveTo(controlP5.tab("Layers"));
  
  y += sep;
  list5 = controlP5.addListBox("Layer 5",20,y,100,120).moveTo(controlP5.tab("Layers"));
  configureList(list5);
  toggleRandomize[4] = controlP5.addToggle("Randomize 5", randomize[4], 150, y-ytoggle, 10, 10).moveTo(controlP5.tab("Layers"));
  sliderRandomizeLevel[4] = controlP5.addSlider("Random amount 5", 0, 100, randomizeLevel[4], 150, y+yslider, 50, 10).moveTo(controlP5.tab("Layers"));
  
  y += sep;
  list6 = controlP5.addListBox("Layer 6", 20, y, 100, 120).moveTo(controlP5.tab("Layers"));
  configureList(list6);
  toggleRandomize[5] = controlP5.addToggle("randomize 6", randomize[5], 150, y-ytoggle, 10, 10).moveTo(controlP5.tab("Layers"));
  sliderRandomizeLevel[5] = controlP5.addSlider("Random amount 6", 0, 100, randomizeLevel[5], 150, y+yslider, 50, 10).moveTo(controlP5.tab("Layers"));
  
  
  
  
  controlP5.addSlider("zoom", 0.1, 10, 2, 20, 160, 200, 10).setWindow(controlWindow);
  controlP5.addSlider("maxHeight", -100, 100, 50, 20, 190, 200, 10).setWindow(controlWindow);
  
  sliderImgPercentToDraw = controlP5.addSlider("imgPercentToDraw", 0.1, 1, 1, 20, 220, 200, 10).moveTo(controlWindow);
  
  slider2DPosition = controlP5.addSlider2D("Image position")
         .setPosition(100,240)
         .setSize(100,100)
         .setArrayValue(new float[] {1, 1}).moveTo(controlWindow);
  
  sliderMaxPixels = controlP5.addSlider("MAX_PIXELS", 50*50,500*500, 250*250, 20, 390, 200, 10).moveTo(controlWindow);
   
  /*
   * Color pickers
   */
 
  controlP5.addTextlabel("Background color", "Background color", 20, 40).moveTo(controlWindow);
  colorPickerBackgroundColor = controlP5.addColorPicker("bg", 20, 50, 50, 100).setColorValue(0).moveTo(controlWindow);
 
  controlP5.addTextlabel("Start color", "Start color", 150, 40).moveTo(controlWindow);
  colorPickerStartColor = controlP5.addColorPicker("Start color picker", 150, 50, 50, 100).setColorValue(0).moveTo(controlWindow);
  
  controlP5.addTextlabel("End color", "End color", 220, 40).moveTo(controlWindow);
  colorPickerEndColor =  controlP5.addColorPicker("End color picker", 220, 50, 50, 100).setColorValue(color(255)).moveTo(controlWindow);
  
  
  
  
  
  /*
   * Animation
   */
 // controlP5.tab("Animation").moveTo(controlWindow);
  controlP5.addSlider("animationDuration", 30, 600, animationDuration, 20, 500, 200, 10).moveTo(controlWindow);
  
  controlP5.addTextlabel("Animation Keyframes", "Animation Keyframes", 20, 530).moveTo(controlWindow);
  tl= new Timeline(controlP5,"Timeline",0, 540, 299, 25, animationNumKeyFrames);
  controlP5.register(controlP5, "Timeline", tl);
  tl.moveTo(controlWindow);
  


  animateButton = controlP5.addButton("Test animation",0,20,570,80,19).moveTo(controlWindow);

  exportAnimationVideoButton = controlP5.addButton("Export anim as video",0,20,600,110,19).moveTo(controlWindow);
  exportAnimationFrameByFrame   = controlP5.addButton("Export anim frame by frame",0,150,600,140,19).moveTo(controlWindow);
  
  screenShotButton = controlP5.addButton("Screenshot",0,20,700,90,19).moveTo(controlWindow);
  highDefScreenShotButton = controlP5.addButton("High resolution screenshot",0,150,700,130,19).moveTo(controlWindow);
  
  
  controlP5.loadProperties();
}


synchronized void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(toggleRandomize[0])) {
    randomize[0] = toggleRandomize[0].getState();
  } else if (theEvent.isFrom(toggleRandomize[1])) {
    randomize[1] = toggleRandomize[1].getState();
  } else if (theEvent.isFrom(toggleRandomize[2])) {
    randomize[2] = toggleRandomize[2].getState();
  }else if (theEvent.isFrom(toggleRandomize[3])) {
    randomize[3] = toggleRandomize[3].getState();
  }else if (theEvent.isFrom(toggleRandomize[4])) {
    randomize[4] = toggleRandomize[4].getState();
  }else if (theEvent.isFrom(toggleRandomize[5])) {
    randomize[5] = toggleRandomize[5].getState();
  } else  if (theEvent.isFrom(sliderRandomizeLevel[0])) {
    randomizeLevel[0] = sliderRandomizeLevel[0].getValue();
  } else if (theEvent.isFrom(sliderRandomizeLevel[1])) {
    randomizeLevel[1] = sliderRandomizeLevel[1].getValue();
  } else if (theEvent.isFrom(sliderRandomizeLevel[2])) {
    randomizeLevel[2] = sliderRandomizeLevel[2].getValue();
  }else if (theEvent.isFrom(sliderRandomizeLevel[3])) {
    randomizeLevel[3] = sliderRandomizeLevel[3].getValue();
  }else if (theEvent.isFrom(sliderRandomizeLevel[4])) {
    randomizeLevel[4] = sliderRandomizeLevel[4].getValue();
  } else if (theEvent.isFrom(sliderRandomizeLevel[5])) {
    randomizeLevel[5] = sliderRandomizeLevel[5].getValue();
  } else if (theEvent.isFrom(sliderImgPercentToDraw)) {
    calculateGridSeparation();
  } else if (theEvent.isFrom(sliderMaxPixels)) {
    calculateGridSeparation();
  } else if (theEvent.isFrom(slider2DPosition)) {
   
    float x = slider2DPosition.arrayValue()[0]/100.0;
    float y = slider2DPosition.arrayValue()[1]/100.0;
    
    blockOriginX = int( (img.width-blockWidth)*x );
    blockOriginY = int( (img.height-blockHeight)*y );
    println(blockOriginX + " " + blockOriginY + " " + blockWidth + " " + blockHeight + " " + img.width + " " + img.height);
    println((blockOriginX+blockWidth) + " " + (blockOriginY+blockHeight));
  }  else if ( theEvent.isFrom(tl) ) {
    if ( tl.isDoubleClick() ) {
      saveAnimationProperties(tl.getLastClicked());
    } else if ( tl.getKeyFrame(tl.getLastClicked()) == false ) { //selected keyframe
      resetAnimationProperties(tl.getLastClicked());
    } else {
      loadAnimationProperties(tl.getLastClicked());
    } 
  } else if (theEvent.isFrom(animateButton) ) {
    
    if (!animate) {
      animationCurrentFrame = 0;
      animate = true;
      animateButton.setLabel("Cancel");
      
    } else {
      animate = false;
      animateButton.setLabel("Test animation");
    }
  
} else if ( theEvent.isFrom(exportAnimationVideoButton) ) {
    exportAnimationAsVideo();
  } else if ( theEvent.isFrom(exportAnimationFrameByFrame) ) {
    exportAnimationAsFrame();
  } else if ( theEvent.isFrom(screenShotButton) ) {
    saveNow = true;
    headsUpMessage = "Taking screenshot";
    headsUpMessageStart = millis();
  } else if ( theEvent.isFrom(highDefScreenShotButton) ) {
    headsUpMessage = "Taking high resolution screenshot";
    headsUpMessageStart = millis();
   
     oldGraphics = g;
   
    g = createGraphics(HIGH_RES_WIDTH, HIGH_RES_HEIGHT, P3D);
    g.smooth();
    this.height = HIGH_RES_HEIGHT;
    this.width = HIGH_RES_WIDTH;
    g.beginDraw();
    saveNowHigh = true;
  }
}


synchronized void  exportAnimationAsVideo() {
  println("Starting animation");
  animationCurrentFrame = 0;
  animate = true;
  recording = true;
  movieMaker = new MovieMaker(this, width, height, "sixlayers"+System.currentTimeMillis()+".mov",
                       30, MovieMaker.H263, MovieMaker.LOSSLESS);
  println(movieMaker);

}

synchronized void  exportAnimationAsFrame() {
  println("Starting animation");
  animationCurrentFrame = 0;
  animate = true;
  saveFramebyFrame = true;
}

void finishAnimation() {
  println("Animation finished.");
  animate = false;
  if (recording) {
    recording = false;
    movieMaker.finish(); 
  }
  if(saveFramebyFrame) {
    saveFramebyFrame = false;
  }
}

void configureList(ListBox dl) {
  for( int i=0; i<elements.length; i++ ) {
    dl.addItem(elements[i], i);
  }
  dl.setHeight(120);
  
}


void checkLayers() {
  layers[0] = int(list1.value());
  layers[1] = int(list2.value());
  layers[2] = int(list3.value());
  layers[3] = int(list4.value());
  layers[4] = int(list5.value());
  layers[5] = int(list6.value());
  
  backgroundColor = colorPickerBackgroundColor.getColorValue();
  startColor = colorPickerStartColor.getColorValue();
  endColor = colorPickerEndColor.getColorValue();
}


void exit() {
 controlP5.saveProperties();
 System.exit(1);
}

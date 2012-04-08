

/*
void imageLoaded() {
  img = loadImage(imageFromJavascript);
  
  icon = createImage(150, 150, RGB);
  
  // TODO: Resize image
  icon.updatePixels();
}*/

void mouseDragged() {
  if (mouseX > 200) {
    rotY += map(mouseX-pmouseX, 0, width, 0, TWO_PI);
    rotX += map(mouseY-pmouseY, 0, height, 0, TWO_PI);
  }
}

void keyPressed() {
  
  if (keyCode == UP) {
    zoom += 0.1;
  } 
  else if (keyCode ==DOWN) {
    zoom -= 0.1;
  } else if (key == 'a') {
    animationCurrentFrame = 0;
    animate = true;
    println("Animating...");
  } else if (key == 'h'){
    oldGraphics = g;
   
    g = createGraphics(HIGH_RES_WIDTH, HIGH_RES_HEIGHT, P3D);
    g.smooth();
    this.height = HIGH_RES_HEIGHT;
    this.width = HIGH_RES_WIDTH;
    g.beginDraw();
    
    saveNowHigh = true;
    
  } else if (key == 's') {
    saveNow = true;
  } else if (key == 'm') {
    recording = !recording;
    if (recording) {
      movieMaker = new MovieMaker(this, width, height, "sixlayers"+System.currentTimeMillis()+".mov",
                       30, MovieMaker.VIDEO, MovieMaker.LOSSLESS);
    } else {
      movieMaker.finish(); 
    }
  } else if (key == 'f') {
    saveFramebyFrame = !saveFramebyFrame;
    
  }
}





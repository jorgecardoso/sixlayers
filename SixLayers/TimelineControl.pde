
class Timeline extends controlP5.Controller {


  Timeline(ControlP5 theControlP5, String theName, int theX, int theY, int theWidth, int theHeight, int theSize) {
    // the super class Controller needs to be initialized with the below parameters
    super(theControlP5,  (Tab)(theControlP5.getTab("default")), theName, theX, theY, theWidth, theHeight);
    
    keyFrames = new boolean[theSize];
 
    for (int i = 0; i < keyFrames.length; i++) {
      keyFrames[i] = false;
    }
    
  }
  
  int lastClicked;
  
  boolean keyFrames[];
  
  boolean doubleClick;
  
  public boolean isDoubleClick() {
    return doubleClick;
  }
  
  public boolean getKeyFrame(int i) {
    return keyFrames[i];
  }
  
  public int getLastClicked() {
    return lastClicked;
  }
  
  void mousePressed() {
   
    int i = (int)map(getControlWindow().getPointer().getX(), 0, width, 0, keyFrames.length);
    doubleClick = false;
    if (getControlWindow().papplet().mouseEvent.getClickCount()==2) {
      doubleClick = true;
      keyFrames[i] = true;
       
    } else if (getControlWindow().papplet().mouseButton == RIGHT) {
         keyFrames[i] = false;
    } 
     
     
     lastClicked = i;
     broadcast(FLOAT);
  }
  

  void draw(PApplet theApplet) {
    theApplet.pushStyle();
    theApplet.pushMatrix();
    theApplet.translate(position().x, position().y);
    
    
    //println("sfs");
    theApplet.strokeWeight(1);
    theApplet.stroke(255);
    theApplet.noFill();
    theApplet.rect(0, 0, width, height);
    
    
    for (int i = 0; i < keyFrames.length; i++) {
      if ( keyFrames[i] ) {
        theApplet.fill(255, 0, 0);
      } else {
        theApplet.fill(100, 100, 100);
      }
      theApplet.rect(i*width/keyFrames.length, 0, width/keyFrames.length, height);
    }
    
   
    theApplet.popMatrix();
    theApplet.popStyle();
  }

  public Controller setValue(float theValue) {
    return this;
  }


}

// DRAG'N'DROP

import java.awt.dnd.*;
import java.awt.dnd.DropTargetListener;
import java.awt.datatransfer.*;
 

synchronized void loadFile(File file) {
  println("someone dropped " + file.getPath());
   
  // we check if the dropped "file" is a folder/directory
  if (file.isDirectory()) {
    println(file.getName() + " seems to be a directory... reading contents");
     
    // so, we can ask that directory for its contents... which will result in an array of File-Objects
    File[] folderContents = file.listFiles();
    println("this folder has " + folderContents.length + " files and/or folders in it:");
     
    for (int i=0; i<folderContents.length; i++) {
     println("|_ " + folderContents[i].getName());  

    }
     
  } else {
    if (file.getPath().endsWith("mov")) {
      movie = new Movie(this, file.getPath());
      movie.loop();
      movie.read();
      isMovie = true;
    } else {
      isMovie = false;
      img = loadImage(file.getPath());
    }
    calculateGridSeparation();
    randomizePixels();
    //img.add(new MetaImage(ref));

  }
   
} 

DropTarget dt = new DropTarget(this, new DropTargetListener() {
  public void dragEnter(DropTargetDragEvent event) {
    // debug messages for diagnostics
    //System.out.println("dragEnter " + event);
    event.acceptDrag(DnDConstants.ACTION_COPY);
  }
 
  public void dragExit(DropTargetEvent event) {
    //System.out.println("dragExit " + event);
  }
 
  public void dragOver(DropTargetDragEvent event) {
    //System.out.println("dragOver " + event);
    event.acceptDrag(DnDConstants.ACTION_COPY);
  }
 
  public void dropActionChanged(DropTargetDragEvent event) {
    //System.out.println("dropActionChanged " + event);
  }
 
  public void drop(DropTargetDropEvent event) {
    //System.out.println("drop " + event);
    event.acceptDrop(DnDConstants.ACTION_COPY);
 
    Transferable transferable = event.getTransferable();
    DataFlavor flavors[] = transferable.getTransferDataFlavors();
    int successful = 0;
 
    for (int i = 0; i < flavors.length; i++) {
 try {
   Object stuff = transferable.getTransferData(flavors[i]);
   if (!(stuff instanceof java.util.List)) continue;
   java.util.List list = (java.util.List) stuff;
 
   for (int j = 0; j < list.size(); j++) {
     Object item = list.get(j);
     if (item instanceof File) {
  File file = (File) item;
     
  // passing the whole file-object here
  loadFile(file);
     }
   }
 
 }  
 catch (Exception e) {
   e.printStackTrace();
 }
    }
  }
}
); 

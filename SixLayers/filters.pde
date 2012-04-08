

void drawLayers() {
  
  colorMode(RGB);
  strokeWeight(strokeThickness);
  translate(-blockOriginX-blockWidth/2, -blockOriginY-blockHeight/2, maxHeight/2);
  
    for (int y = blockOriginY; y < blockOriginY+blockHeight-gridSeparation; y += gridSeparation*2) {

      for (int x = blockOriginX; x <  blockOriginX+blockWidth-gridSeparation; x += gridSeparation*2) {
        int x1 = x;
        int y1 = y;
        int x2 = x + gridSeparation;
        int y2 = y;
        int x3 = x;
        int y3 = y + gridSeparation;
        int x4 = x2;
        int y4 = y3;
      //  int x4R = rX[y4*img.width+x4];
       // int y4R = rY[y4*img.width+x4];
       
        
       /* color c1 = img.pixels[y1*img.width+x1];
        color c2 = img.pixels[y2*img.width+x2];
        color c3 = img.pixels[y3*img.width+x3];
        color c4 = img.pixels[y4*img.width+x4];
        */
        /*if (randomize) {
           c4 = img.pixels[y4R*img.width+x4R];
          drawFour(c1, c2, c3, c4, x1, y1, x2, y2, x3, y3, x4R, y4R);
        } else {
          drawFour(c1, c2, c3, c4, x1, y1, x2, y2, x3, y3, x4, y4);
        }*/
         drawFour(x1, y1, x2, y2, x3, y3, x4, y4);
      }

    }
   
}

void drawLayerElement(int layerType, color c1, color c2, color c3, color c4,  float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4, float z) {
  noFill();

  switch (layerType) {
    case 0:
    break;
  case 1:
    stroke(c1);
    point(x1, y1, z);
    stroke(c3);
    point(x3, y3, z);
    break;
  case 2:
    stroke(c1);
    point(x1, y1, z);
    stroke(c2);
    point(x2, y2, z);
    stroke(c3);
    point(x3, y3, z);
    stroke(c4);
    point(x4, y4, z);
    break;
case 3:
    beginShape(LINES);
    stroke(c1);
    vertex(x1, y1, z);
    stroke(c3);
    vertex(x3, y3, z);
    endShape();
    
    beginShape(LINES);
    stroke(c2);
    vertex(x2, y2, z);
    stroke(c4);
    vertex(x4, y4, z);
    endShape();  
    break;
case 4:
    beginShape(TRIANGLES);
    stroke(c1);
    vertex(x1, y1, z);
    stroke(c2);
    vertex(x2, y2, z);
    stroke(c3);
    vertex(x3, y3, z);
    endShape(CLOSE);
    break;
case 5:
    beginShape(QUADS);
    stroke(c1);
    vertex(x1, y1, z);
    stroke(c2);
    vertex(x2, y2, z);
    stroke(c4);
    vertex(x4, y4, z);
    stroke(c3);
    vertex(x3, y3, z);
    endShape(CLOSE);
    break;
case 6:
    
    beginShape();
    stroke(c1);
    fill(c1);
    vertex(x1, y1, z);
    stroke(c2);
    fill(c2);
    vertex(x2, y2, z);
    stroke(c3);
    fill(c3);
    vertex(x3, y3, z);
    endShape(CLOSE);
    break;
case 7:
    
    beginShape();
    stroke(c1);
    fill(c1);
    vertex(x1, y1, z);
    stroke(c2);
    fill(c2);    
    vertex(x2, y2, z);
    stroke(c4);
    fill(c4);    
    vertex(x4, y4, z);
    stroke(c3);
    fill(c3);    
    vertex(x3, y3, z);
    endShape(CLOSE);
    break;
  }
  
}


void drawFour(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  color c1, c2, c3, c4;
  if (isMovie) {
    c1 = movie.pixels[int(y1*movie.width+x1)];
    c2 = movie.pixels[int(y2*movie.width+x2)];
    c3 = movie.pixels[int(y3*movie.width+x3)];
    c4 = movie.pixels[int(y4*movie.width+x4)];
  } else {
    c1 = img.pixels[int(y1*img.width+x1)];
    c2 = img.pixels[int(y2*img.width+x2)];
    c3 = img.pixels[int(y3*img.width+x3)];
    c4 = img.pixels[int(y4*img.width+x4)];
  }
   
   
  int b1 = int(brightness(c1));
  int b2 = int(brightness(c2));
  int b3 = int(brightness(c3));
  int b4 = int(brightness(c4));
  if (b1 == 0 || b2 == 0 || b3 == 0 || b4 == 0) return;
  
  float intensity = (b1 + b2 + b3 + b4)/4.0;
  
  
  

  float rS = red(startColor);
  float gS = green(startColor);
  float bS = blue(startColor);
  float rE = red(endColor);
  float gE = green(endColor);
  float bE = blue(endColor);
  float aS = alpha(startColor);
  float aE = alpha(endColor);
  
  float b = intensity;
  c1 = color(int(map(b, 0, 255, rS, rE)),
             int(map(b, 0, 255, gS, gE)),
             int(map(b, 0, 255, bS, bE)),
             int(map(b, 0, 255, aS, aE)));
  b = brightness(c2);
  c2 = color(int(map(b, 0, 255, rS, rE)),
             int(map(b, 0, 255, gS, gE)),
             int(map(b, 0, 255, bS, bE)),
             int(map(b, 0, 255, aS, aE)));
 b = brightness(c3);
  c3 = color(int(map(b, 0, 255, rS, rE)),
             int(map(b, 0, 255, gS, gE)),
             int(map(b, 0, 255, bS, bE)),
             int(map(b, 0, 255, aS, aE)));
 b = brightness(c4);
  c4 = color(int(map(b, 0, 255, rS, rE)),
             int(map(b, 0, 255, gS, gE)),
             int(map(b, 0, 255, bS, bE)),
             int(map(b, 0, 255, aS, aE)));
        

  
  float z = map(intensity, 0, 100,  0, maxHeight);



  strokeWeight(1);
  
  float sum = 0;
  float inc = 255.0/(layers.length-1);
  for (int i = 0; i < layers.length; i++) {
    sum += inc;
    
    if (intensity < sum) {
      if (randomize[i]) {
        int x1R, y1R;
        color c1R;
        if (isMovie) {
           x1R = int(constrain(rX[int(y1*movie.width+x1)]*randomizeLevel[i]+x1, 0, movie.width-1));
           y1R = int(constrain(rY[int(y1*movie.width+x1)]*randomizeLevel[i]+y1, 0, movie.height-1));
           c1R = movie.pixels[int(y1R*movie.width+x1R)];
        } else {
           x1R = int(constrain(rX[int(y1*img.width+x1)]*randomizeLevel[i]+x1, 0, img.width-1));
           y1R = int(constrain(rY[int(y1*img.width+x1)]*randomizeLevel[i]+y1, 0, img.height-1));
           c1R = img.pixels[int(y1R*img.width+x1R)];
        }
         b = brightness(c1R);
        c1R = color(int(map(b, 0, 255, rS, rE)),
             int(map(b, 0, 255, gS, gE)),
             int(map(b, 0, 255, bS, bE)));
        drawLayerElement(layers[i], c1R, c2, c3, c4, x1R, y1R, x2, y2, x3, y3, x4, y4, z); 
      } else {
        drawLayerElement(layers[i], c1, c2, c3, c4, x1, y1, x2, y2, x3, y3, x4, y4, z); 
      }
      break;
    }
  }
  
}




void setup(){
   size(640,480); 
}

float step = TWO_PI;
void draw(){
  background(255);
  
  step = TWO_PI*0.1;
  float R = 1/1.683*height;
  noFill();
  stroke(255,120);
  //ellipse(width/2,height/2,R*1.03,R*1.03);
  pushMatrix();
  translate(width/2,height/2);
  rotate(radians(0));
  beginShape();
  int c = 3 ;
  for(float f = 0 ; f < TWO_PI; f += step){
    float y = sin(f)*R/2.0;
    float x = cos(f)*R/2.0;
    float y1 = sin(f)*R/1.8;
    float x1 = cos(f)*R/1.8;
    vertex(x,y);
    text(c++,x1,y1);
  }
  endShape(CLOSE);
  rotate(radians(36*millis()/1000.0));
  line(0,0,R/2,0);
  popMatrix();
  
  //saveFrame("frames/#####.tga");
  
}

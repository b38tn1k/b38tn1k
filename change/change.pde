void setup(){
  size(720,720);
  //noFill();
  strokeWeight(2);
  smooth();
  rectMode(CENTER);
}
void draw(){
  background(255);
  morph_shape(float(mouseX)/width);
  noStroke();
}
 
void morph_shape(float amt){
  background(lerpColor(#43DDE2, #ECF87F, amt*amt));
  fill(lerpColor(#F50CA0,#59981A,amt));
  rect(width/2,height/2, 200+100*amt, 200+100*amt,300*amt);
}

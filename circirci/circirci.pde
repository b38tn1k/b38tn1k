int colors[] = {#EBB858, #EEA8C1, #D0CBC3, #87B6C4, #EA4140, #5A5787, #D0CBC3, #87B6C4, #EA4140, #5A5787};

int rcol() {
  return colors[int(random(colors.length))];
};

void keyPressed() {
  if (key == 's') {
    saveImage(); 
  } else {
    generate();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  println(timestamp);
  saveFrame(timestamp+".png");
}

void setup() {
  size(720, 720);
  smooth(8);
  generate();
}

void generate() {
  background(rcol());
  noStroke();
  int oldColor = rcol();
  int newColor = rcol();
  int lerpCol;
  for (float rad = width; rad>0; rad-=1){
    if(rad % 10 == 0){
      oldColor = newColor;
      newColor = rcol();
    }
    lerpCol = lerpColor(oldColor,newColor, (rad % 30)/31.0);
    fill(lerpCol);
    circle(width/4, height/4, rad);
    circle(3*width/4, height/4, rad);
    lerpCol = lerpColor(newColor,oldColor, (rad % 30)/31.0);
    circle(width/4, 3*height/4, rad);
    circle(3*width/4, 3*height/4, rad);
    circle(width/2, height/2, rad);
  }
}

void draw(){}

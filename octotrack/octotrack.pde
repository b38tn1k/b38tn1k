int colors[] = {#EBB858, #EEA8C1, #D0CBC3, #87B6C4, #EA4140, #5A5787, #D0CBC3, #87B6C4, #EA4140, #5A5787};

int rcol() {
  return colors[int(random(colors.length))];
};

float d = 50;
float h = 0;
float x, y;

void keyPressed() {
  if (key == 'i') {
    saveImage(); 
  } else if (key == 'w'){
    d++;
  }  else if (key == 's'){
    d--;
  }  else if (key == 'a'){
    h+=0.1;
  }  else if (key == 'd'){
    h-=0.1;
  }
  
  if(d < 10) {d=10;}
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  println(timestamp);
  saveFrame(timestamp+".png");
}

void setup(){
  smooth(8);
  size(540, 540);
  pixelDensity(2);
}

void draw() {
  float dd = d; 
  background(0);
  //center of cartesian regular octagon
  fill(colors[0]);
  circle(mouseX, mouseY, 20);
  for (float i = 0.5; i <=1.5; i+= 0.5) {
    dd = d * i;
    //1
    fill(#FF0000);
    y = dd * sin(0 + h) + mouseY;
    x = dd * cos(0 + h) + mouseX;
    circle(x, y, 10);
    //2
    fill(#FFFFFF);
    y = dd * sin((QUARTER_PI) + h) + mouseY;
    x = dd * cos((QUARTER_PI) + h) + mouseX;
    circle(x, y, 10);
    //3
    y = dd * sin(HALF_PI + h) + mouseY;
    x = dd * cos(HALF_PI + h) + mouseX;
    circle(x, y, 10);
    //4
    y = dd * sin((QUARTER_PI) - h) + mouseY;
    x = -1*dd * cos((QUARTER_PI) - h) + mouseX;
    circle(x, y, 10);
    //5
    y = -1* dd * sin(0 + h) + mouseY;
    x = -1*dd * cos(0 + h) + mouseX;
    circle(x, y, 10);
    //6
    y = -1*dd * sin((QUARTER_PI) + h) + mouseY;
    x = -1*dd * cos((QUARTER_PI) + h) + mouseX;
    circle(x, y, 10);
    //7
    y = -1 * dd * sin(HALF_PI + h) + mouseY;
    x = -1 * dd * cos(HALF_PI + h) + mouseX;
    circle(x, y, 10);
    //8
    y = -1*dd * sin((QUARTER_PI) - h) + mouseY;
    x = dd * cos((QUARTER_PI) - h) + mouseX;
    circle(x, y, 10); 
  }
}

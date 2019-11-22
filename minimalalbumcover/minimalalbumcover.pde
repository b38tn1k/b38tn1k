int myColor = 40;

void generate() {
  PFont font = createFont("OCRAStd.otf", 150);
  textFont(font);
  textAlign(LEFT, TOP);
  clear();
  lights();
  fill(myColor);
  background(myColor);
  for (int i = 0; i < 20; i++) {
    noStroke();
    pushMatrix();
    translate(random(width), random(height), -1*random(1500,3000));
    rotateY(random(3.14));
    rotateX(random(3.14));
    box(random(100, 1500));
    popMatrix();
  }
  for (int i = 0; i < 10; i++) {
    noStroke();
    pushMatrix();
    translate(random(width), random(height), -1*random(800,1500));
    rotateY(random(3.14));
    rotateX(random(3.14));
    box(random(100, 800));
    popMatrix();
  }
    //spotLight(255, 255, 255, width/2, height/2, 0, 0.5, 0.5, 0, PI/2, 100);
    pushMatrix();
    rotateY(random(0.3));
    rotateX(random(0.3));
    fill(100, 255, 200);
    text("B38TN1K\nDMCA / 2ndVar13ty", random(-100, width-500), random(300, height- 50) - 200, 0);
    popMatrix();
    saveImage();
}

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
  size(3000, 3000, P3D); 
  generate();
}

void draw(){
}

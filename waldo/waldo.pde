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

PImage photo, maskImage;
void setup() {
  size(720, 720, P3D);
  smooth(8);
  photo = loadImage("waldo.png");
  maskImage = loadImage("waldomask.png");
  photo.mask(maskImage);
  generate();
  imageMode(CENTER);
}

void generate() {
}

int k = 0;
void draw(){
  photo.resize(int(photo.width*1.2), int(photo.height*1.2));
  image(photo, width/2, height/2);
}

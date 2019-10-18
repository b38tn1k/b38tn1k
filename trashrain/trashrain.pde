//img myi = new img(30, 30, 1.0, 0.0, 0.2);
int colors[] = {#F6511D, #FFB400, #00A6ED, #E56399, #FFFFFF};
int rcol() {
  return colors[int(random(colors.length))];
};

img[] imgs;
int count = 1;
PImage bg;
PImage fg;
PImage she;

int shex;
int shey;


void setup() {
  size(1280, 720, P3D);
  smooth(8);
  she = loadImage("she.png");
  float sc = 1.5;
  she.resize(int(she.width*sc), int(she.height*sc));
  shex = width/2 - she.width/2;
  shey = height/2 - she.height/2;
  bg = loadImage("bg2.jpg");
  bg.resize(5000, 5000);
  imgs = new img[count];
  float x = width/count;
  PImage mask = loadImage("mask.png");
  for (int i = 0; i < count; i++) {
    imgs[i] = new img(x, random(height), 0, 10, 0.2);
    x+=width/count;
    PImage photo = loadImage("img.png");
    photo.mask(mask);
    imgs[i].getImage(photo);
  }
  saveFrame();
  
}

float counter = 0.0;
float distance = -500;
float bgcounter = -501;

void draw() {
  counter += 0.1;
  pushMatrix();
  translate(width/2 - bg.width/2, height/2 - bg.height/2, bgcounter);
  bgcounter-=1;
  image(bg, 0, 0);
  popMatrix();
  
  for (int i = 0; i < 1000; i++) {
    stroke(rcol());
    point(int(random(width)), int(random(height)));
  }
  
  if (distance < -300) { distance+=0.5;}
  
  pushMatrix();
  translate(shex, shey, distance);
  image(she, 0, 0);
  popMatrix();
  imgs[0].update();
  saveFrame();
}

class img { 
  float ypos, xpos, xspeed, yspeed, scale;
  PImage i;
  
  img (float x, float y, float xs, float ys, float sc) {
    ypos = y; 
    xpos = x;
    xspeed = xs;
    yspeed = ys;
    scale = sc;
    
  } 
  
  void getImage(PImage _img) {
    i = _img;
    i.resize(int(scale*i.width), int(scale * i.height));
  }
  void update() {
    
    xpos = width/2 - i.width/2;
    ypos = height/2 - i.height/2;
    pushMatrix();
    translate(width/2 - (i.width/2)*cos(xspeed), ypos);
    rotateY(xspeed);
    
    image(i, 0, 0);
    translate(xpos, ypos);
    popMatrix();
    xspeed+=0.005;
    
  }
} 

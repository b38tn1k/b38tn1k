//img myi = new img(30, 30, 1.0, 0.0, 0.2);

img[] imgs;
int count = 30;
PImage bg;
PImage fg;
PImage she;

int shex;
int shey;

void setup() {
  size(1280, 720, P3D);
  smooth(8);
  imgs = new img[count];
  float x = width/count;
  for (int i = 0; i < count; i++) {
    imgs[i] = new img(x, random(height), 0, -1*random(5, 10), 0.1);
    x+=width/count;
    imgs[i].getImage(loadImage("img.png"));
  }
  bg = loadImage("bg.jpg");
  fg = loadImage("fg.png");
  she = loadImage("stock_statue_by_candy_lace_stock_d3bj81a.png");
  float sc = 0.8;
  she.resize(int(she.width*sc), int(she.height*sc));
  shex = width/2 - she.width/2;
  shey = height;
}

void draw() {
  background(bg);
  for (int i = 0; i < count; i++) {
    imgs[i].update();
  }
  image(she, shex, shey);
  shey -= 1;
  image(fg, 0, 0);
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
    ypos += yspeed; 
    if (ypos < -1*i.height) { 
      ypos = height + i.height;
      xpos = random(width);
    }
    
    xpos += xspeed; 
    if (xpos > width) { 
      xpos = -1*i.width; 
    }
    pushMatrix();
    rotateX(-PI/8);
    image(i,xpos,ypos);
    popMatrix();
  }
} 

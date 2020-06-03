//int colors[] = {#EBB858, #EEA8C1, #D0CBC3, #87B6C4, #EA4140, #5A5787, #D0CBC3, #87B6C4, #EA4140, #5A5787};
//int colors[] = {#EBB858, #000000, #EEA8C1}; //#888888};
int colors[] = {#87B6C4, #EA4140, #000000}; //good one
//int colors[] = {#ff71ce, #01cdfe, #05ffa1, #b967ff, #fffb96}; //vapor
//int colors[] = {#000000, #FFFFFF, #b967ff, #fffb96};
//int colors[] = {#000000, #FFFFFF, #05ffa1, #b967ff};
//int colors[] = {#87B6C4, #EA4140, #000000, #FFFFFF}; //good one

int rcol() {
  return colors[int(random(colors.length))];
  //return(int(random(#000000, #FFFFFF)));
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
  size(3000, 3000);
  smooth(8);
  pixelDensity(2);
  generate();
}

void option0(PGraphics pg) {
  pg.background(rcol());
}

void option1(PGraphics pg) {
  pg.background(rcol());
  pg.fill(rcol());
  pg.strokeWeight(random(2, 50));
  pg.stroke(rcol());
  pg.circle(random(pg.width),random(pg.width), random(pg.width)); 
}

void option2(PGraphics pg) {
  pg.background(rcol());
  int x =  int(random(pg.width));
  int y =  int(random(pg.width));
  float dim = random(pg.width/4, pg.width);
  float scale = random(0.9);
  pg.rectMode(CENTER);
  while(dim > pg.width/10) {
    pg.fill(rcol());
    pg.strokeWeight(random(2, 50));
    pg.stroke(rcol());
    pg.square(x, y, dim);
    dim = dim * scale;
  }
}

void option3(PGraphics pg) {
  pg.background(rcol());
  int x =  int(random(pg.width));
  int y =  int(random(pg.width));
  float dim = random(pg.width/4, pg.width);
  float scale = random(0.9);
  pg.rectMode(CENTER);
  while(dim > pg.width/10) {
    pg.fill(rcol());
    pg.strokeWeight(random(2, 50));
    pg.stroke(rcol());
    pg.circle(x, y, dim);
    dim = dim * scale;
  }
}

void option4(PGraphics pg) {
  pg.background(rcol());
  pg.fill(rcol());
  pg.strokeWeight(random(2, 50));
  pg.stroke(rcol());
  pg.square(random(pg.width),random(pg.width), random(pg.width)); 
}

void option5(PGraphics pg) {
  pg.background(rcol());
  for (int i = 0; i < int(random(20)); i ++) {
    pg.strokeWeight(random(2, 50));
    pg.stroke(rcol());
    pg.line(random(pg.width), 0,random(pg.width), pg.height); 
  }
  for (int i = 0; i < int(random(10)); i ++) {
    pg.strokeWeight(random(2, 50));
    pg.stroke(rcol());
    pg.line(0, random(pg.height),pg.width, random(pg.height)); 
  }
}

void option6(PGraphics pg) {
  pg.rotate(PI/4);
  pg.background(rcol());
  pg.fill(rcol());
  pg.strokeWeight(random(2, 50));
  pg.stroke(rcol());
  pg.square(random(pg.width),random(pg.width), random(pg.width)); 
}

void option7(PGraphics pg) {
  pg.rotate(PI/4);
  pg.background(rcol());
  int x =  int(random(pg.width));
  int y =  int(random(pg.width));
  float dim = random(pg.width/4, pg.width);
  float scale = random(0.9);
  pg.rectMode(CENTER);
  while(dim > pg.width/10) {
    pg.fill(rcol());
    pg.strokeWeight(random(2, 50));
    pg.stroke(rcol());
    pg.square(x, y, dim);
    dim = dim * scale;
  }
}

void option8(PGraphics pg) {
  pg.background(rcol());
  int count = int(random(2, 10));
  pg.fill(rcol());
  //pg.noStroke();
  pg.strokeWeight(random(2, 10));
  pg.stroke(rcol());
  float x = pg.width/count;
  float y = (pg.height/count)/2;
  float radius = random(x);
  float space = x;
  x = x/2;
  for (int i = 0; i < count * count; i++) {
    pg.circle(x, y, radius);
    if (i % count ==0 && i!= 0){
      x = space/2;
      y+=space;
    } else {
      x+= space;
    }
  }
  pg.circle(x, y, radius);
}

void generate() {
  int count = int(random(1, 20));
  count = 7;
  //count = 16;
  PGraphics bg;
  background(rcol());
  bg = createGraphics(width-100, height-100);
  bg.beginDraw();
  PGraphics pg;
  int dim = int(bg.width/count);
  int x = 0;
  int y = 0;
  for (int j = 0; j<count*count; j++) {
    pg = createGraphics(dim, dim);
    pg.beginDraw();
    switch(int(random(8))) {
      case 0:
        option0(pg);
        break;
      case 1:
        option1(pg);
        break;
      case 2:
        option2(pg);
        break;
      case 3:
        option3(pg);
        break;
      case 4:
        option4(pg);
        break;
      case 5:
        option5(pg);
        break;
      case 6:
        option6(pg);
        break;
      case 7:
        option7(pg);
        break;
      case 8:
        option8(pg);
        break;
    }
    pg.endDraw();
    bg.image(pg, x, y);
    if (j%count == 0 && j!= 0){
      x = 0;
      y+=dim;
    } else {
      x += dim;
    }
  }
  bg.endDraw();
  image(bg, 50, 50);
}

void draw(){
  generate();
  saveImage();
}

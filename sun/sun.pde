int colors[] = {#EBB858, #EEA8C1, #D0CBC3, #87B6C4, #EA4140, #5A5787};//, #D0CBC3, #87B6C4, #EA4140, #5A5787};
int rcol() {
  return colors[int(random(colors.length))];
};

boolean coin() {
  return random(1) > .5;
}

int randint(int x) {
  return int(random(x));
}

int _size;
float x1;
float y1;
int _dia;

void setup() {
  _size = 1080;
  _dia = 400;
  size(1080, 1080, P3D);
  smooth(8);
  pixelDensity(2);
  background(255);
  x1 = _size/2;
  y1 = _size/2;
}

void draw() {
  strokeWeight(randint(5));
  float x = random(_size);
  float y = random(_size);
  if (y > _size/2) {
    stroke(colors[0]);
    if (y1 > _size/2) {
      stroke(colors[1]);
    }
  } else {
    if (y1 < _size/2) {
      stroke(colors[2]);
    } else {
      stroke(colors[3]);
    }
  }
  //float x1 = random(_size);
  //float y1 = random(_size);
  if ((linePass(_size / 2, _size / 2, x, y, x1, y1, _dia) == true)) {
    line(x, y, x1, y1);
    x1 = x;
    y1 = y;
    fill(255, 255, 255, randint(10));
    //stroke(0, 0, 0, 0);
    //rect(0, 0, width, height);
  }
}
void keyPressed() {
  if (key == 's') saveImage();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

boolean linePass(float targetx, float targety, float x, float y, float x1, float y1, float threshold) {
  float radius = sqrt((targetx - x)*(targetx - x) + (targety - y)*(targety - y));
  if (radius < threshold) {
    return true;
  }
  return false;
}

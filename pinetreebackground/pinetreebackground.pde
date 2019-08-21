void setup() {
  noStroke();
  size(1080, 1080);
}

int step = 5;

void tree(float x, float y, float w, float h, int c1, int c2) {
  x = x - w/2 * step;
  y = y - h/2 * step;
  for (int j = 0; j < h; j++) {
    int watp = int(sin((j/h)*2.5) * w);
    int watps = int((w - watp));
    for (int i = watps; i < watp; i++) {
      int col = lerpColor(c1, c2, j/h);
      fill(col);
      float _x = x + i * step;
      float _y = y + j * step;
      rect(_x, _y, step, step);
    }
  }
}

void draw() {
  tree(height/2, width/2, 60, 150, #23abee, #fa9b45); 
}

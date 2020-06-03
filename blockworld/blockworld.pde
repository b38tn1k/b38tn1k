int cols, rows;
int scl = 40;
int w = 32;
int h = 32;
float[][] terrain;
float res = 0.05;
float amp = 5;

void generate(){
  float yoff = random(-1000, 1000);
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
      for (int x = 0; x < cols; x++) {
        terrain[x][y] = int(map(noise(xoff, yoff), 0, 1, 0, amp));
        xoff += res;
      }
      yoff += res;
  }
}

void setup() {
    smooth(8);
    size(720, 720, P3D);
    generate();
    terrain = new float[cols][rows];
}

void draw() {
  
  background(0);
  translate(width/2,height);
  rotateX(PI/3);
  translate(-w/2, -h/2);
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      float level = terrain[x][y];
      while (level > 0) {
        
        level--;
      }
    }
  }

  
}

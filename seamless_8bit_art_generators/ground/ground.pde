int colors[] = { #0D0D0D, #343434, #69450F, #A14111, #BB3F11, #BB2C38, #E73876, #A635A6, #DF46E2, #FC7DAC, #FBA076, #FAB265, #FBD99E, #EAF494, #C6F393, #CCCDCE, #D6D4D3, #F6DCC6, #FBE4C5, #F6D1E8, #FACCFD, #E1CBFC, #CBCFFC, #B7E6FB, #C1F1E5, #FDFAFD, #FFFFFF, #F59CFC, #A99AFA, #85ADFA, #4FBFF8, #13DEF7, #12D7E6, #139AF7, #138FF7, #1855F7, #1544CD, #5552CC, #7971F9, #969696, #6F6F6F, #0F5070, #118EA5, #11B270, #11B21D, #11BF1E, #108A19, #107D17, #0F6E16, #BA8711, #E7852F, #F96B13, #F8B013, #D5F02D, #71D87E, #6FF2BC};

int rcol() {
  return colors[int(random(colors.length))];
};

boolean coin() {
  return random(1) > .5;
}

int randint(int x) {
  return int(random(x));
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

void generate() {
  randomSeed(millis());
  int canvas[][] = new int[width][height];
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      canvas[x][y] = #117d16;
    }
  }
  int tileSize = 32;
  int tile[][] = new int[tileSize][tileSize];
  
  canvas = noiseLerp(canvas, 0.05, 1, #A14111);
  
  tile = randomTile(tileSize, tile, 50, #117d16);
  canvas = applyTile(tile, canvas, tileSize);
  tile = randomTile(tileSize, tile, 10, #106e16);
  canvas = applyTile(tile, canvas, tileSize);
  tile = randomTile(tileSize, tile, 5, #10b21e);
  canvas = applyTile(tile, canvas, tileSize);
  tile = randomTile(tileSize, tile, 2, #b98711);
  canvas = applyTile(tile, canvas, tileSize);
  
  
  
  canvas = lerpTop(canvas, #000000);
  
  
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      stroke(canvas[x][y]);
      point(x, y);
    }
  }
}

int[][] noiseLerp(int[][]canvas, float res, float impact, int target) {
  float xoff = 0;
  float yoff = 0;
  float val = 0;
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      if (x > 100) {
        val = noise(xoff, yoff) * impact;
      } else {
        float blend = x/100;
        
        val = ((1.0 - blend) * noise(xoff, yoff)  + (blend) * noise(width+x, y))* impact;
      }
      canvas[x][y] = lerpColor(canvas[x][y], target, val);
      yoff = y * res;
    }
    xoff = x * res;
  }
  return canvas;
}

int[][] lerpTop(int[][]canvas, int target) {
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < 32; y++) {
      float val = y / 32.0;
      canvas[x][y] = lerpColor(target, canvas[x][y], val);
    }
  }
  return canvas;
}

int[][] applyTile(int[][] tile, int[][] canvas, int tileSize) {
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      if ((tile[x%tileSize][y%tileSize]) != 0) {
        canvas[x][y] = tile[x%tileSize][y%tileSize];
      }
    }
  }
  return canvas;
}

int[][] randomTile(int tileSize, int[][] tile, float density, int value){
  // clear out tile
  for (int x = 0; x < tileSize; x++) {
    for (int y = 0; y < tileSize; y++) {
      tile[x][y] = 0;
    }
  }
  density = density / 100.0;
  int occurance = int(density * (tileSize * tileSize));
  for (int i = 0; i < occurance; i++) {
    tile[randint(tileSize)][randint(tileSize)] = value;
  }
   
  return tile;
}

void setup() {
  size(1080, 256);
  noSmooth();
  pixelDensity(1);
  background(#0F6E16);
  generate();
}

void draw() {
}

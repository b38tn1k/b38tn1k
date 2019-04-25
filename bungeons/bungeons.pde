Room room;

void setup() {
  background(255);
  size(720, 720, P3D);
  room = new Room(null);
  for (int i = 0; i < 50; i++) {
    room.report();
    room.render();
    room = new Room (room);
  }
}

void draw() {
  
}

void keyPressed() {
  if (key == 's') saveImage();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

boolean randomBool() {
  return random(1) > .5;
}

public class Room {
  public int x;
  public int y;
  public int w;
  public int h;
  public Room child;
  public Room parent;
  
  Room (Room parent) {
    if (parent == null) {
      x = 0;
      y = 0;
      w = width;
      h = height;
      child = null;
    } else {
      parent.child = this;
      this.parent = parent;
      if (randomBool() == true) {
        x = parent.x;
        w = parent.w;
        h = int(random(parent.h));
        y = parent.y + h;
      } else {
        y = parent.y;
        h = parent.h;
        w = int(random(parent.w));
        x = parent.x + w;
      } 
    }
  }
  
  void report() {
    print(y);
    print(" ");
    print(x);
    print(" ");
    print(w);
    print(" ");
    print(h);
    print(" ");
    print('\n');
  }
  
  void render() {
    fill(255, 255, 0);
    rect(this.x - 1, this.y - 1, this.w - 1 , this.h - 1);
    fill(0, 255, 255);
    line(this.x, this.y, this.x + this.w, this.y + this.h);
  }
}

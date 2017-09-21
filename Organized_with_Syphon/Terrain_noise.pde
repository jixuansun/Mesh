class Terrain_noise {

  int cols, rows;
  int scl = 30;
  int w = 2000;
  int h = 4000;

  float flying = 0;
  float speed = 10;

  float[][] terrain;


  Terrain_noise() {
    cols = w / scl;
    rows = h/ scl;
    terrain = new float[cols][rows];
  }

  void display() {
    background(0);
    //stroke(255);
    strokeWeight(3);
    noFill();

    //translate(width/2, height/2-150);
    //rotateX(PI);
    rotateX(noise(PI/2, PI));
    translate(-w/2, -h/2);
    for (int y = 0; y < rows-1; y++) {
      beginShape(TRIANGLE_STRIP);
      for (int x = 0; x < cols; x++) {
        vertex(x*scl, y*scl, terrain[x][y]);
        vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
      }
      endShape();
    }
  }

  void update() {
    flying -= 0.05;
    speed += 0.2;

    float yoff = flying;
    for (int y = 0; y < rows; y++) {
      float xoff = flying;
      for (int x = 0; x < cols; x++) {
        terrain[x][y] = map(noise(xoff, yoff), 0, 1, -speed, speed);
        xoff += 0.2;
      }
      yoff += 0.2;
    }

    if (speed>100) {
      speed -= 0.2;
    }
  }
}
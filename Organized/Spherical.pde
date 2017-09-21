class Spherical {
  PVector[][]globe;
  int total;
  float radius;

  Spherical() {
    total = 25;
    radius = 200;
    globe = new PVector[total+1][total+1];
  }

  void display() {

    background(0);
    fill(0);

    for (int i =0; i<total+1; i++) {
      float lat = map(i, 0, total, -HALF_PI, HALF_PI);
      for (int j = 0; j<total+1; j++) {
        float lon = map(j, 0, total, -PI, PI);
        float x = radius*sin(lon)*cos(lat);
        float y = radius*sin(lon)*sin(lat);
        float z = radius*cos(lon);
        globe[i][j] = new PVector(x, y, z);

        PVector v = PVector.random3D();
        v.mult(2);
        globe[i][j].add(v);
      }
    }
  }


  void update() {
    for (int i =0; i < total; i++) {

      beginShape(TRIANGLE_STRIP);
      for (int j = 0; j<total + 1; j++) {
        PVector v1 =globe[i][j];
        //stroke(255);
        strokeWeight(3);
        vertex(v1.x, v1.y, v1.z);
        PVector v2 = globe[i+1][j];
        vertex(v2.x, v2.y, v2.z);
      }
      endShape();
    }
  }
}
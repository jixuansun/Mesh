class Lorenz_attractor {

  float x, y, z ;
  float a, b, c ;

  Lorenz_attractor() {
    x = 0.01;
    y = 0;
    z = 0;

    a = 10;
    b = 28;
    c = 8.0/3.0;
  }

  ArrayList<PVector> points = new ArrayList<PVector>();

  void display() {
    
    background(0);
    float dt = 0.01;
    float dx = (a * (y - x))*dt;
    float dy = (x * (b - z) - y)*dt;
    float dz = (x * y - c * z)*dt;
    
    x = x + dx;
    y = y + dy;
    z = z + dz;

    points.add(new PVector(x, y, z));

    translate(0, 0, -80);
    //translate(width/2, height/2);
    scale(5);
    //stroke(255);
    noFill();
  }


  void update() {
    beginShape();
    strokeWeight(1);
    for (PVector v : points) {
      vertex(v.x, v.y, v.z);
    }
    endShape();
  }
}
class Bezier_patch {

  float NS;
  float SIZE;
  float AMP ;
  Mesh3D mesh;
  boolean isWireframe=true;

  Bezier_patch() {
    NS = 0.05f;
    SIZE = 1000;
    AMP = SIZE*10;
  }

  void display() {
    updateMesh();
    background(0);
    //translate(width / 2, height / 2, 0);

    if (isWireframe) {
      noFill();
      //stroke(255);
      strokeWeight(3);
    } else {
      fill(255);
      noStroke();
      lights();
    }
    gfx.mesh(mesh, !isWireframe);
  }

  void updateMesh() {
    float phase=frameCount*NS*0.05;
    BezierPatch patch = new BezierPatch();
    for (int y = 0; y < 4; y++) {
      for (int x = 0; x < 4; x++) {
        float xx = x * SIZE*.5;
        float yy = y * SIZE*.5;
        float zz = (float) (SimplexNoise.noise(xx * NS, yy * NS, phase) * AMP)/5.;
        patch.set(x, y, new Vec3D(xx + zz/2, yy + zz/2, zz));
      }
    }
    mesh=patch.toMesh(!mousePressed ? 32 : 10);
    mesh.center(null);
  }
}
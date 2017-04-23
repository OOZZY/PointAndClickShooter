class Star {
  float x, y, size; // position, size

  Star() {
    // set random position/size
    x    = random(width);
    y    = random(height);
    size = random(5);
  }

  void draw() {
    pushMatrix();
    translate(x, y);
    noStroke();
    fill(255); // white
    ellipse(0, 0, size, size);
    popMatrix();
  }
}


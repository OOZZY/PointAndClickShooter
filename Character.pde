class Character {
  float   x, y;   // position
  float   vx, vy; // velocity
  boolean captured  = false;
  int     countDown = 60;

  Character(float x, float y) {
    // set position
    this.x = x;
    this.y = y;

    // set velocity with random values between -1 and 1
    vx = random(-1, 1);
    vy = random(-1, 1);
  }

  void update() {
    if (!captured) {
      // update position
      x += vx;
      y += vy;

      // when character leaves edge of screen, make it reappear on opposite side
      // of screen
      if (x > width)  { x = 0; }
      if (y > height) { y = 0; }
      if (x < 0) { x = width; }
      if (y < 0) { y = height; }
    } else {
      --countDown;
    }
  }

  void draw() {
    pushMatrix();
    translate(x, y);

    // tip
    stroke(0);
    strokeWeight(2);
    line(0, 0, 0, -100);

    // thrusters
    if (!captured) {
      fill(255, 255, 0);
    } else {
      fill(127);
    }
    ellipse(0, 80, 15, 40);
    ellipse(-64, 60, 12, 40);
    ellipse(64, 60, 12, 40);

    // wing rect
    if (!captured) {
      fill(150, 150, 255);
    } else {
      fill(127);
    }
    rectMode(CENTER);
    rect(45, 50, 60, 10);
    rect(-45, 50, 60, 10);

    // wing quad
    if (!captured) {
      fill(255, 200, 200);
    } else {
      fill(127);
    }
    quad(-75, 55, -75, -20, -65, 30, -50, 55);
    quad(75, 55, 75, -20, 65, 30, 50, 55);

    // tail
    triangle(-25, 95, 0, 0, 25, 25);
    triangle(25, 95, 0, 0, -25, 25);

    // body
    if (!captured) {
      fill(200, 200, 255);
    } else {
      fill(127);
    }
    ellipse(0, -10, 75, 140);

    // center line
    line(0, -30, 0, 60);

    // front viewport
    if (!captured) {
      fill(100);
    } else {
      fill(127);
    }
    quad(-25, -40, -10, -70, 10, -70, 25, -40);

    // viewports
    if (!captured) {
      fill(200);
    } else {
      fill(127);
    }
    ellipse(-20, -10, 15, 15);
    ellipse(-18, 10, 15, 15);
    ellipse(-14, 30, 15, 15);
    ellipse(20, -10, 15, 15);
    ellipse(18, 10, 15, 15);
    ellipse(14, 30, 15, 15);
    popMatrix();
  }

  float   leftEdge()   { return x - 75; }
  float   rightEdge()  { return x + 75; }
  float   topEdge()    { return y - 100; }
  float   bottomEdge() { return y + 100; }
  boolean captured()   { return this.captured; }
  int     countDown()  { return this.countDown; }
  void    capture()    { captured = true; }

  void drawHitbox() {
    pushMatrix();
    translate(x, y);
    stroke(255);
    strokeWeight(1);
    noFill();
    rect(0, 0, rightEdge() - leftEdge(), bottomEdge() - topEdge());
    popMatrix();
  }

  boolean colliding(float x, float y) {
    if (!captured && x > leftEdge() && x < rightEdge() &&
                     y > topEdge() && y < bottomEdge()) {
      return true;
    }
    return false;
  }
}


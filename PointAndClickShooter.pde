final int NUM_STARS      = 200;
final int MAX_CHARACTERS = 10;
int score      = 0;
int shotsFired = 0;
Star[] stars;
ArrayList<Character> characters;

void drawCrosshair(float x, float y) {
  pushMatrix();
  translate(x, y);

  stroke(0, 255, 0);     // green
  noFill();
  ellipse(0, 0, 20, 20);
  line(0, -20, 0, 20);   // vertical line
  line(-20, 0, 20, 0);   // horizontal line

  fill(255, 0, 0);       // red
  ellipse(0, 0, 10, 10); // center dot

  popMatrix();
}

void drawShot(float x, float y) {
  pushMatrix();
  translate(x, y);

  stroke(255, 0, 0);      // red
  strokeWeight(5);
  line(-20, -20, 20, 20); // top-left to bottom-right
  line(-20, 20, 20, -20); // bottom-left to top-right

  popMatrix();
}

void setup() {
  size(600, 600);
  background(0);
  noCursor();

  // initialize stars
  stars = new Star[NUM_STARS];
  for (int i = 0; i < stars.length; ++i) {
    stars[i] = new Star();
  }

  // initialize ArrayList
  characters = new ArrayList<Character>();
}

void draw() {
  background(0);

  for (int i = 0; i < stars.length; ++i) {
    stars[i].draw();
  }

  // if 60 frames (1 second) passed and characters.size() < MAX_CHARACTERS
  if (frameCount % 60 == 0 && characters.size() < MAX_CHARACTERS) {
    // initialize and store new character
    characters.add(new Character(random(width), random(height)));
  }

  for (int i = 0; i < characters.size(); ++i) {
    Character character = characters.get(i);
    if (character.captured() && character.countDown() <= 0) {
      // remove character
      characters.remove(character);
    } else {
      // move and draw character
      character.update();
      character.draw();
      //character.drawHitbox(); // uncomment to see hitbox
    }
  }

  drawCrosshair(mouseX, mouseY);
  fill(0, 255, 0);
  text("Score: " + score, 10, 20);                    // display score
  text("# Characters: " + characters.size(), 10, 40); // display # characters
  text("# Shots fired: " + shotsFired, 10, 60);       // display # shots fired
  // display accuracy
  if (shotsFired == 0) { // prevent divide by 0
    text("Accuracy: ?", 10, 80);
  } else {
    text("Accuracy: " + ((float)score/10)/shotsFired*100 + "%", 10, 80);
  }
  text("Frame rate: " + frameRate, 10, 100);          // display frame rate
  // display time elapsed
  text("Time elapsed (s): " + (float)frameCount / 60, 10, 120);
}

void mouseClicked() {
  drawShot(mouseX, mouseY);
  ++shotsFired;

  // on mouseclick, capture characters under the mouse
  for (int i = 0; i < characters.size(); ++i) {
    Character character = characters.get(i);
    if (character.colliding(mouseX, mouseY)) {
      character.capture();
      score += 10; // update score
    }
  }
}


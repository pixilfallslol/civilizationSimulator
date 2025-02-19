final int W_W = 1280;
final int W_H = 720;
final color BG_COLOR = color(66, 135, 245);

float rotX, rotY, camX, camY, camZ;
boolean moveCam = false; // Kinda broken lol.
int[] pCoor = {W_W/2, W_H/2, W_W/5, 2};
color pColor = color(random(0, 255));
int personCount = 2;
int scale = 120;

Person person1 = new Person("Johnny", 1, pCoor[0], pCoor[1], 50, pColor);
Person person2 = new Person("Alice", 1, pCoor[2], pCoor[3], 50, pColor);

PFont font;

void setup() {
  font = loadFont("ComicSansMS-48.vlw");
  size(1280, 720, P3D);
}

void draw() {
  background(BG_COLOR);
  noStroke();
  lights();
  
  cameraMovement();
  //drawGround();
  drawPerson();
}

void cameraMovement() {
  if (moveCam) {
    translate(camX, camY, camZ);
    translate(width/2.0-camX, height/2.0-camY);
    rotateY(rotY);
    rotateX(rotX);
    translate(-(width/2.0-camX), -(height/2.0-camY));
  }
}

void drawPerson() {
  person1.display();
  person2.display();
}

void drawGround() {
  color darker = color(102, 240, 84);
  
  fill(darker);
  translate(100, 100, 0);
  box(1280, 720, 0);
}

void mouseDragged() {
  if (moveCam) {
    rotX += (mouseX - pmouseX)*0.01;
    rotY += (mouseY - pmouseY)*0.01;
  }
}

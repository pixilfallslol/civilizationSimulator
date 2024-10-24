import com.hamoid.*;
VideoExport videoExport;

String VIDEO_FILE_NAME = "video_file.mp4";
boolean SAVE_VIDEO = false;
int PLAY_SPEED = 1;

int W_W = 1373;
int W_H = 720;

int populationCount = 0;
float scale = 0;
int frames = 0;
float t = 0;

float circleX;
float circleY;
float circleX2;
float circleY2;
float RANK_INTERP = 0.1;
int time = 0;

PFont font;

Axon axon1;
Axon axon2;

float interpolate(float current_value, float target_value, float interp_rate) {
  return current_value * (1 - interp_rate) + target_value * interp_rate;
}

void setup() {
  font = createFont("Jygquip 1.ttf", 128);
  size(1373, 720);
  circleX = random(width);
  circleY = random(height);
  circleX2 = random(width);
  circleY2 = random(height);

  axon1 = new Axon(random(1), random(0.1));
  axon2 = new Axon(random(1), random(0.1));

  if (SAVE_VIDEO) {
    videoExport = new VideoExport(this, VIDEO_FILE_NAME);
    videoExport.setFrameRate(60);
    videoExport.startMovie();
  }
}

void draw() {
  background(#33CCFF);
  if (millis() > time) {
    time = millis() + 15000;
    mutateAxons();
  }

  if (t < 1) {
    t += 0.02;
  }

  drawGround();
  firstPerson();
  newPopulation();
  drawCount();
  displayAxons();

  frames += PLAY_SPEED;

  if (SAVE_VIDEO) {
    videoExport.saveFrame();
  }
}

void drawCount() {
  textAlign(CORNER);
  textFont(font);
  textSize(100);
  fill(255);
  text("POPULATION COUNT: ", 849.55, 100.45);
  text(populationCount, 1328.1, 60.05);
}

void drawGround() {
  noStroke();
  fill(#00CC00);
  rect(0, 0, width, height);
}

void firstPerson() {
  scale = 0.5 * (1 - cos(PI * t));
  float currentWidth = 97.9 * scale;
  float currentHeight = 95.8 * scale;

  circleX = interpolate(circleX, axon1.getNextX(circleX), RANK_INTERP);
  circleY = interpolate(circleY, axon1.getNextY(circleY), RANK_INTERP);
  
  strokeWeight(2);
  stroke(0);
  fill(#CCCCCC);
  ellipse(circleX, circleY, currentWidth, currentHeight);
  
  populationCount = 1;
}

void newPopulation() {
  scale = 0.5 * (1 - cos(PI * t));
  float currentWidth2 = 97.9 * scale;
  float currentHeight2 = 95.8 * scale;

  circleX2 = interpolate(circleX2, axon2.getNextX(circleX2), RANK_INTERP);
  circleY2 = interpolate(circleY2, axon2.getNextY(circleY2), RANK_INTERP);
  
  strokeWeight(2);
  stroke(0);
  fill(#CCCCCC);
  ellipse(circleX2, circleY2, currentWidth2, currentHeight2);
  
  populationCount++;
}

void displayAxons() {
  strokeWeight(2);
  
  float axon1EndX = 50 * axon1.weight; 
  float axon1EndY = 50 * axon1.weight;
  stroke(255, 0, 0);
  line(circleX, circleY, circleX + axon1EndX, circleY + axon1EndY);
  
  float axon2EndX = 50 * axon2.weight;
  float axon2EndY = 50 * axon2.weight;
  stroke(0, 0, 255);
  line(circleX2, circleY2, circleX2 + axon2EndX, circleY2 + axon2EndY);
}

void mutateAxons() {
  axon1 = axon1.mutateAxon();
  axon2 = axon2.mutateAxon();
}

class Axon {
  final float MUTABILITY_MUTABILITY = 0.7f;
  final int mutatePower = 9;
  final float MUTATE_MULTI;

  float weight;
  float mutability;

  public Axon(float w, float m) {
    weight = w;
    mutability = m;
    MUTATE_MULTI = (float) Math.pow(0.5, mutatePower);
  }

  public float getNextX(float currentX) {
    return currentX + (weight * pmRan());
  }

  public float getNextY(float currentY) {
    return currentY + (weight * pmRan());
  }

  public Axon mutateAxon() {
    float mutabilityMutate = (float) Math.pow(0.5, pmRan() * MUTABILITY_MUTABILITY);
    return new Axon(weight + r() * mutability / MUTATE_MULTI, mutability * mutabilityMutate);
  }

  public float r() {
    return (float) Math.pow(pmRan(), mutatePower);
  }

  public float pmRan() {
    return (float) (Math.random() * 2 - 1);
  }
}

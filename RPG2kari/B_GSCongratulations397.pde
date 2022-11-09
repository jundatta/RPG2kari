// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Okazzさん
// 【作品名】Flower832659893
// https://neort.io/art/c83rnjk3p9f3k6tgvmc0
//

class GameSceneCongratulations397 extends GameSceneCongratulationsBase {
  color[] colors = {#FE93C2, #3BD89F, #0045E8, #FF323B, #FFC247};
  int seed;

  @Override void setup() {
    seed = int(random(10000));
    seed = 3;
  }
  @Override void draw() {
    push();
    randomSeed(seed);
    background(#101010);
    float seg = 9;
    //float w = width / seg;
    float w = max(width, height) / seg;
    for (float i = 0; i < seg; i++) {
      for (float j = 0; j < seg; j++) {
        float x = i * w + w / 2;
        float y = j * w + w / 2;
        if ((i + j) % 2 == 0) drawFlower(x, y, w * 1.1);
        else {
          noStroke();
          fill(P5JS.random(colors));
          circle(x, y, w * 0.1);
        }
      }
    }
    pop();

    logoRightLower(#ff0000);
  }

  void drawFlower(float x, float y, float d) {
    int num = int(random(6, 17));
    float aa = random(TAU) + sin(random(10) + frameCount * random(0.02, 0.001) * pom());
    strokeWeight(d * 0.03);
    stroke(P5JS.random(colors));
    noFill();
    for (int i = 0; i < num; i++) {
      float a = map(i, 0, num, 0, TAU) + aa;
      float r1 = d * 0.3;
      float r2 = d * 0.5;
      float b = sin(frameCount * 0.02 * pom()) * (TAU / num) * 0.2;
      line(x + r1 * cos(a), y + r1 * sin(a), x + r2 * cos(a + b), y + r2 * sin(a + b));
    }
    vortex(x, y, d * 0.5);
  }

  void vortex(float x, float y, float d) {
    float aa = TAU * random(2, 4);
    float b = random(TAU) + sin(frameCount * random(0.02, 0.001) * pom());
    int c = pom();
    beginShape();
    for (int i = 0; i < 500; i++) {
      float nrm = norm(i, 0, 500);
      float a = lerp(0, aa * c, nrm) + b;
      float r = lerp(d * 0.5, 0, pow(nrm, 1.5));
      float xx = x + r * cos(a);
      float yy = y + r * sin(a);
      vertex(xx, yy);
    }
    endShape();
  }

  int pom() {
    return (int(random(2)) * 2) - 1;
  }
  
  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}

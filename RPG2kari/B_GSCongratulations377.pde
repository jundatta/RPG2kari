// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Vanessa Dominguezさん
// 【作品名】Clock 3
// https://openprocessing.org/sketch/852767
//

class GameSceneCongratulations377 extends GameSceneCongratulationsBase {
  float angle = 0;

  float cx, cy;
  float secondsRadius;
  float minutesRadius;
  float hoursRadius;
  float clockDiameter;

  @Override void setup() {
    stroke(255);

    var radius = min(width, height) / 2;
    secondsRadius = radius * 0.71;
    minutesRadius = radius * 0.6;
    hoursRadius = radius * 0.5;
    clockDiameter = radius * 1.7;

    cx = width / 2;
    cy = height / 2;
  }
  @Override void draw() {
    push();
    background(150);

    // Draw the clock background
    noStroke();
    fill(133, 193, 233);
    ellipse(cx, cy, clockDiameter + 25, clockDiameter + 25);
    fill(40, 116, 166);
    ellipse(cx, cy, clockDiameter, clockDiameter);

    // Angles for sin() and cos() start at 3 o'clock;
    // subtract HALF_PI to make them start at the top
    var s = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;
    var m = map(minute() + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI;
    var h = map(hour() + norm(minute(), 0, 60), 0, 24, 0, TWO_PI * 2) - HALF_PI;

    // Draw the hands of the clock
    stroke(255);
    strokeWeight(1);
    line(cx, cy, cx + cos(s) * secondsRadius, cy + sin(s) * secondsRadius);
    strokeWeight(2);
    line(cx, cy, cx + cos(m) * minutesRadius, cy + sin(m) * minutesRadius);
    strokeWeight(4);
    line(cx, cy, cx + cos(h) * hoursRadius, cy + sin(h) * hoursRadius);

    // Draw the minute ticks
    strokeWeight(2);
    beginShape(POINTS);
    for (var a = 0; a < 360; a += 6) {
      var angle = radians(a);
      var x = cx + cos(angle) * secondsRadius;
      var y = cy + sin(angle) * secondsRadius;
      vertex(x, y);
    }
    endShape();
    pop();

    logoRightLower(#ff0000);
  }
  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}

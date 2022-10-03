// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Justin Chambersさん
// 【作品名】Sunset over water
// https://openprocessing.org/sketch/532445
//

class GameSceneCongratulations309 extends GameSceneCongratulationsBase {
  // Justin Chambers
  // 4/2018

  float canvasSize;
  float halfCanvasSize;
  float sunHeight;
  float sunSize;
  float gradientSteps;

  float noiseScale = 0.07;
  float waveMovementSpeed = 1.75;

  float waterStrokeWeight = 6;
  float waterStride = 10;

  PGraphics pg;

  @Override void setup() {
    pg = createGraphics(width, height);

    canvasSize = width;
    halfCanvasSize = canvasSize * 0.5;
    sunHeight = 150;
    sunSize = canvasSize * 0.25;
    gradientSteps = 10;

    pg.beginDraw();
    pg.background(100);
    pg.noStroke();

    // sky background
    pg.fill(50, 90, 100);
    pg.rect(0, 0, width, height);

    // sky burst
    color from = color(69, 103, 108);
    color to = color(240, 220, 180);
    for (float i = gradientSteps; i > 0; --i) {
      float size = map(i, gradientSteps, 0, canvasSize + 50, halfCanvasSize);
      pg.fill(lerpColor(from, to, 1 - i / gradientSteps));
      pg.ellipse(halfCanvasSize, sunHeight, size, size);
    }

    // horizon fades
    from = color(210, 140, 100, 30);
    to = color(85, 40, 50, 30);
    for (float i = gradientSteps; i > 0; --i) {
      float sizeX = map(i, gradientSteps, 0, canvasSize, halfCanvasSize);
      float sizeY = map(i, gradientSteps, 0, canvasSize * 0.3, 20);
      float posOffset = map(i, gradientSteps, 0, halfCanvasSize, halfCanvasSize + 50);
      pg.fill(lerpColor(from, to, 1 - i / gradientSteps));
      pg.ellipse(halfCanvasSize - posOffset, sunHeight, sizeX, sizeY);
      pg.ellipse(halfCanvasSize + posOffset, sunHeight, sizeX, sizeY);
    }

    // sun
    from = color(255, 245, 200);
    to = color(255, 255, 250);
    for (float i = gradientSteps; i > 0; --i) {
      float size = map(i, gradientSteps, 0, sunSize, 0);
      pg.fill(lerpColor(from, to, 1 - i / gradientSteps));
      pg.ellipse(halfCanvasSize, sunHeight, size, size);
    }

    // setup for the water line drawing
    pg.strokeWeight(waterStrokeWeight);
    pg.endDraw();
  }
  @Override void draw() {
    push();
    pg.beginDraw();

    // water and reflection coloration based on perlin noise
    float lineToggle = 0;
    float reflectionHalfWidth = sunSize;
    color reflectionColor = color(240, 125, 125);
    color highlightColor = color(240, 240, 175);
    color waterLowColor = color(0, 12, 31);
    color waterHighColor = color(100, 110, 130);
    float noiseZInput = frameCount / 100.0f * waveMovementSpeed;

    for (float yPos = sunHeight + waterStrokeWeight; yPos < height + waterStrokeWeight; yPos += waterStrokeWeight) {
      float yPosMap01 = map(yPos, sunHeight, height, 0, 1);
      float noiseYInput = noiseScale * (yPos * map(yPos, sunHeight, height, 1.5, 1) - frameCount / 3) * waveMovementSpeed;

      for (float xPos = lineToggle; xPos <= width - lineToggle; xPos += waterStride) {
        float noiseXInput = noiseScale * ((xPos - (1 - yPosMap01) * halfCanvasSize / 2) + waterStride * 0.5) / (yPosMap01 * 10 + 1);
        float noiseVal = noise(noiseXInput, noiseYInput, noiseZInput);
        float noiseValIncreasedContrast = constrain(map(noiseVal, 0.1, 0.6, 0, 1), 0, 1);
        float edgeBlendModifier = constrain((2 - (abs(halfCanvasSize - xPos + lineToggle) / (reflectionHalfWidth * (yPosMap01 + 0.6))) * 2), 0, 1);

        // base water color
        color c = lerpColor(waterLowColor, waterHighColor, noiseVal);
        // primary reflection color within the center region
        c = lerpColor(c, reflectionColor, constrain(noiseValIncreasedContrast * 4 - 3, 0, edgeBlendModifier));
        // secondary highlight color (with added emphasis just below the sun)
        c = lerpColor(c, highlightColor, constrain((noiseVal * 10 - 6), 0, edgeBlendModifier) + pow(1 - yPosMap01, 8) * edgeBlendModifier * 1.5);
        // random highlights in the waves outside of the center region
        c = lerpColor(c, highlightColor, constrain((noiseVal * 10 - 7), 0, 1));

        // draw the line segment
        pg.stroke(c);
        pg.line(xPos, yPos, xPos + waterStride, yPos);
      }

      // alternate each row to add variety
      lineToggle = lineToggle == 0 ? -waterStride / 2 : 0;
    }
    pg.endDraw();
    image(pg, 0, 0);
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

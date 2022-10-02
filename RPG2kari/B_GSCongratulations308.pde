// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Alminaさん
// 【作品名】Degrees
// https://neort.io/art/c8m5k8s3p9f0i94dfr80
// こちらを参考にしています
// https://wcs.hatenablog.com/entry/2014/08/02/184622
// 【記事の執筆者】Alminaさん
// 【記事のタイトル】Processingでフォントのアウトラインを読み取って再構築する
//

import java.awt.Font;
import java.awt.font.FontRenderContext;
import java.awt.image.BufferedImage;
import java.awt.geom.PathIterator;

class GameSceneCongratulations308 extends GameSceneCongratulationsBase {
  String fontName = "Segoe UI";
  int fontSize = 500;

  PathIterator iter;
  PathIterator createOutline(String text) {
    FontRenderContext frc =
      new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB)
      .createGraphics()
      .getFontRenderContext();

    Font font = new Font(fontName, Font.TRUETYPE_FONT, fontSize);

    PathIterator iter = font.createGlyphVector(frc, text)
      .getOutline(0, 0)
      .getPathIterator(null);

    return iter;
  }
  void drawNormally(int deg, String text) {
    //  vertex(x*cos(-j), y, x*sin(-j));
    float xRad = cos(radians(-deg));
    float zRad = sin(radians(-deg));
    //noFill();
    float coords[] = new float[6];
    while (!iter.isDone()) {
      int type = iter.currentSegment(coords);
      switch (type) {
      case PathIterator.SEG_MOVETO: // beginning of new path
        beginShape();
        vertex(coords[0]*xRad, coords[1], coords[0]*zRad);
        break;
      case PathIterator.SEG_LINETO:
        vertex(coords[0]*xRad, coords[1], coords[0]*zRad);
        break;
      case PathIterator.SEG_CLOSE: // back to last MOVETO point.
        endShape();
        break;
      case PathIterator.SEG_QUADTO:
        quadraticVertex(coords[0]*xRad, coords[1], coords[0]*zRad,
          coords[2]*xRad, coords[3], coords[2]*zRad);
        break;
      case PathIterator.SEG_CUBICTO:
        bezierVertex(coords[0]*xRad, coords[1], coords[0]*zRad,
          coords[2]*xRad, coords[3], coords[2]*zRad,
          coords[4]*xRad, coords[5], coords[4]*zRad);
        break;
      default:
        throw new RuntimeException("should not reach here");
      }
      iter.next();
    }
    iter = createOutline(text);
  }

  /**
   * color pallet
   */
  //let curl = "https://coolors.co/ff595e-ffca3a-8ac926-1982c4-6a4c93";
  color[] curl = {#ff595e, #ffca3a, #8ac926, #1982c4, #6a4c93};
  IntList pal;
  color bgColor;

  String msg; // text to write
  ArrayList<PVector> pts; // store path data
  float angle;  // rotate angle
  float begin_r, end_r;  // begin / end rotate angle

  @Override void setup() {
    //pal = createPallete(curl);
    pal = new IntList();
    for (int n : curl) {
      pal.append(n);
    }
    int cid = int(random(pal.size()));
    bgColor = pal.get(cid);
    //pal.splice(cid, 1);
    pal.remove(cid);
    //pal = shuffle(pal);
    pal.shuffle();

    background(bgColor);

    /** Camera **/
    //cam = createCamera();

    /** Init parameters **/
    angle = 90;
    // angle = int(random(30, 150));
    begin_r = 0;
    end_r = begin_r + angle;

    genTextToPoints();
  }
  @Override void draw() {
    push();
    translate(width/2, height/2);

    background(bgColor);

    if (frameCount%200==0) {
      begin_r += angle;
      angle = int(random(30, 150));
      end_r = begin_r + angle;
      //genTextToPoints();
    }
    // 最初のdrawNormally()の呼び出しでiterを回し切ってしまう
    // iterを先頭に戻せればいいんですけど。。。わかりゃん＼(^_^)／
    // 。。。わかりゃん＼(^_^)／ので作り直すことにしましたw
    genTextToPoints();

    //cam.lookAt(0, 0, 0);
    //cam.setPosition(0, -300, 600);
    //cam.ortho(-width/2, width/2, -height/2, height/2, -4000, 4000);

    /** Fitting to browser scale **/
    push();
    //scale(min(width, height) / 600);
    scale(min(width, height) / width);

    push();
    translate(0, 500, -1000);
    rotateX(radians(90));
    noFill();
    strokeWeight(2);
    stroke(255);
    circle(0, 0, 100);
    pop();

    push();
    translate(0, 500, -1000);
    if (int(frameCount/100)%2==0) {
      expand();
    } else {
      shrink();
    }
    pop();

    //push();
    //rotateX(radians(-atan(-300/600)));
    ////directionalLight(color(255), 0, 0, -1);
    //translate(-300, -300);
    ////specularMaterial(255);
    //genWindow();
    //pop();
    camera();
    genWindow();

    pop();
    pop();

    logoRightLower(#ff0000);
  }

  void expand() {
    float e = easeInQuart(map(frameCount%100, 0, 100, 0, 1));
    float r = map(e, 0, 1, begin_r, end_r);

    noFill();
    strokeWeight(2);
    stroke(255);
    line(0, 0, 0, cos(radians(-begin_r))*1e+4, 0, sin(radians(-begin_r))*1e+4);
    line(0, 0, 0, cos(radians(-r))*1e+4, 0, sin(radians(-r))*1e+4);

    strokeWeight(2);
    stroke(255);
    for (int j = (int)begin_r; j <= r; j+=10) {
      //beginShape();
      //for (let i = 0; i < pts.length; i++) {
      //  let p = pts[i];
      //  let x = p.x + 50;
      //  let y = p.y;
      //  vertex(x*cos(-j), y, x*sin(-j));
      //}
      //endShape();
      drawNormally(j, msg);
    }

    //noFill();
    //strokeWeight(2);
    //stroke(255);
    //for (int i = 0; i < pts.length; i+=5) {
    //beginShape();
    //let p = pts[i];
    //let x = p.x + 50;
    //let y = p.y;
    //for (let j = begin_r; j <= r; j+=10) {
    //  vertex(x*cos(-j), y, x*sin(-j));
    //}
    //vertex(x*cos(-r), y, x*sin(-r));
    //endShape();
    //}

    push();
    rotateY(radians(begin_r));
    //noStroke();
    //fill(250);
    //text(msg, 50, 0);
    drawNormally(0, msg);
    pop();
    push();
    rotateY(radians(r));
    //noStroke();
    //fill(250);
    //text(msg, 50, 0);
    drawNormally(0, msg);
    pop();
  }

  void shrink() {
    float e = easeInOutQuart(map(frameCount%100, 0, 100, 0, 1));
    float r = map(e, 0, 1, begin_r, end_r);

    noFill();
    strokeWeight(2);
    stroke(255);
    line(0, 0, 0, cos(radians(-r))*1e+4, 0, sin(radians(-r))*1e+4);
    line(0, 0, 0, cos(radians(-end_r))*1e+4, 0, sin(radians(-end_r))*1e+4);

    strokeWeight(2);
    stroke(255);
    for (int j = (int)r; j <= end_r; j+=10) {
      //beginShape();
      //for (let i = 0; i < pts.length; i++) {
      //  let p = pts[i];
      //  let x = p.x + 50;
      //  let y = p.y;
      //  vertex(x*cos(-j), y, x*sin(-j));
      //}
      //endShape();
      drawNormally(j, msg);
    }

    noFill();
    strokeWeight(2);
    stroke(255);
    //for (int i = 0; i < pts.length; i+=5) {
    //beginShape();
    //let p = pts[i];
    //let x = p.x + 50;
    //let y = p.y;
    //for (let j = r; j <= end_r; j+=10) {
    //  vertex(x*cos(-j), y, x*sin(-j));
    //}
    //vertex(x*cos(-end_r), y, x*sin(-end_r));
    //endShape();
    //}

    push();
    rotateY(radians(end_r));
    //noStroke();
    //fill(250);
    //text(msg, 50, 0);
    drawNormally(0, msg);
    pop();
    push();
    rotateY(radians(r));
    //noStroke();
    //fill(250);
    //text(msg, 50, 0);
    drawNormally(0, msg);
    pop();
  }

  void genTextToPoints() {
    msg = str(int(angle));
    //pts = font.textToPoints(msg, 0, 0, fSize, {
    //sampleFactor:
    //  0.1, // increase for more points
    //  simplifyThreshold:
    //  0.0 // increase to remove collinear points
    //}
    //);
    iter = createOutline(msg);
  }

  void genWindow() {
    float w = width / 30.0f;
    float sx = w;
    float sy = w * 3;
    float ww = width - (w * 2);
    float hh = height - (w * 6);
    noStroke();
    fill(255);
    rect(sx, sy, ww, w);
    rect(sx + ww - w, sy, w, hh);
    rect(sx, sy + hh - w, ww, w);
    rect(sx, sy, w, hh);
  }

  float easeInQuart(float t) {
    return 1 + (--t) * t * t * t * t;
  }
  float easeInOutQuart(float t) {
    return t < 0.5 ? 8 * t * t * t * t : 1 - 8 * (--t) * t * t * t;
  }

  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}

// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Martin Andersenさん
// 【作品名】3D Earth
// https://openprocessing.org/sketch/663509
//

class GameSceneCongratulations396 extends GameSceneCongratulationsBase {
  PImage earth, clouds, moon;

  PShape shapeEarth, shapeClouds, shapeMoon;

  void preload() {
    earth = loadImage("data/396/earth-hires.jpg");
    clouds = loadImage("data/396/earth-clouds.png");
    moon = loadImage("data/396/moon.png");
  }
  @Override void setup() {
    preload();
    smooth();

    // 球のPShapeの大きさを1にして一つだけ作ってDraw()でsetTexture()で張り替えて
    // 球のPShapeを使いまわししようとしたら2つ目のshape()で
    // ArrayIndexOutOfBoundsException: Index -2 out of bounds for length 1918
    // と表示されて落ちたので、個別にPShapeを作ることにした。
    shapeEarth = createShape(SPHERE, 200);
    shapeEarth.setTexture(earth);
    shapeEarth.setStroke(false);

    shapeClouds = createShape(SPHERE, 204);
    shapeClouds.setTexture(clouds);
    shapeClouds.setStroke(false);

    shapeMoon = createShape(SPHERE, 20);
    shapeMoon.setTexture(moon);
    shapeMoon.setStroke(false);
  }
  @Override void draw() {
    push();
    translate(width/2, height/2);
    noStroke();

    background(0);

    //   Representing the sun
    directionalLight(255, 255, 255, 1, 1, -1);
    directionalLight(50, 50, 50, -1, -1, -1);

    rotateY(millis()/2000.0f);

    //texture(earth);
    //sphere(200);
    shape(shapeEarth);

    rotateY(millis()/10000.0f);

    //texture(clouds);
    //sphere(204);
    shape(shapeClouds);

    translate(500, 0, 0);
    //texture(moon);
    //sphere(20);
    shape(shapeMoon);
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

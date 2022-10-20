// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】センバクさん
// 【作品名】traffic
// https://neort.io/art/ca1b66k3p9fbkmo5q0gg
//

class GameSceneCongratulations356 extends GameSceneCongratulationsBase {
  float t = 0.0;
  float vel = 0.2;
  float num;
  color[] palette_selected;
  float size;

  @Override void setup() {
    size = min(width, height);

    background(#f4f1de);
    //angleMode(DEGREES);
    num = random(100);
    palette_selected = P5JS.random(palettes);
  }
  @Override void draw() {
    push();
    randomSeed((long)num);
    background(#f4f1de);
    shape(width / 2, height / 2, width * 0.4);
    pop();

    logoRightLower(#ff0000);
  }

  void shape(float x, float y, float s) {
    push();
    translate(x, y);
    float count = 1000;
    for (var i = 0; i < count; i++) {
      var colNum = int(random(1, palette_selected.length));
      color col = color(palette_selected[colNum]);

      var angle = random(360);
      var magic = -1+ (random(random(random(1))));
      var d = s ;
      var ex = d * sin(radians(angle)) * magic*sin(radians(i+t));
      var ey = d * cos(radians(angle)) * magic*cos(radians(i+t));
      push();
      translate(ex, ey);
      var l = random(random(random(size/10.0f)));
      noStroke();
      fill(col);
      ellipse(0, 0, l, l);
      pop();
    }
    pop();
    t+=vel;
  }
  final color[][] palettes = {
    {#e9dbce, #fceade, #ea526f, #e2c290, #6b2d5c, #25ced1},
    {#223843, #e9dbce, #eff1f3, #dbd3d8, #d8b4a0, #d77a61},
    {#e29578, #ffffff, #006d77, #83c5be, #ffddd2, #edf6f9},
    {#e9dbce, #ffffff, #cc3528, #028090, #00a896, #f8c522},
    {#e9dbce, #f8f7c1, #f46902, #da506a, #fae402, #92accc},
    {#e42268, #fb8075, #761871, #5b7d9c, #a38cb4, #476590},
    {#f9b4ab, #fdebd3, #264e70, #679186, #bbd4ce},
    {#1f306e, #553772, #8f3b76, #c7417b, #f5487f},
    {#e0f0ea, #95adbe, #574f7d, #503a65, #3c2a4d},
    {#413e4a, #73626e, #b38184, #f0b49e, #f7e4be},
    {#ff4e50, #fc913a, #f9d423, #ede574, #e1f5c4},
    {#99b898, #fecea8, #ff847c, #e84a5f, #2a363b},
    {#69d2e7, #a7dbd8, #e0e4cc, #f38630, #fa6900},
    {#fe4365, #fc9d9a, #f9cdad, #c8c8a9, #83af9b},
    {#ecd078, #d95b43, #c02942, #542437, #53777a},
    {#556270, #4ecdc4, #c7f464, #ff6b6b, #c44d58},
    {#774f38, #e08e79, #f1d4af, #ece5ce, #c5e0dc},
    {#e8ddcb, #cdb380, #036564, #033649, #031634},
    {#490a3d, #bd1550, #e97f02, #f8ca00, #8a9b0f},
    {#594f4f, #547980, #45ada8, #9de0ad, #e5fcc2},
    {#00a0b0, #6a4a3c, #cc333f, #eb6841, #edc951},
    {#5bc0eb, #fde74c, #9bc53d, #e55934, #fa7921},
    {#ed6a5a, #f4f1bb, #9bc1bc, #5ca4a9, #e6ebe0},
    {#ef476f, #ffd166, #06d6a0, #118ab2, #073b4c},
    {#22223b, #4a4e69, #9a8c98, #c9ada7, #f2e9e4},
    {#114b5f, #1a936f, #88d498, #c6dabf, #f3e9d2},
    {#ff9f1c, #ffbf69, #ffffff, #cbf3f0, #2ec4b6},
    {#3d5a80, #98c1d9, #e0fbfc, #ee6c4d, #293241},
    {#06aed5, #086788, #f0c808, #fff1d0, #dd1c1a},
    {#540d6e, #ee4266, #ffd23f, #3bceac, #0ead69},
    {#c9cba3, #ffe1a8, #e26d5c, #723d46, #472d30},
    {#3c4cad, #5FB49C, #e8a49c},
    {#1c3560, #f2efdb, #fea985, #ff6343},
    {#e0d7c5, #488a50, #b59a55, #bf5513, #3b6fb6, #4f3224, #9a7f6e}, //o-ball
    {#ffb53c, #eeb3a3, #f3553c, #642a02}, //bloodOrange
    {#DEEFB7, #5FB49C, #ed6a5a}
  };
  
  @Override void mousePressed() {
    gGameStack.change(new GameSceneTitle());
  }
  @Override void keyPressed() {
    super.keyPressed();

    gGameStack.change(new GameSceneTitle());
  }
}

// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Character ripple. Draw by openFrameworks
// https://junkiyoshi.com/2022/01/15/
//

class GameSceneCongratulations316 extends GameSceneCongratulationsBase {
  final int font_size = 40;
  final String[] words = {
    "A", "B", "C", "D", "E",
    "F", "G", "H", "I", "J",
    "K", "L", "M", "N", "O",
    "P", "Q", "R", "S", "T",
    "U", "V", "W", "X", "Y", "Z",
  };

  class Word {
    PVector location;
    int index;
    boolean param;
    Word(PVector location, int index, boolean param) {
      this.location = location;
      this.index = index;
      this.param = param;
    }
  }
  ArrayList<Word> wordList;

  //--------------------------------------------------------------
  @Override void setup() {
    textSize(font_size);

    wordList = new ArrayList();
    for (int x = font_size * -15; x <= font_size * 15; x += font_size * 0.8) {
      for (int y = font_size * -15; y <= font_size * 15; y += font_size * 1.2) {
        PVector loc = new PVector(x - font_size * 0.2, y - font_size * 0.5);
        Word wd = new Word(loc, 0, true);
        wordList.add(wd);
      }
    }
  }

  //--------------------------------------------------------------
  void update() {
    randomSeed(39);
    for (Word wd : wordList) {
      wd.param = false;
    }

    for (int f = 0; f < 2; f++) {
      var radius = ((frameCount * 10) + f * 500) % 1000;
      for (int i = 0; i < wordList.size(); i++) {
        Word wd = wordList.get(i);
        if (wd.location.mag() > radius - 50 && wd.location.mag() < radius + 50) {
          wd.index += random(1, 5);
          wd.index = wd.index % words.length;
          wd.param = true;
        }
      }
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();

    translate(width/2, height/2);
    background(0);
    fill(255);

    translate(font_size * 0.5, font_size * 0.5);

    for (int i = 0; i < wordList.size(); i++) {
      Word wd = wordList.get(i);
      pushMatrix();
      translate(wd.location.x, wd.location.y);
      if (wd.param) {
        rotateY(map(openFrameworks.ofNoise(wd.location.y * 0.005, frameCount * 0.01), 0, 1, -360, 360));
        rotateX(map(openFrameworks.ofNoise(wd.location.x * 0.005, frameCount * 0.01), 0, 1, -360, 360));
      }
      text(words[wd.index], font_size * -0.5, font_size * -0.5);
      popMatrix();
    }
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

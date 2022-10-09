// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Ripple on fonts. Draw by openFrameworks
// https://junkiyoshi.com/2022/01/02/
//

class GameSceneCongratulations325 extends GameSceneCongratulationsBase {
  final int font_size = 40;
  final String[] words = {
    "H", "A", "P", "P", "Y",
    "N", "E", "W",
    "Y", "E", "A", "R"
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
  ArrayList<Word> word_list = new ArrayList();

  class Wave {
    PVector first;
    float second;
    Wave(PVector first, float second) {
      this.first = first;
      this.second = second;
    }
  }
  ArrayList<Wave> wave_list = new ArrayList();

  //--------------------------------------------------------------
  @Override void setup() {
    for (int x = font_size * -15; x <= font_size * 15; x += font_size * 0.8) {
      for (int y = font_size * -15; y <= font_size * 15; y += font_size * 1.2) {
        Word w = new Word(new PVector(x - font_size * 0.2, y - font_size * 0.5),
          (int)random(words.length), true);
        word_list.add(w);
      }
    }
  }

  //--------------------------------------------------------------
  void update() {
    if (frameCount % 20 == 0) {
      var l = new PVector(random(-250, 250), random(-250, 250));
      float f = 5;
      wave_list.add(new Wave(l, f));
    }

    for (Word w : word_list) {
      w.param = false;
    }

    for (Wave wave : wave_list) {
      for (Word w : word_list) {
        var distance = wave.first.dist(w.location);
        if (distance > wave.second - font_size * 1.2 && distance < wave.second + font_size * 1.2) {
          w.index = (w.index + 1) % words.length;
          w.param = true;
        }
      }
      wave.second += 12;
    }

    for (int i = wave_list.size() - 1; i >= 0; i--) {
      if (wave_list.get(i).second > 650) {
        wave_list.remove(i);
      }
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();

    translate(width/2, height/2);
    background(255);
    textSize(font_size);

    for (Word w : word_list) {
      if (w.param) {
        fill(0);
      } else {
        fill(128);
      }
      text(words[w.index], w.location.x, w.location.y);
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

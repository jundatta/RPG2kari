// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Looking forward to the new Matrix ! Draw by openFrameworks
// https://junkiyoshi.com/2021/12/17/
//

class GameSceneCongratulations353 extends GameSceneCongratulationsBase {
  ArrayList<PVector> location_list = new ArrayList();
  FloatList rotate_deg_list = new FloatList();
  IntList param_list = new IntList();
  IntList word_index_list = new IntList();
  ArrayList<IntList> route_info_list = new ArrayList();
  IntList index_list = new IntList();

  int font_size;

  String[] words;

  //--------------------------------------------------------------
  @Override void setup() {
    int span = 30;
    for (int x = -300; x <= 300; x += span) {
      for (int y = -300; y <= 300; y += span) {
        for (int z = 0; z <= 1200; z += span * 2) {
          location_list.add(new PVector(x, y, z));
          rotate_deg_list.append(0);
          param_list.append(0);
          word_index_list.append(0);
        }
      }
    }

    for (PVector location : location_list) {
      IntList route_info = new IntList();
      int index = -1;
      for (PVector other : location_list) {
        index++;
        if (location == other) {
          continue;
        }
        float distance = PVector.dist(location, other);
        if (distance <= span) {
          route_info.append(index);
        }
      }
      route_info_list.add(route_info);
    }

    for (int i = 0; i < 80; i++) {
      index_list.append((int)random(location_list.size()));
    }

    font_size = 23;
    textSize(font_size);

    String[] wordsT = {
      "ｱ", "ｲ", "ｳ", "ｴ", "ｵ",
      "ｶ", "ｷ", "ｸ", "ｹ", "ｺ",
      "ｻ", "ｼ", "ｽ", "ｾ", "ｿ",
      "ﾀ", "ﾁ", "ﾂ", "ﾃ", "ﾄ",
      "ﾅ", "ﾆ", "ﾇ", "ﾈ", "ﾉ",
      "ﾊ", "ﾋ", "ﾌ", "ﾍ", "ﾎ",
      "ﾏ", "ﾐ", "ﾑ", "ﾒ", "ﾓ",
      "ﾔ", "ﾕ", "ﾖ",
      "ﾗ", "ﾘ", "ﾙ", "ﾚ", "ﾛ",
      "ﾜ", "ｦ", "ﾝ",
    };
    words = wordsT;
  }

  //--------------------------------------------------------------
  void update() {
    if (ofGetFrameNum() % 3 != 0) {
      for (int i = 0; i < index_list.size(); i++) {
        word_index_list.set(index_list.get(i), (int)random(words.length));
      }
      return;
    }

    for (int i = 0; i < index_list.size(); i++) {
      //int next_index = this->route_info_list[this->index_list[i]][(int)ofRandom(this->route_info_list[this->index_list[i]].size())];
      IntList routeInfo = route_info_list.get(index_list.get(i));
      int next_index = routeInfo.get((int)random(routeInfo.size()));
      for (int k = 0; k < routeInfo.size(); k++) {
        if (param_list.get(next_index) <= 0) {
          var loc = location_list.get(index_list.get(i));
          var next = location_list.get(next_index);

          var angle = atan2(next.y - loc.y, next.x - loc.x);
          if (angle != 0) {
            rotate_deg_list.set(next_index, angle * RAD_TO_DEG + 90);
          }
          param_list.set(next_index, 60);
          index_list.set(i, next_index);
          word_index_list.set(next_index, (int)random(words.length));
          break;
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
    strokeWeight(0.5);

    for (int i = 0; i < location_list.size(); i++) {
      if (param_list.get(i) > 0) {
        int z = (int)(location_list.get(i).z + ofGetFrameNum() * 3) % 1200 - 600;

        pushMatrix();
        translate(location_list.get(i).x, location_list.get(i).y, z);

        int alpha = (int)map(param_list.get(i), 0, 60, 0, 255);
        int rb = param_list.get(i) >= 57 ? 239 : 39;
        fill(color(rb, 239, rb, alpha));

        ofRotateZ(rotate_deg_list.get(i));
        text(words[word_index_list.get(i)], -15, -15);

        popMatrix();
      }

      if (param_list.get(i) > 0) {
        param_list.sub(i, 1);
      }
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

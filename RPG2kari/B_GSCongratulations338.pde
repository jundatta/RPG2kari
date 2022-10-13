// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Active boxes colorful. Draw by openFrameworks
// https://junkiyoshi.com/2021/12/26/
//

class GameSceneCongratulations338 extends GameSceneCongratulationsBase {
  ArrayList<PVector> location_list;
  ArrayList<IntList> next_index_list;
  IntList destination_list;

  ArrayList<Actor> actor_list;

  //--------------------------------------------------------------
  class Actor {
    int select_index;
    int next_index;
    float hue;

    PVector location;

    Actor(ArrayList<PVector> location_list, IntList destination_list) {
      this.select_index = (int)random(location_list.size());
      while (true) {
        if (!destination_list.hasValue(this.select_index)) {
          destination_list.append(this.select_index);
          break;
        }
        this.select_index = (this.select_index + 1) % location_list.size();
      }
      this.next_index = this.select_index;
      this.hue = random(255);
    }

    //--------------------------------------------------------------
    void update(int frame_span, ArrayList<PVector> location_list, ArrayList<IntList> next_index_list, IntList destination_list) {
      if (frameCount % frame_span == 0) {
        var tmp_index = this.select_index;
        this.select_index = this.next_index;
        //int retry = next_index_list[this->select_index].size();
        IntList index_list = next_index_list.get(this.select_index);
        int retry = index_list.size();
        //this->next_index = next_index_list[this->select_index][(int)ofRandom(next_index_list[this->select_index].size())];
        this.next_index = index_list.get((int)random(index_list.size()));
        while (--retry > 0) {
          if (!destination_list.hasValue(this.next_index)) {
            if (tmp_index != this.next_index) {
              destination_list.append(this.next_index);
              break;
            }
          }
          //this->next_index = next_index_list[this->select_index][(this->next_index + 1) % next_index_list[this->select_index].size()];
          this.next_index = index_list.get((this.next_index+1) % index_list.size());
        }
        if (retry <= 0) {
          destination_list.append(this.select_index);
          this.next_index = this.select_index;
        }
      }

      var param = frameCount % frame_span;
      //var distance = location_list.get(this.next_index) - location_list.get(this.select_index);
      PVector nextV = location_list.get(this.next_index);
      PVector selectV = location_list.get(this.select_index);
      var distance = PVector.sub(nextV, selectV);
      //this.location = location_list.get(this.select_index) + distance / frame_span * param;
      PVector mov = PVector.div(distance, frame_span);
      mov = PVector.mult(mov, param);
      this.location = PVector.add(selectV, mov);
    }

    //--------------------------------------------------------------
    PVector getLocation() {
      return this.location;
    }

    //--------------------------------------------------------------
    boolean isActive() {
      return this.select_index != this.next_index;
    }

    //--------------------------------------------------------------
    float getHue() {
      return this.hue;
    }
  }

  //--------------------------------------------------------------
  @Override void setup() {
    this.location_list = new ArrayList();
    for (int x = -250; x <= 250; x += 25) {
      for (int y = -250; y <= 250; y += 25) {
        for (int z = -250; z <= 250; z += 25) {
          PVector v = new PVector(x, y, z);
          if (v.mag() < 250) {
            this.location_list.add(v);
          }
        }
      }
    }

    this.next_index_list = new ArrayList();
    for (PVector location : this.location_list) {
      IntList next_index = new IntList();
      int index = -1;
      for (PVector other : this.location_list) {
        index++;
        if (location == other) {
          continue;
        }
        float distance = PVector.dist(location, other);
        if (distance <= 25) {
          next_index.append(index);
        }
      }
      this.next_index_list.add(next_index);
    }

    this.destination_list = new IntList();
    this.actor_list = new ArrayList();
    for (int i = 0; i < 3500; i++) {
      //this->actor_list.push_back(make_unique<Actor>(this->location_list, this->next_index_list, this->destination_list));
      Actor a = new Actor(this.location_list, this.destination_list);
      this.actor_list.add(a);
    }
  }

  //--------------------------------------------------------------
  void update() {

    int frame_span = 20;
    int prev_index_size = 0;

    if (frameCount % frame_span == 0) {
      prev_index_size = destination_list.size();
    }

    for (Actor actor : actor_list) {
      actor.update(frame_span, this.location_list, this.next_index_list, this.destination_list);
    }

    if (prev_index_size != 0) {
      //this.destination_list.erase(this.destination_list.begin(), this.destination_list.begin() + prev_index_size);
      for (int i = 0; i < prev_index_size; i++) {
        this.destination_list.remove(0);
      }
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();
    translate(width/2, height/2);
    background(0);
    strokeWeight(1.5);

    rotateY(radians(frameCount * 0.6666666666666666));

    for (Actor actor : actor_list) {
      push();
      colorMode(HSB, 255, 255, 255);
      color fill_color = #000000;
      if (actor.isActive()) {
        if (frameCount % 20 < 10) {
          fill_color = color(actor.getHue(), 130, map(frameCount % 20, 0, 10, 0, 255));
        } else {

          fill_color = color(actor.getHue(), 130, map(frameCount % 20, 10, 20, 255, 0));
        }
      }
      noStroke();
      fill(fill_color);
      PVector v = actor.getLocation();
      translate(v.x, v.y, v.z);
      box(23);
      pop();

      color stroke_color = #ffffff;
      if (actor.isActive()) {
        if (frameCount % 20 < 10) {
          stroke_color = color(map(frameCount % 20, 0, 10, 255, 0));
        } else {
          stroke_color = color(map(frameCount % 20, 10, 20, 0, 255));
        }
      }
      stroke(stroke_color);
      noFill();
      push();
      v = actor.getLocation();
      translate(v.x, v.y, v.z);
      box(23);
      pop();
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

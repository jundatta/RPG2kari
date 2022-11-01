// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】Cube in cube. Draw by openframeworks
// https://junkiyoshi.com/2021/10/29/
//

class GameSceneCongratulations383 extends GameSceneCongratulationsBase {
  //--------------------------------------------------------------
  class Actor {
    int select_index;
    int next_index;

    PVector location;
    color col;

    Actor(ArrayList<PVector> location_list, IntList destination_list) {
      select_index = (int)ofRandom(location_list.size());
      while (true) {
        //auto itr = find(destination_list.begin(), destination_list.end(), this->select_index);
        //if (itr == destination_list.end()) {
        //  destination_list.push_back(this->select_index);
        //  break;
        //}
        if (!destination_list.hasValue(select_index)) {
          destination_list.append(select_index);
          break;
        }
        select_index = (select_index + 1) % location_list.size();
      }
      next_index = select_index;
    }

    //--------------------------------------------------------------
    void update(final int frame_span, ArrayList<PVector> location_list, ArrayList<IntList> next_index_list, IntList destination_list) {

      if (ofGetFrameNum() % frame_span == 0) {
        var tmp_index = select_index;
        select_index = next_index;
        IntList nextIndex = next_index_list.get(select_index);
        int retry = nextIndex.size();
        next_index = nextIndex.get((int)ofRandom(nextIndex.size()));
        while (--retry > 0) {
          //auto destination_itr = find(destination_list.begin(), destination_list.end(), this->next_index);
          //if (destination_itr == destination_list.end()) {
          //  if (tmp_index != this->next_index) {
          //    destination_list.push_back(this->next_index);
          //    break;
          //  }
          //}
          if (!destination_list.hasValue(next_index)) {
            if (tmp_index != next_index) {
              destination_list.append(next_index);
              break;
            }
          }
          next_index = nextIndex.get((next_index + 1) % nextIndex.size());
        }
        if (retry <= 0) {
          destination_list.append(select_index);
          next_index = select_index;
        }
      }

      //auto distance = location_list[this->next_index] - location_list[this->select_index];
      //this->location = location_list[this->select_index] + distance / frame_span * param;
      PVector locN = location_list.get(next_index);
      PVector locS = location_list.get(select_index);
      var distance = PVector.sub(locN, locS);
      location = PVector.add(locS, distance);
    }

    //--------------------------------------------------------------
    PVector getLocation() {
      return location;
    }

    //--------------------------------------------------------------
    void setColor(color value) {
      col = value;
    }

    //--------------------------------------------------------------
    color getColor() {
      return col;
    }
  }

  //--------------------------------------------------------------
  ArrayList<PVector> parent_location_group = new ArrayList();
  ArrayList<IntList> parent_next_index_group = new ArrayList();
  IntList parent_destination_group = new IntList();
  ArrayList<Actor> parent_actor_group = new ArrayList();

  ArrayList<ArrayList<PVector>> location_group_list = new ArrayList();
  ArrayList<ArrayList<IntList>> next_index_group_list = new ArrayList();
  ArrayList<IntList> destination_group_list = new ArrayList();
  ArrayList<ArrayList<Actor>> actor_group_list = new ArrayList();

  @Override void setup() {
    IntList base_color_list = new IntList();
    color[] hex_list = { #ee6352, #59cd90, #3fa7d6, #fac05e, #f79d84 };
    for (var hex : hex_list) {
      base_color_list.append(hex);
    }

    int span = 180;
    for (int x = -180; x <= 180; x += span) {
      for (int y = -180; y <= 180; y += span) {
        for (int z = -180; z <= 180; z += span) {
          parent_location_group.add(new PVector(x, y, z));
        }
      }
    }

    for (var location : parent_location_group) {
      IntList next_index = new IntList();
      int index = -1;
      for (var other : parent_location_group) {
        index++;
        if (location == other) {
          continue;
        }
        float distance = PVector.dist(location, other);
        if (distance <= span) {
          next_index.append(index);
        }
      }
      parent_next_index_group.add(next_index);
    }

    for (int i = 0; i < 23; i++) {
      Actor a = new Actor(parent_location_group, parent_destination_group);
      a.setColor(base_color_list.get((int)ofRandom(base_color_list.size())));
      parent_actor_group.add(a);
    }

    span = 50;
    for (int g = 0; g < parent_actor_group.size(); g++) {
      ArrayList<PVector> location_group = new ArrayList();
      for (int x = -50; x <= 50; x += span) {
        for (int y = -50; y <= 50; y += span) {
          for (int z = -50; z <= 50; z += span) {
            location_group.add(new PVector(x, y, z));
          }
        }
      }
      location_group_list.add(location_group);

      ArrayList<IntList> next_index_group = new ArrayList();
      for (var location : location_group) {
        IntList next_index = new IntList();
        int index = -1;
        for (var other : location_group) {
          index++;
          if (location == other) {
            continue;
          }

          float distance = PVector.dist(location, other);
          if (distance <= span) {
            next_index.append(index);
          }
        }
        next_index_group.add(next_index);
      }
      next_index_group_list.add(next_index_group);


      ArrayList<Actor> actor_group = new ArrayList();
      IntList destination_group = new IntList();
      for (int i = 0; i < 23; i++) {
        var a = new Actor(location_group, destination_group);
        a.setColor(base_color_list.get((int)ofRandom(base_color_list.size())));
        actor_group.add(a);
      }

      actor_group_list.add(actor_group);
      destination_group_list.add(destination_group);
    }
  }

  //--------------------------------------------------------------
  void update() {
    int frame_span = 20;
    int prev_index_size = 0;

    if (ofGetFrameNum() % frame_span == 0) {
      prev_index_size = parent_destination_group.size();
    }

    for (var actor : parent_actor_group) {
      actor.update(frame_span, parent_location_group, parent_next_index_group, parent_destination_group);
    }

    if (prev_index_size != 0) {
      // 消すのに(prev_index_size-1)しなくていいと思うが。。。
      //this->parent_destination_group.erase(this->parent_destination_group.begin(), this->parent_destination_group.begin() + prev_index_size);
      for (int i = 0; i < prev_index_size; i++) {
        parent_destination_group.remove(0);
      }
    }

    frame_span = 5;
    for (int g = 0; g < parent_actor_group.size(); g++) {
      if (ofGetFrameNum() % frame_span == 0) {
        prev_index_size = destination_group_list.get(g).size();
      }

      for (var actor : actor_group_list.get(g)) {
        actor.update(frame_span, location_group_list.get(g), next_index_group_list.get(g), destination_group_list.get(g));
      }

      if (prev_index_size != 0) {
        //this->destination_group_list[g].erase(this->destination_group_list[g].begin(), this->destination_group_list[g].begin() + prev_index_size);
        for (int i = 0; i < prev_index_size; i++) {
          destination_group_list.get(g).remove(0);
        }
      }
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();
    translate(width/2, height/2);
    ofBackground(239);
    ofSetLineWidth(1);

    ofRotateY(ofGetFrameNum() * 0.5);
    ofRotateX(ofGetFrameNum() * 0.38);

    for (int g = 0; g < parent_actor_group.size(); g++) {
      pushMatrix();
      PVector p = parent_actor_group.get(g).getLocation();
      translate(p.x, p.y, p.z);

      for (var actor : actor_group_list.get(g)) {
        push();
        PVector loc = actor.getLocation();
        translate(loc.x, loc.y, loc.z);

        noStroke();
        fill(actor.getColor());
        box(45);

        stroke(239);
        noFill();
        box(46);
        pop();
      }
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

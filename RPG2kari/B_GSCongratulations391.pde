// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】中内　純(ハンドルネーム：JunKiyoshi)さん
// 【作品名】1 to 2, 2 to 1. Draw by openFrameworks
// https://junkiyoshi.com/2021/10/14/
//

class GameSceneCongratulations391 extends GameSceneCongratulationsBase {
  final int texW = 320;
  final int texH = 320;
  PGraphics[] pixcels_list;
  ArrayList<ArrayList<ofMesh>> face_list = new ArrayList();
  //--------------------------------------------------------------
  @Override void setup() {
    PFont font = createFont("HuiFont29.ttf", 256, true);

    String[] str = { "壱", "零" };
    pixcels_list = new PGraphics[str.length];
    for (int i = 0; i < str.length; i++) {
      PGraphics pg = createGraphics(texW, texH);
      pg.beginDraw();
      pg.translate(pg.width * 0.5f, pg.height * 0.5f);
      pg.rectMode(CENTER);
      pg.background(0);
      pg.textFont(font);
      pg.fill(255);
      pg.text(str[i], -130, 90);
      pg.noFill();
      pg.stroke(255);
      pg.rect(0, 0, pg.width - 20, pg.height - 20);
      pg.endDraw();
      pixcels_list[i] = pg;
    }
  }

  //--------------------------------------------------------------
  void update() {
    face_list.clear();

    int x_span = 20;
    int y_span = 5;

    for (int i = 0; i < pixcels_list.length; i++) {
      ArrayList<ofMesh> mesh_list = new ArrayList();
      PImage tex = pixcels_list[i];
      int W = tex.width;
      int H = tex.height;
      for (int x = 0; x < W; x += x_span) {
        ofMesh mesh = new ofMesh();
        for (int y = 0; y < H; y += y_span) {
          int index = mesh.getNumVertices();

          float z = -(W/2);

          ArrayList<PVector> vertices = new ArrayList();
          PVector org = new PVector(W/2, H/2, 0);
          PVector p = new PVector(x, y, z);
          vertices.add(PVector.sub(p, org));
          p = new PVector(x + x_span, y, z);
          vertices.add(PVector.sub(p, org));
          p = new PVector(x + x_span, y + y_span, z);
          vertices.add(PVector.sub(p, org));
          p = new PVector(x, y + y_span, z);
          vertices.add(PVector.sub(p, org));

          var deg = (x / 3.0f + ofGetFrameNum()) % 360;
          if (deg < 90) {
            deg = 0;
          } else if (deg < 180) {
            deg = ofMap(deg, 90, 180, 0, 180);
          } else if (deg < 270) {
            deg = 180;
          } else if (deg < 360) {
            deg = ofMap(deg, 270, 360, 180, 360);
          }

          deg += i * 180;

          //auto rotation_x = glm::rotate(glm::mat4(), deg * (float)DEG_TO_RAD, glm::vec3(1, 0, 0));
          var rotation_x = new PMatrix3D();
          rotation_x.rotateX(deg * DEG_TO_RAD);
          ArrayList<PVector> newVertices = new ArrayList();
          for (var vertex : vertices) {
            //vertex = glm::vec4(vertex, 0) * rotation_x;
            PVector newVertex = rotation_x.mult(vertex, null);
            newVertices.add(newVertex);
          }
          vertices = newVertices;
          mesh.addVertices(vertices);

          p = new PVector(x, y);
          p = new PVector(p.x / (float)W, 1.0f - (p.y / (float)H));
          mesh.addTexCoord(p);
          p = new PVector(x + x_span, y);
          p = new PVector(p.x / (float)W, 1.0f - (p.y / (float)H));
          mesh.addTexCoord(p);
          p = new PVector(x + x_span, y + y_span);
          p = new PVector(p.x / (float)W, 1.0f - (p.y / (float)H));
          mesh.addTexCoord(p);
          p = new PVector(x, y + y_span);
          p = new PVector(p.x / (float)W, 1.0f - (p.y / (float)H));
          mesh.addTexCoord(p);

          mesh.addIndex(index + 0);
          mesh.addIndex(index + 1);
          mesh.addIndex(index + 2);
          mesh.addIndex(index + 0);
          mesh.addIndex(index + 2);
          mesh.addIndex(index + 3);
        }
        mesh.setTexture(tex);
        mesh_list.add(mesh);
      }
      face_list.add(mesh_list);
    }
  }

  //--------------------------------------------------------------
  @Override void draw() {
    push();
    update();
    translate(width/2, height/2);

    ofBackground(239);
    ofSetLineWidth(2);
    //rectMode(CENTER);

    ofRotateX(180);

    for (var mesh_list : face_list) {
      for (var mesh : mesh_list) {
        // bind()、unbind()はいい感じにテクスチャのuv座標をつけてくれる感じなのかなw
        //image.bind();
        mesh.draw();
        //image.unbind();
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

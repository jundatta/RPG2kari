class ofMesh {
  ArrayList<PVector> vertices;
  IntList colors;
  IntList indices;

  ofMesh() {
    vertices = new ArrayList();
    colors = new IntList();
    indices = new IntList();
  }
  void clear() {
    vertices.clear();
    colors.clear();
    indices.clear();
  }
  void addVertices(ArrayList<PVector> vertices) {
    for (PVector v : vertices) {
      this.vertices.add(v);
    }
  }
  void addVertex(PVector v) {
    this.vertices.add(v);
  }
  int getNumVertices() {
    return vertices.size();
  }
  void addColor(color c) {
    colors.append(c);
  }
  color getColor(int ix) {
    return colors.get(ix);
  }
  void setColor(int ix, color c) {
    colors.set(ix, c);
  }
  void addIndex(int ix) {
    indices.append(ix);
  }
  ArrayList<PVector> getVertices() {
    return vertices;
  }
  PVector getVertex(int ix) {
    return vertices.get(ix);
  }
  // 設定されたOF_PRIMITIVE_LINESの解釈で描画する
  void drawWireframe() {
    PShape sh = createShape();
    sh.setFill(false);
    sh.beginShape(LINES);
    for (int i : indices) {
      PVector v = vertices.get(i);
      sh.vertex(v.x, v.y, v.z);
    }
    sh.endShape();
    for (int i = 0; i < indices.size(); i++) {
      int idx = indices.get(i);
      color col = colors.get(idx);
      sh.setStroke(i, col);
    }
    shape(sh);
  }
  // stroke()の色を指定して線を描画する
  void drawWireframe(PGraphics pg, color stroke) {
    PShape sh = createShape();
    sh.setFill(false);
    sh.beginShape(LINES);
    for (int i : indices) {
      PVector v = vertices.get(i);
      sh.vertex(v.x, v.y, v.z);
    }
    sh.endShape();
    sh.setStroke(stroke);
    pg.shape(sh);
  }
  void drawWireframe(color stroke) {
    PGraphics pg = getGraphics();
    drawWireframe(pg, stroke);
  }
  // デフォルトのOF_PRIMITIVE_TRIANGLESの解釈で描画する
  void draw() {
    PShape sh = createShape();
    sh.setStroke(false);
    sh.beginShape(TRIANGLES);
    for (int i : indices) {
      PVector v = vertices.get(i);
      sh.vertex(v.x, v.y, v.z);
    }
    sh.endShape();
    for (int i = 0; i < indices.size(); i++) {
      int idx = indices.get(i);
      color col = colors.get(idx);
      sh.setFill(i, col);
    }
    shape(sh);
  }
  // fill()の色を指定して描画する
  void draw(color fill) {
    PShape sh = createShape();
    sh.setStroke(false);
    sh.beginShape(TRIANGLES);
    for (int i : indices) {
      PVector v = vertices.get(i);
      sh.vertex(v.x, v.y, v.z);
    }
    sh.endShape();
    for (int i = 0; i < indices.size(); i++) {
      sh.setFill(i, fill);
    }
    shape(sh);
  }
}

int ofGetFrameNum() {
  return frameCount;
}
void ofRotateX(float degrees) {
  rotateX(radians(degrees));
}
void ofRotateY(float degrees) {
  rotateY(radians(degrees));
}
void ofRotateZ(float degrees) {
  rotateZ(radians(degrees));
}
float ofMap(float value, float inputMin, float inputMax, float outputMin, float outputMax) {
  return map(value, inputMin, inputMax, outputMin, outputMax);
}

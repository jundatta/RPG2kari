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
  int getNumVertices() {
    return vertices.size();
  }
  void addColor(color c) {
    colors.append(c);
  }
  void addIndex(int ix) {
    indices.append(ix);
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
}

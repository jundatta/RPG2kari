// コングラチュレーション画面
//
// 【作者】KABIVELAROさん
// 【作品名】Cora´s late night walks
// https://openprocessing.org/sketch/1247325
//

class GameSceneCongratulations313 extends GameSceneCongratulationsBase {
  float x=592;
  float y=340;
  float incrementoX=0;
  float incrementoY=0;

  PGraphics pg;

  final int orgW = 600;
  final int orgH = 600;

  @Override void setup() {
    pg = createGraphics(orgW, orgH);
  }
  @Override void draw() {
    push();
    background(#d8d8d9); //PAVIMENTO

    pg.beginDraw();
    pg.background(#d8d8d9); //PAVIMENTO
    pg.strokeWeight(0); // ANCHO DE TODAS LAS FIGURAS SIGUIENTES
    pg.fill(#6D7349); //PASTO BASE ORDEN ESPIRAL DER. IZQ. ARRIBA ABAJO
    pg.quad(331.93, 84.15, 589.26, 110.47, 464.9, 208.52, 371.62, 152.29);
    pg.quad(581.13, 148.06, 581.13, 308.82, 551.89, 328.17, 459.0987, 241.7565);
    pg.quad(360.04, 316.33, 431.3948, 269.5708, 528.9, 346.88, 465.26, 386.76);
    pg.quad(333.85, 342.52, 435.28, 411.4, 259.5, 521.8, 238.4, 432.16);
    pg.quad(212.08, 431.37, 234.11, 524.08, 181.98, 548.91, 152.4, 468.12);
    pg.quad(134.08, 447.11, 192.73, 413.16, 202.19, 319.96, 79.77, 306.02);
    pg.quad(271.8245, 125.6884, 250.6098, 290.5786, 95.8726, 271.2774, 68.8274, 246.6095);
    pg.quad(280.1675, 294.8617, 307.7209, 145.5301, 428.0269, 224.7068, 328.1647, 298.7736);
    pg.triangle(315.27, 325.3, 225.75, 408.12, 234.9, 322.02);
    pg.fill(#3B4022); //PASTO SUPERIOR
    pg.quad(371.38, 101.58, 539.63, 118.79, 458.31, 182.89, 397.33, 146.13);
    pg.quad(562.9866, 182.8888, 558.41, 287.48, 543.41, 297.4, 488.1958, 244.0333);
    pg.quad(386.3496, 318.45, 454.7143, 364.2102, 500.4449, 342.23, 435.2811, 293.8739);
    pg.quad(323.73, 366.94, 390.12, 414.77, 275.07, 491.41, 261.26, 429.18);
    pg.quad(205.64, 451.48, 220.13, 512.46, 185.84, 528.79, 166.38, 475.66);
    pg.quad(136.37, 424.12, 179.59, 399.1, 186.56, 330.43, 96.35, 320.14);
    pg.quad(236.51, 269.57, 131.55, 256.3, 113.2, 239.33, 257.44, 152.23);
    pg.quad(318.13, 174.96, 397.4, 227.13, 331.6, 275.93, 297.52, 273.6);
    pg.triangle(282.34, 337.97, 245.85, 371.72, 249.58, 336.64);
    pg.fill(#8E445F); //JACARANDAS 1
    pg.ellipse(488.4941, 342.23, 23.9017, 23.9017);
    pg.ellipse(363.7205, 424.7092, 29.5996, 29.5996);
    pg.ellipse(332.6593, 426.1708, 32.5228, 32.5228);
    pg.ellipse(339.3675, 355.4685, 23.9017, 23.9017);
    pg.ellipse(187.392, 333.2498, 29.5996, 29.5996);
    pg.ellipse(156.3308, 334.7114, 32.5228, 32.5228);
    pg.ellipse(242.0068, 223.3178, 29.5996, 29.5996);
    pg.ellipse(210.9456, 224.7794, 32.5228, 32.5228);
    pg.fill(#A74974); //JACARANDAS 2
    pg.ellipse(470.3621, 360.3526, 35.6674, 35.6674);
    pg.ellipse(342.762, 439.509, 41.0717, 41.0717);
    pg.ellipse(321.2356, 373.5911, 35.6674, 35.6674);
    pg.ellipse(166.4335, 348.0495, 41.0717, 41.0717);
    pg.ellipse(221.0483, 238.1176, 41.0717, 41.0717);
    //CONDICIONALES
    if (x==592) {
      if (y==340) {
        incrementoX=-1;
        incrementoY=0;
      }// INICIO DER. A IZQ.
    }
    if (x==544) {
      if (y==340) {
        incrementoX=-1;
        incrementoY=-1;
      } //DER A IZQ DIAGONAL HACIA ARRIBA
    }
    if (x==433) {
      if (y==229) {
        incrementoX=-1;
        incrementoY=1;
      }//DER A IZQ DIAGONAL HACIA ABAJO
    }
    if (x==220) {
      if (y==442) {
        incrementoX=0;
        incrementoY=-1;
      }//ABAJO HACIA ARRIBA
    }
    if (x==220) {
      if (y==306) {
        incrementoX=1;
        incrementoY=0;
      }//IZQ A DER
    }
    if (x==276) {
      if (y==306) {
        incrementoX=0;
        incrementoY=-1;
      }//ABAJO HACIA ARRIBA
    }
    if (x==276) {
      if (y==112) {
        incrementoX=1;
        incrementoY=-1;
      }//IZQ A DER DIAGONAL HACIA ARRIBA
    }
    if (x==322) {
      if (y==66) {
        incrementoX=1;
        incrementoY=0;
      }//IZQ A DER
    }
    if (x==592) {
      if (y==66) {
        incrementoX=0;
        incrementoY=1;
      }// FINAL ARRIBA A ABAJO
    }
    pg.fill(#a38e71);//CORA
    x=x+incrementoX;
    y=y+incrementoY;
    pg.ellipse(x, y, 10, 10);
    pg.endDraw();
    image(pg, width - ((width+orgW)*0.5 + 30), height - ((height+ orgH)*0.5));
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

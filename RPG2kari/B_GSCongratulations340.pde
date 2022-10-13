// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】Michael R Escobarさん
// 【作品名】Cityscape and stars
// https://openprocessing.org/sketch/982918
//

class GameSceneCongratulations340 extends GameSceneCongratulationsBase {
  PGraphics pg;
  @Override void setup() {
    pg = createGraphics(1000, height);
    pg.beginDraw();
    pg.background(47, 49, 190);
    pg.endDraw();
  }
  @Override void draw() {
    push();
    pg.beginDraw();
    pg.scale(2);
    pg.rectMode(CORNER);
    //fade;
    pg.fill(47, 49, 190, 20);
    pg.rect(0, 0, width, height/2);

    //littlestars;
    pg.noStroke();
    pg.fill(250, 250, 250);

    pg.circle(random(width), random(height/2), 1);
    pg.circle(random(width), random(height/2), 1);
    pg.circle(random(width), random(height/2), 2);
    pg.circle(random(width), random(height/2), 2);

    // star 1;
    pg.noStroke();
    pg.fill (237, 241, 88); // windows,moon;
    pg.triangle (30, 70, 30, 100, 20, 100); // triangle 1;
    pg.triangle (30, 70, 40, 100, 30, 100); // triangle 2;
    pg.triangle (20, 100, 30, 100, 30, 120); // triangle 3;
    pg.triangle (30, 100, 40, 100, 30, 120); // triangle 4;
    pg.fill (243, 246, 242); //white star color;
    pg.triangle (10, 100, 30, 93, 30, 100); // triangle 5;
    pg.triangle (10, 100, 30, 100, 30, 107); // triangle 6;
    pg.triangle (30, 93, 50, 100, 30, 100); // triangle 7;
    pg.triangle (30, 100, 50, 100, 30, 107); // triangle 8;

    // star 2;
    pg.fill (237, 241, 88); // windows,moon;
    pg.triangle (220, 10, 220, 30, 210, 30); // triangle 1;
    pg.triangle (220, 10, 230, 30, 220, 30); // triangle 2;
    pg.triangle (210, 30, 220, 30, 220, 50); // triangle 3;
    pg.triangle (220, 30, 230, 30, 220, 50); // triangle 4;
    pg.fill (243, 246, 242); //white star color;
    pg.triangle (220, 22, 220, 30, 200, 30); // triangle 5;
    pg.triangle (220, 30, 220, 37, 200, 30); // triangle 6;
    pg.triangle (220, 22, 240, 30, 220, 30); // triangle 7;
    pg.triangle (220, 30, 240, 30, 220, 37); // triangle 8;

    // moon 1;
    pg.fill (237, 241, 88); // windows,moon;
    pg.noStroke();
    pg.circle (80, 40, 40); // ellipse 1;
    pg.fill (47, 49, 190); // sky;
    pg.ellipse (110, 40, 65, 50); // circle 2;
    pg.stroke(1);

    // mountain 1;
    pg.fill (63, 14, 168); // mountains;
    pg.circle (70, 150, 40); // circle 2;
    pg.circle (50, 160, 30); // circle 1;
    pg.circle (150, 120, 30); // circle 4;
    pg.circle (120, 160, 80); // circle 3;
    pg.circle (270, 100, 50); // circle 6;
    pg.circle (380, 80, 40); // circle 8;
    pg.circle (320, 110, 100); // circle 7;
    pg.circle (220, 160, 160); // circle 5;
    pg.circle (140, 170, 50); // circle 10;
    pg.circle (440, 115, 150); // circle 9;

    pg.circle (170, 160, 20); // circle 11;
    pg.circle (400, 160, 40); // circle 12;
    pg.circle (450, 140, 30); // circle 14;
    pg.circle (430, 160, 60); // circle 13;

    pg.circle (480, 160, 80); // circle 15;

    // background 3;
    pg.fill (29, 122, 103);// grass;
    pg.rect (380, 160, 120, 140); // rect 1;

    // background 2;
    pg.fill (29, 122, 103);// grass;
    pg.triangle (0, 160, 370, 160, 370, 300); // triangle 1;

    // tree 2;
    pg.fill (142, 107, 60); // tree bark;
    pg.rect (100, 160, 10, 30); // rect 1;
    pg.fill (20, 42, 39); // tree leaves;
    pg.circle (100, 160, 20); // circle 1;
    pg.circle (100, 150, 20); // circle 2;
    pg.circle (110, 140, 20); // circle 3;
    pg.circle (120, 150, 20); // circle 4;
    pg.circle (110, 160, 20); // circle 5;

    // tree 3;
    pg.fill (142, 107, 60); // tree bark;
    pg.rect (200, 160, 10, 20); // rect 1;
    pg.fill (20, 42, 39); // tree leaves;
    pg.circle (200, 160, 20); // circle 1;
    pg.circle (200, 150, 20); // circle 2;
    pg.circle (210, 150, 20); // circle 3;
    pg.circle (210, 160, 20); // circle 4;
    pg.ellipse (200, 140, 20, 30);

    // tree 4;
    pg.fill (142, 107, 60); // tree bark;
    pg.rect (250, 180, 10, 40); // rect 1;
    pg.fill (20, 42, 39); // tree leaves;
    pg.circle (250, 180, 20); // circle 1;
    pg.circle (240, 170, 20); // circle 2;
    pg.circle (240, 160, 20); // circle 3;
    pg.circle (250, 150, 20); // circle 4;
    pg.circle (260, 160, 20); // circle 5;
    pg.circle (270, 170, 20); // circle 6;
    pg.circle (260, 180, 20); // circle 7;
    pg.circle (250, 170, 20); // circle 8;

    // road 1;
    pg.fill (21, 82, 138); // road;
    pg.triangle (0, 160, 370, 300, 290, 300); // triangle 1;

    // background 1;
    pg.fill (29, 122, 103);// grass;
    pg.triangle (0, 160, 290, 300, 0, 300); // triangle 1;


    // building 11;
    pg.fill (174, 56, 41); // church dome roofs;
    pg.ellipseMode (RADIUS);
    pg.ellipse (340, 170, 50, 80); // ellipse 1;
    pg.fill (176, 127, 130); // middle dome roof;
    pg.rect (320, 100, 40, 70); // rect 4;
    pg.fill (237, 247, 244); // dome band 2nd tier;
    pg.rect (290, 170, 30, 10); // rect 1;
    pg.fill (237, 247, 244); // dome band 2nd tier;
    pg.rect (320, 170, 40, 10); // rect 2;
    pg.fill (237, 247, 244); // dome band 2nd tier;
    pg.rect (360, 170, 30, 10); // rect 3;
    pg.fill (237, 247, 244); // dome band 2nd tier;
    pg.square (330, 80, 10); // square 1;
    pg.square (340, 80, 10); // square 2;
    pg.fill (153, 212, 233); // steeple left;
    pg.triangle (330, 80, 340, 30, 340, 80); // triangle 1;
    pg.fill (65, 146, 207); // steeple right;
    pg.triangle (340, 80, 340, 30, 350, 80); // triangle 2;
    pg.triangle (330, 20, 340, 10, 340, 20); //triangle 3;
    pg.line (340, 10, 340, 27); // line 1;
    pg.fill (237, 247, 244); // dome band 3rd tier;
    pg.rect (320, 90, 40, 10); // rect 5;

    // building 10;
    pg.fill (82, 165, 200);// facing walls;
    pg.rect (290, 200, 100, 40); // rect 1;
    pg.fill (143, 211, 229); // slanted walls;
    pg.rect (270, 200, 20, 20); // rect 7;
    pg.fill (174, 56, 41); // church dome roofs;
    pg.ellipseMode (RADIUS);
    pg.ellipse (290, 220, 20, 20); // ellipse 1;
    pg.ellipseMode (RADIUS);
    pg.ellipse (370, 220, 20, 20); // ellipse 2;
    pg.fill (143, 211, 229); // slanted walls;
    pg.rect (270, 220, 10, 20); // rect 2;
    pg.fill (65, 146, 207); // steeple right;
    pg.rect (280, 220, 30, 20); // rect 3;
    pg.fill (143, 211, 229); // slanted walls;
    pg.rect (320, 210, 20, 30); // rect 4;
    pg.fill (143, 211, 229); // slanted walls;
    pg.rect (350, 220, 30, 20); // rect 5;
    pg.fill (65, 146, 207); // steeple right;
    pg.rect (380, 220, 10, 20); // rect 6;
    pg.fill (143, 211, 229); // slanted walls dome band 1st tier;
    pg.rect (290, 180, 20, 20); // rect 8;
    pg.fill (143, 211, 229); // slanted walls dome band 1st tier;
    pg.rect (310, 180, 40, 20); // rect 9;
    pg.fill (143, 211, 229); // slanted walls dome band 1st tier;
    pg.rect (350, 180, 40, 20); // rect 10;
    pg.fill (174, 56, 41); // church dome roofs;
    pg.triangle (280, 180, 290, 200, 270, 200); // triangle 1;
    pg.triangle (330, 200, 340, 210, 320, 210); // triangle 2;
    pg.fill (237, 241, 88); // windows,moon;
    pg.ellipseMode (CENTER);
    pg.ellipse (330, 220, 10, 10); // ellipse 3;
    pg.ellipseMode (CENTER);
    pg.ellipse (300, 190, 10, 10); // ellipse 4;
    pg.ellipseMode (CENTER);
    pg.ellipse (330, 190, 10, 10); // ellipse 5;
    pg.ellipseMode (CENTER);
    pg.ellipse (370, 190, 10, 10); // ellipse 6;

    // building 12;
    pg.fill (142, 107, 60); //church walls right;
    pg.rect (390, 200, 110, 20); // rect 2;
    pg.fill (174, 56, 41); // church dome roofs;
    pg.rect (390, 185, 110, 05); // rect 4;
    pg.fill (160, 164, 132); // church walls left;
    pg.rect (390, 190, 110, 10); //slanted church wall;
    pg.fill (237, 241, 88); // windows,moon;
    pg.ellipseMode (RADIUS);
    pg.ellipse (410, 210, 05, 05); // window;
    pg.fill (142, 107, 60); //church walls right;
    pg.rect (390, 210, 20, 40); // rect 3;
    pg.fill (174, 56, 41); // church dome roofs;
    pg.triangle (390, 210, 400, 200, 410, 210);
    pg.fill (237, 241, 88); // windows,moon;
    pg.ellipse (427, 210, 05, 05); // window 1;
    pg.ellipseMode (RADIUS);
    pg.ellipse (446, 210, 05, 05); // window 2;
    pg.ellipseMode (RADIUS);
    pg.ellipse (465, 210, 05, 05); // window 3;
    pg.ellipseMode (RADIUS);
    pg.ellipse (483, 210, 05, 05); // window 4;
    pg.ellipseMode (RADIUS);
    pg.ellipse (500, 210, 05, 05); // window 5;

    // building 9;
    pg.fill (134, 94, 41); // brick walls;
    pg.rect (310, 240, 190, 30); // rect 1;
    pg.rect (310, 230, 10, 10); // rect 2;
    pg.rect (330, 230, 10, 10); // rect 3;
    pg.rect (350, 230, 10, 10); // rect 4;
    pg.rect (370, 230, 10, 10); // rect 5;
    pg.rect (390, 230, 10, 10); // rect 6;
    pg.rect (410, 230, 10, 10); // rect 7;
    pg.rect (430, 230, 10, 10); // rect 8;
    pg.rect (450, 230, 10, 10); // rect 9;
    pg.rect (470, 230, 10, 10); // rect 10;
    pg.rect (490, 230, 10, 10); // rect 11;

    // building 7;
    pg.fill (143, 211, 229); // slanted walls;
    pg.rect (425, 270, 30, 20); // rect 1;
    pg.fill (82, 165, 200);// facing walls;
    pg.rect (450, 270, 20, 20); // rect 2;
    pg.fill (131, 72, 32);// house Roof tops;
    pg.rect (450, 250, 10, 20); // rect 3;
    pg.fill (196, 77, 60); // barn doors;
    pg.rect (430, 280, 10, 10); // rect 4;
    pg.fill (131, 72, 32);// house Roof tops;
    pg.triangle (430, 250, 430, 270, 415, 270); // triangle 1;
    pg.fill (143, 211, 229); // slanted walls;
    pg.triangle (430, 250, 430, 270, 420, 270); // triangle 1;
    pg.triangle (430, 250, 450, 270, 430, 270); // triangle 2;
    pg.fill (131, 72, 32);// house Roof tops;
    pg.triangle (430, 250, 450, 250, 450, 270); // triangle 3;
    pg.triangle (460, 250, 480, 270, 460, 270); // triangle 4;

    // building 8;
    pg.fill (17, 15, 35); // chimney;
    pg.rect (480, 250, 10, 30); // rect 1;
    pg.fill (131, 72, 32);// house Roof tops;
    pg.triangle (470, 280, 470, 300, 443, 300); // triangle 1;
    pg.fill (141, 205, 225); // church doors;
    pg.triangle (470, 280, 470, 300, 448, 300); // triangle 1;
    pg.fill (141, 205, 225); // church doors;
    pg.triangle (470, 280, 500, 300, 470, 300); // triangle 2;
    pg.fill (131, 72, 32);// house Roof tops;
    pg.triangle (470, 280, 500, 280, 500, 300); // triangle 3;
    pg.fill (102, 101, 91); // smoke;
    pg.triangle (480, 240, 490, 240, 480, 250); // triangle 4;
    pg.triangle (480, 230, 480, 240, 470, 240); // triangle 5;
    pg.triangle (480, 220, 490, 220, 480, 230); // triangle 6;
    pg.triangle (470, 210, 480, 220, 470, 220); // triangle 7;
    pg.triangle (460, 200, 470, 200, 470, 210); // triangle 8;
    pg.triangle (460, 190, 460, 200, 450, 200); // triangle 9;
    pg.triangle (440, 180, 450, 190, 440, 190); // triangle 10;
    //pg.fill (141, 205, 225); // church doors;
    //pg.ellipseMode (CENTER);
    //pg.ellipse (470, 300, 30, 25);

    // building 6;
    pg.fill (131, 72, 32);// house Roof tops;
    pg.rect (365, 260, 55, 20); // rect 2;
    pg.triangle (355, 260, 355, 280, 345, 280); // triangle 1;
    pg.triangle (420, 260, 430, 280, 420, 280); // triangle 2;
    pg.fill (131, 72, 32);// house Roof tops;
    pg.triangle (355, 260, 365, 280, 355, 280); //triangle 3;
    pg.fill (131, 72, 32);// house Roof tops;
    pg.triangle (355, 260, 365, 260, 365, 280); //triangle 4;
    pg.fill (141, 205, 225); // church doors;
    pg.ellipseMode (CENTER); // Door;
    pg.ellipse (357, 280, 13, 20);
    pg.fill (143, 211, 229); // slanted walls;
    pg.square (350, 280, 20);
    pg.fill (82, 165, 200);// facing walls;
    pg.rect (365, 280, 55, 20); // rect 1;
    pg.fill (237, 241, 88); // windows,moon;
    pg.ellipseMode (CENTER);
    pg.ellipse (380, 290, 10, 10); // ellipse 1;
    pg.ellipseMode (CENTER);
    pg.ellipse (400, 290, 10, 10); //ellipse 2;
    //pg.fill (196, 77, 60); // barn doors;
    //pg.ellipseMode (CENTER); // Door;
    //pg.ellipse (357, 300, 10, 30);


    //building 1;
    pg.fill (82, 165, 200);// facing walls;
    pg.rect (0, 260, 50, 30); // rect 1;
    pg.fill (143, 211, 229); // slanted walls;
    pg.rect (50, 260, 40, 30); //rect 2;
    pg.fill (196, 77, 60); // barn doors;
    pg.rect (60, 270, 10, 20); //rect 3;
    pg.rect (70, 270, 10, 20); // rect 4;
    pg.fill (131, 72, 32);// house Roof tops;
    pg.rect (10, 240, 40, 20); // rect 5;
    pg.rect (0, 250, 10, 10); // rect 6;
    pg.triangle (10, 240, 10, 250, 0, 250); // triangle 1;
    pg.triangle (50, 240, 70, 240, 50, 260); //triangle 2;
    pg.fill (143, 211, 229); // slanted walls;
    pg.triangle (70, 240, 90, 260, 50, 260); //triangle 3;
    pg.fill (237, 241, 88); // windows,moon;
    pg.ellipse (0, 270, 10, 10); // ellipse 1;
    pg.ellipse (20, 270, 10, 10); // ellipse 2;
    pg.ellipse (40, 270, 10, 10); // ellipse 3;
    pg.ellipse (70, 250, 10, 10); // ellipse 4;
    pg.fill (27, 75, 70); // hedges;
    pg.ellipseMode (RADIUS);
    pg.ellipse (10, 290, 10, 10); // ellipse 5;
    pg.ellipseMode (RADIUS);
    pg.ellipse (20, 290, 10, 10); // ellipse 6;
    pg.ellipseMode (RADIUS);
    pg.ellipse (30, 290, 10, 10); // ellipse 7;
    pg.ellipseMode (RADIUS);
    pg.ellipse (40, 290, 10, 10); // ellipse 8;
    pg.fill (29, 122, 103);// grass;
    pg.rect (0, 290, 80, 10); // corner landscape;

    // building 4;
    pg.fill (82, 165, 200);// facing walls;
    pg.rect (170, 250, 50, 30); // rect 1;
    pg.fill (131, 72, 32);// house Roof tops;
    pg.rect (160, 240, 60, 10); // rect 2;
    pg.fill (17, 15, 35); // chimney;
    pg.rect (200, 220, 10, 20); // rect 3;
    pg.fill (131, 72, 32);// house Roof tops;
    pg.triangle (220, 240, 230, 250, 220, 250); // triangle 1;
    pg.fill (102, 101, 91); // smoke;
    pg.triangle (200, 210, 210, 210, 200, 220); // triangle 2;
    pg.triangle (200, 200, 200, 210, 190, 210); // triangle 3;
    pg.triangle (190, 190, 200, 200, 190, 200); // triangle 4;
    pg.triangle (170, 180, 180, 190, 170, 190); // triangle 5;
    pg.fill (237, 241, 88); // windows,moon;
    pg.ellipseMode (CENTER);
    pg.ellipse (180, 260, 10, 10); // ellipse 1;
    pg.ellipseMode (CENTER);
    pg.ellipse (210, 260, 10, 10); // ellipse 2;

    // building 5;
    pg.fill (131, 72, 32);// house Roof tops;
    pg.rect (200, 270, 70, 20); // rect 1;
    pg.fill (82, 165, 200);// facing walls;
    pg.rect (200, 290, 70, 10); // rect 2;
    pg.fill (17, 15, 35); // chimney;
    pg.rect (250, 240, 10, 30); // rect 3;
    pg.fill (131, 72, 32);// house Roof tops;
    pg.triangle (200, 270, 200, 290, 190, 290); // triangle 1;
    pg.triangle (270, 270, 280, 290, 270, 290); // triangle 2;
    pg.fill (102, 101, 91); // smoke;
    pg.triangle (240, 230, 250, 240, 240, 240); // triangle 3;
    pg.triangle (230, 220, 240, 230, 230, 230); // triangle 4;
    pg.triangle (230, 210, 240, 210, 230, 220); // triangle 5;
    pg.triangle (230, 200, 230, 210, 220, 210); // triangle 6;
    pg.triangle (220, 190, 230, 200, 220, 200); // triangle 7;
    pg.triangle (220, 180, 220, 190, 210, 190); // triangle 8;

    //building 3;
    pg.fill (82, 165, 200);// facing walls;
    pg.rect (80, 280, 60, 20); // rect 1;
    pg.fill (131, 72, 32);// house Roof tops;
    pg.rect (90, 260, 50, 20); // rect 2;
    pg.fill (143, 211, 229); // slanted walls;
    pg.rect (150, 250, 20, 50); // rect 4;
    pg.fill (131, 72, 32);// house Roof tops;
    pg.rect (130, 230, 20, 20); // rect 5;
    pg.fill (143, 211, 229); // slanted walls;
    pg.rect (140, 280, 10, 20);
    pg.fill (131, 72, 32);// house Roof tops;
    pg.triangle (90, 260, 90, 280, 70, 280); // triangle 1;
    pg.triangle (140, 260, 150, 260, 140, 280); // triangle 2;
    pg.fill (143, 211, 229); // slanted walls;
    pg.triangle (140, 280, 150, 260, 150, 280); // triangle 3;
    //pg.fill (196, 77, 60); // barn doors;
    //pg.ellipseMode (CENTER);
    //pg.ellipse (160, 290, 10, 40); // ellipse 4;
    pg.fill (82, 165, 200);// facing walls;
    pg.triangle (150, 290, 170, 300, 150, 300); // triangle 4;
    pg.fill (153, 212, 233); // steeple left;
    pg.triangle (150, 290, 170, 290, 170, 300); // triangle 5;
    pg.triangle (170, 290, 190, 300, 170, 300); // triangle 6;
    pg.fill (143, 211, 229); // slanted walls;
    pg.triangle (160, 230, 170, 250, 150, 250); // triangle 7;
    pg.fill (153, 212, 233); // steeple left;
    pg.triangle (150, 140, 150, 230, 140, 230); // triangle 8;
    pg.fill (65, 146, 207); // steeple right;
    pg.triangle (150, 140, 160, 230, 150, 230); // triangle 9;
    pg.fill (131, 72, 32);// house Roof tops;
    pg.triangle (130, 230, 130, 250, 120, 250); // triangle 10;
    pg.triangle (150, 230, 160, 230, 150, 250); // triangle 11;
    pg.fill (82, 165, 200);// facing walls;
    pg.rect (120, 250, 30, 10); // rect 3;
    pg.fill (237, 241, 88); // windows,moon;
    pg.ellipseMode (CENTER);
    pg.ellipse (90, 290, 10, 10); // ellipse 1;
    pg.ellipseMode (CENTER);
    pg.ellipse (110, 290, 10, 10); // ellipse 2;
    pg.ellipseMode (CENTER);
    pg.ellipse (130, 290, 10, 10); // ellipse 3;
    pg.ellipseMode (CENTER);
    pg.ellipse (160, 250, 10, 10); //ellipse 5;

    // tree 1;
    pg.fill (142, 107, 60); // tree bark;
    pg.rect (10, 180, 10, 40); // rect 1;
    pg.fill (20, 42, 39); // tree leaves;
    pg.circle (10, 180, 20); // circle 1;
    pg.circle (10, 170, 20); // circle 2;
    pg.circle (10, 160, 20); // circle 3;
    pg.circle (10, 150, 20); // circle 4;
    pg.circle (20, 160, 20); // circle 5;
    pg.circle (30, 170, 20); // circle 6;
    pg.circle (20, 180, 20); // circle 7;

    //building 2;
    pg.fill (82, 165, 200);// facing walls;
    pg.rect (20, 210, 50, 20); // rect 1;
    pg.fill (143, 211, 229); // slanted walls;
    pg.rect (70, 210, 30, 20); // rect 2;
    pg.fill (196, 77, 60); // barn doors;
    pg.rect (80, 220, 10, 10); // rect 3;
    pg.fill (143, 211, 229); // slanted walls;
    pg.rect (80, 200, 10, 10); // rect 4;
    pg.fill (131, 72, 32);// house Roof tops;
    pg.rect (20, 200, 50, 10); // rect 5;
    pg.fill (237, 241, 88); // windows,moon;
    pg.rectMode (CENTER);
    pg.rect (30, 220, 10, 10); // rect 6;
    pg.rectMode (CENTER);
    pg.rect (50, 220, 10, 10); // rect 7;
    pg.fill (17, 15, 35); // chimney;
    pg.rect (70, 195, 10, 10); // rect 8;
    pg.fill (131, 72, 32);// house Roof tops;
    pg.triangle (20, 200, 20, 210, 10, 210); // triangle 1;
    pg.triangle (70, 200, 80, 200, 70, 210); // triangle 2;
    pg.fill (143, 211, 229); // slanted walls;
    pg.triangle (80, 200, 80, 210, 70, 210); // triangle 3;
    pg.triangle (90, 200, 100, 210, 90, 210); // triangle 4;
    pg.fill (102, 101, 91); // smoke;
    pg.triangle (60, 180, 70, 180, 70, 190); // triangle 5;
    pg.triangle (60, 170, 70, 170, 60, 180); // triangle 6;
    pg.triangle (50, 160, 60, 160, 60, 170); // triangle 7;
    pg.triangle (50, 150, 60, 150, 50, 160); // triangle 8;
    pg.triangle (40, 140, 50, 140, 50, 150); // triangle 9;
    pg.endDraw();
    image(pg, 0, 0, width, height);
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

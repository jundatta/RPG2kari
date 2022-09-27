// コングラチュレーション画面
//
// こちらがオリジナルです。
// 【作者】osmai11さん
// 【作品名】Pacman
// https://openprocessing.org/sketch/1170377
//

class GameSceneCongratulations303 extends GameSceneCongratulationsBase {
  final float Z = 40;
  final float T = 15;
  float pacx = 11*Z;
  float pacy = 16*Z;
  float pacmx = 0;
  float pacmy = 0;
  float pacd = 0;
  float wacn = 0;
  float score = 0;
  float[] GT = {14, 16, 18, 20};
  float[] ghostx = {9*Z, 10*Z, 11*Z, 12*Z};
  float[] ghosty = {10*Z, 10*Z, 10*Z, 10*Z};
  float[] ghostmx = {1, -1, 0, 0};
  float[] ghostmy = {0, 0, 0, 0};
  float[] ghoststate = {0, 0, 0, 0};
  // colorMode(HSB, 256)に置き換えておく。
  // int[] ghostcol = {color(00, 200, 255), color(220, 125, 255), color(120, 200, 255), color(20, 150, 255)};
  int[] ghostcol;
  float powerpellet = 0;
  float pacstate = 0;
  float life = 0;
  String[] levelstring;
  float w = 23;
  float h = 22;
  float lvlw = w*Z;
  float lvlh = h*Z;
  float[] aap;

  PGraphics pg;

  @Override void setup() {
    pg = createGraphics(920, 880, P3D);

    background(100);
    colorMode(HSB, 256);
    int[] col = {color(00, 200, 255), color(220, 125, 255), color(120, 200, 255), color(20, 150, 255)};
    ghostcol = new int[col.length];
    for (int i = 0; i < ghostcol.length; i++) {
      ghostcol[i] = col[i];
    }
    colorMode(RGB, 256) ;

    String[] str = {
      "11111111111111111111111",
      "1          1          1",
      "1+111 1111 1 1111 111+1",
      "1 111 1111 1 1111 111 1",
      "1                     1",
      "1 111 1 1111111 1 111 1",
      "1     1    1    1     1",
      "11111 1111 1 1111 11111",
      "----1 1         1 1----",
      "11111 1 111-111 1 11111",
      "        1-----1        ",
      "11111 1 1111111 1 11111",
      "----1 1         1 1----",
      "11111 1 1111111 1 11111",
      "1         -1-         1",
      "1 111 1111-1-1111 111 1",
      "1+  1   -------   1  +1",
      "111 1 1 1111111 1 1 111",
      "1     1    1    1     1",
      "1 11111111 1 11111111 1",
      "1                     1",
      "11111111111111111111111"};
    levelstring = str;

    aap = new float[(int)(w*h)];
    for (float i=0; i<w*h; i++) {
      aap[(int)i] = getlevel((i % w)*Z, Z*floor(i/w)) == '1' ? -1 : 0;
    }
  }

  char getlevel(float x, float y) {
    var nstr = levelstring[floor(y/Z)];
    return(nstr.charAt(floor(x/Z)));
  }

  void setlevel(float x, float y, char v) {
    var nstr = levelstring[floor(y/Z)];
    levelstring[floor(y/Z)] = nstr.substring(0, floor(x/Z)) + v + nstr.substring(floor(x/Z)+1);
  }

  float astar(float x2, float y2, float x1, float y1) {
    //var aa = aap.slice(0);
    float[] aa = aap.clone();
    //var q = [x1, y1];
    FloatList q = new FloatList();
    q.append(x1);
    q.append(y1);
    //i = 0
    while (true)
    {
      //var x = q.shift() ;
      //var y = q.shift();
      var x = q.remove(0);
      var y = q.remove(0);
      if (aa[(int)(x+y*w)] == 0)
      {
        if (abs(x-x2)+abs(y-y2) < 2)
        {
          //ellipse(x*Z+Z/2,y*Z+Z/2,Z/4)
          return(atan2(y-y2, x-x2));
        }
        aa[(int)(x+y*w)] = 1;
        //text(i++,x*Z+Z/2,y*Z+Z/2)
        //q.push(x-1, y, x+1, y, x, y-1, x, y+1);
        q.append(x-1);
        q.append(y);
        q.append(x+1);
        q.append(y);
        q.append(x);
        q.append(y-1);
        q.append(x);
        q.append(y+1);
      }
    }
  }

  @Override void draw() {
    push();
    pg.beginDraw();
    pg.background(color(0));

    for (float y=0; y<h; y++)
    {
      var nstr = levelstring[(int)y];
      for (float x=0; x<w; x++)
        if (aap[(int)(x+y*w)] == -1) {
          pg.fill(color(64, 64, 255));
          pg.rect(x*Z, y*Z, Z, Z);
        } else if (nstr.charAt((int)x) == ' ') {
          pg.fill(color(255, 255, 190));
          pg.ellipse(x*Z+Z/2, y*Z+Z/2, Z/4, Z/4);
        } else if (nstr.charAt((int)x) == '+') {
          pg.fill(color(255, 255, 0));
          pg.ellipse(x*Z+Z/2, y*Z+Z/2, Z/2, Z/2);
        }
    }

    if ((pacx % Z < Z/T && pacy % Z < Z/T) || (pacmx == 0 && pacmy == 0))
    {
      if (getlevel(pacx, pacy) == ' ') score++;
      if (getlevel(pacx, pacy) == '+') powerpellet = 500;
      if (pacx >= 0) setlevel(pacx, pacy, '-');
      pacx = (pacx+lvlw) % lvlw;
      if (getlevel(pacx, pacy) == ' ') score++;
      if (pacx >= 0) setlevel(pacx, pacy, '-');

      if (keyPressed) {
        if (keyCode == LEFT) {
          pacmy = 0 ;
          pacmx = -Z/T ;
          pacd = PI;
        }
        if (keyCode == RIGHT) {
          pacmy = 0 ;
          pacmx = Z/T ;
          pacd = 0;
        }
        if (keyCode == UP) {
          pacmy = -Z/T ;
          pacmx = 0 ;
          pacd = PI/2;
        }
        if (keyCode == DOWN) {
          pacmy = Z/T ;
          pacmx = 0 ;
          pacd = PI*3/2;
        }
      }

      float x = pacx+pacmx*T ;
      float y = pacy+pacmy*T;
      if (getlevel(x, y) == '1') {
        pacmx = 0 ;
        pacmy = 0;
      }
    }

    powerpellet--;

    int it = 0;
    for (int i=0; i<4; i++)
    {
      if (ghoststate[i] == 1)
      {
        for (int ix=-1; ix<2; ix+=2)
        {
          pg.fill(color(255)) ;
          pg.stroke(color(0));
          pg.ellipse(ghostx[i]+Z/2+ix*8, ghosty[i]+Z/2, 12, 12);
          pg.fill(color(0));
          pg.ellipse(ghostx[i]+Z/2+ix*8+3*ghostmx[i], ghosty[i]+Z/2+3*ghostmy[i]+1, 4, 4);
        }

        if (pacstate == 0)
        {
          it = 0 ;
          if ((ghostx[i] % Z < Z/GT[i] && ghosty[i] % Z < Z/GT[i]) || (ghostmx[i] == 0 && ghostmy[i] == 0))
          {
            var d = astar(floor(ghostx[i]/Z), floor(ghosty[i]/Z), 11, 10) ;
            ghostmx[i] = cos(d) ;
            ghostmy[i] = sin(d);
            if (dist(ghostx[i], ghosty[i], 11*Z, 10*Z) < 10) ghoststate[i]++;
          }
          ghostx[i] += ghostmx[i]*Z/GT[i] ;
          ghosty[i] += ghostmy[i]*Z/GT[i];
        }
      } else {
        pg.noStroke();
        pg.fill((powerpellet > 0 && powerpellet % 20 > 10) || powerpellet > 100 ? color(0, 0, 255) : ghostcol[i]);
        pg.ellipse(ghostx[i]+Z/2, ghosty[i]+Z/2, Z-4, Z-4);
        pg.rect(ghostx[i]+2, ghosty[i]+Z/2, Z-4, Z/2);
        for (int ix=-1; ix<2; ix+=2)
        {
          pg.fill(color(255)) ;
          pg.stroke(color(0));
          pg.ellipse(ghostx[i]+Z/2+ix*8, ghosty[i]+Z/2, 12, 12);
          pg.fill(color(0));
          pg.ellipse(ghostx[i]+Z/2+ix*8+3*ghostmx[i], ghosty[i]+Z/2+3*ghostmy[i]+1, 4, 4);
        }

        if (ghoststate[i] > 0)
        {
          ghoststate[i]++ ;
          if (ghoststate[i] > 200) ghoststate[i] = 0;
          while ((ghostx[i] % Z < Z/GT[i] && ghosty[i] % Z < Z/GT[i] && (it++ == 0 || random(1) < .25)) || (ghostmx[i] == 0 && ghostmy[i] == 0))
          {
            ghostmx[i] = random(1) < .5 ? 1 : -1 ;
            var x = ghostx[i]+ghostmx[i]*Z ;
            var y = ghosty[i]+ghostmy[i]*Z;
            if (getlevel(x, y) == '1') {
              ghostmx[i] = 0 ;
              ghostmy[i] = 0;
            }
          }
        } else
          if (pacstate == 0)
          {
            it = 0 ;
            var pmx = ghostmx[i] ;
            var pmy = ghostmy[i];
            while ((ghostx[i] % Z < Z/GT[i] && ghosty[i] % Z < Z/GT[i] && (it++ == 0 || random(1) < .25)) || (ghostmx[i] == 0 && ghostmy[i] == 0))
            {
              ghostmx[i] = 0 ;
              ghostmy[i] = 0 ;
              ghostx[i] = (ghostx[i]+lvlw) % lvlw;// ; ghosty[i] = round((ghosty[i]+lvlw) % lvlw)
              if (random(1) < .4) {
                var d = astar(floor(ghostx[i]/Z), floor(ghosty[i]/Z), min(w-1, round(pacx/Z)), round(pacy/Z)) ;
                if (powerpellet > 0) d += PI ;
                ghostmx[i] = cos(d) ;
                ghostmy[i] = sin(d);
              } else
                if (random(1) < .5) {
                  ghostmx[i] = pmx ;
                  ghostmy[i] = pmy;
                } else
                  if (random(1) < .5) {
                    ghostmx[i] = (random(1) < .5) ? 1 : -1;
                  } else {
                    ghostmy[i] = (random(1) < .5) ? 1 : -1;
                  }
              var x = ghostx[i]+ghostmx[i]*Z ;
              var y = ghosty[i]+ghostmy[i]*Z;
              if (getlevel(x, y) == '1') {
                ghostmx[i] = 0 ;
                ghostmy[i] = 0;
              }
            }
            ghostx[i] += ghostmx[i]*Z/GT[i] ;
            ghosty[i] += ghostmy[i]*Z/GT[i];

            if (dist(ghostx[i], ghosty[i], pacx, pacy) < Z) {
              if (powerpellet > -10) {
                ghoststate[i] = 1;
              } else {
                pacstate = 1;
              }
            }
          }
      }
    }

    if (pacstate == 0)
    {
      pacx += pacmx ;
      pacy += pacmy;
      if (pacmx != 0 || pacmy != 0)
        wacn += .5;
      else
        wacn = 3;
      var wac = abs((wacn % 10)-5)*PI/12;

      pg.fill(color(255, 255, 0)) ;
      pg.noStroke();
      pg.beginShape(TRIANGLE_FAN);
      pg.vertex(pacx+Z/2, pacy+Z/2);
      for (var d=pacd+wac; d<pacd-wac+PI*2; d+=PI/12)
      {
        pg.vertex(pacx+Z/2+Z/2*cos(d), pacy+Z/2-Z/2*sin(d));
      }
      pg.endShape();
    } else
    {
      pg.fill(color(255, 255, 0)) ;
      pg.noStroke();
      pg.beginShape(TRIANGLE_FAN);
      pg.vertex(pacx+Z/2, pacy+Z/2);
      for (var d=PI/2+pacstate*PI/100; d<PI*5/2-pacstate*PI/100; d+=PI/20)
      {
        pg.vertex(pacx+Z/2+Z/2*cos(d), pacy+Z/2-Z/2*sin(d));
      }
      pg.endShape();

      if (pacstate++ > 100) {
        pacx = 11*Z ;
        pacy = 16*Z ;
        pacmx = 0 ;
        pacmy = 0 ;
        pacd = 0 ;
        wacn = 0 ;
        pacstate = 0 ;
        life-- ;
        //ghostx = [9*Z, 10*Z, 11*Z, 12*Z];
        //ghosty = [10*Z, 10*Z, 10*Z, 10*Z];
        float[] gx = {9*Z, 10*Z, 11*Z, 12*Z};
        ghostx = gx;
        float[] gy = {10*Z, 10*Z, 10*Z, 10*Z};
        ghosty = gy;
      }
    }

    pg.text("Score: "+score, 50, 25);
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

    //gGameStack.change(new GameSceneTitle());
  }
}

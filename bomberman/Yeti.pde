class Yeti {
  int yX = 512;
  int yY = 64;
  int temporizador = 0;
  int yIncremento = 64;
  int yDecremento = -64;
  boolean morteYeti = false;

  Yeti(int x, int y) {
    yX = x;
    yY = y;
  }

  void desenha() {
    ellipseMode(CENTER);
    if (morteYeti == false) {
      image(yeti,yX, yY);
    }
  }

  void mover() {
    if (morteYeti == false) {

      temporizador++;
      if (random(100) > 50) {
        if (temporizador > 300 && blocos[yX/64+1][yY/64] != 1) {
          yX = yX + yIncremento;
          temporizador = 0;
        }
      } else if (temporizador > 300 && blocos[yX/64-1][yY/64] != 1) {
        yX = yX + yDecremento;
        temporizador = 0;
      }

      temporizador++;

      if (random(100) > 50) {

        if (temporizador > 300 && blocos[yX/64][yY/64+1] != 1) {
          yY = yY + yIncremento;
          temporizador = 0;
        }
      } else if (temporizador > 300 && blocos[yX/64][yY/64-1] != 1) {
        yY = yY + yDecremento;
        temporizador = 0;
      }

      if (blocos[yX/64][yY/64] == 4) {
        morteYeti = true;
      }
      if (blocos[yX/64][yY/64] == 2) {
        blocos[yX/64][yY/64] = 0;
      }
    }
  }
  
 
}

class Monstro {
  int mX = 576;
  int mY = 448;
  int temporizador = 0;
  int mIncremento = 64;
  int mDecremento = -64;
  boolean morteMonstro = false;

  Monstro(int x, int y) {
    mX = x;
    mY = y;
  }

  void desenha() {
    if (morteMonstro == false) {
      image(monstro, mX, mY);
    }
  }

  void mover() {
    if (morteMonstro == false) {

      temporizador++;
      if (random(100) > 50) {
        if (temporizador > 300 && blocos[mX/64+1][mY/64] == 0) {
          mX = mX + mIncremento;
          temporizador = 0;
        }
      } else if (temporizador > 300 && blocos[mX/64-1][mY/64] == 0) {
        mX = mX + mDecremento;
        temporizador = 0;
      }

      temporizador++;

      if (random(100) > 50) {

        if (temporizador > 300 && blocos[mX/64][mY/64+1] == 0) {
          mY = mY + mIncremento;
          temporizador = 0;
        }
      } else if (temporizador > 300 && blocos[mX/64][mY/64-1] == 0) {
        mY = mY + mDecremento;
        temporizador = 0;
      }

      if (blocos[mX/64][mY/64] == 4) {
        morteMonstro = true;
      }
    }
  }
  
 
}

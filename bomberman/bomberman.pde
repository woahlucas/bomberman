int x, y;

//o nMonstros vai definir a quantidade de monstros no jogo (o tamanho do vetor)
int nMonstros = 50;
Monstro[] Monstro = new Monstro[nMonstros];

//o nYeti vai definir a quantidade de yetis no jogo (o tamanho do vetor)
int nYeti = 50;
Yeti[] Yeti = new Yeti[nYeti];

int direcao;
int timer = 0; 
boolean temBomba = false;
boolean gameOver = false;
boolean youWin = false;

PImage chao, gelo, neve, bomba, explosao, monstro, esquerda, direita, baixo, cima, yeti;

PFont p;

int[][] blocos = {  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
  {1, 0, 0, 2, 0, 2, 0, 0, 0, 0, 1}, 
  {1, 0, 1, 0, 1, 0, 1, 0, 1, 2, 1}, 
  {1, 2, 2, 2, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 1, 0, 1, 2, 1, 0, 1, 0, 1}, 
  {1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 1}, 
  {1, 2, 1, 2, 1, 0, 1, 2, 1, 0, 1}, 
  {1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 1, 0, 1, 2, 1, 0, 1, 0, 1}, 
  {1, 0, 0, 0, 0, 2, 0, 0, 0, 2, 1}, 
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}  };

void setup() {
  size(704, 704);
  rectMode(CENTER);
  imageMode(CORNER);
  noStroke();
  x = y = 64;
  
  

  for (int i = 0; i < Monstro.length; i++) {
    Monstro[i] = new Monstro(576, 448);
  }
  
  

  for (int i = 0; i < Yeti.length; i++) {
    Yeti[i] = new Yeti(512, 64);
  }
  chao = loadImage("chao.png");
  gelo = loadImage("gelo.png");
  neve = loadImage("neve.png");
  bomba = loadImage("bomba.png");
  explosao = loadImage("explosao.png");
  monstro = loadImage("monstro.png");
  esquerda = loadImage("esquerda.png");
  direita = loadImage("direita.png");
  baixo = loadImage("baixo.png");
  cima = loadImage("cima.png");
  yeti = loadImage("yeti.png");

  printArray(PFont.list());
  p = createFont("pixel-letters.ttf", 24);
  textFont(p);
}

void draw() {
  background(100);
  criarMapa(); 
  desenhaBomberman(esquerda);
  vetores();
  gameOver();
  youWin();
}

void vetores() {
  for (int i = 0; i < Monstro.length; i++) {
    Monstro[i].desenha();
    Monstro[i].mover();
  }

  for (int i = 0; i < Yeti.length; i++) {
    Yeti[i].desenha();
    Yeti[i].mover();
  }
}

void criarMapa() {
  for (int i = 0; i < blocos.length; i++) {
    for (int j = 0; j < blocos.length; j++) {

      if (blocos[i][j] == 0) {
        image(chao, i*64, j*64);
      }

      if (blocos[i][j] == 1) {
        image(neve, i*64, j*64);
      }

      if (blocos[i][j] == 2) {
        image(gelo, i*64, j*64);
      }
      if (blocos[i][j] == 3) {
        bomba(i*64, j*64, i, j);
      }
      if (blocos[i][j] == 4) {
        timer++;
        image(explosao, i*64, j*64);
        if (timer > 30) {
          blocos[i][j] = 0;
        }
      }
    }
  }
}

void desenhaBomberman(PImage imagemAtual) {
  if (direcao == 0)
    imagemAtual = esquerda;
  if (direcao == 1)
    imagemAtual = direita;
  if (direcao == 2)
    imagemAtual = cima;
  if (direcao == 3)
    imagemAtual = baixo;

  image(imagemAtual, x, y);
}

void bomba(int x, int y, int i, int j) {
  image(bomba, x, y);
  temBomba = true;
  timer++;
  if (timer > 80) {
    blocos[i][j] = 4;
    if (blocos[i+1][j] != 1)
      blocos[i+1][j] = 4;
    if (blocos[i-1][j] != 1)
      blocos[i-1][j] = 4;
    if (blocos[i][j+1] != 1)
      blocos[i][j+1] = 4;
    if (blocos[i][j-1] != 1)
      blocos[i][j-1] = 4;

    timer = 0;
    temBomba = false;
  }
}

void gameOver() {

  //ser atingido pela bomba
  if (blocos[x/64][y/64] == 4) {
    gameOver = true;
  }

  //se o bomberman entrar em contato com um monstro
  for (int i = 0; i < Monstro.length; i++) {
    if (x == Monstro[i].mX && y == Monstro[i].mY && Monstro[i].morteMonstro == false) {
      gameOver = true;
    }
  }

  //se o bomberman entrar em contato com um yeti
  for (int i = 0; i < Yeti.length; i++) {
    if (x == Yeti[i].yX && y == Yeti[i].yY && Yeti[i].morteYeti == false) {
      gameOver = true;
    }
  }

  //se os blocos de gelo acabarem 
  if (contem(2, blocos) == false) {
    gameOver = true;
  }


  if (gameOver) {
    fill(105, 160, 255);
    rect(width/2, height/2, width, height);
    fill(255);
    textAlign(CENTER);
    textSize(64);
    text("GAME OVER", width/2, height/2-100);
    textSize(42);
    text("Reinicie o programa\npara jogar novamente", width/2, height/2+50);
  }
}


void youWin() {

  int aux1 = 0;
  int aux2 = 0;


  //se o bomberman matar todos os inimigos 
  for (int i = 0; i < Monstro.length; i++) {
    if (Monstro[i].morteMonstro == true) {
      aux1 = aux1 + 1;
    }
  }
  for (int i = 0; i < Yeti.length; i++) {
    if (Yeti[i].morteYeti == true) {
      aux2 = aux2 + 1;
    }
  }

  if (aux1 == Monstro.length && aux2 == Yeti.length)
    youWin = true;

  if (youWin) {
    fill(105, 160, 255);
    rect(width/2, height/2, width, height);
    fill(255);
    textAlign(CENTER);
    textSize(64);
    text("YOU WIN", width/2, height/2-100);
    textSize(42);
    text("Reinicie o programa\npara jogar novamente", width/2, height/2+50);
  }
}


void keyPressed() {
  if (keyCode == DOWN &&  blocos[x/64][y/64+1] == 0) {
    y = y + 64; 
    direcao = 3;
  }

  if (keyCode == UP &&  blocos[x/64][y/64-1] == 0) {
    y = y - 64; 
    direcao = 2;
  }


  if (keyCode == RIGHT &&  blocos[x/64+1][y/64] == 0) {
    x = x + 64; 
    direcao = 1;
  }


  if (keyCode == LEFT &&  blocos[x/64-1][y/64] == 0) {
    x = x - 64;
    direcao = 0;
  }


  if (key == ' ' && temBomba == false) {
    blocos[x/64][y/64] = 3;
  }
}

//verificar se na matriz existe um bloco de gelo 
boolean contem( int l, int[][] matriz2d) {
  for ( int[] matriz1d : matriz2d)  for ( int v : matriz1d)
    if (v == l)  return true;
  return false;
}

// card images https://code.google.com/p/vector-playing-cards/
// http://www.rgbhex.com/  COLORS

// for the initial setup
// the tableaus will be in an array
// the piles of cards in the tableaus will be linked lists of nodes
// these nodes will point to the next cards

// the cards will be represented by nodes
// the cards will have a boolean to represent face up/down
// the cards also need to have values and names 
// the values will determine if a move is valid or not 

// there are 104 cards
// in the setup, 54 cards are put in the columns
// there are 10 tableaus (hence array of length 10) 
// first 4 have 6 cards, other 6 have 5 cards
// other 50 cards are in the stock

// easy: only one suit (spades)


//Imports sound library
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
Minim minim;

AudioPlayer soundMedieval, soundFunk;

int points;
int numCompletedTableaus;

import java.util.ArrayList;
import java.util.Collections;

LL[] tableaus;
ArrayList<Node> stock = new ArrayList<Node>();
Node[] cards = new Node[104]; 
ArrayList<Integer> list = new ArrayList<Integer>(); // random ints to 104
int listPos = 0; 
PImage[] imgs = new PImage[14];
int[] columns = new int[10];

boolean illegalmove = false;
boolean gameover = false;
ArrayList<Node> upCards = new ArrayList<Node>();
Node tmpCard;


// width card = 500
// length card = 760
// loads card images
PImage img1, img2, img3, img4, img5, img6, img7, img8, img9, img10, img11, img12, img13;
// how to scale image: scale(decimal number)
// how to print image: image(imageName, x, y)
int column1 = 200-40;
int column2 = 775-40;
int column3 = 1350-40;
int column4 = 1925-40;
int column5 = 2500-40;
int column6 = 3075-40;
int column7 = 3650-40;
int column8 = 4225-40;
int column9 = 4800-40;
int column10 = 5375-40;
  

int instX, instY;
int startX, startY;
int menuX, menuY;
color instC, startC, menuC;
int instH, instL;
int startH, startL;
int menuH, menuL;

int circlePlayX, circlePlayY;
int circlePlaySize;
color circlePlayC;

boolean inst = false;
boolean start = false;
boolean menuI = false;
boolean menuS = false;
boolean circlePlay = false;
boolean play = false;

boolean rectInstOver = false;
boolean rectStartOver = false;
boolean rectMenuSOver = false;
boolean rectMenuIOver = false;
// play button
boolean circlePlayOver = false;

boolean tinted = false;

// sound stuff
int sound1X, sound1Y;
int sound2X, sound2Y;
int soundL = 100+10; 
int soundW = 33;
color sound1, sound1H, sound2, sound2H;
color soundLight, soundDark;
color soundHlight, soundHdark;
boolean sound1Over = false;
boolean sound2Over = false;
boolean picksound = false;

PFont myFont1, myFont2;
PFont myFont3, myFont4;
PImage imgBalloons, imgStar, imgSad;
int pauser = 0;
int counter = 0;

int quitX = 1300;
int quitY = 700;
int quitL = 100;
int quitH = 34;
color quitC = color(255,204,255);
boolean quitOver = false;

int retryX = 500;
int retryY = 700;
int retryL = 125;
int retryH = 50;
color retryC = color(0,255,255);
boolean retryOver = false;

int closeX = 875;
int closeY = 700;
int closeL = 125;
int closeH = 50;
color closeC = color(255,153,204);
boolean closeOver = false;


void setupImgs() {
  imgs[0] = null;
  imgs[1] = img1;
  imgs[2] = img2;
  imgs[3] = img3;
  imgs[4] = img4;
  imgs[5] = img5;
  imgs[6] = img6;
  imgs[7] = img7;
  imgs[8] = img8;
  imgs[9] = img9;
  imgs[10] = img10;
  imgs[11] = img11;
  imgs[12] = img12;
  imgs[13] = img13;
}

void setupColumns() {
  columns[0] = column1;
  columns[1] = column2;
  columns[2] = column3;
  columns[3] = column4;
  columns[4] = column5;
  columns[5] = column6;
  columns[6] = column7;
  columns[7] = column8;
  columns[8] = column9;
  columns[9] = column10;
}

void setup() {
  setup1();   
}

void setup1() {
  points = 500;
  numCompletedTableaus = 0;
  size(1500, 800);
  background(0,0,102);
  textSize(200);
  textAlign(CENTER);
  myFont2 = createFont("Algerian",200);
  textFont(myFont2);
  text("SOLITAIRE", 750, 375);
  myFont1 = createFont("Lucida Sans",200);    //Grande
  textFont(myFont1);
  //text("SOLITAIRE", 750, 500);
  textAlign(CENTER);
  textSize(75);
  text("By Alice Xue & Emily Xu", 755, 700);
  
  //instructions & start buttons
  instC = color(255,0,0);
  instX = 500+40;
  instY = 500;
  instL = 200;
  instH = 50;
  fill(255,255,110);
  rect(instX, instY, instL, instH);
  fill(255);
  textSize(20);
  textAlign(LEFT);
  fill(0);
  text("Instructions", 585, 532);
  fill(255);
  
  startC = color(255,0,0);
  startX = 700+40;
  startY = 500;
  startL = 200;
  startH = 50;
  fill(110,255,110);
  rect(startX, startY, startL, startH);
  fill(255);
  textSize(20);
  textAlign(LEFT);
  fill(0);
  text("Start", 815, 532); 
  fill(255);
  
  // load card images continued
  img1 = loadImage("1.png");
  img2 = loadImage("2.png");
  img3 = loadImage("3.png");
  img4 = loadImage("4.png");
  img5 = loadImage("5.png");
  img6 = loadImage("6.png");
  img7 = loadImage("7.png");
  img8 = loadImage("8.png");
  img9 = loadImage("9.png");
  img10 = loadImage("10.png");
  img11 = loadImage("11.png");
  img12 = loadImage("12.png");
  img13 = loadImage("13.png");
  
  setupImgs();
  setupColumns();
  
  
  // sound stuff
  soundLight = color(0,191,255);
  soundDark = color(24,116,205);
  soundHlight = color(0,191,255);
  soundHdark = color(24,116,205);
  sound1X = 600+37-10;
  sound1Y = 100;
  sound2X = 700+37;
  sound2Y = 100;
  sound1 = color(186,186,186);
  sound1H = color(89,89,89);
  sound2 = color(186,186,186);
  sound2H = color(89,89,89);
  
    
  // sound stuff
  stroke(color(89,89,89));
  fill(color(186,186,186));
  rect(sound1X, sound1Y, soundL, soundW);
  stroke(color(89,89,89));
  fill(color(186,186,186));
  rect(sound2X, sound2Y, soundL, soundW);
  stroke(0);
  fill(255,255,255);
  text("Pick your music:", 658,85);
  text("Medievally", 632,124);
  text("Funky", 763,124);
  
  minim = new Minim(this);
  soundMedieval = minim.loadFile("MedievalMusic.mp3");
  soundFunk = minim.loadFile("FunkMusic.mp3");
}

void draw() {
  if (!play) {
    update(mouseX, mouseY);
    if (inst == true) {
      //resetBooleans();
      inst = true;
      background(0,0,102);
      
      textAlign(CENTER);
      textSize(30);
      text("Instructions", 750-12, 115);
      textSize(20);
      text("The objective of spider solitaire is to complete as many tableaus as possible.", 750-12, 180);
      text("What that entails is to complete columns of cards in decreasing order of value, from King to Ace.", 750-12, 210);
      text("You are allowed to move cards between columns, but the value of the card you are moving must be one less than that of the card", 750-12, 240);
      text("you are moving to.", 750-12, 270);
      text("You are allowed to move multiple cards in a columns, but the values of each card must be in appropriate descending order.", 750-12, 300);
      text("If there are no possible moves left, you may click the stock of cards on the bottom left.", 750-12, 330);
      text("The stock will put one card on each column.", 750-12, 360);
      text("There are a limited number of cards in the stock, however, so be wise with your decisions.",750-12,390);
      text("You will start off with 500 points. For each move you make, 1 point will be deducted.",750-12,420);
      text("If you complete a column, you will be rewarded with 100 * # of columns you have already completed.",750-12,450);
      text("Have fun!",738,480);    
      textAlign(LEFT);
      
      menuC = color(255,0,0);
      menuX = 700-72;
      menuY = 550;
      menuL = 200+20;
      menuH = 50;
      fill(255,110,110);
      rect(menuX, menuY, menuL, menuH);
      fill(255);
      textSize(20);
      text("Go back to the menu", 638, 583);
    }
    if (start == true) {
      //resetBooleans();
      start = true;
      background(0,0,102);
      textSize(20);
      text("Start", 712, 348);
      circlePlayC = color(255,0,0);
      circlePlayX = 733;
      circlePlayY = 400;
      circlePlaySize = 100;
      fill(110,255,110);
      ellipse(circlePlayX, circlePlayY, circlePlaySize, circlePlaySize);
      fill(255);
      textSize(20);
      fill(0);
      text("PLAY!",675+33,410);
      fill(255);
      menuC = color(255,0,0);
      menuX = 700-72;
      menuY = 550;
      menuL = 200+20;
      menuH = 50;
      fill(255,110,110);
      rect(menuX, menuY, menuL, menuH);
      fill(255);
      textSize(20);
      text("Go back to the menu", 638, 583);
    }
    if (menuI == true) {
      //resetBooleans();
      menuI = true;
      setup1();
    }
    if (menuS == true) {
      //resetBooleans();
      menuS = true;
      setup1();
    }  
    if (circlePlay == true) {
      circlePlay = false;
      play = true;
      background(51,153,0);
      setupGame();
      setupPlay();
    }
    
    // sound stuff
    if (picksound == true){
      if (sound1Over == true){
        //fill(sound1);
        //stroke(sound1H);
        fill(soundLight);
        stroke(soundHlight);
        rect(sound1X, sound1Y, soundL, soundW);
        //fill(sound2);
        //stroke(sound2H);
        fill(soundDark);
        stroke(soundHdark);
        rect(sound2X, sound2Y, soundL, soundW);
        fill(255);
        stroke(0);
        fill(0);
        text("Medievally", 632,124);
        fill(255);
        text("Funky", 763,124);
        fill(255);
      }
      if (sound2Over == true){
        //fill(sound2);
        //stroke(sound2H);
        fill(soundLight);
        stroke(soundHlight);
        rect(sound2X, sound2Y, soundL, soundW);
        //fill(sound1);
        //stroke(sound1H);
        fill(soundDark);
        stroke(soundHdark);
        rect(sound1X, sound1Y, soundL, soundW);
        fill(255);
        stroke(0);
        fill(255);
        text("Medievally", 632,124);
        fill(20);
        text("Funky", 763,124);
        fill(255);
      }
    }
  } 
  if (play) {
    scale(.25);
    setupPlay();
  }    
  //gameover = true;
  if (gameover == true){
    winScreen();
  }
}

void resetBooleans() {
    start = false;
    inst = false;
    menuI = false;
    menuS = false;
    circlePlay = false;
    picksound = false;
}

void resetBooleans2() {
    rectInstOver = false;
    rectStartOver = false;
    rectMenuSOver = false;
    rectMenuIOver = false;
    circlePlayOver = false;  
}

void update(int x, int y) {
  if (overRect(instX, instY, instL, instH)) {
    resetBooleans2();
    rectInstOver = true;
  }
  if (overRect(startX, startY, startL, startH)) {
    resetBooleans2();
    rectStartOver = true;
  }
  if (start == true && overRect(menuX, menuY, menuL, menuH)) {
    resetBooleans2();
    rectMenuSOver = true;
  }
  if (inst == true && overRect(menuX, menuY, menuL, menuH)) {
    resetBooleans2();
    rectMenuIOver = true;
  }
  if (overCircle(circlePlayX, circlePlayY, circlePlaySize)) {
    resetBooleans2();
    circlePlayOver = true;    
  }     
 /* if (overRect(quitX, quitY, quitL, quitH)) {
    quitOver = true;
  }*/
  
  
  // sound stuff
 /* if (overRect(sound1X, sound1Y, soundL, soundW)){
  sound1Over = true;
  sound2Over = false;
  }
  if (overRect(sound2X, sound2Y, soundL, soundW)){
    sound1Over = false;
    sound2Over = true;
  }*/
}

boolean overRect(int x, int y, int w, int h) {
  if (mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h) 
    return true;
  return false;
}

boolean overCircle(int x, int y, int diameter){
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2) 
    return true;
  else 
    return false;
}

boolean overCard(int x, int y){
    // width card = 500
    // length card = 760
    if (mouseX*4 >= x && mouseX*4 <= x+500 && mouseY*4 >= y && mouseY*4 <= y+760)
      return true;
    else 
      return false;
}

Node overSpefCard() {
    int tmpX;
    int tmpY;
    for (int i = 0; i<upCards.size(); i++) {
      Node tmp = upCards.get(i);
      tmpX = tmp.getX();
      tmpY = tmp.getY();          
      if (mouseX*4 >= tmpX && mouseX*4 <= tmpX+500 && mouseY*4 >= tmpY && mouseY*4 <= tmpY+760) 
        return tmp;
    }
    return null;
}

Node overSpefCardT() {
  int t = -1;
  for (int i = 0; i<columns.length; i++) {
    if (mouseX*4 >= columns[i] && mouseX*4 <= columns[i]+500) 
      t = i;
    if (tableaus[i].getFirst() == null) {
      if (overCard(columns[i],150)) {
        return new Node(-1);
      }
    }
  } 
  if (t!=-1) {
    Node n = tableaus[t].getFirst();
    Node m = tableaus[t].getLast();
    if (overCard(m.getX(),m.getY()))    
      return m;
    while (n!=null){
      Node tmp = n.getNext();
      if (tmp!=null) {
        if (n.faceUp() == true && overPartCard(mouseX*4, mouseY*4) && !overCard(tmp.getX(),tmp.getY())) {
          return n;
        }
      }
      n = n.getNext();
    }
  }
  return null;
}
      

boolean overPartCard(int x, int y) {
  if (mouseX*4 >= x && mouseX*4 <= x+500 && mouseY*4 >= y && mouseY < y+120) 
    return true;
  else 
    return false;
}

void mousePressed(){ 
  if (!play) {
    if (rectInstOver == true){
      resetBooleans();
      inst = true;
    }
    if (rectStartOver == true) {
      resetBooleans();
      start = true;
    }
    if (rectMenuSOver == true) {
      resetBooleans();
      menuS = true;
    }
    if (rectMenuIOver == true) {
      resetBooleans();
      menuI = true;
    }
    if (circlePlayOver == true) {
      resetBooleans();
      circlePlay = true;
    }  
    
    
    // sound stuff
   
    if (overRect(sound1X, sound1Y, soundL, soundW) == true){
        picksound = true;
        sound1Over = true;
        sound2Over = false;
        sound1 = soundDark;
        sound1H = soundHdark;
        sound2 = soundLight;
        sound2H = soundHlight;
        
      
        //soundFunk = minim.loadFile("FunkMusic.mp3");
        soundFunk.close();
        soundMedieval.close();
        soundMedieval = minim.loadFile("MedievalMusic.mp3");
        soundMedieval.play();
        //soundFunk.close();
    }
    if (overRect(sound2X, sound2Y, soundL, soundW) == true){
        picksound = true;
        sound2Over = true;
        sound1Over = false;
        sound2 = soundDark;
        sound2H = soundHdark;
        sound1 = soundLight;
        sound1H = soundHlight;
        
        
        //soundMedieval = minim.loadFile("MedievalMusic.mp3");
        soundMedieval.close();
        soundFunk.close();
        soundFunk = minim.loadFile("FunkMusic.mp3");
        soundFunk.play();
        //soundMedieval.close();
    }
      
   /* if (sound1Over == true || sound2Over == true){
      picksound = true;
      if (sound1Over == true){
        sound1 = soundDark;
        sound1H = soundHdark;
        sound2 = soundLight;
        sound2H = soundHlight;
      }
      if (sound2Over == true){
        sound1 = soundLight;
        sound1H = soundHlight;
        sound2 = soundDark;
        sound2H = soundHdark;
      }  
    }*/
  }
  if (play) {          
    if (overCard(column1, 2200) && !stock.isEmpty()) {
      addFromStock();
      illegalmove = false; 
      points--;
    } else {      
      Node tmp = overSpefCardT();      
      if (overSpefCard()!=null && overSpefCardT().getValue()!=-1) {
        if (!tinted) {
          tmpCard = tmp;
          tmp.setTinted(true);
          while (tmp.getNext()!=null) {
            tmp.getNext().setTinted(true);
            tmp = tmp.getNext();
          }
          tinted = true;
          illegalmove = false;
          setupPlay();
        } else if (validMove(tmpCard,tmp)){
          Node tmp1 = tmp;
          Node check = tmpCard;
          int numT = tmpCard.getT();
          int numTmp = tmp.getT();
          tmpCard.setTinted(false);            
          int c = 1;       
          Node tmpCard2 = tmpCard; 
          while (tmpCard.getNext()!=null) {
            tmpCard = tmpCard.getNext();
            c++;
          }   
          while (c>0) {
            tableaus[numT].removeL();
            c--;
          }    
          int checkNum = check.getValue();
          int tmpCardNum = tmpCard.getValue();
          while (checkNum!=tmpCardNum) {
            Node n = new Node(checkNum);
            n.setFace(true);
            tableaus[numTmp].addN(n);
            checkNum--;
          }   
          tmpCard.setTinted(false);
          tableaus[numTmp].addN(tmpCard);
          if (tableaus[numT].getFirst()!=null) {
            tableaus[numT].getLast().setFace(true);         
            upCards.add(tableaus[numT].getLast());
          }         
          tinted = false;
          illegalmove = false;
          points--;
          setupPlay();
        } else if (!validMove(tmpCard,tmp)) {
          illegalmove = true;
          if (tmpCard!=null) {
             tmpCard.setTinted(false);
             while (tmpCard.getNext()!=null) {
               tmpCard.getNext().setTinted(false);
               tmpCard = tmpCard.getNext();
             } 
          }
          tinted = false;
          setupPlay();
        }
       } else if (overSpefCardT()!=null && overSpefCardT().getValue()==-1){
            int index = -1;
            for (int i = 0; i<columns.length; i++) {
              if (tableaus[i].getFirst() == null) {
                if (overCard(columns[i],150)) {
                  index = i;
                }
              }
            }
            if (tmpCard!=null) {
              Node check = tmpCard;
              int numT = tmpCard.getT();
              tmpCard.setTinted(false);            
              int c = 1;        
              Node tmpCard2 = tmpCard; 
              while (tmpCard.getNext()!=null) {
                tmpCard = tmpCard.getNext();
                c++;
              }   
              while (c>0) {
                tableaus[numT].removeL();
                c--;
              }    
              int checkNum = check.getValue();
              int tmpCardNum = tmpCard.getValue();
              while (checkNum!=tmpCardNum) {
                Node n = new Node(checkNum);
                n.setFace(true);
                tableaus[index].addN(n);
                checkNum--;
              }   
              tmpCard.setTinted(false);
              tableaus[index].addN(tmpCard); // bug??
              if (tableaus[numT].getFirst()!=null) {
                tableaus[numT].getLast().setFace(true);         
                upCards.add(tableaus[numT].getLast());
              }   
            }
            points--;
            tmpCard = null;
            tinted = false;
            illegalmove = false;
            setupPlay();
          }
        }
       setupPlay();
    }
    if (overRect(quitX, quitY, quitL, quitH)) {
      quitOver = true;
    }
    if(overRect(retryX, retryY, retryL, retryH)) {
      retryOver = true;
    }
    if(overRect(closeX, closeY, closeL, closeH)) {
      closeOver = true;
    }

}

void setupPlay() {   
  if (completeTableau()!=-1) {
    int i = completeTableau();
    Node tmp = tableaus[i].getFirst();
    while (!tmp.getNext().faceUp()) {
      tmp = tmp.getNext();
    }
    tmp.setNext(null);
    if (tmp.getValue()==13) 
      tmp = null;
    if (tableaus[i].getFirst()!=null) 
      tableaus[i].getLast().setFace(true);
    numCompletedTableaus++;
    points+=(numCompletedTableaus*100);
  }  
  if (numCompletedTableaus == 8) {
    gameover = true;
    return;
  }

  background(34,139,34);  //(0,128,0);   //(51,153,0);
  textSize(100);
  fill(255,204,0);
  text("Score: "+str(points),100,100); 
  int posY = 150;
  for (int i = 0; i<tableaus.length; i++) {
    Node tmp = tableaus[i].getFirst();
    while (tmp!=null) {
      if (!tmp.faceUp()) {
        tint(0, 0, 0, 252);
      }
      if (tmp.getTinted()) {
        tint(0, 153, 204);
      }
      PImage tmpI = imgs[tmp.getValue()];
      int c = columns[i];      
      image(tmpI,c,posY);
      if (tmp!=tableaus[i].getFirst() && tmp.getNext()!=null && tmp.faceUp()==false) {
        strokeCap(ROUND);
        strokeWeight(2);
        stroke(255);
        line(c,posY-1,c+498,posY);
      }
      noTint();
      tmp.setX(c);
      tmp.setY(posY);
      tmp.setT(i);
      tmp = tmp.getNext();
      posY=posY+120;
    }
    posY = 150;
  }
  if (!stock.isEmpty()) {
    Node stocktmp = stock.get(0);
    tint(0, 0, 0, 252);
    image(imgs[stocktmp.getValue()],column1,2200);
  }
  
  // width card = 500
  // length card = 760
  /*
  fill(204, 102, 0);
  rect(column1, 890, 500, 20, 20, 20, 0, 0);
  rect((column1+495), 890, 20, 760-5, 0, 20, 20, 0);
  rect(column1-10, 890, 20, 760-5, 20, 0, 0, 20);
  rect((column1), (865+760), 500, 20, 0, 0, 20, 20);
  textSize(100);
  text("testing^", 160, 1800);
  noFill();
  */
    
  if (illegalmove) {
    textSize(100);
    text("That is not a legal move! Please refer to the instructions if you're not sure why.", 1000, 100);
  }
  scale(4);
  fill(quitC);
  rect(quitX, quitY, quitL, quitH);
  fill(0);
  textSize(20);
  text("Quit", quitX+27, quitY+22); 
  fill(255);
  if (quitOver == true){
    quitScreen(); 
    if (retryOver == true){
      scale(4);
      resetBooleans();
      resetBooleans2();
      setup1();
    }
  }
  scale(.25);
  if (retryOver == true){
    scale(4);
    resetBooleans();
    resetBooleans2();
    setup1();
  }
  if (closeOver == true){
    exit();
  }
    
}

void makeDeck(int startpos) {
  int pos = startpos;
  for (int i = 0; i < 13; i++ ) {
    cards[pos] = new Node(i+1);
    cards[pos+13] = new Node(i+1);
    cards[pos+26] = new Node(i+1);
    cards[pos+39] = new Node(i+1);
    pos++;
  }
}

void easy() {
  makeDeck(0);
  makeDeck(52);
}

void randomgenerator() {
  // unique number generator 
  // http://stackoverflow.com/questions/8115722/generating-unique-random-numbers-in-java
  for (int i = 0; i < 104; i++) {
    list.add(new Integer(i));
  }
  Collections.shuffle(list);
}

int UQint() {
  int result = list.get(listPos);
  listPos++;
  return result;
}

void setupGame() {
  easy();
  randomgenerator();
  // this sets up the tableaus with random cards
  tableaus = new LL[10];
  for (int i = 0; i < tableaus.length; i++) {
    tableaus[i] = new LL(cards[UQint()]);
    if (i < 4) {
      for (int j = 1; j < 6; j++) {
        Node tmp = cards[UQint()];
        /*
        if (j==5) 
          tmp.setFace(true);
          */
        tableaus[i].addN(tmp);
      }
    } else {
      for (int j = 1; j < 5; j++) {
        Node tmp = cards[UQint()];
        /*
        if (j==4) 
          tmp.setFace(true);
          */
        tableaus[i].addN(tmp);
      }
    }
  }  
  
  //fills stock
  for (int i = 0; i < 50; i++) {
    Node tmp = cards[UQint()];
    tmp.setFace(true);
    stock.add(tmp);
  }
  
  // turns the last card in each tableau up
  for (int i = 0; i < tableaus.length; i++) {
    LL tmp = tableaus[i];
    Node tmp2 = tmp.getLast();
    tmp2.setFace(true);
    upCards.add(tmp2);
  }
  
}

// when player clicks stock, this method is called to add new cards to the tableaus
void addFromStock() {
  for (int i = 0; i < tableaus.length; i++) {
     LL l = tableaus[i];
     Node n = stock.get(0);
     n.setFace(true);
     l.addN(n);
     upCards.add(n);
     stock.remove(0);
  }
}


// checks if any columns are complete
// returns -1 if no tableaus are complete
// returns index of tableau if there is one complete
int completeTableau() {
  int tableauIndex = -1;
  for (int i = 0; i < tableaus.length; i++) {
    Node tmp = tableaus[i].getLast();
    if (tmp!=null && tmp.getValue()==1) {
      Node tmp1 = tableaus[i].getFirst();
      Node king = null;
      while (tmp1 != null) {
        if (tmp1.faceUp() == true && tmp1.getValue() == 13) {
            king = tmp1;
        }
        tmp1 = tmp1.getNext();
      }
      if (king!=null) {
        if (validMultipleMove(king)) 
          tableauIndex = i;
      }
    }
  }
  return tableauIndex;
}

boolean validMove(Node card1, Node card2) {
  // move card1 to card 2
  if (card1 == null) 
    return false;
  if (card2 == null)
    return true;
  if (validMultipleMove(card1)) {
    if (card1.getValue()+1 == card2.getValue()) 
      return true;   
  }
  return false;
}

// checks if multiple cards can be moved
boolean validMultipleMove(Node card) {
  Node tmp = card;
  Node tmp2 = card.getNext();
  while (tmp2 != null) {
    if (tmp2.getValue() >= tmp.getValue()) {
      return false;
    }
    if (tmp.getValue()-tmp2.getValue()>1) {
      return false;
    }
    tmp = tmp.getNext();
    tmp2 = tmp.getNext();
  }
  return true;
}

void winScreen(){
  imgBalloons = loadImage("balloons2.jpg");
  scale(1.175);
  image(img2,0,0);
  scale(1/1.175);
  myFont3 = createFont("AR DELANEY", 150);
  textFont(myFont3);
  textAlign(CENTER);
  text("CONGRATULATIONS!", 750, 250);
  myFont4 = createFont("AR Darling", 125);
  textFont(myFont4);
  fill(0);
  text("You won!!!", 750, 400);
  fill(255);
  textAlign(LEFT);
  textFont(myFont1);
  /* imgStar = loadImage("star.jpg");
    scale(.1);
    while (pauser < 10000){
      pauser++;
      if (pauser == 1000){
        while (counter<1000000){
          if (counter/2100030 == 0){
            image(imgStar, random(10000),random(1000)+5000);
            text(str(counter), counter, 80000);
          }
          counter++;
        }
      }
    }
  */
  fill(retryC);
  rect(retryX, retryY, retryL, retryH);
  fill(closeC);
  rect(closeX, closeY, closeL, closeH);
  fill(0);
  textSize(20);
  text("Retry", retryX+34, retryY+30);
  fill(255);
  text("Close", closeX+34, closeY+30);
}

void quitScreen(){
  background(0);
  textAlign(CENTER);
  textSize(200);
  text("You lose", 750, 300);
  fill(255);
  tint(255);
  imgSad = loadImage("sadface.jpg");
  image(imgSad, 600,350); 
  textAlign(LEFT);
  
  fill(retryC);
  rect(retryX, retryY, retryL, retryH);
  fill(closeC);
  rect(closeX, closeY, closeL, closeH);
  fill(0);
  textSize(20);
  text("Retry", retryX+34, retryY+30);
  fill(255);
  text("Close", closeX+34, closeY+30);
}
  
class Node {
  int value;
  boolean up;
  Node next;
  // tint blue if clicked
  boolean tinted;
  
  int x;
  int y;
  int t; //tableau index
  
  PImage card;
  //String cardname;
  
  Node (int v) {
    value = v;
    up = false;
    next = null;
    tinted = false;
  }
  
  void setFace(boolean up1) {
     if (up1) 
      up = true;
     else 
      up = false;
  }
  
  int getValue() {
    return value;
  }
  
  void setValue(int n) {
    value = n;
  }
  
  boolean faceUp() {
    return up;
  }
    
  void setNext(Node n) {
    next = n;
  }
  
  Node getNext() {
    return next;
  }
  
  void setX(int tmpx) {
    x = tmpx;
  }
  
  void setY(int tmpy) {
    y = tmpy;
  }
  
  int getX() {
    return x;
  }
  
  int getY() {
    return y;
  }
  
  void setT(int T) {
    t = T;
  }
  
  int getT() {
    return t;
  }
  
  boolean getTinted() {
    return tinted;
  }
  
  void setTinted(boolean n) {
    if (n==true)
      tinted = true;
    else 
      tinted = false;
  }
}
  
class LL {
  Node l;

  LL(Node n) {
    l = n;
  }
  
  boolean addN(Node n) {
    if (l==null) 
      l = n;
    else
      getLast().setNext(n);
    return true;
  }
  
  // remove last card in tableau 
  boolean removeL() {
    Node tmp = l;
    if (tmp==null || tmp.getNext()==null) {
      l=null;
    } else {
      while (tmp.getNext().getNext()!=null) {
        tmp = tmp.getNext();
      }
      tmp.setNext(null);
    }
    return true;
  }
    
  Node getFirst() {
    return l;
  }  
    
  Node getLast() {
    Node tmp = l;
    if (tmp == null) {
      return null;
    }
    while (tmp.getNext() != null) {
      tmp = tmp.getNext();
    }
    return tmp;
  }
    
}








/*

everytime a card gets called again you print it again??? :( ugh
to play:
click one card a, click another card b. if a = b-1, then a goes on top of b
everything on top of a follows a on top of b

once face up cards are 1 to 13, stack of cards 1 t0 13 disappears
one card (king?) appears at bottom of screen

if nontinted card is removed, leaving tinted card on top of pile, tinted card untints

*/


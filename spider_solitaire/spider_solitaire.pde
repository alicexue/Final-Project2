import java.util.ArrayList;
import java.util.Collections;

LL[] tableaus;
ArrayList<Node> stock;
Node[] cards = new Node[104]; 
ArrayList<Integer> list = new ArrayList<Integer>(); // random ints to 104
int listPos; 

// for the initial setup
// the tableaus will be in an array
// the piles of cards in the tableaus will be linked lists of nodes
// these nodes will point to the next cards

// the cards will be represented by nodes(?)
// the cards will have a boolean to represent face up/down
// the cards also need to have values and names 
// the values will determine if a move is valid or not 

// we need to figure out how the point system works


// there are 104 cards
// in the setup, 54 cards are put in the columns
// there are 10 tableaus (hence array of length 10) 
// first 4 have 6 cards, other 6 have 5 cards
// other 50 cards are in the stock

// easy: only one suit (spades)
// intermediate: two suits (spades and hearts)
// difficult: four suits



int instX, instY;
int startX, startY;
color instC, startC;
int instH, instL;
int startH, startL;
boolean inst = false;
boolean start = false;

void setup() {
  size(1500, 800);
  background(0);
  textSize(200);
  text("SOLITAIRE", 356, 325);
  textSize(75);
  text("By Alice Xue & Emily Xu", 250, 700);
  
  //instructions & start buttons
  instC = color(255,0,0);
  instX = 500;
  instY = 500;
  instL = 200;
  instH = 50;
  rect(instX, instY, instL, instH);
  textSize(20);
  text("Instructions", 500, 500);
  
  startC = color(255,0,0);
  startX = 700;
  startY = 500;
  startL = 200;
  startH = 50;
  rect(startX, startY, startL, startH);
  textSize(20);
  text("Start", 700, 500);
  
}

void draw() {
  //update (mouseX, mouseY);
}

void makeDeck(int startpos, char s1, char s2, char s3, char s4) {
  int pos = startpos;
  for (int i = 0; i < 13; i++ ) {
    cards[pos] = new Node(i+1, s1);
    cards[pos+13] = new Node(i+1, s2);
    cards[pos+26] = new Node(i+1, s3);
    cards[pos+39] = new Node(i+1, s4);
  }
}

void easy() {
  makeDeck(0, 'S', 'S', 'S', 'S');
  makeDeck(52, 'S', 'S', 'S', 'S');
}

void medium() {
  makeDeck(0, 'S', 'S', 'S', 'S');
  makeDeck(52, 'H', 'H', 'H', 'H');
}

void difficult() {
  makeDeck(0, 'S', 'H', 'D', 'C');
  makeDeck(52, 'S', 'H', 'D', 'C');
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
  // this sets up the tableaus with random cards
  tableaus = new LL[10];
  int pos = 0;
  for (int i = 0; i < 4; i++) {
    tableaus[i] = new LL(cards[UQint()]);
    pos++;
    if (i < 4) {
      for (int j = 0; j < 6; i++) {
        tableaus[i].add(cards[UQint()]);
        pos++;
      }
    } else {
      for (int j = 0; j < 5; i++) {
        tableaus[i].add(cards[UQint()]);
        pos++;
      }
    }
  }  
  
  //fills stock
  for (int i = 0; i < 50; i++) {
    stock.set(i,cards[UQint()]);
  }
  
  // turns the last card in each tableau up
  for (int i = 0; i < tableaus.length; i++) {
    tableaus[i].getLast().setFace(true);
  }
}

// when player clicks stock, new cards are added to the tableaus
void addFromStock() {
  int pos = 0;
  for (int i = 0; i < tableaus.length; i++) {
     LL l = tableaus[i];
     Node n = stock.get(pos);
     n.setFace(true);
     l.add(n);
     stock.remove(pos);
     pos++;
  }
}

// checks that the cards in this tableau from n are same suit
boolean sameSuit(Node n) {
  Node tmp = n;
  while (tmp != null) {
    if (tmp.getSuit() != tmp.getNext().getSuit()) {
      return false;
    }
    tmp = tmp.getNext();
  }
  return true;
}

// checks if face up columns are complete
// returns -1 if no tableaus are complete
// returns index of tableau if there is one complete
int completeTableau() {
  int tableauIndex = -1;
  for (int i = 0; i < tableaus.length; i++) {
    Node tmp = tableaus[i].getFirst();
    while (tmp != null) {
      if (tmp.faceUp() == true) {
         if (sameSuit(tmp) == true) {
            tableauIndex = i;
         }
      }
      if (tableauIndex != -1) 
        break;
    }
  }
  return tableauIndex;
}

// verifies if suit of card 1 is greater than suit of card 2
boolean checkSuit(Node card1, Node card2) {
  char s1 = card1.getSuit();
  char s2 = card2.getSuit();
  boolean result = false;
  if (s1 == 'S') {
    result = true;
  } else if (s1 == 'H' && s2!= 'S') { 
    result = true;
  } else if (s1 == 'D' && s2 != 'S' && s2 != 'H') {
    result = true;
  } else if (s1 == 'C' && s2 != 'S' && s2 != 'H' && s2 != 'D') {
    result = true;
  }
  return result;
}  

// returns true if suit of card1 is greater than suit of card2
// card2 is being moved on top of card1
// still need to check if this is correct
boolean validSuitMove(Node card1, Node card2) {
  if (card1.getNext()==null)
    return validMultipleMove(card2);
  else if (checkSuit(card1, card2))
    return true;
  return false;
}  

// checks if multiple cards can be moved
boolean validMultipleMove(Node card) {
  Node tmp = card;
  while (tmp != null) {
    if (tmp.getSuit() != tmp.getNext().getSuit()) {
      return false;
    }
    tmp = tmp.getNext();
  }
  return true;
}
  
class Node {
  int value;
  char suit; 
  boolean up;
  Node next;
  
  Node(int v, char s) {
    value = v;
    suit = s;
    up = false;
    next = null;
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
  
  char getSuit() {
    return suit;
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
}
  
class LL {
  Node l;
  
  LL(Node n) {
    l = n;
  }
  
  boolean add(Node n) {
    Node tmp = l;
    while (tmp.getNext()!=null) {
      tmp = tmp.getNext();
    }
    tmp.setNext(n);
    return true;
  }
  
  // remove last card in tableau (player initiated)
  boolean remove() {
    return true;
  }
    
  Node getFirst() {
    return l;
  }  
    
  Node getLast() {
    Node tmp = l;
    while (tmp.getNext() != null) {
      tmp = tmp.getNext();
    }
    return tmp;
  }
    
}


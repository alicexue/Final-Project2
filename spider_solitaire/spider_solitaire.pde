import java.util.ArrayList;
import java.util.Collections;

LL[] tableaus;
ArrayList<Node> stock;
Node[] cards = new Node[104]; //(spades) 
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

// when player clicks stock, new cards are added to them
//void addFromStock() {
//}

class Node {
  int value;
  char suit; 
  boolean up;
  Node next;
  
  Node (int v, char s) {
    value = v;
    suit = s;
    up = false;
    next = null;
  }
  
  void setFace (boolean up1) {
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
    
  Node getLast() {
    Node tmp = l;
    while (tmp.getNext() != null) {
      tmp = tmp.getNext();
    }
    return tmp;
  }
    
}





//void setup(){
//  image = loadImage("1_UsARa4r6x_ZuZATcxFqJ6A.jpeg");
//  size(1000,600);
//  dataset = new immageDataset(image,400);
//  //imageLoad(image);
  
//};

//void draw(){
  
//  background(50);
  
//  dataset.draw_test();
  
//  //dataset.cards.get(200).draw();
  
  
//};

class immageDataset{
  
  PImage image ;
  immageDataset dataset;
  
  ArrayList<Card> cards = new ArrayList<Card>();
  ArrayList<Card> train = new ArrayList<Card>();
  ArrayList<Card> test = new ArrayList<Card>();
  
  
  immageDataset(PImage image, int n){
    if(cards.size()<n){
    for (int i = 0; i < image.height-25; i+=25) {
      for (int j = 0; j < image.width; j+=25) {
        
              Card c = new Card(image,j,i);
              int pos = cards.size() + 1;
              cards.add(c);
              if(pos%5==0) test.add(c);
              else train.add(c);
    }}}
  };
  
  immageDataset(PImage image, int n,int offset){
    if(cards.size()<n){
    for (int i = 0; i < image.height-offset; i+=offset) {
      for (int j = 0; j < image.width; j+=offset) {
        
              Card c = new Card(image,j,i);
              int pos = cards.size() + 1;
              cards.add(c);
              if(pos%5==0) test.add(c);
              else train.add(c);
    }}}
  };
  
  immageDataset(PImage image, int n,int xoffset,int yoffset){
    if(cards.size()<n){
    for (int i = 0; i < image.height-yoffset; i+=yoffset) {
      for (int j = 0; j < image.width; j+=xoffset) {
        
              Card c = new Card(image,j,i);
              int wnum = image.width/xoffset;
              int pos = cards.size() + 1;
              cards.add(c);
              if(pos%5==0) test.add(c);
              else train.add(c);
    }}}
  };
  
  immageDataset(ArrayList<PImage> images){
    if(cards.size()<images.size()){
    for (int i = 0; i < images.size(); i++) {
              
              Card c = new Card(image,0,i);
              int pos = cards.size() +1;
              cards.add(c);
              if(pos%5==0) test.add(c);
              else train.add(c);
    }}
  };
  
  void save(){
    
  };
  
  void load(){
    
  };
  
  void draw(){
    for(Card c: cards){
      c.draw();
    }
  };
  
  void draw_train(){
    for(Card c: train){
      c.draw();
    }
  };
  
  void draw_test(){
    for(Card c: test){
      c.draw();
    }
  };
  
  
  
  class Card{
  
  float x,y;
  int id;
  PImage image;
  
  Card(PImage Image, float xx,float yy){
    
    x = xx;
    y = yy; 
    id = cards.size();
    image = new PImage(25,25);
    image.loadPixels();
    for(int i=0;i<25;i++){
      for(int j=0;j<25;j++){
        
        int pos = j + i * 25;
        int pos2 = int(x+j) + int(y+i) * Image.width; 
      image.pixels[pos] = Image.pixels[pos2];
    }}
    image.updatePixels();
    
  }
  
  void draw(){
    fill(0);
    //text(test.size(),x, y+10);
    image(image,x,y);
  }
  
  void save(){
    
  };
  
  void load(){
    
  };
  
};
  
};

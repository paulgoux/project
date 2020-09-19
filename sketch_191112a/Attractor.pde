class Attractor{
  
  int id,type;
  float x,y,w,h,intensity,mass = 200;
  String label;
  boolean drag,resize;
  public boolean toggle,show,move = true,mdown,mup;
  HashMap<String,Boolean> values = new HashMap<String,Boolean>();
  ArrayList<Attractor> attractors = new ArrayList<Attractor>();
  
  Attractor(float xx, float yy, float Intensity){
    
    x = xx;
    y = yy;
    intensity = Intensity;
  };
  
  Attractor(){
    
  };
  
  void save(){
    
  };
  
  void load(){
    
  };
  
  void draw(){
    if(show){
    stroke(0);
    //text(attractors.size(),100,100);
    for(int i=0;i<attractors.size();i++){
      Attractor a = attractors.get(i);
      fill(0);
      strokeWeight(1);
      if(a.intensity>0)fill(255);
      if(move)mouse_move(a);
      int size = 10;  
      if(a.mdown){size = 16;}
      ellipse(a.x,a.y,size,size);
    }}
  };
  
  void functions(){
    add();
    draw();
  };
  
  void animate(){
    
  };
  
  void mouseReleased(){
    //mdown = false;
  };
  
  void mouse_move(Attractor a){
      if(mousePressed&&!a.pos()){a.mup = true;}
      if(mousePressed&&a.pos()&&!a.mup){a.mdown = true;}
      if(a.mdown){a.x = mouseX;a.y = mouseY;}
      if(a.mdown&&!mousePressed){a.mdown = false;a.mup = false;}
      if(!mousePressed){a.mup = false;}
  };
  
  void add(){    
    if(toggle&&!open_menus){
    if(mousePressed&& mouseButton == LEFT && !mdown){
      attractors.add(new Attractor(mouseX,mouseY,1));
      mdown = true;
    }
    if(mousePressed&& mouseButton == RIGHT && !mdown){
      attractors.add(new Attractor(mouseX,mouseY,-1));
      mdown = true;
    }
    if(!mousePressed){ mdown = false;}
    }
  };
  
  boolean pos(){
    float X = mouseX;
    float Y = mouseY;
    return X > x && X < x + 10 && Y > y && Y < y + 10; 
  }
  
};

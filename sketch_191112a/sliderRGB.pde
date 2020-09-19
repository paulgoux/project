class rgb_Slider{
  
  float x,y,w,h,vspacing,hspacing;
  Slider sliderR,sliderB,sliderG;
  String type,itemLabel,label;
  boolean vertical, horizontal = true;
  Menu menu;
  
  rgb_Slider(float xx, float yy,float ww,float hh,float S){
    
    x = xx;
    y = yy;
    w = ww;
    h = hh;
    vspacing = S;
    
    menu = new Menu(x,y,w,h);
    menu.highlightable = false;
    menu.visible = false;
    menu.type = 2;
    menu.spacing = vspacing;
    //-------------R-----------------
    sliderR = new Slider(x,menu.y,w,10,"R");
    sliderR.classic = true;
    sliderR.bar = true;
    sliderR.parent = menu;
    sliderR.valuex = x;
    menu.sliders.add(sliderR);
    
    //-------------G-----------------
    sliderG = new Slider(menu.x,menu.y + vspacing * 1,w,10,"G");
    sliderG.classic = true;
    sliderG.bar = true;
    sliderG.parent = menu;
    sliderG.valuex = x;
    menu.sliders.add(sliderG);
    
    //-------------B-----------------
    sliderB = new Slider(menu.x,menu.y + vspacing * 2,w,10,"B");
    sliderB.classic = true;
    sliderB.bar = true;
    sliderB.parent = menu;
    sliderB.valuex = x;
    menu.sliders.add(sliderB);
    menus.add(menu);
    
    
  }
  
  void draw(){
    //menu.draw();
  }
  
  void display(String a){
    
    if(a=="vertical"|| a== "Vertical"){
      float k = 0;
      menu.vertical = true;
      
      k = menu.h;
      menu.h = menu.w ;
      h = w;
      menu.w = k;
      w = k;
      
      sliderR.horizontal = false;
      k = sliderR.w;
      sliderR.w = sliderR.h;
      sliderR.h = k;
      k = sliderR.btnw;
      sliderR.btnw = sliderR.btnh;
      sliderR.btnh = k;
      
      sliderG.horizontal = false;
      k = sliderG.w;
      sliderG.w = sliderG.h;
      sliderG.h = k;
      k = sliderG.btnw;
      sliderG.btnw = sliderG.btnh;
      sliderG.btnh = k;
      
      sliderB.horizontal = false;
      k = sliderB.w;
      sliderB.w = sliderB.h;
      sliderB.h = k;
      k = sliderB.btnw;
      sliderB.btnw = sliderB.btnh;
      sliderB.btnh = k;
    }
    
  };
  
  void set(String a){
    if(a=="radio" || a == "Radio"){
      sliderR.radio = true;
      sliderR.square = false;
      sliderR.bar = false;
      
      sliderG.radio = true;
      sliderG.square = false;
      sliderG.bar = false;
      
      sliderB.radio = true;
      sliderB.square = false;
      sliderB.bar = false;
    }
    if(a=="Bar" || a == "bar"){
      sliderR.radio = false;
      sliderR.square = false;
      sliderR.bar = true;
      
      sliderG.radio = false;
      sliderG.square = false;
      sliderG.bar = true;
      
      sliderB.radio = false;
      sliderB.square = false;
      sliderB.bar = true;
    }
    if(a=="Square" || a == "square"){
      sliderR.radio = false;
      sliderR.square = true;
      sliderR.bar = false;
      
      sliderG.radio = false;
      sliderG.square = true;
      sliderG.bar = false;
      
      sliderB.radio = false;
      sliderB.square = true;
      sliderB.bar = false;
    }
    
    if(a =="color" || a == "Color"){
      sliderR.slidercol = color(255,0,0);
      sliderG.slidercol = color(0,255,0);
      sliderB.slidercol = color(0,0,255);
    }
  };
  
  void set(Grid_space a, String b){
    
  };
  
  void set(Entity a, String b){
    
  };
  
  void set(Window a, String b){
    
  };
  
  void set(Menu a, String b){
    
  };
  
  void set(Boundary a, String b){
    
  };
  
  void set(Plot_2D a, String b){
    
  };
  
  void setbg(){
    
  };
  
  
};
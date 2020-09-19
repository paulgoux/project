class Plot_2D{
  
  int id,cols,rows,totalWeights = 10,totalBiases = 5;
  public int tCol = 2;
  public float pSize = 10;
  boolean mdown,odown;
  public float x,y,w,h;
  public String label;
  public boolean drag,resize,line,dotted,dashed,mHide,toggle,axis = true,grid = true,showMouse,loadRdata1,loadRdata2,labels = true,
                 showTab,constructData,construct1,construct2,point = true,cross,clear;
  PVector origin,mouse;
  public color col,pCol = 0;
  String [] settingsLabel = {"Psize","No. of Cols"};
  String [] optionsLabel = {"Show Grid","Show Axis","Track Mouse","Labels","Show Tab","Load Random Data","Load Random Data 2","Load From File","Load From Class","Clear","Exit"};
  String [] assignDataLabels = {"Class","Variables"};
  String [] getDataLabels1 = {"Humans","Plants","Shapes"};
  String [] getDataLabels2 = {"Velocity","Accelerration","Shapes","Population","Size","Health","Age","Children","Family","Proximity"};
  String [] palleteLabel = {};
  String [] pSizesLabel;
  String [] palleteBiasLabel;
  String [] palleteWeightsLabel;
  sliderBox palleteBias,palleteWeights,settings,pSizes;
  Menu options,getData1,getData2;
  ArrayList<ArrayList<Variable>> data = new ArrayList<ArrayList<Variable>>();
  tab pallete;
  Dropdown assignData;
  Network neuralNet;
  HashMap<String,Boolean> values = new HashMap<String,Boolean>();
  
  
  Plot_2D(PVector Origin,float ww, float hh, int Cols, int Rows){
    
    origin = Origin;
    w = ww;
    h = hh;
    cols = Cols;
    rows = Rows;
    
    setupPallete();
  }
  
  Plot_2D(Float xx,float yy,float ww, float hh, int Cols, int Rows){
    
    origin = new PVector((xx+ww)/2,(yy+hh)/2);
    x = xx;
    y = yy;
    w = ww;
    h = hh;
    cols = Cols;
    rows = Rows;
    
    setupPallete();
  }
  
  void save(){
    
  };
  
  void load(){
    
  };
  
  void decisionBoundary(){
    
  };
  
  void setupPallete(){
    palleteWeightsLabel = new String[totalWeights];
    palleteBiasLabel= new String[totalBiases];
    
    for(int i=0;i<totalBiases;i++){
      palleteBiasLabel[i] = "b"+i;;
    }
    for(int i=0;i<totalWeights;i++){
      palleteWeightsLabel[i] = "W"+i;;
    }
    pallete = new tab(main.x,H-90,main.w,70,"Weights");
    pallete.scrollable = true;
    pallete.states.get(0).scrollable = true;
    palleteBias = new sliderBox(30,30,70,5,palleteBiasLabel,pallete);
    palleteWeights = new sliderBox(160,30,90,5,palleteWeightsLabel,pallete);
    palleteBias.parentCanvas = true;
    palleteWeights.parentCanvas = true;
    pallete.add(palleteBias);
    pallete.add(palleteWeights);
    settings = new sliderBox(palleteWeights.x+palleteWeights.w + 120,30,90,5,settingsLabel,pallete);
    settings.parentCanvas = true;
    pallete.add(settings);
    pallete.toggle=true;
    pallete.visible = true;
    pallete.sliderh.visible = false;
    pallete.sliderv.valuex = 0;
    pallete.sliderv.h +=20;
    
    options = new Menu(0,0,70,optionsLabel);

    assignData = new Dropdown(0,0,90,"Select",assignDataLabels,0);
    Dropdown d = new Dropdown(0,0,90,"Select",assignDataLabels,0);

    Button loadClass = options.items.get(8);

    String [] k = {"X","Y","Z"};
    options.items.get(8).submenu = new Menu(loadClass.x+loadClass.w,loadClass.y,k);
    //options.items.get(8).submenu.w = 90;
    options.set_link(8);

    loadClass = options.items.get(8).submenu.items.get(0);
    loadClass.dMenu = assignData;

    loadClass = options.items.get(8).submenu.items.get(1);
    loadClass.dMenu = d;

    // String [] k1 = ;
    // loadClass.submenu = new Menu(loadClass.x+loadClass.w,loadClass.y,90,k1,0);
    // options.items.get(8).submenu.set_link(0);

    // loadClass = options.items.get(8).submenu.items.get(1);
    // String [] k2 = {"Velocity","Accelerration","Shapes","Population","Size","Health","Age","Children","Family","Proximity"};
    // loadClass.submenu = new Menu(loadClass.x+loadClass.w,loadClass.y,k2);
    // options.items.get(8).submenu.set_link(1);
    options.show = false;
    options.items.get(0).toggle = 1;
    options.items.get(1).toggle = 1;
    options.items.get(3).toggle = 1;
    BMS.menus.add(options);
    pSizes = new sliderBox(settings.x+settings.w+90,10,90,5,pallete);
    //pSizes.menu.spacing = 5;
    pallete.add(pSizes);
    getData1 = new Menu(0,0,70,getDataLabels1);
    getData2 = new Menu(0,0,70,getDataLabels2);
  };
  
  void loadRandomData(){
    
    if(construct1){
    ArrayList<Variable> variables = new ArrayList<Variable>();
    color c = color(random(0,255),random(0,255),random(0,255));
    
    for(int i=0;i<200;i++){
        
        PVector p = new PVector(x+w/2+random(-w/2,w/2),y+h/2+random(-h/2,h/2));
        Variable v = new Variable(p,i,c);
        
        variables.add(v);
    }
    
    if(!data.contains(variables))data.add(variables);
    
    loadRdata1 = false;
    options.items.get(5).toggle = 0;
    construct1 = false;
    
    }
    if(pSizes.menu.sliders.size()<data.size())pSizes.add
    (new Slider(pSizes.x,pSizes.y-15+(data.size()*(10+pSizes.vspacing)),pSizes.w,10,str(pSizes.menu.sliders.size())));
  };
  
  void loadRandomData(int k){
    
    if(construct2){
      
    for(int j=0;j<k;j++){
      
      ArrayList<Variable> variables = new ArrayList<Variable>();
      color c = color(random(0,255),random(0,255),random(0,255));
      
      for(int i=0;i<200;i++){
        
        PVector p = new PVector(x+w/2+random(-w/2,w/2),y+h/2+random(-h/2,h/2));
        
        Variable v = new Variable(p,i,c);
        variables.add(v);
      }
      if(!data.contains(variables))data.add(variables);
    }
      loadRdata2 = false;
      options.items.get(6).toggle = 0;
      construct2 = false;
      
    }
    if(pSizes.menu.sliders.size()<data.size()){
      for(int i=0;i<tCol;i++){
        
        float ypos = pSizes.y - 15 + pSizes.menu.sliders.size()* (10 + pSizes.vspacing) + (10 + pSizes.vspacing);
        
        Slider a =  new Slider(pSizes.x ,ypos,pSizes.w,10,str(pSizes.menu.sliders.size()));
        
        a.bar = true;
        a.classic = true;
        a.parent = pSizes.menu;
        a.valuex = pSizes.w/2;
        pSizes.add(a);
      }}
  };
  
  void logic(){
    if(loadRdata1&&!mousePressed)construct1 = true;
    if(loadRdata2&&!mousePressed)construct2 = true;
    
  };
  
  PVector sigmoid(PVector a){
    return new PVector(1/exp(a.x),1/exp(a.y));
  };
  
  void draw(){
    displayTab();
    if(toggle){
      
      stroke(col);
      drawGrid();
      displayPointer();
      displayAxis();
      displayLabels();
      
      sliderControl();
      if(loadRdata1)println("lrd");
      logic();
      loadRandomData();
      loadRandomData(tCol);
      if(!clear)displayData();
      else {
        data = new ArrayList<ArrayList<Variable>>();
        clear = false;
        options.items.get(9).toggle = 0;
        pSizes.menu.sliders = new ArrayList<Slider>();
      }
      drawMenu();
      
    }
  };
  
  void draw(PGraphics canvas){
    displayTab(canvas);
    if(toggle){
      stroke(col);
      //displayPointer();
      drawGrid(canvas);
      displayPointer(canvas);
      displayAxis(canvas);
      displayLabels(canvas);
      
      displayData(canvas);
      logic();
      loadRandomData();
      loadRandomData(2);
      //sliderControl();
      
    }
  };
  
  void displayTab(){
    pallete.toggle = true;
    pallete.draggable = true;
    if(showTab){
      pallete.displayTab();
    }
    
  };
  
  void displayTab(PGraphics canvas){
    pallete.toggle = true;
    if(showTab)
    pallete.displayTabs(canvas);
  };
  
  void drawMenu(){
    //if(mousePressed&&options.show&&!mdown&&!options.menu)options.show = false;
    if(options.show&&!mdown&&!options.pos()&&mousePressed&&options.index==-1)options.show = false;
    if(mousePressed&&mouseButton == RIGHT&&!mdown){
      options.x = mouseX;
      options.y = mouseY;
      mdown = true;
      options.show=true;
    }
    
    Dropdown d = options.items.get(8).submenu.items.get(0).dMenu;
    Dropdown d1 = options.items.get(8).submenu.items.get(1).dMenu;

    int k = -1;

    if(options.show){
      if(d.index==0){
        d.subMenu = getData1;
        d1.index = 1;
        d1.subMenu = getData2;
        k = 0;
      }
      if(d.index==1){
        d.subMenu = getData2;
        d1.index = 0;
        d1.subMenu = getData1;
        k = 1;
      }

      if(d.subMenu!=null)
      for(int i=0;i<d.subMenu.items.size();i++){

        Button b = d.subMenu.items.get(i);

        if(b.pos()&&mousePressed&&!mdown){
          b.self_toggle();
          mdown = true;
        }
        if(!b.pos()&&mousePressed)b.toggle=0;
      }
      if(d1.subMenu!=null&&mousePressed&&!mdown)
      for(int i=0;i<d1.subMenu.items.size();i++){

        Button b = d1.subMenu.items.get(i);

        if(b.pos()&&mousePressed&&!mdown){
          b.self_toggle();
          mdown = true;
        }
        if(!b.pos()&&mousePressed)b.toggle=0;
      }

      if(k==0){
        if(d.subMenu.items.get(0).toggle==1){}
        if(d.subMenu.items.get(1).toggle==1){}
        if(d.subMenu.items.get(2).toggle==1){}

        if(d1.subMenu.items.get(0).toggle==1){}
        if(d1.subMenu.items.get(1).toggle==1){}
        if(d1.subMenu.items.get(2).toggle==1){}
        if(d1.subMenu.items.get(3).toggle==1){}
        if(d1.subMenu.items.get(4).toggle==1){}
        if(d1.subMenu.items.get(5).toggle==1){}
      }

      if(k==1){
        if(d.subMenu.items.get(0).toggle==1){}
        if(d.subMenu.items.get(1).toggle==1){}
        if(d.subMenu.items.get(2).toggle==1){}
        if(d.subMenu.items.get(3).toggle==1){}
        if(d.subMenu.items.get(4).toggle==1){}
        if(d.subMenu.items.get(5).toggle==1){}

        if(d1.subMenu.items.get(0).toggle==1){}
        if(d1.subMenu.items.get(1).toggle==1){}
        if(d1.subMenu.items.get(2).toggle==1){}
      }
    }
    if(!mousePressed)mdown = false;
    // if(odown)text("odown",100,120);
    // if(mdown)text("mdown",100,130);
  };
  
  void displayData(){
    for(int i=0;i<data.size();i++){
      
      ArrayList<Variable> v = data.get(i);
      
       for(int j=0;j<v.size();j++){ 
         Variable v1 = v.get(j);
         
         fill(v1.col);
         noStroke();
         int k = int(pSizes.menu.sliders.get(i).value);
         if(point)ellipse(v1.pos.x,v1.pos.y,pSize+k,pSize+k);
         else if(cross){}
    }}
  };
  
  void displayData(PGraphics canvas){
    for(int i=0;i<data.size();i++){
      
      ArrayList<Variable> v = data.get(i);
      
       for(int j=0;j<v.size();j++){ 
         Variable v1 = v.get(j);
         
         canvas.fill(pCol);
         if(point)canvas.ellipse(v1.pos.x,v1.pos.y,pSize,pSize);
         else if(cross){}
    }}
  };
  
  void drawGrid(){
    if(grid){
      fill(0);
      strokeWeight(0.5);
    for(int i=0;i<rows;i++){
      float x1 = x + w/rows * i;
      
      line(x1,y,x1,y+h);
    }
    for(int i=0;i<cols;i++){
      float y1 = y + h/cols * i;
      
      line(x,y1,x+w,y1);
    }}
  };
  
  void drawGrid(PGraphics canvas){
    canvas.fill(0);
    for(int i=0;i<rows;i++){
      float x1 = (origin.x - w/2) + w/rows * i + w/rows/2;
      
      canvas.line(x1,y,x1,y+h);
    }
    
    for(int i=0;i<cols;i++){
      float y1 = (origin.y - h/2 )+ h/cols * i + h/cols/2;
      
      canvas.line(x,y1,x+w,y1);
    }
  };
  
  void sliderControl(){
    
  pallete.sliderv.set(0,pallete.sliderBoxes.get(1).menu.sliders.size());
      
      if(pallete.sliderv.mdown&&mouseY>pallete.y){
        
      for(int i=0;i<pallete.sliderBoxes.size();i++){
        
          Menu m = pallete.sliderBoxes.get(i).menu;
          
          if(pallete.sliderv.valuex>0)m.y = m.by - pallete.sliderv.valuex;
        
        for(int j=0;j<m.sliders.size();j++){
            
            Slider s1 = m.sliders.get(j);
            
            s1.y = m.y + (s1.h+m.spacing) * j;
            
        }}}
    
      sliderBox s = pSizes;
      
      for(int i=0;i<s.menu.sliders.size();i++)s.setint(i,2,20);
      
        settings.setint(0,2,10,this,"pSize");
        settings.setint(1,2,10,this,"tCol");
};

void displayPointer(){
  if(showMouse){
      float x1=0,y1=0,xa=0,ya=0;
      if(col==0)stroke(0);
      else if(x1-xa==0||y1-ya==0)col = color(255,255,0);
      else col = color(0,255,0);
  if(mousePressed){
        fill(255);
        ellipse(mouseX,mouseY,2,2);
        fill(0);
        
         x1 = map(mouseX,x+23,w+23,floor(-rows/2),floor(rows/2));
         xa = floor(x1);
         y1 = map(mouseY,y+20,h+20,floor((-rows)/4),floor((rows)/4));
         ya = floor(y1);
        if(abs(x1-xa)<0.1)x1=xa;
        if(abs(y1-ya)<0.1)y1=ya;
        text( x1 + ", " + y1 ,mouseX,mouseY); 
        
      }}
};

void displayPointer(PGraphics canvas){
  
  if(showMouse){
      float x1=0,y1=0,xa=0,ya=0;
      if(col==0)canvas.stroke(0);
      else if(x1-xa==0||y1-ya==0)col = color(255,255,0);
      else col = color(0,255,0);
  if(mousePressed){
        canvas.fill(255);
        canvas.ellipse(mouse.x,mouse.y,2,2);
        canvas.fill(0);
        
         x1 = map(mouse.x,x+23,w+23,floor(-rows/2),floor(rows/2));
         xa = floor(x1);
         y1 = map(mouse.y,y+20,h+20,floor((-rows)/4),floor((rows)/4));
         ya = floor(y1);
        if(abs(x1-xa)<0.1)x1=xa;
        if(abs(y1-ya)<0.1)y1=ya;
        canvas.text( x1 + ", " + y1 ,mouse.x,mouse.y); 
        
      }}
};

void displayLabels(){
  
  if(labels){
    for(int i=0;i<cols/2+1;i++){
      fill(255);
      text(i, (x + w)/2 + x + (w/cols-1) * i - 20, y+h/2 + 10);
    }
    for(int i=0;i<cols/2+1;i++){
      fill(255);
      text(- i, (x + w)/2 + x - (w/cols-1) * i - 20, y+h/2 + 10);
    }
    
    for(int i=1;i<rows/2+1;i++){
      fill(255);
      text( i, x+w/2 - textWidth(str(i))-2, (y + h)/2 + y - (h/rows) * i - 10);
    }
    for(int i=1;i<rows/2+1;i++){
      fill(255);
      text(-i, x+w/2 - textWidth(str(-i))-2, (y + h)/2 + y + (h/rows) * i - (h/rows)/2);
    }}
};

void displayLabels(PGraphics canvas){
  
  if(labels){
    for(int i=0;i<cols/2+1;i++){
      canvas.fill(255);
      canvas.text(i, (x + w)/2 + x + (w/cols-1) * i - 20, y+h/2 + 10);
    }
    for(int i=0;i<cols/2+1;i++){
      canvas.fill(255);
      canvas.text(- i, (x + w)/2 + x - (w/cols-1) * i - 20, y+h/2 + 10);
    }
    
    for(int i=1;i<rows/2+1;i++){
      canvas.fill(255);
      canvas.text( i, x+w/2 - textWidth(str(i)), (y + h)/2 + y - (h/rows) * i - 10);
    }
    for(int i=1;i<rows/2+1;i++){
      canvas.fill(255);
      canvas.text(-i, x+w/2 - textWidth(str(-i)), (y + h)/2 + y + (h/rows) * i - (h/rows)/2);
    }}
};

void displayAxis(){
  if(axis){
    PVector o = origin;
    fill(0);
    stroke(0);
    strokeWeight(1);
    line(x,y+h/2 - (h/rows)/2,x+w,y+h/2 - (h/rows)/2);
    line(x+w/2,y,x+w/2,y + h);
    }
   if(showMouse){
    if(mouseX>x+(w)/2){
     if(mouseY>y+(h)/2){
      line(mouseX,mouseY,x+(w)/2,mouseY);
      line(mouseX,mouseY,mouseX,y+(h)/2 - h/cols/2);
    }else if(mouseY<y+(h)/2){
      line(mouseX,mouseY,x+(w)/2,mouseY);
      line(mouseX,mouseY,mouseX,y+(h)/2 - h/cols/2);
    }}else {
    if(mouseX<x+(w)/2){
      line(mouseX,mouseY,x+(w)/2,mouseY);
      line(mouseX,mouseY,mouseX,y+(h)/2 - h/cols/2);
    }else{
      line(mouseX,mouseY,x+(w)/2,mouseY);
      line(mouseX,mouseY,mouseX,y+(h)/2 - h/cols/2);
    }}}
};

void displayAxis(PGraphics canvas){
  if(axis){
    PVector o = origin;
    canvas.fill(0);
    canvas.stroke(0);
    canvas.strokeWeight(1);
    canvas.line(x,y+h/2 - (h/rows)/2,x+w,y+h/2 - (h/rows)/2);
    canvas.line(x+w/2,y - (h/rows)/2,x+w/2,y + h -(h/rows)/2);
  }
    
  if(showMouse){
    if(mouseX>x+(w)/2){
     if(mouseY>y+(h)/2){
      canvas.line(mouseX,mouseY,x+(w)/2,mouseY);
      canvas.line(mouseX,mouseY,mouseX,y+(h)/2 - h/cols/2);
    }else if(mouseY<y+(h)/2){
      canvas.line(mouseX,mouseY,x+(w)/2,mouseY);
      canvas.line(mouseX,mouseY,mouseX,y+(h)/2 - h/cols/2);
    }}else {
    if(mouseX<x+(w)/2){
      canvas.line(mouseX,mouseY,x+(w)/2,mouseY);
      canvas.line(mouseX,mouseY,mouseX,y+(h)/2 - h/cols/2);
    }else{
      canvas.line(mouseX,mouseY,x+(w)/2,mouseY);
      canvas.line(mouseX,mouseY,mouseX,y+(h)/2 - h/cols/2);
    }}}
};
  
  void regression(){
    //pos
  };
  
  boolean pos(){
   return mouseX>x&&mouseX<x+w&&mouseY>y&&mouseY>y+h;
  };
  
  boolean pos(PVector m){
   return m.x>x&&m.x<x+w&&m.y>y&&m.x>y+h;
  };
};



class Plot_3D{
  
  int id;
  float x,y,w,h;
  String label;
  boolean drag,resize;
  
  Plot_3D(){
    
  }
  
  void draw(){
    
    
  };
  
  void regression(){
    
  };
  
};

class Variable{
  
  PVector pos;
  float x,y;
  color col;
  int id,pSize;
  boolean static_,dynamic;
  
  Variable(float X,float Y,color Col){
    
    x = X;
    y = Y;
    col = Col;
    
  };
  
  Variable(PVector a,color Col){
    
    pos = a;
    x = a.x;
    y = a.y;
    col = Col;
  };
  
  //Variable(float X,float Y,int ID){
  //  x = X;
  //  y = Y;
  //  id = ID;
  //};
  
  Variable(float X,float Y,int Id,color Col){
    
    x = X;
    y = Y;
    id = Id;
    col = Col;
  };
  
  Variable(PVector a,int Id,color Col){
    
    pos = a;
    x = a.x;
    y = a.y;
    id = Id;
    col = Col;
  };
  
};

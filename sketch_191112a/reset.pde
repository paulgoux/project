void Reset(){
  //if(yes.toggle==1)text("hello",100,100);
  boolean mdown = false;
  
  if(file.items.get(6).toggle==1&&file.items.get(6).parent.toggle==1){
    fill(255,150);
    rect(0,0,width,height);
    reset_dialogue.toggle = 1;
    reset_dialogue.draw();
    mdown = true;
    if(mousePressed && !reset_dialogue.pos()&&! file.items.get(6).pos()){
      reset_dialogue.toggle = 0;
      file.items.get(6).toggle = 0;
    }
  }
  if(no.toggle==1){
    file.items.get(6).toggle = 0;
    no.toggle=0;
    file.toggle = 0;
  }
  
  if(yes.toggle==1){
    //file.toggle =0;
    BMS = new BMScontrols(this);
    horizontaltabs tab = null;
    windows = new ArrayList<Window>();
    menus = new ArrayList<Menu>();
    textboxes = new ArrayList<TextArea>();
    buttons = new ArrayList<Button>();
    Sliders = new ArrayList<Slider>();
    qgrid = new ArrayList<Quad>();
    gcam = null;
    g = null;
    gimg = null;
    Runtime.getRuntime().gc();
    //scenes = new ArrayList<Scene>();
    attractors = new Attractor();
    int W = 1200, H = 660,gw = 10,gh = 10;
    gridtype = false;
    float kkkk = 0.1, gW = (W)/float(gw), gH = H/float(gh);;
    Button btn1,btn2,btn3,reset,attractor;
    Button grav;
    noiseSeed(int(random(1000000)));
    Grid g;
    TextArea textb1;
    Plot_2D plot;
    Menu file;
    Entity humans;
    Entity plants;
    Entity mineral;
    Entity metal;
    entities = new ArrayList<Entity>();
    
    BMS.begin();
    tabsetup();
    
    //spawnRaces("human",3,60);
  }
};

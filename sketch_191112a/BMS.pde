class BMScontrols{
  
  int Mcount;
  HashMap<Object,String> booleans = new HashMap<Object,String>();
  PApplet applet = null;
  public boolean gridOpen,gridSeeded,autoSave,autoControl,camOpen,terrain3d,openSimpleNN,gridCleared = true,mdown;
  boolean updated;
  String currentMouseObject;
  Object currentObject;
  String[] Lines;
  float seed;
  Button checkbox;
  Dock dock;
  public float autoSaveTimeout = 30;
  ArrayList<Slider> Sliders = new ArrayList<Slider>();
  ArrayList<sliderBox> sliderBoxes = new ArrayList<sliderBox>();
  ArrayList<TextBox> textBoxes = new ArrayList<TextBox>();
  ArrayList<TextArea> textAreas = new ArrayList<TextArea>();
  ArrayList<Button> buttons = new ArrayList<Button>();
  ArrayList<Menu> menus = new ArrayList<Menu>();
  ArrayList<Grid> grids = new ArrayList<Grid>();
  ArrayList<webcam> cams = new ArrayList<webcam>();
  ArrayList<GridImg> gridOfImages = new ArrayList<GridImg>();
  ArrayList<ImgGrid> imagesToGrid = new ArrayList<ImgGrid>();
  ArrayList<tab> tabs = new ArrayList<tab>();
  Boundary bb;
  fileInput File,Folder;
  Img imageProcessing,cam,audio;
  
  String[] cameras = Capture.list();
  String[] files;
  
  Capture Cam;
  Dropdown dd;
  
  BMScontrols(PApplet Applet){
    applet = Applet;
    //startCam();
    
  };
  
  void add(Object o,String globalVar,boolean localVar){
    Field field = null;
    
    booleans.put(o,globalVar);
  
};

void draw(){
  fill(255);
  
  text("hello",100,100);
};

void begin(){
  File = new fileInput();
  Folder = new fileInput(true);
  setupTwitter();
  setupWindows();
  setupMenus();
  setupRGB();
  setupPlots();
  setupReset();
  setupOthers();
  attractors = new Attractor();
  setupTabs();
  setupDock();
  //setupButtons();
  openTwitter();
  checkbox = new Button(25,25,20,20,"checkbox");
  checkbox.radio = true;
  tabsetup();
  spawnRaces("human",5,40);
  String [] ddLabels = {"hello"};
  //dd = new Dropdown(100,200,90,"Select",ddLabels,0);
  //bb = new Boundary(0,0,W,H);
  setupSigmoid();
  slider_functions();
  imageProcessing = new Img(0);
  cam = new Img(6);
  audio = new Img(2);
  //Text = new
  //neuralnet = new Network(28,10,10,1);
};

void setupButtons(){
  //Button b = new Button(100,200,50,20,"terrain");
  //b.togglebox = true;
  //buttons.add(b);
};

void setupDock(){
  Dock b = new Dock(0,height -22,width,24);
  ////b.togglebox = true;
  //buttons.add(b);
  dock = b;
};

void setupTwitter(){
  
  String [] keywords = { "corona virus","uk" ,"United Kingdom", "China"};
  twitterKeywords = new TwitterKeyword(keywords);
};

void setupWindows(){
  main = new Window(23,20,W-46,H-90-20);
  main.fill = false;
  main.border = true;
  Boundary b = new Boundary(main.x+1,main.y+1,main.w-2,main.h-2,4);
  //b.cohesionBoundary = true;
  //b.avoidBoundary = true;
  b.state = 1;
  b.visible = false;
  main.Boundaries.add(b);
  
  header = new Window(0,0,W,20);
  windows.add(header);
  
  footer = new Window(0,H-90,W,90);
  windows.add(footer);
  
  header.border = false;
  footer.border = true;
  footer.col = 0;
  
  fmenu = new Window(200,200,200,200,"C:\\Users\\paul goux\\");
};

void setupMenus(){
  // file----------------------------------------------
  
  
  String [] flabels = {"Open","Save","Grid","Plot 2D","Plot 3D","Attractor","Reset"};
  file = new Menu(0,0,30,20,"File",flabels,0);
  
  menus.add(file);
  //----------------------file -----------------------------------
  if(file!=null){
  String []glabels = {"Terrain","Img","Cam","Video","Audio","Text"};
  file.items.get(2).submenu  = new Menu(file.items.get(2).x+file.items.get(2).w,file.items.get(2).y,70,glabels,0);
  file.set_link(2);
  String [] attractor_labels = {"Show/Hide","On/Off"};
  file.items.get(5).submenu = new Menu(file.items.get(5).x+file.items.get(5).w,file.items.get(5).y,100,attractor_labels,0);
  file.set_link(5);
  }
  //-------------------------------------------------------------------
  String [] shapesLabels = {"Line drawing","Connected Lines","Ellipse","Rectangle","Tri","Poligon","C Poligon","Bezier","Spline","none","Arc","Path Straight","Path Corner"};
  shapes = new Menu(file.x + file.w,0,50,20,"Shapes",shapesLabels,0);
  menus.add(shapes);

  //-------------------------------------------------------------------------------------------
  //physics------------------------------------------------------------------------
  String [] physicsLabels = {"Physics","Gravity","Electromagnetism","Strong","Weak"};
  physics = new Menu(shapes.x + shapes.w,0,50,20,"Physics",physicsLabels,0);
  menus.add(physics);
  //Map--------------------------------------------------------------------
  
  String []mapLabels = {"Humans","Plants","Animals","Minerals","Metals"};
  
  mapMenu = new Menu(physics.x+physics.w,0,40,20,"Maps",mapLabels,0);
  menus.add(mapMenu);

  //---------------------------------------------------------------------------
  
  String [] neuralNetworkMenuLabels = {"Open","Close","Simple"};
  //file.horizontal = false;
  neuralNetworkMenu = new Menu(mapMenu.x+mapMenu.w,mapMenu.y,90,20,"Neural Network",neuralNetworkMenuLabels,0);
  menus.add(neuralNetworkMenu);
  String [] twitterMenuLabels = {"Stream","Show Keywords","Add Keyword","Stream To File","Open Saved Stream"};
  //file.horizontal = false;
  twitter = new Menu(neuralNetworkMenu.x+neuralNetworkMenu.w,neuralNetworkMenu.y,60,20,"Twitter",twitterMenuLabels,0);
  menus.add(twitter);
  
  // grids---------------------------------------------------------------------------------------------
  
  //images.add(loadImage("leaves.jpg"));
  images.add(loadImage("C:\\Users\\paul goux\\Desktop\\b.jpeg"));
  images.add(loadImage("btfly.jpeg"));
  //gimg = new GridImg(W/2-600,H/2-300,1000,660,images);
  gplain = new Grid(W/2-600,H/2-300,1000,780,70,50,6);
  gplain.visible = true;
  //if(BMS.camOpen)gcam = new Cam(W/2-600,H/2-300,1000,660);
  // if(BMS.gridOpen){
  //   g = new Grid(23,H/2-310,1000,500,50);
    
  //   g.visible = true;
  //   g.entities = true;
  //   g.terrain2d = true;
  //   g.perlheight = true;
  //   g.trackmouse = true;
  //   g.border = false;
  //   g.lim = 4;
  //   g.forward = true;
  //   g.trackmouse = true;
  //   g.elasticity = 0.7;
  //   g.fill = true;
  //   g.hover = true;
  //   g.circle = false;
  //   g.bounce = true;
  //   g.attractor = true;
  // }
  file.set(6,0);

  
  //---------------------Entities-----------------------------------
  
  String[] Entities_sub_Labels = {"Show","Add Human","Add Race","Follow Bound","Pause",
                                  "Debug","Adjust","Separation","Cohesion","Alignment","Sliders",
                                  "Births","Deaths","Load","Save","Reset"};
  
  Entities_sublist = new Menu(W-90,H/2-70,90,Entities_sub_Labels,0);
  Entities_sublist.draggable = true;
  
  Button debug = Entities_sublist.items.get(5);
  
  String [] debuglist = {"Family Ties", "CZone","Target A", "Target B","Heading","Eyes","info","Hide Sliders","QuadP","Field","Limit",};
  
  Entities_sublist.items.get(5).submenu = new Menu(debug.x-80,debug.y,90,debuglist,0);
  Entities_sublist.items.get(5).submenu.parentRight = true;
  Entities_sublist.items.get(5).submenu.draggable = true;
  //Entities_debug.parentRight = true;
  String[] Labelsf = {"Total","FrameRate","B room","Cohesion","Separation","Alignment","Max Force","Max Speed","Wanderm","SceneW", "SceneH","B Cohesion","B Separ.","B room B","Tscale","C Cohesion","C Separ.","C Align","Friction","Min","D Sep"};
  fRate = new sliderBox(90,350,90,5,Labelsf);
  fRate.menu.visible = false;
  fRate.menu.draggable = true;
  /*----------------------------------------------------------------------
  ---img sliders------------------------------------------------------------*/
  
  String [] imgsliderMenu_Labels = {"Conv up","Conv right","Conv  down","Conv left",
                                    "Threshold","conv","mdist","convvp","convvn",
                                    "convhp","convhn"};
                                    
  imgsliderMenu = new Menu(70,400,170,0);
  imgsliderList = new sliderBox(imgsliderMenu.x,imgsliderMenu.y,90,10,imgsliderMenu,imgsliderMenu_Labels);
  
};

void setupRGB(){
  //rgb_slider = new rgb_Slider(500,200,90,40,15);
  //rgb_slider.display("vertical");
  //rgb_slider.set("color");
  //rgb_slider.set("radio");
};

void setupPlots(){
  plot = new Plot_2D(main.x,main.y,main.w,main.h,29,30);
  plot.col = color(0,255,0);
  plot.line = true;
};

void setupReset(){
  reset_dialogue = new Menu(W/2 - 136,H/2 - 22,275,45,"Are you sure you want to exit?");
  reset_dialogue.visible = true;
  reset_dialogue.highlightable = false;
  reset_dialogue.free = true;
  yes = new Button(W/2 - 136 ,H/2 +2,reset_dialogue.w/2,20,"Yes");
  yes.border = false;
  yes.togglebox = true;
  
  no = new Button(yes.x + yes.w,H/2 +2,reset_dialogue.w/2,20,"No");
  no.border = false;
  no.togglebox = true;
  
  reset_dialogue.items.add(yes);
  reset_dialogue.items.add(no);
  yes.parent = reset_dialogue;
  no.parent = reset_dialogue;
};

void setupOthers(){
   textb1 = new TextArea(200,300,200,40,20,4,Lines);
   //textb1.border = true;
   textboxes.add(textb1);
   //textb1.parent = mapMenu;
   txtb1 = new TextBox(200+200,300,200,40,20,"Type text here!");
   txtb1.border = true;
   textb.add(txtb1);
};

void setupTabs(){
  String [] tabnames = {"Project","Data :","Processing :","Weights :","Bias :","Activation :","Outputs :"};
  tab = new horizontaltabs(100,100,135,200,tabnames);
  
  String [] options = {"Video","Images","Audio","Text","Humans","Plants","Animals","Mazecrawler","Energy","Cell"};
  String [] images = {"Feature Extraction","Facial Recognition","Text analysis","Handwriting Detection","Facial Recognition","Facial Mimicry"};
  String [] audio = {"Speech Synthesis","Language Translator","Voice Detection"};
  String [] text = {"Text Analysis","sentiment Analysis","Text writer"};
  String [] livingCreatures = {"Lifespan","Velocity","Connections","Activities","Skill"};
  
  Dropdown dmenu = new Dropdown(5,tab.h - 150,tab.w - 55,"Start",options,0);
  tab tab0 = tab.tabs.get(0);
  
  String []s3 = {"Train", "Test"};
  Dropdown d2 = new Dropdown(5,tab0.h - 70,tab0.w - 55,"Train/Test",s3,0);
  
  tab0.add(0,d2);
  tab0.add(0,dmenu);
  
  tab tab1 = tab.tabs.get(1);
      
  tab1.addState(10);
  String []submenuLabels = {"Open Window","From ClipBoard","Search Web","Record"};
  Dropdown dmenu1 = new Dropdown(5,tab1.h - 150,tab1.w - 55,"Locate",submenuLabels,0);
  Button b = new Button(5,tab1.h - 70,tab1.w - 55,20,"Next -->");
  //tab1.clear();
  tab1.setTitle(0,"Data : Video");
  tab1.add(0,dmenu1);
  tab1.add(0,b);
  
  String []s2 = {"From File","From ClipBoard","Search Web"};
  Dropdown d1 = new Dropdown(5,tab1.h - 150,tab1.w - 55,"Locate",s2,0);
  
  tab1.setTitle(1,"Data : Image");
  tab1.add(1,d1);
  tab1.add(1,b);
  
  String []s5 = {"From File","From ClipBoard","Search Web","Record"};
  dmenu1 = new Dropdown(5,tab1.h - 150,tab1.w - 55,"Locate",s5,0);
  b = new Button(5,tab1.h - 70,tab1.w - 55,20,"Next -->");
  
  tab1.setTitle(2,"Data : Audio");
  tab1.add(2,dmenu1);
  tab1.add(2,b);
  
  String []s6 = {"From File","From ClipBoard","Search Web","Record"};
  dmenu1 = new Dropdown(5,tab1.h - 150,tab1.w - 55,"Locate",s6,0);
  b = new Button(5,tab1.h - 70,tab1.w - 55,20,"Next -->");
  
  tab1.setTitle(3,"Data : Text");
  tab1.add(3,dmenu1);
  tab1.add(3,b);
  
  String []s4 = {"Position","Velocity","Lifespan","Offspring","Happiness","Carrying Capacity","Rest","Dexterity","Strength","Health"};
  Dropdown d3 = new Dropdown(5,tab1.h - 150,tab1.w - 55,"Locate",s4,0);
  
  tab1.setTitle(4,"Data : Entities");
  tab1.add(4,d3);
  tab1.add(4,b);
  
  tab tab2 = tab.tabs.get(2);
  
  String [] submenuLabels2 = {"Load From File","K-clustering","Blur","Line detect","Threshold","Pooling","Flatten","Max Pooling", "Ave Pooling","Dot Pooling","DropOut","FFT"};
  dmenu1 = new Dropdown(5,tab2.h - 150,tab2.w - 55,"Convolution",submenuLabels2,5);
  b = new Button(5,tab2.h - 70,tab2.w - 55,20,"Next -->");
  
  tab2.buttons.add(b);
  tab2.dmenus.add(dmenu1);
  
  tab tab3 = tab.tabs.get(3);
  
  String [] submenuLabels3 = {"From File :","Randomize","Manually"};
  b = new Button(5,tab3.h - 70,tab3.w - 55,20,"Next -->");
  d1 = new Dropdown(5,tab3.h - 150,tab3.w - 55,"Assign",submenuLabels3,5);
  
  tab3.dmenus.add(d1);
  tab3.buttons.add(b);
  
  tab tab4 = tab.tabs.get(4);
  
  d1 = new Dropdown(5,tab4.h - 150,tab4.w - 55,"Assign",submenuLabels3,0);
  b = new Button(5,tab4.h - 70,tab4.w - 55,20,"Next -->");
  
  tab4.dmenus.add(d1);
  tab4.buttons.add(b);
  
  tab tab5 = tab.tabs.get(5);
  
  String [] submenuLabels5 = {"Sigmoid","Tan-h","Relu","Threshold","Binary Step","Linear"};  
  d1 = new Dropdown(5,tab5.h - 150,tab5.w - 55,"Assign",submenuLabels5,5);
  b = new Button(5,tab5.h - 70,tab5.w - 55,20,"Next -->");
  
  tab5.dmenus.add(d1);
  tab5.buttons.add(b);
  
  tab tab6 = tab.tabs.get(6);
  String [] submenuLabels6 = {"Random","Manual"};
  
  d1 = new Dropdown(5,tab6.h - 150,tab6.w - 55,"Assign",submenuLabels6,5);
  b = new Button(5,tab6.h - 70,tab6.w - 55,20,"Finish:");
  
  tab6.dmenus.add(d1);
  tab6.buttons.add(b);
  
  tab.toggle = true;
  
  String [] a = {"hello","goodbye","hello1","goodbye1","hello2","goodbye2"};
  d1 = new Dropdown(200,200,200, a);
  d1.draggable = true;
};

void loadImg(){
    
};

void run(){
  globalLogic();
  manageGrid();
  manageNN();
  displayButtons();
  mainFunctions();
  menuFunctions();
  //neuralnet.run(100);
  //bb.draw3();
  //dd.displayDropdown();
  //checkbox.draw();
};

void displayButtons(){
  for(int i=0;i<buttons.size();i++){
    Button b = buttons.get(i);
    
    b.draw();
    b.highlight();
  };
};



void mainFunctions(){
  if(entities.get(0).toggle)frameRate(fRate.get(1));
  fill(255);
  plot.draw();
  //textbox(btn40,humans);
  manageClipBoard();
  attractors.functions();
  gplain.grid_functions();
  displayTextBoxes();
  main.render();
  displayEntities();
  //fmenu.display();
  fmenu.display_grid();
  //gimg.img_functions();
  imageProcessing.menus();
  cam.menus();
  audio.menus();
  tab.displayTabs();
  tabfunctions();
};

void displayEntities(){
  for(int i=entities.size()-1;i>-1;i--){
    Entity e = entities.get(i);
    
    e.runh();
    e.life();
  }
};

void displayTextBoxes(){
  for(TextArea textb : textboxes){
    //textb.draw();
  }
  
  for(TextBox textb : textb){
    //textb.draw();
  }
};

void manageClipBoard(){
  if(getTextFromClipboard ()!=clipBoard)clipBoard = getTextFromClipboard ();
};

void click(){
  //reload();
  grid();
  buttons();
  fill(0);
  if(terrain3d)text("terrain",100,120);
};

void reload(){
  if(buttons.get(0).toggle==1&&!updated){
    frameCount = -1;
    updated = true;
  }
};

void buttons(){
  
  file.self_toggle(6);
  file.toggle(3,plot,"toggle");
  file.toggle(0,fmenu,"toggle");
  //file.toggle(6);
  fill(255);
  if(file.items.get(6).pos())text(hello,100,100);
  yes.self_Toggle();
  no.self_Toggle();
  String [] gridm = {"forward","backward","pause"};
  Menu grid = file.items.get(2).submenu;
  Menu attractor = file.items.get(5).submenu;
  //grid.toggle(0,g,"toggle");
  if(file.index==2){
    grid.toggle(0,BMS,"gridOpen");
    grid.toggle(1,imageProcessing,"toggle");
    grid.toggle(2,BMS,"camOpen");
    grid.toggle(3,audio,"toggle");
    grid.toggle(4,gplain,"toggle");
    //grid.toggle(4,gimg,"imgworkflow");
  }
  
  attractor.toggle(0,attractors,"show");
  attractor.toggle(1,attractors,"toggle");
  
  String [] time_bool = {"forward","backward","pause"};
  //----------entities map menu------------------------
  for(int i=0;i<entities.size();i++){
    mapMenu.toggle(i,entities.get(i),"toggle");
    //mapmenu.toggle(1,entities.get(1),"toggle");
    //mapmenu.toggle(2,entities.get(2),"toggle");
    //mapmenu.toggle(3,entities.get(3),"toggle");
    //mapmenu.toggle(4,entities.get(4),"toggle");
    //mapmenu.toggle2(5,g,"toggle");
    //mapmenu.toggle(6,g,"toggle");
  }
  //----------Shapes------------------------
  String [] shapes_bool = {"toggle","connectedlines","circle","square","tri","bezier","none"};
  
  shapes.sptoggle(0,main,"toggle",shapes_bool);
  shapes.sptoggle(1,main,"connectedlines",shapes_bool);
  shapes.sptoggle(2,main,"circle",shapes_bool);
  shapes.sptoggle(3,main,"square",shapes_bool);
  shapes.sptoggle(4,main,"tri",shapes_bool);
  shapes.sptoggle(5,main,"poligon",shapes_bool);
  shapes.sptoggle(6,main,"complex",shapes_bool);
  shapes.sptoggle(7,main,"bezier",shapes_bool);
  shapes.sptoggle(8,main,"spline",shapes_bool);
  shapes.sptoggle(9,main,"none",shapes_bool);
  shapes.sptoggle(11,main,"path",shapes_bool);
  
  String [] ld = {"draw","edit"};
  
  main.pallete.toggle(0,main,"fill");
  main.pallete.toggle(1,main,"gravity");
  main.pallete.toggle(2,main,"friction");
  main.pallete.toggle(3,main,"velocity");
  main.pallete.toggle(4,main,"connect");
  main.pallete.toggle(5,main,"amendBoundary");
  main.pallete.toggle(6,main,"amendInnerBoundary");
  main.pallete.toggle(7,main,"amendAvoidance");
  main.pallete.toggle(8,main,"amendCohesion");
  main.pallete.toggle(9,main,"followBoundary");
  main.pallete.toggle(10,main,"follow");
  main.pallete.toggle(11,main,"dashed");
  main.pallete.toggle(12,main,"border");
  main.pallete.toggle(13,main,"amendAvoidance");
  main.pallete.toggle(14,main,"showgrid");
  main.pallete.toggle(15,main,"hidemenu");
  main.pallete.sptoggle(16,main,"edit",ld);
  main.pallete.toggle(17,main,"reset");
  //main.complexsub.toggle(0,main,"cfinish");
  
  //----------Entities-----------------
  
  Entities_sublist.toggle(0,entities.get(0),"visible");
  Entities_sublist.toggle(1,entities.get(0),"addh");
  Entities_sublist.toggle(2,entities.get(0),"boundary");
  Entities_sublist.toggle(3,entities.get(0),"followb");
  Entities_sublist.toggle(4,entities.get(0),"pause");
  Entities_sublist.toggle(6,entities.get(0),"dynamic");
  Entities_sublist.toggle(7,entities.get(0),"separationManager");
  Entities_sublist.toggle(8,entities.get(0),"cohesionManager");
  Entities_sublist.toggle(9,entities.get(0),"alignmentManager");
  Entities_sublist.toggle(10,entities.get(0),"showsliders");
  Entities_sublist.toggle(11,entities.get(0),"Birth");
  Entities_sublist.toggle(12,entities.get(0),"Death");
  Entities_sublist.click(13,entities.get(0),"reset");
  
  Menu debug = Entities_sublist.items.get(5).submenu;
  
  debug.toggle(0,entities.get(0),"familyties");
  debug.toggle(1,entities.get(0),"showbroom");
  debug.toggle(2,entities.get(0),"showta");
  debug.toggle(3,entities.get(0),"showtb");
  debug.toggle(4,entities.get(0),"showheading");
  debug.toggle(5,entities.get(0),"showview");
  debug.toggle(6,entities.get(0),"info");
  debug.toggle(7,entities.get(0),"hidesliders");
  debug.toggle(8,entities.get(0).scene,"showq");
  debug.toggle(9,entities.get(0).scene,"showf");
  
  neuralNetworkMenu.toggle(0,tab,"toggle");
  neuralNetworkMenu.toggle2(1,tab,"toggle");
  neuralNetworkMenu.toggle(2,this,"openSimpleNN");
  //if(neuralNetworkMenu.items.get(2).pos()&&mousePressed) openSimpleNN= true;
  
  twitter.toggle(0,twitterKeywords,"toggle");
  
  Menu options = plot.options;
  
  options.toggle(0,plot,"grid");
  options.toggle(1,plot,"axis");
  options.toggle(2,plot,"showMouse");
  options.toggle(3,plot,"labels");
  options.toggle(4,plot,"showTab");
  options.toggle(5,plot,"loadRdata1");
  options.toggle(6,plot,"loadRdata2");
  options.toggle(9,plot,"clear");
  options.toggle(10,plot,"toggle");
  
};

void grid(){
  //-------------pallete-------------------------
  String [] timebool = {"forward","backward","pause"};
  if(g!=null){
  g.pallete.draggable = true;
  g.pallete.toggle(0,g,"circle");
  g.pallete.toggle(1,g,"visible");
  g.pallete.toggle(2,g,"graph");
  g.pallete.toggle(3,g,"attractor");
  g.pallete.sptoggle(4,g,"forward",timebool);
  g.pallete.sptoggle(5,g,"backward",timebool);
  g.pallete.sptoggle(6,g,"pause",timebool);
  g.pallete.toggle(7,g,"heading");
  //g.pallete.click(8,g,"save");
  g.pallete.toggle(9,g,"load");
  g.pallete.toggle(10,g,"contour");
  g.pallete.toggle(11,g,"mouse");
  g.pallete.toggle(12,g,"reset");
  g.pallete.toggle(13,g,"populateBoundaries");
  g.pallete.toggle(14,g,"PopulateSpecies");
  g.pallete.toggle(15,g,"debug");
  }
};

void slider_functions(){
  
  //--------img-------------------------------
  
  imgsliderList.set(0,1,-1,gimg,"convup");
  imgsliderList.set(1,1,-1,gimg,"convright");
  imgsliderList.set(2,1,-1,gimg,"convdown");
  imgsliderList.set(3,1,-1,gimg,"convleft");
  imgsliderList.set(4,-100,300,gimg,"threshold");
  imgsliderList.set(5,1,-1,gimg,"conv");
  imgsliderList.set(6,20,300,gimg,"mdist");
  imgsliderList.set(7,1,-1,gimg,"convvp");
  imgsliderList.set(8,1,-1,gimg,"convvn");
  imgsliderList.set(9,1,-1,gimg,"convhp");
  imgsliderList.set(10,1,-1,gimg,"convhn");
  
  //----------Entities------------
  
  fRate.setint(0,1,4,entities.get(0).scene,"limit");
  fRate.set(1,0,60);
  fRate.set(2,0,200,entities.get(0),"breathingroom");
  fRate.set(3,-100,100,entities.get(0),"cohesion");
  fRate.set(4,-100,100,entities.get(0),"separation");
  fRate.set(5,-100,100,entities.get(0),"alignment");
  fRate.set(6,-50,50,entities.get(0),"alimit");
  fRate.set(7,-50,50,entities.get(0),"vlimit");
  fRate.set(8,0,5,entities.get(0),"wanderm");
  fRate.set(9,50,1200,entities.get(0),"w");
  fRate.set(10,50,600,entities.get(0),"h");
  fRate.set(11,-100,100,entities.get(0),"cohesionb");
  fRate.set(12,-100,100,entities.get(0),"separationb");
  fRate.set(13,0,200,entities.get(0),"breathingroomb");
  fRate.set(14,0,0.5,entities.get(0),"tscale");
  fRate.set(16,-50,50,entities.get(0),"separationc");
  fRate.set(15,-50,50,entities.get(0),"cohesionc");
  fRate.set(17,-50,50,entities.get(0),"alignmentc");
  fRate.set(18,0,1,entities.get(0),"mu");
  fRate.set(19,0,200,entities.get(0),"min");
  fRate.set(20,-100,100,entities.get(0),"separationd");
  
  //---------grid-------------------
  
  if(g!=null){
    //sliderMenu.set(0,-1,1,g,"zoom","sdown");
    //sliderMenu.set(1,0,255,g,"sealevel","sdown");
    //sliderMenu.set(2,0,255,g,"groundlevel2","sdown");
    //sliderMenu.set(3,0,255,g,"grasslevel","sdown");
    //sliderMenu.set(4,0,255,g,"mountainlevel","sdown");
    //sliderMenu.set(5,-200,200,g,"distance","sdown");
    //sliderMenu.set(6,-200,200,g,"vdistance","sdown");
    //sliderMenu.set(7,-200,200,g,"hdistance","sdown");
    //sliderMenu.set(8,-360,360,g,"xrot","sdown");
    //sliderMenu.set(9,-360,360,g,"yrot","sdown");
    //sliderMenu.set(10,-360,360,g,"zrot","sdown");
    //sliderMenu.set(11,0,1,g,"xvar","sdown");
    //sliderMenu.set(12,0,2,g,"noise""sdown");
    
    g.sliderMenu.set(0,-1,1,g,"scale");
    g.sliderMenu.set(1,0,2*g.amp1,g,"sealevel");
    g.sliderMenu.set(2,0,2*g.amp1,g,"groundlevel");
    g.sliderMenu.set(3,0,2*g.amp1,g,"grasslevel");
    g.sliderMenu.set(4,0,2*g.amp1,g,"mountainlevel");
    g.sliderMenu.set(12,0,0.05,g,"scale1");
    g.sliderMenu.set(13,0,10,g,"amp1");
    g.sliderMenu.set(14,1,4,g,"freq1");
    g.sliderMenu.setint(15,0,10,g,"octaves");
    g.sliderMenu.set(16,-1,1,g,"persistance");
    g.sliderMenu.set(17,1,10,g,"lacunarity");
    g.sliderMenu.set(18,-100000,100000,g,"seed");
  }
};

void manageGrid(){
  if(gridOpen&&g==null){
    g = new Grid(23,H/2-310,1200-45,main.h,5);
    g.pallete.items.get(1).toggle = 1;
    g.toggle=true;
    gridSeeded = false;
    gridCleared = false;
    g.sliderMenu.set(0,-1,1,g,"scale");
    g.sliderMenu.set(1,0,2*g.amp1,g,"sealevel");
    g.sliderMenu.set(2,0,2*g.amp1,g,"groundlevel");
    g.sliderMenu.set(3,0,2*g.amp1,g,"grasslevel");
    g.sliderMenu.set(4,0,2*g.amp1,g,"mountainlevel");
    g.sliderMenu.set(12,0,0.05,g,"scale1");
    g.sliderMenu.set(13,0,10,g,"amp1");
    g.sliderMenu.set(14,1,4,g,"freq1");
    g.sliderMenu.setint(15,0,10,g,"octaves");
    g.sliderMenu.set(16,0,1,g,"persistance");
    g.sliderMenu.set(17,1,10,g,"lacunarity");
    g.sliderMenu.set(18,-100000,100000,g,"seed");
    g.canvas = createGraphics(width,height);
    g.canvas2 = createGraphics(width,height);
    g.begin = true;
    g.sUpdate = true;
  }
  if(gridOpen&&g!=null){
    if(g!=null)g.grid_functions();
    }

  if(!gridOpen){
    g = null;
    if(!gridCleared){
      Runtime.getRuntime().gc();
      gridCleared = true;
    }
    if(!gridSeeded)gridSeeded = true;
    
  }
  
  if(BMS.camOpen){
    if(gcam==null){
      gcam = new webcam(applet);
      cam.toggle = true;
    }else gcam.display(cam.canvas);
    }else if(gcam != null){
      gcam.cam.stop();
      cam.toggle = false;

      gcam = null;
    }
};

void manageNN(){
  if(openSimpleNN&&neuralnet==null){
    neuralnet = new Network(28,10,10,2);
  }
  if(!openSimpleNN)neuralnet = null;
  if(neuralnet!=null)neuralnet.run(100);
};

void menuFunctions(){
  
  Mcount = 0;
  
  for(int i=0;i<BMS.menus.size();i++){
    
    Menu m = BMS.menus.get(i);
    m.draw();
    
    if(m.parent==null&&(m.pos()||m.toggle==1)){Mcount++;}
    else if(m.parent!=null&&m.items.size()>0&&m.parent.toggle==1){
      for(int j=0;j<m.items.size();j++){
        Button b = m.items.get(j);
        if(b.pos())Mcount++;
      }}
      else if(m.sliders.size()>0&&m.parent.toggle==1){
      for(int j=0;j<m.sliders.size();j++){
        Slider b = m.sliders.get(j);
        if(b.pos())Mcount++;
      }
  }
  
  if(Mcount>0)open_menus = true;
  else open_menus = false;
  }
};

void boundariesNscenes(){
  
  //------------------------------------------------------
  //Boundaries--------------------------------------------
};

void startCam(){
  Cam.start();
};

void autoSave(){
  
  if(autoSave){
    saveText();
  }
  
};

void load(){
  
};

void saveText(){
  
  for(int i=0;i<textBoxes.size();i++){
    TextBox t = textBoxes.get(i);
    
    t.save();
  }
  
  for(int i=0;i<textAreas.size();i++){
    TextArea t = textAreas.get(i);
    
    t.save();
  }
};

void saveSliderBox(){
  
  for(int i=0;i<sliderBoxes.size();i++){
    sliderBox s = sliderBoxes.get(i);
    
    s.save();
  }
};

void saveButtons(){
  
  for(int i=0;i<buttons.size();i++){
    Button b = buttons.get(i);
    
    b.save();
  }
};

void saveMenu(){
  
  for(int i=0;i<menus.size();i++){
    Menu m = menus.get(i);
    
    m.save();
  }
  
  for(int i=0;i<textAreas.size();i++){
    TextArea t = textAreas.get(i);
    
    t.save();
  }
};

void saveGrid(){
  
  for(int i=0;i<grids.size();i++){
    Grid g = grids.get(i);
    
    g.save();
  }
  
  for(int i=0;i<cams.size();i++){
    webcam c = cams.get(i);
    
    //c.save();
  }
};

void saveTabs(){
  
  for(int i=0;i<tabs.size();i++){
    tab t = tabs.get(i);
    
    t.save();
  }
  
  for(int i=0;i<tabs.size();i++){
    tab t = tabs.get(i);
    
    t.save();
  }
};

void saveImgp(){
  
  for(int i=0;i<textBoxes.size();i++){
    TextBox t = textBoxes.get(i);
    
    t.save();
  }
};

void save(){
  
};

void start(Object o,boolean localVar){
    Field field = null;
    
    String s = "hello";
    
    try{
      //field = o.getClass().getfield(s);
      field = applet.getClass().getField(s); 
      }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }}
    
    void eventListener(){
  
};

void toggle(Object o,String globalVar,boolean localVar){
    Field field = null;
    
    try{
      
      field = applet.getClass().getField(globalVar);
      
      
    }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }
  
};

void globalLogic(){
  if(mousePressed) globaldown = true;
  else {
    currentMouseObject = null;
    currentObject = null;
    globaldown = false;
  }
  dock.drawItems();
  dock.dock();
};
  
};

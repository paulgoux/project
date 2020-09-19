
public class Grid {

  int id, rows, cols, imrows, imcols, camcols, camrows, tbcols, tbrows, ztoggle, ztoggle2, Rows, Cols, rowcount, colcount, totalAgents = 100, agentsCounted, squaresCounted,bcount,res,xRes,yRes,popCount;
  public int sides,octaves = 8;
  int totalpixels;
  public float x, y, z, xback, yback, zback, w, h, lim, acceleration, elasticity, depth, sealevel = 0, floorlevel = 0.2,groundlevel = 0.4,grasslevel = 0.6, mountainlevel = 0.8, flying, fx, fy, zoom, yrot, xrot, zrot, distance,perlx_xoff,perlx_yoff, perly_xoff,perly_yoff,noise1 = 0.05,noise2,noise3, XX, YY, vdistance, hdistance, bordersize = 1, groundlevel2 = 100, posx, posy, dx, dy, imw, imh, camw, camh, mdist = 20, y_padding = -0.8, x_padding= -1,pxfx, pxfy,pyfx, pyfy,map1 = 2,map2 = 4,seed,scale1 = 0.05,freq = 1,freq1 = 1,freq2 = 1,freq3 = 3,amp = 1,amp1 = 1,amp2 = 1,amp3 = 1,scale2 = 0.05,scale3 = 0.05,scale,frequency,lacunarity,max,persistance,amplitude;
  float deltay, deltax;
  color C;
  public float convup = 0, convright = 0, convdown = 0, convleft = 0, threshold = 0, conv, convhp = 1, convvp = 1, convhn = -1, convvn = -1;
  float [][] perlx, perly, perlz, perlh, perlw, perld, perlr, perlg, perlb = new float[cols][rows], terrain;
  String label;
  public boolean trackmouse, drag, resize, init, border = true, fill = true, hover, count, wrap, move, collide, cloth, partition, bounce, mouse, forward = true, backward, pause, randcolor, graph, circular,load,sysUpdate, update,sUpdate, sdown,begin = true,contourUpdate,mdown;
  public boolean visible = true, field = false, reset, heading, intersect, perlcolor, perlheight, isometric, topdown, particle, terrain2d, terrain3d, entity, floored = true, entities, circle,rect,save;
  public boolean colrepeat, rowrepeat, contour, brightness, camera, toggle, tbtoggle, dot, attractor, populateBoundaries, debug, popuateSpecies;
  ArrayList<PVector> octaveOffsets;
  //img bools
  public boolean im_init, imtoggle, normal_img, mouse_img, blur_img, linedetect_img, dot_img, imreset, refreshed, backup, bright, sharp, convolved, imgreset;
  //webcam bools
  public boolean cm_init, camtoggle, normal_cam, mouse_cam, blur_cam, linedetect_cam, dot_cam, camreset, webcam, menu, updateimage;
  // bools
  public boolean normal, mouse_interact, blur, linedetect, shape, imgworkflow;
  boolean array, agentsPopulated, mapScoped, neighboured,beginSquareSorting,sortBoundaries,terrainP= true,Boundaries,bbb,popPhase2;

  Window search;
  taskList workflow;
  String[] palleteLabels = {"Circle", "Hide", "Graph", "Attractor", "Forward", "Backwards", 
    "Pause", "Heading", "Save", "Load", "Contour", "Mouse", "Reset", 
    "Populate Boundaries", "Spawn Entities", "Debug"};
  String []sliderLabels1 = {"Scale","Sea","Floor","Grass","Mountains","Distance","Height","hdistance","Xrot","Yrot","Zrot","xvar","Scale 1","Amp 1","Freq 1","Lacunarity","Persistance","Seed"};

  String []sliderLabels2 = {"Scale","Sea","Floor","Grass","Mountains","Distance","Height","hdistance","Xrot","Yrot","Zrot","xvar","Scale 1","Amp 1","Freq 1","Octaves","Lacunarity","Persistance","Seed"};

  Menu pallete;
  sliderBox sliderMenu;
  Img g1,g2;
  HashMap<String, String> workflow_link = new HashMap<String, String>();

  PImage current_image;
  PGraphics canvas,canvas2;
  PShape grid;
  
  int gridChildren;
  color [][] map;
  color [] map1d;
  float [][] mapNoise;
  float [] mapNoise1d;
  boolean [][] mapUpdate;
  boolean keyUpdate;

  //plain grid
  boolean plain;
  String test = "", link;
  PImage img, img1, cam, im, imgtemp;

  float [] b_kernel1d_ = {1/9, 1/9, 1/9, 1/9, 1/9, 1/9, 1/9, 1/9, 1/9};
  float[][] b_kernel2d_ = {{1/9, 1/9, 1/9}, 
    {1/9, 1/9, 1/9}, 
    {1/9, 1/9, 1/9}};

  float [] b_kernel1d = {1, 1, 1, 1, 1, 1, 1, 1, 1};
  float[][] b_kernel2d = {{1, 1, 1}, 
    {1, 1, 1}, 
    {1, 1, 1}};


  float [] sobelv1d = {convvn, 0, convvp, convvn, conv, convvp, convvn, 0, convvp};
  float [] sobelh1d = {convvn, 0, convvp, convvn, conv, convvp, convvn, 0, convvp};

  float[][] vkernel2d = {{convvn, 0, convvp }, 
    { convvn, 0, convvp }, 
    { convvn, 0, convvp }};

  float[][] hkernel2d = {{-1, -1, -1 }, 
    {0, 0, 0 }, 
    {1, 1, 1 }}; 

  float [] vkernel1d = {convvn, 0, convvp, convvn, conv, convvp, convvn, 0, convvp};

  float [] hkernel1d = {convhn, convhn, convhn, 0, conv, 0, convhp, convhp, convhp};

  float [] difflkernel1d = {0, 0, 0, -1, convleft, 0, 0, 0, 0}; 
  float [] diffrkernel1d = {0, 0, 0, 0, convright, -1, 0, 0, 0}; 
  float [] diffukernel1d = {0, -1, 0, 0, convup, 0, 0, 0, 0}; 
  float [] diffdkernel1d = {0, 0, 0, 0, convdown, 0, 0, -1, 0}; 

  HashMap<String, Boolean> values = new HashMap<String, Boolean>();
  HashMap<String, Float> floats = new HashMap<String, Float>();
  ArrayList<Grid_space> squares = new ArrayList<Grid_space>();
  ArrayList<Grid_space> unsortedSquares = new ArrayList<Grid_space>();
  ArrayList<ArrayList<Grid_space>> sortedSquares = new ArrayList<ArrayList<Grid_space>>();
  ArrayList<ArrayList<Grid_space>> wallSquares = new ArrayList<ArrayList<Grid_space>>();
  ArrayList<ArrayList<Grid_space>> unsortedWallSquares = new ArrayList<ArrayList<Grid_space>>();
  ArrayList<ArrayList<Grid_space>> sortedWallSquares = new ArrayList<ArrayList<Grid_space>>();
  ArrayList<Grid_space> wallSquaresBackup = new ArrayList<Grid_space>();

  ArrayList<ArrayList<Grid_space>> boundaries = new ArrayList<ArrayList<Grid_space>>();

  ArrayList<Grid_space> agents = new ArrayList<Grid_space>();
  ArrayList<Grid_space> agentsBackup = new ArrayList<Grid_space>();
  ArrayList<Grid_space> agentsConst = new ArrayList<Grid_space>();
  ArrayList<Grid_space> sortedAgents = new ArrayList<Grid_space>();
  ArrayList<ArrayList<Grid_space>> popHist = new ArrayList<ArrayList<Grid_space>>();
  ArrayList<ArrayList<Grid_space>> sortedPopHist = new ArrayList<ArrayList<Grid_space>>();
  ArrayList<ArrayList<Grid_space>> popStack = new ArrayList<ArrayList<Grid_space>>();
  ArrayList<ArrayList<Grid_space>> connections = new ArrayList<ArrayList<Grid_space>>();

  ArrayList<Grid_space> table = new ArrayList<Grid_space>();
  ArrayList<Grid_space> imsquares = new ArrayList<Grid_space>();

  ArrayList<Boolean> walls = new ArrayList<Boolean>();
  ArrayList<PImage> images = new ArrayList<PImage>();
  ArrayList<Button> buttons = new ArrayList<Button>();

  ArrayList<Grid_space> camsquares = new ArrayList<Grid_space>();
  ArrayList<Grid_space> temp_rows = new ArrayList<Grid_space>();
  ArrayList<Grid_space> temp_cols = new ArrayList<Grid_space>();
  ArrayList<Grid_space> temp_rowe = new ArrayList<Grid_space>();
  ArrayList<Grid_space> temp_cole = new ArrayList<Grid_space>();

  Grid_space [][]squares2 = new Grid_space[rows][cols];

  ArrayList<Grid_space> temp = new ArrayList<Grid_space>();
  ArrayList<Grid_space> temp2 = new ArrayList<Grid_space>();
  ArrayList<Grid_space> tempSquares = new ArrayList<Grid_space>();

  ArrayList<Shape> shapes = new ArrayList<Shape>();
  String saveLocation = "terrain\\grids.txt";
  fileOutput output = new fileOutput(false);
  fileInput input;
  String folder;

  //color col = color(255);
  Grid() {
  };

  Grid(float xx, float yy, float ww, float hh, int Row, int Col,boolean k) {
    
    sliderMenu = new sliderBox(40,360,90,5,sliderLabels2);
    
    x = xx;
    y = yy;
    xback = x;
    yback = y;

    w = ww;
    h = hh;

    rows = Row;
    cols = Col;

    bordersize = 1;

    perlx  = new float[cols][rows];
    perly = new float[cols][rows];
    perlz = new float[cols][rows];
    perlr  = new float[cols][rows];
    perlg = new float[cols][rows];
    perlb = new float[cols][rows];
    terrain = new float[cols][rows];

    perlheight = true;
    squares2 = new Grid_space[rows][cols];

    trackmouse = false;
    //totalAgents = rows/2;
    if (BMS.terrain3d) {
      terrain3d = true;
      terrain2d = false;
    }else{
      terrain3d = false;
      terrain2d = true;
    }

    pallete = new Menu(W-90, H/2, 70, palleteLabels);
    pallete.draggable = true;
    seed = random(1000000);
    //init();
  };

  Grid(float xx, float yy, float ww, float hh) {
    
    x = xx;
    y = yy;
    xback = x;
    yback = y;
    w = ww;
    h = hh;
    bordersize = 1;
    squares2 = new Grid_space[rows][cols];
    trackmouse = true;
  };

  Grid(float xx, float yy, float ww, float hh,int Res) {
    
    sliderMenu = new sliderBox(40,360,90,5,sliderLabels2);
    
    x = xx;
    y = yy;
    xback = x;
    yback = y;
    w = ww;
    h = hh;
    cols = int(ww/Res);
    rows = int(hh/Res);
    res = Res;
    map = new color[cols][rows];
    scale = 0.05;
    seed = 10;
    seed = random(1000000);
    noiseSeed(int(seed));
    map = new color[cols][rows];
    map1d = new color[cols * rows];
    mapNoise = new float[cols][rows];
    mapNoise1d = new float[cols * rows];
    mapUpdate = new boolean[cols][rows];
    grid = createShape(GROUP);

    pallete = new Menu(W-90, H/2, 70, palleteLabels);
    pallete.draggable = true;
    input = new fileInput(pallete.items.get(9),true);
    
    visible = true;
    canvas = createGraphics(width,height);
    g1 = new Img((int)w - (int)x,(int)h-(int)y);
    g2 = new Img((int)w - (int)x,(int)h-(int)y);
    init2();
    
    rect = true;
    
    save();
  };

  
  Grid(float xx, float yy,float W,float H,int xRes,int yRes){
    
    cols = int(W/xRes);
    rows = int(H/yRes);
    scale = 0.05;
    seed = 10;
    this.w = W;
    this.h = H;
    this.xRes = xRes;
    this.yRes = yRes;
    noiseSeed(int(seed));
    map = new color[cols][rows];
    map1d = new color[cols * rows];
    mapNoise = new float[cols][rows];
    mapNoise1d = new float[cols * rows];
    mapUpdate = new boolean[cols][rows];
    
    init3();
    canvas = createGraphics(width,height);
    g1 = new Img((int)w - (int)x,(int)h-(int)y);
  };
  
  //-3d-------------------
  Grid(float xx, float yy, float zz, float ww, float hh, float dd, int Col, int Row) {
    
    x = xx;
    y = yy;
    z = zz;
    xback = x;
    yback = y;
    zback = z;

    w = ww;
    h = hh;

    depth = dd;

    rows = Row;
    cols = Col;

    bordersize = 1;

    Cols = cols;
    Rows = rows;

    //totalAgents = rows;
    squares2 = new Grid_space[rows][cols];
    search = new Window( 50, 50, 200, 100, "C:\\Users\\paul goux\\");
  };
  //cam------------------------------------------------------
  Grid(float xx, float yy, int ww, int hh, String a) {

    x = xx;
    y = yy;
    xback = x;
    yback = y;
    w = ww;
    h = hh;
    rows = ww;
    cols = hh;
    if (a =="cam"||a == "Cam" || a == "CAM")camera = true;
    bordersize = 1;
    Cols = cols;
    Rows = rows;
    squares2 = new Grid_space[rows][cols];

    search = new Window( 50, 50, 200, 100, "C:\\Users\\paul goux\\");
  };
  //------------------------------------------------
  Grid(float xx, float yy, int ww, int hh, int Cols, int Rows, int Sides) {

    x = xx;
    y = yy;
    xback = x;
    yback = y;
    w = ww;
    h = hh;
    rows = Rows;
    cols = Cols;
    Cols = cols;
    Rows = rows;
    bordersize = 1;
    zrot = 0;
    shape = true;
    sides = Sides;
    perlx  = new float[cols][rows];
    perly = new float[cols][rows];
    perlz = new float[cols][rows];
    perlr  = new float[cols][rows];
    perlg = new float[cols][rows];
    perlb = new float[cols][rows];
    terrain = new float[cols][rows];
    randcolor = false;
    perlheight = true;
    squares2 = new Grid_space[rows][cols];
    fx = w/2;
    fy = h/2;
    pxfx = 0;
    pxfy = 0;
    pyfx = 0;
    pyfy = 0;
    trackmouse = true;
    zoom = 0;
    totalAgents = rows;
    terrain3d = false;
    terrain2d = false;
    search = new Window( 50, 50, 200, 100, "C:\\Users\\paul goux\\");
    pallete = new Menu(W-90, H/2, 70, palleteLabels);
    pallete.draggable = true;
  };
  //---------------image array-----------------------------------


  //-------------Table---------------------------------

  Grid(float xx, float yy, int ww, int hh) {

    x = xx;
    y = yy;
    xback = x;
    yback = y;
    w = ww;
    h = hh;
    rows = ww;
    cols = hh;

    bordersize = 1;
    Cols = cols;
    Rows = rows;
    squares2 = new Grid_space[rows][cols];
  };

  void kernel_modifier() {
    //hkernel1d = {convhn, convhn, convhn, 0, conv, 0,convhp , convhp, convhp};

    hkernel1d[0] = convhn;
    hkernel1d[1] = convhn;
    hkernel1d[2] = convhn;
    hkernel1d[3] = 0;
    hkernel1d[4] = conv;
    hkernel1d[5] = 0;
    hkernel1d[6] = convhp;
    hkernel1d[7] = convhp;
    hkernel1d[8] = convhp;
    //vkernel1d = {convvn, 0, convvp, convvn, conv, convvp, convvn, 0, convvp};
    vkernel1d[0] = convvn;
    vkernel1d[1] = 0;
    vkernel1d[2] = convvp;
    vkernel1d[3] = convvn;
    vkernel1d[4] = conv;
    vkernel1d[5] = convvp;
    vkernel1d[6] = convvn;
    vkernel1d[8] = 0;
    vkernel1d[8] = convvp;
    difflkernel1d[4] = convleft;
    diffukernel1d[4] = convup;
    diffrkernel1d[4] = convright;
    diffdkernel1d[4] = convdown;
  };

  void getFolder(){
    input.listen();
    if(Location!=null && input.fileSelect){
      println(Location);
      folder = Location;
      input.fileSelect = false;
      load = true;
      Location = null;
    }
  };

  void grid_functions() {
    init();
    fill(255);
    if (init&&toggle) {
      load();
      display();
      getFolder();
      
      //draw_2d();
      if (populateBoundaries)popAgents();
      //if(populateBoundaries)seekBoundaries2();
      if (populateBoundaries)seekBoundaries();
      seekBoundaries3();
      //text(wallSquares.size(),W-50,100);
      //for(int i=wallSquares.size()-1;i>-1;i--){
      //  Grid_space g = wallSquares.get(i);
      //  fill(255,0,0,150);
      //  //noFill();
      //  if(contour)ellipse(g.x+g.w/2,g.y+g.h/2,g.w,g.h);
      //}
    }
  };

  void mouseLogic(){
    // if(!mousePressed){
    // amp = map(mouseY,0,height,1,2);
    // freq = map(mouseX,0,width,1,2);
    // }else{
      
    // }
    if(mouseX!=pmouseX||mouseY!=pmouseY) update = true;
    else update = false;
  };

  void plainFunctions(){
    init();
    if(init&&toggle)drawPlain();

  };

  void drawPlain(){

    for (int yy = 0; yy < rows-1; yy++) {

        if (terrain3d)beginShape(TRIANGLE_STRIP);
        float xoffr = fx;

        for (int xx = 0; xx< cols; xx++) {
          
          int pos = xx + yy * cols;
          Grid_space a = squares.get(pos);
          a.shape.draw();

        }}

  };

  void shape_functions() {
  };

  void waveform(PVector a) {
  };

  void waveform(float a, float b) {
  };

  void save() {
      output.checkLocation(saveLocation);
      output.open();
      String gridData = x + "," + y + "," + w + "," + h + "," + res + "," 
                        + seed + "," + fy + "," + pxfx + "," + pyfy;
      //String gridData = "";
      println(gridData);
      output.write(gridData);

      for(int i=0;i<squares.size();i++){
        Grid_space g = squares.get(i);
        String s = red(g.col) + "," + green(g.col) + "," + blue(g.col) + "," 
                   + red(g.col2) + "," + green(g.col2) + "," + blue(g.col2);
        output.write(s);
      }
      output.close();
      save = true;
      sliderMenu.save.update("terrain","sliders.txt",output.counter);
      sliderMenu.save();
  };

  void load() {

    if(load &&folder!=null){
      println("load: " + folder);
      String [] temp = listNames(folder);

      String [] terrainValues = null;
      String [] sliderValues = null;
      
      if(temp!=null&&temp.length>=2){

        for(int i=0;i<temp.length;i++){

          String [] m = match(temp[i],"grids");
          String [] m1 = match(temp[i],"sliders");
          File f = null;
          if(m!=null){
            //f = new File(folder + temp[i]);
            terrainValues = loadStrings(folder + "\\" + temp[i]);
            println(temp[i]);
          }
          if(m1!=null){
            println(temp[i]);
            sliderValues = loadStrings(folder + "\\" + temp[i]);
          }
          if(sliderValues!=null&&terrainValues!=null)break;
          
        }
        if(terrainValues!=null&&sliderValues!=null){

          String []init_ = splitTokens(terrainValues[0], ",");

          x    = float(init_[0]);
          y    = float(init_[1]);
          w    = float(init_[2]);
          h    = float(init_[3]);
          res  = int(init_[4]);
          seed = float(init_[5]);

          cols = int(w/res);
          rows = int(h/res);
          
          squares = new ArrayList<Grid_space>();
          Runtime.getRuntime().gc();
          canvas = createGraphics(width,height);
          g1 = new Img((int)w - (int)x,(int)h-(int)y);
          init2();

          for(int i=0;i<sliderValues.length;i++){
            sliderMenu.menu.sliders.get(i).value = float(sliderValues[i]);
          }
          sealevel = sliderMenu.get(1);
          groundlevel = sliderMenu.get(2);
          grasslevel = sliderMenu.get(3);
          mountainlevel = sliderMenu.get(4);
          //input.values = null;
          sysUpdate = true;
          load = false;
        }else {
          println("No such file...");
          folder = null;
          load = false;
        }
      }
    }
  };
  
  void init() {

    float WW = w/cols;
    float HH = h/rows;
    if (!init&&!array) {
      //squares = new ArrayList<Grid_space>();
      array = true;
    }

    if (toggle) {
      if (squares.size()<rows*cols) {
        if (circular) {

          for (int i=0; i<360; i+=WW) {
            for (int j=0; j<rows; j++) {

              float x1 = (x + WW * i);
              float y1 = (y + HH * j);
              float r = WW;

              x1 = x+w/2 + (r/2+1)*j * cos(i);
              y1 = y+h/2 + (r/2+1)*j * sin(i);
              int num = i + j * cols;
              Grid_space a = new Grid_space(x1, y1, WW, HH, num, i, j);
              a.lim = lim;
              randcolor = true;
              a.parent = this;
              if (randcolor) {
                a.col = color(random(255), random(255), random(255));
              }
              squares.add(a);
            }
          }
        } else {
          float theta=0, ratio=0, ratio2 = 0, wx=0, ww=0, ku=0, kuu=0, hh=0;
          if (shape) {
            theta = radians(360/sides);
            ratio = (HH)/2 * sin(theta);
            ratio2 = (HH)/2 * cos(theta);
            ww = ratio *2;
            hh = ratio2*2;
          }
          for (int yy = 0; yy < rows; yy++) {
            for (int xx = 0; xx< cols; xx++) {
              float x1 = (x + WW * xx);
              float y1 = (y + HH * yy);
              if (shape) {
                float k = pow(-1, yy);
                x1 = ww+x+(ww)*xx+ratio/2*k;
                y1 = hh+y+(hh*1.5)*yy;
                WW=HH;
              }
              int num = xx + yy * cols;
              Grid_space a = new Grid_space(x1, y1, WW, HH, num, xx, yy);
              a.lim = lim;

              if (randcolor) a.col = color(random(255), random(255), random(255));
              
              a.parent = this;

              if (shape) {
                a.sides = sides;
                a.col = color(random(255), random(255), random(255));
                a.col2 = color(255);
                if (border)a.border = true;
                a.col2 = color(0);
                a.shape = new Shape(sides, a);
              }
              squares.add(a);
              //squares2[xx][yy] = a;
            }
          }
        }
      } else {
        //for(int xx=0;xx<rows;xx++){
        //  int pos = xx + 0 * rows;
        //  Grid_space a = squares.get(pos);
        //  //temp_cols.add(a);
        //}
        //for(int xx=0;xx<cols;xx++){
        //  int pos = 0 + xx * rows;
        //  Grid_space a = squares.get(pos);
        //}
        init = true;
        array = false;
      }

      if(reset){
        squares = new ArrayList<Grid_space>();
       init = false;
       zoom = 0;
       flying = 0;
       fx = 0;
       fy = 0;
       reset = false;

      }
    }
  };

  void init2d() {

    float WW = w/res;
    float HH = h/res;

      if (squares.size()<rows*cols) {

          for (int yy = 0; yy < rows; yy++) {
            for (int xx = 0; xx< cols; xx++) {
              float x1 = x+xx * res;
              float y1 = y+yy * res;
              int num = xx + yy * cols;
              Grid_space a = new Grid_space(x1, y1, res, res, num, xx, yy);
              a.lim = lim;

              a.col = color(random(255), random(255), random(255));
              
              a.parent = this;

              squares.add(a);
              //squares2[xx][yy] = a;
            }
          }
        
      } 
    
  };

  void init2(){
    octaveOffsets = new ArrayList< PVector>();
        for(int i=0;i<10;i++){
          float rx = random(-100000,100000);
          float ry = random(-100000,100000);
          octaveOffsets.add(new PVector(rx,ry));
        }
    grid = createShape(GROUP);
    canvas.beginDraw();
    for(int i=0;i<rows;i++){
        for(int j=0;j<cols;j++){
          
          float yy = y + scale*i*freq;
          float xx = x + scale*j*freq;

          float x1 = x + j * res;
          float y1 = y + i * res;
          
          int p = j + i * cols;
          
          float n = noise(xx,yy);
          float height = map(n*amp,0,1,0,255);
          
          color col = 0;
          if(height>50)col = color(0, 0, 153);
          if(height>100)col = color(204, 204, 0);
          if(height>150)col = color(51, 153, 51);
          if(height>200)col = color(102, 102, 153);
          
          map[j][i] = col;
          mapNoise[j][i] = n;
          mapUpdate[j][i] = false;
          
          map1d[p] = col;
          mapNoise1d[p] = n;
          
          PShape rect = createShape(RECT,j*res,i*res,res,res);
          rect.setFill(col);
          grid.addChild(rect);
          gridChildren++;

          int num = j + i * cols;
          Grid_space a = new Grid_space(x1, y1, res, res, p, j, i);
          a.lim = lim;
          if(randcolor){
            a.col = color(random(255), random(255), random(255));
            a.col2 = a.col;
          }
          else {
            a.col = col;
            a.col2 = a.col;
          }
          a.parent = this;
          squares.add(a);
          canvas.fill(a.col);
          canvas.noStroke();
          canvas.rect(a.x,a.y,a.w,a.h);
        
      }}
      g1.img = canvas.get((int)x,(int)y,(int)w,(int)h);
      canvas.endDraw();
  };

  void init3(){
    
    for(int i=0;i<rows;i++){
      for(int j=0;j<cols;j++){
        
        float yy = scale*i*freq;
        float xx = scale*j*freq;
        int p = j + i * rows;
        noStroke();
        //float height = map(noise(xx,yy)*amp,0,1,0,255);
        float height = noise(xx,yy)*amp;
        color col = 0;
        
          if(height>0.2)map[j][i] = color(0, 0, 153);
          if(height>0.4)map[j][i] = color(204, 204, 0);
          if(height>0.6)map[j][i] = color(51, 153, 51);
          if(height>0.8)map[j][i] = color(102, 102, 153); 
        
        map[j][i] = col;
        mapNoise[j][i] = noise(xx,yy);
        mapUpdate[j][i] = false;
        if(p<map1d.length)map1d[p] = col;
    }}


  };

  void timeControls(Grid_space a){

    if (forward||backward) {
            if (acceleration!=0)a.ax = acceleration;
            a.ay = acceleration;
            if (a.collide) fill(0);
            if (a.pos()&&hover) fill(0, 255, 0);

            stroke(a.col);
            strokeWeight(bordersize);
            if (!border) noStroke();

            // ------------------------------------------ time control---------------------------------------
            if (forward) {
              a.forward = true;
              a.pause = false;
              a.backward = false;
              a.update();
            } else if (backward) {
              a.forward = false;
              a.pause = false;
              a.backward = true;
              a.update();
            } else if (pause) {
              a.forward = false;
              a.pause = true;
              a.backward = false;
              a.update();
            } else {
              a.forward = false;
              a.pause = false;
              a.backward = false;
              a.update();
            }
            if (attractor)a.attractors();

            if (mouse&&forward)a.mouse();
          }
  };

  void info(){


  };

  void createVertices(Grid_space a){

    int count = 0;

    for (int i=0; i<a.Neighbours_b.length; i++) {

                  Grid_space neighbour = a.Neighbours_b[i];

                  if (neighbour!=null&&a.col2!=-10000&&neighbour.col2!=-10000&&neighbour.col2==a.col2)a.Walls_b.set(i, false);
                  else if (neighbour==null||neighbour!=null&&a.col2!=-10000&&neighbour.col2!=-10000&&a.col2!=neighbour.col2)a.Walls_b.set(i, true);

                  if (neighbour!=null&&(a.Walls_b.get(i)))if(contour)a.Boundaries.get(i).drawLine();
                  
                  if (neighbour!=null&&a.popVisited&&neighbour.popVisited) {
                    if (a.col2!=-10000
                      &&neighbour.col2!=-10000
                      
                      &&a.popCol!=neighbour.popCol
                      &&a.col2==neighbour.col2
                      &&agentsBackup.get(a.popId).psteps<=agentsBackup.get(neighbour.popId).psteps
                      ) {
                      agentsBackup.get(a.popId).psteps --;
                      agentsBackup.get(neighbour.popId).psteps ++;

                      a.popId = neighbour.popId;
                      a.popCol = neighbour.popCol;
                      count++;
    }}}

  };

  void createVertices2(){


  };

  void updateAgents(int n, Grid_space a){

    for (int k=0; k<a.Neighbours_b.length; k++) {

      Grid_space neighbour = a.Neighbours_b[k];

      if (neighbour!=null&&a.col2!=-10000&&neighbour.col2!=-10000&&neighbour.col2==a.col2)a.Walls_b.set(k, false);
      else if (neighbour==null||neighbour!=null&&a.col2!=-10000&&neighbour.col2!=-10000&&a.col2!=neighbour.col2)a.Walls_b.set(k, true);

      //if (neighbour!=null&&(a.Walls_b.get(k)))if(contour)a.Boundaries.get(k).drawLine();
      
      if (neighbour!=null&&a.popVisited&&neighbour.popVisited) {
        if (a.col2!=-10000
          &&neighbour.col2!=-10000
          &&a.popCol!=neighbour.popCol
          &&a.col2==neighbour.col2
          &&agentsBackup.get(a.popId).psteps<=agentsBackup.get(neighbour.popId).psteps
          ) {
          agentsBackup.get(a.popId).psteps --;
          agentsBackup.get(neighbour.popId).psteps ++;

          a.popId = neighbour.popId;
          a.popCol = neighbour.popCol;
          n++;
    }}}
  };

  void display(){
    
    mouseLogic();
    //logic();
      keys();
      output.append = true;
      
      //println("amp1 "+ amp1);
      noiseSeed(int(seed));
      if(pallete.click(8))save();
      agentsCounted = 0;
      if (border){
        stroke(0);
        fill(255);
        rect(x,y,w,h);
      }
      if(sliderMenu!=null&&sliderMenu.visible&&sliderMenu.menu.smdown||sUpdate){
        update = true;
        mdown = true;
        
        
      }
      else update = false;
      if(mdown&&!mousePressed&&contour)contourUpdate = true;
      if(!mousePressed)mdown = false;
      if(scale<=0)scale = 0.0001;
      //if(contour)beginShape();
      
        
      if(canvas==null)canvas = createGraphics(width,height,JAVA2D);
      //if(update||keyUpdate||sysUpdate||begin)
      canvas.beginDraw();
      //canvas2.beginDraw();
      for(int i=0;i<rows;i++){
        for(int j=0;j<cols;j++){
          
          noStroke();
          int p = j + i * cols;
          Grid_space a = squares.get(p);

          if(update||keyUpdate||sysUpdate||begin){
            amplitude = amp1;
            frequency = freq1;
            float height = 0;
            mapNoise[j][i] = 0;
            
            for(int k=0;k<octaves;k++){
              
              float y1 = fy + scale1*i*frequency + octaveOffsets.get(k).x;
              float x1 = fx + scale1*j*frequency + octaveOffsets.get(k).y;
              float n1 = noise(x1,y1);

              height += (n1*amplitude);
              //float height = n1*amp1;
              amplitude *= persistance;
              frequency *= lacunarity;
            }
            mapNoise[j][i] = height;
              // if(height>sealevel)map[j][i] = color(0, 0, 153);
              // else if(height>groundlevel)map[j][i] = color(204, 204, 0);
              // else if(height>grasslevel)map[j][i] = color(51, 153, 51);
              // else if(height>mountainlevel)map[j][i] = color(102, 102, 153); 

              // with alpha
              // if (height>mountainlevel)map[j][i] = color(102, 102, 153,mountainlevel*255); 
              // else if (height>grasslevel)map[j][i] = color(51, 153, 51,grasslevel*255);
              // else if (height>groundlevel)map[j][i] = color(204, 204, 0,groundlevel*255);
              // else if (height<sealevel)map[j][i] = color(0, 0, 153,sealevel*255);
              if (height>mountainlevel)map[j][i] = color(102, 102, 153); 
              else if (height>grasslevel)map[j][i] = color(51, 153, 51);
              else if (height>groundlevel)map[j][i] = color(204, 204, 0);
              else if (height<sealevel)map[j][i] = color(0, 0, 153);

              a.col = color(map[j][i]);
              debug(a);
              
              //a.get_neighbours(this);
              //a.getNeighbours4(this);
              
            if(brightness(a.col) > max)max = brightness(a.col);
            canvas.fill(a.col);
            canvas.noStroke();
            canvas.rect(a.x,a.y,a.w,a.h);
            a.compared = false;
            begin = false;
          }
          
          if(a.popVisited)fill(a.popCol);
          int count_ = 0;
          if(agentsPopulated)updateAgents(count_,a);
          //if(contour)a.drawBoundaries();
          if (!mapScoped&&count_==0)agentsCounted ++;
      }}
  g1.img = canvas.get((int)x,(int)y,(int)w,(int)h);
  canvas.endDraw();
  image(g1.img,x,y);
  if(!contour){
    // remember to change sobel back;
    g1.sobel = null;
  }else {
    if(g1.sobel==null||contourUpdate){
      g1.sobel(9,4);
      //println(scale1,frequency,amplitude,octaves);

      contourUpdate = false;
    }
    image(g1.sobel,x,y);
  }
  sysUpdate = false;
  update = false;
  sUpdate = false;
  contourUpdate = false;
      //if (contour)endShape(OPEN);
  //if(frameCount%10==0)println(mountainlevel);
  //println(squaresCounted,squares.size());
  if (toggle&&pallete.visible)pallete.draw();
  if (toggle&&sliderMenu!=null&&sliderMenu.visible)sliderMenu.draw();
  if (squaresCounted==squares.size()) sdown = false;
  if (agentsCounted==squares.size()-rows&&agentsPopulated)mapScoped = true;
  if (bcount>=squares.size())Boundaries = true;

  fill(0);
  text(frameRate,100,100);
      
  };
  
  void display2(){
    mouseLogic();
    if(scale<=0)scale = 0.0001;
    
      for(int i=0;i<rows;i++){
        for(int j=0;j<cols;j++){
          
          noStroke();
          
          if(update){
            float yy = scale*i*freq;
            float xx = scale*j*freq;
            float n = noise(xx,yy);
            float height = n*amp;
            //map[j][i] = n;
            mapNoise[j][i] = n;
            if(height>0.2)map[j][i] = color(0, 0, 153);
            if(height>0.4)map[j][i] = color(204, 204, 0);
            if(height>0.6)map[j][i] = color(51, 153, 51);
            if(height>0.8)map[j][i] = color(102, 102, 153); 
          }
          
          color col = map[j][i];
          
          fill(col);
          rect(j*xRes,i*yRes,xRes,yRes);
        
      }}
  };
  
  void displayGrid(){
    mouseLogic();
    
    for(int i=0;i<rows;i++){
        for(int j=0;j<cols;j++){
          if(update){
                //float height = mapNoise1d[i]*amp*freq;
                
                int p = j + i * cols;
                float yy = scale*i*freq;
                float xx = scale*j*freq;
                float n = noise(xx,yy);
                float height = n*amp;
                mapNoise1d[i] = n;
                if(height>0.2)map1d[p] = color(0, 0, 153);
                if(height>0.4)map1d[p] = color(204, 204, 0);
                if(height>0.6)map1d[p] = color(51, 153, 51);
                if(height>0.8)map1d[p] = color(102, 102, 153); 
              
                color col = map1d[p];
                
                grid.getChild(p).setFill(col);
          }
    }}
    
    shape(grid);
    fill(255,0,0);
    text(gridChildren,100,210);
  };

  void displayMesh(){


  };

  void draw2d(){
    
    if (toggle) {
      logic();
      keys();
      fill(255);
      text(squares.size(),100,200);
      noiseSeed(int(seed));
      if(pallete.click(8))exit();
      //if()
      agentsCounted = 0;
      if (border){
        stroke(0);
        fill(255);
        rect(x,y,w,h);
      }
      int count = 0;
      for (int i=0;i<rows;i++) {
        for (int j=0;j<cols;j++) {

          float x1 = (scale1*j*freq);
          float y1 = (scale1*i*freq);

          float x2 = (scale2*j*freq);
          float y2 = (scale2*i*freq);

          float x3 = (scale3*j*freq);
          float y3 = (scale3*i*freq);

          int pos = j + i * cols;
          
          float height1 = map(noise(x1, y1)*amp1, 1, 0, 0, 255);
          float height2 = map(noise(x2, y2)*amp2, 1, 0, 0, 255);
          float height3 = map(noise(x3, y3)*amp3, 1, 0, 0, 255);

          float height = (height1+height2+height3)/3;
          Grid_space a = squares.get(pos);

          float mapHeight = map(height,0,255,0,255);
          
          float sea = sealevel;
          float floor = groundlevel;
          float grass = grasslevel;
          float mountain = mountainlevel;
          fill(a.col);
          if (mapHeight>mountain) {
            a.col2 = color(255, 255, 255);
            a.col = color(255, 255, 255, 255-abs(mapHeight/2)*1.2);
            C = color(255, 255, 255, 255-abs(mapHeight/2)*1.2);
          } else if (mapHeight>grass) {
            a.col2 = color(0, 255, 0);
            a.col = color(0, 255, 0, 255-abs(mapHeight/2)*1.1);
            C = color(0, 255, 0, 255-abs(mapHeight/2)*1.1);
          } else if (mapHeight>floor) {
            a.col2 = color(255, 255, 0);
            a.col = color(255, 255, 0, 255-abs(mapHeight/2)*1.1);
            C = color(255, 255, 0, 255-abs(mapHeight/2)*1.1);
          } else if (mapHeight<sea) {
            a.col2 = color(0, 0, 255);
            a.col = color(0, 0, 255, 255-abs(mapHeight/2)*1.1);
            C = color(0, 0, 255, 255-abs(mapHeight/2)*1.1);
          } else {
            a.col2 = color(255, 255, 255);
            a.col = color(255, 255, 255, 255-abs(mapHeight/2)*1.2);
            C = color(255, 255, 255, 255-abs(mapHeight/2)*1.2);
          }

            if (visible) {
              debug(a);
              fill(a.col);
              if(circle) {
              ellipseMode(CORNER);
              ellipse(a.x, a.y, a.w, a.h);
              }
              if (dot) {
                strokeWeight(2);
                point(a.x, a.y);
                strokeWeight(1);
              }
              if(rect) {
                fill(a.col);
                noStroke();
                rect(a.x, a.y, a.w,a.h);

                // beginShape(QUAD);
                // noStroke();

                // vertex(a.x, a.y);
                // vertex(a.x + a.w, a.y);
                // vertex(a.x + a.w, a.y + a.h);
                // vertex(a.x, a.y + a.h);


                // endShape();
              }
              //a.drawBoundaries();
              compareNeighbours(a,count);
            }}}}

    text(frameRate, W-50, 90);
    if (toggle&&pallete.visible)pallete.draw();
    if (toggle&&sliderMenu!=null&&sliderMenu.visible)sliderMenu.draw();
    if (squaresCounted==squares.size()) sdown = false;
    if (agentsCounted==squares.size()-rows&&agentsPopulated)mapScoped = true;
    if (bcount>=squares.size())Boundaries = true;

  };

  void compareNeighbours(Grid_space a,int count){

    if (!fill) noFill();
    if (a.popVisited&&populateBoundaries)fill(a.popCol);

    if (sdown)a.neighboured = false;

    if (!a.neighboured) {
      squaresCounted++;
      a.get_neighbours(this);
    }
    noStroke(); 
                  
    if (!mapScoped&&count==0)agentsCounted ++;
  };



  void draw_2d() {
    if (terrain3d&&toggle) {
      pushMatrix();
      translate(W/2, H/2);

      if (mousePressed) {
        //XX += pmouseX - mouseX;
        //YY += pmouseY - mouseY;
      }
      rotateX(PI/3+radians(xrot+YY));
      translate(-W/2, -W/2);
      translate(w/2, h/2);
      rotateZ(radians(zrot+XX));
      translate(-w/2, -h/2);
      translate(w/2, 0);
      rotateY(radians(yrot));
      translate(-w/2, 0);
      translate(-hdistance-400, -distance-400, -vdistance);
      keys();
    }

    if (toggle) {
      logic();
      rowcount = 0;
      colcount = 0;
      noiseSeed(int(seed));
      fill(255);
      text(seed,100,200);

      float yoffr = fy;
      perlx_yoff = pxfy;
      perly_yoff = pyfy;

      agentsCounted = 0;

      for (int yy = 0; yy < rows-1; yy++) {

        if (terrain3d)beginShape(TRIANGLE_STRIP);
        
        float xoffr = fx;
        perlx_xoff = pxfy;
        perly_xoff = pyfy;

        for (int xx = 0; xx< cols; xx++) {

          int pos = xx + yy * cols;
          terrain[xx][yy] = map(noise(xoffr, yoffr), 1, 0, 0, 255);
          perlx[xx][yy] = map(noise(perlx_xoff, perlx_yoff)*map1, 1, 0, 0, 255);
          perly[xx][yy] = map(noise(perly_xoff, perly_yoff)*map2, 1, 0, 0, 255);

          xoffr += noise1 + zoom;
          // perlx_xoff += pow(noise1,map1) + zoom;
          // perly_xoff += pow(noise2,map2) + zoom;

          perlx_xoff += noise2 + zoom;
          perly_xoff += noise3 + zoom;

          strokeWeight(0);

          Grid_space a = squares.get(pos);

          float num = perlx[xx][yy];
          float num1 = perly[xx][yy];
          // float R = map((terrain[xx][yy]+num+num1),0,255/map1+255/map2+255,0,255);
          float R = map((terrain[xx][yy]+num+num1),0,765,0,255);
          
          float floor2 = groundlevel2;
          float mountain = mountainlevel;
          float sea = sealevel;
          float grass = grasslevel;

          if (a.shape!=null)a.shape.draw();
          
          if ((terrain2d||terrain3d)&&!plain) {
            fill(a.col);
            if (R>mountain) {
              a.col2 = color(255, 255, 255);
              a.col = color(255, 255, 255, 255-abs(R/2)*1.2);
              C = color(255, 255, 255, 255-abs(R/2)*1.2);
            } else if (R>grass) {
              a.col2 = color(0, 255, 0);
              a.col = color(0, 255, 0, 255-abs(R/2)*1.1);
              C = color(0, 255, 0, 255-abs(R/2)*1.1);
            } else if (R>floor2) {
              a.col2 = color(255, 255, 0);
              a.col = color(255, 255, 0, 255-abs(R/2)*1.1);
              C = color(255, 255, 0, 255-abs(R/2)*1.1);
            } else if (R<sea) {
              a.col2 = color(0, 0, 255);
              a.col = color(0, 0, 255, 255-abs(R/2)*1.1);
              C = color(0, 0, 255, 255-abs(R/2)*1.1);
            } else {
              a.col2 = color(255, 255, 255);
              a.col = color(255, 255, 255, 255-abs(R/2)*1.2);
              C = color(255, 255, 255, 255-abs(R/2)*1.2);
            }}

          if (forward||backward) {
            if (acceleration!=0)a.ax = acceleration;
            a.ay = acceleration;
            if (a.collide) fill(0);
            if (a.pos()&&hover) fill(0, 255, 0);

            stroke(a.col);
            strokeWeight(bordersize);
            if (!border) noStroke();

            // ------------------------------------------ time control---------------------------------------
            if (forward) {
              a.forward = true;
              a.pause = false;
              a.backward = false;
              a.update();
            } else if (backward) {
              a.forward = false;
              a.pause = false;
              a.backward = true;
              a.update();
            } else if (pause) {
              a.forward = false;
              a.pause = true;
              a.backward = false;
              a.update();
            } else {
              a.forward = false;
              a.pause = false;
              a.backward = false;
              a.update();
            }
            if (attractor)a.attractors();

            if (mouse&&forward)a.mouse();
          }
          if (terrain2d) {
            if (visible) {
              debug(a);
              if (!circle&&!dot&&!shape&&!plain) {
                fill(a.col);
                if (!fill) noFill();
                if(!terrainP)fill(255,40);
                if (a.popVisited&&populateBoundaries)fill(a.popCol);

                if (sdown)a.neighboured = false;

                if (!a.neighboured) {
                  squaresCounted++;
                  a.get_neighbours(this);
                }
                noStroke(); 
                if (plain)stroke(0);
                //if(!terrainP){stroke(0,150);strokeWeight(1);}
                rect(a.x, a.y, a.w, a.h);

                int count = 0;

                for (int k=0; k<a.Neighbours_b.length; k++) {

                  Grid_space neighbour = a.Neighbours_b[k];

                  if (neighbour!=null&&a.col2!=-10000&&neighbour.col2!=-10000&&neighbour.col2==a.col2)a.Walls_b.set(k, false);
                  else if (neighbour==null||neighbour!=null&&a.col2!=-10000&&neighbour.col2!=-10000&&a.col2!=neighbour.col2)a.Walls_b.set(k, true);

                  //if (neighbour!=null&&(a.Walls_b.get(k)))if(contour)a.Boundaries.get(k).drawLine();
                  

                  if (neighbour!=null&&a.popVisited&&neighbour.popVisited) {
                    if (a.col2!=-10000
                      &&neighbour.col2!=-10000
                      
                      &&a.popCol!=neighbour.popCol
                      &&a.col2==neighbour.col2
                      &&agentsBackup.get(a.popId).psteps<=agentsBackup.get(neighbour.popId).psteps
                      ) {
                      agentsBackup.get(a.popId).psteps --;
                      agentsBackup.get(neighbour.popId).psteps ++;

                      a.popId = neighbour.popId;
                      a.popCol = neighbour.popCol;
                      count++;
                    }}}

                if(contour)a.drawBoundaries();
                if (!mapScoped&&count==0)agentsCounted ++;
                //if (!populateBoundaries) {
                //  if (!wallSquares.contains(a)&&(wall>0))wallSquares.add(a);
                //  else if (wallSquares.contains(a)&&wall==0)wallSquares.remove(wallSquares.indexOf(a));
                //}
              } else {
                ellipseMode(CORNER);
                if (circle) ellipse(a.x, a.y, a.w, a.h);
                else if (dot) {
                  strokeWeight(2);
                  point(a.x, a.y);
                  strokeWeight(1);
                }
              }
            }
          } else if (terrain3d) {
            float mult = 1;
            fill(a.col);
            stroke(a.col);
            if (!border)noStroke();
            if (!fill)noFill();
            if (floored) {

              float a1 = terrain[xx][yy];
              float a2 = terrain[xx][yy];
              float a3 = terrain[xx][yy];
              float a4 = terrain[xx][yy];

              if (groundlevel<sealevel)groundlevel=sealevel;
              if (grasslevel<groundlevel)grasslevel=groundlevel;
              if (mountainlevel<grasslevel)mountainlevel=grasslevel;

              if (a1<sealevel)a1 = sealevel;
              else {
                if (a1<groundlevel2)a1 = groundlevel2;
                else {
                  if (a1<grasslevel)a1 = grasslevel;
                  else a1 = a3;
                }
              }
              if (a2<sealevel)a2 = sealevel;
              else {
                if (a2<groundlevel2)a2 = groundlevel2;
                else {
                  if (a2<grasslevel)a2 = grasslevel;
                  else a2 = a4;
                }
              }

              vertex(xx*a.w*mult, yy*a.h*mult, terrain[xx][yy]);
              vertex(xx*a.w*mult, (yy+1)*a.h*mult, terrain[xx][yy+1]);
            } else if (R<-100) {
              vertex(xx*a.w*mult, (yy)*a.h*mult, terrain[xx][yy]);
              vertex(xx*a.w*mult, (yy+1)*a.h*mult, terrain[xx][yy+1]);
            }
          }
        }
        if (terrain3d)endShape(CLOSE);
        yoffr += noise1 + zoom;
        // perlx_yoff += pow(noise1,map1) + zoom;
        // perly_yoff += pow(noise2,map2) + zoom;
        perlx_yoff += noise2 + zoom;
        perly_yoff += noise3 + zoom;
      }
    }
    if (terrain3d)popMatrix();
    //if (debug)
    text(frameRate, W-50, 90);
    if (toggle&&pallete.visible)pallete.draw();
    keys();
    if (toggle&&sliderMenu!=null&&sliderMenu.visible)sliderMenu.draw();
    if (squaresCounted==squares.size()) {
      //neighboured = true;
      sdown = false;
    }
    if (agentsCounted==squares.size()-rows&&agentsPopulated)mapScoped = true;
    if (bcount>=squares.size())Boundaries = true;
    //if(mapScoped)text("Scoped",W-50,120);
    if(frameRate%100==0)text(agentsCounted,W-50,120);
  };

  void draw3d(){

  };

  void debug(Grid_space a) {

    if (a.pos()&&debug) {
      float X = W-170;
      float Y = 23;
      float vspacing = 12;
      fill(255,100);
      rect(X, Y, 170, 200);

      fill(0);
      text("ID : " + a.id, X, Y + vspacing);
      text("Pid : " + a.pid, X + 55, Y + vspacing*1);
      text("Pop ID : " + a.popId, X + 105, Y + vspacing*1);
      text("Pop Color : " + a.popCol, X, Y + vspacing*2);
      text("Col 2 : " + a.col2, X, Y + vspacing*3);
      text("Walls : ", X, Y + vspacing*4);

      for (int i=0; i<a.Walls_b.size(); i++) {
         text(str(a.Walls_b.get(i)) + ", ", X+40+30*i, Y+ vspacing*4);
      }
      text("Direc Neighbours: " + a.Neighbours_4.size(),X,Y + vspacing * 5);
      text("All Neighbours: " + a.Neighbours_8.size(),X,Y + vspacing * 6);
      text("Node: " + str(a.node), X,Y + vspacing * 7);
      text("Conn. Neighbours: " + a.connections.size(),X,Y + vspacing * 8);
      text("Toggle: " + str(a.toggle),X,Y + vspacing * 9);
      text("Pop Visited: " + str(a.popVisited),X,Y + vspacing * 10);
      text("Visited: " + str(a.visited),X,Y + vspacing * 11);
      text("Path Connected: " + str(a.pathConnected),X,Y + vspacing * 12);

      text("Parents: " ,X,Y + vspacing * 13);
      for(int i=0;i<a.parents.size();i++){
        text(a.parents.get(i).id,X + 60 + 40 * i,Y + vspacing * 13);
      }

      text("Connections: ",X,Y + vspacing * 14);
      for(int i=0;i<a.connections.size();i++){
        text(a.connections.get(i).id,X + 80 * i,Y + vspacing * 14);
      }
    }
  };

  void popAgents() {
    if (populateBoundaries&&!agentsPopulated) {
      for (int i=0; i<totalAgents; i++) {

        Grid_space g = squares.get(floor(random(squares.size())));
        g.popId = i;
        g.pid = i;
        g.popCol = color(random(255), random(255), random(255));

        if (!agents.contains(g)) {
          g.popVisited = true;
          agents.add(g);
          agentsBackup.add(g);
          agentsConst.add(g);
          popHist.add(new ArrayList<Grid_space>());
          popStack.add(new ArrayList<Grid_space>());
          connections.add(new ArrayList<Grid_space>());
        } else i--;
      } 
      agentsPopulated = true;
      println(agents.size());
    }
  };

  void seekBoundaries() {

    //if(agentsCounted<totalAgents){
    text(agentsCounted, W-50, 100);
    text(squares.size(), W-50, 110);


    if (agentsPopulated) {
      for (int i=0; i<agents.size(); i++) {

        Grid_space c = agents.get(i);

        Grid_space next = c.getNewNeighbour();

        Grid_space home = agentsBackup.get(i);

        ArrayList<Grid_space> neighbours = c.getNewNeighbour1(this);

        Grid_space t = agentsBackup.get(i);
        
        fill(255, 0, 0, 150);
        noStroke();

        if (populateBoundaries&&!contour){
          // rect(t.x, t.y, c.w, c.h);
          // rect(t.x, t.y, c.w, c.h);
        }
        stroke(0);
        if (contour)line(c.x, c.y, home.x, home.y);
        
        //println("agents size " + agents.size());
        if (next!=null) {
          //println("next :  " + next.id);
          next.psteps = agentsBackup.get(c.popId).psteps;
          agentsBackup.get(c.popId).psteps ++;

          next.popVisited = true;
          next.popId = c.popId;
          next.pid = c.pid;
          next.next = c;
          next.popCol = c.popCol;

          popHist.get(c.pid).add(c);
          popStack.get(c.pid).add(c);

          if (popStack.get(c.pid).size()>1)trimPopStack2(c);
          agents.set(i, next);
        } else if (!pause&&popStack.get(i).size()>0)agents.set(i, popStack.get(i).remove(popStack.get(i).size()-1));
        else if (agents.get(i)!=agentsBackup.get(i)){
          agents.set(i, agentsBackup.get(i));
          agents.get(i).noNewPopNeighbours = true;
          popCount ++;
        }
      }
      if(popCount==agents.size()&&popCount<squares.size())popPhase2 = true;
    }
  };

  void completeBoundaries() {

    if (populateBoundaries&&unsortedWallSquares.size()>0&&!pause) {
      ArrayList<Grid_space> biome = new ArrayList<Grid_space>();
      
        biome = unsortedWallSquares.remove(0);
      if (unsortedWallSquares.size()>0) {
        
        Grid_space current = biome.get(biome.size()-1);
        Grid_space next = current.getNewWallNeighbour(this);

        if (next!=null) {
          rect(next.x+next.w/2, next.y+next.h/2, next.w, next.h);
          next.wVisited = true;
          if (!biome.contains(next))biome.add(next);
          int k = wallSquares.indexOf(next);
          if (k>-1)wallSquares.remove(k);
        } else {
          if (!boundaries.contains(biome))boundaries.add(biome);
          biome = new ArrayList<Grid_space>();
        }
      } else if (!boundaries.contains(biome))boundaries.add(biome);
    }
    fill(255);
    text(boundaries.size(), W-50, 110);
    
    for (int i=boundaries.size()-1; i>0; i--) {

      ArrayList<Grid_space> g = boundaries.get(i);

      text(g.size(), 100, 100+10*i);

      for (int k=0; k<g.size(); k++) {
        Grid_space a = g.get(k);

        rect(a.x, a.y, a.w, a.h);
      }
    }
  };

  void seekBoundaries3() {

    if(mapScoped){
      fill(255);
      println("scoped");
      text(unsortedSquares.size(),W-50,140);
      text(squares.size(),W-50,150);

    if (squares.size()>=unsortedSquares.size()&&!beginSquareSorting) {
      
      for (int i=1; i<squares.size(); i++) {
        Grid_space b = squares.get(i);

        unsortedSquares.add(b);
      }}
    else beginSquareSorting = true;
    int count = 0;
    if(beginSquareSorting){
      if(unsortedSquares.size()>0){
      
      tempSquares = new ArrayList<Grid_space>();
      temp = new ArrayList<Grid_space>();
      
      Grid_space a = unsortedSquares.remove(0);

      if(!tempSquares.contains(a))tempSquares.add(a);
      
      for (int i=unsortedSquares.size()-1;i>-1;i--) {

        Grid_space b = unsortedSquares.get(i);
        
        fill(255,100);
        noStroke();
        rect(b.x, b.y, b.w, b.h);
        
        int walls = 0;
        
        if (a.popCol==b.popCol) {
          
            tempSquares.add(b);
            count++;
            unsortedSquares.remove(i);
            
            for(int j=0;j<b.Walls_b.size();j++)if(b.Walls_b.get(j))walls++;
            
            if(walls>0)temp.add(b);
        }}
        sortedSquares.add(tempSquares);
        wallSquares.add(temp);
        unsortedWallSquares.add(temp);
    }else sortBoundaries = true;}}
        
      fill(255,0,0);
      text("Sorted : " + sortedSquares.size(),W-100,170);
      text("Unsorted : " + unsortedSquares.size(),W-100,180);
      
      for(int i=0;i<sortedSquares.size();i++){
        text(sortedSquares.get(i).size(),W-50,190+10*i);
        if(sortedSquares.get(i).size()>0){
          
          Grid_space b = sortedSquares.get(i).get(0);
          fill(0);
          noStroke();
          rect(b.x, b.y, b.w, b.h);
          
      }}
    
    for(int i=0;i<wallSquares.size();i++){
      
      for(int j=0;j<wallSquares.get(i).size();j++){
        
        Grid_space b = wallSquares.get(i).get(j);
        fill(0,100);
        noStroke();
        rect(b.x, b.y, b.w, b.h);
    }}
  };
  
  void completeBoundary(){
    
    for(int i=0;i<wallSquares.size();i++){
      
      for(int j=0;j<wallSquares.get(i).size();j++){
        
        Grid_space b = wallSquares.get(i).get(j);
        fill(0,100);
        noStroke();
        rect(b.x, b.y, b.w, b.h);
    }}
    
  };

  void updateHist(int a, int b) {

    for (int j=popHist.get(a).size()-1; j>-1; j--) {

      Grid_space c = popHist.get(a).get(j);

      ArrayList<Grid_space> neighbours = c.getNewNeighbour2(this);

      if (neighbours!=null) {

        for (int i=0; i<neighbours.size(); i++) {

          Grid_space next = neighbours.get(i);

          next.popId = a;
          next.popCol = agentsBackup.get(b).popCol;
        }
      }
    }
  };

  int getSteps(int i) {
    int k = popHist.get(i).size();
    //for(int j=0;j<agentsBackup.get(i).modifiedAgents.size();j++){

    //  Grid_space g1 = agentsBackup.get(i).modifiedAgents.get(j);

    //  k += popHist.get(g1.pid).size();
    //}
    //for(int j=0;j<agentsBackup.get(i).visitedBy.size();j++){

    //  Grid_space g1 = agentsBackup.get(i).visitedBy.get(j);

    //  k += popHist.get(g1.pid).size();
    //}
    return k;
  };


  void sortHist() {
    if (sortedAgents.size()<totalAgents) {

      if (agents.size()>0) {

        Grid_space c = mostTravelledAgent();

        sortedAgents.add(c);
        agents.remove(c.popId);
      } else sortedAgents.add(agents.get(0));
    }
  };

  Grid_space mostTravelledAgent() {

    Grid_space c = agents.get(0);

    for (int i=1; i<agents.size(); i++) {

      Grid_space n = agents.get(i);

      if (n.steps>c.steps)c = n;
    }
    return c;
  };

  void connectMap() {
    if (mapScoped) {
      agentsCounted = 0;
      for (int i=0; i<agents.size(); i++) {
        Grid_space c = agents.get(i);
        //Grid_space next = c.getNewNeighbour2(this);
      }
    }
  };

  void trimPopStack(int i) {

    if (popStack.get(i).size()>1) {

      for (int j=popStack.get(i).size()-1; j>-1; j--) {

        Grid_space next = popStack.get(i).get(j).getNewNeighbour();
        ArrayList<Grid_space> next1 = popStack.get(i).get(j).getNewNeighbour4(this);

        if (next!=null||next1!=null)break;
        else popStack.get(i).remove(j);
      }
    }
  };

  void trimPopStack2(Grid_space a) {

    if (popStack.get(a.pid).size()>0) {

      for (int j=popStack.get(a.pid).size()-1; j>-1; j--) {

        Grid_space next = popStack.get(a.pid).get(j).getNewNeighbour();
        //ArrayList<Grid_space> next1 = popStack.get(a.pid).get(j).getNewNeighbour4(this);
        ArrayList<Grid_space> next1 = null;
        

        if (next!=null) {
          //next.getNewNeighbour4(this);
          Grid_space b = popStack.get(a.pid).get(j);

          //b.pid    = a.pid;
          //b.popId  = a.pid;
          //b.psteps = agentsBackup.get(a.pid).psteps;

          b.pid    = agents.size()-1;
          b.popId  = agents.size()-1;
          b.leader = a.leader;
          b.popCol = a.popCol;
          b.psteps = agentsBackup.get(a.popId).steps;

          //agentsBackup.add(agentsBackup.get(a.pid));
          //agentsConst.add(agentsConst.get(a.pid));

          agentsBackup.add(b);
          agentsConst.add(b);

          popHist.add(new ArrayList<Grid_space>());
          popStack.add(new ArrayList<Grid_space>());

          agents.add(b);
          totalAgents++;

          break;
        }
        if (next1!=null)break;
        if (next==null&&next1==null&&popStack.get(a.pid).size()>0) popStack.get(a.pid).remove(j);
      }
    }
  };

  void addToArray(ArrayList<Grid_space> a, ArrayList<Grid_space> b) {

    for (int i=0; i<b.size(); i++) {
      Grid_space g = b.get(i);
      a.add(g);
    }
  }



  void gshape(int sides, Grid_space a, color col) {

    beginShape();
    noFill();
    float theta = 360 / sides;
    for (int i=0; i<sides; i++) {
      if (a.Walls_a.get(i)==true) {
        float thetab =  theta * i;
        float thetac =  theta * i+theta;
        stroke(col);
        if (!a.parent.border) noStroke();
        strokeWeight(1);
        line(a.x+a.w/2*sin(thetab), a.y+a.w/2*cos(thetab), a.x+a.w/2*sin(thetac), a.y+a.w/2*cos(thetac));
      } else noStroke();
    }
    endShape();
  };

  void keys() {
    if (ztoggle2==1)zoom -= noise1;
    if (ztoggle==1)zoom += noise1;
    
    // left
    int n = 0;
    float k = 0.05;

    if (keyPressed && keyCode ==37) {
      n++;
      if (!terrain3d){
        fx += k;
        pxfx += k;
        pyfy += k;
      }else {
        fy += k;
        pxfx += k;
        pyfy += k;
      }}

    // right

    if (keyPressed && keyCode ==39) {
      n++;
      if (!terrain3d){
          fx -= k;
          pxfx -= k;
          pyfy -= k;
      } else {
          fy -= k;
          pxfx -= k;
          pyfy -= k;
      }}
    // up
    if (keyPressed && keyCode ==38) {
      n++;
      if (!terrain3d) {
          fy += k;
          pxfx += k;
          pyfy += k;
      }else {
          fx -= k;
          pxfx -= k;
          pyfy -= k;
      }}
    // down
    if (keyPressed && keyCode ==40) {
      n++;
      if (!terrain3d) {
        fy -= k;
        pxfx -= k;
        pyfy -= noise3;
      }else {
        fx += k;
        pxfx += k;
        pyfy += k;
      }}

    if (keyCode == 87) {
      
      ztoggle ++;
      ztoggle2 = 0;
      if (ztoggle==2)ztoggle = 0; 
      //zoom += 0.02;
    }
    if (keyCode == 83) {
      ztoggle2 ++;
      ztoggle = 0;
      if (ztoggle2==2)ztoggle2 = 0;
    }
    if (keyCode == 68) {
      ztoggle = 0;
      ztoggle2 = 0;
    }
    if(n>0||sysUpdate)keyUpdate = true;
    else keyUpdate = false;
  };

  void keys_() {
    if (ztoggle2==1)zoom -= noise1;
    if (ztoggle==1)zoom += noise1;
    
    // left

    if (keyPressed && keyCode ==37) {
      if (!terrain3d){
        fx += noise1;
        pxfx += pow(noise1,map1);
        pyfy += pow(noise2,map2);
      }else {
        fy += noise1;
        pxfx += pow(noise1,map1);
        pyfy += pow(noise2,map2);
      }}

    // right

    if (keyPressed && keyCode ==39) {
      if (!terrain3d){
          fx -= noise1;
          pxfx -= pow(noise1,map1);
          pyfy -= pow(noise2,map2);
      } else {
          fy -= noise1;
          pxfx -= pow(noise1,map1);
          pyfy -= pow(noise2,map2);
      }}
    // up
    if (keyPressed && keyCode ==38) {
      if (!terrain3d) {
          fy += noise1;
          pxfx += pow(noise1,map1);
          pyfy += pow(noise2,map2);
      }else {
          fx -= noise1;
          pxfx -= pow(noise1,map1);
          pyfy -= pow(noise2,map2);
      }}
    // down
    if (keyPressed && keyCode ==40) {
      if (!terrain3d) {
        fy -= noise1;
        pxfx -= pow(noise1,map1);
        pyfy -= pow(noise2,map2);
      }else {
        fx += noise1;
        pxfx += pow(noise1,map1);
        pyfy += pow(noise2,map2);
      }}

    if (keyCode == 87) {
      ztoggle ++;
      ztoggle2 = 0;
      if (ztoggle==2)ztoggle = 0; 
      //zoom += 0.02;
    }
    if (keyCode == 83) {
      ztoggle2 ++;
      ztoggle = 0;
      if (ztoggle2==2)ztoggle2 = 0;
    }
    if (keyCode == 68) {
      ztoggle = 0;
      ztoggle2 = 0;
    }
  };

  void set(String a, boolean b) {
    values.put(a, b);
    //hover = true;
  };

  boolean pos() {
    float X = mouseX;
    float Y = mouseY;

    return X > x && X < x + w && Y > y && Y < y + h;
  };

  void logic() {
    if (pos() && !mousePressed) {
      dx = mouseX - x;
      dy = mouseY - y;
    }

    if ( pos() && mousePressed) {
      posx = dx;
      posy = dy;
      x = mouseX - dx;
      y = mouseY - dy;
      deltax =  dx;
      deltay =  dy;
    }
    if (BMS.terrain3d&&!terrain3d)terrain3d = true;
    else if (!BMS.terrain3d&&terrain3d)terrain3d = false;
  };

  

  void update() {
  };
};

class Shape {

  int sides;
  float x, y, w, theta;
  PVector p;
  Grid_space parent;

  ArrayList<PVector> p1 = new ArrayList<PVector>();
  ArrayList<PVector> p2 = new ArrayList<PVector>();
  ArrayList<PVector[]> lines = new ArrayList<PVector[]>();

  Shape(int Sides, Grid_space Parent) {
    sides = Sides;
    parent = Parent;
    x = parent.x;
    y = parent.y;
    w = parent.w;
    p = new PVector(x, y);
    theta = radians(360 / sides);
    for (int i=0; i<sides; i++) {
      float thetab =  theta * i;
      float thetac =  theta * i+theta;
      PVector a = new PVector (x+w/2*sin(thetab), y+w/2*cos(thetab));
      PVector b = new PVector (x+w/2*sin(thetac), y+w/2*cos(thetac));
      parent.Walls_a.set(i, true);
      p1.add(a);
      p2.add(b);
      PVector []c = {a, b};
      lines.add(c);
    }
  };

  void draw() {
    beginShape();
    fill(parent.col);

    for (int i=0; i<sides; i++) {
      if (parent.Walls_a.get(i)==true) {
        stroke(parent.col2);
        if (!parent.border) noStroke();
        strokeWeight(1);
        vertex(p1.get(i).x, p1.get(i).y);
        vertex(p2.get(i).x, p2.get(i).y);
      } else noStroke();
    }
    endShape();
  }
};



class Grid3D extends Grid {

  Grid3D() {
  };

  void save() {
  };

  void load() {
  };
};

class kernel {

  kernel() {
  };

  void init() {
  };
};

class ImgGrid extends Grid {

  ImgGrid() {
  };

  void save() {
  };

  void load() {
  };
};

class plainGrid extends Grid {

  plainGrid() {
  };

  void save() {
  };

  void load() {
  };
};

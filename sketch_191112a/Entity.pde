  float minageh = 100;
  float maxageh = 200;

  class Entity{

  int id,xp,yp,txtb_value,vcount,polarity = floor(random(-2,2)),pos,race,ent,function = floor(random(0,6)),eIndex1 = -1,eIndex2 = -1,cIndex1,cIndex2,aIndex1,aIndex2,hRaces,acount,scount,alcount,mcount,gid,xpos,ypos,range;

  public float x,y,z,w,h,intensity,mass = random(1,2),radius = random(10,30), lifespan,intelligence,dexterity,endurance,piety,vision,health,speed,selfp,charisma,agility,reputation,sanity,humanity,faith,fresistance;

  public float homex,homey,homew,homeh,birthrate = 2000;
  public float memory,movement,respiration,sensitivity,growth,regulation,nutrition,synthesis,transportation,reparation,size,tscale = 0.3,ssize = 1,hunger,h_cooldown,i_cooldown;

  public float age = 0,bscale = 0.2,time,delay,r,skill,vlimit,vlimitb = vlimit,fov = 20,eating_time = random(10,20),breathingroom,breathingroomb,breathingroomb1 = breathingroom,breathingroomb2 = breathingroomb,alimit,mult1,mult2,mu,min,minb;

  float  bdir = 0,inc = 0,countdown = random(10),countdownb = countdown,offset = 100,valueOffset = random(-offset/2,offset/2),Friction,maxSeek,maxAvoid,maxAlign,minSeek,minAvoid,minAlign,maxRange,minRange;

  public float avoidance = random(0,5),cohesion = random(0,5),cohesionb,alignment,neg = 0,wandertheta = 0,wanderm = 0.2,wandermb = wanderm,cohesionb1 = cohesion,cohesionb2 = cohesionb,separationc=1,cohesionc=1,separation = random(0,15),separationb = random(0,15),alimitb = alimit, alignmentb = alignment,avoidanceb = avoidance,alignmentc = 1,separationd = 20,separationdb,
  separationb1 = separation,separationb2 = separationb,seekN,avoidN,alignN,seekN2,avoidN2,Avoid,Cohesion,Align;

  public int carrying_capacity,boundaryspace = 30,drawtotalh;
  float vx,vy,vz,ax = 0.02,ay = 0.02,az = 0.1,dir = random(-2*PI,2*PI),sumvx,sumvy,tgdist;
  public String label;
  String arrays,floats,bools;
  float a1,a2,a3,a4,a5;
  PVector p, vel = new PVector(0,0), ac,target,center = new PVector(x,y),centervel,fp = new PVector(0,0),tp = new PVector(0,0),targetb,fp2 = new PVector(0,0),centerf = new PVector(x,y),centervelf,fpf = new PVector(0,0),velf = new PVector(0,0),friction = new PVector(0,0);
  color col = color(random(255),random(255),random(255));
  color col2 = col,cols,colb = col,hcol = color(255),col3 = color(0);
  _tri tri_boundary = null;
  _tri tri_boundaryf = null;
  _tri tri_boundaryp = null;
  _rect squ_boundary;
  _ellipse ellipse_boundary;
  Boundary current_boundary;
  Boundary Boundary;
  Plant targetfruit;
  Human leader,parent,desired,owner,obstructionh;
  Species species;
  public Scene scene;
  
  String type,path;
  boolean seek,avoid,align,avoid2;
  public boolean drag,resize,seek_food,fight,mate,work,bond,hide,mazecrawler,human,plant,animal,element,real = true,dead,birth,move,toggle,idle,familyties,addh,Birth,Death;
  boolean locked,setvel,highlight,updategenes,e1down,e2down,mdown,paused;
  public boolean trackmouse,pause,dynamic,debug,boundary,reset,followb,showbroom,showta,showtb,showheading,showsliders,showview,info,merge,stop,turn,turnh,hidesliders,visible,separationManager,cohesionManager,alignmentManager,save;
  HashMap<String,Boolean> values = new HashMap<String,Boolean>();
  HashMap<Integer,Float> neighbourVariables = new HashMap<Integer,Float>();
  ArrayList<Float> seekNeighbour = new ArrayList<Float>();
  ArrayList<Float> avoidNeighbour = new ArrayList<Float>();
  ArrayList<Float> alignNeighbour = new ArrayList<Float>();
  ArrayList<Float> seekNeighbour_ = new ArrayList<Float>();
  ArrayList<Float> avoidNeighbour_ = new ArrayList<Float>();
  ArrayList<Float> alignNeighbour_ = new ArrayList<Float>();
  ArrayList<Float> oscilators = new ArrayList<Float>();
  ArrayList<Float> oscilatorCounters = new ArrayList<Float>();

  //---------------Spatial partititoning variables----------------

  PVector a,v,part;
  boolean collide = false, update = false, ext = false;
  ArrayList<Integer> iid = new ArrayList<Integer>();
  ArrayList<Integer> iid2 = new ArrayList<Integer>();
  ArrayList<Quad> Neighbours = new ArrayList<Quad>();
  ArrayList<Quad> neighbourGrid = new ArrayList<Quad>();
  int t,c,t2 = 0;

  //---------------ArrayLists-------------------------

  ArrayList<ArrayList> Entities = new ArrayList<ArrayList>();
  ArrayList<Boundary> boundariesAvoid = new ArrayList<Boundary>();
  ArrayList<Boundary> boundariesFollow = new ArrayList<Boundary>();
  ArrayList<Boolean> walls = new ArrayList<Boolean>();
  ArrayList<ArrayList<Human>> Humans = new ArrayList<ArrayList<Human>>();
  public ArrayList<ArrayList<Plant>> Plants = new ArrayList<ArrayList<Plant>>();
  ArrayList<ArrayList<Animal>> Animals = new ArrayList<ArrayList<Animal>>();
  ArrayList<ArrayList<Mineral>> Minerals = new ArrayList<ArrayList<Mineral>>();
  ArrayList<ArrayList<Metal>> Metals = new ArrayList<ArrayList<Metal>>();
  ArrayList<ArrayList<Cell>> Cells = new ArrayList<ArrayList<Cell>>();
  ArrayList<ArrayList<Particle>> Particles = new ArrayList<ArrayList<Particle>>();
  ArrayList<Entity> neighbours = new ArrayList<Entity>();
  ArrayList<Human> neighboursH = new ArrayList<Human>();
  ArrayList<ArrayList<mazeCrawler>> Mazecrawlers = new ArrayList<ArrayList<mazeCrawler>>();

  //ArrayList<Integer> genes = new ArrayList<Integer>();
  boolean births,try_,conception;
  int child;
  float dice;
  fileOutput saveEntities = new fileOutput();
  String []saveLocations = {"entities\\humans.txt","entities\\animals.txt","entities\\particles.txt"};
  String saveLocation = "";
  String [] folder,humans,plants;

  ArrayList<Human> Children = new ArrayList<Human>();
  ArrayList<Human> family = new ArrayList<Human>();
  ArrayList<Human> avoidh = new ArrayList<Human>();
  ArrayList<Human> proximity = new ArrayList<Human>();
  ArrayList<Human> prox = new ArrayList<Human>();
  ArrayList<ArrayList<Human>> prox2 = new ArrayList<ArrayList<Human>>();
  ArrayList<ArrayList<Human>> proximity2 = new ArrayList<ArrayList<Human>>();
 
  HashMap<String,Float>genes = new HashMap<String,Float>();
  HashMap<String,Float>sgenes = new HashMap<String,Float>();
  ArrayList<String> Genes = new ArrayList<String>();
  ArrayList<String> desired_traits = new ArrayList<String>();
  ArrayList<String> desired_skill = new ArrayList<String>();

  Float [] avoid_angles = {radians(0),radians(45),radians(-45),radians(90),radians(-90),radians(135),radians(-135),radians(180)};
  Float [] avoid_angles2 = {radians(90),radians(-90),radians(135),radians(-135),radians(180)};

  String []oscilatorLabels = { "vlimit","alimit","cohesion","alignment","separation","breathingroom","separationc","cohesionc"};
  
  Entity(){
  };

  Entity(float xx, float yy,float ww,float hh){

    homex = xx;
    homey = yy;
    homew = xx + ww;
    homeh = yy + hh;
    w = ww;
    h = hh;
    //Boundary = new Boundary();
    scene = new Scene(xx,yy,w,h);
  };


  Entity(float xx, float yy,int Type){

    x = xx;
    y = yy;

  };

  ArrayList<Human> getNeighbours2(){
    
    Entity e = entities.get(ent);

    float max = round(e.Humans.get(race).get(0).maxRange);
    float min = floor(e.Humans.get(race).get(0).minRange);
    //int clip = 0;
    //if(k1>0)clip = k1;
    ArrayList<Quad> n = new ArrayList<Quad>();
    Quad myTile = qgrid.get(pos);
    
      for(int i=floor(xpos+min);i<=xpos+max;i++){
        for(int j=floor(ypos+min);j<=ypos+max;j++){
          
          if(int(i+j*gw)<qgrid.size()&&int(i+j*gw)>0){
            
            Quad q = qgrid.get(int(i+j*gw));
            float d = dist(xpos,ypos,q.xpos,q.ypos);
            if(d<maxRange){
              if(!neighbourGrid.contains(q))neighbourGrid.add(q);
            }}
    }}
    
    //neighbourGrid = n;
    ArrayList<Human> n1 = new ArrayList<Human>();
    
    for(int i=0;i<neighbourGrid.size();i++){
      Quad a = neighbourGrid.get(i);
      for(int j=0;j<a.children.size();j++){
        Human c = a.children.get(j);
        if(c!=null&&c!=this&&!neighbours.contains(c))neighbours.add(c);
        //else break;
    }}
    
    neighboursH = n1;
    return neighboursH;
  };

  void save(){
    //if(save){
      int n = 0;
      saveEntities.checkLocation(saveLocations[n]);
      saveEntities.open();
      for(int i=0;i<Humans.size();i++){

        ArrayList< Human> H = Humans.get(i);

        for(int j=0;j<H.size();j++){
          String s = "[";
          for (int k=0;k<H.get(j).Genes.size();k++) {
            s += H.get(j).genes.get(H.get(j).Genes.get(k)) + ",";
          }

      s = s.substring(0,s.length() - 1)+"]";
      saveEntities.write(s);
      
      }}

      for(int i=0;i<Humans.size();i++){
        //saveEntities.write("[");
        ArrayList< Human> H = Humans.get(i);
        String s = "[",s1 = "",s2 = "";

        for(int j=0;j<H.get(0).avoidNeighbour.size();j++){
          s += H.get(0).avoidNeighbour.get(j) + ",";
          //saveEntities.write(s);
        }
        for(int j=0;j<H.get(0).seekNeighbour.size();j++){
          s += H.get(0).seekNeighbour.get(j) + ",";
          //saveEntities.write(s1);
        }
        for(int j=0;j<H.get(0).alignNeighbour.size();j++){
          s += H.get(0).alignNeighbour.get(j) + ",";
          //saveEntities.write(s2);
        }
        s+= "]";
        saveEntities.write(s);
      }

      saveEntities.close();
      println(Humans.size());
      n ++;
      //saveEntities.checkLocation(saveLocations[n]);
      saveEntities.update("entities" ,"plants.txt",saveEntities.counter);
      
       saveEntities.open();
      for(int i=0;i<Plants.size();i++){
        ArrayList< Plant> H = Plants.get(i);
        for(int j=0;j<H.size();j++){
          String s = "[";
          for (int k=0;k<H.get(j).Genes.size();k++) {
            s += H.get(j).genes.get(H.get(j).Genes.get(k)) + ",";
          }
      s = s.substring(0,s.length() - 1)+"]";
      saveEntities.write(s);
      }}
      saveEntities.close();
      // n ++;

      //fRate.savePath = "entities" + "\\" + "sliders.txt";
      fRate.save.update("entities" ,"sliders.txt",saveEntities.counter);
      fRate.save();
    //}
  };

  void load(){
    int n = 1000;
    String []s = listNames(dataPath("")+"//");
    if(s!=null&&path==null){
    for(int i=0;i<s.length;i++){
      String []s1 = match(s[i],"entities");
      if(s1!=null){
        for (int j=n; j>-1;j--){
          String []s2 = match(s[j],n + "entities");
          if(s2!=null){
            path = n + "entities";
            break;
      }}}}
      //folder = loadStrings(path);
    }

    if(folder!=null){
      s = listNames(path);

      for(int i=0;i<s.length;i++){
        String []s1 = match(s[i],"humans");
        if(s1!=null){

        }
      }
    }
    
  };

  void Reset(){
    if(reset){
      Humans = new ArrayList<ArrayList<Human>>();
      entities.remove(ent);
      spawnRaces("human",1,200);
      btn35.toggle = 0;
      Entities_sublist.toggle = 0;
      reset = false;
    }
  };

  void move(){

    x += random(-vx,vx);
    y += random(-vy,vy);

  };

  void create_genes(){

  };

  void update_Genes(){
    if(updategenes){

      for ( String key : genes.keySet() ) {

          try{
         Field field = key.getClass().getField(key);
         Float strValue = (Float) field.getFloat(key);
           genes.replace(key,strValue);

         }catch (NoSuchFieldException e) {
           }catch (IllegalAccessException e) {
         }}
      updategenes = false;
    }

    //for(int i=0;i<
  };

  void info(){
    fill(255);
    textSize(20);
    //if(lines.scene.boundary!=null)text(lines.scene.boundary.type,100,80);
    text(Humans.size(),100,100);
    text(Plants.size(),100,120);
    text(Animals.size(),100,140);
    textSize(12);
  };
  
  PVector futurep(){
    fp = PVector.add(p,vel.get().normalize().mult(vlimit));
    return fp;
  };

  PVector futurep(float czone){

    return p.add(vel.normalize().mult(czone/2));
  };

  PVector futurep(PVector a, PVector b, float c){

    return a.add(b.normalize().mult(c/2));
  };

  PVector futurep(Human h,float czone){

    return h.p.add(h.vel.normalize().mult(czone/2));
  };

  PVector futurep(Animal a,float czone){

    return a.p.add(vel.normalize().mult(czone/2));
  };

  PVector futurep(Boundary b,float czone){

    return p.add(vel.normalize().mult(czone/2));
  };

  PVector seek(PVector a){

    PVector d = PVector.sub(a,p);
    d.setMag(vlimit);

    PVector s = PVector.sub(d,vel);
    s.limit(alimit);
    return s;
  };

  void quadPos(){

    float sw = scene.fields.get(0).w;
    float sh = scene.fields.get(0).h;

    float X = scene.x;
    float Y = scene.y;

    x = p.x;
    y = p.y;
    int xpos = floor((x-X)/sw);
    int ypos = floor((y-Y)/sh);
    if(int(xpos + ypos * (scene.cols))<scene.fields.size())pos = int(xpos + ypos * (scene.cols));
    // fill(255);
    // text(pos,p.x,p.y);

    if(iid.size()==2&&iid.get(0)!=pos)update = true;
    else update = false;
    if(iid.size()<2)update = true;

    if(iid.size()==0)iid.add(pos);
    else if(iid.get(iid.size()-1)!=pos)iid.add(pos);

    if(iid.size()>2)iid.remove(0);
  };

 

  void separationLogic(){
    Entity e = entities.get(ent);

    int k = -1;
    color col = 255;
    float d1 = 0;
    for(int i=0;i< e.Humans.size();i++){

      float xx = W/2;
      float yy = H/2;
      float theta = radians(360/e.Humans.size());
      float r = 200;

      float x1 = xx + r * cos(theta*i);
      float y1 = yy + r * sin(theta*i);

      fill(e.Humans.get(i).get(0).col);
      float d = dist(mouseX,mouseY,x1,y1);
       d1 = dist(mouseX,mouseY,xx,yy);

      if(d<10){
        fill(255);
        k = i;
      }

      int count = 0;
      for(int j=0;j< e.Humans.size();j++){
        float cc = e.Humans.get(i).get(0).avoidNeighbour.get(j);
        if(cc>-1)count++;
      }

      text(i,x1,y1-20);
      text(eIndex1,x1+20,y1);
      text(eIndex2,x1+20,y1+10);
      text(count,x1-40,y1+10);
      ellipse(x1,y1,20,20);
      ellipse(xx,yy,30,30);
    }

      for(int i=0;i< e.Humans.size();i++){

      float xx = W/2;
      float yy = H/2;
      float theta = radians(360/e.Humans.size());
      float r = 200;

      float x1 = xx + r * cos(theta*i);
      float y1 = yy + r * sin(theta*i);


      for(int j=0;j<e.Humans.get(i).get(0).avoidNeighbour.size();j++){

        float p1 = e.Humans.get(i).get(0).avoidNeighbour.get(j);

        float x2 = xx + r * cos(theta*j);
        float y2 = yy + r * sin(theta*j);
        if(p1>0){
        stroke(0);
        ellipse(x2,y2,5,5);
        
        line(x1,y1,x2,y2);
      }}}

    if(k>-1){
      if(mousePressed&&mouseButton==RIGHT){
        for(int j=0;j< e.Humans.size();j++)e.Humans.get(k).get(0).avoidNeighbour.set(j,float(-1));
        eIndex1 = -1;
        eIndex2 = -1;
      }
    else if(mousePressed&&!e1down&&!e2down&&!mdown){
          eIndex1 = k;
          e1down = true;
          mdown = true;
          
        }else if(mousePressed&&!e2down&&!mdown&&e1down){
          eIndex2 = k;
          e2down = true;
          mdown = true;
          e.Humans.get(eIndex1).get(0).avoidNeighbour.set(eIndex2,random(r*2,50));
          }}else {
            if(mousePressed&&mouseButton==LEFT&&!mdown&&d1<15){
              mdown = true;
              for(int i=0;i< e.Humans.size();i++){
                for(int j=0;j< e.Humans.size();j++){

                if(j!=i)e.Humans.get(i).get(0).avoidNeighbour.set(j,random(r*2,50));

              }}}else if(mousePressed&&mouseButton==RIGHT&&!mdown&&d1<15){
                mdown = true;
                for(int i=0;i< e.Humans.size();i++){
                for(int j=0;j< e.Humans.size();j++){

                e.Humans.get(i).get(0).avoidNeighbour.set(j,float(-1));

              }}}}

        if(!mdown&&mousePressed){
            e1down = false;
            e2down = false;
            mdown = true;
          }
      if(!mousePressed)mdown = false;
      if(!mousePressed&&e2down&&e1down){
        e1down = false;
        e2down = false;
      }
  };

  void cohesionLogic(){
    Entity e = entities.get(ent);

    int k = -1;
    color col = 255;
    float d1 = 0;
    

    for(int i=0;i< e.Humans.size();i++){

      float xx = W/2;
      float yy = H/2;
      
      float theta = radians(360/e.Humans.size());
      float r = 200;

      float x1 = xx + r * cos(theta*i);
      float y1 = yy + r * sin(theta*i);

      fill(e.Humans.get(i).get(0).col);
      float d = dist(mouseX,mouseY,x1,y1);
       d1 = dist(mouseX,mouseY,xx,yy);

      if(d<10){
        fill(255);
        k = i;
      }
      int count = 0;
      for(int j=0;j< e.Humans.size();j++){
        float cc = e.Humans.get(i).get(0).seekNeighbour.get(j);
        if(cc>-1)count++;
      }

      text(cIndex1,x1+20,y1);
      text(cIndex2,x1+20,y1+10);
      text(count,x1-40,y1+10);
      ellipse(x1,y1,20,20);
      ellipse(xx,yy,30,30);
    }

      for(int i=0;i< e.Humans.size();i++){

      float xx = W/2;
      float yy = H/2;
      float theta = radians(360/e.Humans.size());
      float r = 200;

      float x1 = xx + r * cos(theta*i);
      float y1 = yy + r * sin(theta*i);


      for(int j=0;j<e.Humans.get(i).get(0).seekNeighbour.size();j++){

        float p1 = e.Humans.get(i).get(0).seekNeighbour.get(j);

        float x2 = xx + r * cos(theta*j);
        float y2 = yy + r * sin(theta*j);


        if(p1>0){
        stroke(0);
        ellipse(x2,y2,5,5);
        line(x1,y1,x2,y2);
      }}}

    if(k>-1){
      if(mousePressed&&mouseButton==RIGHT){
        for(int j=0;j< e.Humans.size();j++)e.Humans.get(k).get(0).seekNeighbour.set(j,float(-1));

        cIndex1 = -1;
        cIndex2 = -1;
      }
    else if(mousePressed&&!e1down&&!e2down&&!mdown){
          cIndex1 = k;
          e1down = true;
          mdown = true;
        }else if(mousePressed&&!e2down&&!mdown&&e1down){
          cIndex2 = k;
          e2down = true;
          mdown = true;
          e.Humans.get(cIndex1).get(0).seekNeighbour.set(cIndex2,random(5,40));
          if(cIndex1==cIndex2)e.Humans.get(cIndex1).get(0).seekNeighbour.set(cIndex2,random(r*2,50));
          }}else {
            if(mousePressed&&mouseButton==LEFT&&!mdown&&d1<15){
              mdown = true;
              for(int i=0;i< e.Humans.size();i++){
                for(int j=0;j< e.Humans.size();j++){

                if(j!=i)e.Humans.get(i).get(0).seekNeighbour.set(j,random(r*2,50));

              }}}else if(mousePressed&&mouseButton==RIGHT&&!mdown&&d1<15){
                mdown = true;
               for(int i=0;i< e.Humans.size();i++){
                for(int j=0;j< e.Humans.size();j++){

                e.Humans.get(i).get(0).seekNeighbour.set(j,float(-1));

              }}}}

        if(!mdown&&mousePressed){
            e1down = false;
            e2down = false;
            mdown = true;
          }
      if(!mousePressed)mdown = false;
      if(!mousePressed&&e2down&&e1down){
        e1down = false;
        e2down = false;
      }
  };

  void drawArrangement(ArrayList a){

  };

  void alignmentLogic(){
    Entity e = entities.get(ent);

    int k = -1;
    color col = 255;
    float d1 = 0;
    for(int i=0;i< e.Humans.size();i++){

      float xx = W/2;
      float yy = H/2;
      float theta = radians(360/e.Humans.size());
      float r = 200;

      float x1 = xx + r * cos(theta*i);
      float y1 = yy + r * sin(theta*i);

      fill(e.Humans.get(i).get(0).col);
      float d = dist(mouseX,mouseY,x1,y1);
       d1 = dist(mouseX,mouseY,xx,yy);

      if(d<10){
        fill(255);
        k = i;
      }

      int count = 0;
      for(int j=0;j< e.Humans.size();j++){
        float cc = e.Humans.get(i).get(0).alignNeighbour.get(j);
        if(cc>-1)count++;
      }

      text(i,x1,y1-20);
      text(aIndex1,x1+20,y1);
      text(aIndex2,x1+20,y1+10);
      text(count,x1-40,y1+10);
      ellipse(x1,y1,20,20);
      ellipse(xx,yy,30,30);

      for(int j=0;j<e.Humans.get(i).get(0).alignNeighbour.size();j++){
        
        float p1 = e.Humans.get(i).get(0).alignNeighbour.get(j);

        float x2 = xx + r * cos(theta*j);
        float y2 = yy + r * sin(theta*j);

        if(p1>0){
        stroke(0);
        ellipse(x2,y2,5,5);
        line(x1,y1,x2,y2);
      }}}

    if(k>-1){
      if(mousePressed&&mouseButton==RIGHT){
        for(int j=0;j< e.Humans.size();j++)e.Humans.get(k).get(0).alignNeighbour.set(j,float(-1));

        aIndex1 = -1;
        aIndex2 = -1;
      }
    else if(mousePressed&&!e1down&&!e2down&&!mdown){
          aIndex1 = k;
          e1down = true;
          mdown = true;
        }else if(mousePressed&&!e2down&&!mdown&&e1down){
          aIndex2 = k;
          e2down = true;
          mdown = true;
            e.Humans.get(aIndex1).get(0).alignNeighbour.set(aIndex2,random(r*2,50));
          }}else {
            if(mousePressed&&mouseButton==LEFT&&!mdown&&d1<15){
              mdown = true;
              for(int i=0;i< e.Humans.size();i++){
                for(int j=0;j< e.Humans.size();j++){

                if(j!=i)e.Humans.get(i).get(0).alignNeighbour.set(j,random(r*2,50));

              }}}else if(mousePressed&&mouseButton==RIGHT&&!mdown&&d1<15){
                mdown = true;
                for(int i=0;i< e.Humans.size();i++){
                for(int j=0;j< e.Humans.size();j++){

                e.Humans.get(i).get(0).alignNeighbour.set(j,float(-1));

              }}}}

        if(!mdown&&mousePressed){
            e1down = false;
            e2down = false;
            mdown = true;
          }
      if(!mousePressed)mdown = false;
      if(!mousePressed&&e2down&&e1down){
        e1down = false;
        e2down = false;
      }
  };

  void manageBoundaries(){

    for(int i=0;i<main.Boundaries.size();i++){
      Boundary b = main.Boundaries.get(i);

      //if(b.mtranslate()&&mousePressed&&)
    }

  };

  PVector seek2(PVector a){

    PVector desired = PVector.sub(a,p);  // A vector pointing from the position to the target

    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(vlimit);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired,vel);
    return steer.limit(alimit);  // Limit to maximum steering force

    //ac.add(steer);
  };

  void applyFriction(){
    //Friction = mu*mass*-1;
    friction = vel.get();
    friction.mult(-1); 
    friction.normalize();
    friction.mult(mu*alimit*50);
    PVector n = PVector.div(friction,mass);
    //friction.setMag(mu*mass*-1);
    ac.add(n);
    //vel.limit(vlimit);
    // friction.setMag(mu*mass*-1);
    // vel.x *= friction.x;
    // vel.y *= friction.y;
  };

  PVector separate(){

    float desiredseparation = breathingroom;
    PVector steer = new PVector(0,0);
    int count = 0;
    float t = 0;
    // For every Human in the system, check if it's too close
    Entity e = entities.get(ent);
    for (int j=0;j<proximity.size();j++) {

      Entity other = proximity.get(j);

      float d = PVector.dist(p,other.p);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)

      if (d<(radius+other.radius)/2) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(p,other.p);
        diff.normalize();
        diff.div(radius);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
        //t+= e.Humans.get(race).get(0).avoidNeighbour.get(other.race);
      }
      // if (race==other.race) {
      //   // Calculate vector pointing away from neighbor
      //   PVector diff = PVector.sub(p,other.p);
      //   diff.normalize();
      //   diff.div(radius);        // Weight by distance
      //   steer.add(diff);
      //   count++;            // Keep track of how many
      //   //t+= e.Humans.get(race).get(0).avoidNeighbour.get(other.race);
      // }
      
      }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(vlimit);
      steer.sub(vel);
      steer.limit(alimit);
    }
    return steer;
  };

PVector separate_(){

    PVector steer = new PVector(0,0);
    int count = 0;
    int count1 = 0;
    // For every Human in the system, check if it's too close
    for (int j=0;j<prox.size();j++) {

      Entity other = prox.get(j);

      float d = PVector.dist(p,other.p);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)

      if (d<(radius+other.radius)/2) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(p,other.p);
        diff.normalize();
        diff.div((radius+other.radius)/2);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many//

     if (count > 0) {
      steer.div((float)count);
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(100);
      steer.sub(vel);
      steer.limit(100);
      }
    return steer;
};

PVector separate2_(){

    PVector steer = new PVector(0,0);
    int count = 0;
    int count1 = 0;
    Entity e = entities.get(ent);
    // For every Human in the system, check if it's too close
    for (int j=0;j<prox.size();j++) {

      Entity other = prox.get(j);

      float d = PVector.dist(p,other.p);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)

      if (d<min&&e.Humans.get(race).get(0).avoidNeighbour.get(other.race)>0) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(p,other.p);
        diff.normalize();
        diff.div((radius+other.radius)/2);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }}
    if (count > 0) {
      steer.div((float)count);
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(vlimit);
      steer.sub(vel);
      steer.limit(alimit);
    }
    return steer;
};

  PVector separate2(ArrayList<Human> a){

    PVector steer = new PVector(0,0);
    int count = 0;
    // For every Human in the system, check if it's too close
    for (int j=0;j<a.size();j++) {

      Entity other = a.get(j);

      float d = PVector.dist(p,other.p);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      
     if (other.avoid2) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(p,other.p);
        diff.normalize();
        diff.div((radius+other.radius)/2);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }}
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(vlimit);
      steer.sub(vel);
      steer.limit(alimit);
    }
    return steer;
    
  };

  void repel(ArrayList<Human> a){

     separate2(a);
     cohesion2(a);

  };

  PVector separateBoundary(Window s){

    float desiredseparation = breathingroomb;

    PVector steer = new PVector(0,0);
     mult1 = 1;
    int count = 0;
    // For every Human in the system, check if it's too close

    for ( int i=0;i<s.Boundaries.size();i++) {
      
      Boundary C = s.Boundaries.get(i);

      if(C.state==1||C.state==3){
        
    
      for(int j=0;j<C.Boundaries.size();j++){

          Boundary B = C.Boundaries.get(j);

          if(B.state1==1||B.state1==3){

          PVector a = new PVector(B.x1,B.y1);
          PVector b = new PVector(B.x2,B.y2);

          PVector c = find_normal(fp,a,b);
          float d = PVector.dist(fp,c);

        // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
        if ((d > 10) && ((d < desiredseparation+B.broom))&&check_lineP(a,b,c)) {
          
          // Calculate vector pointing away from neighbor
           mult1 += B.avoidance;
          PVector diff = PVector.sub(p,c);
          diff.normalize();
          diff.div(d);        // Weight by distance
          steer.add(diff);
          count++;            // Keep track of how many
        }}}}}
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
      // Implement Reynolds: Steering = Desired - Velocity
      mult1 /=count;
      steer.normalize();
      steer.mult(vlimit);
      steer.sub(vel);
      steer.limit(alimit);
    }
    return steer;
  };

  PVector cohesionf() {

    float neighbordist = breathingroom;
    PVector sum = new PVector(0,0);   // Start with empty vector to accumulate all pitions
    int count = 0;

    Entity e = entities.get(ent);

    for (int j=0;j<proximity.size();j++) {

      Entity other = proximity.get(j);

      float d = PVector.dist(p,other.p);
      float d2 = radius + other.radius;

      if (d>breathingroom&&e.Humans.get(race).get(0).seekNeighbour.get(other.race)>0) {
        sum.add(other.p); // Add pition
        count++;
      }}
    if (count > 0) {
      sum.div((float)count);
      return seek(sum);  // Steer towards the pition
    }
    return sum;
  };

  PVector cohesionf_() {

    PVector sum = new PVector(0,0);   // Start with empty vector to accumulate all pitions
    int count = 0;

    for (int j=0;j<prox.size();j++) {

      Entity other = prox.get(j);

      float d = PVector.dist(p,other.p);

      if (d>(radius+other.radius)/2&&other.race==race) {
        sum.add(other.p); // Add pition
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      return seek(sum);  // Steer towards the pition
    }
    return sum;
  };

  PVector cohesion2(ArrayList<Human> a) {

    PVector sum = new PVector(0,0);   // Start with empty vector to accumulate all pitions
    int count = 0;

    for (int j=0;j<a.size();j++) {

      Entity other = a.get(j);

      float d = PVector.dist(p,other.p);

      if (other.seek) {
        sum.add(other.p); // Add pition
        count++;
      }}
    if (count > 0) {
      sum.div((float)count);
      return seek(sum);  // Steer towards the pition
    }
    return sum;
  };

PVector cohesionfBoundary(Window s) {

    float neighbordist = breathingroomb;
    PVector sum = new PVector(0,0);   // Start with empty vector to accumulate all pitions
     mult2 = 1;
    int count = 0;

    for ( int i=0;i<s.Boundaries.size();i++) {

      Boundary C = s.Boundaries.get(i);

      if(C.state==1||C.state==2){

      for(int j=0;j<C.Boundaries.size();j++){

          Boundary B = C.Boundaries.get(j);

          if(B.state1==1||B.state1==2){

          PVector a = new PVector(B.x1,B.y1);
          PVector b = new PVector(B.x2,B.y2);

          PVector c = find_normal(p,a,b);
          float d = PVector.dist(p,c);
      if ((d > radius) && (d < neighbordist+B.broom)&&check_lineP(a,b,c)){
              mult2 += B.cohesion;
              sum.add(c); // Add position
              count++;
      }}}}}
    if (count > 0) {
      mult2 /= count;
      sum.div((float)count);
      return seek(sum);  // Steer towards the position
    }
    return sum;

};

PVector align() {
    float neighbordist = breathingroom;
    PVector steer = new PVector();
    int count = 0;
    Entity e = entities.get(ent);
    for (int j=0;j<proximity.size();j++) {

      Entity other = proximity.get(j);

      if (e.Humans.get(race).get(0).alignNeighbour.contains(other.race)) {
        steer.add(other.vel);
        count++;
      }}
    if (count > 0) {
      steer.div((float)count);
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(vlimit);
      steer.sub(vel);
      steer.limit(alimit);
    }
    return steer;
  };

  PVector align2(ArrayList<Human> h) {
    
    PVector steer = new PVector();
    int count = 0;

    for (int j=0;j<h.size();j++) {

      Entity other = h.get(j);

      if (other.align) {
        steer.add(other.vel);
        count++;
      }}
    if (count > 0) {
      steer.div((float)count);
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(vlimit);
      steer.sub(vel);
      steer.limit(alimit);
    }
    return steer;
  };

  PVector align_() {
    float neighbordist = breathingroom;
    PVector steer = new PVector();
    int count = 0;
    Entity e = entities.get(ent);
    for (int j=0;j<family.size();j++) {

      Entity other = family.get(j);
      float d = dist(x,y,other.x,other.y);

      if (other.race==race) {
        steer.add(other.vel);
        count++;
      }}
    if (count > 0) {
      steer.div((float)count);
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(50);
      steer.sub(vel);
      steer.limit(50);
    }
    return steer;
  };


  void flockBoundary(){
    PVector sepB = separateBoundary(main);   // Separation
    PVector cohB = cohesionfBoundary(main);
    PVector wan = wander(); //wander

    cohB.mult(cohesionb*50);
    sepB.mult(separationb*50);
    wan.mult(wanderm);


    ac.add(sepB);
    ac.add(cohB);
    ac.add(wan);
    //update();
  };
  
  void flockNeer(){

    PVector sep = new PVector();   // Separation
    //PVector sep2 = new PVector();
    PVector coh = new PVector();   // Cohesion
    //PVector ali = new PVector();   // Alignment

    if(prox.size()>0){
      sep = separate_();
      //sep2 = separate2_();
       coh = cohesionf_();
      // ali = align_();

      coh.mult(cohesionc);
      sep.mult(separationc*(vlimit/50)*50);
      //sep2.mult(separation);
      //ali.mult(alignmentc);
      coh.limit(vlimit);
      sep.limit(vlimit);
      //applyFriction();
      ac.add(sep);
       ac.add(coh);
      // //ac.add(sep2);
      // ac.add(ali);
    }
    //ac.add(ali);
  };

  void flock(){

    Quad field = null;
    futurep();
    if(pos>0&&pos<scene.cols*scene.rows)field = scene.fields.get(pos);
    if(proximity.size()>0)flockSep();
    if(prox2.size()>0)flockSP();
    
    if(prox.size()>0)flockNeer();
    flockBoundary();
  };

  void oscilator(){

    if(id==0){
      //noStroke();
      noFill();

      
    
    for(int i=0;i<oscilatorLabels.length;i++){

      String a = oscilatorLabels[i];
      
      float c = oscilatorCounters.get(i) + 0.01;

      oscilatorCounters.set(i ,c);

      float b = oscilators.get(i) + 2*sin(c);
      oscilators.set(i,b);
      
      
      Field field = null;

      try{
         field = this.getClass().getField(a); 
           field.set(this, field.getFloat(this) + 5*sin(c)); 
    }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }catch (IllegalAccessException e) {
    }}
      //ellipse(p.x,p.y,50,50);
      
    }
  };

  void flockSep() {
    
    Quad field = null;

    PVector sep = new PVector();

    sep = separate();   // Separation
    sep.mult(separationd);
    //sep.limit(vlimit)
    sep.limit(vlimit);
    //  ali.mult(alignment*(field.dens+1));
    //  coh.mult(cohesion*(field.dens+1));
    applyFriction();
    ac.add(sep);
  };


  void flockSP(){

    PVector sep = new PVector();
    PVector sep2 = new PVector();
    PVector coh = new PVector();
    PVector ali = new PVector();

    Entity e = entities.get(ent);
    
    if(prox2.size()>0){
    for(int i=0;i<prox2.size();i++){

      ArrayList< Human> h = prox2.get(i);
      ArrayList< Human> h1 = proximity2.get(i);
      

      if(h.size()>0){
        float avoid_ = e.Humans.get(race).get(0).avoidNeighbour.get(i);
        float seek_ = e.Humans.get(race).get(0).seekNeighbour.get(i);
        float align_ = e.Humans.get(race).get(0).alignNeighbour.get(i);

        // if(id==0)text(race + " Scount " + scount + " " + seek_,100,300+40*race+10*i);
        // if(id==0)text(race +" Acount " + acount + " " + avoid_,250,300+40*race+10*i);
        // if(id==0)text(race + " Alcount " + alcount + " " + align_,400,300+40*race+10*i);

        if(scount>0&&seek_>-1)
        coh.add(cohesion2(h).mult(seek_+cohesion));
        if(acount>0&&avoid_>-1)
        sep.add(separate2(h).mult(avoid_+separation));
        if(alcount>0&&align_>-1)
        ali.add(align2(h).mult(align_+alignment));
        if(mcount>0&&avoid_>-1)
        sep2.add(separate2(h).mult((avoid_+separationd)*50));
        //update2();
    }}}
    coh.limit(vlimit);
    sep.limit(vlimit);
    ali.limit(vlimit);
    sep2.limit(vlimit);
    applyFriction();
    ac.add(coh);
    ac.add(sep);
    ac.add(sep2);
    ac.add(ali);
    //update();

  };

  void flockFamily(){

    if(family.size()>0){
    
      PVector sep2 = new PVector();   // Separation
      PVector coh2 = new PVector();      // Alignment
      
        sep2 = separate2(family);
        coh2 = cohesion2(family);
        //PVector ali = align_();

        coh2.mult(cohesionc);
        sep2.mult(separationc);
        //ali.mult(1);

        ac.add(sep2);
        ac.add(coh2);
    }
    //update2();
    
  };


  PVector wander() {

    float wanderR = 25;         // Radius for our "wander circle"
    float wanderD = 80;         // Distance for our "wander circle"
    float change = 0.3;
    wandertheta += random(-wanderm,wanderm);     // Randomly change wander theta

    // Now we have to calculate the new position to steer towards on the wander circle
    PVector circlepos = vel.get();    // Start with velocity
    circlepos.normalize();            // Normalize to get heading
    circlepos.mult(wanderD);          // Multiply by distance
    circlepos.add(p);               // Make it relative to boid's position

    float h = vel.heading2D();        // We need to know the heading to offset wandertheta

    PVector circleOffSet = new PVector(wanderR*cos(wandertheta+h),wanderR*sin(wandertheta+h));
    PVector t = PVector.add(circlepos,circleOffSet);
    //if(debug) drawWanderStuff(p,circlepos,t,wanderR);
    return seek2(t);

    // Render wandering circle, etc.

  };

  void drawWanderStuff(PVector position, PVector circle, PVector target, float rad) {
  stroke(0);
  noFill();
  ellipseMode(CENTER);
  ellipse(circle.x,circle.y,rad*2,rad*2);
  ellipse(target.x,target.y,4,4);
  line(p.x,p.y,circle.x,circle.y);
  line(circle.x,circle.y,target.x,target.y);
};

void collisions(ArrayList<Human> a){

  for(int i=0;i<a.size();i++){

    Entity h =  a.get(i);

    checkCollision(h);
  }

};

void checkCollision(Entity other) {
    
    // Get distances between the balls components
    PVector distanceVect = PVector.sub(other.p, p);

    // Calculate magnitude of the vector separating the balls
    float distanceVectMag = distanceVect.mag();

    // Minimum distance before they are touching
    float minDistance = radius + other.radius;

    if (distanceVectMag < minDistance) {
      float distanceCorrection = (minDistance-distanceVectMag)/2.0;
      PVector d = distanceVect.copy();
      PVector correctionVector = d.normalize().mult(distanceCorrection);
      PVector o = other.p.copy();
      o.add(correctionVector);
      o.sub(correctionVector);

      // get angle of distanceVect
      float theta  = distanceVect.heading();
      // precalculate trig values
      float sine = sin(theta);
      float cosine = cos(theta);

      /* bTemp will hold rotated ball positions. You 
       just need to worry about bTemp[1] position*/
      PVector[] bTemp = {
        new PVector(), new PVector()
      };

      /* this ball's position is relative to the other
       so you can use the vector between them (bVect) as the 
       reference point in the rotation expressions.
       bTemp[0].position.x and bTemp[0].position.y will initialize
       automatically to 0.0, which is what you want
       since b[1] will rotate around b[0] */
      bTemp[1].x  = cosine * distanceVect.x + sine * distanceVect.y;
      bTemp[1].y  = cosine * distanceVect.y - sine * distanceVect.x;

      // rotate Temporary velocities
      PVector[] vTemp = {
        new PVector(), new PVector()
      };

      vTemp[0].x  = cosine * vel.x + sine * vel.y;
      vTemp[0].y  = cosine * vel.y - sine * vel.x;
      vTemp[1].x  = cosine * other.vel.x + sine * other.vel.y;
      vTemp[1].y  = cosine * other.vel.y - sine * other.vel.x;

      /* Now that velocities are rotated, you can use 1D
       conservation of momentum equations to calculate 
       the final velocity along the x-axis. */
      PVector[] vFinal = {  
        new PVector(), new PVector()
      };

      // final rotated velocity for b[0]
      vFinal[0].x = ((mass - other.mass) * vTemp[0].x + 2 * other.mass * vTemp[1].x) / (mass + other.mass);
      vFinal[0].y = vTemp[0].y;

      // final rotated velocity for b[1]
      vFinal[1].x = ((other.mass - mass) * vTemp[1].x + 2 * mass * vTemp[0].x) / (mass + other.mass);
      vFinal[1].y = vTemp[1].y;

      // hack to avoid clumping
      bTemp[0].x += vFinal[0].x;
      bTemp[1].x += vFinal[1].x;

      /* Rotate ball positions and velocities back
       Reverse signs in trig expressions to rotate 
       in the opposite direction */
      // rotate balls
      PVector[] bFinal = { 
        new PVector(), new PVector()
      };

      bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
      bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
      bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
      bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;

      // update balls to screen position
      other.p.x = p.x + bFinal[1].x;
      other.p.y = p.y + bFinal[1].y;

      p.add(bFinal[0]);

      // update velocities
      vel.x = cosine * vFinal[0].x - sine * vFinal[0].y;
      vel.y = cosine * vFinal[0].y + sine * vFinal[0].x;
      other.vel.x = cosine * vFinal[1].x - sine * vFinal[1].y;
      other.vel.y = cosine * vFinal[1].y + sine * vFinal[1].x;
    }
  };

  void assignVectors(){

    futurep();
    p = new PVector(x,y);
    vel = new PVector(vx,vy);

  };

  void steer_awayIntersection(ArrayList<Human> H,float czone){

    ArrayList<PVector> temp = new ArrayList<PVector>();

    for(int i=0;i<H.size();i++){

      Human h = H.get(i);

      Boundary b1 = new Boundary(x,y,fp.x,fp.y);
      Boundary b2 = new Boundary(h.x,h.y,h.fp.x,h.fp.y);

      PVector i1 = check_intersect(b1,b2);

      if(i1!=null){

        for(int j=0;j<avoid_angles.length;j++){

          float t1 = avoid_angles[j];
          float t2 = atan2(i1.y-y,i1.x-x);

          PVector next = new PVector(x + czone/2 * cos(t1+t2),y + czone/2 * sin(t1+t2));

          PVector ap = futurep(h,czone/2);

          Boundary b3 = new Boundary(x,y,next.x,next.y);
          Boundary b4 = new Boundary(h.x,h.y,ap.x,ap.y);

          PVector i2 = check_intersect(b3,b4);

          if(i2==null){
            temp.add(next);
          }
            if(temp.size()>0){
            //if (target ==null&&targetb==null&&!familyties)      seekddw(greatestTo(temp,center));
            //else if (target ==null&&targetb==null&&familyties)  seekddw(greatestTo(temp,center));
            //else if (target !=null&&targetb==null&&!familyties) seekddw(greatestTo(temp,target));
            //else if (target ==null&&targetb!=null&&!familyties) seekddw(greatestTo(temp,targetb));
        }}}}
  };

  boolean check_lineP(PVector a, PVector b,PVector c){

    boolean k = false;
    float d1 = dist(a.x,a.y,b.x,b.y);
    float d2 = dist(a.x,a.y,c.x,c.y);
    float d3 = dist(b.x,b.y,c.x,c.y);
    float d4 = d2 + d3;

    if(d4 <= d1 + 0.05 && d4 >= d1 - 0.05)k = true;
    
    return k;
  };

  void steer_awayIntersection(ArrayList<Boundary> H){

    ArrayList<PVector> temp = new ArrayList<PVector>();

    for(int i=0;i<H.size();i++){

      Boundary C = H.get(i);

      for(int j=0;j<C.Boundaries.size();j++){

      Boundary h = C.Boundaries.get(j);

      Boundary b1 = new Boundary(x,y,fp.x,fp.y);
      Boundary b2 = new Boundary(h.x1,h.y1,h.x2,h.y2);

      PVector i1 = check_intersect2(b1,b2);


      if(i1!=null&&!stop&&dist(i1.x,i1.y,x,y)<breathingroom/2){

        fill(col);
        ellipse(i1.x,i1.y,10,10);
        stop = true;
        for(int k=0;k<avoid_angles2.length;k++){

          float t1 = avoid_angles[k];
          float t2 = atan2(i1.y-y,i1.x-x);

          PVector next = new PVector(x + breathingroom/2 * cos(t1+dir),y + breathingroom/2 * sin(t1+dir));

          Boundary b3 = new Boundary(x,y,next.x,next.y);

          PVector i2 = check_intersect2(b3,b2);

          if(i2==null){
            temp.add(next);
          }
            if(temp.size()>0){
            //if (target ==null&&targetb==null&&!familyties)      seekddw(shortestTo(temp,fp));
            //else if (target ==null&&targetb==null&&familyties)  seekddw(shortestTo(temp,center));
            //else if (target !=null&&targetb==null&&!familyties) seekddw(shortestTo(temp,target));
            //else if (target ==null&&targetb!=null&&!familyties) seekddw(shortestTo(temp,targetb));
        }}}}}
  };

  void steer_awayZone(ArrayList<Human> H,float czone){

    ArrayList<PVector> temp = new ArrayList<PVector>();

    for(int i=0;i<H.size();i++){

      Human h = H.get(i);

      float d1 = dist(x,y,h.x,h.y);

      if(d1<czone/2+h.breathingroom/2){

        float t1 = atan2(h.y-y,h.x-x);

        for(int j=0;j<avoid_angles.length;j++){

          float t2 = avoid_angles[j];

          PVector next = new PVector(x + czone/2 * cos(t2+t1),y + czone/2 * sin(t2+t1));

          float d2 = dist(next.x,next.y,h.x,h.y);

          if(d2>czone/2+h.breathingroom/2){
            temp.add(next);
          }
          if(temp.size()>0){
            //if (target ==null&&targetb==null&&!familyties)      seekddw(greatestTo(temp,center));
            //else if (target ==null&&targetb==null&&familyties)  seekddw(greatestTo(temp,center));
            //else if (target !=null&&targetb==null&&!familyties) seekddw(greatestTo(temp,target));
            //else if (target ==null&&targetb!=null&&!familyties) seekddw(greatestTo(temp,targetb));
        }}}}
  };

  PVector greatestTo(ArrayList<PVector> d,PVector h){

    PVector k = d.get(0);

    for(int i=0;i<d.size();i++){

      PVector a = d.get(i);

      float d1 = dist(a.x,a.y,h.x,h.y);
      float d2 = dist(k.x,k.y,h.x,h.y);

      if(d1>d2) k = a;
    }

    return k;
  };

  PVector shortestTo(ArrayList<PVector> d,PVector h){

    PVector k = d.get(0);

    for(int i=0;i<d.size();i++){

      PVector a = d.get(i);

      float d1 = dist(a.x,a.y,h.x,h.y);
      float d2 = dist(k.x,k.y,h.x,h.y);

      if(d1<d2) k = a;
    }

    return k;
  };

  void seek_boundary(Scene s){

    for(int i=0;i<s.Boundaries.size();i++){

      Boundary C = s.Boundaries.get(i);

      for(int j=0;j<C.Boundaries.size();j++){

        Boundary B = C.Boundaries.get(j);

        PVector a = new PVector(B.x1,B.y1);
        PVector b = new PVector(B.x2,B.y2);

        PVector v = PVector.sub(p,a);
        PVector v2 = PVector.sub(b,a);

        v2.normalize();
        v2.mult(v.dot(v2));
        v2 = v2.add(a);

        //line(x,y,v2.x,v2.y);
        //if(dist(x,y,v2.x,v2.y)>=breathingroom) seekddw(v2);
    }}
  };

  void seek_boundary(ArrayList<Boundary> s){

    for(int i=0;i<s.size();i++){


      Boundary C = s.get(i);

      for(int j=0;j<C.Boundaries.size();j++){

        Boundary B = C.Boundaries.get(j);

        PVector a = new PVector(B.x1,B.y1);
        PVector b = new PVector(B.x2,B.y2);

        PVector v = PVector.sub(p,a);
        PVector v2 = PVector.sub(b,a);

        v2.normalize();
        v2.mult(v.dot(v2));
        v2 = v2.add(a);

        //line(x,y,v2.x,v2.y);
        //if(dist(x,y,v2.x,v2.y)>=breathingroom) seekddw(v2);
    }}
  };

  void avoid_boundary(Scene s){

        Boundary A = shortestToCenter(s.Boundaries);
        Boundary B = shortestToCenter(A.Boundaries);

        PVector a = new PVector(B.x1,B.y1);
        PVector b = new PVector(B.x2,B.y2);

        PVector v = PVector.sub(p,a);
        PVector v2 = PVector.sub(b,a);

        PVector v3 = PVector.sub(fp,a);
        PVector v4 = PVector.sub(b,a);

        v2.normalize();
        v2.mult(v.dot(v2));
        v2 = v2.add(a);

        v4.normalize();
        v4.mult(v3.dot(v4));
        v4 = v4.add(a);

        float d1 = dist(fp.x,fp.y,v4.x,v4.y);
        float d2 = dist(x,y,B.x1,B.y1);
        float d3 = dist(x,y,B.x2,B.y2);

        stroke(col);
        line(x,y,v2.x,v2.y);
        ellipse(v2.x,v2.y,10,10);

        //if(d1<=breathingroom)avoiddw(v4);
        //else if(d2<=breathingroom)avoiddw(new PVector(B.x1,B.y1));
        //else if(d3<=breathingroom)avoiddw(new PVector(B.x2,B.y2));


  };

  void avoid_boundary2(Scene s){

    for(int i=0;i<s.Boundaries.size();i++){

      Boundary C = s.Boundaries.get(i);

      for(int j=0;j<C.Boundaries.size();j++){

        Boundary B = C.Boundaries.get(j);

        PVector a = new PVector(B.x1,B.y1);
        PVector b = new PVector(B.x2,B.y2);

        PVector v = PVector.sub(p,a);
        PVector v2 = PVector.sub(b,a);

        v2.normalize();
        v2.mult(v.dot(v2));
        v2 = v2.add(a);

        PVector v3 = PVector.sub(fp,a);
        PVector v4 = PVector.sub(b,a);

        v4.normalize();
        v4.mult(v3.dot(v4));
        v4 = v4.add(a);

        float d0 = dist(x,y,v2.x,v2.y);
        float d1 = dist(fp.x,fp.y,v4.x,v4.y);
        float d2 = dist(x,y,B.x1,B.y1);
        float d3 = dist(x,y,B.x2,B.y2);

        //stroke(col);
        //line(x,y,v2.x,v2.y);
        //ellipse(v2.x,v2.y,10,10);

        //if(d1<=breathingroom/2)avoiddw(v4);
        //else if(d0<=breathingroom/2)avoiddw(v2);
        //else if(d2<=breathingroom/2)avoiddw(new PVector(B.x1,B.y1));
        //else if(d3<=breathingroom/2)avoiddw(new PVector(B.x2,B.y2));
    }}

  };

  void avoid_boundary(ArrayList<Boundary> s){

    for(int i=0;i<s.size();i++){

      Boundary C = s.get(i);

      for(int j=0;j<C.Boundaries.size();j++){

        Boundary B = C.Boundaries.get(j);

        PVector a = new PVector(B.x1,B.y1);
        PVector b = new PVector(B.x2,B.y2);

        PVector v = PVector.sub(p,a);
        PVector v2 = PVector.sub(b,a);

        v2.normalize();
        v2.mult(v.dot(v2));
        v2 = v2.add(a);

        //line(x,y,v2.x,v2.y);
        //if(dist(x,y,v2.x,v2.y)<=30) avoid(v2);
    }}
  };

  void follow_boundary(ArrayList<Boundary> s, float radius){

    if(s.size()>0){

       Boundary B = shortestTo(s);

       Boundary b1 = shortestTo(B.Boundaries);

       PVector a = new PVector(b1.x1,b1.y1);
       PVector b = new PVector(b1.x2,b1.y2);

       PVector n = find_normal(p,a,b);

       float d1 = dist(x,y,n.x,n.y);
       float d2 = dist(x,y,a.x,a.y);
       //float d2 = dist(x,y,a.x,a.y);

       if(d1>radius){
         targetb = n;
       }else {
         targetb = b;
       }

       //seekddw(targetb);
     }
  };

  void follow_boundary(Scene s,float radius){

     Boundary B = shortestTo(s.Boundaries.get(0).Boundaries);

     PVector a = new PVector(B.x1,B.y1);
     PVector b = new PVector(B.x2,B.y2);

     PVector n = find_normal(p,a,b);

     float d1 = dist(x,y,n.x,n.y);
     float d2 = dist(x,y,a.x,a.y);

     if(d1>radius){
       targetb = n;
     }else {
       targetb = b;
     }

     //seekddw(targetb);
  };

  Boundary shortestTo(ArrayList<Boundary> B){

     Boundary k = null;

    if(B.size()>0){

      k = B.get(0);;

    for(int i=1;i<B.size();i++){

      Boundary A = B.get(i);
      PVector a = new PVector(A.x1,A.y1);

      float d1 = dist(a.x,a.y,x,y);
      float d2 = dist(k.x1,k.y1,x,y);

      if(d1<d2) k = A;
    }}

    return k;

  };

  Boundary shortestToCenter(ArrayList<Boundary> B){

     Boundary k = null;

    if(B.size()>0){

      k = B.get(0);;

    for(int i=1;i<B.size();i++){

      Boundary A = B.get(i);
      PVector a = new PVector(A.center.x,A.center.y);

      float d1 = dist(a.x,a.y,x,y);
      float d2 = dist(k.center.x,k.center.y,x,y);

      if(d1<d2) k = A;
    }}

    return k;

  };

  PVector  find_normal(PVector p, PVector a, PVector b){

        PVector v = PVector.sub(p,a);
        PVector v2 = PVector.sub(b,a);

        v2.normalize();
        v2.mult(v.dot(v2));
        v2 = v2.add(a);

        return v2;
  };

  PVector[] sum(ArrayList<Human>a){

    PVector v = new PVector(0,0);
    PVector p = new PVector(0,0);

    for(int i=0;i<a.size();i++){

      Human e = a.get(i);

        p.add(e.p);
        v.add(e.vel);
    }
    p.div(family.size());
    v.div(family.size());

    PVector []sum = {p,v};

   return sum;

  };

  void eyes(){

    fill(col3,20);
    noStroke();
    arc(p.x + 10 * cos(dir),p.y + 10 * sin(dir),200,200,dir - radians(fov),dir + radians(fov));
    //line(x + 10 * cos(dir),y + 10 * sin(dir),x + 110 * cos(dir-radians(fov)),y + 110 * sin(dir-radians(fov)));
    //line(x + 10 * cos(dir),y + 10 * sin(dir),x + 110 * cos(dir+radians(fov)),y + 110 * sin(dir+radians(fov)));

  };

  void eye(ArrayList<Human> a){

     float d = 0;
     vcount = 0;

    for(int i=0;i<a.size();i++){

      Human e = a.get(i);
      float d1 = dist(p.x,p.y,e.x,e.y);
      if(e!=this&&d1<breathingroom){
        d = atan2(p.y - e.y,p.x - e.x) + PI;
        if(d>=abs(dir)-radians(fov)&&d<=abs(dir)+radians(fov))vcount++;

    }}
    if(vcount>0){
      highlight = true;
      col3 = hcol;
    }
    else {
      highlight = false;
      col3 = colb;
  }
  };

  void eyes(PVector m){

    float d1 = dist(x,y,m.x,m.y);
    float t1 = atan2(p.y - m.y, p.x - m.x) + PI;
    //float t2 = atan2(m.y - p.y, m.x - p.x) + PI;

    if(d1<200&&t1>dir-radians(fov) && t1 < dir + radians(fov)){highlight = true;}
    else {highlight = false;}
  };

  void highlight(){
    if(highlight) col3 = hcol;
    else col3 = colb;
  };

  void rotate(){
    dir+=0.1;
  };

  void wander(float a){

    float t2 = 0;
    assignVectors();

    if(!turn&&!turnh){
      dir += radians(random(-10,10));
      fp = futurep();
      tri_boundaryf.tri.center = fp;
      tri_boundaryf.tri.rotate2(dir);
      PVector desired = new PVector(p.x + vel.x * cos(dir), p.y + vel.y * sin(dir));
      seek(desired);
      //fill(col);
      //ellipse(fp.x,fp.y,10,10);
    }
    if(!turn&&!turnh){
    if(!check_inter(lines.scene.Boundaries,fp)){
      if(proximity.size()==0||!check_interh(proximity,fp)){


    }else{ turnh = true;bdir = dir;}}else{ turn = true;bdir = dir;}}
    if(turn||turnh){
      inc ++;
      neg = pow(-1,inc);

      dir = bdir + (radians(10+inc)*neg)+ (radians((id+1)+inc)*neg);
      fp = futurep();
      tri_boundaryf.tri.center = fp;
      tri_boundaryf.tri.rotate2(dir);

      PVector desired = new PVector(p.x + vel.x * cos(dir), p.y + vel.y * sin(dir));

    if(!check_inter(lines.scene.Boundaries,fp2)){
      if(!check_interh(proximity,fp2)){

      seek(desired);
      turn = false;
      turnh = false;
    }}else{
    }}
  };

  Boolean check_inter(ArrayList<Boundary> B,PVector a){

    boolean k = false;

    for(int i=0;i<B.size();i++){

      Boundary C = B.get(i);

      for(int j=0;j<C.Boundaries.size();j++){

      Boundary h = C.Boundaries.get(j);

      Boundary b1 = new Boundary(p.x,p.y,a.x,a.y);
      Boundary b2 = new Boundary(h.x1,h.y1,h.x2,h.y2);

      PVector i1 = check_intersect2(b1,b2);

      if(a.x==h.x1||a.x==h.x2){
        current_boundary = h;
        k = true;
        turn = true;
        return true;
        }

      else if(i1!=null&&dist(i1.x,i1.y,p.x,p.y)<dist(a.x,a.y,p.x,p.y)){
        current_boundary = h;
        k = true;
        turn = true;

        return true;
      }}}

      return k;

  };

  Boolean check_inter(Boundary B,PVector a){

    boolean k = false;

      Boundary h = B;

      Boundary b1 = new Boundary(p.x,p.y,a.x,a.y);
      Boundary b2 = new Boundary(h.x1,h.y1,h.x2,h.y2);

      PVector i1 = check_intersect(b1,b2);

      if(a.x==h.x1||a.x==h.x2||a.y == h.y1||a.y == h.y2||i1!=null){

        k = true;
        return true;
      }
      return k;

  };

  Boolean check_interh(ArrayList<Human> B,PVector a){

    boolean k = false;

    for(int i=0;i<B.size();i++){

      Human h = B.get(i);
      float d1 = dist(p.x,p.y,a.x,a.y);
      float d2 = dist(h.p.x,h.p.y,a.x,a.y);
      float d3 = dist(h.p.x,h.p.y,p.x,p.y);
      if(h!=this){
      //fp = new PVector(x+vlimit*cos(dir),x+vlimit*sin(dir));
      Boundary b1 = new Boundary(p.x,p.y,a.x,a.y);
      Boundary b2 = new Boundary(h.p.x,h.p.y,h.p.x + h.vlimit * cos(h.dir),h.p.y + h.vlimit*sin(h.dir));

      PVector i1 = check_intersect2(b1,b2);

       if(i1!=null&&dist(i1.x,i1.y,x,y)<20){
        stroke(col);
        fill(col);
        line(p.x,p.y,i1.x,i1.y);
        ellipse(i1.x,i1.y,10,10);
        k = true;
        turnh = true;
      }else
      if(tri_boundaryf.pos(new PVector(h.fp.x + 10 * cos(h.dir),h.fp.y + 10 * sin(h.dir)))||
          tri_boundaryf.pos(new PVector(h.fp.x + 10 * cos(dir+radians(120)),h.fp.y + 10 * sin(dir+radians(120))))||
          tri_boundaryf.pos(new PVector(h.fp.x + 10 * cos(dir-radians(120)),h.fp.y + 10 * sin(dir-radians(120))))||
          h.tri_boundaryf.pos(new PVector(fp.x + 10 * cos(dir),fp.y + 10 * sin(dir)))||
          h.tri_boundaryf.pos(new PVector(fp.x + 10 * cos(dir+radians(120)),fp.y + 10 * sin(dir+radians(120))))||
          h.tri_boundaryf.pos(new PVector(fp.x + 10 * cos(dir-radians(120)),fp.y + 10 * sin(dir-radians(120))))){
        stroke(col);
        noFill();
        line(p.x,y,p.x+vlimit*cos(dir),p.y+vlimit*sin(dir));
        ellipse(p.x+vlimit*cos(dir),p.y+vlimit*sin(dir),10,10);
        turnh = true;
        k = true;
        }}}

      return false;

  };

  Boolean check_interh(Human B,PVector a){

    boolean k = false;
      Human h = B;

      Boundary b1 = new Boundary(p.x,p.y,a.x,a.y);
      Boundary b2 = new Boundary(h.p.x,h.p.y,h.fp.x,h.fp.y);

      PVector i1 = check_intersect2(b1,b2);
      if(a.x==h.x||a.x==h.x){
        //turn = true;
        //k = true;
        //return true;
        }

      else if(i1!=null&&dist(i1.x,i1.y,p.x,p.y)<dist(x,y,fp.x,fp.y)){
        fill(col);
        stroke(col);
        line(p.x,p.y,i1.x,i1.y);
        ellipse(i1.x,i1.y,10,10);
        k = true;
        turn = true;

      }else obstructionh = null;

      return k;

  };


  void draw_future(){
    stroke(col);
    fill(col);

    if(fp.x!=0&&fp.y!=0)line(x,y,fp.x,fp.y);
    ellipse(fp.x,fp.y,10,10);

  };

  void arrive(PVector a){

    x = lerp(p.x,a.x,0.5);
    y = lerp(p.y,a.y,0.5);
    dir = atan2(a.y-p.y,a.x-p.x);
  };

  PVector [] sumf(ArrayList<Human> a){

    float sumx = 0;
    float sumy = 0;
    float sumd = 0;
    int total = 0;

    PVector c = new PVector(0,0);
    PVector c2 = new PVector(0,0);

    for(int i=0;i<a.size();i++){

      Human e = a.get(i);
        e.p.x = e.x;
        e.p.y = e.y;

        c.add(e.p);
        c2.add(e.vel);
    }

    c.div(a.size());
    c2.div(a.size());

    centerf = new PVector(c.x,c.y);
    centervelf = new PVector(c2.x,c2.y);

    velf = centervel;
    PVector c3 = new PVector(dir,dir);
    PVector [] temp = {c,c2,c3};

    return temp;

  };

  PVector [] sumv(ArrayList<Human> a){

    PVector c = new PVector(0,0);
    PVector c2 = new PVector(0,0);

    for(int i=0;i<a.size();i++){

      Human e = a.get(i);

        e.p.x = e.x;
        e.p.y = e.y;
        c.add(e.p);
        c2.add(e.vel);
    }

    c.div((a.size()-1));
    c2.div((a.size()-1));

    center = c;
    centervel = c2;


      float dx = abs(x - center.x);
      float dy = abs(y - center.y);

      vel = new PVector(vx,vy);

    PVector c3 = new PVector(dir,dir);
    PVector [] temp = {c,c2,c3};

    return temp;

  };

  void logic(){

    if(dir>=2*PI) dir = dir%(2*PI);
    if(dir<=-2*PI) dir = dir%(-2*PI);
  };

  void draw_broom(){
    stroke(col);
    noFill();
    ellipse(p.x,p.y,breathingroom,breathingroom);
  };

  void fties(){
    stroke(col);
    if(centerf.x!=0&&centerf.y!=0)line(p.x,p.y,centerf.x,centerf.y);
    fill(col);
    ellipse(centerf.x,centerf.y,20,20);

  };

  float limit(float a, float l){
    if(a>=l) a = l;
    if(a<=-l)a = -l;

    return a;
  };

  void update_boundary(){
    if(tri_boundary!=null){
      tri_boundary.tri.update_points(tri_boundary.tri.Boundaries);
    }
  };


  void showtargeta(){
    if(target!=null){
      text("T",x+25,y);
      Plant P = targetfruit;
      stroke(col);
      line(P.x,P.y,p.x,p.y);
    }
  };
  void showtargetb(){
    if(targetb!=null){
      PVector P = targetb;
      stroke(col);
      line(p.x,p.y,P.x,P.y);
    }
  };

  void wrap2(){

    if(p.x>scene.x+scene.w) p.x=scene.x+1;
    if(p.x<scene.x) p.x = scene.x+scene.w-1;
    if(p.y>scene.y+scene.h) p.y = scene.y+1;
    if(p.y<+scene.y) p.y = scene.y+scene.h-1;
  };

  void wrap(){
    if(p.x >= W) p.x = 1;
    if(p.x <= 0) p.x = W - 1;
    if(p.y >= H) p.y = 1;
    if(p.y <= 0) p.y = H - 1;
  };

  void boundary_functions(){

      tri_boundary.draw();
      //tri_boundaryf.draw();

      tri_boundary.tri.center = p;

      tri_boundary.tri.rotate2(dir);

      tri_boundaryf.tri.center = fp;

      tri_boundaryf.tri.rotate2(dir);

      tri_boundary.bg = col;
      tri_boundaryf.bg = col;

  };

  void fboundary_functions(){

      tri_boundaryf.tri.center.x = fp.x;
      tri_boundaryf.tri.center.y = fp.y;
      tri_boundaryf.tri.rotate2(dir);
      tri_boundaryf.bg = col;
  };


  void p_update(){

  };

  void update() {
    // Update velocity
    vel.add(ac);
    
    // Limit speed
    
    vel.limit(vlimit);
    dir = atan2(vel.y,vel.x) - PI;
    p.add(vel);
    // Reset accelertion to 0 each cycle

    ac.mult(0);
  }
  void update2() {
    // Update velocity
    vel.add(ac);
    // Limit speed
    vel.limit(vlimit);
    dir = atan2(vel.y,vel.x) - PI;
    p.add(vel);
    // Reset accelertion to 0 each cycle

  }

  void runh(){

    a1 += 0.2;
    a2 += 0.5;
    a3 += 0.9;
    a4 += 1.2;
    a5 += 1.5;

    if(a1>=5)a1=0;
    if(a2>=10)a2=0;
    if(a3>=12)a3=0;
    if(a4>=14)a4=0;
    if(a5>=15)a5=0;

    PVector m = new PVector(mouseX,mouseY);
    
    if(toggle){
      Entity e = entities.get(ent);
      if(entities.size()>=ent&&e.Humans.size()>0)text(e.Humans.get(0).size(),100,100);
      e.scene.w = e.w;
      e.scene.h = e.h;
      if(!pause)e.scene.field();

      Entities_sublist.draw();
      //fRate.save.location =  saveEntities.folderPath + "/"  + saveEntities.counter +"sliders.txt";
      //folderPath + "/" + coun
      //fRate.savePath = "entities\\" + 

      if(cohesionManager)cohesionLogic();
      if(separationManager)separationLogic();
      if(alignmentManager)alignmentLogic();

      if(!dynamic)drawtotalh = entities.get(ent).Humans.size()-1;
      if(!Entities_sublist.pos())new_human(m);

      

    for ( int i=0;i<e.Humans.size();i++) {
      ArrayList<Human> H = e.Humans.get(i);

      for(int j=H.size()-1;j>-1;j--){

        
        Human h = H.get(j);
        
        h.proximity2 = new ArrayList<ArrayList<Human>>();
        h.family = new ArrayList<Human>();
        h.prox = new ArrayList<Human>();
        h.prox2 = new ArrayList<ArrayList<Human>>();

        for (int l=0;l<hRaces;l++){
          h.prox2.add(new ArrayList<Human>());
          h.proximity2.add(new ArrayList<Human>());
        }
        
        h.scene = e.scene;
        h.alcount = 0;h.acount = 0;h.scount = 0;h.mcount=0;
        
          
        for ( int k=0;k<e.Humans.size();k++) {

          ArrayList<Human> H1 = e.Humans.get(k);
          
          for(int l=H1.size()-1;l>-1;l--){

            Human h1 = H1.get(l);

            float d = dist(h.x,h.y,h1.x,h1.y);

            //if(d<h.breathingroom&&h1!=h)h.proximity.add(h1);
            h1.avoid = false;
            h1.seek = false;
            h1.align = false;
            h1.avoid2 = false;
              
            if(d<h.radius+h1.radius&&h1!=h&&h.race==h1.race)h.family.add(h1);

            if(h1!=h){
            if(
                e.Humans.get(h.race).get(0).alignNeighbour.get(h1.race)>-1
                //&&d>h.min
                &&d<e.Humans.get(h.race).get(0).alignNeighbour.get(h1.race)+h.breathingroom){
                if(!h.prox2.get(h1.race).contains(h1))h.prox2.get(h1.race).add(h1);
                h.alcount++;
                h1.align = true;
              }
              

            if( (e.Humans.get(h.race).get(0).seekNeighbour.get(h1.race)>-1
                //&&d>h.min
                &&d<e.Humans.get(h.race).get(0).seekNeighbour.get(h1.race)+h.breathingroom)){
                if(!h.prox2.get(h1.race).contains(h1))h.prox2.get(h1.race).add(h1);
                h.scount++;
                h1.seek = true;
              }

            if(
                e.Humans.get(h.race).get(0).avoidNeighbour.get(h1.race)>-1
                //&&d>h.min
                &&d<e.Humans.get(h.race).get(0).avoidNeighbour.get(h1.race)+h.breathingroom){
                if(!h.prox2.get(h1.race).contains(h1))h.prox2.get(h1.race).add(h1);
                h.acount++;
                h1.avoid = true;
            }
             if(e.Humans.get(h.race).get(0).avoidNeighbour.get(h1.race)>-1&&d<h.min&&h.min>=0
                &&d<e.Humans.get(h.race).get(0).avoidNeighbour.get(h1.race)+h.breathingroom
                //&&!h.prox2.get(h1.race).contains(h1)
                &&h.race!=h1.race
                ){
                if(!h.proximity2.get(h1.race).contains(h1))h.proximity2.get(h1.race).add(h1);
                h.mcount ++;
                h1.avoid2 = true;
            }}
            if(d<h.min&&h1!=h)h.prox.add(h1);

              }}
        //if(info){
          
        //h.life(h.proximity);
        assignVariable(h);

        if(!pause){
        //h.wander();
        h.quadPos();
        h.update();
        h.applyFriction();
        h.wrap2();
        if(h.update)h.update_qgrid();
        //h.collisions(h.proximity);
        h.flock();
        
        // if(h.id==0)text(h.friction.x,200,150+10*h.race);
        // if(h.id==0)text(h.scount,250,150+10*h.race);
        // h.oscilator();
        
        }
        h.dir = atan2(h.vel.y,h.vel.x);
        if(visible)h.boundary_functions();
        else {
          fill(h.col);
          noStroke();
          ellipse(h.p.x,h.p.y,h.radius,h.radius);
        }

    }
    if(info)
    for(int j=e.Humans.size()-1;j>-1;j--){

      Human h = e.Humans.get(i).get(0);

      float cc = e.Humans.get(i).get(0).seekNeighbour.get(j);
      int count = 0;

      for(int k=0;k<e.Humans.get(i).get(0).prox2.get(j).size();k++){
        Human h1 = e.Humans.get(i).get(0).prox2.get(j).get(k);
        count++;
        //if(j==0)line(h.p.x,h.p.y,h1.p.x,h1.p.y);
      }
      
      text(i,150+100*i,100);
      text(count,130+100*i,110+20*j);
      text("race: " + j + " " + cc,150+100*i,120+10*j);
      text("Vlimit: " + h.vlimit,150+100*i,160);
      text("Alimit: " + h.alimit,150+100*i,170);
      text("Coh: " + h.cohesion,150+100*i,180);
      text("Sep: " + h.separation,150+100*i,190);
    }
    }Reset();
      //if(!hidesliders)
      fRate.draw();
    }
    //else fRate.menu.toggle=0;
  };

 void runh_(){

    a1 += 0.2;
    a2 += 0.5;
    a3 += 0.9;
    a4 += 1.2;
    a5 += 1.5;

    if(a1>=5)a1=0;
    if(a2>=10)a2=0;
    if(a3>=12)a3=0;
    if(a4>=14)a4=0;
    if(a5>=15)a5=0;

    PVector m = new PVector(mouseX,mouseY);
    
    if(toggle){
      Entity e = entities.get(ent);
      if(entities.size()>=ent&&e.Humans.size()>0)text(e.Humans.get(0).size(),100,100);
      e.scene.w = e.w;
      e.scene.h = e.h;
      if(!pause)e.scene.field();

      Entities_sublist.draw();
      //fRate.save.location =  saveEntities.folderPath + "/"  + saveEntities.counter +"sliders.txt";
      //folderPath + "/" + coun
      //fRate.savePath = "entities\\" + 
      //proximity = getNeighbours2();

      if(cohesionManager)cohesionLogic();
      if(separationManager)separationLogic();
      if(alignmentManager)alignmentLogic();

      if(!dynamic)drawtotalh = entities.get(ent).Humans.size()-1;
      if(!Entities_sublist.pos())new_human(m);

      

    for ( int i=0;i<e.Humans.size();i++) {
      ArrayList<Human> H = e.Humans.get(i);

      for(int j=H.size()-1;j>-1;j--){

        
        Human h = H.get(j);
        
        h.proximity2 = new ArrayList<ArrayList<Human>>();
        h.family = new ArrayList<Human>();
        h.prox = new ArrayList<Human>();
        h.prox2 = new ArrayList<ArrayList<Human>>();

        for (int l=0;l<hRaces;l++){
          h.prox2.add(new ArrayList<Human>());
          h.proximity2.add(new ArrayList<Human>());
        }
        
        h.scene = e.scene;
        h.alcount = 0;h.acount = 0;h.scount = 0;h.mcount=0;
        
          
        for ( int k=0;k<h.proximity.size();k++) {

            Human h1 = h.proximity.get(k);

            float d = dist(h.x,h.y,h1.x,h1.y);

            //if(d<h.breathingroom&&h1!=h)h.proximity.add(h1);
            h1.avoid = false;
            h1.seek = false;
            h1.align = false;
            h1.avoid2 = false;
              
            if(d<h.radius+h1.radius&&h1!=h&&h.race==h1.race)h.family.add(h1);

            if(h1!=h){
            if(
                e.Humans.get(h.race).get(0).alignNeighbour.get(h1.race)>-1
                //&&d>h.min
                &&d<e.Humans.get(h.race).get(0).alignNeighbour.get(h1.race)+h.breathingroom){
                if(!h.prox2.get(h1.race).contains(h1))h.prox2.get(h1.race).add(h1);
                h.alcount++;
                h1.align = true;
              }
              

            if( (e.Humans.get(h.race).get(0).seekNeighbour.get(h1.race)>-1
                //&&d>h.min
                &&d<e.Humans.get(h.race).get(0).seekNeighbour.get(h1.race)+h.breathingroom)){
                if(!h.prox2.get(h1.race).contains(h1))h.prox2.get(h1.race).add(h1);
                h.scount++;
                h1.seek = true;
              }

            if(
                e.Humans.get(h.race).get(0).avoidNeighbour.get(h1.race)>-1
                //&&d>h.min
                &&d<e.Humans.get(h.race).get(0).avoidNeighbour.get(h1.race)+h.breathingroom){
                if(!h.prox2.get(h1.race).contains(h1))h.prox2.get(h1.race).add(h1);
                h.acount++;
                h1.avoid = true;
            }
             if(e.Humans.get(h.race).get(0).avoidNeighbour.get(h1.race)>-1&&d<h.min&&h.min>=0
                &&d<e.Humans.get(h.race).get(0).avoidNeighbour.get(h1.race)+h.breathingroom
                //&&!h.prox2.get(h1.race).contains(h1)
                &&h.race!=h1.race
                ){
                if(!h.proximity2.get(h1.race).contains(h1))h.proximity2.get(h1.race).add(h1);
                h.mcount ++;
                h1.avoid2 = true;
            }}
            if(d<h.min&&h1!=h)h.prox.add(h1);

              }
        //if(info){
          
        //h.life(h.proximity);
        assignVariable(h);

        if(!pause){
        //h.wander();
        h.quadPos();
        h.update();
        h.applyFriction();
        h.wrap2();
        if(h.update)h.update_qgrid();
        h.getNeighbours2();
        //h.collisions(h.proximity);
        h.flock();
        
        // if(h.id==0)text(h.friction.x,200,150+10*h.race);
        // if(h.id==0)text(h.scount,250,150+10*h.race);
        // h.oscilator();
        
        }
        h.dir = atan2(h.vel.y,h.vel.x);
        if(visible)h.boundary_functions();
        else {
          fill(h.col);
          noStroke();
          ellipse(h.p.x,h.p.y,h.radius,h.radius);
        }

    }
    if(info)
    for(int j=e.Humans.size()-1;j>-1;j--){

      Human h = e.Humans.get(i).get(0);

      float cc = e.Humans.get(i).get(0).seekNeighbour.get(j);
      int count = 0;

      for(int k=0;k<e.Humans.get(i).get(0).prox2.get(j).size();k++){
        Human h1 = e.Humans.get(i).get(0).prox2.get(j).get(k);
        count++;
        //if(j==0)line(h.p.x,h.p.y,h1.p.x,h1.p.y);
      }
      
      text(i,150+100*i,100);
      text(count,130+100*i,110+20*j);
      text("race: " + j + " " + cc,150+100*i,120+10*j);
      text("Vlimit: " + h.vlimit,150+100*i,160);
      text("Alimit: " + h.alimit,150+100*i,170);
      text("Coh: " + h.cohesion,150+100*i,180);
      text("Sep: " + h.separation,150+100*i,190);
    }
    }Reset();
      //if(!hidesliders)
      fRate.draw();
    }
    //else fRate.menu.toggle=0;
  }; 

  void assignVariable(Entity h){
    if(dynamic){
          h.vlimit = h.vlimitb+vlimit;
          h.alimit = h.alimitb+alimit;
          h.cohesion = h.cohesionb1+cohesion;
          h.cohesionb = h.cohesionb2+cohesion;
          h.alignment = h.alignmentb+alignment;
          h.separation = h.separationb1+separation;
          h.separationb = h.separationb2 + separationb;
          h.separationd = h.separationdb + separationd;
          h.wanderm = h.wandermb+wanderm;
          h.breathingroom = h.breathingroomb1+breathingroom;
          h.breathingroomb = h.breathingroomb2+breathingroomb;
		      h.tscale = tscale;
          
          
        }else {
          h.alimit = h.alimitb;
		      h.vlimit = h.vlimitb;
          h.cohesion = h.cohesionb1;
          h.cohesionb = h.cohesionb2;
          h.alignment = h.alignmentb;
		      h.separation = h.separationb1;
          h.separationb = h.separationb2;
          h.wanderm = h.wandermb;
          h.breathingroom = h.breathingroomb1;
          h.breathingroomb = h.breathingroomb2;
		      h.tscale = h.tscale;
          h.separationb = separationb;
          h.separationd = h.separationdb;
        }
          h.separationc = separationc;
          h.cohesionc = cohesionc;
          h.alignmentc = -alignmentc;
          h.mu = mu;
          h.min = h.minb +min;
          
          //h.prox = h.proximity;
  };

  void runh(Scene s){

    a1 += 0.2;
    a2 += 0.5;
    a3 += 0.9;
    a4 += 1.2;
    a5 += 1.5;

    if(a1>=5)a1=0;
    if(a2>=10)a2=0;
    if(a3>=12)a3=0;
    if(a4>=14)a4=0;
    if(a5>=15)a5=0;

    PVector m = new PVector(mouseX,mouseY);

    if(toggle){

      Entity e = entities.get(ent);
      if(entities.size()>=ent&&e.Humans.size()>0)text(e.Humans.get(0).size(),100,100);
      //e.scene.w = e.w;
      //e.scene.h = e.h;
      s.field();
      
      Entities_sublist.draw();
      //if(!hidesliders)
      fRate.draw();
      if(!dynamic)drawtotalh = entities.get(ent).Humans.size()-1;
      if(!Entities_sublist.pos())new_human(m);

    for ( int i=0;i<e.Humans.size();i++) {
      ArrayList<Human> H = e.Humans.get(i);

      for(int j=H.size()-1;j>-1;j--){

        Human h = H.get(j);
        h.proximity = new ArrayList<Human>();
        h.scene = s;


        for(int k=0;k<e.Humans.size();k++){
          ArrayList<Human> HH = e.Humans.get(k);
          for(int l=0;l<HH.size();l++){

            Human h2 = HH.get(l);
            float d = dist(h.x,h.y,h2.x,h2.y);

            if(d<h.breathingroom/2&&h2!=h)h.proximity.add(h2);

        }}
        h.dir = atan2(h.vel.y,h.vel.x);
        h.wander();
        h.quadPos();
        h.update();
        h.wrap2();
        h.update_qgrid();
        if(!pause)h.flock();
        if(!hidesliders&&dynamic){
          h.vlimit = vlimit;
          h.alimit = alimit;
          h.cohesion = cohesion;
          h.alignment = alignment;
          h.separation = separation;
          h.wanderm = wanderm;
          h.breathingroom = breathingroom;
        }
        //h.prox = h.proximity;
        
        
        if(visible)h.boundary_functions();

    }}Reset();}
  };

  void runp(){

  };

  void draw(){
    tri_boundary.draw();
  };

  void draw2(){
    //flock();
  };

  void desired_trait(){
    for(int i=0;i<3;i++){

    int r = floor(random(Genes.size()-1));
      desired_traits.add(Genes.get(r));
    }
  };

  void mate(){

  };

  void new_human(PVector m){

    if(toggle&&addh&&mousePressed){

      int Race = floor(random(Humans.size()));
      //int Ent = ent;
      int ID = Humans.get(Race).size()-1;

      Human entity = new Human(m.x,m.y,ID,Race,ent);

        entity.lifespan = random(minageh,maxageh);
        entity.carrying_capacity = floor(random(0,6));

      Humans.get(Race).add(entity);
    }

  };

  void life(){
    //boolean retry = false;
    //boolean try_ = false

    Entity e = entities.get(ent);

    if((real&&!pause)&&(Death||Birth)){

    for ( int i=0;i<e.Humans.size();i++) {
      ArrayList<Human> H = e.Humans.get(i);

      for(int j=H.size()-1;j>-1;j--){

       Human h = H.get(j);

       h.col2 = int(map(h.age,0,h.lifespan,0.0,255));

       if(Birth){
       Boolean k = h.births;

       h.age += h.tscale;
       h.w += h.tscale/2;
       h.h += h.tscale/2;
       h.dice = 0;

       if(h.age>=h.lifespan/4&&h.age<=h.lifespan-h.lifespan/4&&h.child<h.carrying_capacity)h.births = true;
       if(h.child > h.carrying_capacity) h.births = false;

       if(h.births) h.delay ++;
       else h.delay = 0;

       if(h.delay > h.lifespan*0.9){h.try_ = true;}
       else h.try_ = false;h.conception = false;

       if(h.try_)h.dice = random(0.001,10);
       fill(255);
       text(h.prox.size(),x+20,y);
       if(h.dice>0&&h.dice<h.carrying_capacity/(h.prox.size()+1) && h.delay >0&&(h.age > random(h.lifespan*1/4,h.lifespan*3/4)))
       {h.conception = true;h.delay = 0; h.dice = 0 ;}
       else h.conception = false;

       if(h.conception){

         Human entity = new Human(h.x + random(-20,20),h.y + random(-20,20),Humans.get(h.race).size(),h.race,h.ent);
         entity.parent = h;
         h.Children.add(entity);
         h.child ++;
         Humans.get(h.race).add(entity);
         h.conception = false;

       }}

       if((h.age>h.lifespan||h.health<=0)&&Death){


       Humans.get(h.race).remove(i);

     }}}}


  };



  void fam(){

  };

  void updateplants(){

  };

  void seek_food(){
    if(hunger>90 && !idle){

    }
    if(hunger>50 && idle){

    }

  };

  void seek(){

  };

  void p_in_space(){

  };


  void add(){

    if(mousePressed){

    }
  };

  boolean p(){
    float X = mouseX;
    float Y = mouseY;
    return X > x -w/2 && X < x + w/2 && Y > y -h/2 && Y < y + h/2;
  };

  void create(int n,int type){

    for(int i=0;i<n;i++){

      float x = random(0,W);
      float y = random(0,H);
      int k = entities.get(ent).Mazecrawlers.get(race).size()-1;
      if(type==0){
        entities.get(ent).Humans.get(race).add(new Human(x,y,k,species.id,ent));
      }else if(type==1){

        entities.get(ent).Animals.get(race).add(new Animal(x,y,k,species.id,ent));
      }else if(type==2){
        entities.get(ent).Plants.get(race).add(new Plant(x,y,k,species.id,ent));
      }else if(type==3){

        entities.get(ent).Mazecrawlers.get(race).add(new mazeCrawler(x,y,k,species.id,ent));
      }
    }

  };



};

class Species{
  float x,y,vx,vy;
  int id;
  public boolean toggle;
  public float intelligence;
  float skill;

  Species(float X, float Y){
    x = X;
    y = Y;
    vx = 2;
    vy = 2;
  };

  Species(){

  };

};

class rSpecies{
  float x,y,vx,vy;
  int type;
  public boolean toggle;
  public float intelligence;
  float skill;

  rSpecies(float X, float Y){
    x = X;
    y = Y;
    vx = 2;
    vy = 2;
  };

  rSpecies(){

  };

};

class Particle extends Entity{

  public boolean toggle;
  public float intelligence;
  float skill;

  Particle(float X, float Y){
    x = X;
    y = Y;
    vx = 2;
    vy = 2;
  };

};

class Human extends Entity{

  ArrayList<Integer> connections = new ArrayList<Integer>();

  Human(float X, float Y){

    x = X;
    y = Y;
    vx = 2;
    vy = 2;

    init();
  }

  Human(float X, float Y,int i,int j,int E){

    x = X;
    y = Y;
    vx = 2;
    vy = 2;
    id = i;
    race = j;
    ent = E;

    init();
  }

  Human(float X, float Y,int i,int j,int E,color c){

    x = X;
    y = Y;
    vx = 2;
    vy = 2;
    id = i;
    race = j;
    ent = E;

    col = c;

    init();
  }

  void init(){
    p = new PVector(x,y);
    vel = new PVector(random(-1,1),random(-1,1));
    ac = new PVector(0.1,0.1);
    lifespan = random(200,250);
    movement = random(40,100);
    intelligence = random(40,100);
    dexterity = random(40,100);
    speed = random(40,100);
    charisma = random(40,100);
    vision = random(40,100);
    health = random(200,250);
    endurance = random(40,100);
    selfp = random(40,100);
    agility = random(40,100);
    reputation = random(40,100);
    sanity = random(40,100);
    humanity = random(40,100);
    size = random(10,20);
    skill = random(0,10);
    w = size;
    h = size;
    center = new PVector(0,0);
    centervel = new PVector(0,0);
    breathingroom = random(50,100);

    tri_boundary = new _tri(x,y,10,20);
    tri_boundary.parent = this;
    tri_boundary.tri.center.x = tri_boundary.tri.x1;
    tri_boundary.tri.center.y = tri_boundary.tri.y1;
    tri_boundary.bg = col;
    tri_boundary.tri.update_Boundaries(tri_boundary.tri);
    tri_boundary.tri.create_rotation_points(tri_boundary.tri.Boundaries);
    tri_boundary.tri.update_dist(tri_boundary.tri.Boundaries);
    // previous boundary
    tri_boundaryp = new _tri(x,y,10,20);
    tri_boundaryp.parent = this;
    tri_boundaryp.tri.center.x = tri_boundaryp.tri.x1;
    tri_boundaryp.tri.center.y = tri_boundaryp.tri.y1;
    tri_boundaryp.bg = col;
    tri_boundaryp.tri.update_Boundaries(tri_boundaryp.tri);
    tri_boundaryp.tri.create_rotation_points(tri_boundaryp.tri.Boundaries);
    tri_boundaryp.tri.update_dist(tri_boundaryp.tri.Boundaries);

    // future boundary

    tri_boundaryf = new _tri(x,y,10,20);
    tri_boundaryf.parent = this;
    tri_boundaryf.tri.center.x = tri_boundaryf.tri.x1;
    tri_boundaryf.tri.center.y = tri_boundaryf.tri.y1;
    tri_boundaryf.bg = col;
    tri_boundaryf.tri.update_Boundaries(tri_boundaryf.tri);
    tri_boundaryf.tri.create_rotation_points(tri_boundaryf.tri.Boundaries);
    tri_boundaryf.tri.update_dist(tri_boundaryf.tri.Boundaries);
    fov = random(30,40);
    //ac.x = map(speed,0,100,0,0.01);
    //ac.y = map(speed,0,100,0,0.01);

    //vlimit = random(4,100);
    lifespan = random(minageh,maxageh);
    carrying_capacity = floor(random(0,6));
    genes.put("carrying_capacity",float(carrying_capacity));
    genes.put("vlimit",vlimit);
    genes.put("vlimit",vlimitb);
    genes.put("alimit",alimit);
    genes.put("alimit",alimitb);
    genes.put("radius",radius);
    genes.put("breathingroom",breathingroom);
    genes.put("min",min);
    genes.put("minb",minb);
    genes.put("col",float(col));
    genes.put("mass", mass);
    genes.put("lifespan",lifespan);
    genes.put("intelligence",intelligence);
    genes.put("dexterity",dexterity);
    genes.put("endurance",endurance);
    genes.put("piety",piety);
    genes.put("vision,",vision);
    genes.put("health",health);
    genes.put("speed",speed);
    genes.put("selfp",selfp);
    genes.put("charisma",charisma);
    genes.put("agility",agility);
    genes.put("reputation",reputation);
    genes.put("sanity",sanity);
    genes.put("humanity",humanity);
    genes.put("faith",faith);
    genes.put("fresistance",fresistance);

    for (String key : genes.keySet()) {
        Genes.add(key);
    }
    desired_trait();

     
  };

  void savegenes(){
    genes.put("carrying_capacity",float(carrying_capacity));
    genes.put("vlimit",vlimit);
    genes.put("vlimit",vlimitb);
    genes.put("alimit",alimit);
    genes.put("alimit",alimitb);
    genes.put("radius",radius);
    genes.put("breathingroom",breathingroom);
    genes.put("min",min);
    genes.put("minb",minb);
    genes.put("col",float(col));
    genes.put("mass", mass);
    genes.put("lifespan",lifespan);
    genes.put("intelligence",intelligence);
    genes.put("dexterity",dexterity);
    genes.put("endurance",endurance);
    genes.put("piety",piety);
    genes.put("vision,",vision);
    genes.put("health",health);
    genes.put("speed",speed);
    genes.put("selfp",selfp);
    genes.put("charisma",charisma);
    genes.put("agility",agility);
    genes.put("reputation",reputation);
    genes.put("sanity",sanity);
    genes.put("humanity",humanity);
    genes.put("faith",faith);
    genes.put("fresistance",fresistance);

    for (String key : genes.keySet()) {
      Genes.add(key);
    }
  };

  void draw(){
    strokeWeight(ssize);
    stroke(cols);
    fill(col2);
    ellipse(x,y,w,h);
  };

   void update_qgrid(){

    //updates the corresponding qgrid array's children with the last id in the iid arraylist

    // iid is either of length 1 at the start or of length 2 any time after. If iid is size 2 then you need to check if the perticle crosses a border at anytime by comparing iid(0)
    // and iid(1), if they are different then the particle has crossed a border. Therefore update the corresponding previous grid space by removing this id, and update the new grid
    // space by adding the id.

    ArrayList<Quad> qgrid = scene.fields;
    if(iid.size()==2){
      boolean a = true;
      if(iid.get(1)<qgrid.size()&&iid.get(1)>=0){
        a = qgrid.get(iid.get(1)).children.contains(this);
      }
      boolean b = false;
      if(iid.get(0)<qgrid.size()&&iid.get(0)>=0){
        b = qgrid.get(iid.get(0)).children.contains(this);
      }
    if(!a){
      qgrid.get(iid.get(1)).children.add(this);
      
      }
      //qgrid.get(iid.get(1)).fillc();
    if (b){
      int k = qgrid.get(iid.get(0)).children.indexOf(this);
      qgrid.get(iid.get(0)).children.remove(k);
    }}
    if(iid.size()==1){
      if(iid.get(0)<qgrid.size()&&iid.get(0)>=0){
    boolean a = qgrid.get(iid.get(0)).children.contains(this);
    if(!a){
      //qgrid.get(iid.get(0)).fillc();
      qgrid.get(iid.get(0)).children.add(this);
    }}}
  };

  void interact(){

  };

  void reproduce(){

  }

  void collide(){

  }

  void ears(){

  };

  void gene(){

  };

};

class Plant extends Entity{

  color col = color(0,255,0);

  Plant(float X, float Y){
    x = X;
    y = Y;
    vx = 2;
    vy = 2;
    init();
  };

  Plant(float X, float Y,int i,int j,int E){
    x = X;
    y = Y;
    vx = 2;
    vy = 2;
    id = i;
    ent = E;
    species = new Species(ent,i);
    init();

  };

  void init(){
    p = new PVector(x,y);
    vel =new PVector(0,0);
    ac =new PVector(0,0);
    lifespan = random(40,100);
    movement = random(40,100);
    intelligence = random(40,100);
    dexterity = random(40,100);
    speed = random(40,100);
    charisma = random(40,100);
    vision = random(40,100);
    health = random(40,100);
    endurance = random(40,100);
    selfp = random(40,100);
    agility = random(40,100);
    reputation = random(40,100);
    sanity = random(40,100);
    humanity = random(40,100);
    size = random(5,10);
    skill = random(0,10);
    w = size;
    h = size;
    lifespan = random(500,1000);
    carrying_capacity = floor(random(0,6));
  }

  void draw(){
    stroke(col);
    fill(col,100);
    ellipse(x,y,w/(frameCount/60)*2,h/(frameCount/60)*2);
  };

};

class Animal extends Entity{

  Animal(float X, float Y){
    x = X;
    y = Y;

  }

  Animal(float X, float Y,int i,int j,int E){
    x = X;
    y = Y;
    id = i;
    species = new Species(ent,i);
    ent = E;

  }

  void draw(){
    stroke(0);
    fill(0);
    ellipse(x,y,20,20);
  };

};

class Mineral extends Entity{

  Mineral(float X, float Y){
    x = X;
    y = Y;

  }

  Mineral(float X, float Y,int i,int j,int E){
    x = X;
    y = Y;
    id = i;
    species = new Species(ent,i);
    ent = E;

  }

  void draw(){
    stroke(0);
    ellipse(x,y,size,size);
  };

};

class Metal extends Entity{

  Metal(float X, float Y){
    x = X;
    y = Y;
  }

  Metal(float X, float Y,int i,int j,int E){
    x = X;
    y = Y;
    id = i;
    species = new Species(ent,i);
    ent = E;
  }

  void draw(){
    stroke(0);
    ellipse(x,y,size,size);
  };
};

class mazeCrawler extends Entity{
  float x,y;
  boolean toggle;
  Entity target;

  mazeCrawler(float X, float Y){
    x = X;
    y = Y;
  }

  mazeCrawler(float X, float Y,int i,int j,int E){
    x = X;
    y = Y;
    id = i;
    species = new Species(ent,i);
    ent = E;

  }

  void draw(){
    stroke(0);
    ellipse(x,y,size,size);
  };

  void seek(){

  };
};

class Cell extends Entity{
  float x,y;
  boolean toggle;
  Entity target;
  Species species;

  Cell(float X, float Y){
    x = X;
    y = Y;

    //species
  }

  Cell(float X, float Y,int i,int j,int E){
    x = X;
    y = Y;
    id = i;
    species = new Species(ent,i);
    ent = E;

  }

  void draw(){
    stroke(0);
    ellipse(x,y,size,size);
  };

  void seek(){

  };
};

class Energy{

  Energy(){

  }

};

class Cycle{

  public float len = 120,start,inc;
  float current;
  Cycle(float Start,float Inc){
    start = Start;
    inc = Inc;
  }

  void run(){

    start += inc;
    current = sin(inc);

  }

};

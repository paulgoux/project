void pop(int x,int y,float w,float h){
  float gW = (1000)/float(gw), gH = 580/float(gh);
  int total = x*y;
  
  for (int i=0;i<total;i++){
    PVector a = new PVector(random(W),random(H));
    
    qgrid.add(new Quad(a,i,w,h));
  }
 
 //float gw = w/x;
 //float gh = h/y;
 
 for (int j=0;j<gh;j++){
    for (int i=0;i<gw;i++){
      int id = i+j*x;
      PVector p = new PVector(i*gW,j*gH);
      qgrid.add(new Quad(p,id,gw,gh));
    }}
};

Quad index2(int xpos,int ypos){
  
  if(wrap){
    
  if(xpos<=0)xpos = gw -1;
  if(xpos>= gw -1)xpos = 0;
  if(ypos <= 0)ypos = gh - 1;
  if(ypos >= gh - 1)ypos = 0;
  
    return qgrid.get(ypos + (xpos * int(gw)));
  }
  else{
    if(xpos<0||xpos>gw-1||ypos<0||ypos>gh-1){
     
    return null;
  }
    return qgrid.get(xpos + (ypos * int(gw)));
  }
  
};

class Quad{
  int id,iid,counter,xpos,ypos;
  float x,y,w,h,dens,dens2,dens3,dens4,v,v2,v3,v4,kv,kv2,kv3,kv4;
  float dir,dir2,dir3,dir4;
  PVector p, kp = new PVector(0,0),kp2 = new PVector(0,0),kp3 = new PVector(0,0);
  color col = 0,col2 = 0,col3 = 0,col4 = 0;
  //ArrayList<Entity> children  = new ArrayList<Entity>();
  ArrayList<Quad> affectees  = new ArrayList<Quad>();
  ArrayList<Quad> affectors  = new ArrayList<Quad>();
  ArrayList<Human> children  = new ArrayList<Human>();
  //HashMap<Quad,ArrayList
  Scene scene;
  
  Quad(PVector P,int ID,float W,float H){
    p = P;
    id = ID;
    x = p.x;
    y = p.y;
    w = W;
    h = H;
  };
  
  Quad(PVector P,int ID,float W,float H,Scene s){
    p = P;
    id = ID;
    x = p.x;
    y = p.y;
    w = W;
    h = H;
    scene = s;
  };

  void draw(){
    
    if(x+w<scene.x+scene.w +w&&y+h<scene.y+scene.h+w){
    float kv = 0;
    float kd = 0;
    kp = new PVector(0,0);
    PVector tkp = new PVector(0,0);
    PVector tkp2 = new PVector(0,0);
    color a = 0;
    affectors = new ArrayList<Quad>();
    
    if(children.size()>0){
      dens = children.size();
    for(int i=0;i<children.size();i++){
      Entity e = children.get(i);
      
      kv += sqrt(abs(e.vel.x*e.vel.x+ e.vel.y*e.vel.y));
      kd += e.dir;
      tkp.add(e.p); 
      
      a += e.col;
    }}
    kv2 = 0;
    col2 = 0;
    dens2 = 0;
    dir2 = 0;
    
    for(int i=0;i<scene.fields.size();i++){
      Quad q = scene.fields.get(i);
      
      float d = dist(x,y,q.x,q.y);
      if(q.dens*4>d&&q!=this){
        if(!affectors.contains(q))affectors.add(q);
      }}
      
      dens2 = affectors.size();
      for(int i=0;i<affectors.size();i++){
        
        Quad q = affectors.get(i);
        
        if(dens2>0){
        kv2 += q.kv/dens2;
        col2 += q.col/dens2;
        dir2 = q.dir/dens2;
        tkp2.add(q.kp);
      }}
      
      dir3 = kd + dir2;
      dir = kd;
      tkp.div(dens);
      tkp2.div(dens2);
      if(kv>0)kv = map(kv,0-200,200,0,125);
      if(kv2>0)kv2 = map(kv2,0-200,200,0,125);
      v = kv + kv2;
      dens3 = dens + dens2;
      PVector k = PVector.add(tkp,tkp2);
      kp = tkp;
      kp = k.div(2);
      kp2 = tkp2;
      a /=dens;col2/=dens2;
      col = a + col2;
      
      
      //if(dens2>0){
      //  dir = dir2;
      //  dens3 = dens2;
      //  v = kv2;
      //  col = col2;
      //}
      
      // if(children.size()>0){
      //  dir = kd/dens;
      //  v = map(kv,0-200,200,0,255)/dens;
      //  //kp = kp.div(dens);
      //  a /=dens; col = a;
      // }
    
    if(scene.showf)line(x,y,x + h/2 * cos(dir3),y + h/2 * sin(dir3));
    if(scene.showf)line(x,y,x - h/2 * cos(dir3),y - h/2 * sin(dir3));
    noFill();
    //fill(255,d);
    noStroke();
    
    if(dir>0){
    fill(col,v);
    //fill(255,kv2/4);
    if(scene.showq)ellipse(kp.x,kp.y,dens3*4,dens3*4);
    //if(scene.showq)ellipse(kp2.x,kp2.y,dens2*10,dens2*10);
    }
    
    //fill(255);
    //text(int(dens3),x,y);
    if(dir<0){
    fill(col,v);
    //fill(0,kv2/4);
    if(scene.showq)ellipse(kp.x,kp.y,dens3*4,dens3*4);
    //if(scene.showq)ellipse(kp2.x,kp2.y,dens2*10,dens2*10);
    }}
  };
  
  void fillc(){
    fill(255);
    //rect(p.x,p.y,w,h);
    
  }; 

  void drawSpace(){
    noFill();
    stroke(0);
    strokeWeight(1);
    rect(p.x,p.y,w,h);

  };
  
  void field(){
    dens2 = 0;
    kv2 = 0;
    col2 = 0;
    dir2 = 0;
    if(x+w<scene.x+scene.w + w&&y+h<scene.y+scene.h+w){
    for(int i=0;i<scene.fields.size();i++){
      Quad q = scene.fields.get(i);
      
      float d = dist(x,y,q.x,q.y);
      if(dens*4>d&&q!=this){
        q.dens2 = dens/4;
        q.kv2 = kv/4;
        q.col2 = col/4;
        q.kp = kp;
        q.dir2 = atan2(y-q.y,x-q.x);
        
      }}}
  };
  
  void humans(){
    
  }
  
};

  
class Input{
  float x,y,w = 100,h = 100,sSize = 8;
  ArrayList<ArrayList<PVector>> points = new ArrayList<ArrayList<PVector>> ();
  boolean mdown, update,onExit,exit,complete,debug;
  
  int xmin = 1000,ymin = 1000,xmax,ymax,output,nxOffset = 20,pxOffset = 20,nyOffset = 10,pyOffset = 10;
  PImage image,croppedImage;
  color col = 0,col1 = 255;
  Card card;
  
  Input(float x,float y){
    
    this.x = x;
    this.y = y;
    
  };
  
  void logic(){
    
    if(mousePressed&&pos()&&!mdown){
      mdown = true;
      points.add(new ArrayList<PVector>());
    }
    
    if(mousePressed&&pos()&&mdown)onExit = false;
    
    if(mdown&&!pos()&&!onExit){
      points.add(new ArrayList<PVector>());
      onExit = true;
      complete = false;
    }
    if(mdown&&!mousePressed){
      update = true;
      mdown = false;
      exit = false;
      onExit = false;
    }
    if(points.size()==0)neuralnet.data.input = null;
    if(!pos()&&mousePressed&&!neuralnet.test.pos()){
       xmin = 1000;ymin = 1000;xmax = 0;ymax = 0; 
       croppedImage = null;
    }
  };
  
  void getPoints(){
    logic();
    if(mdown&&pos()){
      float x1 = mouseX;
      float y1 = mouseY;
      float x2 = pmouseX;
      float y2 = pmouseY;
    
    if(x1!=x2||y1!=y2){
      points.get(points.size()-1).add(new PVector(x1,y1));
    }
    else if(points.get(points.size()-1).size()==0){
      points.get(points.size()-1).add(new PVector(x1,y1));
    }}
    
    if(!pos()&&mousePressed&&!mdown&&!neuralnet.reset.pos()&&!neuralnet.test.pos()){
      //points = new ArrayList<ArrayList<PVector>>();
      //complete = false;
    }
    if(neuralnet.reset.pos()&&mousePressed){
      complete = false;
      points = new ArrayList<ArrayList<PVector>>();
      image = null;
    }
  };
  
  void draw(){
    
    getPoints();
    strokeWeight(1);
    fill(col);
    noStroke();
    stroke(col1);
    rect(x-1,y-1,w+2,h+2);
    
    if(points.size()>0){
      
     strokeWeight(sSize);
     stroke(col1);
     
     for(int i=0;i<points.size();i++){
       if(points.get(i).size()>1){
         for(int j=0;j<points.get(i).size()-1;j++){
         PVector p = points.get(i).get(j);
         PVector p1 = new PVector(-1,-1);
         if(i<points.size())p1 = points.get(i).get(j+1);
         line(p.x,p.y,p1.x,p1.y);
         
         }}else if(points.get(i).size()==1){
             PVector p = points.get(i).get(0);
             point(p.x,p.y);
             int loc = (int)p.x-(int)x + ((int)p.y - (int)y)*(int)w;
     }}}
     
     if(update||mdown){
       
     image = createImage(int(w),int(h),RGB);
     image.loadPixels();
     loadPixels();
     
     for(int i=0;i<h;i++){
       for(int j=0;j<w;j++){
         
         int p = j+i*(int)w;
         int p1 = (int)x+(int)y*width+j+i*width;
         
         image.pixels[p] = pixels[p1];
       }}
       image.updatePixels();
       
     }
     crop();
  };
  
  void crop(){
    fill(255);
    if(image!=null){
      
      for(int i=0;i<h;i++){
        for(int j=0;j<w;j++){
          
          int p = j+i*(int)w;
          color c = color(image.pixels[p]);
          
          if(red(c)==col1){
            //if(xmin > (int)x+j)xmin = (int)x+j;
            //if(ymin > (int)y+i)ymin = (int)y+i;
            
            //if(xmax < (int)x+j)xmax = (int)x+j;
            //if(ymax < (int)y+i)ymax = (int)y+i;
            
            //if(xmin > j)xmin = j;
            //if(ymin > i)ymin = i;
            
            //if(xmax < j)xmax = j;
            //if(ymax < i)ymax = i;
            
            if(xmin > j )xmin = j;
            
            if(ymin > i )ymin = i;
            
            if(xmax < j )xmax = j;
            
            if(ymax < i )ymax = i;
            
          }}}
          
         if(debug){
           image(image,200,0);
           
           strokeWeight(7);
           stroke(0,255,0);
           point( xmin+200,ymin);
           stroke(255,0,0);
           point( xmax+200,ymax);
           fill(255);
           color c = 0;
           if((mouseX+mouseY*width)<pixels.length)c = pixels[mouseX+mouseY*width];
           fill(0);
           text(red(c),300,100);
           text(xmin,300,110);
           text(xmax,300,120);
         }
         if(update&&points.size()>0){
           xmin -= nxOffset;
           ymin -= nyOffset;
           xmax += pxOffset;
           ymax += pyOffset;
           if(xmax>xmin){
             if(ymax > ymin)croppedImage = createImage(xmax - xmin,ymax - ymin,RGB);
             else croppedImage = createImage(xmax - xmin,ymin - ymax ,RGB);
           }else{
             if(ymax > ymin)croppedImage = createImage(xmin - xmax,ymax - ymin  ,RGB);
             else croppedImage = createImage(xmin - xmax,ymin - ymax ,RGB);
           }
        
        croppedImage.loadPixels();
        
        for(int i=ymin;i<ymax;i++){
          for(int j=xmin;j<xmax;j++){
            
            int p = (j-xmin) + (i-ymin) * (croppedImage.width);
            int p1 = j + i * (int)w;
            
            if(p<croppedImage.pixels.length&&p1<image.pixels.length&&p>=0&&p1>=0)croppedImage.pixels[p] = image.pixels[p1];
        }}
        update = false;
        complete = false;
      }
        
        if(croppedImage!=null&&!complete){
          int k = 28;
          croppedImage.resize(k,k);
          complete = true;
        }
        if(croppedImage!=null&&debug){
          stroke(col1);
          noFill();
          strokeWeight(1);
          rect(199,99,15,15);
          image(croppedImage,200,100);
        }
    }
  };
  
  boolean pos(){
    return mouseX>x&&mouseX<x+w&&mouseY>y&&mouseY<y+h;
  };
};
class SliderGrid{
  float x,y,w,h;
  ArrayList<Slider> sliders = new ArrayList<Slider>();
  String itemLabel;
  
  SliderGrid(float X,float Y,float W,float H,String[] Labels,int cols,int rows){
    
    x = X;
    y = Y;
    w = W;
    h = H;
    
    float ww = W/cols;
    float hh = H/cols;
    
    for (int i=0;i<rows;i++){
      for(int j=0;j<cols;j++){
        
        int pos = j+i*cols;
        
        String label = null;
        if(pos<Labels.length){
        
          label = Labels[pos];
        Slider s = new Slider(x+ww*j,y+hh*i,ww-30,10,label);
        sliders.add(s);
        
    }}}
  };
    
    void draw(){
     for(int i=0;i<sliders.size();i++){
       Slider s = sliders.get(i);
       
       s.draw();
     }
    
  };
  
  
  
};
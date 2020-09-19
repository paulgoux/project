class Tree{
  float x,y;
  
  
  Tree(){
    
  }
  
  
};

class SoundSpectrum{
  
  SoundFile Audio = null;
  Amplitude amp;
  
  FFT fft;
  AudioIn in;
  
  processing.sound.Sound s;
  public float volume = 0,offsetx,offsety;
  int bands,slices;
  PImage specImg;
  
  int frame,frame2,frames,count;
  boolean constructImage,debug;
  
  float[] spectrum = new float[bands];
  ArrayList<PVector> audio = new ArrayList<PVector>();
  ArrayList<ArrayList<PVector>> audio2 = new ArrayList<ArrayList<PVector>>();
  ArrayList<ArrayList<PVector>> visualiser = new ArrayList<ArrayList<PVector>>();
  ArrayList<PImage> audioSlices = new ArrayList<PImage>();
  ArrayList<GridImg> gridImages = new ArrayList<GridImg>();
  ArrayList<Image> imageProcesses = new ArrayList<Image>();
  GridImg imageGrid;
  
  PApplet sketchRef;
  tab parent;
  Window window;
  
  SoundSpectrum(processing.sound.Sound S, PApplet sketchRef_,int Bands,String loc){
    s = S;
    slices = 1;
    sketchRef = sketchRef_;
    s = new processing.sound.Sound(sketchRef);
    bands = Bands;
    // Create an Input stream which is routed into the Amplitude analyzer
    amp = new Amplitude(sketchRef_);
    Audio = new SoundFile(sketchRef_,loc);
    // Create an Input stream which is routed into the Amplitude analyzer
    fft = new FFT(sketchRef_, bands);
    
    //amp.input(audio);
    fft.input(Audio);
    Audio.play();
    //audio.amp(0.01);
    frames = Audio.frames();
    
  }
  
  SoundSpectrum(processing.sound.Sound S, PApplet sketchRef_,int Bands,int Slices,String loc){
    s = S;
    slices = Slices;
    sketchRef = sketchRef_;
    s = new processing.sound.Sound(sketchRef);
    bands = Bands;
    // Create an Input stream which is routed into the Amplitude analyzer
    amp = new Amplitude(sketchRef_);
    Audio = new SoundFile(sketchRef_,loc);
    // Create an Input stream which is routed into the Amplitude analyzer
    fft = new FFT(sketchRef_, bands);
    
    //amp.input(audio);
    fft.input(Audio);
    Audio.play();
    //audio.amp(0.01);
    frames = Audio.frames();
    
    load();
    int l = floor(sqrt(audioSlices.size()));
    GridImg imageGrid = new GridImg(parent.x + offsetx,parent.y + offsety,l,l,audioSlices);
    
    
  }
  
  SoundSpectrum(){
    
  }
  
  void save(){
    
  };
  
  void loadSave(){
    
  };
  
  void load() { 
  
  //---------------------------------------------------------------------------------------------------
  // Map vertical mouse position to volume.
  float amplitude = map(mouseY, 0, height, 0.4, 0.0);

  // Instead of setting the volume for every oscillator individually, we can just
  // control the overall output volume of the whole Sound library.
  s.volume(0);
  //------------------------------------------------------------------------------------------------------
 
  if(Audio.isPlaying())analyse();
  else if(!constructImage)construct();
    
};

void draw(){
  if(constructImage)display();
  debug();
}

void play(){
  s.volume(1);
  Audio.play();
};

void play(float a){
  Audio.play(a);
};

void analyse(){
  fft.analyze(spectrum);
  audio2.add(new ArrayList<PVector>());
  visualiser.add(new ArrayList<PVector>());
  for(int i = 0; i < bands; i++){
  // The result of the FFT is normalized
  // draw the line for frequency band i scaling it up by 5 to get more amplitude.
  float k = map(i,0,bands,0,width);
  float y = map( (spectrum[i]),0,0.01,0,height);
  
  float k1 = i;
  float y1 = map( (spectrum[i]),0,0.01,0,255);
  
  colorMode(HSB);
  stroke(i,random(255),random(255));
  fill(i,random(255),random(255));
  audio.add(new PVector(k,y));
  audio2.get(frame).add(new PVector(k,height-y));
  visualiser.get(frame).add(new PVector(i,y1));
  //vertex(k,-y);
  stroke(i,random(255),random(255));
  //vertex(bar.x,bar.y);
  line(k,height,k,height -y);
  }
  //endShape(OPEN);
  fill(255);
  text("playing",100,100);
  frame ++;
};

void construct(){
    colorMode(RGB);
    fill(255);
    text("Constructing",100,110);
    
    specImg = createImage(bands,frame,RGB);
    specImg.loadPixels();
    loadPixels();
    
    for(int i = 0; i < visualiser.size(); i++){
      ArrayList<PVector> b = visualiser.get(i);
      for(int j = 0; j < b.size(); j++){
        
        int pos = j+i*b.size();
        PVector p = b.get(j);
        
        specImg.pixels[pos] = color(255-p.y,map(i,0,255,0,height),255-p.y);
        
        pixels[pos] = color(random(255),0,0);
      }}
      updatePixels();
      specImg.updatePixels();
      
    if(slices>1&&audioSlices.size()<slices){
      PImage img = createImage(bands,frame/slices,RGB);
      
      count = 0;
      for(int i = 0; i < visualiser.size(); i++){
        
        ArrayList<PVector> b = visualiser.get(i);
        
          for(int j = 0; j < b.size(); j++){
            if(count==0)img.loadPixels();
            
            int pos = j+i*b.size();
            PVector p = b.get(j);
            
            img.pixels[count] = specImg.pixels[pos];
            count++;
            
            if(count>=(specImg.width*specImg.height)/2){
              img.updatePixels();
              if(audioSlices.size()<slices)audioSlices.add(img);
              img = createImage(bands,frame/slices,RGB);
              count = 0;
            }}}
      text(slices + " slices",100,110);
    }else{
      text("1 slice",100,110);
      audioSlices.add(specImg);
    }
    constructImage = true;
};

void display(){
  fill(255);
  if(slices>1){
        for(int i = 0; i < audioSlices.size(); i++){
          image(audioSlices.get(i),0,0+i*audioSlices.get(i).height);
        }
        text(audioSlices.size() + " slices",100,110);
        text("stopped",100,100);
      
    }else{
      image(specImg,0,0); 
      
      text("1 slice",100,110);
      text("stopped",100,100);
      if(frame2<frame-1)frame2++;
      }
};

void debug(){
  if(debug){
  fill(0);
  text(frameRate,200,200);
  text(frames,200,210);
  text(frame,200,220);
  text(audio2.size(),200,230);
  text(visualiser.size(),200,240);
  }
};
  
  
};

class TwitterKeyword{
  
  ArrayList<String> Keywords = new ArrayList<String>();
  public boolean toggle,addKeyword,showKeyword; 
  Menu keywords;
  String []keywordArray;
  color col = 255;;
  boolean arraySet;
  TwitterKeyword(String S){
    Keywords.add(S);
    keywords = new Menu(100,100,70,Keywords);
  };
  
  TwitterKeyword(String[] S){
    for(int i=0;i<S.length;i++){
      Keywords.add(S[i]);
    }
    
    keywords = new Menu(100,100,70,S,0);
  };
  
  TwitterKeyword(ArrayList<String> S){
    Keywords = S;
    keywords = new Menu(100,100,70,S);
  };
  
  void showKeywords(){
    fill(col);
    for(int i=0;i<Keywords.size();i++){
      text(Keywords.get(i),100,100+10*i);
    }
  };
  
  void addKeywords(String s){
    
    if(addKeyword&&arraySet){
      Keywords.add(s);
      arraySet = false;
    }
    
  };
  
  void eventListener(){
    
  };
  
  String [] getKeywords(){
    
    if(!arraySet){
      keywordArray = new String [Keywords.size()];
    for(int i=0;i<Keywords.size();i++){
      String s1 = Keywords.get(i);
      
      keywordArray[i] = s1;
      
    }arraySet = true;
    }
    return keywordArray;
  };
  
};

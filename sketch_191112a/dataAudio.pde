class audioData{
  
  PApplet app;
  
  Amplitude amp;
  SoundFile audioFile = null;
  
  FFT fft;
  AudioIn in;
  processing.sound.Sound  s;
  
  int slices = 1,bands,frame,frame2,frames=0,count,slice;;

  float[] spectrum;
  ArrayList<PVector> audio = new ArrayList<PVector>();
  ArrayList<ArrayList<PVector>> audio2 = new ArrayList<ArrayList<PVector>>();
  ArrayList<ArrayList<PVector>> visualiser = new ArrayList<ArrayList<PVector>>();
  ArrayList<PImage> audioSlices = new ArrayList<PImage>();
  
  PImage specImg;
  boolean constructImage,Debug,analysed,sliced;
  
  audioData(PApplet app,int bands,String file){
    
    spectrum = new float[bands];
    this.bands = bands;
    this.app = app;
    s = new processing.sound.Sound (app);
    amp = new Amplitude(app);
    audioFile = new SoundFile(app,file);
    // Create an Input stream which is routed into the Amplitude analyzer
    fft = new FFT(app, bands);
    
    //amp.input(audioFile);
    fft.input(audioFile);
    audioFile.rate(1.5);
  };
  
  audioData(PApplet app,int bands,int Slices,String file){
    
    this.slices = Slices;
    spectrum = new float[bands];
    this.bands = bands;
    this.app = app;
    s = new processing.sound.Sound (app);
    amp = new Amplitude(app);
    audioFile = new SoundFile(app,file);
    // Create an Input stream which is routed into the Amplitude analyzer
    fft = new FFT(app, bands);
    
    //amp.input(audioFile);
    fft.input(audioFile);
    audioFile.rate(1.5);
  };
  
  void load(){
    
    
    // Create an Input stream which is routed into the Amplitude analyzer
    
    
  };
  
  void init(){
    if(count==0)audioFile.play();
    
    if(audioFile.isPlaying())analyse();
     else  analysed = true;
    //---------------------------------------------------------------------------------------------------
    // Map vertical mouse position to volume.
    float amplitude = map(mouseY, 0, height, 0.4, 0.0);
    
    // Instead of setting the volume for every oscillator individually, we can just
    // control the overall output volume of the whole Sound library.
    s.volume(1);
    //------------------------------------------------------------------------------------------------------
   
        if(!constructImage&&analysed){
          construct();
          }else if(constructImage){
            display();
          }
  
    debug();
    if(audioFile.isPlaying())count++;
  };
  
  void analyse(){
    if(audioFile.isPlaying()){
    fft.analyze(spectrum);
    audio2.add(new ArrayList<PVector>());
    visualiser.add(new ArrayList<PVector>());
    for(int i = 0; i < bands; i++){
    // The result of the FFT is normalized
    // draw the line for frequency band i scaling it up by 5 to get more amplitude.
    float x = map(i,0,bands,0,width);
    float y = map( (spectrum[i]),0,1,0,height);
    
    float x1 = i;
    float y1 = map( (spectrum[i]),0,0.001,0,255);
    
    colorMode(HSB);
    stroke(i,random(255),random(255));
    fill(i,random(255),random(255));
    audio.add(new PVector(x,y));
    audio2.get(frame).add(new PVector(x,y));
    visualiser.get(frame).add(new PVector(x1,y1));
    //vertex(k,-y);
    stroke(x1,random(255),random(255));
    //vertex(bar.x,bar.y);
    line(x,height,x,height -y);
    frames ++;
    }
    //endShape(OPEN);
    fill(255);
    text("playing",100,100);
    frame ++;
    }
  };
  
  void construct(){
    colorMode(RGB);
    fill(255);
    text("Constructing",100,110);
    if(!sliced){
    specImg = createImage(bands,frame,RGB);
    specImg.loadPixels();
    //loadPixels();
    
    for(int i = 0; i < visualiser.size(); i++){
      ArrayList<PVector> b = visualiser.get(i);
      for(int j = 0; j < b.size(); j++){
        
        int pos = j+i*b.size();
        PVector p = b.get(j);
        
        specImg.pixels[pos] = color(255-p.y,map(i,0,255,0,height),255-p.y);
        
        //if(pos<pixels.length)pixels[pos] = color(random(255),0,0);
      }}
      //updatePixels();
      specImg.updatePixels();
     sliced = true; 
    }
      
    constructImage = true;
};

void display(){
  
        
        if(sliced){
          image(specImg,0,0);
          int n = (int)(specImg.width*specImg.height)/slices;
          
          if(audioSlices.size()<slices){
            for(int i=0;i<slices;i++)
            audioSlices.add(null);
          }
          for(int i=0;i<slices;i++){
            
            PImage img = createImage(specImg.width,specImg.height/slices,RGB);
            img.loadPixels();
            int k = i * img.pixels.length;
            int p1 = i * (512+1);
            for(int j=0;j<img.pixels.length;j++){
              int p = k + j;
              if(p<specImg.pixels.length)img.pixels[j] 
              = specImg.pixels[p];
            }
            img.updatePixels();
            audioSlices.set(i,img);
        }}
          
          for(int i = 0; i < slices; i++){
              //image(audioSlices.get(i),0,i*audioSlices.get(i).height);
              stroke(0);
              strokeWeight(1);
              noFill();
              rect(0,i*frame/slices,bands,frames/slices);
            }
            
            fill(255);
      
            
            text(audioSlices.size() + " slices",100,110);
            text("stopped",100,100);
      
};

void debug(){
  if(Debug){
  fill(0);
  text(frameRate,200,200);
  text("frames " + frames,200,210);
  text("frame " + frame,200,220);
  text(audio2.size(),200,230);
  text("visualiser size " + visualiser.size(),200,240);
  if(visualiser.size()>0)text("visualiser[0] " + visualiser.get(0).size(),200,250);
  if(specImg!=null)text("img height " + specImg.height,200,260);
  
  }
};
  
};
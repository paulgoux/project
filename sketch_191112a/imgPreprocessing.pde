class Img {
  float Mean = 0,Variance,VarianceR,VarianceG,VarianceB,VarianceBR;
  public PImage img, mean,mean_,meanGx,meanGy,blurX,blurY, threshold, variance,varianceR,varianceG,varianceB,varianceBR,Gaussian,
         kMeans, kNearest,sobel, sobelx, sobely,sobel2, sobel2x, sobel2y, sobelMax,sobelMin,sobelG,gradientB, blur,combined,current;
  public String currentParameter,currentS;
  String []menuLabels = {"Load","Save","Restore Menus"};
  String []menuLabels1 = {"Load","Save","Pick Camera","Load workflow","Save workflow","Restore Menus"};
  String []menuLabels2 = {"Run"};
  String []sliderLabels ,names;
  String file,folder,location;
  Menu menu,run;
  public float currentF;
  int currentImageIndex;
  public int firstImageIndex;
  boolean update = true,imageF = true,videoF,audioF,camF;;
  public final int IMAGES = 0,VIDEOS = 1,AUDIO = 2,MOVIE = 3,SOUND = 4;
  public boolean load = true,toggle,iUpdate = true;
  ArrayList<PImage> images = new ArrayList<PImage>();
  ArrayList<PImage> thumbnails = new ArrayList<PImage>();
  fileInput input;
  fileOutput output;
  tab info,sliders,workFlow;
  PGraphics canvas,camera;
  //currentField;
  String [] instructions;
  
  int [][]SobelH = {{-1, -2, -1}, 
                    {0, 0, 0}, 
                    {1, 2, 1}};

  int [][]SobelV = {{-1, 0, 1}, 
                    {-2, 0, 2}, 
                    {-1, 0, 1}};
                    
  int [][]SobelH_ = {{-2, -1, 0}, 
                    {-1, 0, 1}, 
                    {0, 1, 2}};

  int [][]SobelV_ = {{0, 1, 2}, 
                    {-1, 0, 1}, 
                    {-2, -1, 0}};
                    
  int [][]edgev = {{-1, -2, -1}, 
                   {0, 0, 0}, 
                   {1, 2, 1}};

  int [][]edgeh = {{-1, 0, 1}, 
                   {-2, 0, 2}, 
                   {-1, 0, 1}};

  int [][]LapLacian = {{0, 1, 0}, 
                      {-1, 4, -1}, 
                      {0, 1, 0}};

  int [][]LapLacianD = {{-1, -1, -1}, 
                        {-1, 8, -1}, 
                        {-1, -1, -1}};
                        
  int [][]edge = {{-1, 1, -1}, 
                  {-1, 0, -1}, 
                  {-1, -1, -1}};
                  
  int [][]meanX = {{1,1,1}, 
                   {0,0,0}, 
                   {1,1,1}};

  int [][]meanY = {{1,1,1}, 
                   {2,0,2}, 
                   {1,0,1}};
                   
  float [][]gaussian3 = {{1,2,1}, 
                         {2,4,2}, 
                         {1,2,1}};
                     
  float [][]gaussian5 = {{1,4,7,4,1}, 
                         {4,16,126,16,4}, 
                         {7,26,41,26,7},
                         {4,16,26,16,4},
                         {1,4,7,4,1}};
                   
  color [][]neighbours;
  float [][]gradient;
  
  Img(String s) {
    img = loadImage(s);
    neighbours = new color[img.width][img.height];
    gradient = new float[img.width][img.height];
  };

  Img(PImage p) {
    img = new PImage(p.width,p.height,ARGB);
    img.pixels = p.pixels;
  };

  
  Img(int w,int h){
      img = new PImage(w, h, ARGB);
    
  };
  
  Img(int a){
    float mx = width-200;
    if(a==0){
      imageF=true;
      menu = new Menu(mx,23,100,menuLabels);
    }
    if(a==1||a==3)videoF=true;
    if(a==2||a==4){
      audioF=true;
      menu = new Menu(mx,23,100,menuLabels1);
    }
    if(a==6){
      imageF = false;
      camF = true;
      menu = new Menu(mx,23,100,menuLabels1);
    }
    
    info = new tab(0,height - 170,width,150,"Images");
    sliders = new tab(width-100,68,100,height - 240,"Sliders");
    workFlow = new tab(0,68,100,height - 240,"Workflow");
    TextArea m1 = new TextArea(0,20,100,workFlow.h - 40,10,100);
    run = new Menu(0,workFlow.h-20,100,menuLabels2);
    run.w = 100;
    workFlow.add(m1);
    workFlow.add(run);
    
    input = new fileInput(menu.items.get(0),true);
    output = new fileOutput();
    info.toggle = true;
    sliders.toggle = true;
    workFlow.toggle = true;
    info.draggable = true;
    info.scrollable = true;
    workFlow.draggable = true;
    sliders.draggable = true;
    sliders.scrollable = true;
    //workFlow.scrollable = true;
    canvas = createGraphics(width-200,height - 190);
  };

  Img(){
    menu = new Menu(width-100,23,100,menuLabels);
    
    info = new tab(0,height - 170,width,150,"Images");
    sliders = new tab(width-100,68,100,height - 240,"Sliders");
    workFlow = new tab(0,68,100,height - 240,"Workflow");
    TextArea m1 = new TextArea(0,20,100,height - 240,10,100);
    workFlow.add(m1);
    
    input = new fileInput(menu.items.get(0),true);
    output = new fileOutput();
    info.toggle = true;
    sliders.toggle = true;
    workFlow.toggle = true;
    info.draggable = true;
    info.scrollable = true;
    workFlow.draggable = true;
    sliders.draggable = true;
    sliders.scrollable = true;
    //workFlow.scrollable = true;
    canvas = createGraphics(width-200,height - 190);
  };

  void init(){
    //menu

  };

  Object parseParameter(String parameter) {
    try {
        return Integer.parseInt(parameter);
      } catch(NumberFormatException e) {
          try {
              return Float.parseFloat(parameter);
          } catch(NumberFormatException e1) {
              try {
                  Field field = this.getClass().getField(parameter);
                  return field.get(this);
              } catch (NoSuchFieldException e2){return null;}
                catch(IllegalAccessException e2) {
                  throw new RuntimeException(e2);
                  //return null;
              }
          }
      }
  };

  Class<?> getParameterClass(String parameter) {
      try {
          Integer.parseInt(parameter);
          return int.class;
      } catch(NumberFormatException e) {
          try {
              Float.parseFloat(parameter);
              return float.class;
          } catch(NumberFormatException e1) {
              
              if(parameter!=null)return PImage.class;
              else return null;
          }
      }
  };

  void loadInput(){
    if(location!=null){
      String loc = "";
      if(file!=null||folder!=null){
        if(file!=null)loc = file;
        else loc = folder;

        //String files = 
      }
      load = false;
      location = null;
    }
  };
  void display(){


  };
  void menus(){
    
    if(toggle){
      //sliders.toggle = true;
      //workFlow.toggle = true;
      //info.toggle = true;
      if(imageF)loadImages();
      if(videoF)loadVideo();
      if(audioF)loadSound();
      save();
      
      if(info.sliderh.mdown)iUpdate = true;
      if(images.size()>0){
        
        canvas.beginDraw();
        
        canvas.background(50);
        if(firstImageIndex<images.size()&&firstImageIndex>0)canvas.image(images.get(firstImageIndex),0,0);
        canvas.endDraw();
        
      }
      if(BMS.Cam!=null){
        set(BMS.Cam);
        canvas.beginDraw();
        //if(img!=null)
        canvas.image(BMS.Cam,0,0);
        if(mousePressed)println("cam connected");
        
        canvas.background(50);
        if(firstImageIndex<images.size()&&firstImageIndex>0)canvas.image(images.get(firstImageIndex),0,0);
        canvas.endDraw();
      }
      //else if(mousePressed)println("no cam");
      if(thumbnails.size()>0)info.sliderh.setint(0,thumbnails.size(),this,"firstImageIndex");
      if(!mousePressed){
        currentImageIndex = floor(map(mouseX,0,info.w,0,8));
        iUpdate = false;
      }
      int c1 = floor(map(mouseX,0,info.w,-4,5));
      //if(mousePressed)println(firstImageIndex,currentImageIndex);
      if(!info.sliderh.mdown&&mousePressed&&info.posTab()&&!iUpdate){
        //println(c1);
        if(c1<0)firstImageIndex += c1+1;
        else firstImageIndex += c1;
        iUpdate = true;
      }
      
      image(canvas,100,20);
      
      info.displayTab();
      
      info.drawDynamicImages(info.images,currentImageIndex);
      sliders.displayTab();
      workFlow.displayTab();
      
      menu.draw();
      run.draw();
      //run.selfClick(0);
      if(run.selfClick(0)){
        if(workFlow.textareas.get(0).getValue()!=null){
          println(true,workFlow.textareas.get(0).getValue());

          if(images.size()>0&&img==null)img = images.get(firstImageIndex);
          
          String[] s = splitTokens(workFlow.textareas.get(0).getValue(),",");
          String[] s1 = new String[1];
          s1[0] = workFlow.textareas.get(0).getValue();
          workflow(s1);
          firstImageIndex = images.size()-1;
          if(firstImageIndex>0&&firstImageIndex<images.size())img = images.get(firstImageIndex);
          else if(images.size()>0)img = images.get(images.size()-1);
          workFlow.textareas.get(0).textBox ="";
          iUpdate = true;
          workFlow.textareas.get(0).textbox = new ArrayList<Letter>();
        }else println(false);
      }
      //else println("no");
    }
  };

  void loadImages(){
    input.listen();
    if(input.values!=null){
      println("input",input.values.length);
      if(input.values.length<100){
        //if(true){
          names = new String[input.values.length];
          if(images.size()<input.values.length)
          for(int i=0;i<input.values.length;i++){
            String s1 = input.files[i].getAbsolutePath();
            String[] m1 = match(s1, ".jpg");
            String[] m2 = match(s1, ".jpeg");
            String[] m3 = match(s1, ".gif");
            String[] m4 = match(s1, ".png");
            String[] m5 = match(s1, ".bmp");
            String[] m6 = match(s1, ".JPG");
            String[] m7 = match(s1, ".JPEG");
            String[] m8 = match(s1, ".GIF");
            String[] m9 = match(s1, ".PNG");
            String[] m10 = match(s1, ".BMP");

            if (m1 != null||m2 != null||m3 != null||m4 != null||m5 != null||
                m6 != null||m7 != null||m8 != null||m9 != null||m10 != null) { 
              if(images.size()<100){
                PImage thumbnail = loadImage(s1);
                images.add(loadImage(s1));
                
                thumbnail.resize(150,90);
                thumbnails.add(thumbnail);
                names[i] = (s1);
              }
            } 
          }
          int k = (5-firstImageIndex);
          println("step 1",images.size(),"first index:",firstImageIndex);
          
          input.values = null;
          //iUpdate = false;
        }else {
          info.sliderh.setint(0,input.files.length,this,"firstImageIndex");
          if(iUpdate){
            for(int i=firstImageIndex;i<firstImageIndex+100;i++){
              if(input.files[i]!=null){
                String s1 = input.files[i].getAbsolutePath();
                String[] m1 = match(s1, ".jpg");
                String[] m2 = match(s1, ".jpeg");
                String[] m3 = match(s1, ".gif");
                String[] m4 = match(s1, ".png");
                String[] m5 = match(s1, ".bmp");
                String[] m6 = match(s1, ".JPG");
                String[] m7 = match(s1, ".JPEG");
                String[] m8 = match(s1, ".GIF");
                String[] m9 = match(s1, ".PNG");
                String[] m10 = match(s1, ".BMP");

                if (m1 != null||m2 != null||m3 != null||m4 != null||m5 != null||
                    m6 != null||m7 != null||m8 != null||m9 != null||m10 != null) { 
                  images.add(loadImage(s1));
                } 
              }
          }}
        }
        //if(images.size()>100)images.remove(0);
      //if(mousePressed)println(firstImageIndex);
    }else if(names!=null&&names.length>0&&iUpdate){
      for(int i=firstImageIndex-4;i<firstImageIndex+5;i++){
          if(i>0&&i<thumbnails.size()){
            PImage p1 = thumbnails.get(i);
            
            if(!info.images.contains(p1)){
              info.images.add(p1);
            }
            if(info.images.size()>9)info.images.remove(0);
        }}
    }

  };

  void loadVideo(){


  };

  void loadSound(){


  };

  void save(){

  };
  
  void workflow(String a){
    String[] s = splitTokens(a, "-");
    
    for(int i=0;i<s.length;i++){
      String s1 = s[i];
      
      //ArrayList<Integer> [] pIndex = strIndex(s1,"(",")");
      int [] pIndex = strIndex1(s1,"(",")");
      String function = s1.substring(0,pIndex[0]);
      
      //String[]parameters = new String [pIndex[0].size()];
      String[]parameters = splitTokens(s[i].substring(pIndex[0]+1,pIndex[1]),",");
      parameters[parameters.length-1] =  parameters[parameters.length-1].substring(0,parameters.length-1);
      
      boolean image = false;
      Method method = null;
      try {
        method = this.getClass().getMethod(function,float.class,float.class);
        //Img instance = new Img();
        float result = (float) method.invoke(this, 1, 3);
        println("result",result);
      } catch (SecurityException e) {
        println(function , "se");
      }catch (NoSuchMethodException e) {  
        println(function , "nsm");
      }
      catch (IllegalAccessException e) {  
        println(function , "nsm");
      }
      catch (InvocationTargetException e) {  
        println(function , "nsm");
      }
      for(int j=0;j<parameters.length;j++){
        
        float currentF = float(parameters[j]);
        
        if(currentF>-10000000&&currentF<10000000){
          println(function,"f " + currentF);
        }else println(function,"s " + parameters[j]);
        
      }
      
      //println(s1);
      //for(int j=0;j<s3.length;j++){
      //  println(s3[j]);
      //}
      
      //println(s3[0]+", ");
      //switch(){
        
      //}
    }
  };
  
  void workflow(String[] a){
    if(update&&a!=null){
      String[] s = a;
      
      for(int i=0;i<s.length;i++){
        String s1 = s[i];
        if(s[i].length()>0){
        int [] pIndex = strIndex1(s1,"(",")");
        String function = s1.substring(0,pIndex[0]);
        
        String[]parameters = splitTokens(s[i].substring(pIndex[0]+1,pIndex[1]),",");
        print("p",function +"(");
        String s2 = "";
        Class<?>[] parameterClasses = new Class<?>[parameters.length];
        Object[] parsedParameters = new Object[parameters.length];
        for(int j=0;j<parameters.length;j++){
          //print(parameters[j]);
          
          parameterClasses[j] = getParameterClass(parameters[j]);
          parsedParameters[j] = parseParameter(parameters[j]);
          // s2+=parameterClasses[j]+" "+parameters[j];
          s2 += parameters[j];
          if(j<parameters.length-1)s2+=",";
        }
        println(s2+")");
        
        update = true;
        try {
            Method method = this.getClass().getMethod(function, parameterClasses);
            method.invoke(this, parsedParameters);
            //println(method.getName());
          } catch (NoSuchMethodException e){println("nsm",function,parameterClasses[0]);}
            catch(IllegalAccessException e){println("ia");}
            catch( InvocationTargetException e){println("it");}
    }}
    update = false;
  }else if(a==null)update = false;
  
  if(keyPressed&&key =='r')update = true;
      
  };
  
  void func0(String function,String[] parameters){
    Method method = null;
      try {
        switch(parameters.length){
          case 1: method = this.getClass().getMethod(function,int.class);
          method.invoke(this, float(parameters[0]));
          println("result",parameters[0]);
          case 2: method = this.getClass().getMethod(function,float.class,int.class);
          method.invoke(this, float(parameters[0]));
          println("result",parameters[0]);
          case 3: method = this.getClass().getMethod(function,PImage.class,float.class,int.class);
          //method.invoke(this, float(parameters[0]));
          println("result",parameters[0]);
          case 4: method = this.getClass().getMethod(function);
          method.invoke(this);
        }
        
      } catch (SecurityException e) {
        println(function , "se");
      }catch (NoSuchMethodException e) {  
        println(function , "nsm");
      }
      catch (IllegalAccessException e) {  
        println(function , "nsm");
      }
      catch (InvocationTargetException e) {  
        println(function , "nsm");
      }
      for(int j=0;j<parameters.length;j++){
        
        float currentF = float(parameters[j]);
        
        if(currentF>-10000000&&currentF<10000000){
          println(function,"f " + currentF);
        }else println(function,"s " + parameters[j]);
        
      }
  };
  
  void func1(String function,int p){
    println(function,p);
    Method method = null;
      try {
        method = this.getClass().getMethod(function,int  .class);
        println(method);
        method.invoke(this, p);
        //println("result",result);
      } catch (SecurityException e) {
        println(function , "se f1");
      }catch (NoSuchMethodException e) {  
        println(function , "nsm f1");
      }
      catch (IllegalAccessException e) {  
        println(function , "ia f1");
      }
      catch (InvocationTargetException e) {  
        println(function , "it f1");
      }
  };
  
  void func2(String function,float p1,int p2){
    Method method = null;
      try {
        method = this.getClass().getMethod(function,float.class,int.class);
        //Img instance = new Img();
        
        method.invoke(this, p1,p2);
        //println("result",result);
        println(p1,p2);
      } catch (SecurityException e) {
        println(function , "se f2");
      }catch (NoSuchMethodException e) {  
        println(function , "nsm");
      }
      catch (IllegalAccessException e) {  
        println(function , "ia f2");
      }
      catch (InvocationTargetException e) {  
        println(function , "it f2");
      }
  };
  
  void func2(String function,PImage p1,float p2){
    Method method = null;
      try {
        method = this.getClass().getMethod(function,PImage.class,int.class);
        
        method.invoke(this, p1,p2);
        //println("result",result);
        println(p1,p2);
      } catch (SecurityException e) {
        println(function , "se f2b");
      }catch (NoSuchMethodException e) {  
        println(function , "nsm f2b");
      }
      catch (IllegalAccessException e) {  
        println(function , "ia f2b");
      }
      catch (InvocationTargetException e) {  
        println(function , "it f2b");
      }
  };
  
  void func3(String function,float p1,float p2,float p3){
    Method method = null;
      try {
        method = this.getClass().getMethod(function,float.class,float.class,int.class);
        //Img instance = new Img();
        
        method.invoke(this, p1,p2,p3);
        println(p1,p2);
      } catch (SecurityException e) {
        println(function , "se f3a");
      }catch (NoSuchMethodException e) {  
        println(function , "nsm f3a");
      }
      catch (IllegalAccessException e) {  
        println(function , "ia f3a");
      }
      catch (InvocationTargetException e) {  
        println(function , "it f3a");
      }
  };
  
  void func4(String function,PImage p1,PImage p2){
    Method method = null;
    boolean k = false;
      try {
        method = this.getClass().getMethod(function,PImage.class,PImage.class);
        //Img instance = new Img();
        
        method.invoke(this, p1,p2);
        println(p1,p2,"4a");
      } catch (SecurityException e) {
       println(function , "se f4ba");
      }catch (NoSuchMethodException e) {  
        println(function , "nsm f4ba");
        k = true;
      }catch (IllegalAccessException e) {  
        println(function , "ia f4ba");
      }catch (InvocationTargetException e) {  
        println(function , "it f4ba");
      }
      if(k){
        try {
          method = this.getClass().getMethod(function,PImage.class,PImage.class);
          
          method.invoke(this, p1,p2);
          //println(p1,p2,"3b");
        } catch (SecurityException e) {
         println(function , "se f4b");
        }catch (NoSuchMethodException e) {  
          println(function , "nsm f4b");
        }catch (IllegalAccessException e) {  
          println(function , "ia f4b");
        }catch (InvocationTargetException e) {  
          println(function , "it f4b");
        }
      }
  };
  
  void func3(String function,PImage p1,float p2,int p3){
    Method method = null;
    boolean k = false;
      try {
        method = this.getClass().getMethod(function,PImage.class,float.class,int.class);
        //Img instance = new Img();
        
        method.invoke(this, p1,p2,p3);
        println(p1,p2);
      } catch (SecurityException e) {
       println(function , "se f3b");
      }catch (NoSuchMethodException e) {  
        println(function , "nsm f3b");
        k = true;
      }catch (IllegalAccessException e) {  
        println(function , "ia f3b");
      }catch (InvocationTargetException e) {  
        println(function , "it f3b");
      }
      if(k){
        try {
          method = this.getClass().getMethod(function,PImage.class,float.class,float.class);
          //Img instance = new Img();
          
          method.invoke(this, p1,p2,p3);
          println(p1,p2,"3b");
        } catch (SecurityException e) {
         println(function , "se f3b");
        }catch (NoSuchMethodException e) {  
          println(function , "nsm f3b");
        }catch (IllegalAccessException e) {  
          println(function , "ia f3b");
        }catch (InvocationTargetException e) {  
          println(function , "it f3b");
        }
      }
  };
  
  void catch1(){
    
  };
  
  void reflection(){
    
  };
  
  float mult(float a,float b){
    return a * b;
  };
  
  //String[] split(String s,String s1){
  //  String[]S = splitTokens(s.substring(pIndex[0]+1,pIndex[1]),",");
  //  parameters[parameters.length-1] =  parameters[parameters.length-1].replaceAll(")s+","");
  //  return 
  //};
  
  int [] strIndex1(String s,String a,String b){
    int[]index = new int [2];
    for(int i=0;i<s.length();i++){
      char c = s.charAt(i);
      if(c=='(')index[0] = i;
      if(c==')')index[1] = i;
    }
    return index;
  };
  
  ArrayList [] strIndex(String s,String a,String b){
    ArrayList[]index = new ArrayList [2];
    index[0] = new ArrayList<Integer>();
    index[1] = new ArrayList<Integer>();
    for(int i=0;i<s.length();i++){
      char c = s.charAt(i);
      if(c=='(')index[0].add(i);
      if(c==')')index[1].add(i);
    }
    return index;
  };
  
  int findNext(String s){
    int a = -1;
    
    return a;
  };
  
  void set(PImage p){
    img = p;
  };

  void threshold(float a) {
    threshold = new PImage(img.width, img.height, RGB);
    img.loadPixels();
    threshold.loadPixels();
    if (mean==null) {
      for (int i=0; i<img.width; i++) {
        for (int j=0; j<img.height; j++) {
          int p = i + j * img.width;
          float b = brightness(img.pixels[p]);
          if (b>a)b = 0;
          threshold.pixels[p] = color(255-b);
        }
      }
    } else {
      //for (int i=0; i<mean.width; i++) {
      //  for (int j=0; j<mean.height; j++) {
      //    int p = i + j * mean.width;
      //    float b = brightness(mean.pixels[p]);
      //    //if (b>a)b = 0;
      //    threshold.pixels[p] = color(b);
      //  }
      //}
    }

    threshold.updatePixels();

    threshold.loadPixels();
    for (int i=0; i<img.pixels.length; i++) {
      float b = brightness(mean.pixels[i]);
      //println(b);
      //if (b<a)b=0;
      b = 255;

      threshold.pixels[i] = color(random(b));
      //threshold.pixels[i] = color(b);
    }
    threshold.updatePixels();
  };

  void threshold(PImage im,float a) {
    threshold = new PImage(im.width, im.height, RGB);
    threshold.loadPixels();
    im.loadPixels();

    for (int i=0; i<im.width; i++) {
      for (int j=0; j<im.height; j++) {
        
        int p = i + j * im.width;
        float b = brightness(im.pixels[p]);
        boolean k = getTMin(i,j,im,a);
        //b = 255;
        if (k)b = 0;
        else b = 255;
  
        threshold.pixels[p] = color((b));
    }}
    threshold.updatePixels();
  };
  
  boolean getTMin(int x, int y,PImage im,float t) {
    
    float []min = new float[2];
    min[0] = 255;
    
    boolean k = false;
    int p = x + y * im.width;
    
    for (int i=x-1; i<=x+1; i++) {
      for (int j=y-1; j<=y+1; j++) {
        
        int p1 = i+j*im.width;
        
        if(p1>0&&p1<im.pixels.length&&p1!=p){
          
          float c = brightness(im.pixels[p1]);
          
          if(min[0]>c){
            min[0] = c;
            min[1] = p1;
          }}}
    }
    
    int p1 = (int)min[1];
    
    float c = brightness(im.pixels[p]);
    float c2 = brightness(im.pixels[p1]);
    float t2 = 30;
    //println(min[0]);
    float d = abs((c)-c2);
    
    //if(c<=c2&&c<t||c2<t&&d<t2)k = true;
    //if(c<t&&(c<=c2)||c2<t&&(d<t2)||c2<t&&d<t2)k = true;
    //if(c<t&&(c>=c2)^c>t&&(d>t2)||c2<t&&d<t2)k = true;
    if(c2<c){
      if(c2<t+t2)k = true;
    }
    else{
      //if(c<t)k = true;
    }
    //println(c,k,t,t+t2);
    //println(c,c2,c<t,d<t2,t,k,d);
    //println(d<t2&&c2>c,c2<c,c,c2,k);
    return k;
    
  };

  void mean() {

    mean = new PImage(img.width, img.height, RGB);
    float mean_ = 0;
    img.loadPixels();
    for (int i=0; i<img.pixels.length; i++) {
      float b = brightness(img.pixels[i]);
      mean_ += b;
    }

    mean_ /= img.pixels.length;

    mean.loadPixels();
    for (int i=0; i<img.pixels.length; i++) {
      float b = brightness(img.pixels[i]);
      float a = mean_ - b;
      mean.pixels[i] = color(255-a);
    }

    mean.updatePixels();
    current = mean;
    images.add(current);
  };

  void mean(float k) {

    mean = new PImage(img.width, img.height, RGB);
    Mean = 0;
    img.loadPixels();
    for (int i=0; i<img.pixels.length; i++) {
      float b = brightness(img.pixels[i]);
      Mean += b;
    }

    Mean /= img.pixels.length;
    //Mean = k + Mean;

    mean.loadPixels();
    for (int i=0; i<img.pixels.length; i++) {
      float b = brightness(img.pixels[i]);
      float a = Mean - b;
      mean.pixels[i] = color(255-a);
    }

    mean.updatePixels();
    current = mean;
    images.add(current);
  };

  void mean(int a) {
    mean = new PImage(img.width, img.height, RGB);
    mean.loadPixels();
    mean_ = new PImage(img.width, img.height, RGB);
    mean_.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        //float b = brightness(img.pixels[p]);

        float []mn = getNeighboursMean(i, j, a);
        float m = mn[0];
        //println(mean_);
        float a1 = (red(img.pixels[p]) + green(img.pixels[p]) + blue(img.pixels[p]) + brightness(img.pixels[p]))/4;
        float a2 = red(img.pixels[p]);
        float a3 = green(img.pixels[p]);
        float a4 = blue(img.pixels[p]);

        float a5 = brightness(img.pixels[p]);
        //println(mean_ - b);

        //img.pixels[p] = color(b);
        //float k = mean_*mean_*mean_*mean_*mean_ -(-mean_ -a1)*(-mean_ +a1)*(-mean_ -a2)*(-mean_ +a2)*(-mean_ -a3)*(-mean_ +a3)*(-mean_ -a4)*(-mean_ +a4)*(-mean_ -a5)*(-mean_ +a5);
        //mean.pixels[p] = color((255)-k);
        //if ((mean_ -b)<20)
        //mean.pixels[p] = color(255-(mean_ -(-mean_ -a1)));
        //mean.pixels[p] = color(255-(mean_*mean_ -(-mean_ -a1)));
        mean_.pixels[p] = color(255-(m - a5));
        mean.pixels[p] = color(255-(m - a5)*25);
        //mean.pixels[p] = color(0);
        //mean.pixels[p] = color(random(255));
        //else mean.pixels[p] = color(255);
      }
    }
    mean.updatePixels();
    current = mean;
    images.add(current);
  };
  
  void mean(PImage img,int a) {
    mean = new PImage(img.width, img.height, RGB);
    mean.loadPixels();
    mean_ = new PImage(img.width, img.height, RGB);
    mean_.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        //float b = brightness(img.pixels[p]);

        float []mn = getNeighboursMean(i, j, a,img);
        float m = mn[0];
        //println(mean_);
        float a1 = (red(img.pixels[p]) + green(img.pixels[p]) + blue(img.pixels[p]) + brightness(img.pixels[p]))/4;
        float a2 = red(img.pixels[p]);
        float a3 = green(img.pixels[p]);
        float a4 = blue(img.pixels[p]);

        float a5 = brightness(img.pixels[p]);
        //println(mean_ - b);

        //img.pixels[p] = color(b);
        //float k = mean_*mean_*mean_*mean_*mean_ -(-mean_ -a1)*(-mean_ +a1)*(-mean_ -a2)*(-mean_ +a2)*(-mean_ -a3)*(-mean_ +a3)*(-mean_ -a4)*(-mean_ +a4)*(-mean_ -a5)*(-mean_ +a5);
        //mean.pixels[p] = color((255)-k);
        //if ((mean_ -b)<20)
        //mean.pixels[p] = color(255-(mean_ -(-mean_ -a1)));
        //mean.pixels[p] = color(255-(mean_*mean_ -(-mean_ -a1)));
        mean_.pixels[p] = color(255-(m - a5));
        mean.pixels[p] = color(255-(m - a5)*25);
        //mean.pixels[p] = color(0);
        //mean.pixels[p] = color(random(255));
        //else mean.pixels[p] = color(255);
      }
    }
    mean.updatePixels();
    current = mean;
    images.add(current);
  };
  
  void mean(float mult,int a) {
    mean = new PImage(img.width, img.height, RGB);
    mean.loadPixels();
    mean_ = new PImage(img.width, img.height, RGB);
    mean_.loadPixels();
    meanGx = new PImage(img.width, img.height, RGB);
    meanGx.loadPixels();
    meanGy = new PImage(img.width, img.height, RGB);
    meanGy.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        //float b = brightness(img.pixels[p]);

        float []mn = getNeighboursMean(i, j, a);
        float m = mn[0];
        float mx = mn[1];
        float my = mn[2];
        //println(mean_);
        float a1 = (red(img.pixels[p]) + green(img.pixels[p]) + blue(img.pixels[p]) + brightness(img.pixels[p]))/4;
        float a2 = red(img.pixels[p]);
        float a3 = green(img.pixels[p]);
        float a4 = blue(img.pixels[p]);

        float a5 = brightness(img.pixels[p]);
        //println(mean_ - b);

        //img.pixels[p] = color(b);
        //float k = mean_*mean_*mean_*mean_*mean_ -(-mean_ -a1)*(-mean_ +a1)*(-mean_ -a2)*(-mean_ +a2)*(-mean_ -a3)*(-mean_ +a3)*(-mean_ -a4)*(-mean_ +a4)*(-mean_ -a5)*(-mean_ +a5);
        //mean.pixels[p] = color((255)-k);
        //if ((mean_ -b)<20)
        //mean.pixels[p] = color(255-(mean_ -(-mean_ -a1)));
        //mean.pixels[p] = color(255-(mean_*mean_ -(-mean_ -a1)));
        mean_.pixels[p] = color(255-(m - a5));
        mean.pixels[p] = color(255-(m - a5)*mult);
        meanGx.pixels[p] = color(mx);
        meanGy.pixels[p] = color(my);
        //mean.pixels[p] = color(0);
        //mean.pixels[p] = color(random(255));
        //else mean.pixels[p] = color(255);
      }
    }
    mean.updatePixels();
    current = mean;
    images.add(current);
  };
  
  void mean(PImage img,float mult,int a) {
    mean = new PImage(img.width, img.height, RGB);
    mean.loadPixels();
    mean_ = new PImage(img.width, img.height, RGB);
    mean_.loadPixels();
    meanGx = new PImage(img.width, img.height, RGB);
    meanGx.loadPixels();
    meanGy = new PImage(img.width, img.height, RGB);
    meanGy.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        //float b = brightness(img.pixels[p]);

        float []mn = getNeighboursMean(i, j, a,img);
        float m = mn[0];
        float mx = mn[1];
        float my = mn[2];
        //println(mean_);
        float a1 = (red(img.pixels[p]) + green(img.pixels[p]) + blue(img.pixels[p]) + brightness(img.pixels[p]))/4;
        float a2 = red(img.pixels[p]);
        float a3 = green(img.pixels[p]);
        float a4 = blue(img.pixels[p]);

        float a5 = brightness(img.pixels[p]);
        //println(mean_ - b);

        //img.pixels[p] = color(b);
        //float k = mean_*mean_*mean_*mean_*mean_ -(-mean_ -a1)*(-mean_ +a1)*(-mean_ -a2)*(-mean_ +a2)*(-mean_ -a3)*(-mean_ +a3)*(-mean_ -a4)*(-mean_ +a4)*(-mean_ -a5)*(-mean_ +a5);
        //mean.pixels[p] = color((255)-k);
        //if ((mean_ -b)<20)
        //mean.pixels[p] = color(255-(mean_ -(-mean_ -a1)));
        //mean.pixels[p] = color(255-(mean_*mean_ -(-mean_ -a1)));
        mean_.pixels[p] = color(255-(m - a5));
        mean.pixels[p] = color(255-(m - a5)*mult);
        meanGx.pixels[p] = color(mx);
        meanGy.pixels[p] = color(my);
        //mean.pixels[p] = color(0);
        //mean.pixels[p] = color(random(255));
        //else mean.pixels[p] = color(255);
      }
    }
    meanGx.updatePixels();
    meanGy.updatePixels();
    current = mean;
    images.add(current);
  };

  void mean_(int a) {
    mean = new PImage(img.width, img.height, RGB);

    mean.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;

        float []mean_ = getNeighboursMean(i, j, a);
        float m = mean_[0];
        //println(mean_);
        //float b = brightness(img.pixels[p]);
        //println(mean_ - b);

        //img.pixels[p] = color(b);
        //if ((mean_ -b)<20)
        float k = m-((m)/(b)*(m)/(b)) *((m)*(b)/(m));
        //k = m*m - (m-b)*(m-b);
        //println(k);
        //k = m - b;
        float t1 = (k);
        //k = (m*m -t1*t1);
        float t = 2.0;
        //k = 2.0 / (1.0 + exp(-2.0 * k)) - 1.0;
        k = t/ (1.0 + exp(-t * (k))) - 1.0;

        mean.pixels[p] = color(k*255);
        //mean

        //mean.pixels[p] = color(b);
        //else mean.pixels[p] = color(255);
      }
    }
    mean.updatePixels();
    current = mean;
    images.add(current);
  };


  void meanR(int a) {
    mean = new PImage(img.width, img.height, RGB);
    img.loadPixels();

    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = brightness(img.pixels[p]);
        img.pixels[p] = color(b);
      }
    }
    current = mean;
    images.add(current);
  };

  void meanG(int a) {
    mean = new PImage(img.width, img.height, RGB);
    img.loadPixels();

    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = brightness(img.pixels[p]);
        img.pixels[p] = color(b);
      }
    }
    current = mean;
    images.add(current);
  };

  void meanB(int a) {
    mean = new PImage(img.width, img.height, RGB);
    img.loadPixels();

    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = brightness(img.pixels[p]);
        img.pixels[p] = color(b);
      }
    }
    current = mean;
    images.add(current);
  };

  void meanRGB() {
    mean = new PImage(img.width, img.height, RGB);
    float mean_ = 0;
    img.loadPixels();
    for (int i=0; i<img.pixels.length; i++) {
      float b = brightness(img.pixels[i]);
      mean_ += b;
    }

    mean_ /= img.pixels.length;
    mean_ = 150 +mean_;

    mean.loadPixels();
    for (int i=0; i<img.pixels.length; i++) {
      float r = red(img.pixels[i]);
      float g = green(img.pixels[i]);
      float b = blue(img.pixels[i]);
      float br = brightness(img.pixels[i]);
      float a = mean_ - (r+g+b+br)/4;
      mean.pixels[i] = color(255-a);
    }

    mean.updatePixels();
    current = mean;
    images.add(current);
  };

  void localMean() {
    mean = new PImage(img.width, img.height, RGB);
    img.loadPixels();

    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = brightness(img.pixels[p]);
      }
    }
  };

  void kMeans() {
    kMeans = new PImage(img.width, img.height, RGB);
    img.loadPixels();

    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        //float b = map(brightness(img.pixels[p]),0,255,0,100);
        float b = brightness(img.pixels[p]);
        img.pixels[p] = color(b);
      }
    }
  };

  void kNearest(float a) {
    variance = new PImage(img.width, img.height, RGB);
    img.loadPixels();

    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = brightness(img.pixels[p]);

        img.pixels[p] = color(b);
      }
    }
  };

  void variance() {
    variance = new PImage(img.width, img.height, RGB);
    img.loadPixels();

    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float var = getNeighboursVar(0, 0, 0);
        float a1 = red(img.pixels[p]);
        float a2 = green(img.pixels[p]);
        float a3 = blue(img.pixels[p]);
        float a4 = brightness(img.pixels[p]);

        float a = var*var*var*var - ((((var)) + (var - a2))*(((var)) + (var + a3))*(((var)) - (var + a4))*(((var)) + (var + a1)))-255;
        variance.pixels[p] = color(255-a);
      }
    }
    current = variance;
    images.add(current);
  };

  void variance(int a) {
    variance = new PImage(img.width, img.height, RGB);
    img.loadPixels();
    variance.loadPixels();

    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float var = getNeighboursVar(i, j, a);
        //float a1 = (red(img.pixels[p]) + green(img.pixels[p]) + blue(img.pixels[p]) + brightness(img.pixels[p]))/4;
        float a1 = (red(mean.pixels[p]) + green(mean.pixels[p]) + blue(mean.pixels[p]) + brightness(mean.pixels[p]))/4;
        float a2 = red(mean.pixels[p]);
        float a3 = green(mean.pixels[p]);
        float a4 = blue(mean.pixels[p]);
        float a5 = brightness(mean.pixels[p]);


        float k = var*4;
        float r = sqrt((var + ( var - a1)) * a1 + (var + ( var - a2)) * a2 + (var + ( var - a3)) * a3 + (var + ( var - a4)) * a4);
        //float r = var*var*var - (var + a1)*(var - a1)*(var + a2)*(var - a2)*(var + a3)*(var - a3)*(var + a4)*(var - a4)*(var + a5)*(var - a5);
        //float r = var*var*var*var*var*var*var*var*var - (var + a1)*(var - a1)*(var + a2)*(var - a2)*(var + a3)*(var - a3)*(var + a4)*(var - a4)*(var + a5)*(var - a5);
        //float r = var*var*var*var*var*var*var*var*var - (-var + a1)*(-var - a1)*(-var + a2)*(-var - a2)*(-var + a3)*(-var - a3)*(-var + a4)*(-var - a4)*(-var + a5)*(-var - a5);
        //println(k);
        //r = ((var-brightness(mean.pixels[p]))*20);
        //r = var;
        r = (var*var-(var - a5)*(var + a5));
        //r = var+a1;
        //println(r);
        //println(var,r);
        variance.pixels[p] = color(r);
      }
    }
    variance.updatePixels();
    current = variance;
    images.add(current);
  };
  
  void variance(PImage imgg,int a) {
    variance = new PImage(img.width, img.height, RGB);
    img.loadPixels();
    variance.loadPixels();

    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float var = getNeighboursVar(i, j, a,imgg);
        //float a1 = (red(img.pixels[p]) + green(img.pixels[p]) + blue(img.pixels[p]) + brightness(img.pixels[p]))/4;
        float a1 = (red(mean.pixels[p]) + green(mean.pixels[p]) + blue(mean.pixels[p]) + brightness(mean.pixels[p]))/4;
        float a2 = red(img.pixels[p]);
        float a3 = green(img.pixels[p]);
        float a4 = blue(img.pixels[p]);
        float a5 = brightness(img.pixels[p]);
        float a6 = (red(img.pixels[p]) + green(img.pixels[p]) + blue(img.pixels[p]) + brightness(img.pixels[p]))/4;
        float a7 = (red(imgg.pixels[p]) + green(imgg.pixels[p]) + blue(imgg.pixels[p]) + brightness(imgg.pixels[p]))/4;
        float a8 = 0, a9 = 0;
        //if(mean==null)a1 = a6;
        if(sobel2!=null)a8 = (red(sobel2.pixels[p]) + green(sobel2.pixels[p]) + blue(sobel2.pixels[p]) + brightness(sobel2.pixels[p]))/4;


        float k = var*4;
        //float r = sqrt((var + ( var - a1)) * a1 + (var + ( var - a2)) * a2 + (var + ( var - a3)) * a3 + (var + ( var - a4)) * a4);
        //float r = var*var*var - (var + a1)*(var - a1)*(var + a2)*(var - a2)*(var + a3)*(var - a3)*(var + a4)*(var - a4)*(var + a5)*(var - a5);
        //float r = var*var*var*var*var*var*var*var*var - (var + a1)*(var - a1)*(var + a2)*(var - a2)*(var + a3)*(var - a3)*(var + a4)*(var - a4)*(var + a5)*(var - a5);
        //float r = var*var*var*var*var*var*var*var*var - (-var + a1)*(-var - a1)*(-var + a2)*(-var - a2)*(-var + a3)*(-var - a3)*(-var + a4)*(-var - a4)*(-var + a5)*(-var - a5);
        //println(k);
        //r = ((var-brightness(mean.pixels[p]))*20);
        //r = var;
        //float r = sqrt(var*var-(var - a1)*(var - a6)+a5*a5);
        float r = sqrt(var + (a1));
        //float r = (var/2 + (a8+a7)/2 );
        // for combined sobel;
        //float r = (var/2 + (a7+a1)/2.5 );
        //float r = (var -a1);
        //blur filters-----------------------------------
        //float r = sqrt((var * var - ( var - a1)*(var + a1))-a1*a1);
        //float r = sqrt((var * var - ( var - a1)*(var - a1)))-a1*a1;
        //-------------------------------------
        
        //r/=10;
        //if(r<200)r=0;
        //else r = 255;
        //else r = 255;
        //
        //r += a6;
        //float r = (var - a1);
        //println(r);
        //println(var,r);
        variance.pixels[p] = color((r));
      }
    }
    variance.updatePixels();
    current = variance;
    images.add(current);
  };

  void variance(int a, int n) {
    variance = new PImage(img.width, img.height, RGB);
    img.loadPixels();
    //variance.loadPixels();
    Variance = 0;
    for (int i=0; i<img.pixels.length; i++) {
      float a1 = (red(img.pixels[i]) + green(img.pixels[i]) + blue(img.pixels[i]) + brightness(img.pixels[i]))/4;
      float a2 = (red(mean.pixels[i]) + green(mean.pixels[i]) + blue(mean.pixels[i]) + brightness(mean.pixels[i]))/4;
      //float a2 = (red(threshold.pixels[i]) + green(threshold.pixels[i]) + blue(threshold.pixels[i]) + brightness(threshold.pixels[i]))/4;
      //a2 = brightness(mean.pixels[i]);
      //println("mean " + i + " " + a2);
      Variance += (a2 - a1);
      //float a1 = red(img.pixels[p]);
      //float a2 = green(img.pixels[p]);
      //float a3 = blue(img.pixels[p]);
      //float a4 = brightness(img.pixels[p]);

      //float k = var*4;
      //float r = (var + ( var - a1)) * a1 + (var + ( var - a2)) * a2 + (var + ( var - a3)) * a3 + (var + ( var - a4)) * a4;
      ////println(k);
      ////println(var,r);
      //variance.pixels[p] = color(255-(k-r));
    }
    //variance.updatePixels();
    Variance /= img.pixels.length;
    //Variance = sqrt(Variance);
    //var = abs(var);
    println("Variance " + Variance);
    variance.loadPixels();
    img.loadPixels();
    println(Variance);
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float m = brightness(mean.pixels[p]);
        //float a1 = red(img.pixels[p]);
        float a1 = (red(img.pixels[p]) + green(img.pixels[p]) + blue(img.pixels[p]) + brightness(img.pixels[p]))/4;
        //float a1 = (red(mean.pixels[p]) + green(mean.pixels[p]) + blue(mean.pixels[p]) + brightness(mean.pixels[p]))/4;
        float a2 = red(img.pixels[p]);
        float a3 = green(img.pixels[p]);
        float a4 = blue(img.pixels[p]);
        float a5 = brightness(img.pixels[p]);

        float k = Variance*4;
        //float r = sqrt(Variance*Variance - a5*a5);
        float r = Variance*Variance - (Variance - a1)*(Variance + a2);
        //float b = Variance*Variance*Variance*Variance -((((Variance+a1)) + (Variance - a2))*(((Variance)) + (Variance + a3))*(((Variance)) + (Variance + a4))*((Variance) + (Variance + a1)))-255;
        //println(r);
        ////println(Variance,r);
        variance.pixels[p] = color(r);
      }
    }
    variance.updatePixels();
    current = variance;
    images.add(current);
  };

  void variance2(int a) {
    variance = new PImage(img.width, img.height, RGB);
    variance.loadPixels();
    varianceR = new PImage(img.width, img.height, RGB);
    varianceR.loadPixels();
    varianceG = new PImage(img.width, img.height, RGB);
    varianceG.loadPixels();
    varianceB = new PImage(img.width, img.height, RGB);
    varianceB.loadPixels();
    img.loadPixels();

    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float []v = getNeighboursVar2(i, j, a);
        float a1 = (red(img.pixels[p]) + green(img.pixels[p]) + blue(img.pixels[p]) + brightness(img.pixels[p]))/4;
        //float a1 = (red(mean.pixels[p]) + green(mean.pixels[p]) + blue(mean.pixels[p]) + brightness(mean.pixels[p]))/4;
        float a2 = red(img.pixels[p]);
        float a3 = green(img.pixels[p]);
        float a4 = blue(img.pixels[p]);
        float a5 = brightness(img.pixels[p]);
        
        float var = v[0];

        float k = var*4;
        //float r = (var + ( var - a1)) * a1 + (var + ( var - a2)) * a2 + (var + ( var - a3)) * a3 + (var + ( var - a4)) * a4;
        //float r = var*var*var - (var + a1)*(var - a1)*(var + a2)*(var - a2)*(var + a3)*(var - a3)*(var + a4)*(var - a4)*(var + a5)*(var - a5);
        //float r = var*var*var*var*var*var*var*var*var - (var + a1)*(var - a1)*(var + a2)*(var - a2)*(var + a3)*(var - a3)*(var + a4)*(var - a4)*(var + a5)*(var - a5);
        //float r = var*var*var*var*var*var*var*var*var - (-var + a1)*(-var - a1)*(-var + a2)*(-var - a2)*(-var + a3)*(-var - a3)*(-var + a4)*(-var - a4)*(-var + a5)*(-var - a5);
        //println(k);
        //println(var,r);
        variance.pixels[p] = color((k));
      }
    }
    variance.updatePixels();
    current = variance;
    images.add(current);
  };

  void kNearest() {
    variance = new PImage(img.width, img.height, RGB);
    img.loadPixels();

    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = brightness(img.pixels[p]);

        img.pixels[p] = color(b);
      }
    }
  };
  
  void combine(PImage a,PImage b){
    combined = new PImage(img.width, img.height, RGB);
    combined.loadPixels();
    for (int i=0; i<img.pixels.length; i++) {
      
      float b1 = brightness(a.pixels[i]);
      float b2 = brightness(b.pixels[i]);
      
      if(b1<b2)combined.pixels[i] = color(b1);
      else combined.pixels[i] = color(b2);
      
    }
    combined.updatePixels();
    current = combined;
    images.add(current);
  };

  void blur(int a) {
    blur = new PImage(img.width, img.height, RGB);
    //sobelG = new PImage(img.width, img.height, RGB);
    blur.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float mean = getNeighboursBlur(i, j, a);
        float b = brightness(img.pixels[p]);
        //blur.pixels[p] = color(255-(mean*(mult2)-b));
        blur.pixels[p] = color(mean);
        //sobelG.pixels[p] = color((gradient[i][j]*100));
        //println(gradient[i][j],green(sobelG.pixels[p]));
      }
    }
    blur.updatePixels();
    current = blur;
    images.add(current);
  };
  
  void blur(PImage img,int a) {
    blur = new PImage(img.width, img.height, RGB);
    //sobelG = new PImage(img.width, img.height, RGB);
    blur.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float mean = getNeighboursBlur(i, j, a,img);
        float b = brightness(img.pixels[p]);
        //blur.pixels[p] = color(255-(mean*(mult2)-b));
        blur.pixels[p] = color(mean);
        //sobelG.pixels[p] = color((gradient[i][j]*100));
        //println(gradient[i][j],green(sobelG.pixels[p]));
      }
    }
    blur.updatePixels();
    current = blur;
    images.add(current);
  };
  
  void blurS(int a) {
    blur = new PImage(img.width, img.height, RGB);
    blurX = new PImage(img.width, img.height, RGB);
    blurY = new PImage(img.width, img.height, RGB);
    blur.loadPixels();
    blurX.loadPixels();
    blurY.loadPixels();
    //gradientB = new PImage(img.width, img.height, RGB);
    //gradientB.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = brightness(img.pixels[p]);
        float bx = getNeighboursBlurX(i, j, a);
        float by = getNeighboursBlurY(i, j, a);
        blur.pixels[p] = color(((bx+by)/2));
      }
    }
    blur.updatePixels();
    blurX.updatePixels();
    blurY.updatePixels();
    current = blur;
    images.add(current);
  };
  
  void blurS(PImage img,int a) {
    blur = new PImage(img.width, img.height, RGB);
    blurX = new PImage(img.width, img.height, RGB);
    blurY = new PImage(img.width, img.height, RGB);
    blur.loadPixels();
    blurX.loadPixels();
    blurY.loadPixels();
    //gradientB = new PImage(img.width, img.height, RGB);
    //gradientB.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = brightness(img.pixels[p]);
        float bx = getNeighboursBlurX(i, j, a,img);
        float by = getNeighboursBlurY(i, j, a,img);
        blur.pixels[p] = color(((bx+by)/2));
      }
    }
    blur.updatePixels();
    blurX.updatePixels();
    blurY.updatePixels();
    current = blur;
    images.add(current);
  };
  
  void gaussian3(){
    Gaussian = new PImage(img.width,img.height,ARGB);
    Gaussian.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = brightness(img.pixels[p]);
        float v = getGaussian3(i, j);
        //println(v);
        Gaussian.pixels[p] = color(v);
      }
    }
    Gaussian.updatePixels();
    
  };
  
  float getGaussian3(int x,int y){
    float val = 0;
    float v = 0;
    int z = 1;
    img.loadPixels();
    
    int count = 0;
    
    int p1 = x + y * img.width;
    float b1 = (red(img.pixels[p1])+green(img.pixels[p1])+blue(img.pixels[p1])+brightness(img.pixels[p1]))/4;
    
    for (int i=x-z; i<=x+z; i++) {
      for (int j=y-z; j<=y+z; j++) {

        int p = i + j * img.width;
        if (p>0&&p<img.pixels.length) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
          
          int x1 = 0 + i - x + 1;
          int y1 = 0 + j - y + 1;
          
          float col = brightness(img.pixels[p]);
          col = b;
          
          v += gaussian3[x1][y1] * col;
          //println(gaussian3[x1][y1]);
          }
          count ++;
        }
      }
    
    v/= 2;
    v/= count;
    
    return v;
  };
  
  void gaussian3(PImage img){
    Gaussian = new PImage(img.width,img.height,ARGB);
    Gaussian.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = brightness(img.pixels[p]);
        float v = getGaussian3(i, j,img);
        Gaussian.pixels[p] = color(v);
      }
    }
    Gaussian.updatePixels();
    
  };
  
  float getGaussian3(int x,int y, PImage img){
    float val = 0;
    float v = 0;
    int z = 1;
    img.loadPixels();
    
    int count = 0;
    
    int p1 = x + y * img.width;
    float b1 = (red(img.pixels[p1])+green(img.pixels[p1])+blue(img.pixels[p1])+brightness(img.pixels[p1]))/4;
    
    for (int i=x-z; i<=x+z; i++) {
      for (int j=y-z; j<=y+z; j++) {

        int p = i + j * img.width;
        if (p>0&&p<img.pixels.length) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
          
          int x1 = 0 + i - x + 1;
          int y1 = 0 + j - y + 1;
          
          float col = brightness(img.pixels[p]);
          col = b;
          
          v += gaussian3[x1][y1] * col;
          }
          count ++;
        }
      }
    v/= 16;
    v/= count;
    return v;
  };
  
  void gaussian5(){
    Gaussian = new PImage(img.width,img.height,ARGB);
    Gaussian.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = brightness(img.pixels[p]);
        float v = getGaussian5(i, j);
        Gaussian.pixels[p] = color(v);
      }
    }
    Gaussian.updatePixels();
  };
  
  float getGaussian5(int x,int y){
    float val = 0;
    float v = 0;
    int z = 2;
    img.loadPixels();
    
    int count = 0;
    
    int p1 = x + y * img.width;
    float b1 = (red(img.pixels[p1])+green(img.pixels[p1])+blue(img.pixels[p1])+brightness(img.pixels[p1]))/4;
    
    for (int i=x-z; i<=x+z; i++) {
      for (int j=y-z; j<=y+z; j++) {

        int p = i + j * img.width;
        if (p>0&&p<img.pixels.length) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
          
          int x1 = 0 + (i - x) + z;
          int y1 = 0 + j - y + z;
          //println(x1);
          //if(x1 == -1)x1 = 4;
          //if(y1 == -1)y1 = 4;
          float col = brightness(img.pixels[p]);
          col = b;
          
          v += gaussian5[x1][y1] * col;
          }
          count ++;
        }
      }
    v/= 273;
    v/= count;
    return v;
  };
  
  void gaussian5(PImage img){
    Gaussian = new PImage(img.width,img.height,ARGB);
    Gaussian.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = brightness(img.pixels[p]);
        float v = getGaussian5(i, j,img);
        Gaussian.pixels[p] = color(v);
      }
    }
    Gaussian.updatePixels();
  };
  
  float getGaussian5(int x,int y, PImage img){
    float val = 0;
    float v = 0;
    int z = 2;
    img.loadPixels();
    
    int count = 0;
    
    int p1 = x + y * img.width;
    float b1 = (red(img.pixels[p1])+green(img.pixels[p1])+blue(img.pixels[p1])+brightness(img.pixels[p1]))/4;
    
    for (int i=x-z; i<=x+z; i++) {
      for (int j=y-z; j<=y+z; j++) {

        int p = i + j * img.width;
        if (p>0&&p<img.pixels.length) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
          
          int x1 = 0 + i - x + z;
          int y1 = 0 + j - y + z;
          
          float col = brightness(img.pixels[p]);
          col = b;
          
          v += gaussian5[x1][y1] * col;
          }
          count ++;
        }
      }
    v/= 273;
    v/= count;
    return v;
  };
  
  float getNeighboursBlur(int x, int y,int a){
    float mean = 0;
    int count = 0;
    for (int i=x-a; i<=x+a; i++) {
      for (int j=y-a; j<=y+a; j++) {
        int p = i + j * img.width;
        if (p<img.pixels.length&&p>0) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
          mean += brightness(img.pixels[p]);
          count++;
      }}
    }
    mean /= count;
    return mean;
  };
  
  float getNeighboursBlur(int x, int y,int a,PImage img){
    float mean = 0;
    int count = 0;
    for (int i=x-a; i<=x+a; i++) {
      for (int j=y-a; j<=y+a; j++) {
        int p = i + j * img.width;
        if (p<img.pixels.length&&p>0) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
          mean += brightness(img.pixels[p]);
          count++;
      }}
    }
    mean /= count;
    return mean;
  };

  float getNeighboursBlurX(int x, int y,int a){
    float mean = 0;
    int count = 0;
    int count2 = 0;
    for (int i=x-a; i<=x+a; i++) {
        int p = (i) + y * img.width;
        count2++;
        int n = (y-a+count);
        float k = (a-abs(n-y));
        k = 2.0 / (1.0 + exp(-2.0 * k)) - 1.0;
        //println(k);
        //k = 1;
        int p1 = (i) + (n) * img.width;
        if (p<img.pixels.length&&p>0&&p1>0&&p1<img.pixels.length) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
           mean += (brightness(img.pixels[p])+brightness(img.pixels[p1])*k)/2;
           count++;
      }
    }
    int p = x + y * img.width;
    blurX.pixels[p] = color(mean);
    return mean/count;
  };
  
  float getNeighboursBlurX(int x, int y,int a,PImage img){
    float mean = 0;
    int count = 0;
    int count2 = 0;
    for (int i=x-a; i<=x+a; i++) {
        int p = (i) + y * img.width;
        count2++;
        int n = (y-a+count);
        float k = (a-abs(n-y));
        k = 2.0 / (1.0 + exp(-2.0 * k)) - 1.0;
        //println(k);
        //k = 1;
        int p1 = (i) + (n) * img.width;
        if (p<img.pixels.length&&p>0&&p1>0&&p1<img.pixels.length) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
           mean += (brightness(img.pixels[p])+brightness(img.pixels[p1])*k)/(2);
           count++;
      }
    }
    int p = x + y * img.width;
    blurX.pixels[p] = color(mean);
    return mean/count;
  };
  
  float getNeighboursBlurY(int x, int y,int a){
    float mean = 0;
    int count = 0;
    int count2 = 0;
    //print("h");
      for (int j=y-a; j<=y+a; j++) {
        int p = x + (j) * img.width;
        int n = (x-a+count);
        float k = (a-abs(n-x));
        k = 2.0 / (1.0 + exp(-2.0 * k)) - 1.0;
        //k = 1;
        int p1 = (n) + (j) * img.width;
        
        if (p<img.pixels.length&&p>0&&p1>0&&p1<img.pixels.length) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
           mean += (brightness(img.pixels[p])+ brightness(img.pixels[p1])*k)/2;
           count++;
      }
    }
    int p = x + y * img.width;
    blurX.pixels[p] = color(mean);
    return mean/count;
    //return sqrt(mean*mean);
  };
  
  float getNeighboursBlurY(int x, int y,int a,PImage img){
    float mean = 0;
    int count = 0;
    int count2 = 0;
    //print("h");
      for (int j=y-a; j<=y+a; j++) {
        int p = x + (j) * img.width;
        int n = (x-a+count);
        float k = (a-abs(n-x));
        k = 2.0 / (1.0 + exp(-2.0 * k)) - 1.0;
        //k = 1;
        int p1 = (n) + (j) * img.width;
        
        if (p<img.pixels.length&&p>0&&p1>0&&p1<img.pixels.length) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
           mean += (brightness(img.pixels[p])+brightness(img.pixels[p1])*k)/2;
           count++;
      }
    }
    int p = x + y * img.width;
    blurX.pixels[p] = color(mean);
    return mean/count;
    //return sqrt(mean*mean);
  };

  void getNeighboursAv(int x, int y) {
    for (int i=x-1; i<=x+1; i++) {
      for (int j=y-1; j<=y+1; j++) {
      }
    }
  };

  float[] getNeighboursMean(int x, int y, int a) {
    float mean = 0;
    int count = 0;
    int count2 = 0;
    float mx = 0;
    float my = 0;
    for (int i=x-a; i<=x+a; i++) {
      for (int j=y-a; j<=y+a; j++) {
        int p = i + j * img.width;
        if (p<img.pixels.length&&p>0) {
          mean += brightness(img.pixels[p]);
          count++;
          if (brightness(img.pixels[p])>10)count2++;
          
          int x1 = 0 + i - x + 1;
          int y1 = 0 + j - y + 1;
          if(x1>=0&&x1<3&&y1>=0&&y1<3){
            mx += meanX[x1][y1];
            my += meanY[x1][y1];
          }
        }
      }
    }
    mean /= count;
    mx /= count;
    my /= count;
    float []val = {mean,mx,my};
    return val;
  };
  
  float []getNeighboursMean(int x, int y, int a,PImage img) {
    float mean = 0;
    int count = 0;
    int count2 = 0;
    float mx = 0;
    float my = 0;
    for (int i=x-a; i<=x+a; i++) {
      for (int j=y-a; j<=y+a; j++) {
        int p = i + j * img.width;
        if (p<img.pixels.length&&p>0) {
          mean += brightness(img.pixels[p]);
          count++;
          int x1 = 0 + i - x + 1;
          int y1 = 0 + j - y + 1;
          //println(x1);
          
          if(x1>=0&&x1<3&&y1>=0&&y1<3){
            mx += meanX[x1][y1] * brightness(img.pixels[p]);
            my += meanY[x1][y1] * brightness(img.pixels[p]);
            //println(
            //count++;
          }
        }
      }
    }
    
    mean /= count;
    mx /= count;
    my /= count;
    //println(mx,my,count2);
    float []val = {mean,mx,my};
    return val;
  };

  float getNeighboursMean_(int x, int y, int a) {
    float mean = 0;
    int count = 0;
    int count2 = 0;
    int p1 = x + y * img.width;
    float b1 = (red(img.pixels[p1])+green(img.pixels[p1])+blue(img.pixels[p1])+brightness(img.pixels[p1]))/4;
    float k = 40;
    for (int i=x-a; i<=x+a; i++) {
      for (int j=y-a; j<=y+a; j++) {
        int p = i + j * img.width;
        if (p<img.pixels.length&&p>0) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
          if (abs(b1-b)<k
            //if(abs(red(img.pixels[p1])-red(img.pixels[p]))<k
            //  ||abs(green(img.pixels[p1])-red(img.pixels[p]))>k
            //  ||abs(blue(img.pixels[p1])-red(img.pixels[p]))<k
            ) {
            //if(true){
            mean += brightness(img.pixels[p]);
            //mean += b;
            count2++;
          } else mean += 15;
          //else mean -=20;
          count++;
        }
      }
    }
    //if (count2<(a*2*a*2)/(a*4)) mean = 1;
    if (mean<k*(a*2*a*2)) mean = 0;
    //if(count2>8) mean = 0;
    return mean/count;
  };

  float getNeighboursVar(int x, int y, int a) {
    float variance = 0;
    int count = 0;
    int count2 = 0;
    for (int i=x-a; i<=x+a; i++) {
      for (int j=y-a; j<=y+a; j++) {
        int p = i + j * img.width;
        if (p<img.pixels.length&&p>0) {
          float a1 = 0;
          if(threshold==null){
            a1 = (red(mean.pixels[p]) + green(mean.pixels[p]) + blue(mean.pixels[p]) + brightness(mean.pixels[p]))/4;
            a1 = brightness(mean.pixels[p]);
          }else a1 = (red(threshold.pixels[p]) + green(threshold.pixels[p]) + blue(threshold.pixels[p]) + brightness(threshold.pixels[p]))/4;
          float a2 = (red(img.pixels[p]) + green(img.pixels[p]) + blue(img.pixels[p]) + brightness(img.pixels[p]))/4;
          //variance += brightness(threshold.pixels[p]) - brightness(img.pixels[p]);
          variance += a2-a1;

          count++;
        }
      }
    }
    return sqrt((variance*variance)/count);
  };

  float getNeighboursVar(int x, int y, int a,PImage mean) {
    float variance = 0;
    int count = 0;
    int count2 = 0;
    for (int i=x-a; i<=x+a; i++) {
      for (int j=y-a; j<=y+a; j++) {
        int p = i + j * img.width;
        if (p<img.pixels.length&&p>0) {
          float a1 = 0;
            a1 = (red(mean.pixels[p]) + green(mean.pixels[p]) + blue(mean.pixels[p]) + brightness(mean.pixels[p]))/4;
            a1 = brightness(mean.pixels[p]);
          float a2 = (red(img.pixels[p]) + green(img.pixels[p]) + blue(img.pixels[p]) + brightness(img.pixels[p]))/4;
          //variance += brightness(threshold.pixels[p]) - brightness(img.pixels[p]);
          variance += a2-a1;

          count++;
        }
      }
    }
    return sqrt((variance*variance)/count);
  };
  
  float []getNeighboursVar2(int x, int y, int a) {
    float variance = 0;
    float varianceR = 0;
    float varianceG = 0;
    float varianceB = 0;
    int count = 0;
    int count2 = 0;
    float a1r = 0,a1g = 0,a1b = 0,a1br = 0;
    for (int i=x-a; i<=x+a; i++) {
      for (int j=y-a; j<=y+a; j++) {
        int p = i + j * img.width;
        if (p<img.pixels.length&&p>0) {
          
          
          float a2r = red(img.pixels[p]);
          float a2g = green(img.pixels[p]);
          float a2b = blue(img.pixels[p]);
          float a2br = red(img.pixels[p]);
          
          varianceR += a1r-a2r;
          varianceG += a1g-a2g;
          varianceB += a1b-a2b;
          
          variance += a1br-a2br;

          count++;
        }
      }
    }
    variance /= count;
    varianceR /= count;
    varianceG /= count;
    varianceB /= count;
    
    float []val = {variance,varianceR,varianceG,varianceB};
    return val;
  };

  void getNeighbours2Min(int x, int y, int a, int b) {
    for (int i=x-a; i<=x+b; i++) {
      for (int j=y-a; j<=y+b; j++) {
      }
    }
  };

  void getNeighbours2Min(int x, int y, int a) {
    for (int i=x-a; i<=x+a; i++) {
      for (int j=y-a; j<=y+a; j++) {
      }
    }
  };
  
  void sobel(float mult,int a) {
    sobel = new PImage(img.width, img.height, RGB);
    sobel.loadPixels();
    sobelx = new PImage(img.width, img.height, RGB);
    sobelx.loadPixels();
    sobely = new PImage(img.width, img.height, RGB);
    sobely.loadPixels();
    sobelG = new PImage(img.width, img.height, RGB);
    sobelG.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        
        int p = i + j * img.width;
        float[] val = getSobel(i, j);
        
        float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
        float r = red(img.pixels[p]);
        float g = green(img.pixels[p]);
        float b1 = blue(img.pixels[p]);
        float b2 = brightness(img.pixels[p]);
        //println(val.length);
        float v = val[0];
        //println(val[3]);

        //float k = ((v/b)*(v)/(b)) *((b/v)*(v))-((v)/(b));
        //k = (b*b - (b-v)*(b+v));
        //k = (v*v - (v-b)*(v+b));
        
        //println(k,b);
        //k = abs(v-b);
        //k = v-b;
        float k = v * mult;
        float t = 2.0;
        //k = 2.0 / (1.0 + exp(-2.0 * k)) - 1.0;
        //k = (t/ (1.0 + exp(-t * (k))) - 1.0)*val[0]*mult;
        //sobel.pixels[p] = color(255);
        //println(k);
        //if(k>val[0])
        //if(k<7)
        //sobel.pixels[p] = color(k);
        //if(255-(k-b2)<255&&val[3]>6)
        //if(val[3]<8)
        //if(255-(k-b2)<255)
        //sobel.pixels[p] = color(255);
        if(a==0)sobel.pixels[p] = color(255-(k-(b2)));
        //sobel.pixels[p] = color(0);
        if(a==1)sobel.pixels[p] = color(255-k);
        if(a==2)sobel.pixels[p] = color(b2-k);
        if(a==3)sobel.pixels[p] = color(k);
        if(a==4)sobel.pixels[p] = color(r - k,g - k,b1 - k,b2);
        if(a==5)sobel.pixels[p] = color(r - (k-(r)),g - (k-(g)),b1 - (k-(b1)),b2 -(k-(b2)));
        if(a==6)sobel.pixels[p] = color(255 - (k-(r)),255 - (k-(g)),255 - (k-(b1)),255 -(k-(b2)));
        if(a==7){
          float rng = random(200);
          float rng1 = random(100);
          if(255-(k-(b2))<100)sobel.pixels[p] = color(0);
          else sobel.pixels[p] = color(255-(k-b2),0);
        }
        if(a==8){
          float rng = random(200);
          float rng1 = random(100);
          if(255-(k-(b2))<100)sobel.pixels[p] = color(0,rng);
          else sobel.pixels[p] = color(255-(k-b2),0);
        }
        if(a==9){
          float rng = random(200);
          float rng1 = random(100);
          if(255-(k-(b2))<100)sobel.pixels[p] = color(r-rng1,g-rng1,b1-rng1,rng);
          else sobel.pixels[p] = color(255-(k-b2),0);
        }
        sobelx.pixels[p] = color(val[1]);
        sobely.pixels[p] = color(val[2]);
      }
    }
    sobel.updatePixels();
    sobelx.updatePixels();
    sobely.updatePixels();
    //sobelG.updatePixels();
    current = sobel;
    images.add(current);
  };

  float []getSobel(int x, int y) {
    float val = 0;
    float vy = 0;
    float vx = 0;
    float vd = 0;
    float hd = 0;
    float eh = 0;
    float ev =0;
    img.loadPixels();
    int count = 0;
    int count2 = 0;
    int p1 = x + y * img.width;
    float b1 = (red(img.pixels[p1])+green(img.pixels[p1])+blue(img.pixels[p1])+brightness(img.pixels[p1]))/4;
    float k = 40;
    int z = 1;
    for (int i=x-z; i<=x+z; i++) {
      for (int j=y-z; j<=y+z; j++) {

        int p = i + j * img.width;
        if (p>0&&p<img.pixels.length) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
          if (abs(red(img.pixels[p1])-red(img.pixels[p]))<k
            ||abs(green(img.pixels[p1])-green(img.pixels[p]))<k
            ||abs(blue(img.pixels[p1])-blue(img.pixels[p]))<k
            ||brightness(img.pixels[p1])-brightness(img.pixels[p])<k
            ) {
            count2 ++;
            
            int x1 = 0 + i - x + 1;
            int y1 = 0 + j - y + 1;
            
            float col = brightness(img.pixels[p]);
            col = b;
            float v = SobelH[x1][y1] * col;
            float h = SobelV[x1][y1] * col;
            float vd_ = SobelH_[x1][y1] * col;
            float hd_ = SobelV_[x1][y1] * col;
            float eh_ = SobelV[x1][y1] * col;
            float ev_ = SobelH[x1][y1] * col;
            
            //v = LapLacian[x1][y1] * col;
            //h = LapLacianD[x1][y1] * col;

            //println(col);
            vx += v;
            vy += h;
            vd += vd_;
            hd += hd_;
            ev += ev_;
            eh += eh_;
            }

          //neighbours[x][y] 
          count ++;
        }
      }
    }

    vx/= count;
    vy/= count;

    //if(vx<0)vx = 0;
    //if(vy<0)vy = 0;

    val = sqrt(vx*vx + vy*vy);
    //val = sqrt(vx*vx + vy*vy + vd*vd + hd*hd + ev*ev + eh*eh);
    //val = sqrt(vx*vx + vy*vy + vd*vd + hd*hd);
    //println(atan2(vy,vx));
    float [] sob = {val, vx, vy, count2,atan2(vy,vx)};
    //float [] sob = {val, vx, vy, count2,atan2((vy + hd + eh)/3,(vx + vd + ev)/3)};
    //float [] sob = {val, vx, vy, count2,atan2((vy + hd)/2,(vx + vd)/2)};
    //gradient[x][y] = atan2(vy,vx);
    return sob;
  };
  
  void sobel(PImage img,float mult,int a) {
    //println("h");
    sobel = new PImage(img.width, img.height, RGB);
    sobel.loadPixels();
    sobelx = new PImage(img.width, img.height, RGB);
    sobelx.loadPixels();
    sobely = new PImage(img.width, img.height, RGB);
    sobely.loadPixels();
    sobelG = new PImage(img.width, img.height, RGB);
    sobelG.loadPixels();
    
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {

        int p = i + j * img.width;
        float[] val = getSobel(i, j,img);
        float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
        float r = red(img.pixels[p]);
        float g = green(img.pixels[p]);
        float b1 = blue(img.pixels[p]);
        float b2 = brightness(img.pixels[p]);
        //println(val.length);
        float v = val[0];
        //println(val[0]);
        float k = v*mult;
        //k = random(255);
        
        if(a==0)sobel.pixels[p] = color(255-(k-(b2)));
        //sobel.pixels[p] = color(0);
        if(a==1)sobel.pixels[p] = color(255-k);
        if(a==2)sobel.pixels[p] = color(b2-k);
        if(a==3)sobel.pixels[p] = color(k);
        //sobel.pixels[p] = color(((b2)-k));
        //sobel.pixels[p] = color(0);
        //sobel.pixels[p] = color(k);
        //sobel.pixels[p] = color(k-r,k-g,k-b1);
        //sobel.pixels[p] = color((k-r),(k-g),(k-b1));
        //sobel.pixels[p] = color(r-k,g-k,b1-k);
        //float s = brightness(sobel.pixels[p]);
        //if(s>250)sobel.pixels[p] = color(0);
        //println(sobel.pixels[p]);
        //if(k<200)sobel.pixels[p] = color(img.pixels[p]);
        //sobel.pixels[p] = color(val[0]);
        //else sobel.pixels[p] = color(255);
        sobelx.pixels[p] = color(val[1]);
        sobely.pixels[p] = color(val[2]);
      }
    }
    sobel.updatePixels();
    sobelx.updatePixels();
    sobely.updatePixels();
    sobelG.updatePixels();
    current = sobel;
    images.add(sobel);
  };
  
  float []getSobel(int x, int y, PImage img) {
    float val = 0;
    float vy = 0;
    float vx = 0;
    img.loadPixels();
    int count = 0;
    for (int i=x-1; i<=x+1; i++) {
      for (int j=y-1; j<=y+1; j++) {

        int p = i + j * img.width;
        if (p>0&&p<img.pixels.length) {
          int x1 = 0 + i - x + 1;
          int y1 = 0 + j - y + 1;

          float col = brightness(img.pixels[p]);
          //println(col);
          //col = (red(img.pixels[p])+blue(img.pixels[p])+green(img.pixels[p])+brightness(img.pixels[p]))/4;
          float v = SobelH[x1][y1] * col;
          float h = SobelV[x1][y1] * col;

          //println(col);
          vx += v;
          vy += h;

          count ++;
        }
      }
    }

    vx/= count;
    vy/= count;

    val = sqrt(vx*vx + vy*vy);
    //val = random(255);
    //println(count);
    float [] sob = {val, vx, vy, count};
    return sob;
  };
  
  void sobel2(float mult,int a) {
    sobel2 = new PImage(img.width, img.height, RGB);
    sobel2.loadPixels();
    sobel2x = new PImage(img.width, img.height, RGB);
    sobel2x.loadPixels();
    sobel2y = new PImage(img.width, img.height, RGB);
    sobel2y.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float []mean = getSobel2(i, j, a);
        float b = brightness(img.pixels[p]);
        //println(mean[0]);
        sobel2.pixels[p] = color(255-(mean[0]*mult-b));
        sobel2x.pixels[p] = color(mean[1]);
        sobel2y.pixels[p] = color(mean[2]);
        //sobel2.pixels[p] = color(mean);
        //sobelG.pixels[p] = color((gradient[i][j]*100));
        //println(gradient[i][j],green(sobelG.pixels[p]));
      }
    }
    sobel2.updatePixels();
    current = sobel2;
    images.add(current);
  };
  
  float []getSobel2(int x, int y,int a){
    float mean = 0;
    float meany = 0;
    float meana = 0;
    float meanb = 0;
    int count = 0;
    for (int i=x-a; i<=x+a; i++) {
      for (int j=y-a; j<=y+a; j++) {
        int p = i + j * img.width;
        if (p<img.pixels.length&&p>0) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
          float c = (i-x);
          float d = (j-y);
          float e = x - i;
          float f = y - j;
          //if(c==0)c=1;
          //meany += brightness(img.pixels[p])*(c+d);
          //mean += brightness(img.pixels[p])*(e+f);
          //meana += brightness(img.pixels[p])*(c+f);
          //meanb += brightness(img.pixels[p])*(e+d);
          meany += b*(c+d);
          mean += b*(e+f);
          meana += b*(c+f);
          meanb += b*(e+d);
          //mean += (brightness(img.pixels[p])*(c+d) + brightness(img.pixels[p])*(e+f))/2;
          //mean += brightness(img.pixels[p])*(c+d);
          count++;
      }}
    }
    
    mean /= count;
    meana /= count;
    meanb /= count;
    meany /= count;
    float k = 00;
    //return sqrt(mean*mean+meany*meany);
    //gradient[x][y] = atan2((meany+meana)/2,(mean+meanb)/2);
    float val = sqrt(mean*mean+meany*meany+(meana*meana+meanb*meanb))+random(-k);
    //float val = sqrt((mean*mean+meany*meany)/(meana*meana+meanb*meanb));
    //float val = sqrt((mean*mean+meany*meany)/(meana*meana+meanb*meanb))-sqrt((meana*meana+meanb*meanb)/(mean*mean+meany*meany));;
    //float val = sqrt((mean*mean+meany*meany)*(meana*meana+meanb*meanb))*sqrt((x^x&y^y));
    //float val = sqrt((mean*mean+meany*meany)*(meana*meana+meanb*meanb))/sqrt(((x^x)-(width/2))&((y^y)-(height/2)));
    //float val = sqrt(mean*mean+meany*meany);
    //float val = sqrt(meana*meana+meanb*meanb);
    //println(val);
    float valx = (mean);
    float valy = (meany);
    float [] sob = {val,valx,valy};
    return sob;
    //return sqrt((meana*meana+meanb*meanb));
    //return sqrt((meany/count)*meany/count+meanb/count*meanb/count);
  };
  
  void sobel2(int a, float mult2,int c) {
    sobel2 = new PImage(img.width, img.height, ARGB);
    sobel2.loadPixels();
    sobel2x = new PImage(img.width, img.height, RGB);
    sobel2x.loadPixels();
    sobel2y = new PImage(img.width, img.height, RGB);
    sobel2y.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float []mean = getSobel2(i, j, a);
        float b = brightness(img.pixels[p]);
        float k = mean[0]*(mult2);
        //if(k>0)k=255;
        //println(mean[1]);
        if(c==0)sobel2.pixels[p] = color(255-(k-b));
        if(c==1)sobel2.pixels[p] = color(255-(k));
        if(c==2)sobel2.pixels[p] = color(255-(k)-b);
        if(c==3)sobel2.pixels[p] = color(b-k);
        if(c==4)sobel2.pixels[p] = color(k);
        if(c==7){
          
          if(255-(k)<10)sobel2.pixels[p] = color(255-(k),255);
          else sobel2.pixels[p] = color(255-(k),0);
        }
        //
        //sobel2x.pixels[p] = color(255-(mean[1]*(mult2)-b));
        //sobel2y.pixels[p] = color(255-(mean[2]*(mult2)-b));
        sobel2x.pixels[p] = color((mean[1]));
        sobel2y.pixels[p] = color((mean[2]));
        
        
        //sobel2.pixels[p] = color(mean);
        //sobelG.pixels[p] = color((gradient[i][j]*100));
        //println(gradient[i][j],green(sobelG.pixels[p]));
      }
    }
    sobel2.updatePixels();
    current = sobel2;
    images.add(current);
  };
  
  void sobel2(PImage img,float mult,int a) {
    sobel2 = new PImage(img.width, img.height, RGB);
    sobel2.loadPixels();
    sobel2x = new PImage(img.width, img.height, RGB);
    sobel2x.loadPixels();
    sobel2y = new PImage(img.width, img.height, RGB);
    sobel2y.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float []mean = getSobel2(img,i, j, a);
        float b = brightness(img.pixels[p]);
        float k = mean[0]*mult;
        sobel2.pixels[p] = color(255-(k-b));
        
        sobel2x.pixels[p] = color(mean[1]);
        sobel2y.pixels[p] = color(mean[2]);
        //sobel2.pixels[p] = color(mean);
        //sobelG.pixels[p] = color((gradient[i][j]*100));
        //println(gradient[i][j],green(sobelG.pixels[p]));
      }
    }
    sobel2.updatePixels();
    current = sobel2;
    images.add(current);
  };
  
  float []getSobel2(PImage img,int x, int y,int a){
    float mean = 0;
    float meany = 0;
    float meana = 0;
    float meanb = 0;
    int count = 0;
    for (int i=x-a; i<=x+a; i++) {
      for (int j=y-a; j<=y+a; j++) {
        int p = i + j * img.width;
        if (p<img.pixels.length&&p>0) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
          //b = brightness(img.pixels[p]);
          //println(b);
          float c = (i-x);
          float d = (j-y);
          float e = x - i;
          float f = y - j;
          //if(c==0)c=1;
          //meany += brightness(img.pixels[p])*(c+d);
          //mean += brightness(img.pixels[p])*(e+f);
          //meana += brightness(img.pixels[p])*(c+f);
          //meanb += brightness(img.pixels[p])*(e+d);
          meany += b*(c+d);
          mean += b*(e+f);
          meana += b*(c+f);
          meanb += b*(e+d);
          //mean += (brightness(img.pixels[p])*(c+d) + brightness(img.pixels[p])*(e+f))/2;
          //mean += brightness(img.pixels[p])*(c+d);
          count++;
      }}
    }
    
    mean /= count;
    meana /= count;
    meany /= count;
    meanb /= count;
    float k = 90;
    //return sqrt(mean*mean+meany*meany);
    //gradient[x][y] = atan2((meany+meana)/2,(mean+meanb)/2);
    float val = sqrt(mean*mean+meany*meany+(meana*meana+meanb*meanb))+random(-k);;
    //float val = sqrt((mean*mean+meany*meany)/(meana*meana+meanb*meanb));
    //float val = sqrt((mean*mean+meany*meany)/(meana*meana+meanb*meanb))-sqrt((meana*meana+meanb*meanb)/(mean*mean+meany*meany));;
    //float val = sqrt((mean*mean+meany*meany)*(meana*meana+meanb*meanb))*sqrt((x^x&y^y));
    //float val = sqrt((mean*mean+meany*meany)*(meana*meana+meanb*meanb))/sqrt(((x^x)-(width/2))&((y^y)-(height/2)));
    //float val = sqrt(mean*mean+meany*meany);
    //float val = sqrt(meana*meana+meanb*meanb);
    //println(val);
    float valx = (mean);
    float valy = (meany);
    float [] sob = {val,valx,valy};
    return sob;
    //return sqrt(((meana/count)*meana/count+meanb/count*meanb/count));
    //return sqrt((meany/count)*meany/count+meanb/count*meanb/count);
  };
 
  
  void sobelMax(float t){
    sobelMax = new PImage(img.width, img.height, RGB);
    sobelMax.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {

        int p = i + j * img.width;
        
        boolean max = getNeighboursMax(i,j,t);
        if(!max)sobelMax.pixels[p] = color(255);
        else sobelMax.pixels[p] = combined.pixels[p];
      }}
    current = sobelMax;
    images.add(current);
  };
  
  boolean getNeighboursMax(int x, int y,float t) {
    
    float []max = new float[7];
    max[0] = 255;
    
    boolean k = false;
    int p = x + y * img.width;
    //float myGradient = gradient[x][y];
    //float myGradient_ = atan2(sobely.pixels[p],sobelx.pixels[p]);
    
    for (int i=x-1; i<=x+1; i++) {
      for (int j=y-1; j<=y+1; j++) {
        
        int p1 = i+j*sobel.width;
        
        if(p1>0&&p1<sobel.pixels.length){
          float c = 0;
          if(combined==null)c = brightness(sobel.pixels[p1]);
          else c = brightness(combined.pixels[p1]);
          if(max[0]>c){
            max[0] = c;
            max[3] = p1;
          }}}
    }
    int p1 = (int)max[3];
    boolean k2 = false;
    float c = brightness(combined.pixels[p]);
    float c2 = brightness(combined.pixels[p1]);
    //float t = 30;
    float t2 = radians(45);
    float t3 = radians(10);
    float d1 = abs(max[0]-(255-(c)));
    float d2 = abs(atan2(sobely.pixels[p] - sobely.pixels[p1],sobelx.pixels[p] - sobelx.pixels[p1]));
    //println(d2);
    float d3 = abs(max[0]-c);
    //if(d2<t2||c2<=255-c)k = true;
    if(c<t)k = true;
    //println(max[0],brightness(combined.pixels[p]),x,y);
    //if(max[0]<=brightness(combined.pixels[p])||k2)k=true;
    
    // keep this one for cartoons
    //if((max[0]<=brightness(combined.pixels[p]))||d1>t&&max[0]<=brightness(combined.pixels[p]))k = true;
    return k;
  };
  
  void sobelMax(PImage sobel,float t){
    sobelMax = new PImage(img.width, img.height, RGB);
    sobelMax.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {

        int p = i + j * img.width;
        
        boolean max = getNeighboursMax(i,j,sobel,t);
        sobelMax.pixels[p] = color(255);
        if( max)sobelMax.pixels[p] = color(0);
        //else if(max&&brightness(sobel.pixels[p])<255-t)sobelMax.pixels[p] = color(0);
      }}
    current = sobelMax;
    images.add(current);
  };
  
  //boolean getNeighboursMax(int x, int y,PImage sobel,float t) {
    
  //  float []min = new float[2];
  //  min[0] = 255;
    
  //  boolean k = false;
  //  int p = x + y * img.width;
  //  float myGradient = gradient[x][y];
    
  //  for (int i=x-1; i<=x+1; i++) {
  //    for (int j=y-1; j<=y+1; j++) {
        
  //      int p1 = i+j*sobel.width;
        
  //      if(p1>0&&p1<sobel.pixels.length){
  //        float c = 0;
  //        c = brightness(sobel.pixels[p1]);
  //        if(min[0]>c){
  //          min[0] = c;
  //          min[1] = p1;
  //        }}}
  //  }
  //  int p1 = (int)min[1];
  //  boolean k2 = false;
  //  float c = brightness(sobel.pixels[p]);
  //  float c1 = brightness(sobel.pixels[p1]);
  //  float t1 = radians(45);
  //  float t2 = 30;
  //  float d = abs(c1-(255-(c)));
  //  //println(d2);
  //  float d1 = abs(c1-c);
  //  float g = atan2(green(sobelG.pixels[p]), blue(sobelG.pixels[p]));
  //  float g1 = atan2(green(sobelG.pixels[p1]), blue(sobelG.pixels[p1]));
  //  float d2 = abs(g-g1);
  //  //println(d3,d1,c,c2,min[0]);
  //  //if(d3<t)k = true;
  //  //println(g,g1,g-g1,t1);
  //  //if(c<t&&c<=c1||d2<t&&d<t2)k = true;
  //  if(c>c1&&c1<t&&d2<t1&&d1<t2||c<t&&c<=c1)k = true;

  //  // for(int i=0;i<8;i++){
  //  //   float theta = radians(45)*i;
  //  //   float theta2 = radians(45)*(i+1);

  //  //   if(g>theta&&g<theta2){
  //  //     if(g2>theta-PI&&g2<theta2-PI||g2>theta+PI&&g2<theta2+PI)
  //  //   }
  //  // }
  //  //println(min[0],brightness(combined.pixels[p]),x,y);
  //  //if(min[0]<=brightness(combined.pixels[p])||k2)k=true;
    
  //  // keep this one for cartoons
  //  //if((min[0]<=brightness(combined.pixels[p]))||d1>t&&min[0]<=brightness(combined.pixels[p]))k = true;
  //  return k;
  //};
  
  boolean getNeighboursMax(int x, int y,PImage sobel,float t) {
    
    float []min = new float[2];
    min[0] = 255;
    
    boolean k = false;
    int p = x + y * img.width;
    float myGradient = gradient[x][y];
    
    for (int i=x-1; i<=x+1; i++) {
      for (int j=y-1; j<=y+1; j++) {
        
        int p1 = i+j*sobel.width;
        
        if(p1>0&&p1<sobel.pixels.length){
          float c = 0;
          c = brightness(sobel.pixels[p1]);
          if(min[0]>c){
            min[0] = c;
            min[1] = p1;
          }}}
    }
    int p1 = (int)min[1];
    boolean k2 = false;
    float c = brightness(sobel.pixels[p]);
    float c1 = brightness(sobel.pixels[p1]);
    float t1 = radians(45);
    float t2 = 30;
    float d = abs(c1-(255-(c)));
    //println(d2);
    float d1 = abs(c1-c);
    float g = atan2(green(sobelG.pixels[p]), blue(sobelG.pixels[p]));
    float g1 = atan2(green(sobelG.pixels[p1]), blue(sobelG.pixels[p1]));
    float d2 = abs(g-g1);
    return k;
  };
  
  // used with mean--------------------------------
  void sobelMax(PImage sobel,float t,float t1){
    sobelMax = new PImage(img.width, img.height, RGB);
    sobelMax.loadPixels();
    println(t);
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {

        int p = i + j * img.width;
        
        boolean max = getNeighboursMax(i,j,sobel,t,t1);
        sobelMax.pixels[p] = color(255);
        if(max)sobelMax.pixels[p] = color(brightness(sobel.pixels[p]));
        //else if(!max&&brightness(sobel.pixels[p])<t+t1)sobelMax.pixels[p] = color(200);
        //else if(max&&brightness(sobel.pixels[p])<255-t)sobelMax.pixels[p] = color(0);
      }}
  };
  
  boolean getNeighboursMax(int x, int y,PImage sobela,float t,float t2) {
    
    float []min = new float[2];
    min[0] = 255;
    
    boolean k = false;
    int p = x + y * img.width;
    float g = 0;
    if(sobel!=null)g = atan2((sobelx.pixels[p]),(sobely.pixels[p]));
    else g = atan2((sobel2x.pixels[p]),(sobel2y.pixels[p]));
    
    float c = brightness(sobela.pixels[p]);
    //float t2 = 30;
    for (int i=x-1; i<=x+1; i++) {
      for (int j=y-1; j<=y+1; j++) {
        
        int p1 = i+j*sobela.width;
        
        if(p1>0&&p1<sobela.pixels.length){
          float c1 = 0;
          float g1 = atan2(y-j,x-i);
          float d1 = abs(g-g1);
          float d2 = abs((g-PI)-g1);
          float t1 = radians(45);
          if(combined==null)c1= brightness(sobela.pixels[p1]);
          else c1= brightness(combined.pixels[p1]);
          if((((d1<t1||d2<t1)&&((c1<c&&c1<t))))){
            min[0] = c1;
            min[1] = p1;
            k = true;
            
          }}}
    }
    int p1 = (int)min[1];
    boolean k2 = false;
    //float c = brightness(sobel.pixels[p]);
    float c1 = brightness(sobela.pixels[p1]);
    float t1 = radians(180);
    //println(k);
    float d = abs(c1-(255-(c)));
    
    float d1 = abs(c1-c);
    float g1 = 0;
    if(sobel!=null)g1 = atan2((sobelx.pixels[p1]),(sobely.pixels[p1]));
    else g1 = atan2((sobel2x.pixels[p1]),(sobel2y.pixels[p1]));
    //float g1 = atan2((meanGy.pixels[p1]), (meanGy.pixels[p1]));
    //float g1 = atan2((blurX.pixels[p1]),(blurY.pixels[p1]));
    float d2 = abs(g-g1);
    float d3 = abs((g-PI)-g1);
    float d4 = abs(c-t);
    return k;
  };
  
  //boolean getNeighboursMax(int x, int y,PImage sobela,float t,float t2) {
    
  //  boolean k = true;
  //  int p = x + y * img.width;
    
  //  float c = brightness(sobela.pixels[p]);
    
  //  for (int i=x-1; i<=x+1; i++) {
  //    for (int j=y-1; j<=y+1; j++) {
        
  //      int p1 = i+j*sobela.width;
        
  //      if(p1>0&&p1<sobela.pixels.length){
  //        float c1 = brightness(sobela.pixels[p1]);
  //        if(c>c1)k = false;
  //    }}
  //  }
  //  return k;
  //};
  
  
  void sobelMin(){
    sobelMin = new PImage(img.width, img.height, RGB);
    sobelMin.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {

        int p = i + j * img.width;
        
        boolean min = getNeighboursMin(i,j);
        if(!min)sobelMin.pixels[p] = color(255);
        else sobelMin.pixels[p] = sobel.pixels[p];
      }}
  };
  
  boolean getNeighboursMin(int x, int y) {
    
    float []max = new float[3];
    max[0] = 0;
    boolean k = false;
    int p = x + y * img.width;
    float myGradient = brightness(sobelG.pixels[p]);
    for (int i=x-1; i<=x+1; i++) {
      for (int j=y-1; j<=y+1; j++) {
        
        int p1 = i+j*sobel.width;
        
        if(p1>0&&p1<sobel.pixels.length&&p1!=p){
        float cGradient = brightness(sobelG.pixels[p1]);
        
        //if(cGradient==-1/myGradient||cGradient==PI-(-1/myGradient)){
        //if(cGradient==myGradient){
          float c = brightness(sobel.pixels[p1]);
          if(max[0]>c){
            max[0] = c;
            max[1] = i;
            max[2] = j;
          }
        //}
      }}
    }
    //println(max[0],brightness(blur.pixels[x+y*sobel.width]));
    int p2 = (int)max[1] + (int)max[2] * sobelG.width;
    //if(p2
    //println((int)max[0],(int)max[1],x,y);
    float cGradient = brightness(sobelG.pixels[p]);
    //if(max[0]>=brightness(blur.pixels[x+y*sobel.width])||(cGradient==-1/myGradient||cGradient==PI-(-1/myGradient)))k=true;
    boolean k2 = false;
    float r = red(blur.pixels[p]);
    float g = green(blur.pixels[p]);
    float b = blue(blur.pixels[p]);
    float b1 = brightness(blur.pixels[p]);
    float r1 = red(blur.pixels[p2]);
    float g1 = green(blur.pixels[p2]);
    float b2 = blue(blur.pixels[p2]);
    float b3 = brightness(blur.pixels[p2]);
    float t = 0;
    if(abs(r-r1)<t||abs(g-g1)<t||abs(b-b2)<t||abs(b1-b3)<t)k2 = true;
    
    //if(max[0]<=brightness(blur.pixels[x+y*sobel.width])||(cGradient==-1/myGradient||cGradient==PI-(-1/myGradient))||k2)k=true;
    if(max[0]<=brightness(blur.pixels[x+y*sobel.width])&&(cGradient!=-1/myGradient&&cGradient!=PI-(-1/myGradient)))k=true;
    //if(max[0]<=brightness(blur.pixels[x+y*sobel.width])||(cGradient==myGradient))k=true;
    //if(max[0]<=brightness(blur.pixels[x+y*sobel.width]))k=true;
    return k;
  };
};
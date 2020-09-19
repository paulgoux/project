class Data{
  
  HashMap<Integer,Integer> numbers = new HashMap<Integer,Integer>();
  
  String[] labels = {"0","1","2","3","4","5","6","7","8","9",
                     "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
                     "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"};
  //String[] labels = {"0","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
  //                   "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};       
  String []l;
  String location;
  byte[] imageB,trainingLabels,testingLabels;
  float[] imageB_,trainingLabels_,testingLabels_;
  byte[][] temp;
  float[] temp2;
  PImage image,input;
  PImage [] images,trainingData,testingData;
  boolean debug,counter,counted;
  fileOutput outPut;
  ArrayList<float []> inputs,outputs;
  int output;
  Card card;
  ArrayList<String> fileNames = new ArrayList<String>();
  ArrayList<vectorText> textFiles = new ArrayList<vectorText>();
  vectorText[] textFile;
  ArrayList<audioData> audioFiles = new ArrayList<audioData>();
  audioData[] audioFile;
  HashMap<String, ArrayList<Integer>> extensions = new HashMap<String, ArrayList<Integer>>();
  
  Data(){
  };
  
  Data(String location){
    this.location = location;
    //outPut = new fileOutput(location);
  };

  Data(audioData audio){
    //location
    //outPut = new fileOutput(location);
  };
  
  Data(byte[] image){
    
  };

  void listExt() {

    String []names = listNames(location);

    if(names!=null&&!counted){
      for(int i=0;i<names.length;i++){

        File f = new File(names[i]);

        String type = getFileExtension(f);
        String[] m = match(names[i], "ubyte");

        if(m==null){
          if(!extensions.containsKey(type)){
            ArrayList<Integer> n = new ArrayList<Integer>();
            n.add(i);
            extensions.put(type,n);
            fileNames.add(names[i]);
          }else{
            extensions.get(type).add(i);
            fileNames.add(names[i]);
        }}
        else{
          if(!extensions.containsKey("ubyte")){
            ArrayList<Integer> n = new ArrayList<Integer>();
            n.add(i);
            extensions.put("ubyte",n);
            fileNames.add(names[i]);
          }else{
            extensions.get(type).add(i);
            fileNames.add(names[i]);
        }}}
    counted = true;
    }
  };

  void sortData(){

      for(int i=0;i<fileNames.size();i++){
        String s = fileNames.get(i);

        switch(s){
          
          case "txt" :
          case "doc" :
          case "DOC" :
          case "jpg" :
          case "JPG" :
          case "jpeg":
          case "JPEG":
          case "bmp" :
          case "BMP" :
          case "png" :
          case "PNG" :
          case "gif" :
          case "GIF" :
          case "mp3" :
          case "MP3" :
          case "wav" :
          case "ubyte" :

        }
      }
  };

  void loadAudioData(audioData data){


  };

  void loadAudioData(audioData [] data){


  };

  void loadAudioData(ArrayList<audioData> data){


  };

  void loadTextData(vectorText text){


  };

  void loadTextData(vectorText[] text){


  };

  void loadTrainingData(byte[] Image,int size){
    int k = 28;
    
    int[][]temp = new int[k][k];
    
    
    trainingData = new PImage[size];
    inputs = new ArrayList<float[]>();
    
    for(int i=0;i<size;i++){
      
      image = createImage(k,k,RGB);
      image.loadPixels();
      inputs.add(new float[k*k]);
      float[]temp2 = new float[k*k];
      for(int j=0;j<k*k;j++){
        image.pixels[j] = Image[j+16+k*k*i];
      }
      for(int j=0;j<k;j++){
        for(int h=0;h<k;h++){
          
          int p = h + j * k;
          temp[h][j] = image.pixels[p];;
          
      }}
      
      for(int j=0;j<k;j++){
        for(int h=0;h<k;h++){
          
          int p = h + j * k;
          image.pixels[p] =  - (int)red(temp[j][h]);
           if(red(image.pixels[p])>50)image.pixels[p] = (int)map(red(image.pixels[p])+20,0,255,-1,1); 
           else image.pixels[p] = -1;
          temp2[p] = 128 * (1 - (red(image.pixels[p])));
          image.pixels[p] = (int)red(temp[j][h]);
          
      }}
      
      image.updatePixels();
      inputs.set(i,temp2);
      trainingData[i] = image;
    }
  };
  
  void loadTrainingData(byte[] Image,int size,int res){
    int k = res;
    
    int[][]temp = new int[k][k];
    
    trainingData = new PImage[size];
    inputs = new ArrayList<float[]>();
    
    for(int i=0;i<size;i++){
      
      image = createImage(k,k,RGB);
      image.loadPixels();
      inputs.add(new float[k*k]);
      float[]temp2 = new float[k*k];
      for(int j=0;j<k*k;j++){
        image.pixels[j] = Image[j+16+k*k*i];
      }
      for(int j=0;j<k;j++){
        for(int h=0;h<k;h++){
          
          int p = h + j * k;
          temp[h][j] = image.pixels[p];;
          
      }}
      
      for(int j=0;j<k;j++){
        for(int h=0;h<k;h++){
          
          int p = h + j * k;
          image.pixels[p] =  - (int)red(temp[j][h]);
           if(red(image.pixels[p])>50)image.pixels[p] = (int)map(red(image.pixels[p])+20,0,255,-1,1); 
           else image.pixels[p] = -1;
          temp2[p] = 128 * (1 - (red(image.pixels[p])));
          image.pixels[p] = (temp[j][h]);
          
      }}
      
      image.updatePixels();
      inputs.set(i,temp2);
      trainingData[i] = image;
    }
  };
  
  
  void loadTestingData(byte[] Image,int size){
    int k = 28;
    
    testingData = new PImage[size];
    inputs = new ArrayList<float[]>();
    
    int [][] temp = new int[k][k];
    
    for(int i=0;i<size;i++){
      image = createImage(k,k,RGB);
      image.loadPixels();
      inputs.add(new float[k*k]);
      float[]temp2 = new float[k*k];
      
      for(int j=0;j<k*k;j++){
        image.pixels[j] = Image[j+16+k*k*i];
      }
      for(int j=0;j<k;j++){
        for(int h=0;h<k;h++){
          
          int p = h + j * k;
          temp[h][j] = image.pixels[p];
          
      }}
      
      for(int j=0;j<k;j++){
        for(int h=0;h<k;h++){
          
          int p = h + j * k;
          image.pixels[p] =  - (int)red(temp[j][h]);
           if(red(image.pixels[p])>50)image.pixels[p] = (int)map(red(image.pixels[p])+20,0,255,-1,1); 
           else image.pixels[p] = -1;
          temp2[p] = 128 * (1 - (red(image.pixels[p])));
          
      }}
      image.updatePixels();
      inputs.set(i,temp2);
      testingData[i] = image;
    }
  };
  
  void loadTestingData(byte[] Image,int size,int res){
    int k = res;
    
    testingData = new PImage[size];
    inputs = new ArrayList<float[]>();
    
    int [][] temp = new int[k][k];
    
    for(int i=0;i<size;i++){
      image = createImage(k,k,RGB);
      image.loadPixels();
      inputs.add(new float[k*k]);
      float[]temp2 = new float[k*k];
      
      for(int j=0;j<k*k;j++){
        image.pixels[j] = Image[j+16+k*k*i];
      }
      for(int j=0;j<k;j++){
        for(int h=0;h<k;h++){
          
          int p = h + j * k;
          temp[h][j] = image.pixels[p];
          
      }}
      
      for(int j=0;j<k;j++){
        for(int h=0;h<k;h++){
          
          int p = h + j * k;
          image.pixels[p] =  - (int)red(temp[j][h]);
           if(red(image.pixels[p])>50)image.pixels[p] = (int)map(red(image.pixels[p])+20,0,255,-1,1); 
           else image.pixels[p] = -1;
          temp2[p] = 128 * (1 - (red(image.pixels[p])));
          
      }}
      image.updatePixels();
      inputs.set(i,temp2);
      testingData[i] = image;
    }
  };
  
  void loadTestingLabels(byte [] Image){
    
    testingLabels = new byte[Image.length - 8];
    testingLabels_ = new float[Image.length - 8];
      
      for(int j=8;j<Image.length;j++){
        testingLabels[j-8] = Image[j];
      }
  };
  
  void loadTrainingLabels(byte [] Image){
    
    trainingLabels = new byte[Image.length - 8];
    trainingLabels_ = new float[Image.length - 8];
    
      for(int j=8;j<Image.length;j++){
        trainingLabels[j-8] = Image[j];
      }
  };
  
  PImage threshold(PImage image){
  
    PImage tempCard = createImage(image.width,image.height,RGB);
    
    for (int i = 0; i < 784; i++) {
        if(red(image.pixels[i])<50)tempCard.pixels[i] = 10;
         if(red(image.pixels[i])>50)tempCard.pixels[i] = (int)map(red(image.pixels[i])+20,0,255,1,-1); 
         else tempCard.pixels[i] = 1;
         //map(red(image.pixels[i]),0,255,-1,1); 
      }
    return tempCard;
  };
  
};
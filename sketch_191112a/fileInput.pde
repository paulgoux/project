class fileInput{
  String value,location;
  boolean click = false,folder,counted,fileSelect,toggle,folderSelect;
  float x,y,w = width,h = height;
  Button parent;
  String [] values;
  File []files;
  ArrayList<String>fileNames = new ArrayList<String>();
  HashMap<String, ArrayList<Integer>> extensions = new HashMap<String, ArrayList<Integer>>();

  fileInput(){
  };

  fileInput(boolean b){
    folder = true;
  };

  fileInput(Button b){
    
    x = b.x;
    y = b.y;
    w = b.w;
    h = b.h;
    parent = b;
  };

  fileInput(Button b,boolean a){
    
    x = b.x;
    y = b.y;
    w = b.w;
    h = b.h;
    parent = b;
    folder = true;
  };

  fileInput(Button b,boolean a,Object o){
    
    x = b.x;
    y = b.y;
    w = b.w;
    h = b.h;
    parent = b;
    folder = true;

  };

  String getFile(){
    
    String s = value;
    value = null;
    return s;
  };

  void setLink(Button b){
    x = b.x;
    y = b.y;
    w = b.w;
    h = b.h;
  };

  String []getFolder(){
    String []s = values;
    values = null;
    return s;
  };

  void saveLocation(String location){
    this.location = location;
  };

  void listen(){
    if(!folder){
      if(pos()&&click()){
        selectInput("Select a file to process:", "fileSelected");
        fileSelect = true;
      }}else {
        if(pos()&&click()){
          selectFolder("Select a file to process:", "folderSelected");
          folderSelect = true;
          
      }}

      if(BMS.File.value!=null){
        value = BMS.File.value;
        BMS.File.value = null;
        if(folder){
          values = listFileNames(value);
          files = listFiles(value);
        }

        //  println("Locationi: " + value);
      }

  };

  void listen1(){
    click();
    if(!folder){
      if(click){
        selectInput("Select a file to process:", "fileSelected");
        value = BMS.File.value;
        BMS.File.value = null;
      }}else {
        if(click){
          selectFolder("Select a file to process:", "folderSelected");
          //value = BMS.File.value;
          BMS.File.value = null;
          //values = listNames(value);
      }}
  };
 
  public void listen_(){
    if(!folder)selectInput("Select a file to process:", "fileSelected");
    else selectInput("Select a file to process:", "folderSelected");
  };

  void listExt() {

    if(values!=null&&!counted){
      for(int i=0;i<values.length;i++){

        File f = new File(values[i]);

        String type = getFileExtension(f);
        if(!extensions.containsKey(type)){
          ArrayList<Integer> n = new ArrayList<Integer>();
          n.add(i);
          extensions.put(type,n);
        }else extensions.get(type).add(i);
      }
    counted = true;
    }
  };

  void getTextFiles(){


  };

  void getImageFiles(){


  };

  void getVideoFiles(){


  };

  void getAudioFiles(){


  };

  String []getFolder(String location) {

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
        }}}}

      String []s = new String[fileNames.size()];

      for(int i=0;i<fileNames.size();i++){
        s[i] = fileNames.get(i);
      }
      return s;
  };

  boolean click(){
    boolean k = false;
    
        if (pos()&&mousePressed&&!click){
        click = true;
        k = false;
      }else if(click&&!mousePressed){
        k = true;
        click = false;
      }
    return k;
  };
    
  boolean pos(){
    return mouseX>x&&mouseX<x+w&&mouseY>y&&mouseY<y+h;
  };
  
};

void fileSelected(File selection){
  if(selection != null)BMS.File.value = selection.getAbsolutePath();
  Location = selection.getAbsolutePath();
};

void folderSelected(File selection) {
  if(selection != null){
    BMS.File.value = selection.getAbsolutePath();
    //println("Locationf: " + BMS.File.value);
    Location = selection.getAbsolutePath();
  }
};
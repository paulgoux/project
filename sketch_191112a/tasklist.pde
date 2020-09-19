class taskList extends Window{
   
    float x,y,w,h,w2,h2;
    int tcount = 0;
    Menu menu,submenu;
    ArrayList<String> tasks = new ArrayList<String>();
    ArrayList<String[][]> conv_pair = new ArrayList<String[][]>();
    //HashMap<String,Float[][]> tasks
    PImage icon;
    boolean done,numbered,convolved,cdown,windowreset;
    Table_ table;
    Window Window;
    //Float [][] convolution;
    String [][] convolution;
    TextBox [] colrow;
    //ArrayList<String> convolution = new ArrayList<String>();
    
    taskList(){
      
    };
    
    taskList(float x,float y,float w,float h, String [] List){
      
      this.x = x;
      this.y = y;
      this.w = w;
      this.h = h;
      w2 = w;
      h2 = h;
      menu = new Menu(x+w+5,y,100,List,0); 
      
      Button b = new Button(x+100,y+10,30,30,"+");
      b.bsize = 35;
      b.tsize = 35;
      b.tmax = 5;
      b.tyoff = 7;
      b.txoff = -1;
      Buttons.add(b);
      
      Button b1 = new Button(x+5,y+h - 30,w-15,20,"Finish");
      Buttons.add(b1);
      
      Button b2 = new Button(x+5,y+h - 55,w-15,20,"Clear");
      Buttons.add(b2);
      
      Button b3 = new Button(menu.x ,menu.y - 30,w - 55,20,"Get From File");
      Buttons.add(b3);
      
      String [] submenuLabels = {"Load Dataset","Load Training set","Load Image Folder"};
      
      submenu = new Menu(menu.x ,y + h - 70,w - 55,submenuLabels,10);
      submenu.border = true;
      
      int trows = 3;
      int tcols = 3;
      table = new Table_(menu.x + menu.w,y,120,100,tcols,trows);
      windows.get(0).launchable = false;
      colrow = new TextBox[2];
      TextBox t1 = new TextBox(x+40,y+h-80,30,20,2);
      TextBox t2 = new TextBox(x+20+90,y+h-80,30,20,2);
      colrow[0] = t1;
      colrow[1] = t2;
      
    };
    
    taskList(float x,float y,float w,float h, String [] List,int k){
      super(x,y,w,h,"C:\\Users\\paul goux\\");
      this.x = x;
      this.y = y;
      this.w = w;
      this.h = h;
      w2 = w;
      h2 = h;
      menu = new Menu(x+w+5,y,80,List,0); 
      
      Button b = new Button(x+100,y+10,30,30,"+");
      b.bsize = 35;
      b.tsize = 35;
      b.tmax = 5;
      b.tyoff = 7;
      b.txoff = -1;
      Buttons.add(b);
      
      Button b1 = new Button(x+5,y+h - 55,w-15,20,"Clear");
      Buttons.add(b1);
      
      Button b2 = new Button(x+5,y+h - 30,w-15,20,"Finish");
      Buttons.add(b2);
      
      Button b3 = new Button(menu.x ,menu.y - 30,w - 55,20,"Get From File");
      Buttons.add(b3);
      
      String [] submenuLabels = {"Load Dataset","Load Training set","Load Image Folder","Load Source"};
      
       submenu = new Menu(menu.x ,y + h - 75,w - 55,submenuLabels,5);
       submenu.visible = false;
       submenu.borders(true);
       
      int trows = 3;
      int tcols = 3;
      table = new Table_(menu.x + menu.w,y,120,100,tcols,trows,0);
      windows.get(0).launchable = false;
      colrow = new TextBox[2];
      TextBox t1 = new TextBox(x+40,y+h-80,30,20,2);
      TextBox t2 = new TextBox(x+20+90,y+h-80,30,20,2);
      colrow[0] = t1;
      colrow[1] = t2;
      
    };
    
    void displayList(){
      fill(255);
      if(!done){
        box();
      fill(0);
      text("Cols :",x+10,y+h-65);
      text("Rows :",x+75,y+h-65);
      
      for(int i=0;i<colrow.length;i++){
        
        TextBox t = colrow[i];
        
        t.draw();
      }
      for(int i=0;i<Buttons.size()-1;i++){
        
        Button b = Buttons.get(i);
        
        if(!windows.get(0).toggle)b.self_click2();
        b.draw();
        
      }
      String link2 = null;
      if(Buttons.get(1).toggle==1&&!windows.get(0).toggle){
        tasks = new ArrayList<String>();
        conv_pair = new ArrayList<String[][]>();
        convolution = null;
        table.rows = 0;
        table.cols = 0;
        table.gridarray = new ArrayList<ArrayList<TextBox>>();
        colrow[0].textBox = "";
        colrow[0].value = 0;
        colrow[1].textBox = "";
        colrow[1].value = 0;
      }
      if(Buttons.get(2).toggle==1&&!windows.get(0).toggle)done = true;
      if(Buttons.get(0).toggle==1){
        w2 = 450;
        y2 = y - 40;
        h2 = h + 40;
        menu.draw();table.draw();submenu.draw();
        Buttons.get(3).draw();
        Buttons.get(3).highlight();
        if(!windows.get(0).ddown&&!!windows.get(0).mdown)Buttons.get(3).toggle2(windows.get(0),"toggle");
        
        for(int i=0;i<submenu.items.size();i++){
          Button b1 = submenu.items.get(i);
          b1.toggle2(windows.get(0),"toggle");
        }
        //submenu.toggle(0,windows.get(0),"toggle");
        
        if(windows.get(0).nav.get(2).pos()&&mousePressed&&!mdown){
          windows.get(0).nav.get(2).reverseclick(windows.get(0),"toggle");
          Buttons.get(3).mdown=false;
          Buttons.get(3).toggle=0;
        }
        //if(Buttons.get(3).toggle==0)windows.get(0).nav.get(2).toggle=0;
        windows.get(0).display_grid();
        table.rows = int(colrow[1].value);
        table.cols = int(colrow[0].value);
        if(mousePressed&&!mdown)link2 = windows.get(0).currentf;
      
      }else {
      w2 = w;
      y2 = y;
      h2 = h;
      }
      
      if(!mousePressed)mdown = false;
      if(link2!=null){
      
      if(link2.endsWith("txt")|| link2.endsWith("csv")){
        //
          convolution = string_to_array(loadStrings(link2));
          convolved = false;
          
      }
      link2 = null;
    }
      
      if(convolution!=null){
      if(table.gridarray.size()>0&&convolution.length*convolution[0].length==table.gridarray.size()*table.gridarray.get(0).size()){
        
        for(int i=0;i<convolution.length;i++){
          for(int j=0;j<convolution[0].length;j++){
            
          TextBox t = table.gridarray.get(j).get(i);
          t.textBox = convolution[i][j].toString();
          t.value = int(convolution[i][j]);
        }}}else {table.initialize(convolution.length,convolution[0].length);}convolved = true;}
      
      Button b = Buttons.get(3);
      
      tcount = 0;
      if(table.gridarray.size()>0&&!convolved){
        
        
        for(int i=0;i<table.gridarray.size();i++){
          for(int j=0;j<table.gridarray.get(i).size();j++){
          TextBox t = table.gridarray.get(i).get(j);
          
          if(t.textBox!=null&&t.textBox!="")tcount ++;
        }}}
        
        if(table.gridarray.size()>0&&(tcount == table.gridarray.size()*table.gridarray.get(0).size())||convolved) numbered = true;
        else numbered = false;
      
      for(int i=0;i<menu.items.size();i++){
        Button b1 = menu.items.get(i);
        if(b1.pos()&&mousePressed&&!mdown&&(numbered||convolved)){
          tasks.add(b1.label);
          conv_pair.add(convolution);
          b.toggle = 0;
        }
        else if(b1.pos()&&mousePressed&&!mdown&&(!numbered||convolved)){
          cdown = true;
          mdown = true;
        }
      }
      
      if(cdown)convolve_request();
      
      for(int i=0;i<tasks.size();i++){
        
       String s = tasks.get(i);
       
       text(s,x+10,y+40 +10*i);
      }}
      if(mousePressed&&!mdown) cdown = false;
      if(mousePressed)mdown = true;
      //if(mousePressed&&cdown&&mdown) cdown = false;
      
      
    };
    
    void box(){
      noStroke();
      if(!transparent)fill(255);
      else fill(255,transparency);
      rect(x,y,w,h);
      rect(x,y2,w2,h2);
      
      fill(0,transparency2);
      rect(x,y2,w2,h2);
      rect(x,y,w,h);
      
    };
    
    void convolve_request(){
          stroke(0);
          fill(255);
          
          rect(300,300,200,20);
          fill(0);
          text("Please add convolution!",340,315);
    };
    
    void tasklogic(){
      if(!mousePressed) smdown = false;
    };
    
    ArrayList<String> string_to_arrayl(String [] a){
      ArrayList<String> temp = new ArrayList<String>();
      
      for (int i=0;i<a.length;i++){
        String s = a[i];
        temp.add(s);
      }
      
      return temp;
    }
  };
  
  String[][] string_to_array(String [] a){
    String s = "";
    int count = 0;
    for(int i=0;i<a.length;i++){
      if(a[i].length()>0){
      String k = a[i] + ",";
      
      if(a[i].charAt(a[i].length()-1)==',')s += a[i];
      else s += k;
    }}
    
    int char_counter = 0;
    
    ArrayList<String> s1 = new ArrayList<String>();
    
    for(int i=0;i<s.length();i++){
      
      char c = s.charAt(i);
      
      if(c==','){
        String b = s.substring(char_counter,i);
        
        s1.add(b);
        char_counter = i+1;
      }
    }
    
      int wid = s1.size()/a.length;
      String[][] temp = new String [wid][a.length];
      
      for (int j=0;j<a.length;j++){
        
        for (int i=0;i<wid;i++){
        
          int pos = i + j * wid;
          
          temp[i][j] = s1.get(pos);
        
      }}
      
    return temp;
};
  


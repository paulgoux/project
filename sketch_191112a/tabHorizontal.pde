class horizontaltabs extends tab {
  float x, y, w, h;
  String itemLabel;

  ArrayList<tab> tabs = new ArrayList<tab>();
  horizontaltabs parentnavh;
  verticaltabs parentnavv;
  horizontaltabs childnavh;
  verticaltabs childnavv;

  Window currentWindow = null;
  int windex = -1;
  //boolean navigator;

  horizontaltabs(float x, float y, float w, float h, float W, String [] titles) {

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    //canvas = createCanvas(w,h);
    for (int i=0; i<titles.length; i++) {

      String s = titles[i];

      tab t = new tab(x + W * i, y, w, h, s);
      Button b = new Button(x + w * i, y, w, 20);
      b.border = false;
      t.buttons.add(b);

      tabs.add(t);
    }

    sliderv = new Slider(x+w-10, y+20, 10, h-20);
    sliderv.vertical = true;
    sliderv.tvisible = false;
    sliderh = new Slider(x, y+h-10, w-10, 10);
    sliderh.tvisible = false;
    sliderh.tooltip = null;
  };

  horizontaltabs(float x, float y, float w, float h, String [] titles) {

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    //canvas = createCanvas(w,h);
    for (int i=0; i<titles.length; i++) {

      String s = titles[i];

      tab t = new tab(x + w * i, y, w, h, s);
      //t.buttons.add(new Button(x + w * i,y,w,20,s));
      tabs.add(t);
    }

    sliderv = new Slider(x+w-10, y+20, 10, h-20);
    sliderv.vertical = true;
    sliderv.tvisible = false;
    sliderh = new Slider(x, y+h-10, w-10, 10);
    sliderh.tvisible = false;
    sliderh.tooltip = null;
  };

  horizontaltabs(float x, float y, float w, float h, float W, int n) {

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    //canvas = createCanvas(w,h);
    for (int i=0; i<n; i++) {

      tab t = new tab(x + W * i, y, w, h);
      //t.buttons.add(new Button(x + W * i,y,w,20));
      tabs.add(t);
    }

    sliderv = new Slider(x+w-10, y+20, 10, h-20);
    sliderv.vertical = true;
    sliderv.tvisible = false;
    sliderh = new Slider(x, y+h-10, w-10, 10);
    sliderh.tvisible = false;
    sliderh.tooltip = null;
  };

  horizontaltabs(float x, float y, float w, float h, int n) {

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    //canvas = createCanvas(w,h);
    for (int i=0; i<n; i++) {

      tab t = new tab(x + w * i, y, w, h);
      t.buttons.add(new Button(0 + w * i, 0, w, 20));
      tabs.add(t);
    }

    sliderv = new Slider(x+w-10, y+20, 10, h-20);
    sliderv.vertical = true;
    sliderv.tvisible = false;
    sliderh = new Slider(x, y+h-10, w-10, 10);
    sliderh.tvisible = false;
    sliderh.tooltip = null;
  };

  horizontaltabs(float x, float y, float w, horizontaltabs n) {

    this.x = x;
    this.y = y;
    this.w = w;
    //this.h = h;
    parentnavh = n;
    //canvas = createCanvas(w,n.h);
    //canvas = createCanvas(w,h);
    for (int i=0; i<n.tabs.size(); i++) {
      String s = n.tabs.get(i).label;
      tab t = new tab(0, 0, w, h, s);
      t.parent = n.tabs.get(i);

      tabs.add(t);
      n.tabs.get(i).child = tabs.get(tabs.size()-1);
    }

    sliderv = new Slider(w-10, 20, 10, h-20);
    sliderv.vertical = true;
    sliderv.tvisible = false;
    sliderh = new Slider(0, h-10, w-10, 10);
    sliderh.tvisible = false;
    n.childnavh = this;
    sliderh.tooltip = null;
  };

  horizontaltabs(float x, float y, float w, float h, horizontaltabs n) {

    this.x = x;
    this.y = y;
    this.w = w ;
    this.h = h;
    parentnavh = n;
    
    canvas = createCanvas(w,h);
    
    for (int i=0; i<n.tabs.size(); i++) {
      
      String s = n.tabs.get(i).label;
      
      tab t = new tab(0, 0, w, h, s);
      t.parent = n.tabs.get(i);

      tabs.add(t);
      n.tabs.get(i).child = tabs.get(tabs.size()-1);
    }

    sliderv = new Slider(w-10, 20, 10, h-20);
    sliderv.vertical = true;
    sliderv.tvisible = false;
    sliderh = new Slider(0, h-10, w-10, 10);
    sliderh.tvisible = false;
    sliderh.tooltip = null;
    n.childnavh = this;
  };

  horizontaltabs(float x, float y, float w, verticaltabs n) {

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    parentnavv = n;

    for (int i=0; i<n.tabs.size(); i++) {
      String s = n.tabs.get(i).label;
      tab t = new tab(x + w * i, y, w, h, s);
      t.parent = n.tabs.get(i);
      tabs.add(t);
      n.tabs.get(i).child = tabs.get(tabs.size()-1);
    }

    sliderv = new Slider(x+w-10, y+20, 10, h-20);
    sliderv.vertical = true;
    sliderv.tvisible = false;
    sliderh = new Slider(x, y+h-10, w-10, 10);
    sliderh.tvisible = false;
    sliderh.tooltip = null;
    n.childnavh = this;
  };

  horizontaltabs(float x, float y, float w, float h, verticaltabs n) {

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    parentnavv = n;

    for (int i=0; i<n.tabs.size(); i++) {
      String s = n.tabs.get(i).label;
      tab t = new tab(x + w * i, y, w-40, h-40, s);
      t.parent = n.tabs.get(i);
      tabs.add(t);
      n.tabs.get(i).child = tabs.get(tabs.size()-1);
    }

    sliderv = new Slider(x+w-10, y+20, 10, h-20);
    sliderv.vertical = true;
    sliderv.tvisible = false;
    sliderh = new Slider(x, y+h-10, w-10, 10);
    sliderh.tvisible = false;
    sliderh.tooltip = null;
    n.childnavh = this;
  };
  
  void displayTabs() {
    fill(255);

    //if(childnavh!=null){
    //  text("Navigator h",x,y);
    //if(toggle)childnavh.toggle=true;
    //else childnavh.toggle = false;

    //childnavh.displayTabs();
    //}
    //if(childnavv!=null){
    //  //text("Navigator v",x,y);
    //if(toggle)childnavv.toggle=true;
    //else childnavv.toggle = false;

    //childnavv.displayTabs();
    //}
    tabindex = -1;
    logic();
    //canvas.beginDraw();
    if (toggle&&canvas!=null) {
      
      canvas.beginDraw();
      mouse = getMouse();
      
      for (int i=0; i<tabs.size(); i++) {
        tab t1 = tabs.get(i);
        tab t = t1.states.get(t1.state);
        if (t.toggle&&t.windows.get(0).toggle)currentWindow = t.windows.get(0);
        if (t.visible) {
          t.toggle = true;
          tabindex = i;
        }
        ////else if(tabindex>0)t.toggle = false;
        //if(t.toggle&&t.title.toggle==0)t.title.toggle = 1;

        //if (t.toggle)t.title.toggle=1;
        //else t.title.toggle = 0;
        if(t1.toggle){t.visible=true;t.toggle=true;t.title.toggle=1;}
        if(t.title.toggle!=1&&(t.toggle||t.visible)){t.toggle=true;t.visible = true;t.title.toggle=1;}
        
        if(!t.visible){t.toggle = false;}
        if (t.title.toggle==0&&t.toggle) {

          t.toggle= false;
          t.visible = false;
        } else if (t.title.toggle==1&&!t.toggle) {
        }

        if (t.title.pos()&&mousePressed)sliderset = false;

        else if ((t.title.pos()||t.posTab())&&mousePressed&&t.visible) {
          current = i;
          setTab = true;
        }

        if (t.child!=null&&t.displayChild) {
          if (t.visible||t.title.toggle==1) {
            //t.child.visible = true;
            //t.child.displayTabs();
          } else if (!t.visible) t.child.visible = false;
        }
        //if(t.toggle)
        t.displayTabs();
      }

      if (setTab) {
        tabindex = current;
        setTab = false;
      }
      //
      displayNavv();
      displayWindow();
      
      canvas.endDraw();
      image(canvas,x,y);
      displayNavh();
    }else canvas = createCanvas(w,h);
  };

  void displayTabs_() {
    fill(255);

    //if(childnavh!=null){
    //  text("Navigator h",x,y);
    //if(toggle)childnavh.toggle=true;
    //else childnavh.toggle = false;

    //childnavh.displayTabs();
    //}
    //if(childnavv!=null){
    //  //text("Navigator v",x,y);
    //if(toggle)childnavv.toggle=true;
    //else childnavv.toggle = false;

    //childnavv.displayTabs();
    //}
    
    tabindex = -1;
    logic();
    if (toggle) {
      for (int i=0; i<tabs.size(); i++) {

        tab t = tabs.get(i);
        if (t.toggle&&t.windows.get(0).toggle)currentWindow = t.windows.get(0);
        if (t.visible) {
          t.toggle = true;
          tabindex = i;
          t.title.toggle = 1;
          t.title.draw();
        }
        if (t.title.pos()&&mousePressed)sliderset = false;
        else if ((t.title.pos()||t.posTab())&&mousePressed&&t.visible) {
          current = i;
          setTab = true;
        }

        if (t.child!=null&&t.displayChild) {
          if (t.visible||t.title.toggle==1) {
            //t.child.visible = true;
            //t.child.displayTabs();
          } else if (!t.visible) t.child.visible = false;
        }
        //if(t.toggle)
        t.displayTabs();
      }

      if (setTab) {
        tabindex = current;
        setTab = false;
      }
      displayNavh();
      displayNavv();
      displayWindow();
    }
  };

  void displayNavh() {

    if (navigatorh!=null&&tabindex>-1) {

      setTabsh();
      navigatorh.canvas.beginDraw();
      navigatorh.canvas.background(50);
      navigatorh.mouse = new PVector(mouse.x - navigatorh.x,mouse.y-navigatorh.y);
      
      if(current_tab!=null)current_tab.mouse2 = navigatorh.mouse;
      if(previous_tab!=null)previous_tab.mouse2 = navigatorh.mouse;
      if(next_tab!=null)next_tab.mouse2 = navigatorh.mouse;
      //--------------------------------------------------------------
      
      float v = map(sliderh.value, -navigatorh.w/2, navigatorh.w/2, 0, navigatorh.w*2);

      current_tab.w = v;
      current_tab.x = sliderh.value ;
      current_tab.title.x = 0;
      
      if (current_tab.x<=10) {
        current_tab.x = 0;
        current_tab.title.x = 0;
        
      }
      //if (current_tab.x + current_tab.w >navigatorh.w)current_tab.w =   navigatorh.w - current_tab.x;

      if (current_tab.title!=null)current_tab.title.w = v;
      
      //-------------------------------------------------------------
      if (previous_tab!=null) {
        previous_tab.x = 0;

        float value = (current_tab.x);
        if(value>navigatorh.w)previous_tab.x = 0+value*2;
        
        if (previous_tab!=null&&previous_tab.title!=null) {
          previous_tab.title.x = previous_tab.x;
          previous_tab.title.w = value;
        }
        previous_tab.displayTabs(navigatorh.canvas);
      }
      //----------------------------------------------------------------
      current_tab.displayTabs(navigatorh.canvas);
      //current_tab.title.mouse = navigatorh.mouse;
      //current_tab.title.draw(navigatorh.canvas);
      //----------------------------------------------------------------
      if (next_tab!=null&&(!next_tab.visible || !next_tab.toggle)) next_tab = null;
      else if (next_tab!=null&&next_tab.visible && next_tab.toggle) {
        
        next_tab.x = v;
        
        if(next_tab.x+textWidth(next_tab.label)>=navigatorh.w){
          
        }
        float value = (sliderh.x + sliderh.w) - (current_tab.x + current_tab.w );
        //if (value>)
        next_tab.w = value + 10;

        if (next_tab.title!=null) {
          
          next_tab.title.w = value;
          next_tab.title.mouse = navigatorh.mouse;
        } 
        
        next_tab.displayTabs(navigatorh.canvas);
      }
      current_tab.w =  navigatorh.w;
      
      if (current_tab.title!=null)current_tab.title.w = navigatorh.w;

      if (navigatorh!=null&&navigatorh.visible) {
        if (toggle) {
          navigatorh.toggle = true;
          navigatorh.visible = true;
        } else {
          navigatorh.toggle = false;
          navigatorh.visible = false;
        }
      }
      //println(navigatorh.x,navigatorh.y,x,y);
      sliderControl(navigatorh.canvas);
      //navigatorh.canvas.fill(0);
      //navigatorh.canvas.ellipse(mouseX-navigatorh.x,mouseY-navigatorh.y,25,25);
      navigatorh.canvas.endDraw();
      
      
      image(navigatorh.canvas,navigatorh.x,navigatorh.y);
      fill(255);
      //ellipse(mouseX,mouseY,20,20);
      
    }

    //-----------------------------------------------------------------
  };

  void displayNavv() {
    if (tabindex!=-1) {
      if (navigatorv!=null) {

        setTabsv();

        if (navigatorv.visible) {
          if (toggle) {
            navigatorv.toggle = true;
            navigatorv.visible = true;
          } else {
            navigatorv.toggle = false;
            navigatorv.visible = false;
          }
        }

        sliderControl(canvas);
      }
    }
  };
  
  void logic(){
    //if(open){
    //  for(int i =0;i<tabs.size();i++){
    //    tab t = tabs.get(i);
    //    t.toggle = true;
    //    t.visible = true;
    //  }
    //}else{
    //  for(int i =0;i<tabs.size();i++){
    //    tab t = tabs.get(i);
    //    t.toggle = false;
    //    t.visible = false;
    //  }
    //}
  };

  void setTabsv() {



    if (navigatorv!=null&&tabindex>-1&&!setTab) {

      current_tab = navigatorv.tabs.get(tabindex);

      if (tabindex<tabs.size()-1)next_tab = navigatorh.tabs.get(tabindex + 1);
      else next_tab = null;

      if (tabindex>1)previous_tab = navigatorh.tabs.get(tabindex - 1);
      else previous_tab = null;

      if (current_tab!=null) {
        current_tab.toggle=true;
        current_tab.visible=true;
      }

      if (previous_tab!=null) {
        previous_tab.toggle=true;
        previous_tab.visible=true;
      }

      if (next_tab!=null) {
        next_tab.toggle=true;
        next_tab.visible=true;
      }
      setTab =true;
    }
  };

  void setTabsh() {
    fill(255);
    if (current>-1&&!setTab) {
      if (tabs.get(current).visible) {
        tabindex = current;
        setTab = true;
      }
    }
    if (navigatorh!=null&&tabindex>-1) {

      current_tab = navigatorh.tabs.get(tabindex);

      if (tabindex<tabs.size()-1)next_tab = navigatorh.tabs.get(tabindex + 1);
      else next_tab = null;

      if (tabindex>0)previous_tab = navigatorh.tabs.get(tabindex - 1);
      else previous_tab = null;

      if (current_tab!=null) {
        current_tab.toggle=true;
        current_tab.visible=true;
      }

      if (previous_tab!=null) {
        previous_tab.toggle=true;
        previous_tab.visible=true;
      }

      if (next_tab!=null) {
        next_tab.toggle=true;
        next_tab.visible=true;
      }
      setTab = true;
    }
  };


  void displayWindow() {
    if (currentWindow!=null)currentWindow.display_grid();
  };

  void displayNav() {
    //if(scrollable&&toggle){
    //  if(title==null){
    //  if(!sliderh.mdown){
    //    //sliderv.draw();
    //    //sliderv.mouse();
    //  }
    //  if(!sliderv.mdown){

    //    //sliderh.mouse();
    //    //sliderh.draw();
    //  }}}
  };

  void sliderControl(PGraphics canvas) {
    if (tabindex>-1) {
      
      if (current_tab!=null)sliderh.set(-current_tab.w, current_tab.w);
      if (!sliderset&&current_tab!=null) {
        sliderv = new Slider(current_tab.x+current_tab.w-10, current_tab.y+20, 10, current_tab.h-30);
        sliderv.vertical = true;
        sliderv.valuex = 0;
        sliderv.tooltip = null;
        sliderh.value = 0;
        sliderh.tooltip = null;
        sliderh = new Slider(current_tab.x, current_tab.y+current_tab.h - 10, current_tab.w-10, 10);
        sliderset = true;
      }
      //println(current_tab.x,current_tab.y);
      PVector m = new PVector(mouseX-navigatorh.x,mouseY-navigatorh.y);
      sliderv.mouse = m;
      if (!sliderh.mdown)sliderv.mouseFunctions(m);
      
      sliderv.parentCanvas = true;
      sliderv.parentTab = this;
      sliderv.draw(navigatorh.canvas);
      sliderh.mouse = m;
      if (!sliderv.mdown)sliderh.mouseFunctions(m);
      sliderh.parentTab = this;
      sliderh.parentCanvas = true;
      sliderh.draw(navigatorh.canvas);
    }
  };

  void states(int k){
    for(int i=0;i<tabs.size();i++){
      tab t = tabs.get(i);
      
      tab t1 = new tab(t.x,t.y,t.w,t.h);
      tab t2 = new tab(t.x,t.y,t.w,t.h,t.label);
      
      for(int j=0;j<k;j++){
        
        if(t.title!=null)t.states.add(t2);
        else t.states.add(t1);
        
    }}
  }

  void setWidth(int k, float W) {
    tabs.get(k).w = W;
    tabs.get(k).title.w = W;
    tab T = tabs.get(k);
    float cwidth = w;
    for (int i=k+1; i<tabs.size(); i++) {
      tab t = tabs.get(i);

      t.x =  T.x + cwidth;
      cwidth += t.w;
    }
  };
};
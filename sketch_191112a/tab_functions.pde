void tabsetup(){

  tab.tabs.get(0).toggle = true;
  for(int i=1;i<tab.tabs.size();i++){
    //if(i==1)i++;
    tab t = tab.tabs.get(i);
    t.toggle = false;
    t.border = true;
    t.visible = false;
    
    for(int j=0;i<t.windows.size()-1;j++){
    Window w1 = t.windows.get(j);
    
    w1.launchable = false;
    w1.quickAccess = true;
    w1.transparent = true;
    w1.border = true;
    
  }
  for(int j=0;j<t.states.size();j++){
    tab t1 = t.states.get(j);
    t1.toggle = false;
    if(t1.title!=null)t1.title.toggle=1;
    t1.border = true;
    t1.visible = false;
  }
}

  //tab.navigator = new horizontaltabs(300,400,600,200,tab);
  
  tab.tabs.get(0).border = true;
  tab.navigatorh = new horizontaltabs(300,400,600,200,tab);
  tab.navigatorh.scrollable = true;
  tab.navigatorh.parentnavh = tab;
  tab.toggle = false;
  Table_ t = new Table_(tab.navigatorh.x+10,tab.navigatorh.y+21,200,200,3,3,10);
  tab.tables.add(t);
  Window w1 = tab.tabs.get(1).windows.get(0);
  w1.launchable = false;
  w1.quickAccess = true;
  w1.transparent = true;
  w1.border = true;
};

void tabLogic(){
  tab tab1 = tab.tabs.get(0);
  tab tab2 = tab.tabs.get(1);
  tab tab3 = tab.tabs.get(2);
  tab tab4 = tab.tabs.get(3);
  tab tab5 = tab.tabs.get(4);
  tab tab6 = tab.tabs.get(5);
  tab tab7 = tab.tabs.get(6);
  
  // tab 1-------------Project------------------------
  
  tab tab00_01 = tab1.states.get(0);
  tab tab00_02 = tab1.states.get(1);
  tab tab00_03 = tab1.states.get(2);
  tab tab00_04 = tab1.states.get(3);
  tab tab00_05 = tab1.states.get(4);
  tab tab00_06 = tab1.states.get(5);
  
  // tab 2--------------Inputs--------------------------
  
  tab tab01_01 = tab2.states.get(0);
  tab tab01_02 = tab2.states.get(1);
  tab tab01_03 = tab2.states.get(2);
  tab tab01_04 = tab2.states.get(3);
  tab tab01_05 = tab2.states.get(4);
  tab tab01_06 = tab2.states.get(5);
  
  // tab 3------------Processing---------------------------
  
  tab tab02_01 = tab3.states.get(0);
  tab tab02_02 = tab3.states.get(1);
  tab tab02_03 = tab3.states.get(2);
  tab tab02_04 = tab3.states.get(3);
  tab tab02_05 = tab3.states.get(4);
  tab tab02_06 = tab3.states.get(5);
  
  // tab 4-------------------------------------------------
  
  tab tab03_01 = tab4.states.get(0);
  tab tab03_02 = tab4.states.get(1);
  tab tab03_03 = tab4.states.get(2);
  tab tab03_04 = tab4.states.get(3);
  tab tab03_05 = tab4.states.get(4);
  tab tab03_06 = tab4.states.get(5);
  
  // tab 5-------------------------------------------------
  
  tab tab04_01 = tab5.states.get(0);
  tab tab04_02 = tab5.states.get(1);
  tab tab04_03 = tab5.states.get(2);
  tab tab04_04 = tab5.states.get(3);
  tab tab04_05 = tab5.states.get(4);
  tab tab04_06 = tab5.states.get(5);
  
  // tab 6----------------Outputs-----------------
  
  tab tab05_01 = tab6.states.get(0);
  tab tab05_02 = tab6.states.get(1);
  tab tab05_03 = tab6.states.get(2);
  tab tab05_04 = tab6.states.get(3);
  tab tab05_05 = tab6.states.get(4);
  tab tab05_06 = tab6.states.get(5);
  
 
  };
  
  void tabfunctions(){
  tab tab1 = tab.tabs.get(0);
  
  //tab tab2 = tab.tabs.get(1).states.get(tab.tabs.get(1).state);
  tab tab2 = tab.tabs.get(1);
  tab tab3 = tab.tabs.get(2);
  tab tab4 = tab.tabs.get(3);
  tab tab5 = tab.tabs.get(4);
  tab tab6 = tab.tabs.get(5);
  tab tab7 = tab.tabs.get(6);
  
  int index = tab1.dmenus.get(1).index;
  int index2 = tab1.dmenus.get(0).index;
  fill(255);
  //text(index,100,90);
  //text(tab2.state,200,100);
  //     if(index==0||index==2)tab2.state = 0;
  ////else 
  if(index>-1)tab.tabs.get(1).state = index;
  ////else if(index==3)tab2.state = 2;
  //else tab2.state = 5;
  //tab2.state = 0;
  
  //-------------------------------------------------------------------------------------------
  
  int [] s1 = {0,1,2,3,4,5};
  
  if(index2>-1&&index>-1){
    tab2.visible=true;
    tab2.toggle=true;
  }
  //else {
  //  tab2.visible=false;
  //  tab2.toggle=false;
  //}
  
  //tab2.state = 4;
    
  if(tab2.toggle){
   
    if(index>=0&&index2>-1)tab2.buttons.get(0).toggle2(tab3,"toggle");
    Window w1 = tab2.windows.get(0);
    tab2.dmenus.get(0).items.get(0).mouse = tab2.mouse;
    //tab2.buttons.get(0).mouse = tab2.mouse;
    if((index<4&&index>-1)&&tab2.dmenus.size()>0)tab2.dmenus.get(0).items.get(0).latch(w1,"toggle");
  }
  if(tab3.toggle&&tab3.dmenus.get(0).index>-1)tab3.buttons.get(0).toggle2(tab4,"toggle");
  if(tab4.toggle&&tab4.dmenus.get(0).index>-1)tab4.buttons.get(0).toggle2(tab5,"toggle");
  if(tab5.toggle&&tab5.dmenus.get(0).index>-1)tab5.buttons.get(0).toggle2(tab6,"toggle");
  if(tab6.toggle&&tab6.dmenus.get(0).index>-1)tab6.buttons.get(0).toggle2(tab7,"toggle");
  
  Window w1 = tab1.windows.get(0);
  if(w1.currentp!=null&&mousePressed)tab.tabs.get(1).folder = w1.currentp;
  if(w1.currentf!=null&&mousePressed)tab.tabs.get(1).file = w1.currentf;
  
  //----------inuputs---------------------------------
 
  };

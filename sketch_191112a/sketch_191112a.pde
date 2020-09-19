PVector m = new PVector(0,0);
PVector n = new PVector(0,0);
PVector sub = new PVector(0,0);

import java.io.BufferedWriter;
import java.io.FileWriter;
float LEARNING_RATE = 0.001;

Network neuralnet;

int kk;
//PGraphics pg;
int gridrows = 100;
PApplet app = this;
//Human xxx = new Human(width/2,height/2);
String []kemp;
BMScontrols BMS = new BMScontrols(this);;
//PVector norm = new PVector(0,0);
float norm;
float theta = 0;
_tri tri1 = new _tri(200,200,10,20);
//Table t = new Table(300,600,200,200,2,2);
Html webpage = new Html("https://www.google.com/") ;

String []text;
String sentence = "This is a sentence!";

vectorText words;

import processing.sound.*;
import java.io.*;
import java.net.*;
import processing.core.PApplet;
//------------------apache word files-----
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.extractor.WordExtractor;

//-------------hashmap---------------
//import java.util.Hashtable;
//import java.util.Map;
//import java.util.List;
//import java.util.Map.Entry;
//-------------------clipboard---------
//import java.awt.*;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.Transferable;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.UnsupportedFlavorException;
import java.awt.Toolkit;
//-----------webcam------------------
import processing.video.*;
import processing.sound.*;
//----------reflections-----------------
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
//import java.awt.*;
//import java.lang.reflect.*;

//---------twitter----------------------
import twitter4j.conf.*; 
import twitter4j.api.*; 
import twitter4j.*; 
import java.util.*;  
TwitterStream twitterStream;

import processing.sound.*;
//JSONArray data;
 
boolean k1 = false;
PImage img;
//SetFieldValueExample n = new SetFieldValueExample();

void settings(){
  //Terrain3d = true;
    size(W,H,FX2D);
    //size(W,H,P2D);
  
  
};

void setup(){
  //surface.setResizable(true);
  //fullScreen();
  frame.setTitle("Neural Playground");
  //surface.setUndecorated();
  //Lines = loadStrings("http://www.gutenberg.org/files/61075/61075-h/61075-h.htm");
  //Lines = loadStrings("test.txt");
  //kemp = loadStrings("i.txt");
  BMS.begin();
  
  //text = loadStrings("example.txt");
  //words = new vectorText(text);
  //Spawn("human",200);
  //Spawn("plant",100);
  
}

void draw(){
  //webpage.getString();
  
  fill(255);
  background(bgcol);
  text(frameRate,50,100);
   kk = 0;
  //text(main.Boundaries.size(),100,150);
  //btn1.draw();
  //webpage.readString();
  //webpage.getLinks();
  //webpage.displayLinks();
  
  //words.classText();
  debug();
  //if(gcam!=null)gcam.cam_functions();
  
  BMS.run();
  Reset();
  
};


void keyPressed(){
  if(keyCode == 88)xdown = true;
  else xdown = false;
  if(keyCode == 89)ydown = true;
  else ydown = false;
  if (keyCode== 17){
    clipboard_toggle=1;
    ctrl = 1;
  }
  if(key=='A' && ctrl==1){
    selectAll = true;
  }
    
  if (key== 'V'&& clipboard_toggle==1&&!copy_clipboard) {
    k1 = true;
    copy_clipboard = true;
    pastedown = true;
  }else{
    k1 = false;
    copy_clipboard = false;
  }
};

void debug(){
  fill(255);
  //if(btn2.toggle==1)text("plot",200,460);
  //if(file.pos())text("file",200,470);
  //if(open_menus)text("menuall",200,480);
  //if(btn57.toggle==1)text("camera",200,500);
  //if(gcam.cam!=null)text(gcam.camsquares.size(),200,510);
  //if(btn61.toggle==1)text("image",200,520);
  //if(gimg.convolved)text("convolved",200,530);
  //if(btn55.toggle==1)text("terrain",200,540);
  //if(g.toggle)text(g.squares.size(),200,550);
  //text(frameRate,1000,560);
  //if(clipboard_toggle==1)text("ctrl",100,100);
  //if(k1)text("copy",100,100);
};



void mousePressed(){
  for(Menu menu : BMS.menus)menu.click();
};

void mouseReleased(){
  
}

void keyReleased(){
  clipboard_toggle = 0;
  if(keyCode==88)xdown = false;
  if(keyCode==89)ydown = false;
  if (keyCode== 17)clipboard_toggle = 0;copy_clipboard = false;ctrl=0;
  if(key=='V'){ copy_clipboard = false;textb1.copied = false;clipboard_toggle=0;}
  if(key=='A'){selectAll = false;}
}
void mouseClicked(){
  BMS.click();
};

void mouseDragged(){
  
  file.dpos();
  BMS.slider_functions();
}

void openTwitter(){
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("2Z674FTQPomH4YbajPzLjBqQQ");
  cb.setOAuthConsumerSecret("Tf7QLmQWpJjBLHwUgFP8fUlncO5bYpI2XSFHMHoTn5Ph4uQwp8");
  cb.setOAuthAccessToken("3399736859-NH842wgutewgcAEox6RuHtVAOYFHWdKC50BmMUp");
  cb.setOAuthAccessTokenSecret("bmNK9MX2BTqoLGWPT6qICqLobQYpR4NbtWSPpEX9YY47G");
  
  twitterStream = new TwitterStreamFactory(cb.build()).getInstance();
  
  FilterQuery filtered = new FilterQuery();
  
  String [] Keywords = twitterKeywords.getKeywords();
  
  filtered.track(Keywords);
  
  twitterStream.addListener(listener);
  
  if(Keywords.length==0) twitterStream.sample();
  else twitterStream.filter(filtered);
};

StatusListener listener = new StatusListener(){
  
  //override 
  public void onStallWarning(StallWarning warning){
    
    if(twitterKeywords.toggle)System.out.println("Got stall warning " + warning);
    
  };
  
  public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice){
    if(twitterKeywords.toggle)System.out.println("Deleted " + statusDeletionNotice);
  };
  
  
  public void onException(java.lang.Exception ex){
    if(twitterKeywords.toggle)System.out.println("Exception");
  };
  
  public void onTrackLimitationNotice(int numberOfLimitedStatuses){
    if(twitterKeywords.toggle)System.out.println("Get track limitation notices " + numberOfLimitedStatuses);
  };
  
  public void onScrubGeo(long userId,long upToStatusId){
    if(twitterKeywords.toggle)System.out.println(" Get scrub notice" + userId + "up to " + upToStatusId);
  }
  
  public void onStatus(Status status){
    if(twitterKeywords.toggle)System.out.println(status.getUser().getScreenName() + status.getText());
  };
};

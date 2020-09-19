class webcam{
  String[] cameras = Capture.list();
  Capture cam;
  PApplet applet;
  
  webcam(PApplet app){
    applet = app;
    if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    //exit();
    } else {
      println(cameras.length + " Available cameras:");
      for (int i = 0; i < cameras.length; i++) {
        println(i + " " + cameras[i]);
      }
      
      // The camera can be initialized directly using an 
      // element from the array returned by list():
      cam = new Capture(app, cameras[26]);
      cam.start();     
    }
  };
  
  void display(){
    if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0);
  };

  void display(PGraphics c){
    if (cam.available() == true) {
    cam.read();
  }
  c.beginDraw();
  c.image(cam, 0, 0);
  c.endDraw();
  };
  
  void display(float x, float y){
    if (cam.available() == true)cam.read();
    else println("no Cam");
    image(cam, x, y);
  };
  
  PImage get(){
    return cam;
  };
  
};
class Dock{

    float x,y,w,h,currentWidth,currentHeight;
    ArrayList<String> names = new ArrayList<String>();
    ArrayList<Button> buttons = new ArrayList<Button>();
    ArrayList<PGraphics> canvases = new ArrayList<PGraphics>();
    ArrayList<Object> objects = new ArrayList<Object>();
    boolean update,vertical,horizontal,mdown;
    String loc;
    Object currentObject;

    Dock(float x,float y,float w,float h){
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
    };

    void dock(){
        
        if(mousePressed&&!pos()&&BMS.currentMouseObject!=null&&!mdown){
            mdown = true;
            //println(names.size(),names.contains(BMS.currentMouseObject),BMS.currentMouseObject);
            loc = BMS.currentMouseObject;
            currentObject = BMS.currentObject;
            update = false;
        }
        
        if(!update&&mdown&&!mousePressed&&pos()&&!names.contains(BMS.currentMouseObject)){
            
            update = true;
            mdown = false;
            
            //println(update,loc,names.contains(loc),"step2");
        }
        if(pos()&&update&&loc!=null&&!names.contains(loc)){
            BMS.currentMouseObject = null;
            BMS.currentObject = null;
            PGraphics canvas = createGraphics((int)textWidth(loc)+20,20);
            canvases.add(canvas);
            
            Button b = new Button(currentWidth,y,textWidth(loc)+20,20,loc);
            b.togglebox = true;
            buttons.add(b);
            objects.add(currentObject);
            currentWidth += textWidth(loc)+20;
            names.add(loc);
            update = false;
            mdown = false;
            loc = null;
            currentObject = null;
            //println(currentWidth,loc,"step3");
        }
        if(!mousePressed){
            mdown = false;
        }
    };

    void draw(){

        // canvas.beginDraw();

        // canvas.endDraw();
        // image(canvas,x,y);

    };

    void draw(PGraphics canvas){

        canvas.beginDraw();

        canvas.endDraw();
        image(canvas,x,y);

    };

    void drawItems(){
        
        for(int i=0;i<buttons.size();i++){
            Button b = buttons.get(i);
            canvases.get(i).beginDraw();
            
            b.x = 1;
            b.y = 1;
            b.mouse = getMouse(b);
            
            if(b.pos(b.mouse))b.highlight();
            
            //println(objects.get(i));
            b.draw(canvases.get(i));
            b.toggle(objects.get(i),"visible",canvases.get(i));
            canvases.get(i).endDraw();
            image(canvases.get(i),b.bx,b.by);
        }
        if(pos()&&mousePressed){
            noFill();
            stroke(0);
            strokeWeight(2);
            rect(x,y,w,h);
        }
    };

    PVector getMouse(Button b){

        return new PVector(mouseX-x-b.bx,mouseY-y);
    };

    PVector getMouse(){

        return new PVector(mouseX-x,mouseY-y);
    };

    boolean pos(){
        return mouseX>x&&mouseX<x+w&&mouseY>y&&mouseY<y+h;
    };

    boolean pos(PVector mouse){
        return mouse.x>x&&mouse.x<x+w&&mouse.y>y&&mouse.y<y+h;
    };

};
class verticaltabs extends tab {

  float x, y, w, h;
  String itemLabel;

  ArrayList<tab> tabs = new ArrayList<tab>();

  horizontaltabs parentnavh;
  verticaltabs parentnavv;
  horizontaltabs childnavh;
  verticaltabs childnavv;

  verticaltabs(float x, float y, float w, float h, float H, String [] titles) {

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    for (int i=0; i<titles.length; i++) {

      String s = titles[i];

      tab t = new tab(x, y + H * i, w, H, s);
      tabs.add(t);
    }

    sliderv = new Slider(x+w-10, y+20, 10, h-20);
    sliderv.vertical = true;
    sliderv.tvisible = false;
    sliderh = new Slider(x, y+h-10, w-10, 10);
    sliderh.tvisible = false;
  };

  verticaltabs(float x, float y, float w, float h, String [] titles) {

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    for (int i=0; i<titles.length; i++) {

      String s = titles[i];

      tab t = new tab(x, y + h * i, w, h, s);
      tabs.add(t);
    }
    sliderv = new Slider(x+w-10, y+20, 10, h-20);
    sliderv.vertical = true;
    sliderv.tvisible = false;
    sliderh = new Slider(x, y+h-10, w-10, 10);
    sliderh.tvisible = false;
  };

  verticaltabs(float x, float y, float w, float h, float H, int n) {

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    for (int i=0; i<n; i++) {
      tab t = new tab(x, y + H * i, w, H);
      tabs.add(t);
    }

    sliderv = new Slider(x+w-10, y+20, 10, h-20);
    sliderv.vertical = true;
    sliderv.tvisible = false;
    sliderh = new Slider(x, y+h-10, w-10, 10);
    sliderh.tvisible = false;
  };

  verticaltabs(float x, float y, float w, float h, int n) {

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    for (int i=0; i<n; i++) {
      tab t = new tab(x, y + h * i, w, h);
      tabs.add(t);
    }

    sliderv = new Slider(x+w-10, y+20, 10, h-20);
    sliderv.vertical = true;
    sliderv.tvisible = false;
    sliderh = new Slider(x, y+h-10, w-10, 10);
    sliderh.tvisible = false;
  };

  verticaltabs(float x, float y, float w, verticaltabs n) {

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    parentnavv = n;

    for (int i=0; i<n.tabs.size(); i++) {
      String s = n.tabs.get(i).label;
      tab t = new tab(x, y + h * i, w, h, s);
      tabs.add(t);
    }
    n.childnavv = this;
  };

  verticaltabs(float x, float y, float w, horizontaltabs n) {

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    parentnavh = n;

    for (int i=0; i<n.tabs.size(); i++) {
      String s = n.tabs.get(i).label;
      tab t = new tab(x, y + h * i, w, h, s);
      tabs.add(t);
    }

    sliderv = new Slider(x+w-10, y+20, 10, h-20);
    sliderv.vertical = true;
    sliderv.tvisible = false;
    sliderh = new Slider(x, y+h-10, w-10, 10);
    sliderh.tvisible = false;
    n.childnavv = this;
  };

  void displayTabs() {
    for (int i=0; i<tabs.size(); i++) {

      tab t = tabs.get(i);
      t.displayTab();
    }
  };
};
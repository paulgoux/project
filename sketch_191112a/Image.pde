class Image extends Grid {

  ArrayList<PImage> images = new ArrayList<PImage>();
  ArrayList<ArrayList<PImage>> segmentations = new ArrayList<ArrayList<PImage>>();
  boolean dotp, maxp, minp, kmeans, colour, bw, rgb;
  HashMap<Integer, Integer> processCount = new HashMap<Integer, Integer>();
  PImage image;

  Image(ArrayList<PImage> image, float threshold) {

    for (int i=0; i<image.size(); i++) {
      images.add(image.get(i));
    }
  };

  Image(PImage image ) {
    images.add(image);
  };

  void init() {
    if (!init) {
      for (int i=0; i<image.height; i++) {
        for (int j=0; j<image.width; j++) {
        }
      }
    }
  };

  void rescale() {
  };

  void process(Float[]Kernel) {

    int ky = Kernel.length;


    for (int i=0; i<images.size(); i++) {

      PImage p = images.get(i);
      p.loadPixels();

      for (int y=0; y<p.height; y++) {
        for (int x=0; x<p.width; x++) {
        }
      }
      p.updatePixels();
    }
  };

  void process(float[][]Kernel) {

    for (int i=0; i<images.size(); i++) {

      PImage p = images.get(i);
      PImage p2 =  createImage(p.width, p.height, RGB);
      p2.loadPixels();
      for (int y=0; y<p.height; y++) {
        for (int x=0; x<p.width; x++) {

          if (bw)pixels[x+y*image.width] = convolveB(x, y, Kernel);
          else if (rgb)pixels[x+y*image.width] = convolveRGB(x, y, Kernel);
          else if (kmeans)pixels[x+y*image.width] = kmeans(x, y, Kernel);
          else if (maxp)pixels[x+y*image.width] = maxPooling(x, y, Kernel);
          else if (minp)pixels[x+y*image.width] = minPooling(x, y, Kernel);
          else if (dotp)pixels[x+y*image.width] = dotPooling(x, y, Kernel);
        }
      }

      p2.updatePixels();
      ArrayList<PImage> convolution = new ArrayList<PImage>();

      if (segmentations.size()<i) {
        convolution.add(p2);
        segmentations.add(convolution);
      } else segmentations.set(i, convolution);

      if (processCount.get(i)==null)processCount.put(i, segmentations.get(i).size());
      else processCount.replace(i, segmentations.get(i).size());
    }
  };

  color kmeans(int x, int y, float[][] kernel) {
    int sy = y-floor(kernel.length/2);
    int sx = x-floor(kernel[0].length/2);

    int ey = y+floor(kernel.length/2); 
    int ex = x+floor(kernel[0].length/2);

    color c = color(0);

    for (int i=sy; i<ex; i++) {
      for (int j=sx; j<ey; j++) {

        //if(brightness(image.pixels[i+j*image.width])>c)c = brightness(image.pixels[i+j*image.width]);
      }
    }

    return c;
  };

  color maxPooling(int x, int y, float[][] kernel) {
    int sy = y-floor(kernel.length/2);
    int sx = x-floor(kernel[0].length/2);

    int ey = y+floor(kernel.length/2); 
    int ex = x+floor(kernel[0].length/2);

    color c = color(0);

    for (int i=sy; i<ex; i++) {
      for (int j=sx; j<ey; j++) {

        if (brightness(image.pixels[i+j*image.width])>c)c = int(brightness(image.pixels[i+j*image.width]));
      }
    }

    return c;
  };

  color minPooling(int x, int y, float[][] kernel) {

    int sy = y-floor(kernel.length/2);
    int sx = x-floor(kernel[0].length/2);

    int ey = y+floor(kernel.length/2); 
    int ex = x+floor(kernel[0].length/2);

    color c = color(255);
    int count = 0;

    for (int i=sy; i<ex; i++) {
      for (int j=sx; j<ey; j++) {

        if (brightness(image.pixels[i+j*image.width])<c)c = int(brightness(image.pixels[i+j*image.width]));
      }
    }

    c /= count;

    return c;
  };

  color avPooling(int x, int y, float[][] kernel) {
    int sy = y-floor(kernel.length/2);
    int sx = x-floor(kernel[0].length/2);

    int ey = y+floor(kernel.length/2); 
    int ex = x+floor(kernel[0].length/2);

    color c = color(0);
    int count = 0;

    for (int i=sy; i<ex; i++) {
      for (int j=sx; j<ey; j++) {

        c+= brightness(image.pixels[i+j*image.width]);
      }
    }

    c /= count;

    return c;
  };

  color dotPooling(int x, int y, float[][] kernel) {

    int sy = y-floor(kernel.length/2);
    int sx = x-floor(kernel[0].length/2);

    int ey = y+floor(kernel.length/2); 
    int ex = x+floor(kernel[0].length/2);

    color c = color(0);

    for (int i=sy; i<ex; i++) {
      for (int j=sx; j<ey; j++) {

        c+= brightness(image.pixels[i+j*image.width]);
      }
    }

    return c;
  };

  color convolveB(int x, int y, float[][] kernel) {

    int sy = y-floor(kernel.length/2);
    int sx = x-floor(kernel[0].length/2);

    int ey = y+floor(kernel.length/2); 
    int ex = x+floor(kernel[0].length/2);

    color c = color(0);

    for (int i=sy; i<ex; i++) {
      for (int j=sx; j<ey; j++) {

        c+= brightness(image.pixels[i+j*image.width]);
      }
    }

    return c;
  };

  color convolveRGB(int x, int y, float[][] kernel) {

    int sy = y-floor(kernel.length/2);
    int sx = x-floor(kernel[0].length/2);

    int ey = y+floor(kernel.length/2); 
    int ex = x+floor(kernel[0].length/2);

    color c = color(0);

    for (int i=sy; i<ex; i++) {
      for (int j=sx; j<ey; j++) {

        c+= image.pixels[i+j*image.width];
      }
    }

    return c;
  };

  color hog(int x, int y, float[][] kernel) {

    int sy = y-floor(kernel.length/2);
    int sx = x-floor(kernel[0].length/2);

    int ey = y+floor(kernel.length/2); 
    int ex = x+floor(kernel[0].length/2);

    color c = color(0);

    for (int i=sy; i<ex; i++) {
      for (int j=sx; j<ey; j++) {

        c+= image.pixels[i+j*image.width];
      }
    }

    return c;
  };
};
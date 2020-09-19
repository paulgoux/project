/*

 Charles Fried - 2017
 ANN Tutorial 
 Part #2
 
 NETWORK
 
 This class is for the neural network, which is hard coded with three layers: input, hidden and output
 
 */
int SOBEL = 0, MAX_POOLING = 1, AVE_POOLING = 2, MIN_POOLING = 3, CANNY, PREWITT = 4, GAUSSIAN_BLUR = 5;
class Network {

  int totalTrain, totalTest, totalRight, testCard, trainCard, matchingCC,maxPm;
  float sucess = 0,x,y,w = width,h = height;

  String type = "mnist";
  PImage tempImage;
  String link1 = "emnist-"+type+"-train-images-idx3-ubyte";
  String link2 = "emnist-"+type+"-test-images-idx3-ubyte";
  String link3 = "emnist-"+type+"-train-labels-idx1-ubyte";
  String link4 = "emnist-"+type+"-test-labels-idx1-ubyte";

  int [][]SobelV = {{1, 0, 1}, 
                    {1, 0, 1}, 
                    {1, 0, 1}};

  int [][]SobelH = {{1, 1, 1}, 
                    {0, 0, 0}, 
                    {1, 1, 1}};

  int [][]Sobel00 = {{0, 1, 0}, 
                     {1, 0, 1}, 
                     {0, 1, 0}};

  int [][]Sobel01 = {{1, 0, 1}, 
                     {0, 1, 0}, 
                     {1, 0, 1}};
                     
  int [][]maxPooling = {{1, 1}, 
                        {1, 1}};
                        
  int [][]gaussian = {{1, 0, 1}, 
                      {0, 1, 0}, 
                      {1, 0, 1}};

  ArrayList<int [][]>convolutions = new ArrayList<int [][]>();
  ArrayList<int [][]>countedConvolutions = new ArrayList<int [][]>();

  byte []trainingData, testingData, testingLabels, trainingLabels;

  Neuron [] input_layer, hidden_layer, output_layer, previous_layer, PVinputLayer, PVhiddenLayer, PVoutputLayer;
  ArrayList<Neuron []> hiddenLayers;
  int bestIndex = 0, N, N1, inputs_, hidden_, outputs_, stacks_ = 1;
  boolean deep, convolutionCC,convolutionWritten;
  fileOutput output,convolutionOutput;
  String loc = "nn\\positions.txt";
  String loc1 = "nn\\convolutions.txt";

  Button trainB, testB,reset, test, loadFile, saveFile, openFile,saveConvolutions,loadConvolutions,
          loadTrainingData,loadTestingData,loadTrainingLabels,loadTestingLabels;

  String menuLabels [] = {"Load File","Save to File","Open Folder","Save Convolutions","Open Convolutions","Load Training Data","Load Testing Data", "Load Training Labels","Load Testing Labels"};
  String drawMenuLabels [] = {"Reset","Test"};
  Menu menu,drawMenu;
  Input input;
  fileInput convolutionInput;
  Data data;

  Card [] testingSet, trainingSet;
  Card tempCard;

  Network() {
    init2();
  };

  Network(String location) {
    loc = location;

    init();
  };

  Network(int inputs, int hidden, int outputs) {

    init();
    inputs_ = inputs;
    hidden_ = hidden;
    outputs_ = outputs;

    input_layer = new Neuron [inputs*inputs];
    hidden_layer = new Neuron [hidden*hidden];
    output_layer = new Neuron [outputs];
    String text = inputs + "," + hidden + "," + outputs;

    for (int i = 0; i < input_layer.length; i++) {
      input_layer[i] = new Neuron();
    }

    for (int j = 0; j < hidden_layer.length; j++) {
      hidden_layer[j] = new Neuron(input_layer);
      for (int i = 0; i < hidden_layer[j].inputs.length; i++) {
        //output.write(hidden_layer[j].inputs[i] + " " + hidden_layer[j].weights[i] + " " + hidden_layer[j].biases[i]);
      }
    }

    for (int k = 0; k < output_layer.length; k++) {
      output_layer[k] = new Neuron(hidden_layer);
    }


    N = inputs;
    N1 = hidden;
  };


  Network(int inputs, int hidden, int outputs, String s) {
    loc = s;
    output = new fileOutput(loc);
    init();

    inputs_ = inputs;
    hidden_ = hidden;
    outputs_ = outputs;

    input_layer = new Neuron [inputs*inputs];
    hidden_layer = new Neuron [hidden*hidden];
    output_layer = new Neuron [outputs];

    for (int i = 0; i < input_layer.length; i++) {
      input_layer[i] = new Neuron();
    }

    for (int j = 0; j < hidden_layer.length; j++) {
      hidden_layer[j] = new Neuron(input_layer);
    }

    for (int k = 0; k < output_layer.length; k++) {
      output_layer[k] = new Neuron(hidden_layer);
    }

    N = inputs;
    N1 = hidden;
  };

  Network(int inputs, int hidden, int outputs, int n) {

    inputs_ = inputs;
    hidden_ = hidden;
    outputs_ = outputs;
    stacks_ = n;

    init();

    input_layer  = new Neuron [inputs*inputs];
    hiddenLayers = new ArrayList<Neuron []>();
    hidden_layer = new Neuron [hidden*hidden];
    output_layer = new Neuron [outputs];

    for (int i = 0; i < input_layer.length; i++) {
      input_layer[i] = new Neuron();
    }

    previous_layer = input_layer;

    for (int i=0; i<n; i++) {

      hidden_layer = new Neuron [hidden*hidden];
      for (int j = 0; j < hidden_layer.length; j++) {
        hidden_layer[j] = new Neuron(previous_layer);
      }
      previous_layer = hidden_layer;
      hiddenLayers.add(hidden_layer);
    }

    for (int k = 0; k < output_layer.length; k++) {
      output_layer[k] = new Neuron(hiddenLayers.get(hiddenLayers.size()-1));
    }

    N = inputs;
    N1 = hidden;
  };

  Network(int inputs, int hidden, int outputs, int n, int [] operations) {


    int [] temp = new int [1+(hidden-2)*(hidden-2)];
    for (int i=0; i<operations.length; i++) {
      int k = operations[i];

      switch(k) {
        //temp = new int[(hidden-2)*(hidden-2)];
      }
    }

    inputs_ = inputs;
    hidden_ = hidden;
    outputs_ = outputs;
    stacks_ = n;

    init();
    int inputNodes = 0;
    input_layer  = new Neuron [inputNodes];
    hiddenLayers = new ArrayList<Neuron []>();
    hidden_layer = new Neuron [hidden*hidden];
    output_layer = new Neuron [outputs];

    for (int i = 0; i < input_layer.length; i++) {
      input_layer[i] = new Neuron();
      //input_layer[i].outputs = new float[inputNodes];
    }

    previous_layer = input_layer;

    for (int i=0; i<n; i++) {

      hidden_layer = new Neuron [hidden*hidden];
      for (int j = 0; j < hidden_layer.length; j++) {
        hidden_layer[j] = new Neuron(previous_layer);
      }
      previous_layer = hidden_layer;
      hiddenLayers.add(hidden_layer);
    }

    for (int k = 0; k < output_layer.length; k++) {
      output_layer[k] = new Neuron(hiddenLayers.get(hiddenLayers.size()-1));
    }

    N = inputs;
    N1 = hidden;
  };

  void init() {
    menu = new Menu(width - 150,160,70,menuLabels);
    drawMenu = new Menu(width - 200,250,drawMenuLabels);

    output = new fileOutput(loc);
    convolutionOutput = new fileOutput(loc1,false);
    convolutionInput = new fileInput();
    data = new Data();

    trainingData = loadBytes(link1);
    testingData = loadBytes(link2);
    trainingLabels = loadBytes(link3);
    testingLabels = loadBytes(link4);

    data.loadTrainingData(trainingData, 60000, 28);
    trainingSet = new Card[60000];
    testingSet = new Card[10000];

    for (int i=0; i<data.trainingData.length; i++) {
      Card c = new Card(data.inputs.get(i), i, 0);
      trainingSet[i] = c;
    }

    data.loadTestingData(trainingData, 10000, 28);
    for (int i=0; i<data.testingData.length; i++) {
      Card c = new Card(data.inputs.get(i), i, 1);
      testingSet[i] = c;
    }
    
    data.loadTrainingLabels(trainingLabels);

    for (int i=0; i<trainingSet.length; i++) {
      Card c = trainingSet[i];

      for (int j = 0; j < 10; j++) {  // We then set the correct index in output[] to +1 if it corresponds to the ouput and -1 if not
        if (data.trainingLabels[i] == j)c.outputs[j] = 1.0;
        else c.outputs[j] = -1.0;
      }
    }

    data.loadTestingLabels(testingLabels);

    for (int i=0; i<testingSet.length; i++) {
      Card c = testingSet[i];
      c.output = data.trainingLabels[i];
      for (int j = 0; j < 10; j++) {  // We then set the correct index in output[] to +1 if it corresponds to the ouput and -1 if not
        if (data.trainingLabels[i] == j)c.outputs[j] = 1.0;
        else c.outputs[j] = -1.0;
      }
    }
    float xx = width - 150;
    float yy = 160;
    float spacing = 20;
    
    input = new Input(xx - 120, 200);
    reset = new Button(xx, yy, 40, 20, "Reset");
    test = new Button(xx, yy + spacing, 40, 20, "Test");
    // loadFile = new Button(xx, yy + spacing * 2, 60, 20, "Load File");
    // saveFile = new Button(xx, yy + spacing * 3, 60, 20, "Save to File");
    // openFile = new Button(xx, yy + spacing * 4, 90, 20, "Open File");
    // saveConvolutions = new Button(xx, yy + spacing * 4, 60, 20, "Save Convolutions");
    // loadConvolutions = new Button(xx, yy + spacing * 5, 90, 20, "Open Convolutions");
    // loadTrainingData = new Button(xx, yy + spacing * 6, 60, 20, "Load Training Data");
    // loadTestingData = new Button(xx, yy + spacing * 7, 60, 20, "Load Testing Data");
    // loadTrainingLabels = new Button(xx, yy + spacing * 8, 60, 20, "Load Training Labels");
    // loadTestingLabels = new Button(xx, yy + spacing * 9, 60, 20, "Load Testing Labels");
    // stroke(0);
    //loadData();
    trainB = new Button(width*0.06, height*0.9,50,20, "Train");
    testB = new Button(width*0.11, height*0.9,50,20, "Test");

    convolutions.add(SobelV);
    convolutions.add(SobelH);
    convolutions.add(Sobel00);
    convolutions.add(Sobel01);
    //permute();
    maxPm = 512;
  };
  
  void init2() {
    output = new fileOutput(loc);
    convolutionOutput = new fileOutput(loc1,false);
    convolutionInput = new fileInput();

    data = new Data();
    
    float xx = width - 150;
    float yy = 160;
    float spacing = 20;
    
    input = new Input(xx - 120, 200);
    reset = new Button(xx, yy, 40, 20, "Reset");
    test = new Button(xx, yy + spacing, 40, 20, "Test");
    // loadFile = new Button(xx, yy + spacing * 2, 60, 20, "Load File");
    // saveFile = new Button(xx, yy + spacing * 3, 60, 20, "Save to File");
    // openFile = new Button(xx, yy + spacing * 4, 90, 20, "Open File");
    // saveConvolutions = new Button(xx, yy + spacing * 4, 60, 20, "Save Convolutions");
    // loadConvolutions = new Button(xx, yy + spacing * 5, 90, 20, "Open Convolutions");
    // loadTrainingData = new Button(xx, yy + spacing * 6, 60, 20, "Load Training Data");
    // loadTestingData = new Button(xx, yy + spacing * 7, 60, 20, "Load Testing Data");
    // loadTrainingLabels = new Button(xx, yy + spacing * 8, 60, 20, "Load Training Labels");
    // loadTestingLabels = new Button(xx, yy + spacing * 9, 60, 20, "Load Testing Labels");
    // stroke(0);
    // //loadData();
    trainB = new Button(width*0.06, height*0.9,40,20, "Train");
    testB = new Button(width*0.11, height*0.9,40,20, "Test");

    convolutions.add(SobelV);
    convolutions.add(SobelH);
    convolutions.add(Sobel00);
    convolutions.add(Sobel01);
    //permute();
    maxPm = 512;
  };

  Card loadImage(PImage image) {

    tempCard = new Card();

    for (int i = 0; i < 784; i++) {
      if (red(image.pixels[i])<50)tempCard.inputs[i] = -10;
      if (red(image.pixels[i])>50)tempCard.inputs[i] = map(red(image.pixels[i])+20, 0, 255, -1, 1); 
      else tempCard.inputs[i] = -1;
      map(red(image.pixels[i]), 0, 255, -1, 1);
    }
    return tempCard;
  };

  PImage loadImage(PImage image, boolean bool) {

    tempImage = createImage(inputs_, inputs_, RGB);

    for (int i = 0; i < inputs_*inputs_; i++) {
      tempImage.pixels[i] = image.pixels[i];
    }
    return tempImage;
  };


  void load() {
  };

  void load(String s) {
  };

  void save() {
    println("Saving File..."+ loc);
    output.open();
    String text = "";
    if (stacks_ == 0)text = inputs_ + "," + hidden_ + "," + outputs_ + ",";
    else text = inputs_ + "," + hidden_ + "," + outputs_ + "," + stacks_;
    output.write(text);

    for (int i = 0; i < input_layer.length; i++) {
      if (input_layer[i].weights!=null)
        for (int j = 0; j < input_layer[i].weights.length; j++) {
          output.write(input_layer[i].inputs[j].output + " " + input_layer[i].weights[j] + " " + input_layer[i].biases[j]);
        } else 
      for (int j = 0; j < inputs_* inputs_; j++) {
        output.write(0 + " " + 0 + " " + 0);
      }
    }

    output.write("");

    for (int i=0; i<stacks_; i++) {

      for (int j = 0; j < hidden_layer.length; j++) {
        for (int k = 0; k < hidden_layer[j].inputs.length; k++) {
          output.write(hidden_layer[j].inputs[k].output + "," + hidden_layer[j].weights[k] + "," + hidden_layer[j].biases[k]);
        }
      }
    }

    output.write("");

    for (int k = 0; k < output_layer.length; k++) {
      for (int j = 0; j < output_layer[k].inputs.length; j++) {
        output.write(output_layer[k].inputs[j].output + "," + output_layer[k].weights[j] + "," + output_layer[k].biases[j]);
      }
    }
    output.close();
  };
  
  void saveConvolutions(){
    println("Saving File...");
    convolutionOutput.open();
    for(int i=0;i<convolutions.size();i++){
      for(int j=0;j<convolutions.get(i).length;j++){
        
        convolutionOutput.write(str(convolutions.get(i)[j]));
        //convolutionOutput.write("hello");
    }
    convolutionOutput.write("");
    }
    convolutionOutput.close();
    println("Saved!");
  };

  void listen() {
    if (menu.items.get(0).pos())BMS.File.listen();
    if (BMS.File.value!=null) {
      loc = BMS.File.value;
      println("User " + BMS.File.value);
      BMS.File.value = null;
      loadFile(BMS.File.value);
    }
    
    if (menu.items.get(4).pos())convolutionInput.listen();
    if (convolutionInput.value!=null) {
      loc1 = convolutionInput.value;
      println("User " + convolutionInput.value);
      convolutionInput.value = null;
      //loadConvolutions(file.value);
    }
    //if(file.listen()!=null)
    //println(file.listen());
  };

  void loadFile(String s) {
  };

  void respond(Card card) {

    if (!deep) {
      for (int i = 0; i < input_layer.length; i++) {
        input_layer[i].output = card.inputs[i];
      }
      // now feed forward through the hidden layer
      for (int j = 0; j < hidden_layer.length; j++) {
        hidden_layer[j].respond();
      }
      for (int k = 0; k < output_layer.length; k++) {
        output_layer[k].respond();
      }
    }
  };

  void respond(PImage card) {

    card.loadPixels();

    for (int i = 0; i < input_layer.length; i++) {
      input_layer[i].output = card.pixels[i];
    }
    // now feed forward through the hidden layer
    for (int j = 0; j < hidden_layer.length; j++) {
      hidden_layer[j].respond();
    }
    for (int k = 0; k < output_layer.length; k++) {
      output_layer[k].respond();
    }
  };

  void respondDeep(Card card) {

    for (int i = 0; i < input_layer.length; i++) {
      input_layer[i].output = card.inputs[i];
    }
    // now feed forward through the hidden layer
    for (int i = 0; i<hiddenLayers.size(); i++) {
      for (int j = 0; j < hiddenLayers.get(i).length; j++) {
        if (i<hiddenLayers.size()-1)hiddenLayers.get(i)[j].respondDeep();
        else hiddenLayers.get(i)[j].respond();
      }
    }

    for (int i = 0; i < output_layer.length; i++) {
      output_layer[i].respond();
    }
  };

  void respondDeep(PImage card) {
    card.loadPixels();
    for (int i = 0; i < input_layer.length; i++) {
      input_layer[i].output = card.pixels[i];
    }
    // now feed forward through the hidden layers
    for (int i = 0; i<hiddenLayers.size(); i++) {
      for (int j = 0; j < hiddenLayers.get(i).length; j++) {
        if (i<hiddenLayers.size()-1)hiddenLayers.get(i)[j].respondDeep();
        else hiddenLayers.get(i)[j].respond();
      }
    }

    for (int i = 0; i < output_layer.length; i++) {
      output_layer[i].respond();
    }
  };

  void displayOutput() {

    // Draw the output layer
    float [] resp = new float [output_layer.length];
    float respTotal = 0.0;

    for (int k = 0; k < output_layer.length; k++) {
      resp[k] = output_layer[k].output;
      respTotal += resp[k]+1;
    }

    fill(0);

    for (int k = 0; k < output_layer.length; k++) {
      //text(k%10, 100, 10);
      text(k + "   " +nfc(((output_layer[k].output+1)/respTotal)*100, 2) + "%", 115, 10+10*k);
      strokeWeight(1);
    }
    float best = -1.0;
    for (int i =0; i < resp.length; i++) {
      if (resp[i]>best) {
        best = resp[i];
        bestIndex = i;
      }
    }
  };

  void getBest() {

    float [] resp = new float [output_layer.length];

    float respTotal = 0.0;
    float best = -1.0;

    for (int k = 0; k < output_layer.length; k++) {
      resp[k] = output_layer[k].output;

      respTotal += resp[k]+1;
      if (resp[k]>best) {
        best = resp[k];
        bestIndex = k;
      }
    }
  };

  void displayGuess() {
    fill(9);
    textSize(30);
    text(bestIndex, 10, 40);
    textSize(12);
  };


  void train(float [] outputs) {
    // adjust the output layer
    float best = -1.0;
    for (int k = 0; k < output_layer.length; k++) {
      output_layer[k].setError(outputs[k]);
      output_layer[k].train();
      if (output_layer[k].output > best) bestIndex = k;
    }

    // propagate back to the hidden layer
    for (int j = 0; j < hidden_layer.length; j++) {
      hidden_layer[j].train();
    }

    // The input layer doesn't learn: it is the input and only that
  };

  void trainDeep(float [] outputs) {
    // adjust the output layer
    float best = -1.0;
    for (int k = 0; k < output_layer.length; k++) {
      output_layer[k].setError(outputs[k]);
      output_layer[k].train();
      if (output_layer[k].output > best) bestIndex = k;
    }

    // propagate back to the hidden layer


    for (int i=hiddenLayers.size()-1; i>-1; i--) {
      for (int j = 0; j < hiddenLayers.get(i).length; j++) {
        hiddenLayers.get(i)[j].train();
      }
    }

    // The input layer doesn't learn: it is the input and only that
  };

  void convolve() {
  }

  void permute() {
    int [][]permutation = new int[3][3];
    if (!convolutionCC) {
      for (int i=0; i<3; i++) {
        for (int j=0; j<3; j++) {
          int p = i + j * 3;

          permutation[i][j] = floor(random(0, 2));
        }
      }

      if (!convolutions.contains(permutation)) convolutions.add(permutation);
        
       if (!countedConvolutions.contains(permutation)){
        countedConvolutions.add(permutation);
        matchingCC ++;
      }

      if (matchingCC >= maxPm)convolutionCC = true;
    }
    
    if(convolutionCC&&convolutionWritten){};
  };

  void displayCard(Card card, int x, int y) {
      int size = 28;
      int res = 7;
    for(int i=0;i<size;i++){
      for(int j=0;j<size;j++){
        int p = j+i*size;
        noStroke();
        //stroke(0);
        fill(128 * (1 - card.inputs[p]));
        rect(x+j*(res+2),y+i*(res+2),res,res);
    }}

    //if (card.type == 0) {
    //  data.trainingData[card.id].resize(150, 0);
    //  image(data.trainingData[card.id], x, y);
    //} else {
    //  data.testingData[card.id].resize(150, 0);
    //  image(data.testingData[card.id], x, y);
    //}
  };

  void displayCard(PImage a, int x, int y) {

    a.resize(150, 0);
    image(a, x, y);
  };

  void run(int n) {
    trainDisplay();
    testDisplay();
    if (menu.click(1))save();
    //if (menu.click(2))exit();
    listen();

    if (trainB.toggle_) {
      for (int i = 0; i < n; i++) {
        trainCard = (int) floor(random(0, trainingSet.length));
        //println(trainCard);
        respondDeep(trainingSet[trainCard]);
        trainDeep(trainingSet[trainCard].outputs);
        totalTrain++;
      }
    } else if (testB.hold()) {
      testCard = (int) floor(random(0, testingSet.length));
      respondDeep(testingSet[testCard]);

      getBest();
      if (bestIndex == testingSet[testCard].output) totalRight ++;
      totalTest ++;
    }
    displayOutput();

    if (trainingSet[trainCard]!=null)displayCard(trainingSet[trainCard], 210, 0);
    if (testingSet[testCard]!=null)displayCard(testingSet[testCard], 470, 0);

    trainB.draw();
    testB.draw();
    input.draw();
    //saveFile.draw();
    if (test.click()&&input.croppedImage!=null) {
      tempCard = loadImage(input.croppedImage);
      tempImage = loadImage(input.croppedImage, true);
      respondDeep(tempCard);
      getBest();
      totalTest ++;
    }
    if (tempImage!=null)displayCard(tempImage, 730, 0);
    fill(100);
    text("Test card: #" + testCard, width*0.18, height*0.89);
    text("Train card: " + trainCard, width*0.18, height*0.93);

    text("Total train: " + totalTrain, width*0.32, height*0.89);
    text("Total test: " + totalTest, width*0.32, height*0.93);

    if (totalTest>0) sucess = float(totalRight)/float(totalTest);
    text("Success rate: " + nfc(sucess, 2), width*0.44, height*0.89);
    text("Card label: " + testingSet[testCard].output, width*0.44, height*0.93);
    displayGuess();
    reset.draw();
    test.draw();
    // loadFile.draw();
    // saveFile.draw();
    drawMenu.draw();
    // saveConvolutions.draw();
    menu.draw();
    if(menu.click(3))saveConvolutions();
    // loadConvolutions.draw();
    // loadTrainingData.draw();
    // loadTestingData.draw();
    // loadTrainingLabels.draw();
    // loadTestingLabels.draw();
    permute();
    fill(0);
    text(frameRate, 10, 10);
    text(LEARNING_RATE, 10, 50);
    //if (frameCount%10==0&&matchingCC<512)println(countedConvolutions.size() + " " +  matchingCC);
  };

  void trainDisplay() {
  };

  void testDisplay() {
  };
};

class pNetwork extends Network {

  ArrayList<Neuron []> hiddenLayers_;
  ArrayList<Neuron []> inputLayers_;
  ArrayList<Neuron []> outputLayers_;

  Neuron [][] hiddenLayers;
  Neuron [][] inputLayers;
  Neuron [][] outputLayers;
};


class Card { // This class contains all the functions to format and save the data
  
  int id,type;
  float [] inputs,outputs;
  int output;
  Card tempCard;

  Card() {
    inputs = new float [784]; // the images are a grid of 14x14 pixels which makes for a total of 196
    outputs = new float[10]; // the number of possible outputs; from 0 to 9
  };
  
  Card(float []inputs_) {
    inputs = inputs_; // the images are a grid of 14x14 pixels which makes for a total of 196
    outputs = new float[10]; // the number of possible outputs; from 0 to 9
  };
  
  Card(float []inputs_, int id,int type) {
    this.id = id;
    this.type = type;
    inputs = inputs_; // the images are a grid of 14x14 pixels which makes for a total of 196
    outputs = new float[10]; // the number of possible outputs; from 0 to 9
  };

  void imageLoad(byte [] images, int offset) { // Images is an array of 1,960,000 bytes, each one representing a pixel (0-255) of the 10,000 * 14x14 (196) images
                                               // We know one image consists of 196 bytes so the location is: offset*196
    for (int i = 0; i < 784; i++) {
      inputs[i] = int(images[i+offset]) / 128.0 - 1; // We then store each pixel in the array inputs[] after converting it from (0 - 255) to (+1 - -1) as they vary on the greyscale 
    }
  };

  void labelLoad(byte [] labels, int offset) {  // Labels is an array of 10,000 bytes, each representing the answer of each image

    output = int(labels[offset]);
    
    for (int i = 0; i < 10; i++) {  // We then set the correct index in output[] to +1 if it corresponds to the ouput and -1 if not
      if (i == output) {
        outputs[i] = 1.0;
      } else {
        outputs[i] = -1.0;
      }
    }
  }
  
};
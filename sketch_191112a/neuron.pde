class Neuron {

  Neuron [] inputs; // Strores the neurons from the previous layer
  float [] weights,biases;
  float output,error,errorW,errorB,bias;
  float [] outputs;

  Neuron() {
  }

  Neuron(Neuron [] p_inputs) {

    inputs = new Neuron [p_inputs.length];
    weights = new float [p_inputs.length];
    biases = new float [p_inputs.length];
    bias = random(-1.0, 1.0);
    
    error = 0.0;
    errorB = 0.0;
    errorW = 0.0;
    
    for (int i = 0; i < inputs.length; i++) {
      
      inputs[i] = p_inputs[i];
      weights[i] = random(-1.0, 1.0);
      biases[i] = random(-1.0, 1.0);
    }
  };

  void respond() {

    float input = 0.0;
    float bias = 0.0;
    for (int i = 0; i < inputs.length; i++) {
      
      input += inputs[i].output * weights[i] + biases[i];
    }
    output = lookupSigmoid(input);
    error = 0.0;
  };
  
  void respondDeep(){
    float input = 0.0;
    float bias = 0.0;
    for (int i = 0; i < inputs.length; i++) {
      input += inputs[i].output * weights[i] + biases[i];
    }
    output = lookupSigmoid(input);
    error = 0;
  };
  
  void setError(float desired) {
    error = desired - output;
  };

  void train() {

    float delta = (1.0 - output) * (1.0 + output) * error * LEARNING_RATE;
    
    for (int i = 0; i < inputs.length; i++) {
      
      inputs[i].error += (weights[i] )* error;
      weights[i] += (inputs[i].output ) * delta;
    }
  };

  void display() {
    stroke(200);
    rectMode(CENTER);
    fill(128 * (1 - output));
    rect(0, 0, 16, 16);
  };
  
};
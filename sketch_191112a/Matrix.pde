class Matrix{
  
  int i,j;
  //ArrayList<float> m1,m2;
  float [][] m1,m2,tpose;
  float [] m3,m4;
  
  ArrayList<Matrix> matrices = new ArrayList<Matrix>();
  //ArrayList<Float[]> matrices = new ArrayList<Matrix>();
  float [][]matrix;
  
  
  Matrix(float [][] a){
    m1 = a;
    
  };
  
  Matrix(int xx,int yy,boolean c){
    
    matrix = new float[yy][xx];
    
    if(c){
    for(int i=0;i<yy;i++){
      for(int j=0;j<xx;j++){
        
        matrix[xx][yy] = random(-1,1);
        
    }}}
  };
  
  void save(){
    
  };
  
  void load(){
    
  };
  
  //---------------------------dot product------------------
  float[][] dot(float [][] a,float [][]  b){
    
      int x = a.length;
      int y = b.length;
      int z = b[0].length;
      float [][]temp = new float[x][z];
      
      for (int i=0;i<x;i++){
          for (int j=0;j<y;j++){
               for (int k=0;k<z;k++){
                   
      temp[i][j] += a[i][k] * b[j][k];
               }}}
      m1 = temp;
      return m1;
  };
  
  float[] dot(float [] a,float []  b){
    
      int x = a.length;
      int y = b.length;
      float []temp = new float[x];
      
      for (int i=0;i<x;i++){
          for (int j=0;j<y;j++){
                   
               }}
               
      m3 = temp;
      return m4;
  };
  
  PVector dot(PVector t, PVector u){
      
      float [][]a = {{t.x,t.y,t.z}};
      float [][]b = {{u.x,u.y,u.z}};
    
      int x = a.length;
      int y = b.length;
      int z = b[0].length;
      float [][]temp = new float[x][z];
      
      for (int i=0;i<x;i++){
          for (int j=0;j<y;j++){
               for (int k=0;k<z;k++){
                   
      temp[i][j] += a[i][k] * b[j][k];
               }}}
      m1 = temp;
      PVector result = new PVector(m1[0][0],m1[0][1],m1[0][2]);
      return result;
  };
  
  
  //--------------------cross product-----------------------
  float[][] cross(float [][] a,float [][]  b){
    
    return a;
  };
  
  //-------------matrix multiplyer------------------
  float[][] mult(float [][] a,float [][]  b){
      int x = a.length;
      int y = b[0].length;
      float [][]temp = new float[x][y];
      
      for (int i=0;i<x;i++){
          for (int j=0;j<y;j++){
                   
      temp[i][j] += a[i][j] * b[i][j];
               }}
      m1 = temp;
      return m1;
  };
  
  float mult(float a, float b){
    a = a * b;
    return a;
  };
  
  float[][] mult(float[][] a, float b){
      int x = a.length;
      int y = a[0].length;
      float [][]temp = new float[x][y];
      
      for (int i=0;i<x;i++){
          for (int j=0;j<y;j++){
                   
      temp[i][j] += a[i][j] * b;
               }}
      m1 = temp;
      return m1;
  };
  
  float[][] add(float [][] a,float [][]  b){
    int x = a.length;
      int y = a[0].length;
      float [][]temp = new float[x][y];
      
      for (int i=0;i<x;i++){
          for (int j=0;j<y;j++){
                   
      temp[i][j] += a[i][j] + b[i][j];
               }}
      m1 = temp;
      return m1;
  };
  
  //------------------------------------------
  float[][] add(float [][] a,float  b){
    int x = a.length;
      int y = a[0].length;
      float [][]temp = new float[x][y];
      
      for (int i=0;i<x;i++){
          for (int j=0;j<y;j++){
                   
      temp[i][j] += a[i][j] + b;
               }}
      m1 = temp;
      return m1;
  };
  
  float[][] translate(float [][] a,float b){
    
      int x = a.length;
      int y = a[0].length;
      float [][]temp = new float[x][y];
      
      for (int i=0;i<x;i++){
          for (int j=0;j<y;j++){
                   
      temp[i][j] += a[i][j] + b;
               }}
      m1 = temp;
      return m1;
  };
  
  float[][] transpose(float[][] a){
      int x = a.length;
      int y = a[0].length;
      float [][]temp = new float[y][x];
      
      for (int i=0;i<x;i++){
          for (int j=0;j<y;j++){
                   
      temp[i][j] += a[j][i] ;
               }}
      tpose = temp;
      return tpose;
  };

  void transposeFlat(){




  };
  
  void determinant(){
    
    //return a;
  }
  
  float[][] substract(float [][] a,float [][]  b){
    int x = a.length;
      int y = a[0].length;
      float [][]temp = new float[x][y];
      
      for (int i=0;i<x;i++){
          for (int j=0;j<y;j++){
                   
      temp[i][j] += a[i][j] - b[i][j];
               }}
      m1 = temp;
      return m1;
  };
  
  float[][] randomize(float[][] a){
    
    return a;
  };
  
};

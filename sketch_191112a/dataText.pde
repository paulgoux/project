class vectorText{
  
  String [] text = null;
  String Sentence = "",sentence = "",Text="";
  ArrayList<Word[]> ninputs = new ArrayList<Word[]>();
  ArrayList<String> Sentences = new ArrayList<String>();
  ArrayList<Word> newSentence = new ArrayList<Word>();
  ArrayList<Word> builtSentence = new ArrayList<Word>();
  //ArrayList<Integer> sentences = new ArrayList<Integer>();
  ArrayList<Word> frequency = new ArrayList<Word>();
  ArrayList<ArrayList<String>> words = new ArrayList<ArrayList<String>>();
  ArrayList<ArrayList<Word>> Words = new ArrayList<ArrayList<Word>>();
  ArrayList<Word> Words1d = new ArrayList<Word>();
  ArrayList<Word> Words1dsingle = new ArrayList<Word>();
  ArrayList<Word> wordPool = new ArrayList<Word>();
  ArrayList<String> words1d = new ArrayList<String>();
  ArrayList<String> words1dsingle = new ArrayList<String>();
  ArrayList<ArrayList<Integer>> sentences = new ArrayList<ArrayList<Integer>>();
  
  ArrayList<Word> unsortedSearch = new ArrayList<Word>();
  ArrayList<Word> sortedSearch = new ArrayList<Word>();
  float max_size = 0,maxVariance,minVariance=10,maxFrequency;
  
  Word start;
  
  int sentence_counter = 0, word_counter = 0,word_total,char_counter,char_counter2,char_counter3,counter,counter2,counter3,mid,twords,
      nonRep_words,char_total,space_total,longest_sentence;
  boolean init = true,textcompleted,inputs_complete,separatewords,separatesentences,trimchars,createwordobj,textjoined,getvariance,foundS,mdown;
  
  vectorText(String a){
    sentence = a;
  };
  
  vectorText(String [] a){
    text = a;
  };
  
void classString(){
  
  words.add(new ArrayList<String>());
  if(sentence_counter<sentence.length()){
    
  for(int i=0;i<sentence.length();i++){
    
    char a = sentence.charAt(i);
    
    if(a==' '||i==sentence.length()-1){
      String b = "";
      if(a==' ')b += sentence.substring(word_counter,i);
      else b += sentence.substring(word_counter,i+1);
      words.get(0).add(b);
      //sentence = sentence.substring(i,sentence.length());
      word_counter=i;
      if(i==0);word_counter =0;
      System.out.println(b);
    }
    sentence_counter ++;
  }}
  
  mid = floor(sentence.length()/2);
  float cursorx = 0;
  for(int i=0;i<words.size();i++){
    String a = words.get(0).get(i);
    
    int dy = mid - i;
    
    //text(dy,10,20+10*i);
    
    Word w = new Word(dy,0,i,cursorx,a.length(),a);
    
    if(!Words1dsingle.contains(w))Words1dsingle.add(w);
    cursorx+= textWidth(a);
  }
};

void classString(String sentence){
  
  String temp = "";
  words.add(new ArrayList<String>());
  if(sentence_counter<sentence.length()){
    
  for(int i=0;i<sentence.length();i++){
    
    char a = sentence.charAt(i);
    
    if(a==' '||i==sentence.length()-1){
      String b = "";
      if(a==' ')b += sentence.substring(word_counter,i);
      else b += sentence.substring(word_counter,i+1);
      words.get(0).add(b);
      word_counter=i;
      if(i==0);word_counter =0;
      System.out.println(b);
    }
    sentence_counter ++;
  }}
  
  mid = floor(sentence.length()/2);
  float cursorx = 0;
  for(int i=0;i<words.size();i++){
    String a = words.get(0).get(i);
    
    int dy = mid - i;
    
    text(dy,10,20+10*i);
    
    Word w = new Word(dy,0,i,cursorx,a.length(),a);
    
    if(!Words1dsingle.contains(w))Words1dsingle.add(w);
    cursorx += textWidth(a);
  }
};

void separateSentences_(){
  
  //push all text into one array
  if(sentence_counter<text.length){
    
    for(int j=0;j<text.length;j++){
      Text+= text[j];
      sentence_counter++;
    }}
    // loop through array and find key characters
    if(counter<Text.length()){
      
    for(int i=0;i<Text.length();i++){
      
      counter ++;
      
    char a = Text.charAt(i);
    String b = "";
    
    if(a=='.'){
      
      if(a=='.'||a=='!'||a=='?')b = Text.substring(char_counter,i+1);
      char_counter=i+1;
      Sentences.add(b);
      words.add(new ArrayList<String>());
      
    }
    else if(i==Text.length()-1){
      b = Text.substring(char_counter,i);
      char_counter=i;
      Sentences.add(b);
      words.add(new ArrayList<String>());
    }
    //System.out.println(b);
    
  }}
};

void trimChars_(){
  
};

void separateWords_(){
  if(counter2<Sentences.size()){
    
  for(int i=0;i<Sentences.size();i++){
    
    String s = Sentences.get(i);
    s = s.replaceAll("\\s+","");
    char_counter2 = 0;
    
    for(int j=0;j<s.length();j++){
      
      char a = s.charAt(j);
      
      counter2++;
      String b = "";
      
    if(a==' '){
      b = s.substring(char_counter2,j);
      char_counter2 = j;
      words.get(i).add(b);
      words1d.add(b);
      word_total++;
      words.get(i).add(" ");
      words1d.add(" ");
      space_total++;
    }
     else if(a=='\''){
      b += "\' ";
      println(b);
      words.get(i).add(b);
      
      words1d.add(b);
      char_counter2=j+1;
    }
     else if(a==','){
      b = s.substring(char_counter2,j);
      println(b);
      words.get(i).add(b);
      
      words1d.add(b);
      char_counter2=j;
    }
    
    
    else if(a=='.'){
      b = s.substring(char_counter2,j-2);
      char_counter2 = j+1;
      words.get(i).add(b);
      words1d.add(b);
      words.get(i).add(".");
      words1d.add(".");
    }};counter2++;}}
};

void createWordObject_(){
  if(Words1dsingle.size()<words1d.size()){
    
    for(int i=0;i<words.size();i++){
    
    ArrayList<String> s = words.get(i);
    char_counter2 = 0;
    
    mid = floor(s.size()/2);
    float cursorx = 0;
    for(int j=0;j<s.size();j++){
      
      String a = s.get(j);
      
      Word word = new Word(j - mid,j,i,cursorx,a.length(),a);
      cursorx += textWidth(a);
      Words1dsingle.add(word);
  }}}
};

void classText(){
  
  separateSentences_();
  trimChars_();
  separateWords_();
  createWordObject_();
  
};

void classTextsp(){
  if(!textcompleted){
  separateSentences();
  trimChars();
  separateWords();
  createWordObject();
  getVariance();
  }
};

void separateSentences(){
  if(sentence_counter<text.length){
    
    for(int j=0;j<text.length;j++){
      Text+= text[j] + " ";
      max_size += textWidth(text[j]);
      sentence_counter++;
    }
  max_size /= text.length;
}else if(counter<Text.length()){
      
    for(int i=0;i<Text.length();i++){
      
      counter ++;
      
    char a = Text.charAt(i);
    String b = "";
    
    if(a=='.'){
      
      b = Text.substring(char_counter,i+1);
      if(b.length()>1){
      char_counter=i+1;
      Sentences.add(b);
      words.add(new ArrayList<String>());
    }}}}else separatesentences = true;
};

void trimChars(){
  
};

void separateWords(){
  
  if(counter2<Sentences.size()&&separatesentences&&!separatewords){
    
  for(int i=0;i<Sentences.size();i++){
    
    String s = Sentences.get(i);
    char_counter2 = 0;
    s = s.replace("\r\n",". ");
    for(int j=0;j<s.length();j++){
      
      char a = s.charAt(j);
      
      String b = "";
      
     if(a==','){
      b = s.substring(char_counter2,j)+",";
      
      if(b.length()>0){
        words.get(i).add(b);
        words.get(i).add(b);
      }
      //words1d.add(b);
      char_counter2 = j+1;
      char_total ++;
      }
      else if(a=='\n'){
      b = s.substring(char_counter2,j);
      char_counter2 = j+1;
      //b += " ";
      if(b.length()>0){
        words.get(i).add(b);
        words1d.add(b);
      }
      word_total++;
      //words.get(i).add(" ");
      //words1d.add(" ");
      space_total++;
      }
      else if(a==' '){
      b = s.substring(char_counter2,j);
      char_counter2 = j+1;
      //b += " ";
      if(b.length()>0){
        words.get(i).add(b);
        words1d.add(b);
      }
      word_total++;
      //words.get(i).add(" ");
      //words1d.add(" ");
      space_total++;
      }
      //else if(a==';'){
      //b = s.substring(char_counter2,j);
      //char_counter2 = j+1;
      //words.get(i).add(b);
      //words1d.add(b);
      //word_total++;
      ////words.get(i).add(" ");
      ////words1d.add(" ");
      //space_total++;
      //}
      else if(a=='?'){
      b = s.substring(char_counter2,j)+"?";
      char_counter2 = j+1;
      if(b.length()>0){
        words.get(i).add(b);
        words1d.add(b);
      }
      word_total++;
      //words.get(i).add("?");
      //words1d.add("?");
      space_total++;
      }
      else if(a=='.'){
      b = s.substring(char_counter2,j)+".";
      char_counter2 = j+1;
      if(b.length()>0){
        words.get(i).add(b);
        words1d.add(b);
      }
      //words.get(i).add(".");
      //words1d.add(".");
      space_total++;
    }
    else if(a=='!'){
      b = s.substring(char_counter2,j)+"!";
      char_counter2 = j+1;
      if(b.length()>0){
        words.get(i).add(b);
        words1d.add(b);
      }
      //words.get(i).add("!");
      //words1d.add("!");
      char_total++;
    }
    else if(a=='-'){
      b = s.substring(char_counter2,j);
      char_counter2 = j+1;
      if(b.length()>0){
        words.get(i).add(b);
        words1d.add(b);
      }
      //words.get(i).add("-");
      //words1d.add("-");
      char_total++;
    }
    else if(a==':'){
      b = s.substring(char_counter2,j);
      char_counter2 = j+1;
      if(b.length()>0){
        words.get(i).add(b);
        words1d.add(b);
      }
      //words.get(i).add(":");
      //words1d.add(":");
      char_total++;
    }
    //else if(a=='/'){
    //  b = s.substring(char_counter2,j);
    //  char_counter2 = j+1;
    //  words.get(i).add(b);
    //  words1d.add(b);
    //  //words.get(i).add("/");
    //  //words1d.add("/");
    //  char_total++;
    //}
    //else if(a=='\''){
    //  b = s.substring(char_counter2,j);
    //  char_counter2 = j;
    //  words.get(i).add("'");
    //  words1d.add("'");
    //  words.get(i).add("'");
    //  words1d.add("'");
    //  char_total++;
    //}
  };counter2++;if(i==Sentences.size()-1)separatewords = true;}}
    
};

void createWordObject(){
  //text(count,200,130);
    
  if(twords<words1d.size()&&words1d.size()>0){
    for(int i=0;i<words.size();i++){
        longest_sentence += words.get(i).size();
      }
      
      longest_sentence /= words.size();
    
    ArrayList<String> temp = new ArrayList<String>();
    ArrayList<Word> temp2 = new ArrayList<Word>();
    int count = 0;
    for(int i=0;i<words.size();i++){
    
    ArrayList<String> s = words.get(i);
    char_counter2 = 0;
    
    mid = floor(longest_sentence/2);
    float cursorx = 0;
    for(int j=0;j<s.size();j++){
      
      String a = s.get(j);
      int total = words.size() * s.size();
      float v =  mid - j;
      Word next = null;
      if(count<words1d.size()){ next = new Word(j - mid,j,i,cursorx,a.length(),a,count,words.size(),total);
      
      next.pos2.add(abs(v*v));
      next.frequency = 1;
      next.cYpos.add(0);
      next.cXpos.add(0);
      next.ypos.add(i);
      //next.xpos.add(new ArrayList<Integer>());
      //next.xpos.get(0).add(j);
      next.xpos.add(j);
      
      if(textWidth(Sentences.get(i))>1)
      next.sentenceSize.add(textWidth(Sentences.get(i)));
      else next.sentenceSize.add(1.0);
      Words1d.add(next);
      cursorx += textWidth(a);
      
        if(!words1dsingle.contains(a)){
          Words1dsingle.add(next);
          words1dsingle.add(a);
          
        }else{
          int k = words1dsingle.indexOf(a);
        
          Word word =  Words1dsingle.get(k);
          //if(j<s.size()-1)word.nextWord.add(s.get(j+1));
          word.frequency ++;
          word.pos2.add(abs(v*v));
          //word.occurence.set(j,1);
          if(textWidth(Sentences.get(i))>1)
          word.sentenceSize.add(textWidth(Sentences.get(i)));
          else word.sentenceSize.add(1.0);
          //word.sentence_occurence.set(j,1);
          if(i>0&&Sentences.get(i-1).contains(a)){
            word.cYpos.add(word.cYpos.get(word.cYpos.size()-1)+1);
          }
          if(j>0){
            word.cXpos.add(word.cXpos.get(word.cXpos.size()-1)+1);
          }
          word.xpos.add(j);
          word.ypos.add(i);
          word.pos.add(next.p);
        }
      count++;
      twords++;
      if(count == words1d.size()){
        
        textcompleted = true;
      }}}}}
};

void markovChain(){
  
};

void getVariance(){
  int countv = 0;
  if(textcompleted&&!getvariance){
  for(int i=0;i<Words1dsingle.size();i++){
          Word w = Words1dsingle.get(i);
          countv ++;
          w.calcVariance();
          if(maxVariance<w.variance)maxVariance=w.variance;
          if(maxFrequency<w.frequency)maxFrequency=w.frequency;
          if(minVariance<w.variance)minVariance=w.variance;
          //w.setVariance();
          //for(int j=0;j<w.sentenceSize.size();j++){
          //  float v = w.sentenceSize.get(j);
            
          //  if(v>w.maxWordVariance)w.maxWordVariance = v;
          //}
        
      }
        
        fill(255);
   for(int i=0;i<Words1dsingle.size();i++){
          Word w = Words1dsingle.get(i);
          w.setVariance();
       }
      
    if(countv>=Words1dsingle.size())getvariance = true;}
    else{
      //int count = 0;
      //for(int i=0;i<Words1dsingle.size();i++){
      //    Word w = Words1dsingle.get(i);
      //    //if(w.maxWordVariance==0){
      //      text(w.maxWordVariance,400,50+10*count);
      //      count++;
      //    //}
      // }
    }
};

void getEncodings(){
  fill(255);
  if(getvariance){
  for(int i=0;i<Words1d.size();i++){
      
      Word w = Words1d.get(i);
      for(int j=0;j<w.sentence_occurence.size();j++){
        
        int k = w.occurence.get(j);
        text(k,40+j*10,70+10*i);
        
      }}}
};

void readText(){
  
  float my = map(mouseY,0,text.length*12,0,height);
  for(int i=0;i<words.size();i++){
    
    ArrayList<String> s = words.get(i);
    
    float cursorx = 0;
  
    for(int j=0;j<s.size();j++){
      
      String s2 = s.get(j);
      
      text(s2 + " ", cursorx ,230+10*i-my);
      cursorx += textWidth(s2);
    }}
  
  //for(int i=0;i<Sentences.size();i++){
  //  String s = Sentences.get(i);
  //  fill(255);
  //  text(s,10,90+10*i);
  //}
  
  //for(int i=0;i<words1d.size();i++){
  //  String s = words1d.get(i);
    
  //  text(s,10,90+10*i);
  //}
};

void plotText(){
  
  for(int i=0;i<Words1dsingle.size();i++){
    
    Word w = Words1dsingle.get(i);
    
    fill(255);
    stroke(0);
    ellipse(w.x+w.variance + 400,w.y,5,5);
    //text(w.variance,10,40+10*i);
    
  }
  
};

void findSimilar(String a){
  
  
      ArrayList<Word>temp = new ArrayList<Word>();
      
      if(Words1dsingle.size()==words1dsingle.size()){
        
  if(words1dsingle.contains(a)){
    
      int k = words1dsingle.indexOf(a);
      
      Word w1 = Words1dsingle.get(k);
      
  for(int i=0;i<Words1dsingle.size();i++){
    
    Word w2 = Words1dsingle.get(i);
    
   float deltav = abs(w1.p - w2.p);
   float deltaf = abs(w1.frequency - w2.frequency);
    
    fill(255);
    if(deltaf < 0.000001&&w1.a!=w2.a)temp.add(w2);
    
  }}else{
    fill(255);
    text("Choose, new word",10,40);
  }}
  
  if(temp.size()>0){
    int y1 = 50;
    fill(255);
    text("|" + a + "|",10,y1);
    
    for(int i=0;i<temp.size();i++){
      
      Word w = temp.get(i);
      
      text("|" + w.a + "|",10,50+10*i);
      text(w.variance,100,50+10*i);
      text(w.frequency,200,50+10*i);
    }
  }else{
    fill(255);
      text("Temp is empty",10,50);
  }
};

ArrayList<Word> findSimilar(String a,int b){
    fill(255);
      ArrayList<Word>temp = new ArrayList<Word>();
      
      if(textcompleted){
        
  if(words1dsingle.contains(a)){
    
    if(!foundS){
      int k = words1dsingle.indexOf(a);
      
      Word w1 = Words1dsingle.get(k);
      
        for(int i=0;i<w1.ypos.size();i++){
          
          ArrayList<String> s = words.get(w1.ypos.get(i));
          
          for(int j=w1.xpos.get(i);j<w1.xpos.get(i)+b+1;j++){
            
            if(j>0&&j<s.size()){
            int k2 = words1dsingle.indexOf(s.get(j));
            
            Word w2 = Words1dsingle.get(k2);
              //if(int(c)+1==j){
            
            
            if(w2.a!=" "&&w2.a!=":"&&w2.a!="  "){
            if(w1.a!=w2.a&&!unsortedSearch.contains(w2)){
              w2.p = j;
              w2.searchFrequency++;
              //if(w2.a[0]!=':'||w2.a[0]!=';')
              unsortedSearch.add(w2);
            }
            if(w1.a!=w2.a&&unsortedSearch.contains(w2)){
              int k1 = unsortedSearch.indexOf(w2);
              unsortedSearch.get(k1).searchFrequency++;
              unsortedSearch.add(w2);
              
            }}}
      //if(j>=s.size()&&w1.ypos.get(j)<words.size()){
      //  int n = abs(s.size()-j);
      //int k2 = words1dsingle.indexOf(words.get(w1.ypos.get(i)+1).get(n));
      
      //Word w2 = Words1dsingle.get(k2);
      //if(w2.a!=" "&&w1.a!=w2.a&&!unsortedSearch.contains(w2)){
      //  w2.p = 0;
      //  w2.searchFrequency++;
      //  unsortedSearch.add(w2);
      //}
      //if(w2.a!=" "&&w1.a!=w2.a&&unsortedSearch.contains(w2)){
      //  int k1 = unsortedSearch.indexOf(w2);
      //  unsortedSearch.get(k1).searchFrequency++;
      //  //unsortedSearch.add(w2);
        
      //}}
      //if(j<=0&&w1.ypos.get(j)>0){
      //  int n = words.get(w1.ypos.get(i)-1).size()+j;
      //int k2 = words1dsingle.indexOf(words.get(w1.ypos.get(i)-1).get(n));
      
      //Word w2 = Words1dsingle.get(k2);
      //if(w2.a!=" "&&w1.a!=w2.a&&!unsortedSearch.contains(w2)){
      //  w2.p = 0;
      //  w2.searchFrequency++;
      //  unsortedSearch.add(w2);
      //}
      //if(w2.a!=" "&&w1.a!=w2.a&&unsortedSearch.contains(w2)){
      //  int k1 = unsortedSearch.indexOf(w2);
      //  unsortedSearch.get(k1).searchFrequency++;
      //  //unsortedSearch.add(w2);
        
      //}}
    }}
    
      foundS = true;
      
      //for(int i=0;i<unsortedSearch.size();i++){
      //  Word w = unsortedSearch.get(i);
      //  w.searchFrequency /= unsortedSearch.size();
      //}

    }}else{
      
      text("Choose, new word",10,40);
    }}
  
  if(textcompleted){
  if(foundS)temp = unsortedSearch;
  
  }
  
  return temp;
};

ArrayList<Word> findSimilar(String a,int b,float c){
    fill(255);
      ArrayList<Word>temp = new ArrayList<Word>();
      ArrayList<Word>unsortedSearch = new ArrayList<Word>();
      if(textcompleted){
        
  if(words1dsingle.contains(a)){
    
    if(!foundS){
      
      int k = words1dsingle.indexOf(a);
      int y = 0;
      
      Word w1 = Words1dsingle.get(k);
      
      for(int i=0;i<w1.ypos.size();i++){
        
        ArrayList<String> s = words.get(w1.ypos.get(i));
        
        for(int j=w1.xpos.get(i);j<w1.xpos.get(i)+b+1;j++){
          
          boolean check = false;
          //if(i>0&&w1.ypos.get(i)==w1.ypos.get(i-1))w1.t++;
          //else w1.t = 0;
          
          if(j>=0&&j<s.size()&&j==c+1){
          int k2 = words1dsingle.indexOf(s.get(j));
          
          Word w2 = Words1dsingle.get(k2);
          if(w1.a!=w2.a&&!unsortedSearch.contains(w2)){
            w2.p = w1.xpos.get(i)+j;
            w2.searchFrequency++;
            unsortedSearch.add(w2);
          }
          if(w1.a!=w2.a&&unsortedSearch.contains(w2)){
            int k1 = unsortedSearch.indexOf(w2);
            unsortedSearch.get(k1).searchFrequency++;
            unsortedSearch.add(w2);
            
       }}}}
    
      foundS = true;

    }}else{
      
      text("Choose, new word",10,40);
    }}
  
  if(textcompleted){
  if(foundS)temp = unsortedSearch;
  
  }
  return temp;
};

void displaySimilar(String a,int b,int c){
    fill(255);
      ArrayList<Word>temp = new ArrayList<Word>();
      
      if(textcompleted){
        
  if(words1dsingle.contains(a)){
    
    if(!foundS){
      int k = words1dsingle.indexOf(a);
      
      Word w1 = Words1dsingle.get(k);
      
      for(int i=0;i<w1.ypos.size();i++){
        
        ArrayList<String> s = words.get(w1.ypos.get(i));
        
        //float deltaf = abs(w1.frequency - w2.frequency);
        int count = 0;
        for(int j=w1.xpos.get(i);j<w1.xpos.get(i)+b+1;j++){
          
          if(j>=0&&j<s.size()){
          int k2 = words1dsingle.indexOf(s.get(j));
          
          Word w2 = Words1dsingle.get(k2);
          if(w1.a!=w2.a&&w2.a != " "&&!unsortedSearch.contains(w2)){
            w2.p = w1.xpos.get(i)+j;
            w2.searchFrequency++;
            unsortedSearch.add(w2);
          }
          if(w1.a!=w2.a&&unsortedSearch.contains(w2)){
            int k1 = unsortedSearch.indexOf(w2);
            unsortedSearch.get(k1).searchFrequency++;
            //unsortedSearch.add(w2);
            
       }}}}
    
      foundS = true;
      
      //for(int i=0;i<unsortedSearch.size();i++){
      //  Word w = unsortedSearch.get(i);
      //  w.searchFrequency /= unsortedSearch.size();
      //}

    }}else{
      
      text("Choose, new word",10,40);
    }}
  
  if(textcompleted){
  if(foundS){
    
    if(unsortedSearch.size()>0)text(unsortedSearch.size(),10,40);
    
    Word w1 = null;
    
    if(unsortedSearch.size()>0){
      
      for(int j=unsortedSearch.size()-1;j>-1;j--){
        
        w1 = unsortedSearch.get(j);
        int n = -1;
        
        for(int i=unsortedSearch.size()-2;i>-1;i--){
          
           Word w2 = unsortedSearch.get(i);
          
          if(w1.searchFrequency<w2.searchFrequency){
            w1 = w2;
            n = i;
          }}
          
          if(n>-1&&unsortedSearch.get(n).a!=" "){
          if(n>-1)sortedSearch.add(unsortedSearch.remove(n));
          else if(unsortedSearch.size()>0)sortedSearch.add(unsortedSearch.remove(j));
    }else if(n>-1)unsortedSearch.remove(n);
   }}}
  
    if(sortedSearch.size()>0){
      int y1 = 70;
      fill(255);
      text("|" + a + "|" ,10,y1-20);
      text(sortedSearch.size(),10,y1-10);
    for(int i=0;i<sortedSearch.size();i++){
      Word w = sortedSearch.get(i);
      
      text("|" + w.a + "|",10,y1+10*i);
      text(w.searchFrequency,100,y1+10*i);
      text(w.frequency,200,y1+10*i);
    }}
     if(sortedSearch.size()==0&&unsortedSearch.size()==0) text("Temp is empty",10,50);
  }
  else text("Scanning not finnished", 10,50);
};

ArrayList<Word> findSimilar(String a,int b,int c){
    fill(255);
      ArrayList<Word>temp = new ArrayList<Word>();
      
      if(textcompleted){
        
  if(words1dsingle.contains(a)){
    
    if(!foundS){
      int k = words1dsingle.indexOf(a);
      
      Word w1 = Words1dsingle.get(k);
      
  for(int i=0;i<w1.ypos.size();i++){
    
    ArrayList<String> s = words.get(w1.ypos.get(i));
    
    //float deltaf = abs(w1.frequency - w2.frequency);
    int count = 0;
    for(int j=w1.xpos.get(i)-c;j<w1.xpos.get(i)+b+1;j++){
      
      if(j>0&&j<s.size()){
      int k2 = words1dsingle.indexOf(s.get(j));
      
      Word w2 = Words1dsingle.get(k2);
      if(w1.a!=w2.a&&!unsortedSearch.contains(w2)){
        w2.p = j;
        w2.searchFrequency++;
        unsortedSearch.add(w2);
      }
      if(w1.a!=w2.a&&unsortedSearch.contains(w2)){
        int k1 = unsortedSearch.indexOf(w2);
        unsortedSearch.get(k1).searchFrequency++;
        //unsortedSearch.add(w2);
        
      }
      
      }}}
    
      foundS = true;
      
      //for(int i=0;i<unsortedSearch.size();i++){
      //  Word w = unsortedSearch.get(i);
      //  w.searchFrequency /= unsortedSearch.size();
      //}

    }}else{
      
      text("Choose, new word",10,40);
    }}
  
  if(textcompleted){
  if(foundS){
    
    if(unsortedSearch.size()>0)text(unsortedSearch.size(),10,40);
    else text(sortedSearch.size(),10,40);
    
    Word w1 = null;
    
    if(unsortedSearch.size()>0){
      
      for(int j=unsortedSearch.size()-1;j>-1;j--){
        
        w1 = unsortedSearch.get(j);
        int n = -1;
        
        for(int i=unsortedSearch.size()-2;i>-1;i--){
          
          Word w2 = unsortedSearch.get(i);
          
          if(w1.searchFrequency<w2.searchFrequency){
            w1 = w2;
            n = i;
          }}
          
          if(n>-1)sortedSearch.add(unsortedSearch.remove(n));
          else if(unsortedSearch.size()>0)sortedSearch.add(unsortedSearch.remove(j));
    }
    
  }}
  
    if(sortedSearch.size()>0){
      
      temp = sortedSearch;
      if(sortedSearch.size()==0&&unsortedSearch.size()==0)temp = null;
      
    }}else {
    text("Scanning not finnished", 10,50);
    temp = null;
  }
  
  return temp;
};

void findSimilar(String a,int b,int c,int d){
    fill(255);
      ArrayList<Word>temp = new ArrayList<Word>();
      
      if(textcompleted){
        
  if(words1dsingle.contains(a)){
    
    if(!foundS){
      int k = words1dsingle.indexOf(a);
      
      Word w1 = Words1dsingle.get(k);
      
  for(int i=0;i<w1.ypos.size();i++){
    
    ArrayList<String> s = words.get(w1.ypos.get(i));
    
    //float deltaf = abs(w1.frequency - w2.frequency);
    int count = 0;
    for(int j=w1.xpos.get(i)-c;j<w1.xpos.get(i)+b+1;j++){
      
      if(j>=0&&j<s.size()){
      int k2 = words1dsingle.indexOf(s.get(j));
      
      Word w2 = Words1dsingle.get(k2);
      if(w1.a!=w2.a&&w2.a != " "&&!unsortedSearch.contains(w2)){
        w2.p = w1.xpos.get(i)+j;
        w2.searchFrequency++;
        unsortedSearch.add(w2);
      }
      if(w1.a!=w2.a&&unsortedSearch.contains(w2)){
        int k1 = unsortedSearch.indexOf(w2);
        unsortedSearch.get(k1).searchFrequency++;
        //unsortedSearch.add(w2);
        
      }}}}
    
      foundS = true;
      
      //for(int i=0;i<unsortedSearch.size();i++){
      //  Word w = unsortedSearch.get(i);
      //  w.searchFrequency /= unsortedSearch.size();
      //}

    }}else{
      
      text("Choose, new word",10,40);
    }}
  
  if(textcompleted){
  if(foundS){
    
    if(unsortedSearch.size()>0)text(unsortedSearch.size(),10,40);
    else text(sortedSearch.size(),10,40);
    
    Word w1 = null;
    
    if(unsortedSearch.size()>0){
      
      for(int j=unsortedSearch.size()-1;j>-1;j--){
        
        w1 = unsortedSearch.get(j);
        int n = -1;
        
        for(int i=unsortedSearch.size()-2;i>-1;i--){
          
          Word w2 = unsortedSearch.get(i);
          
          if(w1.searchFrequency<w2.searchFrequency){
            w1 = w2;
            n = i;
          }}
          
          if(n>-1)sortedSearch.add(unsortedSearch.remove(n));
          else if(unsortedSearch.size()>0)sortedSearch.add(unsortedSearch.remove(j));
    }
    
  }}
  
    if(sortedSearch.size()>0){
      int y1 = 70;
      fill(255);
      text("|" + a + "|" ,10,y1-10);
    for(int i=0;i<sortedSearch.size();i++){
      Word w = sortedSearch.get(i);
      
      text(w.a,10,y1+10*i);
      text(w.searchFrequency,100,y1+10*i);
      text(w.frequency,200,y1+10*i);
    }}
     if(sortedSearch.size()==0&&unsortedSearch.size()==0) text("Temp is empty",10,50);
  }
  else text("Scanning not finnished", 10,50);
};

void findLeastSimilar(String a,float b){
    fill(255);
      ArrayList<Word>temp = new ArrayList<Word>();
      
      if(textcompleted){
        
  if(words1dsingle.contains(a)){
    
    if(!foundS){
      int k = words1dsingle.indexOf(a);
      
      Word w1 = Words1dsingle.get(k);
      
  for(int i=0;i<Words1dsingle.size();i++){
    
    Word w2 = Words1dsingle.get(i);
    
   float deltav = abs(w1.variance - w2.variance);
   float deltaf = abs(w1.frequency - w2.frequency);
    
    if(deltav > b)unsortedSearch.add(w2);
    
  }foundS = true;}}else{
    
    text("Choose, new word",10,40);
  }}
  
  if(textcompleted){
  if(foundS){
    if(unsortedSearch.size()>0)text(unsortedSearch.size(),10,40);
    else text(sortedSearch.size(),10,40);
    Word w1 = null;
    if(unsortedSearch.size()>0){
      
      
      for(int j=unsortedSearch.size()-1;j>-1;j--){
        w1 = unsortedSearch.get(j);
        int n = -1;
        for(int i=unsortedSearch.size()-2;i>-1;i--){
          Word w2 = unsortedSearch.get(i);
          
          if(w1.variance<w2.variance){
            w1 = w2;
            n = i;
          }}
          
          if(n>-1){
            
          sortedSearch.add(unsortedSearch.remove(n));
          
          }else if(unsortedSearch.size()>0)sortedSearch.add(unsortedSearch.remove(j));
    }
    
  }}
  
    if(sortedSearch.size()>0)
    for(int i=0;i<sortedSearch.size();i++){
      Word w = sortedSearch.get(i);
      
      text('"'+w.a+'"',10,50+10*i);
      text(w.variance,100,50+10*i);
      text(w.frequency,200,50+10*i);
    }
     if(sortedSearch.size()==0&&unsortedSearch.size()==0) text("Temp is empty",10,50);
  }
  else text("Scanning not finnished", 10,50);
};

int getFrequency(String a){
  int i = -1;
  if(textcompleted){
  if(words1dsingle.contains(a)){
    int k = words1dsingle.indexOf(a);
    Word w = Words1dsingle.get(k);
    
    i = w.frequency;
    
  }else{
   fill(255);
   text("Choose another word!",300,70);
  }}
  else{
   fill(255);
   text("Scanning not finished",300,70);
  }
  
  fill(255);
  text(i,300,80);
  return i;
};

void logic(){
  if(mousePressed)mdown = true;
  if(!mousePressed) mdown = false;
  
};

void createSentence(String Start,int size){
  //fill(255);
  //  text("Building Sentence",100,80);
  if(mdown){
    newSentence = new ArrayList<Word>();
  }
  else if(textcompleted){
  //if(start == null && newSentence.size()==0){
    
   if(words1dsingle.contains(Start)){
     
     if(newSentence.size()==0){
       start = Words1dsingle.get(words1dsingle.indexOf(Start));
       newSentence.add(start);
     }else if(start!=null){
       fill(255);
       rect(0,0,width,height);
       fill(0);
       text("Loading",100,80);
       float cursorx = 0;
       
       for(int i=0;i<100;i++){
         foundS = false;
         
         wordPool = findSimilar(start.a,1,float(newSentence.size()));
           
           if(wordPool.size()>0){
           Word nextWord = wordPool.get(floor(random(wordPool.size())));
           newSentence.add(nextWord);
           start = nextWord;
           
             if(nextWord.a.length()>1){
               char a = nextWord.a.charAt(nextWord.a.length()-1);
             if(a=='!'||a=='?'||a=='.'){
               start = null;
               break;
             }}else if(start.a=="!"||start.a=="?"||start.a=="."){
          start = null;
          break;
        }}else {
          start = null;
          break;
      }}
      //start = null;
    }}else{
    fill(255);
    text("Word Not Found",100,90);
   }
   
   if (newSentence.size()>0){
       fill(255);
       float cursorx = 0;
       int h = 0;
       if(start!=null)text(start.a,100 ,70);
       if(wordPool.size()==0)text("No words in pool !",160 ,70);
       for(int i=0;i<newSentence.size();i++){
         
         Word word = newSentence.get(i);
         if(cursorx + textWidth(word.a + " ")+100> width){
           h++;
           cursorx = 0;
         }
         text( word.a + " " ,100 +cursorx,90+(h*10));
         cursorx += textWidth(word.a + " ");
         }
       
       //for(int i=0;i<newSentence.size();i++){
       //  Word word = newSentence.get(i);
         
       //  for(int j=0;j<word.a.length();j++){
           
       //  char a = word.a.charAt(j);
       //  if(a == ' ') a= '!';
       //  text("," + a + ",",300 +10*j,90+10*i);
       //}}
     
   }}
  
};

void neural_inputs(){
  
  int count = 0;
  
  if(!inputs_complete){
  for(int i=0;i<words.size();i++){
    
    ArrayList<String> s = words.get(i);
    
    for(int j=0;j<s.size();j++){
      
      Word w = Words1d.get(count);
      count ++;
      
      int count2 = 0;
      for(int k=0;k<words.size();k++){
    
        ArrayList<String> s2 = words.get(k);
        
        for(int l=0;l<s.size();l++){
          
          Word w2 = Words1d.get(count2);
          
          Word[] n = {w,w2};
          
          ninputs.add(n);
          
    }}}}}if(count==Words1d.size())inputs_complete = true;
};


void mostFrequent(){
  
};

float getVariance(String a){
  float i = -1;
  Word w1 = null;
  if(textcompleted){
  if(words1dsingle.contains(a)){
    int k = words1dsingle.indexOf(a);
    Word w = Words1dsingle.get(k);
    
    i = w.variance;
    w1 = w;
    
  }else{
   fill(255);
   text("Choose another word!",500,70);
  }}
  else{
   fill(255);
   text("Scanning not finished",500,70);
  }
  
  fill(255);
  text(i,500,80);
  if(w1!=null)text(w1.frequency,500,90);
  return i;
};

void getTFIDF(){
  
};

//void normalize(Word w){
  
//  for(int i=0;i<w.pos2.size();i++){
    
    
//  }
  
//};



class Word{
  
  int x,y,p,t;
  float w,l,maxWordVariance,searchFrequency;
  String a;
  ArrayList<Integer> xpos = new ArrayList<Integer>();
  //ArrayList<ArrayList<Integer>> xpos = new ArrayList<ArrayList<Integer>>();
  ArrayList<Integer> ypos = new ArrayList<Integer>();
  ArrayList<Integer> cXpos = new ArrayList<Integer>();
  ArrayList<Integer> cYpos = new ArrayList<Integer>();
  ArrayList<Integer> flatRef = new ArrayList<Integer>();
  ArrayList<Integer> occurence = new ArrayList<Integer>();
  ArrayList<Integer> sentence_occurence = new ArrayList<Integer>();
  ArrayList<Float> sentenceSize = new ArrayList<Float>();
  float variance,sentenceSize_;
  int frequency;
  ArrayList<Integer> pos = new ArrayList<Integer>();
  ArrayList<Float> pos2 = new ArrayList<Float>();
  ArrayList<Word> previousWord = new ArrayList<Word>();
  ArrayList<Word> nextWord = new ArrayList<Word>();
  float textpos;
  boolean varianced,beginning,end;
  
  
  Word(int pp,int xx,int yy,float ww,int ll,String aa){
    x = xx;
    y = yy;
    a = aa;
    p = pp;
    pos.add(pp);
    textpos = pp;
    //pos2.add(w);
    xpos.add(xx);
    ypos.add(yy);
    w = ww;
    l = ll;
    
  };
  
  Word(int pp,int xx,int yy,float ww,int ll,String aa,int tpos,int sentences,int total){
    x = xx;
    y = yy;
    a = aa;
    p = pp;
    pos.add(pp);
    textpos = tpos;
    //for(int i=0;i<words1d.size();i++){
    //  occurence.add(0);
    //}
    //for(int i=0;i<longest_sentence;i++){
    //  sentence_occurence.add(0);
    //}
    
    //occurence.set(tpos,1);
    xpos.add(xx);
    ypos.add(yy);
    w = ww;
    l = ll;
    
  };
  
  Word(int pp,int xx,int yy,float v,float ww,int ll,String aa,int tpos,int sentences,int total){
    x = xx;
    y = yy;
    a = aa;
    p = pp;
    variance = v;
    pos.add(pp);
    textpos = tpos;
    for(int i=0;i<words1d.size();i++){
      occurence.add(0);
    }
    for(int i=0;i<longest_sentence;i++){
      sentence_occurence.add(0);
    }
    
    occurence.set(tpos,1);
    xpos.add(xx);
    ypos.add(yy);
    w = ww;
    l = ll;
    
  };
  
  void calcVariance(){
    
    if(!varianced){
    //max_size * Sentences.size();
    for(int i=0;i<pos2.size();i++){
      float v = pos2.get(i);
      float u = sentenceSize.get(i)*sentenceSize.get(i);
      variance += v;
      sentenceSize_ += u;
    }
    
    variance /= frequency;
    sentenceSize_ /= frequency;
    //if(maxWordVariance>0)
    //variance = map(variance,0,maxWordVariance,0,1);
    //else println(a);
    //variance = variance/frequency;
    
    for(int i=0;i<pos.size();i++){
      int v = pos.get(i);
      
      p += v;
      //println(v);
      if(i==pos.size()-1){
        p/= pos.size();
        p = (int)map(p,0,longest_sentence,0,1);
        //variance = map(variance,0,max_size,0,1);
        varianced = true;
    }}}
    
  };
  
  void setVariance(){
    //variance = map(variance,0,maxVariance,0,100000);
    //variance = map(variance,0,maxWordVariance*maxWordVariance,0,10);
  }
  
  
};

};
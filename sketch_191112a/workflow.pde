  //ArrayList<String> string_to_array(String [] a){
  //  String s = "";
  //  for(int i=0;i<a.length;i++){
  //    if(a[i].length()>0){
  //    String k = a[i] + ",";
      
  //    if(a[i].charAt(a[i].length()-1)==',')s += a[i];
  //    else s += k;
  //  }}
  //  int char_counter = 0;
    
  //  ArrayList<String> s1 = new ArrayList<String>();
    
  //  for(int i=0;i<s.length();i++){
      
  //    char c = s.charAt(i);
      
  //    if(c==','){
  //      String b = s.substring(char_counter,i);
        
  //      s1.add(b);
  //      char_counter = i+1;
  //    }
  //  }
    
  //  return s1;
  //};
  
  
  
class Workflow extends taskList{
    
    Table_ table;
    
    
    Workflow(float x,float y,float w,float h, int tcols, int trows){
      
      table = new Table_(x,y,w,h,tcols,trows,0);
      
      
    };
    
    void draw_workflow(){
      
      displayList();
      if(Buttons.get(0).toggle==1){
        table.draw();
        
      }
      
    };
    
    
    
};
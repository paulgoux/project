class Html{
  
  String html = "",url;
  ArrayList<String> lines = new ArrayList<String>();
  ArrayList<String> links = new ArrayList<String>();
  boolean stop = false,textScanned;
  
  int counter;
  
  Html(String Url){
    url = Url;
    
    
    String line, result = "";
      if(!stop){
      try {
        HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
        conn.setRequestMethod("GET");
        setRequestHeaders(conn);
        BufferedReader rd = new BufferedReader
          (new InputStreamReader(conn.getInputStream()));
        while ( (line = rd.readLine ()) != null) {
          result += line;
          lines.add(line);
          html += line;
        }
        rd.close();stop = true;
      } 
      catch (Exception e) {
        e.printStackTrace();
      }}
  };
  
  void getString(){
    
  String html = getHTML(url);
  //println(html);
  }

    String getHTML(String url) {
      
      String line, result = "";
      if(!stop){
    
      try {
        HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
        conn.setRequestMethod("GET");
        setRequestHeaders(conn);
        BufferedReader rd = new BufferedReader
          (new InputStreamReader(conn.getInputStream()));
        while ( (line = rd.readLine ()) != null) {
          result += line;
          lines.add(line);
          html += line;
        }
        rd.close();stop = true;
      } 
      catch (Exception e) {
        e.printStackTrace();
      }}
    
      return html;
    }

    void setRequestHeaders(HttpURLConnection conn)
    {
      String ua = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.56 Safari/536.5";
      conn.setRequestProperty("User-Agent", ua);
      conn.setRequestProperty("Accept-Language", "en-US,en;q=0.8");
      conn.setRequestProperty("Accept-Charset", "ISO-8859-1,utf-8;q=0.7,*;q=0.3");
      conn.setRequestProperty("Connection", "keep-alive");
      conn.setRequestProperty("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
    }
    
    void readString(){
      
      //for(int i=0;i<html
      
      fill(255);
      for(int i=0;i<lines.size();i++){
        String s = lines.get(i);
        
        text(s,40,40+10*i);
      }
      
    };
    
    void getLinks(){
      counter = 0;
      if(!textScanned){
      for(int i=0;i<html.length() - 4;i++){
        char h = html.charAt(i);
        char t = html.charAt(i+1);
        char t_ = html.charAt(i+2);
        char p = html.charAt(i+3);
        
        if(h=='h'&&t=='t'&&t_=='t'&&p=='p'){
          counter = i;
          
          findEnd(i);
          }
          if(i==html.length() - 5) textScanned = true;
      }}
      
      if(textScanned)println(links.size());
      
      
      
    };
    
    void findEnd(int i){
      
      for(int j=i+3;j<html.length();j++){
            char end = html.charAt(j);
            if(end=='>'){
              links.add(html.substring(counter,j));break;
            }}
    };
    
    void displayLinks(){
      
      for(int i=0;i<links.size();i++){
        String s = links.get(i);
        fill(255);
        text(s,10,50 + 10 * i);
      }
      
    };
  
};




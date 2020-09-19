String [] WordStream(String Loc){
  WordExtractor extractor = null;
  String s = "sketch_191112a\\";
  String [] fileData = null;
  File file = null;
        
        try{

            file = new File(Loc);
            FileInputStream fis = new FileInputStream(file.getAbsolutePath());
            
            HWPFDocument document = new HWPFDocument(fis);
            extractor = new WordExtractor(document);
            
            fileData = extractor.getParagraphText();
            
            for (int i = 0; i < fileData.length; i++){
              
                if (fileData[i] != null)System.out.println(fileData[i]);
                
            }}
            catch (Exception exep){
            //exep.printStackTrace();
        }
        return fileData;
};

String [] WordStream(File file){
  WordExtractor extractor = null;
  String [] fileData = null;
        
        try{
            FileInputStream fis = new FileInputStream(file.getAbsolutePath());
            
            HWPFDocument document = new HWPFDocument(fis);
            extractor = new WordExtractor(document);
            
            fileData = extractor.getParagraphText();
            
            for (int i = 0; i < fileData.length; i++){
              
                if (fileData[i] != null)System.out.println(fileData[i]);
                
            }}
            catch (Exception exep){
            //exep.printStackTrace();
        }
        return fileData;
};

Object getFromClipboard (DataFlavor flavor) {

  Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard(); 
  Transferable contents = null;
  try{
   contents = clipboard.getContents(null);
  }catch(IllegalStateException e){
    
  }
  
  Object object = null;

  if (contents != null && contents.isDataFlavorSupported(flavor))
  {
    try
    {
      object = contents.getTransferData(flavor);
      //println("Clipboard.getFromClipboard() >> Object transferred from clipboard.");
    }

    catch (UnsupportedFlavorException e1) // Unlikely but we must catch it
    {
      //println("Clipboard.getFromClipboard() >> Unsupported flavor: " + e1);
      //~  e1.printStackTrace();
    }

    catch (java.io.IOException e2)
    {
      //println("Clipboard.getFromClipboard() >> Unavailable data: " + e2);
      //~  e2.printStackTrace();
    }
  }

  return object;
}

String getTextFromClipboard () {
  String text = (String) getFromClipboard(DataFlavor.stringFlavor);
 
  if (text==null) 
    return "";
 
  return text;
}

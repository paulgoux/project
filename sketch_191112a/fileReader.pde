class fileReader{

    String location;
    String []text;

    fileReader(){

    }

    fileReader(String location){
        this.location = location;
        text = loadStrings(location);
    }

    void read(String location){
        this.location = location;
        text = loadStrings(location);
    }

};
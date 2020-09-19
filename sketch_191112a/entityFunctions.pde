void spawnRaces(String a, int b,int num){
  entities = new ArrayList<Entity>();
  Entity e = new Entity(23,20,W-46,H-90);
  e.ent = entities.size();
  e.hRaces = b;
  int pos = entities.size();
  float a1 = 0;
  
  for(int i=0;i<8;i++){
    e.oscilators.add(a1);
    e.oscilatorCounters.add(a1);
  };
  //e.saveEntities.checkLocation(e.saveLocations[0]);
  
  // e.saveEntities.location = e.saveLocations[0];
  // e.saveEntities.folderPath = "entities"; 
  // e.saveLocation = e.saveLocations[0];
  if(a=="Human"||a=="human"||a=="humans"||a=="Humans"){
    
    for(int i=0;i<b;i++){
      
      ArrayList<Human> race = new ArrayList<Human>();
      color c = color(random(255),random(255),random(255));
      
      float r = random(10,20);
      //r = 10;
      float br = random(r*2,50);
      float vlimit = random(5,10);
      vlimit = 5;
      float alimit = random(0.1,0.9);
      alimit = 0.1;
      float min = random(r*2,50);
      float m = 0;
      for(int j=0;j<num;j++){
        Human h = new Human(random(W),random(H),j,i,pos,c);

        h.scene = e.scene;

        h.radius = r + random(-m,m);

        h.oscilators = e.oscilators;

        h.oscilatorCounters = e.oscilatorCounters;

        h.breathingroom = br + random(-m,m);

        h.vlimit = vlimit + random(-m,m);

        h.vlimitb = h.vlimit;

        h.alimit = alimit+ random(-m,m);

        h.alimitb = alimit;

        h.mass = h.radius*0.4+ random(-m,m);

        h.min = min+ random(-m,m);

        h.minb = h.min;
        race.add(h);
    }
    e.Humans.add(race);

    }
    //e.saveEntities.close();

      for(int k=0;k<b;k++){
        //e.saveEntities.write_("[");
        for(int l=0;l<b;l++){
          e.Humans.get(k).get(0).seekNeighbour.add(float(-1));
          e.Humans.get(k).get(0).avoidNeighbour.add(float(-1));
          e.Humans.get(k).get(0).alignNeighbour.add(float(-1));
          e.Humans.get(k).get(0).prox2.add(new ArrayList<Human>());
        }
        float maxAvoid = 0;
        float minAvoid = 1000000;
        float maxSeek = 0;
        float minSeek = 1000000;
        float minAlign = 1000000;
        float maxAlign = 0;
        float maxRange = 0;
        float minRange = 100000;
        for(int l=0;l<b;l++){
          int p = floor(random(20));
          int p1 = floor(random(20));
          int p2 = floor(random(20));
          if(l!=k){
            
            if(p>=10){
              float m1 = random(0,50);
              e.Humans.get(k).get(0).seekNeighbour.set(l,m1);
              e.Humans.get(k).get(0).maxSeek = maxSeek;
              e.Humans.get(k).get(0).minSeek = minSeek;
              if(a1>maxSeek)maxSeek = m1;
              if(a1<minSeek)minSeek = m1;
            }
              else e.Humans.get(k).get(0).seekNeighbour.set(l,float(-1));

            if(p1>=10){
              float m1 = random(0,50);
              e.Humans.get(k).get(0).avoidNeighbour.set(l,m1);
              if(a1>maxAvoid)maxAvoid = m1;
              if(a1<minAvoid)minAvoid = m1;
            }
              else e.Humans.get(k).get(0).avoidNeighbour.set(l,float(-1));

            if(p2>=10){
              float m1 = random(0,50);
              e.Humans.get(k).get(0).alignNeighbour.set(l,m1);
              e.Humans.get(k).get(0).maxAlign = maxAlign;
              e.Humans.get(k).get(0).minAlign = minAlign;
              if(a1<minAlign)minAlign = m1;
              if(a1>maxAlign)maxAlign = m1;
            }
              else e.Humans.get(k).get(0).alignNeighbour.set(l,float(-1));
            
            e.Humans.get(k).get(0).maxRange = maxRange;
            e.Humans.get(k).get(0).minRange = minRange;
            
      }
      if(l==k){
        e.Humans.get(k).get(0).seekNeighbour.set(k,float(-1));
        
        e.Humans.get(k).get(0).avoidNeighbour.set(k,float(-1));
        e.Humans.get(k).get(0).alignNeighbour.set(k,float(-1));
        
      }}}
       e.save();
      }

  if(a=="Plant"||a=="plant"||a=="plants"||a=="Plants"){
    for(int i=0;i<b;i++){

      ArrayList<Plant> species = new ArrayList<Plant>();

      for(int j=0;j<num;j++){

        Plant p = new Plant(random(W),random(H),i,j,pos);

        p.scene = e.scene;

        species.add(p);

    }e.Plants.add(species); }}
  if(a=="Mineral"||a=="mineral"||a=="minerals"||a=="Minerals"){
    for(int i=0;i<b;i++){

      ArrayList<Mineral> species = new ArrayList<Mineral>();

      for(int j=0;j<b;j++){

        Mineral m = new Mineral(random(W),random(H),i,j,pos);

        m.scene = e.scene;

        species.add(m);

    }e.Minerals.add(species); }}

  if(a=="Animal"||a=="animal"||a=="Animals"||a=="animals"){
    for(int i=0;i<b;i++){

      ArrayList<Animal> species = new ArrayList<Animal>();

      for(int j=0;j<num;j++){

        Animal A = new Animal(random(W),random(H),i,j,pos);

        A.scene = e.scene;

        species.add(A);

    }e.Animals.add(species); }}

  if(a=="Metals"||a=="metal"||a=="metals"||a=="Metals"){
    for(int i=0;i<b;i++){

      ArrayList<Metal> type = new ArrayList<Metal>();

      for(int j=0;j<num;j++){

        Metal m = new Metal(random(W),random(H),i,j,pos);

        m.scene = e.scene;

        type.add(m);

    }e.Metals.add(type); }
  }

  entities.add(e);

  if(entities.size()==b){

    for(int i=0;i<entities.size();i++){

         //Entity e = entities.get(i).Humans.get(0);
         
         
    }}
};

void textbox(Button a,Object b){

}


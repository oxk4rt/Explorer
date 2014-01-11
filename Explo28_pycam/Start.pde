/* 
 * Por:
 * Oscar Espada García
 * oscar.es.garci@gmail.com
 *
 */
 
class Start extends Element{
  
  Start(PGraphics buffer_, String name_, PVector reference_system){
    super(buffer_, reference_system);
    this.name = name_;
  }
  
  public void storingData(XML[] data){
      println("Load data number: "+data.length+".");
      for(int i=0; i<data.length; i++){ 
        if(data[i].getString("type").equals("pvector")){
             this.center.x = data[i].getChild("x").getInt("value");
             this.center.y = data[i].getChild("y").getInt("value");
             this.center.z = data[i].getChild("z").getInt("value");
        }else if(data[i].getString("type").equals("grade")){
             this.grade = data[i].getInt("value");
        }else if(data[i].getString("type").equals("color")){
             this.r = data[i].getChild("r").getInt("value");
             this.g = data[i].getChild("g").getInt("value");
             this.b = data[i].getChild("b").getInt("value");
             this.a = data[i].getChild("a").getInt("value");
        }else if(data[i].getString("type").equals("diameter")){
             this.radius = data[i].getFloat("value")/2;
           this.volume = (4/3) * PI * pow(this.radius,3);
        }else if(data[i].getString("type").equals("radiusorbit")){
             this.radius_orbit = data[i].getFloat("value");
        }else if(data[i].getString("type").equals("module")){
             this.module = data[i].getFloat("value");
        }else if(data[i].getString("type").equals("mass")){
             this.mass = data[i].getString("value");
        }else if(data[i].getString("type").equals("inclination")){
             this.inclination = data[i].getInt("value");
        }else if(data[i].getString("type").equals("speed")){
             this.speed = data[i].getFloat("value");
        }
      }
  }
  
  public void refresh(PGraphics buffer_){
    super.refresh(buffer_);
    this.grade++;
    this.center.x = cos(radians(this.grade/this.module)) * this.radius_orbit;
    this.center.y = sin(radians(this.grade/this.module)) * this.radius_orbit;   
  }
  
  public void draw(){
    pushMatrix();
    translate(this.center.x, this.center.y, this.center.z);
    shininess(5.0); 
    this.display(); 
    noStroke();
    popMatrix();
    this.refresh(this.buffer);
  }
  
}

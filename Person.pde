class Person {
  String name;
  int age = 0;
  int x;
  int y;
  int s;
  color c;
  
  public Person(String name, int age, int x, int y, int s, color c) {
    this.name = name;
    this.age = age;
    this.x = x;
    this.y = y;
    this.s = s;
    this.c = c;
  }
  
  void display() {
    fill(255);
    textFont(font);
    text(this.name + " " + age, this.x + -90, this.y + -60);
    fill(this.c);
    translate(this.x, this.y);
    sphere(this.s);
  }
}

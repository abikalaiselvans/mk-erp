package bean;


public class MyBean {
  private String count;
  public String getCount() { return count; }
  public void setCount(String count) { this.count = count; }
  public MyBean() { 
    System.out.println("MyBean intialized");
    count =  "0";
  }
}

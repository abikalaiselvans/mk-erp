 <%@ page import="java.sql.*,java.io.*,java.util.*" %> 

<%



String connectionURL = "jdbc:mysql://localhost:3306/smartcampus";

if(request.getParameter("imgid")!=null && request.getParameter("imgid")!="")

{

  String id =   (request.getParameter("imgid"));



  String filename = id+".jpg";

  Connection con=null;

  try{  

  Class.forName("com.mysql.jdbc.Driver").newInstance();

  con=DriverManager.getConnection(connectionURL,"root","mythra");  

  Statement st1=con.createStatement();

  String strQuery = "select IMG_IMAGE from com_m_staff where CHR_EMPID='"+id+"'";

  out.println(strQuery);

  ResultSet rs1 = st1.executeQuery(strQuery);

  

  String imgLen="";

  if(rs1.next()){

  imgLen = rs1.getString(1);

 }  

  rs1 = st1.executeQuery(strQuery);

  if(rs1.next()){

  int len = imgLen.length();

  byte [] rb = new byte[len];

  InputStream readImg = rs1.getBinaryStream(1);

  int index=readImg.read(rb, 0, len);  

  st1.close();

  response.reset();

  response.setContentType("image/jpg");

  response.setHeader("Content-disposition","attachment; filename=" +filename);

  response.getOutputStream().write(rb,0,len); 

  response.getOutputStream().flush();  

  }

  }

  catch (Exception e){

  e.printStackTrace();

  }

}

%>
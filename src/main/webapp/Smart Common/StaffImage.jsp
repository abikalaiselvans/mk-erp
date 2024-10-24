 <%@ page import="java.sql.*,java.io.*,java.util.*" %> 
 <%@ page import="DBConnection.*" %>
<%



 
if(request.getParameter("imgid")!=null && request.getParameter("imgid")!="")

{

  String id =   (request.getParameter("imgid"));



  String filename = id+".jpg";

  Connection con=null;

  try{  
  con=new DBCon().getConnection();
  Statement st1=con.createStatement();
  String strQuery = "select IMG_IMAGE from com_m_staffaddressproof where CHR_EMPID='"+id+"'";
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

  catch (Exception e)
  {

  	e.printStackTrace();
	 

  }

}

%>
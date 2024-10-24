<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<%
 String company=request.getParameter("company");
 String address=request.getParameter("address");
 String city=request.getParameter("city");
 String state=request.getParameter("state");
 String pincode=request.getParameter("pincode");
 String phone=request.getParameter("phone");
 String pf=request.getParameter("pf");
 String esi=request.getParameter("esi");	
 String cpypf=request.getParameter("cpypf");	
 String cpypension=request.getParameter("cpypension");	
 String cpyesi=request.getParameter("cpyesi");
 String sql ="";
 		
sql ="UPDATE m_institution SET";
sql = sql +" CHR_NAME='"+company+"' , ";
sql = sql +" CHR_ADD1='"+address+"' , ";
sql = sql +" CHR_CITY='"+city+"' , ";
sql = sql +" CHR_STATE='"+state+"' , ";
sql = sql +" INT_PINCODE="+pincode+" , ";
sql = sql +" INT_PHONE="+phone+" , ";
sql = sql +" INT_PFAMT="+pf+" , ";
sql = sql +" INT_ESIAMT="+esi+" , ";
sql = sql +" INT_CPY_PFAMT="+cpypf+" , ";
sql = sql +" INT_CPY_PENSIONAMT="+cpypension+" , ";
sql = sql +" INT_CPY_ESIAMT="+cpyesi+"   ";
sql = sql +" WHERE INT_ID=1";
//out.println(sql);
CommonFunctions.Execute(sql);
response.sendRedirect("index.jsp");
%>
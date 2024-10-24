 <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.util.*" errorPage=""%>
<%@ page import="com.my.org.erp.bean.Attendance.Attinfo"%>
<div align="center">
					      <%
					  	
						 try
						 {
							ArrayList attinfo=(ArrayList) session.getAttribute("attinfo");	
							
						 	if(attinfo.size()>0)
							{
								out.println("<center>");
								out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
								out.println("<tr class='MRow1'>");
								out.println("<td class='boldEleven' colspan='10' align='center'><b>ATTENDANCE ERROR - INFORMATION </b></td>");
								out.println("</tr>");
								out.println("<tr class='MRow1'>");
								out.println("<td class='boldEleven'><b>S.No</b></td>");
								out.println("<td class='boldEleven'><b>Emp Id</b></td>");
								out.println("<td class='boldEleven'><b>Description</b></td>");
								out.println("<td class='boldEleven'><b>Details</b></td>");
								out.println("<td class='boldEleven'><b>Day Type</b></td>");
								out.println("<td class='boldEleven'><b>Register Type</b></td>");
								out.println("</tr>");
								 for(int i=0;i<attinfo.size();i++)
								 {
									Attinfo a= (Attinfo)attinfo.get(i);
									if(i%2==0)
										out.println("<tr class='MRow2'>");
									else
										out.println("<tr class='MRow1'>");	
									out.println("<td class='boldEleven'>"+(i+1)+"</td>");
									out.println("<td class='bolddeepred'>"+ a.getEmpid() +"/"+a.getName() +"</td>");
									out.println("<td class='bolddeepred'>Attendance Already entered ... </td>");
									out.println("<td class='bolddeepred'>"+a.getDate()+"</td>");	
									out.println("<td class='boldEleven'>"+a.getDaytype()+"</td>");
									out.println("<td class='boldEleven'>"+a.getRegistertype()+"</td>");
									out.println("</tr>");
								} 
								out.println("</table>");	
								out.println("</center>");
								
							}
						 
						}
						catch(Exception e)
						{
							out.println(e.getMessage());
						}
						
						
						  
					  %>
			            </div>
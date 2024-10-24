package com.my.org.erp.SmartPayroll;

import java.io.IOException;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.setting.CommonData;
 
public class DOBandWeddingMailActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{

		try 
		{
			String action = request.getParameter("actionS");
		 
			String sql = "";
			 
			if (action.equals("PAYDOBMail")) 
			{ 
				
				try
				{
					sql ="";	
					sql = sql+ " SELECT A.CHR_EMPID,A.CHR_STAFFNAME,A.CHR_GENDER,DATE_FORMAT(A.DT_DOB,'%d-%b-%Y') ,DAY(A.DT_DOB), DAY(now()),D.CHR_COMPANYNAME,E.CHR_BRANCHNAME ";
					sql = sql+ " FROM com_m_staff A,  com_m_company D, com_m_branch E  ";
					sql = sql+ " WHERE MONTHNAME(A.DT_DOB)= MONTHNAME(now()) AND A.INT_COMPANYID=D.INT_COMPANYID  AND A.INT_BRANCHID = E.INT_BRANCHID AND D.INT_COMPANYID = E.INT_COMPANYID    ";
					sql = sql+ " AND A.CHR_TYPE !='T'  ";
					sql = sql+ " AND A.CHR_HOLD!='Y'  ";
					sql = sql+ " AND DAY(A.DT_DOB)= DAY(now()) ";
					sql = sql+ " order BY DAY(A.DT_DOB) ";
					String Ddata[][] = CommonFunctions.QueryExecute(sql);
				
					String content="";
					
				
					for(int u=0; u<Ddata.length;u++)
					{	
						     
							content = content + "<html> ";
							content = content + "<head> ";
							content = content + "<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'> ";
							content = content + "<title> :: CARE IT SOLUTION :: t</title> ";
							content = content + "<style type='text/css'> <!-- ";
							content = content + ".style2 {color: #333300} ";
							content = content + ".style3 {color: #330000} ";
							content = content + ".style4 {color: #336600; } ";
							content = content + ".style5 { ";
							content = content + "	color: #3333FF; ";
							content = content + "	font-weight: bold; ";
							content = content + "} ";
							content = content + "--> ";
							content = content + "</style> ";
							content = content + "</head> ";
						    content = content + "<body  onpaste='return false;'> ";
						    content = content + "<DIV> ";
							
						  content = content + "  <table width='100%' border='0' cellspacing='0' cellpadding='0'> ";
						  content = content + "<tr> ";
						  content = content + "  <td><h2 class='style3'><strong>Dear   All,</strong></h2></td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + " <td>&nbsp;</td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + " <td>&nbsp;</td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + " <td><div align='center'> ";
						  content = content + "<h2><span class='style4'><strong>We are   glad to inform you that </strong></span><span class='style3'><strong>"+Ddata[u][1]+" </strong>&nbsp;<strong>From</strong> <strong> CARE -   "+Ddata[u][7]+"</strong></span><span class='style4'><strong>celebrating</strong> <strong>";
						  if("Male".equals(Ddata[u][3].trim()))
							  content = content + " his ";
						  else
							  content = content + " her "; 
						  content = content + " <strong>birthday </strong>on</strong></span><span class='style3'><strong> "+Ddata[u][3]+"</strong></span></h2> ";
						  content = content + "  </div></td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + " <td>&nbsp;</td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + "  <td>&nbsp;</td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + "<td><div align='center'> ";
						  content = content + "<h1 class='style5'>Happy   Birthday</h1> ";
						  content = content + " </div></td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + "  <td>&nbsp;</td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + "  <td>&nbsp;</td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + "  <td>&nbsp;</td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + " <td>&nbsp;</td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + "  <td>&nbsp;</td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + "<td><div align='center'><IMG id='Picture_x0020_3' height='280'  src='"+com.my.org.erp.common.CommonFunctions.getPath(request)+"/SmartCampus/flyer/Birthday.jpg' width='343'></div></td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + " <td>&nbsp;</td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + " <td>&nbsp;</td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + "  <td>&nbsp;</td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + "  <td>&nbsp;</td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + "  <td><div align='center'></div></td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + " <td><div align='center'></div></td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + "  <td><div align='center' class='style2'> ";
						  content = content + "<h2><span class='style3'><strong>Let us   all join hands in wishing</strong> <strong>";
						  if("Male".equals(Ddata[u][3].trim()))
							  content = content + " his ";
						  else
							  content = content + " her "; 
						  content = content + " </strong></span><strong> a wonderful   birthday</strong></h2> ";
						  content = content + " </div></td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + " <td><div align='center'> ";
						  content = content + "<h4><span class='style2'></span></h4> ";
						  content = content + "  </div></td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + "  <td><div align='center' class='style4'> ";
						  content = content + "   <h2><strong>May   everyone who knows you, shower a graceful smile and wishes on your   birthday,</strong></h2> ";
						  content = content + " </div></td>  ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + " <td><div align='center'> ";
						  content = content + "<h2><span class='style2'><span class='style4'></span></span></h2> ";
						  content = content + "  </div></td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + "<td><div align='center' class='style4'> ";
						  content = content + "   <h2><strong>making   it a special and memorable day.</strong></h2> ";
						  content = content + " </div></td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + " <td><div align='center'> ";
						  content = content + "<h2><span class='style2'><span class='style4'></span></span></h2> ";
						  content = content + "  </div></td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + " <td><div align='center' class='style4'> ";
						  content = content + "   <h2><em><strong>Warm   Regards,</strong></em></h2> ";
						  content = content + "</div></td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + "  <td><div align='center'></div></td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + "  <td><div align='center'> ";
						  content = content + "<h1><span class='style3'><em><strong>Care</strong></em></span></h1> ";
						  content = content + " </div></td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + " <td><div align='center'></div></td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + "  <td><div align='center'> ";
						  content = content + "<h2 class='style4'><em><strong>HR   Dept</strong></em></h2> ";
						  content = content + " </div></td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + "<td><div align='center'></div></td> ";
						  content = content + "</tr> ";
						  content = content + "<tr> ";
						  content = content + "<td><div align='center'></div></td> ";
						  content = content + "</tr> ";
						  content = content + "  </table> ";
						  
						content = content + "</DIV> ";
						content = content + "</body> ";
						content = content + "</html> ";
						
						Properties props = new Properties();
						props.setProperty("mail.transport.protocol", "smtp");
						//props.setProperty("mail.host", com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MAILHOST FROM m_institution WHERE  INT_ID=1")[0][0]);
						props.setProperty("mail.host", "192.168.0.5");
			        	props.setProperty("mail.user", "connect");
						props.setProperty("mail.password", "connect");
						Session mailSession = Session.getDefaultInstance(props, null);
						mailSession.setDebug(true);
						Transport transport = mailSession.getTransport();
						MimeMessage message = new MimeMessage(mailSession);
						message.setSubject("****** LETS ALL JOIN HANDS IN WISHING HIM/HER A WONDERFUL BIRTHDAY *****"); 
						message.setFrom(new InternetAddress(""+CommonData.mailid));
						message.setContent(content, "text/html");
						message.addRecipient(Message.RecipientType.TO, new InternetAddress(""+CommonData.mailid));
						transport.connect();
						transport.sendMessage(message, message.getRecipients(Message.RecipientType.TO));
						transport.close();
						
					}
					
				
					
					con.close();    
					response.sendRedirect("Smart Payroll/Payrollmain.jsp");
	  	          
				}
	    	 
		    	catch (Exception mex) 
		    	{
		    		 
		    		mex.printStackTrace();
		    	}
				 
			}
			 
				
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

}

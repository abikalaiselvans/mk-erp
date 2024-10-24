package com.my.org.erp.SmartMarketing;
import java.io.IOException;
import java.sql.CallableStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.SmartUtility.SendGreetingsMail;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 
import com.my.org.erp.common.CommonFunctions;

public class EmailCustomerActionHandler extends AbstractActionHandler 
{
	String sessionid="";
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session=request.getSession();	
			sessionid=session.getId();
			String user=""+session.getAttribute("USRID");			
			if ("MKTEmailCustomerAdd".equals(action)) 
			{
				
				String group=request.getParameter("group");
				String company=request.getParameter("company");
				String branch=request.getParameter("branch");
				String name=request.getParameter("name");
				String department=request.getParameter("department");
				String designation=request.getParameter("designation");
				String email=request.getParameter("email");
				String active=request.getParameter("active");
				String newsletter=request.getParameter("newsletter");
				
				if("on".equals(active) || "".equals(active))
					active="Y";
				else
					active="N";
				CallableStatement cs = con.prepareCall("{call MKT_PRO_EMAILCUSTOMERS(?,?,?,?,?,?,?,?,?,?,?,?)}");
				cs.setString(1, "INSERT");
				cs.setString(2, "1");
				cs.setString(3, group);
				cs.setString(4, company);
				cs.setString(5, branch);
				cs.setString(6, name);
				cs.setString(7, department);
				cs.setString(8, designation);
				cs.setString(9, email);
				cs.setString(10, newsletter);
				cs.setString(11,active );
				cs.setString(12, user);
				cs.execute();
				cs.close();
				 
				String id = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT MAX(INT_CUSTOMERID) FROM email_m_customerinfo")[0][0];
				sendFirstGreeting(name,id,email);
				response.sendRedirect("Smart Marketing/EmailCustomerAction.jsp?action1=Add&msg=Record Added Successfully");
			} 		
			else if ("MKTEmailCustomerEdit".equals(action)) 
			{
				String id=request.getParameter("id");
				String group=request.getParameter("group");
				String company=request.getParameter("company");
				String branch=request.getParameter("branch");
				String name=request.getParameter("name");
				String department=request.getParameter("department");
				String designation=request.getParameter("designation");
				String email=request.getParameter("email");
				String active=request.getParameter("active");
				String newsletter=request.getParameter("newsletter");
				if("on".equals(active) || "".equals(active))
					active="Y";
				else
					active="N";
				CallableStatement cs = con.prepareCall("{call MKT_PRO_EMAILCUSTOMERS(?,?,?,?,?,?,?,?,?,?,?,?)}");
				cs.setString(1, "UPDATE");
				cs.setString(2, id);
				cs.setString(3, group);
				cs.setString(4, company);
				cs.setString(5, branch);
				cs.setString(6, name);
				cs.setString(7, department);
				cs.setString(8, designation);
				cs.setString(9, email);
				cs.setString(10, newsletter);
				cs.setString(11,active );
				cs.setString(12, user);
				
				cs.execute();
				cs.close();
				 				
				response.sendRedirect("Smart Marketing/EmailCustomer.jsp");
			} 	
			else if ("MKTEmailCustomerDelete".equals(action)) 
			{
				String ids[] = request.getParameterValues("id");
				CallableStatement cs = con.prepareCall("{call MKT_PRO_EMAILCUSTOMERS(?,?,?,?,?,?,?,?,?,?,?,?)}");
				for (int i = 0; i < ids.length; i++) {
					cs.setString(1, "DELETE");
					cs.setString(2, ids[i]);
					cs.setString(3, "");
					cs.setString(4, "");
					cs.setString(5, "");
					cs.setString(6, "");
					cs.setString(7, "");
					cs.setString(8, "");
					cs.setString(9, "");
					cs.setString(10, "");
					cs.setString(11, "");
					cs.setString(12, "");
					cs.addBatch();
				}
				cs.executeBatch();
				cs.close();
				 				
				response.sendRedirect("Smart Marketing/EmailCustomer.jsp");
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
	
	public void sendFirstGreeting(String name,String id,String email)
	{
		try
		{
			 String s="";
			 s= "<html>  <head>  <meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>  <title>CARE IT Solutions</title>  <style type='text/css'>  <!--  .style7 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 12px; color: #000099; }  .style9 {  	font-family: Verdana, Arial, Helvetica, sans-serif;  	font-size: 18px;  	color: #FFFFFF;  	font-weight: bold;  }  .style10 {font-size: 16px}  .style12 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px; color: #990000; font-weight: bold; }  .style14 {font-size: 12px; font-family: Verdana, Arial, Helvetica, sans-serif;}  -->  </style>  </head>  <body  onpaste='return false;'>  <table width='800' border='0' align='center' cellpadding='2' cellspacing='2' bgcolor='#669932'>    <tr>     <td height=64><div align='center'><span class='style9'><span class='style10'>Tech Updates/Special Offers From</span> CARE IT Solutions <span class='style10'>Pvt.   Ltd</span></span></div></td>    </tr>    <tr>      <td><table width='800' border='0' cellpadding='4' cellspacing='4' bgcolor='#FFFFFF'>    ";
			 String s1= "";
			 s1= " <tr>          <td><div align='justify'><span class='style7'>With Thanks &amp; Warm Regards</span></div></td>        </tr>       <tr>          <td>&nbsp;</td>        </tr>        <tr>          <td><div align='justify'><img src='http://connect.careind.net/SmartCampus/images/logo.jpg' width='159' height='49'></div></td>        </tr>        <tr>          <td><div align='justify'><span class='style12'>Tech Team &ndash; CARE IT Solutions Pvt. Ltd</span></div></td>        </tr>        <tr>          <td><div align='justify'><span class='style7'>No: 8, 1st Main Road,</span></div></td>        </tr>        <tr>          <td><div align='justify'><span class='style7'>Seethammal Extn, Alwarpet,</span></div></td>        </tr>        <tr>          <td><div align='justify'><span class='style7'>Chennai &ndash; 600018</span></div></td>        </tr>        <tr>          <td><div align='justify'><span class='style7'>+91-44-24340906</span></div></td>        </tr>        <tr>          <td><div align='justify'><span class='style7'><a href='mailto:techupdate@careind.net'>techupdate@careind.net</a>&nbsp;</span></div></td>        </tr>        <tr>          <td><div align='justify'></div></td>        </tr>        <tr>          <td><div align='justify'><span class='style12'>DISCLAIMER: </span></div></td>        </tr>        <tr>   <td><div align='justify' class='style7'>This Unsolicited mail is an initiative to educate the entire community on the technical usage / get to know the new develpments of the technologies in the IT Infrastructure space  . </div></td>        </tr>        <tr>  <td><div align='justify' class='style7'>This mail is not a spam e-mail. You received this mail because either your e-mail address is listed in our address book or  one of your friends recommended your name. If this e-mail caused any inconvenience, we apologize for the same.</div></td>        </tr>        <tr>          <td><div align='justify' class='style7'>Since India has no anti-spamming law, we follow the US Unsolicited Electronic Mail act of 2000 and the US directive   passed in Bill 1618 Title III by the 105th US Congress, which states that mail can not be considered Spam if it contains contact information, and a mechanism to  exempt the mail recepient, if they wish to do so, which this mail does,. </div></td>        </tr> ";
			 String s3= "<tr>          <td>		</td>        </tr>      </table></td>    </tr>    <tr>      <td>&nbsp;</td>    </tr>  </table>  </body>  </html> ";
			 String from=CommonFunctions.QueryExecute("SELECT CHR_TECHNICALEMAILID FROM m_institution WHERE INT_ID=1")[0][0];
			 String subject ="Tech Updates/Special Offers From CARE IT Solutions Pvt. Ltd";
			 String content=SendGreetingsMail.readTextFromhtmlFile("Firstmail.html");
			 String message="";
			 message="";
			 message= s+"<tr><td><div align='justify'><span class='style7'><h3><b>Dear "+name+"</b></h3></span></div></td> </tr> "+content+s1;
			 message= message+ "<tr> ";
			 message= message+ "<td class='style7'>For any reason, if you are not interested to receive e mail communications from us in future, we request you to and send us an reply mail ";
			 message= message+ "with subject &quot;<strong><a href=\"http://connect.careind.net/SmartCampus/flyer/alert.jsp?sessionid="+sessionid+"&id="+id+"\">REMOVE</a></strong>&quot; and please be rest assured to stop getting any future e-mail from us.</td> ";
			 message= message+ "</tr> ";
			 message= message+ s3;
			 
			 SendGreetingsMail.sendHTMLMail(from, email, subject, message);
			  
		}
		catch (Exception e) {
			 System.out.println(e.getMessage());
		}
	}

}

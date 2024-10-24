package com.my.org.erp.SmartUtility;

import java.io.IOException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.*;
public class HTMLMailActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			HttpSession session = request.getSession();
			String action = request.getParameter("actionS");
			String sql ="";
			if (action.equals("UTIHTMLTechnicalMail")) 
			{	
				// sql="SELECT INT_COMPANYID ,CHR_CONTACTNAME,CHR_EMAIL,INT_CUSTOMERID  FROM email_m_customerinfo WHERE CHR_ACTIVE='Y' AND CHR_FLAG !='P' AND CHR_EMAIL is not NULL";
				 sql="SELECT CHR_COMPANYNAME ,CHR_CUSTOMERNAME,CHR_EMAIL,INT_CUSTOMERID  FROM email_m_customerinfo WHERE CHR_ACTIVE='Y' AND CHR_FLAG !='P' AND CHR_EMAIL is not NULL ORDER BY INT_CUSTOMERID";
				 String  data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				 
				 if(data.length>0)
				 {
				
					 String  data1[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_TECHHEADER,CHR_TECHNICALREMOVE,CHR_TECHFOOTER,CHR_TECHNICALSUBJECT FROM email_m_emailconfiguration  WHERE INT_ID=1");
					 String s="";
					 s= data1[0][0];
					 String s1= "";
					 s1= data1[0][2];
					 String s3= "";
					 s3= data1[0][1];
					 String from=CommonFunctions.QueryExecute("SELECT CHR_TECHNICALEMAILID FROM m_institution WHERE INT_ID=1")[0][0];
					 String subject ="";
					 String content=SendGreetingsMail.readTextFromhtmlFile("Technicalmail.html");
					 String to="";
					 String message="";
					 for(int u=0;u<data.length;u++)
					 {
						 System.out.println(data[0][3]);
						 message="";
						 subject=data1[0][3];
						 message= s+"<tr><td><div align='justify'><span class='style7'><h3><b>Dear "+data[u][1]+"</b></h3></span></div></td> </tr> "+content+s1;
						 message= message+ "<tr> ";
						 message= message+ "<td class='style7'>For any reason, if you are not interested to receive e mail communications from us in future, we request you to and send us an reply mail ";
						 message= message+ "with subject &quot;<strong><a href=\"http://connect.careind.net/SmartCampus/flyer/alert.jsp?sessionid="+session.getId()+"&id="+data[u][3]+"\">REMOVE</a></strong>&quot; and please be rest assured to stop getting any future e-mail from us.</td> ";
						 message= message+ "</tr> ";
						 message= message+ s3;
						  
						 to = data[u][2];
						 SendGreetingsMail.sendHTMLMail(from, to, subject, message);
					 }
				 }
				  
				con.close();  
				response.sendRedirect("Utility/Userframe.jsp");
			}
			else if(action.equals("UTIHTMLProductMail"))
			{
				 sql="SELECT INT_COMPANYID ,CHR_CONTACTNAME,CHR_EMAIL,INT_CUSTOMERID  FROM email_m_customerinfo WHERE CHR_ACTIVE='Y' AND CHR_FLAG !='T' AND CHR_EMAIL is not NULL";
				 String  data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				 
				 if(data.length>0)
				 {
				
					 String  data1[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_TECHHEADER,CHR_TECHNICALREMOVE,CHR_TECHFOOTER,CHR_PRODUCTSUBJECT FROM email_m_emailconfiguration  WHERE INT_ID=1");
					 String s="";
					 s= data1[0][0];
					 String s1= "";
					 s1= data1[0][2];
					 String s3= "";
					 s3= data1[0][1];
					 String from=CommonFunctions.QueryExecute("SELECT CHR_PRODUCTMAILID FROM m_institution WHERE INT_ID=1")[0][0];
					 String subject ="";
					 String content=SendGreetingsMail.readTextFromhtmlFile("Technicalmail.html");
					 String to="";
					 String message="";
					 for(int u=0;u<data.length;u++)
					 {
						 message="";
						 subject=data1[0][3];
						 message= s+"<tr><td><div align='justify'><span class='style7'><h3><b>Dear "+data[u][1]+"</b></h3></span></div></td> </tr> "+content+s1;
						 message= message+ "<tr> ";
						 message= message+ "<td class='style7'>For any reason, if you are not interested to receive e mail communications from us in future, we request you to and send us an reply mail ";
						 message= message+ "with subject &quot;<strong><a href=\"http://connect.careind.net/SmartCampus/flyer/alert.jsp?sessionid="+session.getId()+"&id="+data[u][3]+"\">REMOVE</a></strong>&quot; and please be rest assured to stop getting any future e-mail from us.</td> ";
						 message= message+ "</tr> ";
						 message= message+ s3;
						to = data[u][2];
						 SendGreetingsMail.sendHTMLMail(from, to, subject, message);
					 }
				 }
				 
				 
				con.close();  
				response.sendRedirect("Utility/Userframe.jsp");
			}
			else if (action.equals("UTIHTMLMailRemove")) 
			{	
				
				String id = request.getParameter("id");
				sql ="UPDATE email_m_customerinfo  SET CHR_ACTIVE='N' , DAT_REMOVEDATE=now() WHERE INT_CUSTOMERID="+id;
				Statement st = con.createStatement();
				st.execute(sql);
				st.close();
				con.close();  
				response.sendRedirect("flyer/Removealert.jsp");
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

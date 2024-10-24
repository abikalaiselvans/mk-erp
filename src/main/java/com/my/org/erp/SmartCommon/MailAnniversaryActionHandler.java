package com.my.org.erp.SmartCommon;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.SmartMail.Mail;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.setting.CommonData;
 
 
public class MailAnniversaryActionHandler extends AbstractActionHandler 
{
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			if("GENMailAnniversary".equals(action) ) 
			{    
				String company = request.getParameter("company");
				String branch = request.getParameter("branch");
				String Office = request.getParameter("Office");
				String dept = request.getParameter("dept");
				String month = request.getParameter("month");
				String day = request.getParameter("day");
				asql =" SELECT  A.CHR_STAFFNAME,D.CHR_OFFICENAME,B.CHR_DEPARTNAME,C.CHR_DESIGNAME,   "; 
				asql = asql +" DATE_FORMAT(DT_DOJCOLLEGE,'%d-%b-%Y') ,A.CHR_MOBILE,A.CHR_PERMAILID, ";
				asql = asql +" ROUND(DATEDIFF(NOW(),A.DT_DOJCOLLEGE )/365,0) ";
				asql = asql +"  FROM  com_m_staff  A,  com_m_depart   B, com_m_desig  C , com_m_office D  ";
				asql = asql +" WHERE  A.INT_OFFICEID= D.INT_OFFICEID  ";
				asql = asql +"   AND A.INT_DEPARTID=B.INT_DEPARTID AND A.INT_DESIGID=C.INT_DESIGID AND  A.CHR_TYPE !='T'";  
				asql = asql +"  AND A.CHR_HOLD!='Y'     ";
				if(!"0".equals(company))
				 	asql = asql +" AND A.INT_COMPANYID="+company;
				if(!"0".equals(branch))
				 	asql = asql +" AND A.INT_BRANCHID="+branch;
				if(!"0".equals(Office))
				 	asql = asql +" AND A.INT_OFFICEID="+Office;
				if(!"0".equals(dept))
				 	asql = asql +" AND A.INT_DEPARTID="+dept;
				if(!"0".equals(day))
				 	asql = asql +" AND DAY(A.DT_DOJCOLLEGE)="+day;
				if(!"0".equals(month))	
				 	asql = asql +" AND MONTH(A.DT_DOJCOLLEGE)="+month;
				asql = asql +" ORDER BY D.CHR_OFFICENAME ";
				System.out.println(asql);
				String data[][] = CommonFunctions.QueryExecute(asql);
			    String dbcontent="";
			    if(data.length>0)
			    {
			    	
			    	String[] attachments = new String [5];
			    	attachments[0] =Path+"images/dobmail/mailbackground.jpg";
			    	attachments[1] =Path+"images/dobmail/top.jpg";
					attachments[2] =Path+"images/dobmail/bottom.jpg"; 
					attachments[3] =  Path+"images/logo.jpg";
					attachments[4] =  Path+"images/20yrs.jpg";
					
					
			    	dbcontent = "<style type='text/css'> ";
			    	dbcontent = dbcontent + " <!-- ";
			    	dbcontent = dbcontent + " .style1 { ";
			    	dbcontent = dbcontent + " 	color: #FFFFFF; ";
			    	dbcontent = dbcontent + " 	font-size: 36px; ";
			    	dbcontent = dbcontent + " } ";
			    	
			    	dbcontent=dbcontent+" body {";
			    	dbcontent=dbcontent+"       padding:0px;";
			    	dbcontent=dbcontent+"       margin:0px;";
			    	//dbcontent=dbcontent+"	 background: url('mailbackground.jpg');";
			    	dbcontent=dbcontent+" } ";
			    	
			    	dbcontent = dbcontent + ".boldEleven { ";
			    	dbcontent = dbcontent + "	FONT-WEIGHT: normal; ";
			    	dbcontent = dbcontent + "	FONT-SIZE: 10px; ";
			    	dbcontent = dbcontent + "	COLOR: #000000; ";
			    	dbcontent = dbcontent + "	LINE-HEIGHT: 15px; ";
			    	dbcontent = dbcontent + "	FONT-FAMILY: Verdana; ";
			    	dbcontent = dbcontent + "	TEXT-DECORATION: none; ";
			    	dbcontent = dbcontent + "  ";
			    	dbcontent = dbcontent + "} ";
		    		
		    		
			    	dbcontent = dbcontent + " --> ";
			    	dbcontent = dbcontent + " </style> ";
			    	
			    	//dbcontent = dbcontent + "<br><br>";
			    	//dbcontent = dbcontent + "<center><img src='top.jpg' ></center> ";
			    	//dbcontent = dbcontent + "<br><br>";
			    	
			    	dbcontent = dbcontent + "<br><br>";
			    	dbcontent = dbcontent + "<center><h3><font  color='red'>Dear All,<br>We are Glad and would like to thank </font>  </h3> </center>";
			    	dbcontent = dbcontent + "<br><br>";
			    	
			    	dbcontent = dbcontent + " <table width='702' border='0' align='center' cellpadding='5' cellspacing='3' bgcolor='#0099FF'> ";
			    	dbcontent = dbcontent + "   <tr> ";
			    	dbcontent = dbcontent + "     <td> <div align='center'><span class='style1'>ANNIVERSARY </span></div></td> ";
			    	dbcontent = dbcontent + "   </tr> ";
			    	dbcontent = dbcontent + "   <tr> ";
			    	dbcontent = dbcontent + "     <td bgcolor='#FFFFFF'><table width='100%' border='0' cellpadding='5' cellspacing='3' border='1' bordercolor='#9900CC'> ";
			    	dbcontent = dbcontent + "      <tr> ";
			    	dbcontent = dbcontent + "         <td class='boldEleven'><div align='center'><b>S.No</b></div></td> ";
			    	dbcontent = dbcontent + "         <td class='boldEleven'><div align='center'><b>NAME</b></div></td> ";
			    	dbcontent = dbcontent + "         <td class='boldEleven'><div align='center'><b>OFFICE</b></div></td> ";
			    	//dbcontent = dbcontent + "        <td class='boldEleven'><div align='center'><b>DEPARTMENT</b></div></td> ";
			    	dbcontent = dbcontent + "        <td class='boldEleven'><div align='center'><b>DESIGNATION</b></div></td> ";
			    	dbcontent = dbcontent + "         <td class='boldEleven'><div align='center'><b>DATE OF JOINING</b></div></td> ";
			    	dbcontent = dbcontent + "        <td class='boldEleven'><div align='center'><b>EXPERIENCE</b></div></td> ";
			    	dbcontent = dbcontent + "        <td class='boldEleven'><div align='center'><b>MOBILE</b></div></td> ";
			    	dbcontent = dbcontent + "         <td class='boldEleven'><div align='center'><b>EMAIL</b></div></td> ";
			    	dbcontent = dbcontent + "     </tr> ";
			    	      
			    	      
			    	for(int u=0;u<data.length;u++)
			    	{
			    		dbcontent = dbcontent + "<tr> ";
			    		dbcontent = dbcontent + " <td class='boldEleven'>"+(u+1)+".</td> ";
			    		dbcontent = dbcontent + " <td class='boldEleven'>"+data[u][0]+"</td> ";
			    		dbcontent = dbcontent + " <td class='boldEleven'>"+data[u][1]+"</td> ";
			    		//dbcontent = dbcontent + " <td class='boldEleven'>"+data[u][2]+"</td> ";
			    		dbcontent = dbcontent + " <td class='boldEleven'>"+data[u][3]+"</td> ";
			    		dbcontent = dbcontent + " <td class='boldEleven'>"+data[u][4]+"</td> ";
			    		if( Integer.parseInt(data[u][7])>1 )
			    			dbcontent = dbcontent + " <td class='boldEleven'>"+data[u][7]+"</td> ";
			    		else
			    			dbcontent = dbcontent + " <td class='boldEleven'>"+data[u][7]+" -Years</td> ";
			    		dbcontent = dbcontent + " <td class='boldEleven'>"+data[u][5]+"</td> ";
			    		dbcontent = dbcontent + " <td class='boldEleven'>"+data[u][6]+"</td> ";
			    		dbcontent = dbcontent + "</tr> ";
			    	}
			    	dbcontent = dbcontent + "    </table></td> ";
		    	    dbcontent = dbcontent + " </tr> ";
		    	    dbcontent = dbcontent + " </table> ";
		    	     
		    	    
		    	    //dbcontent = dbcontent + "<br><center><h3> On Successful  completion of "+data[0][7]+" years …..with Us</h3></center> ";
		    	    dbcontent = dbcontent + "<br><center><h2>We look forward to more of your valuable contributions and wish you all the very best for a rewarding career with</h2></center> ";

		    	    dbcontent = dbcontent + "<br><br>";
			    	dbcontent = dbcontent + "<center><img src='logo.jpg' ></center> ";
			    	dbcontent = dbcontent + "<br><br>";
			    	
			    	dbcontent = dbcontent + "<br><br>";
			    	dbcontent = dbcontent + "<center><img src='20yrs.jpg' ></center> ";
			    	dbcontent = dbcontent + "<br><br>";
			    	
		    	    dbcontent = dbcontent + "<br><center>Thanking you,</center> ";
		    	    dbcontent = dbcontent + "<br><center>With Warm Regards,</center> ";
		    	    
		    	    dbcontent = dbcontent + "<br><br>";
			    	dbcontent = dbcontent + "<center><img src='bottom.jpg' ></center> ";
			    	dbcontent = dbcontent + "<br><br>";
			    	dbcontent = dbcontent + "<center><h1>HR DEPARTMENT </h1> </center>";
			    	
			    	String a[] =(CommonData.mailid+","+CommonFunctions.QueryExecute("SELECT CHR_GROUPMAIL FROM m_institution WHERE INT_ID=1")[0][0]+",").split(",") ;
				    Mail.sendEmailWithAttachments(a, "@@@@ ANNIVERSARY CELEBRATIONS @@@@ ", dbcontent,attachments);
					System.out.println("Mail has been sent");
			    }
			    con.close();   
				
				response.sendRedirect("Smart Common/commonmain.jsp");
			}
			 
		} catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

}

 <%@ page import="java.io.*,java.util.*" isErrorPage="false" 	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<%
try
{
%>

<html>
 

<title> :: TRAINNING ::</title>

<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

 

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 <body  onpaste="return false;" onLoad="javascript:window.print()" >
 
<table width="820" height="620" border="0" cellpadding="1" cellspacing="1" background="../images/certification.jpg">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
  </tr>
	<tr>
		<td>&nbsp;</td>
	</tr>

	<tr>
	  <td><div align="center">
	    <%
 
String sql="";
String applicantid = request.getParameter("applicantid");
String testid = request.getParameter("testid");
boolean f = false;
sql = " SELECT b.CHR_TESTNAME,a.CHR_QUESTION,a.CHR_ANSWER1,a.CHR_ANSWER2,a.CHR_ANSWER3,a.CHR_ANSWER4,a.CHR_ACTUAL_ANSWER,a.CHR_ATTEND_ANSWER,a.CHR_RESULT,  ";
sql = sql +" DATE_FORMAT(a.DAT_ATTENDDATE,'%d-%m-%Y') FROM internal_training_t_testquestion a,internal_training_m_testtype b WHERE a.INT_TESTTYPEID = b.INT_TESTTYPEID  AND MONTH(a.DAT_ATTENDDATE) = MONTH(now())  ";
sql = sql +" AND YEAR(a.DAT_ATTENDDATE) = YEAR(now())  ";
sql = sql +" AND  a.CHR_EMPID='"+applicantid+"' AND a.INT_TESTTYPEID ="+testid;
sql = sql +" ORDER BY a.INT_TRANSACTIONID  ";
String TestData[][] = CommonFunctions.QueryExecute(sql);

sql ="  SELECT a.INT_TESTTYPEID,a.CHR_TESTNAME, COUNT(*),  a.INT_NO_OF_QUESTION,a.INT_DURATION,a.INT_PECENTAGE FROM  internal_training_m_testtype a,internal_training_m_testquestion b WHERE a.INT_TESTTYPEID =b.INT_TESTTYPEID AND a.INT_TESTTYPEID ="+testid+" GROUP BY  a.INT_TESTTYPEID  ORDER BY a.CHR_TESTNAME ";
String tData[][] = CommonFunctions.QueryExecute(sql);
if (tData.length > 0)
{
	out.println("<center><br>");
	out.println("<table width='400' class='boldEleven'   >");
	out.println("<tr  >");
	out.println("<td class='boldEleven' align='left'><b>STAFF NAME</b></td>");
	out.println("<td class='boldEleven' align='left'>"+ CommonFunctions.QueryExecute("SELECT CHR_STAFFNAME FROM com_m_staff WHERE CHR_EMPID='"+applicantid+"'")[0][0]+"</td>");
	out.println("<td class='boldEleven' align='left'><b>STAFF ID </b></td>");
	out.println("<td class='boldEleven' align='left'>"+applicantid+"</td>");
	out.println("<td class='boldEleven' align='left'><b>TEST NAME</b></td>");
	out.println("<td class='boldEleven' align='left'>"+tData[0][1]+"</td>");
	out.println("</tr>");
	out.println("</table><br>");
	out.println("<center>");

}


			//out.println("<center>");
			//out.println("<table width='60%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1   background='../images/payslip.jpg'>");//bgcolor='#9900CC' 
			//out.println("<tr >");
			//out.println("<td  class='boldEleven'colspan='10' align='center'> ");
			
			
			String totalresult="";
			List<String> list = new ArrayList<String>();
			//out.println("<tr  >");
			//out.println("<td  class='boldEleven' colspan='10' align='right'>  ");
			 sql = " select a.INT_TESTTYPEID,b.CHR_TESTNAME,count(*),INT_PECENTAGE  from internal_training_t_testquestion a, internal_training_m_testtype b where a.INT_TESTTYPEID=b.INT_TESTTYPEID  AND  a.INT_TESTTYPEID = "+testid+" AND   a.CHR_EMPID='"+applicantid+"' group by a.INT_TESTTYPEID ";
			
			 String NoofTest[][] = CommonFunctions.QueryExecute(sql);
			 if(NoofTest.length>0)
			 {
			 		out.println("<center><br>");
					//out.println("<tabl>");//e width='90%' class='boldEleven'    cellpadding=2 cellspacing=1  bgcolor='#99BBCC'
					//out.println("<tr  >");
					//out.println("<td  class='boldEleven'   align='center'> <b>S. No </td> ");
					//out.println("<td  class='boldEleven'   align='center'> <b>TEST </td> ");
					//out.println("<td  class='boldEleven'   align='center'> <b>No. of Question</b></td> ");
					//out.println("<td  class='boldEleven'   align='center'> <b>No. of Correct Answer</b></td> ");
					//out.println("<td  class='boldEleven'   align='center'> <b>No. of Wrong Answer</b></td> ");
					//out.println("<td  class='boldEleven'   align='center'> <b>Secured ( % )</b></td> ");
					//out.println("<td  class='boldEleven'   align='center'> <b>Minimum ( % )</b></td> ");
					//out.println("<td  class='boldEleven'   align='center'> <b>Maximum ( % )</b></td> ");
					//out.println("<td  class='boldEleven'   align='center'> <b>Result</b></td> ");
					//out.println("</tr >");
					int noofquestion=0;
					int noofcorrectanswer=0;
					int noofwronganswer=0;
					int passingpercentage=0;
					boolean result = true;
					 
					totalresult="";
					 for(int k=0;k<NoofTest.length;k++)
					{
						noofquestion=0;
						noofcorrectanswer=0;
						noofwronganswer=0;
						passingpercentage=0;
						 
						result = true;
						//if(k%2==0)
						//	out.println("<tr class='MRow1'>");
						//else
						//	out.println("<tr class='MRow3'>");	
							
						//out.println("<td  class='boldEleven'   align='left'>"+(k+1)+"</td> ");
						//out.println("<td  class='boldEleven'   align='left'>"+NoofTest[k][1]+" </td> ");
						//out.println("<td  class='boldEleven'   align='right'>"+NoofTest[k][2]+" </td> ");
						noofquestion=Integer.parseInt(NoofTest[k][2]);
						passingpercentage=Integer.parseInt(NoofTest[k][3]);
						sql = " SELECT COUNT(*) FROM internal_training_t_testquestion where CHR_EMPID='"+applicantid+"' AND INT_TESTTYPEID="+NoofTest[k][0]+" and upper(CHR_RESULT)='TRUE' group by INT_TESTTYPEID ";
						//out.println(sql);
 						String NoofcorrectTest[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						if(NoofcorrectTest.length>0)
							noofcorrectanswer=Integer.parseInt(NoofcorrectTest[0][0]);
						else
							noofcorrectanswer=0;
							
						sql = " SELECT COUNT(*) FROM internal_training_t_testquestion where CHR_EMPID='"+applicantid+"' AND INT_TESTTYPEID="+NoofTest[k][0]+" and upper(CHR_RESULT)='FALSE' group by INT_TESTTYPEID ";
 						String NoofwrongTest[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						if(NoofwrongTest.length>0)
							noofwronganswer=Integer.parseInt(NoofwrongTest[0][0]);
						else
							noofwronganswer=0;
						 
						double per =  (double)noofcorrectanswer/(double)noofquestion  ;
						//out.println("<td  class='boldEleven'   align='right'> "+noofcorrectanswer+"</td> ");
						//out.println("<td  class='boldEleven'   align='right'>"+noofwronganswer+" </td> ");
						//out.println("<td  class='boldEleven'   align='right'> "+ (per*100 )+ "% </td> ");
						//out.println("<td  class='boldEleven'   align='right'>"+passingpercentage+"%</td> ");
						//out.println("<td  class='boldEleven'   align='right'>100% </td> ");
						if((per*100 ) >= passingpercentage)
							result = true;
						else
							result = false;
						
						totalresult=totalresult+result+",";	
						list.add(""+result);
						
						//if(result)
						//	out.println("<td  class='boldEleven'   align='right'><h3><font color='blue'>PASS</font></h3> </td> ");
						//else
						//	out.println("<td  class='boldEleven'   align='right'><h3><font color='red'>FAIL</font></h3> </td> ");
						//out.println("</tr>");
					} 
					//out.println("</table>");
					//out.println("</center><br>");
					
					
 			 }
			//out.println("</td></tr>");
			//out.println("<tr  >");
			//if(list.contains("false"))
			//	out.println("<td  class='boldEleven' colspan='10' align='center'><br><h1><font color='red'>RESULT  :  FAIL...</font></h1></br></td>");
			//else
				//out.println("<td  class='boldEleven' colspan='10' align='center'><br><h1><font color='red'>RESULT  :  PASS...</font></h1></br></td>");
			
		
			//out.println("</table>");
			
			 if(list.contains("false"))
				out.println("<h1><font color='red'>FAIL...</font></h1></br>");
			else
				out.println("<h1><font color='red'> PASS...</font></h1></br>");
			
			out.println("</center>");	 	 
			  
			
%>
      </div></td>
  </tr>
	<tr>
	  <td><div align="center"></div></td>
  </tr>
</table>



 

</body>
</html>



<%
}
catch(Exception e)
{
	System.out.println(e.getMessage());
	out.println(e.getMessage());
}
%>




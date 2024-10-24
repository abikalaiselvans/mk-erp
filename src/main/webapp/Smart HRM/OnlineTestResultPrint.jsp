   <%@ page import="java.io.*,java.util.*" isErrorPage="false" 	errorPage="./error.jsp"%>

<html>
 

<title>:: HRM ::</title>

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
 
<table width="100%" border="0" cellspacing="1" cellpadding="1">
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
	  <td><%
String sql="";
String applicantid = request.getParameter("applicantid");
boolean f = false;
String ssql=" SELECT b.INT_APPID,a.INT_JOBID,a.CHR_JOBGRADE,a.CHR_JOBCODE,a.CHR_JOBTITLE, ";
ssql = ssql + " b.CHR_APPCODE,b.CHR_APPNAME, a.CHR_TESTYPEID,a.CHR_NOOFQUESTION,a.INT_TESTHOURS ";
ssql = ssql + " FROM hrm_m_jobdesign a,hrm_m_application b WHERE a.CHR_JOBGRADE = b.CHR_JOBGRADE  AND a.INT_JOBID = b.INT_JOBID ";
ssql = ssql + " AND b.INT_APPID= "+applicantid;
String AppDatails[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(ssql);


sql = " SELECT b.CHR_TESTNAME,a.CHR_QUESTION,a.CHR_ANSWER1,a.CHR_ANSWER2,a.CHR_ANSWER3,a.CHR_ANSWER4,a.CHR_ACTUAL_ANSWER,a.CHR_ATTEND_ANSWER,a.CHR_RESULT,  ";
sql = sql +" DATE_FORMAT(a.DAT_ATTENDDATE,'%d-%m-%Y') FROM hrm_t_testquestion a,hrm_m_testtype b WHERE a.INT_TESTTYPEID = b.INT_TESTTYPEID  AND MONTH(a.DAT_ATTENDDATE) = MONTH(now())  ";
sql = sql +" AND YEAR(a.DAT_ATTENDDATE) = YEAR(now())  ";
sql = sql +" AND  a.INT_APPID="+applicantid;
sql = sql +" ORDER BY a.INT_TRANSACTIONID  ";
String TestData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);


			out.println("<center>");
			out.println("<table width='60%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1  bgcolor='#9900CC' border='0'>");//bgcolor='#9900CC' 
			out.println("<tr class='MRow1'>");
			out.println("<td  class='boldEleven' colspan='10' align='center'><h1><font  color='red'><img src='../images/logo.jpg'>   ONLINE TEST  </font></h1></td>");
			out.println("</tr>");
			
			out.println("<tr class='MRow1'>");
			out.println("<td  class='boldEleven' colspan='10' align='center'> ");
			if (AppDatails.length > 0)
			{
				out.println("<center><br>");
				out.println("<table width='60%'   class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
				 
				 
				out.println("<tr class='MRow1'>");
				out.println("<td class='boldEleven' align='left'><b>JOB TITLE </b></td>");
				out.println("<td class='boldEleven' align='left'>"+AppDatails[0][4]+"</td>");
				out.println("</tr>");
				
				
				out.println("<tr class='MRow1'>");
				out.println("<td class='boldEleven' align='left'><b>APPLICANT CODE </b></td>");
				out.println("<td class='boldEleven' align='left'>"+AppDatails[0][5]+"</td>");
				out.println("</tr>");
				
				out.println("<tr class='MRow1'>");
				out.println("<td class='boldEleven' align='left'><b>APPLICANT NAME </b></td>");
				out.println("<td class='boldEleven' align='left'>"+AppDatails[0][6] +"</td>");
				out.println("</tr>");
				
				out.println("<tr class='MRow1'>");
				out.println("<td class='boldEleven' align='left'><b>DATE </b></td>");
				out.println("<td class='boldEleven' align='left'>"+TestData[0][9]+"</td>");
				out.println("</tr>");
				
				out.println("<tr class='MRow1'>");
				out.println("<td class='boldEleven' align='left'><h4><font color='red'>DURATION </font></h4></td>");
				out.println("<td class='boldEleven' align='left'><h4><font color='red'>"+AppDatails[0][9]+" - MINUTES </font></h4></td>");
				out.println("</tr>");
				out.println("</table><br>");
				out.println("<center>");
 			}
			out.println("</td></tr>");
			
			
			/*
			out.println("<tr class='MRow1'>");
			out.println("<td  class='boldEleven' align='center'> <b>S.NO</b></td>");
			out.println("<td  class='boldEleven' colspan='8' align='center'>  <b>QUESTION</b></td>");
			out.println("<td  class='boldEleven' align='center'>  <b>RESULT</b></td>");
			out.println("</tr>");
			
			
			
			if(TestData.length>0)
			{
					for(int i=0;i<TestData.length;i++)
					{
						if(i%2==0)
							out.println("<tr  class='MRow3' >");
						else
							out.println("<tr   class='MRow4'>");	
						
						
						out.println("<td   width='5%'   class='boldEleven' valign='top'> "+(i+1)+".</td>");
						out.println("<td  width='90%'   class='boldEleven' colspan='8' valign='top'><b>"+TestData[i][1].toUpperCase()+" </b></td>");
						out.println("<td   width='5%'   class='boldEleven' valign='top'>&nbsp;</td>");
						out.println("</tr>");
						
						if(i%2==0)
							out.println("<tr class='MRow1'>");
						else
							out.println("<tr class='MRow1'>");	
						
						out.println("<td    width='5%'  class='boldEleven' align='center'>&nbsp;</td>");
						 
						out.println("<td   width='90%'  class='boldEleven' align='left' height='30'  colspan='8'>");
							out.println("<table width='98%' class='boldEleven'  id='myTable' border='0'    cellpadding=2 cellspacing=1  >");//bgcolor='#99BBCC'
							out.println("<tr >");
							
							String attendanswer[]=TestData[i][7] .split(",");
							//ANSWER-1
							f = false;
							for(int u=0; u<attendanswer.length;u++)
								if(attendanswer[u].equals("1") )
									f= true;
							if(f)
								out.println("<td  class='boldEleven'>1).&nbsp; <img src='../Image/report/tick.gif' width='16' height='16'>&nbsp; "+TestData[i][2].toUpperCase()+"</td>");
							else
								out.println("<td  class='boldEleven'>1).&nbsp;   "+TestData[i][2].toUpperCase()+"</td>");	
								
							//ANSWER-2	
							f = false;
							for(int u=0; u<attendanswer.length;u++)
								if(attendanswer[u].equals("2") )
									f= true;
							if(f)
								out.println("<td  class='boldEleven'>2).&nbsp; <img src='../Image/report/tick.gif' width='16' height='16'>&nbsp; "+TestData[i][3].toUpperCase()+"</td>");
							else
								out.println("<td  class='boldEleven'>2).&nbsp;  "+TestData[i][3].toUpperCase()+"</td>");	
								
									
							//ANSWER-3	
							f = false;
							for(int u=0; u<attendanswer.length;u++)
								if(attendanswer[u].equals("3") )
									f= true;
							if(f)
								out.println("<td  class='boldEleven'>3).&nbsp; <img src='../Image/report/tick.gif' width='16' height='16'>&nbsp; "+TestData[i][4].toUpperCase()+"</td>");
							else
								out.println("<td  class='boldEleven'>3).&nbsp; "+TestData[i][4].toUpperCase()+"</td>");	
								
								
							//ANSWER-4	
							f = false;
							for(int u=0; u<attendanswer.length;u++)
								if(attendanswer[u].equals("4") )
									f= true;
							if(f)
								out.println("<td  class='boldEleven'>4).&nbsp; <img src='../Image/report/tick.gif' width='16' height='16'>&nbsp; "+TestData[i][5].toUpperCase()+"</td>");
							else
								out.println("<td  class='boldEleven'>4).&nbsp; "+TestData[i][5].toUpperCase()+"</td>");	
							
							out.println("</tr>");
							out.println("</table>");
							out.println("</td>");
							if("TRUE".equals(TestData[i][8].toUpperCase()))
								out.println("<td   width='5%'    class='boldEleven' ><img src='../Image/report/correct.jpeg' width='25' height='25'>CORRECT</td>");
							else
								out.println("<td   width='5%'     class='boldEleven' ><img src='../Image/report/delete.jpeg' width='25' height='25'>WRONG</td>");
							out.println("</tr>");
							
							out.println("<tr  class='MRow3' ><td  class='boldEleven' colspan='10'>&nbsp;</td>");
							out.println("</tr>");
						
							
					}
			}
*/


			String totalresult="";
			List<String> list = new ArrayList<String>();
			out.println("<tr class='MRow1'>");
			out.println("<td  class='boldEleven' colspan='10' align='right'>  ");
			 sql = " select a.INT_TESTTYPEID,b.CHR_TESTNAME,count(*),INT_PASSPERCENTAGE  from hrm_t_testquestion a, hrm_m_testtype b where a.INT_TESTTYPEID=b.INT_TESTTYPEID   AND   INT_APPID="+applicantid+" group by INT_TESTTYPEID ";
			 String NoofTest[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			 if(NoofTest.length>0)
			 {
			 		out.println("<center><br>");
					out.println("<table width='100%' class='boldEleven'    cellpadding=2 cellspacing=1  bgcolor='#99BBCC'>");//
					out.println("<tr  >");
					out.println("<td  class='boldEleven'   align='center'> <b>S. No </td> ");
					out.println("<td  class='boldEleven'   align='center'> <b>Test Type</td> ");
					out.println("<td  class='boldEleven'   align='center'> <b>No. of<br> Question</b></td> ");
					out.println("<td  class='boldEleven'   align='center'> <b>No. of<br> Correct Answer</b></td> ");
					out.println("<td  class='boldEleven'   align='center'> <b>No. of <br>Wrong Answer</b></td> ");
					out.println("<td  class='boldEleven'   align='center'> <b>Secured<br> ( % )</b></td> ");
					out.println("<td  class='boldEleven'   align='center'> <b>Minimum<br> ( % )</b></td> ");
					out.println("<td  class='boldEleven'   align='center'> <b>Maximum<br> ( % )</b></td> ");
					out.println("<td  class='boldEleven'   align='center'> <b>Result</b></td> ");
					out.println("</tr >");
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
						if(k%2==0)
							out.println("<tr class='MRow1'>");
						else
							out.println("<tr class='MRow3'>");	
							
						out.println("<td  class='boldEleven'   align='left'>"+(k+1)+"</td> ");
						out.println("<td  class='boldEleven'   align='left'>"+NoofTest[k][1]+" </td> ");
						out.println("<td  class='boldEleven'   align='right'>"+NoofTest[k][2]+" </td> ");
						noofquestion=Integer.parseInt(NoofTest[k][2]);
						passingpercentage=Integer.parseInt(NoofTest[k][3]);
						sql = " SELECT COUNT(*) FROM hrm_t_testquestion where INT_APPID="+applicantid+" AND INT_TESTTYPEID="+NoofTest[k][0]+" and upper(CHR_RESULT)='TRUE' group by INT_TESTTYPEID ";
 						String NoofcorrectTest[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						if(NoofcorrectTest.length>0)
							noofcorrectanswer=Integer.parseInt(NoofcorrectTest[0][0]);
						else
							noofcorrectanswer=0;
							
						sql = " SELECT COUNT(*) FROM hrm_t_testquestion where INT_APPID="+applicantid+" AND INT_TESTTYPEID="+NoofTest[k][0]+" and upper(CHR_RESULT)='FALSE' group by INT_TESTTYPEID ";
 						String NoofwrongTest[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						if(NoofwrongTest.length>0)
							noofwronganswer=Integer.parseInt(NoofwrongTest[0][0]);
						else
							noofwronganswer=0;
						 
						double per =  (double)noofcorrectanswer/(double)noofquestion  ;
						out.println("<td  class='boldEleven'   align='right'> "+noofcorrectanswer+"</td> ");
						out.println("<td  class='boldEleven'   align='right'>"+noofwronganswer+" </td> ");
						out.println("<td  class='boldEleven'   align='right'> "+ (per*100 )+ "% </td> ");
						out.println("<td  class='boldEleven'   align='right'>"+passingpercentage+"%</td> ");
						out.println("<td  class='boldEleven'   align='right'>100% </td> ");
						if((per*100 ) >= passingpercentage)
							result = true;
						else
							result = false;
						
						totalresult=totalresult+result+",";	
						list.add(""+result);
						
						if(result)
							out.println("<td  class='boldEleven'   align='right'><h3><font color='blue'>PASS</font></h3> </td> ");
						else
							out.println("<td  class='boldEleven'   align='right'><h3><font color='red'>FAIL</font></h3> </td> ");
						out.println("</tr>");
					} 
					out.println("</table>");
					out.println("</center><br>");
					
					
 			 }
			out.println("</td></tr>");
			
			
			
			
			out.println("<tr class='MRow1'>");
			if(list.contains("false"))
				out.println("<td  class='boldEleven' colspan='10' align='center'><br><h1><font color='red'>RESULT  :  FAIL...</font></h1></br></td>");
			else
				out.println("<td  class='boldEleven' colspan='10' align='center'><br><h1><font color='red'>RESULT  :  PASS...</font></h1></br></td>");
			out.println("</tr>");
			
			
 
			
			out.println("</table>");
			out.println("</center>");
			
%></td>
  </tr>
	<tr>
	  <td>&nbsp; </td>
  </tr>
	<tr>
		<td><div align="center"><a href="javascript:window.print()">Print</a> </div></td>
	</tr>
</table>



 

</body>
</html>




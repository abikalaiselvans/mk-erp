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

<style type="text/css">
<!--
.style8 {
	font-family: Verdana;
	font-size: 12px;
}
.style9 {color: #FFFFFF}
.style10 {font-family: Verdana; font-size: 12px; color: #FFFFFF; }
a:visited {
	color: #663366;
}
a:hover {
	color: #FF0000;
}
a:active {
	color: #0000FF;
}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>


<%
String sql="";
String applicantid = request.getParameter("applicantid");

 
if(com.my.org.erp.common.CommonFunction.RecordExist( " SELECT  COUNT(*)  FROM hrm_t_testquestion WHERE INT_APPID="+applicantid))
 	response.sendRedirect("error.jsp?error=Already online test conducted for this person...");
					 	
							
String testids = request.getParameter("testids");
String attenquestion = request.getParameter("attenquestion");
String timeduration = request.getParameter("timeduration");
String nooftesttype = request.getParameter("nooftesttype");
String percentage = request.getParameter("percentage");
String q = request.getParameter("question");
 
String pass[] = percentage.split(",");
String question = "";
int count = Integer.parseInt(nooftesttype);
String questionid[] = q.split(",");


String ssql=" SELECT b.INT_APPID,a.INT_JOBID,a.CHR_JOBGRADE,a.CHR_JOBCODE,a.CHR_JOBTITLE, ";
ssql = ssql + " b.CHR_APPCODE,b.CHR_APPNAME, a.CHR_TESTYPEID,a.CHR_NOOFQUESTION,a.INT_TESTHOURS ";
ssql = ssql + " FROM hrm_m_jobdesign a,hrm_m_application b WHERE a.CHR_JOBGRADE = b.CHR_JOBGRADE  AND a.INT_JOBID = b.INT_JOBID ";
ssql = ssql + " AND b.INT_APPID= "+applicantid;
String AppDatails[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(ssql);

ssql =" SELECT COUNT(*) FROM hrm_t_testquestion WHERE MONTH(DAT_ATTENDDATE) = MONTH(NOW()) AND YEAR(DAT_ATTENDDATE) =YEAR(NOW()) AND  INT_APPID="+applicantid;
String RowCount[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(ssql);

boolean f = com.my.org.erp.common.CommonFunction.RecordExist("SELECT COUNT(*) FROM hrm_t_testquestion WHERE INT_APPID="+applicantid);
if(f)
	response.sendRedirect("error.jsp?error=Already you applied the online test...");	
if(com.my.org.erp.common.CommonFunction.RecordExist(ssql))
	response.sendRedirect("error.jsp?error=Already you applied the online test...");				
%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 
 
<script type="text/javascript">
var hh=0; 
var mm=0; 
var ss=0;
var time="";
var duration = <%=timeduration%> 

function startTime()
{
	
 	 
	ss=(ss+1);
	  
	 if(ss>=60)
	{
		ss=0;
		mm =   (mm+1);
	}
	if(mm>=60)
	{
		mm=0;
		hh =   (hh+1);
	} 
	 
	
	 time = ""+checkTime(hh)+":"+checkTime(mm)+":"+checkTime(ss)
	 
	document.getElementById('showtime').innerHTML="<h2><font  color='red'>" +time+"</font></h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
	 
	/*var p=window.createPopup()
	var pbody=p.document.body
	pbody.style.backgroundColor="#DEE7FF"
	pbody.style.border="solid red 0px"
	pbody.innerHTML="<h2><font  color='red'>" +time+"</font></h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
	p.show(350,550,200,25,document.body);*/
 
	t=setTimeout('startTime()',1000);
	 
	
}

function checkTime(i)
{
	if (i<10)
  	{
  		i="0" + i;
  	}
	return i;
}

function loadNextPage() 
{
   alert("The Duration is completed. So Its auto submitted ");
   document.frm.submit(); 
}

setTimeout("loadNextPage()",(duration*60*1000));


function validate()
{
	try
	{
	
		var name=confirm("ARE YOU SUBMIT THE ONLINE TEST ")
		if (name==true)
		{ 
			document.frm.action="../SmartLoginAuth";
			return true;			
		}
		else
			return false;
	}
	catch(err)
	{
		alert(err);
		return false;
	}	 
}




</script>
<script language="javascript">
var scrlStr="PUT MESSAGE HERE"
var width=140;
var strLen=scrlStr.length;
var pos=1-width; 
function scroll() 
{   
	var scroll = "";    
	pos++; 
	if(pos == strLen) 
		pos =1 - width;   
	
	if(pos<0)   
	{       
		for(var i=1;      i<=Math.abs(pos);      i++)
			scroll=scroll+" ";      
		scroll=scroll+scrlStr.substring(0,width-i+1); 
   }    
   else    
   	scroll=scroll+scrlStr.substring(pos,pos+width);    
	window.status=scroll; 
	setTimeout("scroll()",1000); 
}
</script>
</head>



<!--frmMainonLoad="startTime()"-->
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<form  AUTOCOMPLETE = "off"   method="post" name='frm' action="../SmartLoginAuth" onSubmit="return validate()">
<body  onpaste="return false;" onLoad="startTime(),scroll()" >
<%@ include file="indexhrm.jsp"%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
	  <td align="right">
	  <div id="showtime" style="width:90%"></div></td>
  </tr>
	<tr>
		<td><%
			 
				
					
			sql = " SELECT INT_TESTTYPEID,CHR_TESTNAME FROM  hrm_m_testtype WHERE INT_TESTTYPEID IN("+testids+") ORDER BY CHR_TESTNAME ";
			String testTypeData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			
		
			
			out.println("<center>");
			out.println("<table width='90%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1  bgcolor='#9900CC' border='0'>");//bgcolor='#9900CC' 
			out.println("<tr class='MRow1'>");
			out.println("<td  class='boldEleven'colspan='10' align='center'><h1><font  color='red'>ONLINE TEST  </font></h1></td>");
			out.println("</tr>");
			
			out.println("<tr class='MRow1'>");
			out.println("<td  class='boldEleven'colspan='10' align='center'> ");
			if (AppDatails.length > 0)
			{
				out.println("<center><br>");
				out.println("<table width='50%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
				 
				 
				out.println("<tr class='MRow1'>");
				out.println("<td class='boldEleven' align='left'><b>JOB TITLE </b></td>");
				out.println("<td class='boldEleven' align='left'>"+AppDatails[0][4]+"</td>");
				out.println("<td class='boldEleven' align='left'><b>APPLICANT NAME </b></td>");
				out.println("<td class='boldEleven' align='left'>"+AppDatails[0][6]+"</td>");
				out.println("<td class='boldEleven' align='left'><h4><font color='red'>DURATION </font></h4></td>");
				out.println("<td class='boldEleven' align='left'><h4><font color='red'>"+AppDatails[0][9]+" - MINUTES </font></h4></td>");
				out.println("</tr>");
				out.println("</table><br>");
				out.println("<center>");
 			}
			out.println("</td></tr>");
			
			
			
			 
			if (testTypeData.length > 0)
			{
				for(int k=0;k<testTypeData.length;k++)
     	 		{
					 sql = " SELECT a.INT_EQUESTIONID,b.CHR_TESTNAME,a.CHR_QUESTION,a.CHR_ANSWER1,a.CHR_ANSWER2,a.CHR_ANSWER3,a.CHR_ANSWER4,a.CHR_ACTUAL_ANSWER  ";
					sql = sql + " FROM  hrm_m_testquestion  a,hrm_m_testtype b WHERE a.INT_TESTTYPEID= b.INT_TESTTYPEID ";
					sql = sql + " AND a.INT_TESTTYPEID="+testTypeData[k][0];
					sql = sql + " ORDER BY a.INT_EQUESTIONID  ";
					String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					Collections.shuffle(Arrays.asList(Data));
					
					 
					if (Data.length > 0)
					{
						/*out.println("<tr class='MRow1'>");
			 			out.println("<td  class='boldEleven'colspan='10' align='center'><h3><font  color='red'>"+testTypeData[k][1].toUpperCase()+"QUESTION - [ No of Question "+Data.length+" ] [  PASSING PERCENTAGE - "+pass[k]+" %]   </font></h3></td>");
						out.println("</tr>");
						*/
						
						int gk=0;
						for(int i=0;i<Data.length;i++)
						{
							
							gk=Integer.parseInt(questionid[k]); 	
							if(i>=gk)	
								break;
							if(i%2==0)
								out.println("<tr  class='MRow3' >");
							else
								out.println("<tr   class='MRow4'>");	
							
							
							out.println("<td  class='boldEleven' valign='top'> "+(i+1)+".</td>");
							out.println("<td  class='boldEleven' colspan='6' valign='top'><b>"+Data[i][2].toUpperCase()+"</b><input name='rowid' id='rowid'  type='hidden' value='"+Data[i][0]+"'><input name='passpercent' id='passpercent'  type='hidden' value='"+pass[k]+"'></td>");
							out.println("</tr>");
							
							
							if(i%2==0)
								out.println("<tr class='MRow1'>");
							else
								out.println("<tr class='MRow1'>");	
							
							out.println("<td  class='boldEleven' align='center'>&nbsp;</td>");
							 
							out.println("<td  class='boldEleven' align='left' height='30'  colspan='6'>");
								out.println("<table width='100%' class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1  >");//bgcolor='#99BBCC'
								out.println("<tr >");
								out.println("<td  class='boldEleven'>A).&nbsp;&nbsp;<input name='Ans_"+Data[i][0]+"'  id='Ans_"+Data[i][0]+"' type='radio'   value='1'> "+Data[i][3].toUpperCase()+"</td>");
								out.println("<td  class='boldEleven'>B).&nbsp;&nbsp;<input name='Ans_"+Data[i][0]+"'  id='Ans_"+Data[i][0]+"'  type='radio'   value='2'> "+Data[i][4].toUpperCase()+"</td>");
								out.println("<td  class='boldEleven'>C).&nbsp;&nbsp;<input name='Ans_"+Data[i][0]+"'  id='Ans_"+Data[i][0]+"'  type='radio'   value='3'> "+Data[i][5].toUpperCase()+"</td>");
								out.println("<td  class='boldEleven'>D).&nbsp;&nbsp;<input name='Ans_"+Data[i][0]+"'  id='Ans_"+Data[i][0]+"' type='radio'   value='4'> "+Data[i][6].toUpperCase()+"</td>");
								out.println("</tr>");
								
								 
				
								out.println("</table>");
							out.println("</td>");
							out.println("</tr>");
							out.println("<tr class='MRow1' height='10'> <td  class='boldEleven'colspan='10' > &nbsp;</td> </tr>");
							out.println("<tr class='MRow1' height='10'> <td  class='boldEleven'colspan='10' > &nbsp;</td> </tr>");
							 
							out.println("</tr>");
						}
					} 
					
				}
			}
				
			out.println("</table>");
			out.println("</center>");
	%>		</td>
	</tr>

	<tr>
		<td>
		<table width="317" align="center">
			<tr>
				<td width="120"><div align="center"><input  class="tMLAscreenHead" type="submit" name="action1" value="Submit Test">
				</div>				</td>
				 
 
				<td width="56">
				<div align="center"><input  class="tMLAscreenHead" type="button"
					name="Button" value="Close " onClick="redirect('HRMmain.jsp')"></div>				</td>
			    <td width="69"  ><input name="filename" type="hidden" id="filename" value="OnlineTest">
                  <input name="actionS" type="hidden" id="actionS" value="HRMOnlineTestApply">		        <input name="applicantid" type="hidden" id="applicantid" value="<%=applicantid%>"></td>
			</tr>
		</table>		</td>
	</tr>
</table>



<%@ include file="../footer.jsp"%>

</body>
</html>




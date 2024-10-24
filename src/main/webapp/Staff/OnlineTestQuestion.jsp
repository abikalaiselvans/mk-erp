<%@ page import="java.io.*,java.util.*" isErrorPage="false" 	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<%
try
{

response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setDateHeader("Expires", 0); // Proxies.

%>

<%@include file="Redirect.jsp" %>


<html>
 

<title>:: STAFF ::</title>

 
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

 

<%
String sql="";


String test = request.getParameter("test");
sql ="  SELECT a.INT_TESTTYPEID,a.CHR_TESTNAME, COUNT(*),  a.INT_NO_OF_QUESTION,a.INT_DURATION,a.INT_PECENTAGE FROM  internal_training_m_testtype a,internal_training_m_testquestion b WHERE a.INT_TESTTYPEID =b.INT_TESTTYPEID AND a.INT_TESTTYPEID ="+test+" GROUP BY  a.INT_TESTTYPEID  ORDER BY a.CHR_TESTNAME ";
//out.println(sql);
String tData[][] = CommonFunctions.QueryExecute(sql);
String testids = test ; 
String attenquestion =tData[0][3]    ;
String timeduration = tData[0][4] ;  
String percentage = tData[0][5] ;

String pass[] = percentage.split(",");
session.setMaxInactiveInterval(7200); 

sql = " SELECT COUNT(*) FROM internal_training_t_testemployeelist ";
sql = sql + " WHERE INT_TESTTYPEID = "+test;
sql = sql + " AND CHR_EMPID ='"+session.getAttribute("EMPID")+"'";
sql = sql + " AND CHR_RESULT ='P' ";
if("1".equals(CommonFunctions.QueryExecute(sql)[0][0]))
	response.sendRedirect("error.jsp?error=Already passed the Test "+tData[0][1]+"...");;

/*int totalnoofquestion = Integer.parseInt(tData[0][2]) ;
String squestion[] = new String[totalnoofquestion];
for(int i=0;i<totalnoofquestion;i++)	 	
	squestion[i] = ""+i;
Collections.shuffle(Arrays.asList(squestion));	
String squestionids="";
for(int i=0;i<Integer.parseInt(attenquestion);i++)	
	squestionids = squestionids+squestion[i]+",";
	*/			
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
   alert("Server Goes to auto Submit");
   document.frm.submit(); 
}

setTimeout("loadNextPage()",(duration*60*1000));

function validate()
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
			 
				
					
			sql = " SELECT INT_TESTTYPEID,CHR_TESTNAME FROM  internal_training_m_testtype WHERE INT_TESTTYPEID IN("+testids+",0) ORDER BY CHR_TESTNAME ";
			String testTypeData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			
		
			
			out.println("<center>");
			out.println("<table width='90%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1  bgcolor='#9900CC' border='0'>");//bgcolor='#9900CC' 
			out.println("<tr class='MRow1'>");
			out.println("<td class='boldEleven'colspan='10' align='center'><h1><font  color='red'>ONLINE TEST <BR>  </font></h1></td>");
			out.println("</tr>");
			 
			
			out.println("<tr class='MRow1'>");
			out.println("<td  class='boldEleven'colspan='10' align='center'> ");
			if (tData.length > 0)
			{
				out.println("<center><br>");
				out.println("<table width='80%' class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
				out.println("<tr class='MRow1'>");
				out.println("<td class='boldEleven' align='left'><b>STAFF NAME</b></td>");
				out.println("<td class='boldEleven' align='left'>"+ CommonFunctions.QueryExecute("SELECT CHR_STAFFNAME FROM com_m_staff WHERE CHR_EMPID='"+session.getAttribute("EMPID")+"'")[0][0]+"</td>");
				out.println("<td class='boldEleven' align='left'><b>STAFF ID </b></td>");
				out.println("<td class='boldEleven' align='left'>"+session.getAttribute("EMPID")+"</td>");
				out.println("<td class='boldEleven' align='left'><h4><font color='red'>&nbsp;</font></h4></td>");
				out.println("<td class='boldEleven' align='left'><h4><font color='red'>&nbsp;</font></h4></td>");
				out.println("</tr>");
				out.println("<tr class='MRow1'>");
				out.println("<td class='boldEleven' align='left'><b>TEST NAME</b></td>");
				out.println("<td class='boldEleven' align='left'>"+tData[0][1]+"</td>");
				out.println("<td class='boldEleven' align='left'><b>NO OF QUESTION </b></td>");
				out.println("<td class='boldEleven' align='left'>"+tData[0][3]+"</td>");
				out.println("<td class='boldEleven' align='left'><h4><font color='red'>DURATION </font></h4></td>");
				out.println("<td class='boldEleven' align='left'><h4><font color='red'>"+tData[0][4]+"-MINUTES</font></h4></td>");
				out.println("</tr>");
				
				out.println("</table><br>");
				out.println("<center>");
 			}
			out.println("</td></tr>");
			
			
			
			
			
			
			
			 
			if (testTypeData.length > 0)
			{
				for(int k=0;k<testTypeData.length;k++)
     	 		{
					 sql = " SELECT a.INT_ROWID,b.CHR_TESTNAME,a.CHR_QUESTION,a.CHR_ANSWER1,a.CHR_ANSWER2,a.CHR_ANSWER3,a.CHR_ANSWER4,a.CHR_ACTUAL_ANSWER  ";
					sql = sql + " FROM  internal_training_m_testquestion  a,internal_training_m_testtype b WHERE a.INT_TESTTYPEID= b.INT_TESTTYPEID ";
					sql = sql + " AND a.INT_TESTTYPEID="+testTypeData[k][0];
					sql = sql + " ORDER BY a.INT_ROWID  LIMIT 0,"+attenquestion;
					String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					
					Collections.shuffle(Arrays.asList(Data));
					Collections.shuffle(Arrays.asList(Data));
					 
					if (Data.length > 0)
					{
						 
						
						
						for(int i=0;i<Data.length;i++)
						{
							
						
							if(i%2==0)
								out.println("<tr  class='MRow1' >");
							else
								out.println("<tr   class='MRow1'>");	
							
							
							out.println("<td  class='boldEleven' valign='top'> "+(i+1)+".</td>");
							out.println("<td  class='paramenu' colspan='6' valign='middle'  height='50' ><b>"+Data[i][2].toUpperCase()+"</b><input name='rowid' id='rowid'  type='hidden' value='"+Data[i][0]+"'><input name='passpercent' id='passpercent'  type='hidden' value='"+pass[k]+"'></td>");
							out.println("</tr>");
							
							
							if(i%2==0)
								out.println("<tr class='MRow1'>");
							else
								out.println("<tr class='MRow1'>");	
							
							out.println("<td  class='boldEleven' align='center'>&nbsp;</td>");
							 
							out.println("<td  class='boldEleven' align='left' height='50'  colspan='6'>");
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
							out.println("<tr class='MRow1' height='60'> <td  class='boldEleven'colspan='10' > &nbsp;</td> </tr>");
							  
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
				<td width="120" align="center"><input  class="tMLAscreenHead" type="submit" name="action1" value="Submit Test">
				</td>
				 
 
				<td width="56" align="center">
				
				<input  class="tMLAscreenHead" type="button" name="Button" value="Close " onClick="redirect('Userframe.jsp')">				</td>
		      <td width="69"  >
			  		<input name="filename" type="hidden" id="filename" value="OnlineTest">
                  	<input name="actionS" type="hidden" id="actionS" value="STAOnlineTestApply">		       
			  	  <input name="applicantid" type="hidden" id="applicantid" value="<%=session.getAttribute("EMPID")%>">
				  	<input name="testid" type="hidden" id="testid" value="<%=test%>"></td>
			</tr>
		</table>		</td>
	</tr>
</table>



 
</body>
</html>


<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>


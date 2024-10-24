
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="com.my.org.erp.common.CommonFunctions"%>
<html>
<head>
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


<title> :: ATTENDANCE ::</title>





<script src="../JavaScript/Tree/ua.js"></script>
<script src="../JavaScript/Tree/ftiens4.js"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 

</head>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">


<%
try
{
	String sql=" ";
	String instid=""+session.getAttribute("INSTITUTIONID");
 	sql="  select INT_COMPANYID ,CHR_COMPANYNAME  from com_m_company order by INT_COMPANYID" ;
	String  company[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);

	sql=" select INT_OFFICEID ,CHR_OFFICENAME  from  com_m_office  order by CHR_OFFICENAME";
	String  office[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);

	sql=" select INT_DEPARTID ,CHR_DEPARTNAME  from com_m_depart order by CHR_DEPARTNAME ";
	String  dept[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	
	 
%>

<script language="javascript" src="">

		
		
function getQueryString(positionindex)
		{
			var paramExpressions;
			var param
			var val
			paramExpressions = window.location.search.substr(1).split("&");
			if (positionindex < paramExpressions.length)
			{
				param = paramExpressions[positionindex]; 
				if (param.length > 0) {
					return eval(unescape(param));
				}
			}
			return ""
		} 
		
USETEXTLINKS = 1
STARTALLOPEN = 0
USEFRAMES = 0
USEICONS = 0
WRAPTEXT = 1
PRESERVESTATE = 1
foldersTree = gFld("", "")
aux0 = 	insFld(foldersTree, gFld('<b><font class=boldEleven>Company</font></b>', ""));
//aux1 = 	insFld(aux0, gFld('<%//=company[u][1]%>', ""));
	<%	sql="";
		for(int u=0;u<company.length;u++)
		{
			 %>
			 aux1 = 	insFld(aux0, gFld('<b><font class=boldEleven><%=company[u][1]%></font></b>', ""));
			 <%
			 if(office.length>1)
			 	for(int o=0;o<office.length;o++)
				{
				%>
					 aux2 = 	insFld(aux1, gFld('<b><font class=boldEleven><%=office[o][1]%></font></b>', ""));
				<%	 
					 if(dept.length>1)
						for(int p=0;p<dept.length;p++)
						{
					%>
					 	aux3 = 	insFld(aux2, gFld('<b><font class=boldEleven><%=dept[p][1]%></font></b>', ""));
					<%	 
						sql=" select CHR_EMPID ,CHR_STAFFNAME  from com_m_staff  WHERE INT_COMPANYID="+company[u][0]+" AND INT_OFFICEID="+office[o][0]+" AND INT_DEPARTID="+dept[p][0] +" AND CHR_TYPE!='T' ORDER BY CHR_STAFFNAME";
						String  staff[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						if(staff.length>0)
							for(int q=0;q<staff.length;q++)
							{
							%>
					 		aux4 = 	insFld(aux3, gFld('<b><font class=boldEleven><%=staff[q][1]%></font></b>', "StaffPersonalinfoview.jsp?empid=<%=staff[q][0]%>"));
						<%	
							}
					
						}
				}
		}
%>
	 
	 
	 
	
function Personalinfo(query)
	{  
		
		width=410;
		height=450;
  		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
	 	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		newWindow = window.open(query,"subWind",styleStr);
		newWindow.focus( );
	}
		

 
</script>





 <br><br>

<table width="101%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="21%">&nbsp;</td>
    <td width="79%">&nbsp;</td>
  </tr>
  <tr>
    <td>
	
	<TABLE border=0 width="257" height=400>
                   <TR>
                      	<TD width="251" valign="top">
						<div id="divscroll" style="OVERFLOW:auto;width:280px;height:500px">
						<FONT size=-2>
					  		<A  style="FONT-SIZE: 7pt; COLOR: silver; TEXT-DECORATION: none" 
                       		 href="http://www.treemenu.net/" target=_blank> </A></FONT>
							<SPAN   class=TreeviewSpanArea>
						  <SCRIPT>initializeDocument()</SCRIPT></SPAN>
						</div>  
			 		 </TD>
			  </TR>
</TABLE>
	</td>
    <td align="center" valign="top">
	
	<iframe src="" 	name="abikalai" width="95%" height="100%"  frameborder="0"
					style="border-width: 0px; border-color: #F48442; border-style: dotted;">
	  </iframe>
	
	</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>

 
    <%
 }
 catch(Exception e)
 {
 }
 %>  
</body>
</html>

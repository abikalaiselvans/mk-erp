<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<html>
<head>

<title>:: ACCOUNTS ::</title>

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
 <%
try
{
	String sql=" ";
	 
	sql=" SELECT INT_TYPEID ,CHR_TYPENAME FROM accc_m_type ORDER BY CHR_TYPENAME ";
	String  types[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	
	 
	

	
%>
<style type="text/css">
<!--
.style3 {font-size: 10px}
-->
</style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script src="../JavaScript/Tree/ua.js"></SCRIPT>
<script src="../JavaScript/Tree/ftiens4.js"></script>
<script language="javascript" src="">

	
		
		
	
		
function getQueryString(index)
		{
			var paramExpressions;
			var param
			var val
			paramExpressions = window.location.search.substr(1).split("&");
			if (index < paramExpressions.length)
			{
				param = paramExpressions[index]; 
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


foldersTree = gFld("<b>Account Informations</b>", "")

	 
	
	 
	 
	aux0 = 	insFld(foldersTree, gFld('Account', ""));
	<%	sql="";
		for(int u=0;u<types.length;u++)
		{
			 %>
			 aux1 = 	insFld(aux0, gFld('<%=types[u][1]%>', ""));
			 <%
		 
			sql = "SELECT INT_TYPEGROUPID ,CHR_TYPEGROUPNAME FROM accc_m_typegroups  WHERE INT_TYPEID ="+types[u][0];
			sql = sql +" ORDER BY CHR_TYPEGROUPNAME ";
			String  typegroup[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			
			%>
			
			<%
			if(typegroup.length>0)
			{
				for(int v=0;v<typegroup.length;v++)
				{
			 	
				%>
			 		aux2 = 	insFld(aux1, gFld('<%=typegroup[v][1]%>', ""));
					
					<%
		 
						 
						sql = "SELECT INT_TYPESUBGROUPID,CHR_TYPESUBGROUPNAME FROM accc_m_typesubgroups WHERE INT_TYPEGROUPID="+typegroup[v][0];
						sql = sql +" ORDER BY CHR_TYPESUBGROUPNAME ";
						
						String  floor[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						if(floor.length>0)
						{
							for(int x=0;x<floor.length;x++)
							{
							%>
			 				aux3 = 	insFld(aux2, gFld('<%=floor[x][1]%>', ""));
								
								
								<%
								
									sql = "SELECT INT_TYPESUBSIDIARYID,CHR_TYPESUBSIDIARYNAME FROM  accc_m_typesubsidiarygroup";
									sql = sql +" WHERE INT_TYPESUBGROUPID="+floor[x][0];
									sql = sql +" ORDER BY CHR_TYPESUBSIDIARYNAME ";
									String  room[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
									if(room.length>0)
									for(int y=0;y<room.length;y++)
									{
									%>
									aux4 = 	insFld(aux3, gFld('<%=room[y][1]%>', ""));
									
									<%
									}
								%>
									
							<%
		 			 	
							}
						}	
			
					%>
					
			 	<%
				}
			}	
		}
		
	%>
	 
 
</script>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >

<%@ include file="indexacct.jsp"%>
<p><br>
  <br>
</p>
 
<table width="101%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="21%">&nbsp;</td>
    <td width="79%">&nbsp;</td>
  </tr>
  <tr>
    <td><TABLE border=0 width="257" height=400>
      <TR>
        <TD width="251" valign="top"><div id="divscroll" style="OVERFLOW:auto;width:280px;height:390px"> <FONT size=-2> <A  style="FONT-SIZE: 7pt; COLOR: silver; TEXT-DECORATION: none" 
                       		 href="http://www.treemenu.net/" target=_blank> </A></FONT> <SPAN   class=TreeviewSpanArea>
          <SCRIPT>initializeDocument()</SCRIPT>
        </SPAN> </div></TD>
      </TR>
    </TABLE></td>
    <td><iframe src="" 	name="abikalai" width="95%" height="100%" frameborder="0"
					style="border-width: 0px; border-color: #F48442; border-style: dotted;"> </iframe></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
<p>&nbsp; </p>

<%
 }
 catch(Exception e)
 {
 }
 %>  
<%@ include file="../footer.jsp"%>

</body>
</html>

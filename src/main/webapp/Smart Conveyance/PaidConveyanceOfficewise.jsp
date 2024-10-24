<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
<%
try
{
%>
 
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


<title> :: CONVEYANCE ::</title>

 
   
  <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
  
 
  
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>

 

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<br>
<br>
<%
try
{

%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="PayConveyancess.jsp"	onSubmit="return validate()">
 
			<center>
			<p>&nbsp;</p>
			<table width="600" border="0"
			align="center" cellpadding="0"   cellspacing="0" class="BackGround">
              <tbody>
                <tr>
                  <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
                  <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
                  <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
                </tr>
                <tr>
                  <td height="6"><spacer height="1" width="1" type="block" /></td>
                </tr>
                <tr>
                  <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
                  <td width="7"><spacer height="1" width="1" type="block" /></td>
                  <td width="575"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                      <td colspan="2" class="boldEleven"><div align="center"><span
								class="boldThirteen">PAY CONVEYANCE OFFICE WISE</span> </div></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven">&nbsp;</td>
                    </tr>
                    <tr>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven">&nbsp;</td>
                    </tr>
                    
                    <tr>
                      <td colspan="2" class="boldEleven">
					  
					  
					  
					  
					  
					  
					    <div align="center">
					      <%
String oficeid=""+session.getAttribute("OFFICEID");
String usertype=""+session.getAttribute("USRTYPE");
String userid=""+session.getAttribute("USRID");
String OfficeData[][] =  CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b WHERE b.INT_OFFICEID IN("+ CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a WHERE a.CHR_USRNAME='"+userid+"' ")[0][0]+" )");

out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
out.println("<tr class='MRow1'> <td colspan='4'class='boldEleven'><center><h3>SELECT OFFICE<input type='checkbox' id='all' name='all' onClick='assign()'> Check All</h3></center></td></tr>" );
out.println("<tr class='MRow2'>");
int i=0;
boolean flag = false;
for(int a=0;a<OfficeData.length;a++)
{
	
		
	if(i>=3)
	{
		if(flag)
			out.println("<tr class='MRow2'>");
		else
			out.println("<tr class='MRow1'>");
		 
		i=0;
		if(flag)
			flag = false;
		else
			flag =true;
	}
	i=i+1;	
	out.println("<td  class=\"boldEleven\"> <input type=\"checkbox\" name='office'  id='office"+a+"'  value=\""+OfficeData[a][0]+"\"><font class='boldEleven'>"+OfficeData[a][1]);
}

if(i==1)
	out.println("<td  class=\"boldEleven\">&nbsp;</td><td  class=\"boldEleven\">&nbsp;</td>");
else if(i==2)
	out.println("<td  class=\"boldEleven\">&nbsp;</td>");
out.println("</tr>");	
	
out.println("</table>");

/*out.println("<table width='100%'  border='1' align='center' cellpadding='2' cellspacing='1'   >");
out.println("<tr class='MRow1'> <td colspan='2'class='boldEleven'><center><h3>SELECT OFFICE</h3></center></td></tr>" );
out.println("<tr class='MRow1'> " );
out.println("<td class='boldEleven'><b>S.NO</b></td>");
out.println("<td class='boldEleven'><b>NAME</b></td>");
out.println("</tr>");
for (int i = 0; i < OfficeData.length; i++) 
{	
		 if(i%2==0)
				out.println("<tr class='MRow1'>");
			else
				out.println("<tr class='MRow2'>");
		 
		out.println("<td class='boldEleven'>"+(i+1)+".</td>" );
		out.println("<td class='boldEleven'><input name='office'  id='office"+i+"'  type='checkbox' value='"+OfficeData[i][0]+"'>"+OfficeData[i][1]+"</td>");
		out.println("</tr>");
	}	
		 
out.println("</table>");		*/


					  %>
					      
	                      <input name='dec' type='hidden' class='formText135' id='dec' size='15' maxlength='100' value=<%= OfficeData.length%>>
					      
					      
					      
					      
			            </div></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">&nbsp;</td>
                      <td class="boldEleven">&nbsp;</td>
                    </tr>
                    <tr>
                      <td colspan="2" class="boldEleven"><table width="50" border="0" align="center" cellpadding="2" cellspacing="2">
                          <tr>
                            <td width="56"><input type="submit" name="Submit" value="Submit"   accesskey="s"    class="tMLAscreenHead"></td>
                            <td width="56"><input type="button" name="Submit2"  value="Close"   accesskey="c"  class="tMLAscreenHead" onClick="redirect('Conveyancemain.jsp')"></td>
                          </tr>
                      </table></td>
                    </tr>
                  </table></td>
                  <td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
                  <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
                </tr>
                <tr>
                  <td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
                  <td height="6"><spacer height="1" width="1" type="block" /></td>
                  <td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
                </tr>
                <tr>
                  <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
                </tr>
              </tbody>
            </table>
			<p>&nbsp;</p>
			</center>
			 
</form>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>

<%@ include file="../footer.jsp"%>
<script language="javascript">
 
function validate()
{
	try
	{
		var len=document.getElementById("dec").value;
		 
		var acount=0;
		var rcount=0;
		 
		for(var i=0;i<len;i++)
		 if(document.getElementById("office"+i).checked)	  	
			acount=acount+1;
		
		 
		if((acount<=0) )
		{
			alert("Select Atleast One Office...");
			return false;
		}	
		else
		{
			return true;
		}	
	}
	catch(err)
	{
		alert(err);
	}
}


function assign()
{
	 	
	var nocheck=document.forms[0].office
	var val=document.getElementById("all").checked
	if(val==false)
	{
		for(i=0;i<nocheck.length;++ i)
		{
			nocheck[i].checked=false;
		}
	}
	else
	{
		for(i=0;i<nocheck.length;++ i)
		{		
			nocheck[i].checked=true;
		}
	}
		
		
		
}
	
</script>
</body>
</html>

<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	 
}
%>
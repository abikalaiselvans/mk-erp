<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" %>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%><%
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

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script>
	
	$(function() {
		$( "#paydate" ).datepicker({ minDate: -10, maxDate: "+2D",showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true });
	});
	
	
 
</script>
	
	
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">




<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<br>
<br>

 
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth"	onSubmit="return validate()">
<%
	 
	String paydate = request.getParameter("paydate");
	String sql = "" ;
	sql = " SELECT a.CHR_EMPID, FUN_GET_CONVEYANCE_ADVANCE(a.CHR_EMPID),SUM(a.DOU_TOTAL), ";
	sql = sql +" (SUM(a.DOU_TOTAL)-FUN_GET_CONVEYANCE_ADVANCE(a.CHR_EMPID)), ";
	sql = sql +" FIND_A_EMPLOYEE_ID_NAME(a.CHR_EMPID) ,c.CHR_OFFICENAME,d.CHR_CATEGORYNAME   ";
	sql = sql +" FROM conveyance_t_conveyance a ,com_m_staff b, com_m_office c, com_m_employeecategory d ";
	sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID AND b.INT_OFFICEID =c.INT_OFFICEID AND b.CHR_CATEGORY = d.INT_EMPLOYEECATEGORYID AND a.CHR_STATUS='Y' AND a.CHR_ACCSTATUS='Y' AND CHR_ADVANCEFLAG ='N'  AND  FUN_GET_CONVEYANCE_ADVANCE(a.CHR_EMPID) > 0  ";
	sql = sql +" AND a.DAT_ACCDATE='"+paydate+"' ";
	sql = sql +" GROUP BY a.CHR_EMPID  ";
	//out.println(sql);
	String data[][]= CommonFunctions.QueryExecute(sql);
	if(data.length>0)
	{
		out.println("<center>");
		out.println("<table width='60%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		
		out.println("<TR class='MRow1'>");
		out.println("<Td  colspan='7' class='boldEleven' align='center'>");
		out.println("<br><H1>A D V A N C E  &nbsp;&nbsp;&nbsp;&nbsp;  D E D U C T I O N</H1><br> ");
		out.println("</Th>");
		out.println("</tr>");
		
		out.println("<tr class='MRow2'>");
		out.println("<td class='boldEleven' align='center'><b>S.No</b></td>");
		out.println("<td class='boldEleven' align='center'><b>Empid</b></td>");
		out.println("<td class='boldEleven' align='center'><b>Office</b></td>");
		out.println("<td class='boldEleven' align='center'><b>Category</b></td>");
		out.println("<td class='boldEleven' align='center'><b>Advance Amount</b></td>");
		out.println("<td class='boldEleven' align='center'><b>Conveyance Amount</b></td>");
		out.println("<td class='boldEleven' align='center'><b>Deduction Amount</b></td>");
		out.println("</tr>");
		for(int u=0;u<data.length;u++)
		{
			if(u%2==0)
				out.println("<tr  class='MRow2'>");
			else
				out.println("<tr  class='MRow1'>");
					
			out.println("<td class='boldEleven'>"+(u+1)+"</td>");
			out.println("<td class='boldEleven'>"+data[u][4]+"</td>");
			out.println("<td class='boldEleven'>"+data[u][5]+"</td>");
			out.println("<td class='boldEleven'>"+data[u][6]+"</td>");
			
			out.println("<td class='boldEleven' align='right'>"+data[u][1]+"</td>");
			out.println("<td class='boldEleven' align='right'>"+data[u][2]+"</td>");
			out.println("<td class='boldEleven'><input type='text' value ="+data[u][2]+" size=15 name='deduction"+(u+1)+"'  id='deduction"+(u+1)+"' class='formText135'  style='text-align:right'  onKeyPress=\"return numeric_only(event,'deduction"+(u+1)+"','10')\" maxlength='8' />");
			out.println("<input name='empid"+(u+1)+"'  id='empid"+(u+1)+"' type='hidden' value='"+data[u][0]+"'>");	
			out.println("<input name='advance"+(u+1)+"'  id='advance"+(u+1)+"' type='hidden' value='"+data[u][1]+"'>");	
			out.println("<input name='conveyance"+(u+1)+"'  id='conveyance"+(u+1)+"' type='hidden' value='"+data[u][2]+"'>");	
			out.println("</td></tr>");
		}
		
		out.println("<TR class='MRow2'>");
		out.println("<Td  colspan='7' class='boldEleven'>");
		out.println("<input name='filename' type='hidden' value='ConveyanceAdvance'>");
		out.println("<input name='actionS' type='hidden' value='CONConveyanceAdvanceDED'>");
		out.println("<input name='paydate' type='hidden' value='"+paydate+"'>");
		out.println("<input name='len' type='hidden' value='"+data.length+"'>");
		
		out.println("</Th>");
		out.println("</tr>");
		
		out.println("<TR class='MRow1'>");
		out.println("<Th  colspan='7' class='boldEleven'>");
		
		out.println("<center><table width='120' border='0' cellspacing='2' cellpadding='3' align='center'>");
		out.println("<tr class='MRow1'>");
		out.println("<td><input type='submit' id='submit'  name='submit' value='Submit' class='buttonbold13'></td>");
		out.println("<td><input type=button name=submit1 value=Close class='buttonbold13' onclick=\"(redirect('Conveyancemain.jsp'))\"></td>");
		out.println(" </tr>");
		out.println("</table></center>"); 
		out.println("</Th>");
		out.println("</tr>");
		
		out.println("</table>");		
		out.println("</center>");
		
	}
 
	
	
	 
		%>
		 
			</center>
			 
  
			
</Td>			
 </TR> 
 </table> 
</form>
 

<script language="javascript">
 
 
function validate()
{
		
	var row="<%=data.length%>";
	var f  = false;
	for(u=0;u<row;u++)
	{
		var advance = parseFloat(document.getElementById("advance"+(u+1)).value);
		var deduction = parseFloat(document.getElementById("deduction"+(u+1)).value);
		var conveyance = parseFloat(document.getElementById("conveyance"+(u+1)).value);
		if(checkNull('deduction'+(u+1),'Check Deduction Amount'))
		{
			if( conveyance>=advance  )
			{
				alert("deduction :"+deduction + " advance :"+advance + "/"  +(deduction <=advance) );
				
				if(deduction <=advance)
					d = 1;
				else
				{
					alert("deduction amount greater than the conveyance amount")
					document.getElementById("deduction"+(u+1)).focus();
					return false;
				}	
			}
			else
			{
				alert("deduction :"+deduction + " conveyance :"+conveyance + "/"  +(deduction <=conveyance) );
				if(deduction <=conveyance)
					d = 1;
				else
				{
					alert("deduction amount greater than the advance amount")
					document.getElementById("deduction"+(u+1)).focus();
					return false;
				}	
			}	
		}		
		else
		{
			return false;		
		}	
			
	}
}
</script>
<%@ include file="../footer.jsp"%>

</body>

<%
}
catch(Exception e)
{
	 
	System.out.println(e.getMessage());
}
%>
</html>

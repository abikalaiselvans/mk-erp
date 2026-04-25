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




<script language="javascript">
function disable()
{
	rejectdecs.style.visibility="hidden";
	
}	

function enable()
{
	rejectdecs.style.visibility="Visible";
	
}	

function assign()
{
	 	
	var nocheck=document.forms[0].accept
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

function validateCheckboxes() {
    const checkboxes = document.getElementsByName('accept');
    for (let i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
            return true; // Found a checked one, return true immediately
        }
    }
    return false; // No checked boxes found
}

function validate()
{
	  
	if(validateCheckboxes())
		return true;
	else
	{
		alert("Select Only one claim");
		return false;
	}
	
	
}
</script>

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<br>
<br>
<%
try
{

%> 
 
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth"	onSubmit="return validate()">
<%
	 
	
	String[] dofficeid = request.getParameterValues("office");
	String sql ="";
	String ids=" ";
	for(int y=0;y<dofficeid.length;y++)
		ids = ids+dofficeid[y]+",";
		
  	
	boolean f = com.my.org.erp.common.CommonFunction.RecordExist("SELECT  COUNT(*)  FROM conveyance_t_conveyance WHERE CHR_ACCSTATUS='Y' GROUP BY DAT_ACCDATE  ORDER BY DAT_ACCDATE  asc");
	if(f)
	{
		try
		{
			sql ="SELECT  (DAT_CLEARINGDATE is null),DATE_FORMAT(DAT_ACCDATE,'%d-%b-%Y') FROM conveyance_t_conveyance WHERE CHR_ACCSTATUS='Y'  and DAT_CLEARINGDATE is null  GROUP BY DAT_ACCDATE  ORDER BY DAT_ACCDATE  DESC LIMIT 0,1";
			String checkdata[][]= CommonFunctions.QueryExecute(sql);
			f = "1".equals(checkdata[0][0]);
			 
			if(f)
			{
				out.println("<script language=\"javascript\">");
				out.println("window.location = \"conveyanceClearingPage.jsp\";");
				out.println("</script>");
				 
				 
				 
			}
		}
		catch(Exception e)
		{
			out.println(e.getMessage());
		}			
	} 
	 
	
	
	 
		%>
		<table width='90%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC'  align='center'> 
		<TR class='MRow1'> 
		<Td   colspan=21 class='boldEleven'> 
		
		
			<center>
			<table width="250" border="0" cellspacing="0" cellpadding="0">
			<tr >
				<td class="boldEleven">Payment Date</td>
				<td class="boldEleven">
					<input name="paydate" type="text" class="formText135" id="paydate" 
					 size="15" maxlength="10" readonly="readonly"> 
					 
					<script	language="JavaScript">
						<!--
						  
						  setCurrentDate('paydate');
						//-->
                  </script></td>
			</tr>
			</table>
			</center>
			<%
			
			
			double sum=0;
		 
		 
			
			sql = "SELECT a.INT_CONID,a.DAT_CONDATE,a.CHR_FROM,a.CHR_TO,a.DOU_KM,a.DOU_TRAVEL,a.DOU_TRAIN,a.DOU_AUTO,a.DOU_LUNCH,a.DOU_TELEPHONE,  ";
			sql = sql+" a.CHR_OTHERDESC,a.DOU_OTHERAMT,a.DOU_TOTAL,a.CHR_STATUS,a.CHR_DESC,a.CHR_ACCSTATUS,a.CHR_CALLID ,a.CHR_EMPID,b.CHR_STAFFNAME , c.CHR_OFFICENAME, ";
			sql = sql+"	FIND_A_OFFICENAME(a.INT_OFFICEID) , a.CHR_CONVEYANCETYPE, a.CHR_CUSTOMER    "; 
			sql = sql+" FROM conveyance_t_conveyance  a  ,com_m_staff b, com_m_office c  ";
			sql = sql+" WHERE  a.CHR_EMPID=b.CHR_EMPID AND b.INT_OFFICEID = c.INT_OFFICEID  AND a.CHR_STATUS='Y' AND a.CHR_ACCEPT='Y'  AND CHR_ACCSTATUS='N'   ";
			sql = sql+" AND  b.INT_OFFICEID IN ( "+ids+"   0)  ";
  			out.println(sql);
			String data[][]= CommonFunctions.QueryExecute(sql);
			
			if(data.length>0)
			{
				
				
				
				out.println("<TR class='MRow1'>");
				out.println("<Th  class='boldEleven'><b>Sl.No</b></Th>");
				out.println("<Th  class='boldEleven'><b>Name</b></Th>");
				out.println("<Th  class='boldEleven'><b>Office</b></Th>");
				out.println("<Th  class='boldEleven' width=75><b>Date</b></Th>");
				out.println("<Th  class='boldEleven'><b>Call Id</b></Th>");
				out.println("<Th  class='boldEleven'><b>Office</Th>");
				out.println("<Th  class='boldEleven'><b>ConveyanceType</Th>");
				out.println("<Th  class='boldEleven'><b>Customer</Th>");
				out.println("<Th  class='boldEleven'><b>From</b></Th>");
				out.println("<Th  class='boldEleven'><b>To</b></Th>");
				out.println("<Th  class='boldEleven'><b>Vehicle No of Kms</b></Th>");
				out.println("<Th  class='boldEleven'><b>Amount</b></Th>");
				out.println("<Th  class='boldEleven'><b>Train/Bus Fare</b></Th>");
				out.println("<Th  class='boldEleven'><b>Auto Fare</b></Th>");
				out.println("<Th  class='boldEleven'><b>Lunch / Dinner</b></Th>");
				out.println("<Th  class='boldEleven'><b>Telephone Charges</b></Th>");
				out.println("<Th  class='boldEleven'><b>Others Desc</b></Th>");
				out.println("<Th  class='boldEleven'><b>Others Amt</b></Th>");
				out.println("<Th  class='boldEleven'><b>Total</b> </Th>");
				out.println("<Th  class='boldEleven'><input type='checkbox' id='all' name='all' onClick='assign()'>");
				out.println("<Th  class='boldEleven'>&nbsp; </Th>");
				out.println(" </TR>");
				for(int x=0;x<data.length;x++)
				{
					if(x%2==0)
						out.println("<tr class='MRow1'>");
					else
		    			out.println("<tr  class='MRow2'>");	
						
					out.println("<td class='boldEleven'>"+(x+1));
					out.println("<td class='boldEleven'>"+data[x][17]+"/"+data[x][18]);
					out.println("<td class='boldEleven'>"+data[x][19]);
					
					out.println("<td class='boldEleven'>"+ DateUtil.FormateDateSys(data[x][1]));	
					out.println("<td class='boldEleven'>"+data[x][16]);
					
					out.println("<td class='boldEleven'>"+data[x][20]);
					out.println("<td class='boldEleven'>"+data[x][21]);
					out.println("<td class='boldEleven'>"+data[x][22]);
					
					out.println("<td class='boldEleven'>"+data[x][2]);
					out.println("<td class='boldEleven'>"+data[x][3]);
					out.println("<td class='boldEleven' align='right'>"+data[x][4]);
					out.println("<td class='boldEleven' align='right'>"+data[x][5]);
					out.println("<td class='boldEleven' align='right'>"+data[x][6]);
					out.println("<td class='boldEleven' align='right'>"+data[x][7]);
					out.println("<td class='boldEleven' align='right'>"+data[x][8]);
					out.println("<td class='boldEleven' align='right'>"+data[x][9]);
					out.println("<td class='boldEleven' align='right'>"+data[x][10]);
					out.println("<td class='boldEleven' align='right'>"+data[x][11]);
					out.println("<td class='boldEleven' align='right'>"+data[x][12]);
					sum = sum+Double.parseDouble(data[x][12]);
					out.println("<td ><input type='checkbox' name='accept' id='accept' value='"+data[x][0]+"'>");
					 
					out.println("<td class='boldEleven'>");
					 
				}
				out.println("<TR class='MRow1'>");
				out.println("<Td  colspan=18 class='boldEleven' align='right'><b> SUM :: </b></Td>");
				out.println("<Td  class='boldEleven' align='right'>"+sum+"</Td>");
				out.println("<Td  class='boldEleven'>&nbsp;</Td>");
				out.println("<Td  class='boldEleven'>&nbsp;</Td>");
				out.println(" </TR>"); 
				 
				out.println("<TR class='MRow1'>");
				out.println("<Th  colspan='21' class='boldEleven'>");
				
				out.println("<center><table width='120' border='0' cellspacing='2' cellpadding='3' align='center'>");
				out.println("<tr class='MRow1'>");
				out.println("<td><input type='submit' id='submit'  name='submit' value='Submit' class='buttonbold13'></td>");
				out.println("<td><input type=button name=submit1 value=Close class='buttonbold13' onclick=\"(redirect('Conveyancemain.jsp'))\"></td>");
				out.println(" </tr>");
				out.println("</table></center>"); 
				out.println("</Th>");
			}
		 	else
			{
				out.println("<center> <font  class='bolddeepred' ><br><br><br><br>Data not found... </font></center>");
				out.println("<center><table width='120' border='0' cellspacing='2' cellpadding='3' align='center'>");
				out.println("<tr class='MRow1'>");
				out.println("<td><input type=button name=submit1 value=Close class='buttonbold13' onclick=\"(redirect('Conveyancemain.jsp'))\"></td>");
				out.println(" </tr>");
				out.println("</table></center>"); 
			}
		 
		
	 
	 
	 
%>
 
	    <input name="filename"
			type="hidden" id="filename" value="Conveyance">
        <input
			name="actionS" type="hidden" id="actionS"
			value="CONConveyancePayAccept">
			
</Td>			
 </TR> 
 </table> 
</form>
<%
}
catch(Exception e)
{
	 
	System.out.println(e.getMessage());
}
%>

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

 <%@ page import="java.io.*,java.util.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
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
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">

<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css" />
 


<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return Validate()">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		 
    </tr>
	<tr>
	  <td><table class="BackGround" cellspacing="0" cellpadding="0" width="800"
			align="center" border="0">
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
            <td width="6"><spacer height="1" width="1" type="block" /></td>
            <td><table width="100%" border="0" cellspacing="2" cellpadding="2">
              <tr>
                <td colspan="4"><div align="center" class="bold1">
                  <div align="center">PAYMENT COMMITMENT </div>
                </div></td>
                </tr>
              <tr>
                <td colspan="4">
				
				<%

	String salno = request.getParameter("salno");
	String Billinttype = request.getParameter("Billinttype");
	
	String sql="";
	sql=" SELECT INT_PAYMENTCOMMITMENTID, CHR_SALESNO,CHR_INVOICETYPE,DATE_FORMAT(DT_COMMITMENTDATE,'%d-%m-%Y'),DOU_COMMITMENTAMOUNT,";
	sql = sql + " DOU_ACTUALAMOUNT,DT_RECIEVEDDATE,DOU_RECEIVEDAMOUNT,CHR_DESCRIPTION,DOU_BALANCEAMOUNT,";
	sql = sql + " CHR_STATUS,CHR_NEXTFLAG FROM inv_t_paymentcommitment  WHERE CHR_SALESNO='"+salno+"'";
	 
	String data[][] = CommonFunctions.QueryExecute(sql);
	boolean f= true;
	double invoiceamount=0;
	if(data.length>0)
	{


	String invoicedate="";
	String comittmentdays="30";
	if("C".equals(data[0][2]))
	{
		 invoicedate =CommonFunctions.QueryExecute("SELECT  DATE_FORMAT(DAT_SALESDATE,'%d-%m-%Y' ) FROM  inv_t_directsales WHERE  CHR_SALESNO='"+data[0][1]+"'")[0][0];
		 comittmentdays =CommonFunctions.QueryExecute("SELECT  INT_PAYMENT_COMMITMENT_DAYS FROM  inv_t_directsales WHERE  CHR_SALESNO='"+data[0][1]+"'")[0][0];
	}	 
	else if("D".equals(data[0][2]))
	{
		invoicedate =CommonFunctions.QueryExecute("SELECT  DATE_FORMAT(DAT_SALESDATE,'%d-%m-%Y' ) FROM  inv_t_directbilling WHERE  CHR_SALESNO='"+data[0][1]+"'")[0][0];
		 comittmentdays =CommonFunctions.QueryExecute("SELECT  INT_PAYMENT_COMMITMENT_DAYS FROM  inv_t_directbilling WHERE  CHR_SALESNO='"+data[0][1]+"'")[0][0];
	}	
	else if("S".equals(data[0][2]))
	{
		invoicedate =CommonFunctions.QueryExecute("SELECT  DATE_FORMAT(DAT_SALESDATE,'%d-%m-%Y' ) FROM  inv_t_servicebilling WHERE  CHR_SALESNO='"+data[0][1]+"'")[0][0];
		 comittmentdays =CommonFunctions.QueryExecute("SELECT  INT_PAYMENT_COMMITMENT_DAYS FROM  inv_t_servicebilling WHERE  CHR_SALESNO='"+data[0][1]+"'")[0][0];
	}
	
	sql = "SELECT DATE_FORMAT(DATE_ADD('"+DateUtil.FormateDateSQL(invoicedate)+"',INTERVAL "+comittmentdays+" DAY),'%d-%m-%Y')"; 
	String  commitmentdate = CommonFunctions.QueryExecute(sql)[0][0];
	
	out.println("<input name='invoicedate'  id='invoicedate'  type='hidden' value='"+invoicedate+"'> ");		
	out.println("<br><br><center>");
	out.println("<table width='100%' class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.println("<tr class='MRow1'><td class='boldEleven'><b>S.No.");
	out.println("<td class='boldEleven'><b>Sales No");
	out.println("<td class='boldEleven'><b>Invoice Type");
	out.println("<td class='boldEleven'><b>Commitment Date");
	out.println("<td class='boldEleven'><b>Commitment Amount");
	out.println("<td class='boldEleven'><b>Invoice Amount");
	out.println("<td class='boldEleven'><b>");
	 
	 
	 
	for(int u=0;u<data.length;u++)
	{
		if(u%2==0)
			out.println("<tr class='MRow2'>");
		else
			out.println("<tr class='MRow1'>");
			
		invoiceamount = Double.parseDouble(data[u][5])/data.length;
		out.println("<td class='boldEleven'>"+(u+1));
		out.println("<td class='boldEleven'>"+data[u][1]);
		out.println("<td class='boldEleven'>");
		out.println(" <input name='rowid"+(u+1)+"'  id='rowid"+(u+1)+"' type='hidden' value='"+data[u][0]+"'>");
		out.println(" <input name='salno"+(u+1)+"'  id='salno"+(u+1)+"' type='hidden' value='"+data[u][1]+"'>");
		out.println(" <input name='saledate"+(u+1)+"'  id='saledate"+(u+1)+"' type='hidden' value='"+data[u][3]+"'>");
		out.println(" <input name='salnoamount'  id='salnoamount' type='hidden' value='"+data[u][5]+"'>");
		
		if("C".equals(data[u][2]))
			out.println("Customer Sales");
		else if("D".equals(data[u][2]))
			out.println("Direct Sales");
		else if("S".equals(data[u][2]))
			out.println("Service Billing");
			
		out.println("<td class='boldEleven'>");
		if(!"Y".equals(data[u][10]))
		{
			
			out.println("<input name = 'cdate"+(u+1)+"'  id = 'cdate"+(u+1)+"'  readonly='readonly' type='textbox' size='15' class='formText135'  value='"+commitmentdate+"'>");
			out.println("<script>");
			out.println("$(function() { ");
						out.println("$( \"#cdate"+(u+1)+"\" ).datepicker({ minDate: -0, maxDate: \"+"+comittmentdays+"D\" });");
			out.println("});");
			
			out.println("</script>");
  



		 
			
			
		}
		else
		{
			f = false;
			out.println("&nbsp;"+data[u][3]);
		}	
		
		
			
		
		 out.println("<td class='boldEleven'>");
		if(!"Y".equals(data[u][10]))
			out.println("<input name = 'camount"+(u+1)+"' onkeypress=\"return numeric_only(event,'camount"+(u+1)+"','8')\"   onBlur=\"checkCommitment('camount"+(u+1)+"','"+ invoiceamount+"')\"  id = 'camount"+(u+1)+"' type='textbox' size='15' class='formText135'  value='"+ invoiceamount+"' readonly='readonly'>");
		else
			out.println("&nbsp;"+data[u][4]);
			
			
		out.println("<td class='boldEleven'>"+data[u][5]);
		
		if("Y".equals(data[u][10]))
			out.println("<td class='boldEleven'>Commitment Assigned");
		else 
			out.println("<td class='boldEleven'>Commitment Not Assigned");
		 
		 
	}
	out.println("</table>");
	out.println("</center>");
	}
	else
	{
	out.println("<br><br><font color='red'><h3><b><center>Data not found ...</center></b><h3></font>");
	}

%>
          <input name="filename" type="hidden" value="PaymentCommitment" /> 
		  <input name="actionS" type="hidden" value="INVPaymentCommitmentEntry" />
		  <input name="param" type="hidden" id="param" value="<%=data.length%>">  
		  <input name="Billinttype" type="hidden" id="Billinttype" value="<%=Billinttype%>">	 			
		  <input name="saleno" type="hidden" id="saleno"   value="<%=salno%>"></td> 
                </tr>
              <tr>
                <td colspan="4">
                  <div align="center">
                    <%
	 if("C".equals(Billinttype))
	{
		 
		{
			out.println("<table  border='0' cellpadding='2' cellspacing='2' align='center' width='400'>");
			out.println(" <tr>");
			out.println("<td class='boldEleven'>Support / CRO Charges </td>");
			out.println("<td class='boldEleven'><input name='support' type='text' class='formText135' id='support' onkeypress=\"return numeric_only(event,'support','15')\" value='0' size='10' maxlength='10'/></td>");
			out.println(" </tr>");
			out.println("<tr>");
			out.println("<td class='boldEleven'>Installation /Implementation Charges </td>");
			out.println("<td class='boldEleven'><input name='installation' type='text' class='formText135' id='installation' onkeypress=\"return numeric_only(event,'installation','15')\" value='0' size='10' maxlength='10'/></td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td class='boldEleven'>Transport Charges </td>");
			out.println("<td class='boldEleven'><input name='transport' type='text' class='formText135' id='transport' onkeypress=\"return numeric_only(event,'transport','15')\" value='0' size='10' maxlength='10'/></td>");
			out.println("</tr>");
			out.println("</table>");
		}
	}
	else
	{
		out.println("<input name='support'      type='hidden'   id='support'       value='0' size='40' maxlength='10'/>");
		out.println("<input name='installation' type='hidden'   id='installation'  value='0' size='40' maxlength='10'/>");
		out.println("<input name='transport'    type='hidden'   id='transport'     value='0' size='40' maxlength='10'/>");
	} 
 %>
                    
                    
                    
                    
                    </div></td>
                </tr>
              <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
               
              <tr>
                <td colspan="4">
				<table border="0" align="center" cellpadding="0">
                  <tr>
                    <td width="60">
					<%
					if(f)
						out.println("<input name='Update' type='submit' class='buttonbold13' id='Update' value='Update' >");
					%>					</td>
					<td  width="60"><input name="Close" type="button" class="buttonbold13" id="Close"  value="Close"   accesskey="c"  onClick="redirect('PaymentCommitment.jsp')"></td>
                  </tr>
             </table>				</td>
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
      </table></td>
    </tr>
</table>
<p>
  <script language="JavaScript">


function checkCommitment(ctr, salesamount)
{
	var textamount = parseFloat(document.getElementById(ctr).value);
	var actualamount = parseFloat(salesamount);
	if(textamount>actualamount)
	{
		alert("Kindly check your commitment amount...");
		document.getElementById(ctr).focus();
	}	
}

function Validate()
  {
	
	var noofcommitment = "<%=data.length%>";
	var data="";
	for(u=1 ; u<=noofcommitment; u++)
		data = data+"cdate"+u+","+"camount"+u+",";
		
	var f = true;
	for(u=1 ; u<=noofcommitment; u++)
	{
		f = DateCompares("invoicedate","cdate"+u ," Commitment Date Cannot be Greater Than Invoice date...") 
		if(!f)
			return false;
	}
	
	
	var sum=0;
	for(u=1 ; u<=noofcommitment; u++)
		sum = sum+ parseFloat(document.getElementById("camount"+u).value);
	var salnoamount= parseFloat(document.getElementById('salnoamount').value);
	 
	 
	if((salnoamount==sum))
	{ 
		var v = data.split(",");	
		for( i=0; i<v.length-1; i++)
		{
			
			var chk =document.getElementById(v[i]).value;
			var ck = "Enter Data..."+v[i];
			if(checkNull(v[i],ck))
			{
				d=1;
				
			}
			else
			{
				return false;				
			}	
		}
	}
	else
	{
		alert(" kindly check the Total Amount  not equal to Commitment Amount...That means "+salnoamount+" / "+sum);
		return false;
	}	
 } 	
  </script> 
  <%@ include file="../footer.jsp"%>
</form>
  
  <%
  }
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}

  %>
</p>
<p>&nbsp;</p>
<p>
   
</p>
<p>
  
</p>
</body>
</html>

 <%@ page import="java.io.*,java.util.*"%>

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
<script language="JavaScript" src="../JavaScript/calendar1.js"  ></script>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">


<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post"    >
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td valign="top">&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	 
	<tr>
		<td>
		
		
		<div align="center"><b>Payment Commitment</b>
          <strong>Update</strong>                            
  <%

	String salno = request.getParameter("salno");
	String sql="";
	sql=" SELECT INT_PAYMENTCOMMITMENTID, CHR_SALESNO,CHR_INVOICETYPE,DATE_FORMAT(DT_COMMITMENTDATE,'%d-%m-%Y'),DOU_COMMITMENTAMOUNT,";
	sql = sql + " DOU_ACTUALAMOUNT,DT_RECIEVEDDATE,DOU_RECEIVEDAMOUNT,CHR_DESCRIPTION,DOU_BALANCEAMOUNT,";
	sql = sql + " CHR_STATUS,CHR_PAYMENTFLAG,CHR_NEXTFLAG FROM inv_t_paymentcommitment  WHERE CHR_SALESNO='"+salno+"' AND CHR_STATUS='Y'    ";
	String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	boolean f= true;

	if(data.length>0)
	{

		out.println("<br><br><center>");
		out.println("<table  class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<tr class='MRow1'><td class='boldEleven'><b>S.No.");
		out.println("<td class='boldEleven'><b>Sales No");
		out.println("<td class='boldEleven'><b>Invoice Type");
		out.println("<td class='boldEleven'><b>Commitment Date");
		out.println("<td class='boldEleven'><b>Commitment Amount");
		out.println("<td class='boldEleven'><b>Invoice Amount");
		out.println("<td class='boldEleven'><b>Commitment Status");
		out.println("<td class='boldEleven'><b>Received Date");
		out.println("<td class='boldEleven'><b>Received Amount");
		out.println("<td class='boldEleven'><b>Description");
		 
		out.println("<td class='boldEleven'><b>Update"); 
		out.println("<td class='boldEleven'><b>Cancel"); 
		for(int u=0;u<data.length;u++)
		{
			if(u%2==0)
				out.println("<tr class='MRow2' height='50'>");
			else
				out.println("<tr class='MRow1'  height='50'>");
			out.println("<td valign='top' class='boldEleven'>"+(u+1));
			out.println("<td valign='top'  class='boldEleven'>"+data[u][1]);
			out.println("<td valign='top'  class='boldEleven'>");
			out.println(" <input name='rowid"+(u+1)+"'  id='rowid"+(u+1)+"' type='hidden' value='"+data[u][0]+"'>");
			out.println(" <input name='salno"+(u+1)+"'  id='salno"+(u+1)+"' type='hidden' value='"+data[u][1]+"'>");
			out.println(" <input name='salnoamount'     id='salnoamount' type='hidden' value='"+data[u][5]+"'>");
			out.println(" <input name='cmount"+(u+1)+"' id='cmount"+(u+1)+"' type='hidden' value='"+data[u][4]+"'>");
			out.println(" <input name='cdate"+(u+1)+"' id='cdate"+(u+1)+"' type='hidden' value='"+data[u][3]+"'>");
			
			if("C".equals(data[u][2]))
				out.println("Customer Sales");
			else if("D".equals(data[u][2]))
				out.println("Direct Sales");
			else if("S".equals(data[u][2]))
				out.println("Service Billing");
			out.println("<td valign='top'  class='boldEleven'>"+data[u][3]);
			out.println("<td valign='top'  class='boldEleven'>"+data[u][4]);
			out.println("<td valign='top'  class='boldEleven'>"+data[u][5]);
			if("Y".equals(data[u][10]))
				out.println("<td valign='top'  class='boldEleven'>Commitment Assigned");
			else 
				out.println("<td valign='top'  class='boldEleven'>Commitment Not Assigned");
			
			
			
			
			
			
			if( ("Y".equals(data[u][10]))  && ("N".equals(data[u][11]))  && ("N".equals(data[u][12])) )
			{
				out.println("<td valign='top'  class='boldEleven'><input name = 'rdate"+(u+1)+"'  id = 'rdate"+(u+1)+"' type='textbox' size='15' class='formText135' readonly ='readonly'  value='"+data[u][6]+"'   >"); 			
				out.println("<a	href=\"javascript:call"+(u+1)+".popup();\"> ");
				out.println("<img src=\"../JavaScript/img/cal.gif\" width=\"16\" height=\"16\"	border=\"0\" /> </a>");
				out.println("<script language='JavaScript' type=\"text/javascript\">");
				out.println("var call"+(u+1)+" = new calendar1(document.forms['frm'].elements['rdate"+(u+1)+"']);");
				out.println("call"+(u+1)+".year_scroll = true;");
				out.println("call"+(u+1)+".time_comp = false;");
				out.println("setCurrentDate('rdate"+(u+1)+"');");
				out.println("</script>");
				 
 
 
				
			}
			else
				out.println("<td valign='top'  class='boldEleven'>&nbsp;"+data[u][6]);
				
				
			
			if( ("Y".equals(data[u][10]))  && ("N".equals(data[u][11]))  && ("N".equals(data[u][12])) )
				out.println("<td valign='top'  class='boldEleven'><input name = 'ramount"+(u+1)+"'  id = 'ramount"+(u+1)+"' type='textbox' maxlength='10' size='10' class='formText135'  value='"+data[u][7]+"' onKeyPress=\"return numeric_only(event,'ramount"+(u+1)+"','15')\"    onBlur=\"checkCommitment( 'ramount"+(u+1)+"','"+data[u][5]+"')\"  >"); 
			else
				out.println("<td valign='top'  class='boldEleven'>&nbsp;"+data[u][5]);
				
				
				
			if( ("Y".equals(data[u][10]))  && ("N".equals(data[u][11]))  && ("N".equals(data[u][12])) )	
				out.println("<td valign='top'  class='boldEleven'><textarea  cols='35' rows='5'  onKeyPress=textArea('desc"+(u+1)+"',1000) name='desc"+(u+1)+"' id='desc"+(u+1)+"' >"+data[u][8]+"</textarea>");
			 else
				out.println("<td valign='top'  class='boldEleven'>&nbsp;"+data[u][8]);
				
			
			 
			 
			 
			 
			 
			if( ("Y".equals(data[u][10]))  && ("N".equals(data[u][11]))  && ("N".equals(data[u][12])) )
				out.println("<td valign='top'  class='boldEleven'><input name='Update' type='Button' class='buttonbold13' id='Update' value='Update' onClick=\"return CommitmentUpdate('"+(u+1)+"')\">");
			else
				out.println("<td valign='top'  class='boldEleven'>&nbsp;");
			
			
			
			out.println("<td valign='top'  class='boldEleven'>	");
			if( ("Y".equals(data[u][10]))  && ("N".equals(data[u][11]))  && ("N".equals(data[u][12])) )	
				out.println("<input name='Cancel' type='Button' class='buttonbold13'   id='Cancel' value='Postpone' onClick=\"CommitmentCancel('"+(u+1)+"')\">");
			else if( ("Y".equals(data[u][10]))  && ("Y".equals(data[u][11]))   )	
				out.println("<a href='../SmartLoginAuth?filename=PaymentCommitment&actionS=INVPaymentCommitmentreset&rowid="+data[u][0]+"&saleno="+data[u][1]+"'><font class='boldgreen'>Reset</font></a>");
			else	
				out.println("&nbsp;");	
				
			if( ("Y".equals(data[u][10]))  && ("N".equals(data[u][11]))  && ("N".equals(data[u][12]))  && data.length>1)	
				out.println("&nbsp;<input name='Delete' type='Button' class='buttonbold13'   id='Delete' value='Delete' onClick=\"CommitmentDelete('"+(u+1)+"')\">");	
				
		}
		out.println("</table>");
		out.println("</center>");
	}
	else
	{
		out.println("<br><br><font color='red'><h3><b><center>Data not found ...</center></b><h3></font>");
	}

%>
           
		</div>
		
		<p>&nbsp;</p>
	    </td>
	</tr>
	<tr>
		<td> </td>
	</tr>
	<tr>
		<td>  
			  <table align="center">
                  <tr>
                     
					<td  width="60"><input name="Close" type="button" class="buttonbold13" id="Close"  value="Close"   accesskey="c"  onClick="redirect('PaymentCommitment.jsp')"></td>
                  </tr>
             </table>
		
			
			</td>
	</tr>
</table>
<p>
  <script language="JavaScript">


function checkCommitment(ctr ,   salesamount)
{
	var textamount = parseFloat(document.getElementById(ctr ).value);
	var actualamount = parseFloat(salesamount);
	if((textamount>actualamount))
	{
		alert("Kindly check your commitment amount...");
		document.getElementById(ctr).focus();
	}	
}

function CommitmentUpdate(ctr)
{
	 
	var ramount = parseInt(document.getElementById("ramount"+ctr ).value);
	var rowid=(document.getElementById("rowid"+ctr ).value);
	var saleno=(document.getElementById("salno"+ctr ).value);
	var rdate=(document.getElementById("rdate"+ctr ).value);
	var desc=(document.getElementById("desc"+ctr ).value);
	if(ramount<1) 
	{
		alert("Received Amount Should not be Zero...")
		document.getElementById("ramount"+ctr ).focus();
	}
	 
	if( DateCompares("rdate"+ctr ,"cdate"+ctr," Received Date Cannot be Greater Than Commitment date...") && (ramount>0)  )
	{
			var d ="../SmartLoginAuth?filename=PaymentCommitment&actionS=INVPaymentCommitmentUpdate&rowid="+rowid+"&rdate="+rdate+"&desc="+desc+"&ramount="+ramount+"&saleno="+saleno;
			document.frm.action=""+d; 
			document.frm.submit(); 
	}
	else
	{
	 	return false;
	}	
}


function CommitmentCancel(ctr)
{
	 
	Printquery("PaymentCommitmentPostponse.jsp?rowid="+document.getElementById("rowid"+ctr ).value)
	//PaymentCommitmentPostponse.jsp
}


function CommitmentDelete(ctr)
{
	var rowid=(document.getElementById("rowid"+ctr ).value);
	var d ="../SmartLoginAuth?filename=PaymentCommitment&actionS=INVPaymentCommitmentDelete&rowid="+rowid+"&salno=<%=salno%>";
	document.frm.action=""+d; 
	document.frm.submit(); 
}

   </script> 
  <%@ include file="../footer.jsp"%>
  </form>
  
  <%
  }
catch(Exception e)
{
	out.println(e.getMessage());
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

<%@ page import="com.my.org.erp.common.CommonFunctions"%>
 
<%@ page import="java.io.*,java.util.*"%>

<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>


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
<script language="javascript" src="../JavaScript/Numericfunctions.js"></script>
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script language="javascript" src="../JavaScript/Inventory/PurchaseRequestDate.js"></script>
<script>
	 

 $(function() {
		var dates = $( "#fromdate, #todate" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,maxDate: "+0D" ,
			changeMonth: true,maxDate: "+0D" ,
			changeYear: true,
			maxDate: "+0D" ,showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true,
			onSelect: function( selectedDate ) {
				var option = this.id == "fromdate" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(
						instance.settings.dateFormat ||
						$.datepicker._defaults.dateFormat,
						selectedDate, instance.settings );
				dates.not( this ).datepicker( "option", option, date );
			}
		});
	});

	</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">

<body>
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" action="../SmartLoginAuth" method="post" onSubmit="return valid()">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
	  <td>
	  
	  
	  
	  </td>
	</tr>
	<tr>
		<td>
		
		<%
try
{
 %>
		
		<table width="95%" height="150" border="0" align="center"
	cellpadding="2" cellspacing="2">
    
          <tr>
            <td>
			<%
   
   				String fromdate = request.getParameter("fromdate");
				String todate = request.getParameter("todate"); 
				String vendor = request.getParameter("vendor");
				String Branch = request.getParameter("Branch");
				String division=request.getParameter("division");
				String creditto = request.getParameter("creditto"); 
				
				String refsql="";
				 	 		
				String divsql="";
				if(!"0".equals(division))
					divsql=" AND d.INT_DIVIID="+division+" ";
				 
				String sql="";
				String fdt=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdate);
				String tdt=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate);
				String mode="VENDOR PURCHASE";
				
				sql = "SELECT a.CHR_VENDORPO vendorno, DATE_FORMAT(a.DAT_ORDERDATE,'%e-%M-%Y') purdate, FUN_INV_GET_VENDORNAME(a.INT_VENDORID) vendor,    "; 
				sql = sql + " SUM(a1.DOU_TOTAL - a1.DOU_TAX_AMOUNT) beforetax, a.DOU_TOTALAMOUNT netamount, b.DOU_PAIDAMOUNT tdsamount,c.CHR_DEPOSITNAME tds,    "; 
				sql = sql + " b.CHR_DDNUMBER tdsP, b.DAT_PAYMENTDATE tdsdate, FIND_A_EMPLOYEE_NAME_ONLY(a.CHR_REF) manager1,FIND_A_EMPLOYEE_NAME_ONLY(a.CHR_REF) manager2, "; 
				sql = sql + "  b.INT_PAYMENTID, b.DOU_TDS_RECEIVED_AMOUNT,   ( b.DOU_PAIDAMOUNT - b.DOU_TDS_RECEIVED_AMOUNT) balance ,a.CHR_PURCHASEORDERNO ,  "; 
				sql = sql + "  IF(b.DOU_TDS_RECEIVED_AMOUNT>0, 'Y', 'N') ";
				sql = sql + " from inv_t_directpurchase a, inv_t_directpurchaseitem a1, inv_t_vendorpurchasepayment b, com_m_deposit_to c,inv_m_division d    "; 
				sql = sql + " WHERE a.CHR_CANCEL ='N' AND a.DOU_TOTALAMOUNT >0   "; 
				sql = sql + " AND a.CHR_PURCHASEORDERNO = a1.CHR_PURCHASEORDERNO AND a.CHR_PURCHASEORDERNO= b.CHR_PURCHASEORDERNO    "; 
				sql = sql + " AND a.INT_DIVIID=d.INT_DIVIID    "; 
				if(!"0".equals(division))
					sql = sql +" AND a.INT_DIVIID="+division+" ";
				if(!"0".equals(Branch))
					sql = sql +" AND a.INT_BRANCHID="+Branch+" ";
				if(!"0".equals(division))
					sql = sql +" AND a.INT_DIVIID="+division+" ";
				if(!"0".equals(vendor))
					sql = sql +" AND a.INT_VENDORID="+vendor+" ";
					
				sql = sql + " AND b.INT_BANKID =  "+creditto;
				sql = sql + " AND c.INT_DEPOSITID =  "+creditto; 
				
				sql = sql + " AND a.DAT_ORDERDATE<='"+tdt+"' AND a.DAT_ORDERDATE>='"+fdt+"' ";
				sql = sql + " GROUP BY a.CHR_PURCHASEORDERNO ORDER BY a.DAT_ORDERDATE DESC    "; 
  
				//out.println(sql); 
				String reportheader="TDS PAYABLE FOR  "+mode+"   [ FROM -"+fromdate +"  TO-  "+ todate +" ] "; 
			  	out.println("<br><br>");
				String data[][] = CommonFunctions.QueryExecute(sql);
	
	
		 
	
	if(data.length>0)
	{
		 
		out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<TR class='MRow1'  >");
		out.println("<Td  colspan=16 class='boldEleven'><center><b>TDS PAYABLE UPDATE</center></td></tr>");
		out.println("<TR class='MRow1'  >");
		out.println("<Td colspan=13 class='boldEleven'><center><b> &nbsp; </b></center></td>");
		out.println("<Td colspan=3 class='boldEleven'>&nbsp;");
		%>
                <table width="169" height="22" border="0" cellpadding="0" cellspacing="0" align="center">
                  <tr>
                    <td width="20" class="boldEleven"><label>
                      <input id="Astatus" name="status" type="checkbox" value="A" onClick="Acceptall('Astatus')" >
                    </label></td>
                    <td width="69" class="boldEleven">Paid all</td>
                    <!--<td width="20" class="boldEleven"><input name="Rstatus" id="Rstatus" type="checkbox" value="R" onClick="Rjectall('Rstatus')" ></td>
                    <td width="60" class="boldEleven">Not Received all</td>-->
                  </tr>
                </table>
              <%
		out.println("</td></tr>");
		out.println("<TR>");
		
		
		out.println("<Th bgColor=#ffffff class='boldEleven'><b>Sl.No</b></Th>");
		out.println("<Th bgColor=#ffffff class='boldEleven'><b>PO NUMBER</b></Th>");
		out.println("<Th bgColor=#ffffff class='boldEleven'><b>PO DATE</b></Th>");
		out.println("<Th bgColor=#ffffff class='boldEleven'><b>VENDOR</b></Th>");
		out.println("<Th bgColor=#ffffff class='boldEleven'><b>BEFORE TAX </b></Th>");
        out.println("<Th bgColor=#ffffff class='boldEleven'><b>NET AMOUNT</b></Th>");
        out.println("<Th bgColor=#ffffff class='boldEleven'><b>TDS AMOUNT</b></Th>");
        out.println("<Th bgColor=#ffffff class='boldEleven'><b>TDS</b></Th>");
        out.println("<Th bgColor=#ffffff class='boldEleven'><b>TDS %</Th>");
        out.println("<Th bgColor=#ffffff class='boldEleven'><b>TDS DATE</b></Th>");
        out.println("<Th bgColor=#ffffff class='boldEleven'>&nbsp;</Th>"); 
		out.println("<Th bgColor=#ffffff class='boldEleven'><b>Pre Payable Amt</b></Th>");
		out.println("<Th bgColor=#ffffff class='boldEleven'><b>Payable Amt</b></Th>");
		//out.println("<Th bgColor=#ffffff class='boldEleven'><b>Received Amount2</b></Th>");
		out.println("<Th bgColor=#ffffff class='boldEleven'><b>Remarks</b></Th>"); 
		out.println("<Th bgColor=#ffffff class='boldEleven'><b>Payable Date</b></Th>"); 
		//out.println("<Th bgColor=#ffffff class='boldEleven'><b>&nbsp;</b></Th>"); 
		out.println(" </TR>");
		
		 
        double invamount=0;
		double tdsamount=0;
		double tdspaidamount=0;
		for(int u=0;u<data.length;u++)
		{
		 	 
			 
			if("Y".equals(data[u][15]))
			{
				out.println("<tr class='loginTable'>");
			}
			else {
				if(u%2==1)
					out.println("<tr class='MRow1'>");
				else
					out.println("<tr  class='MRow2'>");	
			 }
			 
			out.println("<td class='boldEleven'>"+(u+1) +"</td>");
			out.println("<td class='boldEleven'>"+data[u][0] +"</td>");
			out.println("<td class='boldEleven'>"+data[u][1] +"</td>");
			out.println("<td class='boldEleven'>"+data[u][2] +"</td>");
			out.println("<td class='boldEleven'>"+data[u][3] +"</td>");
			out.println("<td class='boldEleven' align='right'>"+data[u][4] +"</td>");
			out.println("<td class='boldEleven' align='right'>"+data[u][5] +"</td>");
			out.println("<td class='boldEleven' align='right'>"+data[u][6] +"</td>");
			out.println("<td class='boldEleven' align='right'>"+data[u][7] +"</td>");
			out.println("<td class='boldEleven' align='right'>"+data[u][8] +"</td>"); 
			 
			invamount=invamount+Double.parseDouble(data[u][4]);
			tdsamount=tdsamount+Double.parseDouble(data[u][5]);
			tdspaidamount=tdspaidamount+Double.parseDouble(data[u][12]);
			
			out.println("<td class='boldEleven' ><div id='adiv"+u+"'><input type='checkbox' id='accept"+u+"' name='accept"+u+"' value='A'  onclick=Accept('accept"+u+"')>Paid</div>  ");
			//out.println("<div id='rdiv"+u+"'><input type='checkbox' id='reject"+u+"' name='reject"+u+"' onclick=Reject('reject"+u+"')  value='R'  disabled>Not Received </div>");
			out.println("<input type='hidden' name='tdsamount"+u+"' id='tdsamount"+u+"' value='"+data[u][5]+"'>");
			out.println("<input type='hidden' name='salesno"+u+"' id='salesno"+u+"' value='"+data[u][14]+"'>");
			out.println("<input type='hidden' name='rowid"+u+"' id='rowid"+u+"' value='"+data[u][11]+"'>"); 
			out.println("<input type='hidden' name='pamount"+u+"' id='pamount"+u+"' value='"+data[u][12]+"'>"); 
			out.println("<input type='hidden' name='balance"+u+"' id='balance"+u+"' value='"+data[u][13]+"'>"); 
			//out.println("<input name='dec"+u+"' type='text' class='formText135' id='dec"+u+"' size='15' maxlength='100'>");
			out.println("</td>");
			
			out.println("<td class='boldEleven'  align='right'>"+data[u][12] +"</td>");
			
			out.println("<td class='boldEleven' >");
			out.println("<input name='ramount"+u+"' type='text' value='"+data[u][13] +"' class='formText135' id='ramount"+u+"' size='12' maxlength='10' onkeyup='extractNumber(this,2,true)' onkeypress='return blockNonNumbers(this, event, true, true);'>");
			
			
			out.println("</td>");
			//out.println("<td class='boldEleven' >");
			//out.println("<input name='rramount"+u+"' type='text' value='0'  class='formText135' id='rramount"+u+"' size='12' maxlength='10'>");
			//out.println("</td>");
			
			out.println("<td class='boldEleven' >");
			out.println("<input name='remark"+u+"' type='text' value='Paid' class='formText135' id='remark"+u+"' size='10' maxlength='100'>");
			out.println("</td>");
			//out.println("<td class='boldEleven' >;&nbsp;</td>");
			 
			out.println("<td class='boldEleven' >");
			
			out.println("<input name='opendate"+u+"' type='hidden' class='formText135' id='opendate"+u+"' onKeyPress='numericHypenOnly('opendate"+u+"',10)' size='10' maxlength='10' readonly='readonly'>");
			 
			 out.println("<script>setCurrentDate('opendate"+u+"'); </script>");
			 
			
			 
			//out.println("<input name='remark"+u+"' type='text' class='formText135' id='remark"+u+"' size='15' maxlength='100'>");
			out.println("</td>");
			
			//out.println("<td class='boldEleven' ><input type='checkbox' checked id='update"+u+"' name='update"+u+"' value='Y' >Update");
			
		}
		
		out.println("<tr>");
	  	out.println("<td bgColor=#ffffff class='boldEleven'><b>&nbsp;</b></Td>");
		out.println("<td bgColor=#ffffff class='boldEleven'><b>&nbsp;</b></Td>");
		out.println("<td bgColor=#ffffff class='boldEleven'><b>&nbsp;</b></Td>");
		out.println("<td bgColor=#ffffff class='boldEleven'><b>&nbsp;</b></Td>");
		out.println("<td bgColor=#ffffff class='boldEleven'><b>&nbsp; </b></Td>");
        out.println("<td bgColor=#ffffff class='boldEleven'><b>&nbsp;</b></Td>");
        out.println("<td bgColor=#ffffff class='boldEleven' align='right'><b>"+tdsamount+"</b></Td>");
        out.println("<td bgColor=#ffffff class='boldEleven'><b>&nbsp;</b></Td>");
        out.println("<td bgColor=#ffffff class='boldEleven'><b>&nbsp;</Td>");
        out.println("<td bgColor=#ffffff class='boldEleven'><b>&nbsp;</b></Td>");
        out.println("<td bgColor=#ffffff class='boldEleven'>&nbsp;</Td>"); 
		out.println("<td bgColor=#ffffff class='boldEleven' align='right'><b>"+tdspaidamount+"</b></Td>");
		out.println("<td bgColor=#ffffff class='boldEleven'><b>&nbsp;</b></Td>"); 
		out.println("<td bgColor=#ffffff class='boldEleven'><b>&nbsp;</b></Td>"); 
		out.println("<td bgColor=#ffffff class='boldEleven'><b>&nbsp;</b></Td>"); 
		 out.println("</tr>");
		 
		 
		out.println("</TABLE>");
	}
	else
	{
		out.println("<font  class='bolddeepred' ><center>Data not found</center></font> ");
	}
   %>
            </td>
          </tr>
          <tr>
            <td><table border="0" align="center" cellpadding="1"
									cellspacing="1">
                <tr>
					<td  ><span class="boldEleven">
					  <input name="filename" type="hidden" id="filename" value="TDSReceivable">
					  <input	name="actionS" type="hidden" id="actionS" value="INVTDSPayable">
					</span></td>
                  <td  ><input name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
                  <td ><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="javascirpt:window.close()"></td>
                </tr>
              </table></td>
          </tr>
          <tr>
            <td></td>
          </tr>
          <tr>
            <td ><div id="txt"></div></td>
          </tr>
          <tr>
            <td><input name='dec' type='hidden' class='formText135' id='dec' size='15' maxlength='100' value=<%= data.length%>></td>
          </tr>
        </table>
		
		 
		<%		 		 
			}
			catch(Exception e)
			{
			}	
	   %>
	  
	 
		
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

<script language="javascript" >
	function disabletxt()
	{
	
		var len=document.getElementById("dec").value;
		for(var i=0;i<len;i++)
		{
		  var fline="dec"+i;
		  document.getElementById(fline).style.visibility="hidden";
	    }
	}
	
	function Reject(ctr)
	{
		var len=document.getElementById(ctr).value;
		var l=ctr.substring(6);
		//var fline="dec"+l;
		var f ="accept"+l;
		f ="adiv"+l;
		if(document.getElementById(ctr).checked )
		{
			document.getElementById(f).style.visibility="hidden";
			//document.getElementById(fline).style.visibility="visible";
		}
		else
		{
			document.getElementById(f).style.visibility="visible";
			//document.getElementById(fline).style.visibility="hidden";
		}
	}

	function Accept(ctr)
	{
		var len=document.getElementById(ctr).value;
		var l=ctr.substring(6);
		//var fline="dec"+l;
		var f ="reject"+l;
		f ="rdiv"+l;
		if(document.getElementById(ctr).checked )
		{
			document.getElementById(f).style.visibility="hidden";
			//document.getElementById(fline).style.visibility="hidden";
		}
		else
		{
			document.getElementById(f).style.visibility="visible";
			//document.getElementById(fline).style.visibility="visible";
		}
	}

	
	function Acceptall(ctr)
	{
		var len=document.getElementById("dec").value;
		if(document.getElementById(ctr).checked)
		{
			//document.getElementById('Rstatus').style.visibility="hidden";
			for(var i=0;i<len;i++)
			{
		  		var fline="accept"+i;
				var fline1 ="adiv"+i;
				var f = "reject"+i;
				var f1 ="rdiv"+i;
				//var f0 = "dec"+i;
				document.getElementById(fline).checked=true;
				document.getElementById(fline1).style.visibility="visible";
		  		//document.getElementById(f).checked=false;
				//document.getElementById(f1).style.visibility="hidden";
				
				//document.getElementById(f0).style.visibility="hidden";
	    	}
		}
		else
		{
			
			//document.getElementById('Rstatus').style.visibility="visible";
			for(var i=0;i<len;i++)
			{
		  		var fline="accept"+i;
				var fline1 ="adiv"+i;
				var f = "reject"+i;
				var f1 ="rdiv"+i;
				//var f0 = "dec"+i;
				document.getElementById(fline).checked=false;
				document.getElementById(fline1).style.visibility="visible";
		  		//document.getElementById(f).checked=false;
				//document.getElementById(f1).style.visibility="visible";
				//document.getElementById(f0).style.visibility="hidden";
	    	}
		}
	}
	
	function Rjectall(ctr)
	{
		var len=document.getElementById("dec").value;
		if(document.getElementById(ctr).checked)
		{
			document.getElementById('Astatus').style.visibility="hidden";
			for(var i=0;i<len;i++)
			{
		  		var fline="accept"+i;
				var fline1 ="adiv"+i;
				var f = "reject"+i;
				var f1 ="rdiv"+i;
				
				//var f0 = "dec"+i;
				document.getElementById(fline).checked=false;
				document.getElementById(fline1).style.visibility="hidden";
		  		document.getElementById(f).checked=true;
				document.getElementById(f1).style.visibility="visible";
				//document.getElementById(f0).style.visibility="visible";
	    	}
		}
		else
		{
			document.getElementById('Astatus').style.visibility="visible";
			for(var i=0;i<len;i++)
			{
		  		var fline="accept"+i;
				var fline1 ="adiv"+i;
				var f = "reject"+i;
				var f1 ="rdiv"+i;
				//var f0 = "dec"+i;
				document.getElementById(fline).checked=false;
				document.getElementById(fline1).style.visibility="visible";
		  		document.getElementById(f).checked=false;
				document.getElementById(f1).style.visibility="visible";
				//document.getElementById(f0).style.visibility="hidden";
	    	}
		}
	}
	
function valid()
{
	var len=document.getElementById("dec").value;
	var acount=0;
	var rcount=0;
	for(var i=0;i<len;i++)
	 if(document.getElementById("accept"+i).checked)	  	
	 	acount=acount+1;
	
	 
	if((acount<=0) )
	{
		alert("Select Atleast One Claim from Accept ");
		return false;
	}	
	else
	{
		for(var i=0;i<len;i++){
			 
			 
			
				var ramount = parseFloat(document.getElementById("ramount"+i).value);
				var bamount = parseFloat(document.getElementById("balance"+i).value);
				var salesno = document.getElementById("salesno"+i).value;
				//var rramount = parseFloat(document.getElementById("rramount"+i).value);
				//alert( ramount +"/" + bamount);
				if(ramount > bamount )
				{
					alert("Kindly check the TDS Payable amount.  PO Number::"+salesno);
					//document.getElementById("ramount"+i).value="";
					document.getElementById("ramount"+i).focus();
					return false;
				}
			
		}
		
		return true;
	}	
}	

function focuss(ctr){
	document.getElementById(ctr).focus();
	ctr.focus();
}	

</script>

 <%@ include file="../footer.jsp"%></form>
</body>
</html>

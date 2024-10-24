 <%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%
try
{
%>
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
</head>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="JavaScript">

function Validate()
  {
	
 
	
	if( 
	 checkNullSelect( "customer","Select Customer Name" ,'0')
	 && checkNull( "desc","Enter Description " )
	 && checkNull( "date","Enter Date " )
	 && checkNull( "amount","Enter Amount " )
	 && AccountDateCheck()
	)
		return true;
	else
		return false;				
		
	
 } 	
 
   
 function AccountDateCheck()
 {
 	try
 	{
 		var date = document.getElementById('date').value;
		var fromdate='<%=""+session.getAttribute("ACCFROMDATE")%>';
		var todate='<%=""+session.getAttribute("ACCTODATE")%>';
 		var url = "../Account?actionS=LoadDateCheck&date="+escape(date)+"&todate="+todate+"&fromdate="+fromdate;
    	initRequest(url);
    	req.onreadystatechange=DateCheckRequest;
		req.open("GET", url, true);
    	req.send(null);
		var ch = document.getElementById('credit').value;
		if(ch == "true")
		{
			return true;
		}	
		else
		{
			return false;
		}	
		 
    	
    }
     
	catch(err)
	{
		
		alert(err.description);
		
	} 	
    
}
 
function DateCheckRequest() 
{
		if(req.readyState == 4) 
		{    	
			if (req.status == 200) 
			{		  	
			  DateCheckMessages();
			}
		}
}
	
	
function DateCheckMessages() 
{	 
   
   	 	var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
    	var str=""; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
		{	     
			var batch = batchs.childNodes[loop];
			var Field1 = batch.getElementsByTagName("Value")[0].childNodes[0].nodeValue;
			var fromdate = batch.getElementsByTagName("fromdate")[0].childNodes[0].nodeValue;
			var todate = batch.getElementsByTagName("todate")[0].childNodes[0].nodeValue;
			
			if(Field1 == "False")
			{
				alert("Kindly check date is not between "+fromdate+ "  to  "+todate);	
				document.getElementById('credit').value = "false";
			}
			else
				document.getElementById('credit').value = "true";
				
		}
	 	
	
}
 
</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<%@ include file="indexacct.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
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
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
			align="center" border="0">
      <tbody>
        <tr>
          <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
          <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
          <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
        </tr>
        <tr>
          <td height="6"><spacer height="1" width="1" type="block" /></td>
        </tr>
        <tr>
          <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
          <td width="6"><spacer height="1" width="1" type="block" /></td>
          <td width="412" valign="top">
		  <form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">
		    <table width="400" border="0" align="center" cellpadding="3" cellspacing="3">
              <tr>
                <td colspan="2" class="bold1"><div align="center">Credit Entry  
                    <%
							String action=request.getParameter("action1");
							String id="",Name="",actionS="",value="";
							String customer="", desc="",date="",amount="";
							String sql="";
							if("Add".equals(action))
							{
								id="";Name=""; customer="";desc="";date="";amount=""; 
								actionS="ACCCreditAdd";
								value="Add";
							}
							else
							{
								id="";Name="";
								id=request.getParameter("id");
								sql = " SELECT INT_CREDITID,INT_CUSTOMERID,DOU_AMOUNT,CHR_DESC,DATE_FORMAT(DAT_DATE,'%d-%m-%Y')   FROM acc_t_credit WHERE INT_CREDITID= "+id;
								String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								id=data[0][0];Name=data[0][1]; 
								customer=data[0][1];desc=data[0][3];date=data[0][4];amount=data[0][2];
								actionS="ACCCreditEdit";
								value="Update";
							}
							
						%>			
				
				</div></td>
                </tr>
              <tr>
                <td class="boldEleven"> Customer Name</td>
                <td class="boldEleven">
				 <select name="customer" id="customer">
				 <option value="0">Select</option>
				 <%
				String readData[][] =  com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_CUSTOMERID,CHR_CUSTOMERNAME FROM acc_m_customer ORDER BY CHR_CUSTOMERNAME");
				for(int u=0;u<readData.length;u++)
					out.println("<option value='"+readData[u][0]+"'>"+readData[u][1]+"</option>");
				 %>
				</select>
				<%
				if(!"Add".equals(action))
				{
				%>
				<script language="javascript" >setOptionValue('customer','<%=customer%>')</script>
				<%
				}
				%>	 				</td>
              </tr>
              <tr>
                <td valign="top" class="boldEleven">Description</td>
                <td valign="top" class="boldEleven"><textarea name="desc" cols="30" rows="5" class="formText135" id="desc"><%=desc%></textarea></td>
              </tr>
              <tr>
                <td class="boldEleven">Date</td>
                <td class="boldEleven"><input name="date" type="text" class="formText135"
									id="date"
									tabindex="2" value="<%=date%>" size="15" readonly="readonly">
                  <a
									href="javascript:cal2.popup();"> <img
									src="../JavaScript/img/cal.gif" width="16" height="16"
									border="0" /> </a>
                  <script language='JavaScript'
									type="text/javascript">
		<!--			
				//document.getElementById('saleDate').disabled=true;
				var cal2 = new calendar1(document.forms['frm'].elements['date']);
				cal2.year_scroll = true;
				cal2.time_comp = false;
				<%
				if("Add".equals(action))
				{
				%>
				setCurrentDate('date'); 
				<%
				}
				 
				%>
		//-->
                          </script></td>
              </tr>
              <tr>
                <td class="boldEleven">Amount</td>
                <td class="boldEleven"><input name="amount" type="text" class="formText135" id="amount"  value="<%=amount%>" maxlength="10"  style="text-align:right" onKeyPress="numericValue('amount','10')"></td>
              </tr>
              <tr>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">
				<input type="hidden" name="filename" value="Credit" />
                <input type="hidden" name="actionS"  value="<%=actionS%>" />
				<input name="id" type="HIDDEN" id="id" value="<%=id%>">				<input name="credit" type="hidden" id="credit" value="false"></td>
              </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                  <tr>
                    <td><input name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
                    <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('Credit.jsp')"></td>
                  </tr>
                </table></td>
                </tr>
            </table>
		  </form></td>
          <td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
          <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
        </tr>
        <tr>
          <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
          <td height="6"><spacer height="1" width="1" type="block" /></td>
          <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
        </tr>
        <tr>
          <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
        </tr>
      </tbody>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</html>
<%
}
catch(Exception e)
{
}
%>
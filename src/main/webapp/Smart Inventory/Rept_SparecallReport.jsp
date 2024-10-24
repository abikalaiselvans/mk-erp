 <%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>

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
<script language="javascript">
function validate()
{
	if(	
		checkNull("fromdate","Enter From Date")	
		&&checkNull("todate","Enter To Date")	
		&&checkNullSelect("servicecenter","Select Service Center","-1")	
		&&checkNullSelect("customerid","Select Customer","-1")	
	)	
		return true;	
	else
		return false;	
}
</script>


<script language="javascript">	

function LoadRuntimeCustomer(ctr)
{
 	try
 	{
 		
		var _targ=document.getElementsByName('customerid')[0];
    	_targ.options.length=0;	 
		var opt = document.createElement("option");
		document.getElementById("customerid").options.add(opt); 
       	opt.text = "All";
        opt.value = "0";	 
		
		
		var branch=document.getElementById('branch').value;	 
		var id = document.getElementById("servicecenter").value;
 		var url = "../inventory?actionS=LoadRuntimeCustomer&id="+escape(id)+"&branch="+branch;
		initRequest(url);
    	req.onreadystatechange=RuntimeCustomerRequest;
		req.open("GET", url, true);
    	req.send(null);
		//LoadServiceAMC('0')
    	
    }
     
	catch(err)
	{
		
		alert(err.description);
		
	} 	
    
}
 
function RuntimeCustomerRequest() 
{
		if(req.readyState == 4) 
		{    	
			if (req.status == 200) 
			{		  	
			  RuntimeCustomerMessages();
			}
		}
}
	
	
function RuntimeCustomerMessages() 
{	 
   
   	 	var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
		for(loop = 0; loop < batchs.childNodes.length; loop++) 
		{	     
			var batch = batchs.childNodes[loop];
			var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
			var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
			var opt = document.createElement("option");
			document.getElementById("customerid").options.add(opt); 
       		opt.text = Name;
        	opt.value = Id;
		}
		 
	 	
	
}  
 	

</script>
<body >
<%@ include file="indexinv.jsp"%>

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
	  <td><form name="frm" method="post" action="Rept_SparecallReportresponse.jsp" onSubmit="return validate()">
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="250"
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
				  <td width="412"><table width="500" border="0" cellspacing="2" cellpadding="2">
                    <tr>
                      <td colspan="2"><div align="center" class="bigusername">SPARE CALL REPORT </div></td>
                    </tr>
                    <tr>
                      <td width="82" class="boldEleven">From Date <span
									class="bolddeepred">* </span></td>
                      <td width="63%"><input
									tabindex="2" name="fromdate" type="text" class="formText135"
									id="fromdate" size="15" readonly="readonly">
                        <a
									href="javascript:cal2.popup();"> <img
									src="../JavaScript/img/cal.gif" width="16" height="16"
									border="0" /> </a>
                        <script language='JavaScript'
									type="text/javascript">
		<!--			
				//document.getElementById('saleDate').disabled=true;
				var cal2 = new calendar1(document.forms['frm'].elements['fromdate']);
				cal2.year_scroll = true;
				cal2.time_comp = false;
				setCurrentDate('fromdate'); 
		//-->
                          </script></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">To Date <span
									class="bolddeepred">* </span></td>
                      <td><input tabindex="2"
									name="todate" type="text" class="formText135" id="todate"
									size="15" readonly="readonly">
                        <a
									href="javascript:cal3.popup();"> <img
									src="../JavaScript/img/cal.gif" width="16" height="16"
									border="0" /> </a>
                        <script language='JavaScript'
									type="text/javascript">
		<!--			
				//document.getElementById('saleDate').disabled=true;
				var cal3 = new calendar1(document.forms['frm'].elements['todate']);
				cal3.year_scroll = true;
				cal3.time_comp = false;
				setCurrentDate('todate'); 
		//-->
                          </script></td>
                    </tr>
                    <tr>
                      <td valign="top" class="boldEleven">Branch</td>
                      <td><select name="branch" id="branch"  class="formText135"     onChange="LoadRuntimeCustomer('servicecenter')" >
                              <option value="0">All</option>
                              <%
			   	String branchid=""+session.getAttribute("INVCOMPANY"); 
				String sq=" Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID and  a.INT_BRANCHID not in("+Integer.parseInt(branchid)+")";
String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sq);
				for(int u=0; u<shipids.length; u++)
					out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+ "  @  " +shipids[u][1] +"</option>");
						 
			   %>
                            </select></td>
                    </tr>
                    <tr>
                      <td valign="top" class="boldEleven">Service Center  <span
									class="bolddeepred">* </span></td>
                      <td><span class="copyright style3">
               <select name="servicecenter" class="formText135"  id="servicecenter"    onChange="LoadRuntimeCustomer('servicecenter')">
                         <option value="0">All</option>
                          <%
				String readDatas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_SERVICECENTERID,CHR_CENTERNAME,CHR_SHORTNAME FROM  inv_m_servicecenter ORDER BY CHR_CENTERNAME");
				for(int u=0;u<readDatas.length;u++)
					out.println("<option value="+readDatas[u][0]+">"+readDatas[u][1]+"</option>");
				%>
                      </select>
                      </span></td>
                    </tr>
                    <tr>
                      <td valign="top" class="boldEleven">Customer Group </td>
                      <td><select name="Customergroup" class="formText135"  id="Customergroup" >
                         <option value="0">All</option>
                          <%
				String readDatass[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_GROUPID,CHR_GROUPNAME FROM inv_m_servicecustomergroup  WHERE INT_BRANCHID="+""+session.getAttribute("BRANCHID") +" ORDER BY CHR_GROUPNAME");
				for(int u=0;u<readDatass.length;u++)
					out.println("<option value="+readDatass[u][0]+">"+readDatass[u][1]+"</option>");
				%>
                        </select></td>
                    </tr>
                    <tr>
                      <td valign="top" class="boldEleven">Customer
                        Name  <span
									class="bolddeepred">* </span></td>
                      <td><span class="boldEleven">
                        <select name="customerid" id="customerid" class="formText135" >
                          <option value="0">All</option>
                      </select>
                      </span></td>
                    </tr>
                    <tr>
                      <td height="17" class="boldEleven">Call Status </td>
                      <td height="17" class="boldEleven"><select name="callstatus" id="callstatus">
                          <option value="0" selected="selected">All</option>
                          <option value="1">Pending for Spare</option>
                          <option value="2">Pending for Response</option>
                          <option value="3">Pending for Customer</option>
                          <option value="4">Under Observation</option>
                          <option value="5">Closed</option>
                        </select>                      </td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Spare Call </td>
                      <td>
					  <select name="sparecall" class="formText135" id="sparecall">
                      <option value="0">All</option>
					  <option value="Y">Spare</option>
					  <option value="N">Not Spare</option>
					  </select>                      </td>
                    </tr>
                    <tr>
                      <td colspan="2"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                        <tr>
                          <td><input name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
                          <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('Rept_Servicereport.jsp')"></td>
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
		</table>	</form>  </td>
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

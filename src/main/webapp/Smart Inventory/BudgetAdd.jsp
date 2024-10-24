<%@ page import="java.io.*,java.util.*"%>

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

<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
function validate()
{
	if(
		checkNullSelect('dept','Select Department','0') 
		&& checkNullSelect('select','Select Accessories ','0') 
		&& checkNull('year','Select Budget year') 
		&& checkNull('amount','Enter Budget Amount') 
		&& BudgetCheck() 
	
	)
		return true;
	else
		return false;
		

}


   
 function BudgetCheck()
 {
 	try
 	{
 		var dept = document.getElementById('dept').value;
		var access = document.getElementById('select').value;
		var year = document.getElementById('year').value;
		var url = "../inventory?actionS=INVBudgetCheck&dept="+escape(dept)+"&access="+access+"&year="+year;
		initRequest(url);
    	req.onreadystatechange=BudgetCheckRequest;
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
 
function BudgetCheckRequest() 
{
		if(req.readyState == 4) 
		{    	
			if (req.status == 200) 
			{		  	
			  BudgetCheckMessages();
			}
		}
}
	
	
function BudgetCheckMessages() 
{	 
   
   	 	var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
    	var str=""; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
		{	     
			var batch = batchs.childNodes[loop];
			var Field1 = batch.getElementsByTagName("Value")[0].childNodes[0].nodeValue;
			if(Field1 == "True")
			{
				alert("Already budget assigned ");	
				document.getElementById('credit').value = "false";
			}
			else
				document.getElementById('credit').value = "true";
				
		}
	 	
	
}
 
 
</script>
<body    onLoad="document.getElementById('amount').focus()">
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
    <td><form  AUTOCOMPLETE = "off"   name="form1" method="post" action="../SmartLoginAuth" onSubmit=" return validate()">
    
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
            <td width="412"><table cellspacing="2" cellpadding="2" width="184" align="center"
						border="0">
                <!--DWLayoutTable-->
                <tbody>
                  <tr>
                    <td height="16" align="center" valign="top"
									class="boldThirteen"></td>
                  </tr>
                  <tr>
                    <td height="17" class="boldEleven"><div align="center" class="boldThirteen">Budget Assign </div></td>
                  </tr>
                  <tr>
                    <td height="17" class="boldEleven"><table width="400" border="0" align="center" cellpadding="4" cellspacing="4">
                      <tr>
                        <td class="bold1"><strong>Department</strong></td>
                        <td><select name="dept" class="formText135"	id="dept" tabindex="1"  >
						<option value="0">Select</option>
                          <%
			String deptsql="SELECT INT_DEPARTID,CHR_DEPARTNAME FROM com_m_depart ORDER BY INT_DEPARTID";
			String deptdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(deptsql);
			for(int x=0;x<deptdata.length;x++)
				out.println("<option value='"+deptdata[x][0]+"'>"+deptdata[x][1]+"</option>");
			%>
                        </select></td>
                      </tr>
                      <tr>
                        <td class="bold1"><strong>Accessories</strong></td>
                        <td><select name="select" class="formText135"	id="select" tabindex="1"  >
                          <option value="0">Select</option>
                          <%
						String accdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_GROUPID,CHR_GROUPNAME,CHR_DESC FROM  inv_m_accessoriesgroup  ORDER BY CHR_GROUPNAME");
			for(int x=0;x<accdata.length;x++)
				out.println("<option value='"+accdata[x][0]+"'>"+accdata[x][1]+"</option>");
				
						%>
                        </select></td>
                      </tr>
                      <tr>
                        <td class="bold1">Year</td>
                        <td><select name="year" class="formText135" id="year">
                          <%@ include file="../JavaScript/Inventory/year.jsp"%>
                        </select>
                          <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('year',year1);							
				//-->
                                    </script></td>
                      </tr>
                      <tr>
                        <td class="bold1">Budget Amount </td>
                        <td><input name="amount" type="text" class="formText135" id="amount" onKeyPress="doubleValue('amount','6')" size="6" style='text-align:right'>
                          <span class="boldred">* </span> In terms of lakhs.</td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="17" class="boldEleven"><font size="1"><strong><font
										color="#000000"><font size="1"><strong><font
										color="#000000"><font size="1">
                      <input
										type="hidden" name="filename" value="BudgetAssign" />
                      <strong><font
										color="#000000"><font size="1">
                      <input
										type="hidden" name="actionS" value="INVBudgetAssign" />
                      <input name="credit" type="hidden" id="credit" value="false">
                      </font></font></strong></font></font></strong></font></font></strong></font></td>
                  </tr>
                  <tr>
                    <td height="17" class="boldEleven"><table border="0" align="center" cellpadding="2"
										cellspacing="2">
                      <tr>
                        <td width="56">
<input type="submit" name="Submit"	id="submit_btn" class="buttonbold" value="Submit"   accesskey="s"    /></td>
                        <td width="56">
<input type="button" name="submit" class="buttonbold"  value="Close"   accesskey="c" 	onClick="redirect('BudgetAssign.jsp')" /></td>
                      </tr>
                    </table></td>
                  </tr>
                </tbody>
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
	  </form>
	  
    </td>
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

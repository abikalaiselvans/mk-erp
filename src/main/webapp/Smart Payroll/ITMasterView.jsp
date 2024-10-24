<%@ page
	import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
<%@ include file="index.jsp"%>
<%!
	ArrayList empdata = new ArrayList();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>:: PAYROLL ::</title>

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

<style type="text/css">
<!--
a:visited {
	color: #663366;
}
a:hover {
	color: #FF0000;
}
a:active {
	color: #0000FF;
}
-->
</style>
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/Payroll/PayrollAjax.js"></script>
<script language="javascript">
function Edit()
{		
  var count=0;
 	    sel=document.forms[0].id;
 	    for(i=0;i<sel.length;i++)
 	    {
 	         if(sel[i].checked)
 	         count=count+1;  
 	    } 
 	    if(count==0)
 	    {
 	      if (document.forms[0].id.checked) 
 	       { count=1;} 	    
 	       else
				return false;
 	    }
 	    if(count>1)
 	    {
 	       alert("Select One Record to Edit");
 	       return false;
 	    }
 	    if(count==1)
 	    {
		document.EmployeeCessationfrm.action="ITMasterEdit.jsp";
		document.EmployeeCessationfrm.submit();
		return true;
		}
 	}

	function Add()
 	{		
		document.EmployeeCessationfrm.action="ITMasterAdd.jsp";		
 	}		

	function Delete()
 	{		
		var count;
		count=0;
		c1=document.forms[0].id
		txt=""
		for (i=0;i<c1.length;++ i)
		{
			if (c1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].id.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.EmployeeCessationfrm.action="../SmartLoginAuth";
				document.EmployeeCessationfrm.submit();
				return true;			
			}
			else
				return false;
		}
		else
		{
		    alert("Select Atleast One Value");
		    return false;
		}		
 	}
	
	
	
function loadITMaster()
{
	var financial 	= 	document.getElementById('financial').value;
    var gender 		=	document.getElementById('gender').value;
	var url = "../Payroll?actionS=PAYITMaster&financial="+financial+"&gender="+gender;
    initRequest(url);
    req.onreadystatechange = ITMasterRequest;
    req.open("GET", url, true);
    req.send(null);
}
function ITMasterRequest()
{LoadingTab('CessationTable');	
    if(req.readyState == 4) 
    {    ClearTab('CessationTable');  
        document.getElementById('btnEdit').disabled=true ;
        document.getElementById('btnDelete').disabled=true;
        if (req.status == 200) 
        {		  	
          	var loop=0;
		  	var batchs = req.responseXML.getElementsByTagName("ITMS")[0];
			var str="";
			str=str+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >";
			var tot = batchs.childNodes.length;
			for(loop = 0; loop < batchs.childNodes.length; loop++) 
			{           		                           
			    var batch1 = batchs.childNodes[loop];
		        var Staffid = batch1.getElementsByTagName("id")[0]; 
		    	var Staffname = batch1.getElementsByTagName("from")[0];
		    	var all = batch1.getElementsByTagName("to")[0];
		    	var rec = batch1.getElementsByTagName("cal")[0];    	
		    	var amo = batch1.getElementsByTagName("amount")[0];
		    	var pre = batch1.getElementsByTagName("precent")[0];    	
		    	if(loop%2==1)
					str=str+"<tr class='MRow2'>";
				else
				    str=str+"<tr  class='MRow1'>";
				
				
				str=str+"<td   class='boldEleven'>&nbsp;<input type='checkbox' name='id' id='id' value='"+Staffid.childNodes[0].nodeValue+"'>&nbsp;"+(loop+1);
				str=str+"<td  class='boldEleven' align='right'>&nbsp;<a href='ITMasterEdit.jsp?id="+Staffid.childNodes[0].nodeValue+"'><font class='boldEleven'><font color='blue'>"+Staffname.childNodes[0].nodeValue
				str=str+"<td  class='boldEleven' align='right'>&nbsp;"+all.childNodes[0].nodeValue;
				if(rec.childNodes[0].nodeValue=="Y")
				str=str+"<td  class='boldEleven' align='center'>&nbsp;Yes";
				else
				str=str+"<td  class='boldEleven' align='center'>&nbsp;No";				
				str=str+"<td  class='boldEleven' align='right'>&nbsp;"+amo.childNodes[0].nodeValue;
				str=str+"<td  class='boldEleven' align='center'>&nbsp;"+pre.childNodes[0].nodeValue;
				str=str+"</td></tr>";
				
			}
			str=str+"</table>";
			
			var tb=document.getElementById('CessationTable');
			if(loop>0)
			{
				document.getElementById('btnEdit').disabled=false;
				document.getElementById('btnDelete').disabled=false;
	  			tb.innerHTML=str;  
	  		}
	  		else
	  		{
		  		ClearTab('CessationTable');  
		        document.getElementById('btnEdit').disabled=true ;
		        document.getElementById('btnDelete').disabled=true;
	  		}
  	
  			/*var tbs=document.getElementById('totrec');
  			tbs.innerHTML="<font color='#000000'>Total Records :: "+tot+"</font>"; */
        }
    }
}
	
	
</script>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onLoad="loadITMaster()">
<form  AUTOCOMPLETE = "off"   method="get" name="EmployeeCessationfrm">
<table width="100%" height="285" align="center">


	<tr>
		<td height="151" align="center"><br>
		<table width="90%" height="120" border="1" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<!--DWLayoutTable-->
			
			<tr align="center" valign="middle" >
				<td height="28"  
					 ><div align="center" class="whiteMedium">Income Tax Master </div></td>
			</tr>

			<tr  >
			  <td height="31" align="center" valign="middle"  ><table width="827" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
                <tr>
                  <th width="114"   scope="col">Year </th>
                  <th width="126" scope="col"><div align="left">
                    <select name="financial"   id="financial" onChange="loadITMaster()">
                      <option value="0">Select Year</option>
                      <%
								    String data[][]=com.my.org.erp.common.CommonFunction.RecordSetArray("select INT_FINANCIALYEARID,CHR_FINANCIALYEAR from com_m_financialyear ");
								    for(int i=0;i<data.length;i++)
								    	out.println("<option value="+data[i][0]+">"+data[i][1]+"</option>");
								    %>
                    </select>
                  </div></th>
                  <th width="68"   scope="col">Gender </th>
                  <th width="111" scope="col"><div align="left">
                    <select name="gender"   id="gender" onChange="loadITMaster()">
                      <option value="0" selected>Select Gender</option>
                      <option value="M">Male</option>
                      <option value="F">Female</option>
					  <option value="S">Senior Citizens (> 60 Years but less than 80 Years)</option>
					  <option value="V">Very Senior Citizens (80 Years and above)</option>
                    </select>
                  </div></th>
                </tr>
              </table></td>
		  </tr>
			<tr  >
				<td height="31" align="left" valign="middle"  >
				<table width="100%" border="0" class="whiteMedium"
					  >
					<tr>

						<td width="97" align="center">Sl.No</td>
						<td width="260" align="center">From</td>
						<td width="162" align='Center'>To</td>
						<td width="152" align='Center'>Calculation</td>
						<td width="129" align='Center'>Amount</td>
						<td width="144" align='Center'>Precentage (%) </td>
					</tr>
				</table>				</td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td height="28" valign="top">
			  <div id="CessationTable" style="OVERFLOW: auto;width:100%;height:180px"></div><br>				</td>
		</table>		</td>
	</tr>
	
	<tr>
		<td height="17">
		  <input name="filename" type="hidden"
			id="filename" value="ITMaster">
          <input name="actionS"
			type="hidden" id="actionS" value="PAYITMasterDelete"></td>
	</tr>
	<tr>
		<td height="17" align="center">
		<center>
		<table border="0" cellspacing="1" cellpadding="1">
			<tr>
				<td width="56"><input class="ButtonHead" name="submit2"
					type="submit" onClick="Add()" value="Add"></td>
				<td width="56"><input class="ButtonHead" name="submit3"
					type="submit" id="btnEdit"  onClick="Edit()" value="Edit"></td>
				<td width="56"><input class="ButtonHead" name="submit3"
					type="submit" id="btnDelete" onClick="Delete()" value="Delete"></td>
				<td width="56"><input class="ButtonHead" type="Button"
					name="Button"  value="Close"   accesskey="c"  onClick="redirect('Payrollmain.jsp')"></td>
			</tr>
		</table>
	<tr>
		<td height="20"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</body>
</html>

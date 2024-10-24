<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.*"%>
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

<style type="text/css">
<!--
.style4 {font-weight: bold}
.style5 {font-weight: bold}
-->
</style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
<script language="javascript" src="../JavaScript/Inventory/noncustomer.js"></script>
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="ServiceCustomerInfoAdd.jsp";
 	}
	
	function IEdit()
 	{		 
		var count;
		count=0;
		coffee1=document.forms[0].custid
		txt=""
		for (i=0;i<frm.length;++ i)
		{
			if (frm[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].custid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="ServiceCustomerInfoEdit.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
		
 	}	
 	
	
	function Delete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].custid
		txt=""
		for (i=0;i<frm.length;++ i)
		{
			if (frm[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].custid.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
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
 	
	function PageBack()
	{
	     //future enhancement
    }
 	
	
  function Validate()
  {
    if(checkNullSelect("company","Select the Company","select"))
		return true;
	else
		return false;		
  }	
  
  
  
  
  	
function LoadRuntimeNonCustomerGroup(ctr)
{
 	try
 	{
 		var  branch = document.getElementById('branch').value;
		var id = document.getElementById('servicecenter').value;
 		var url = "../inventory?actionS=LoadRuntimeNonCustomerGroup&id="+escape(id)+"&branch="+branch;
    	initRequest(url);
    	req.onreadystatechange=RuntimeNonCustomerGroupRequest;
		req.open("GET", url, true);
    	req.send(null);
	}
     
	catch(err)
	{
		alert(err.description);
	} 	
    
}
 
function RuntimeNonCustomerGroupRequest() 
{
		if(req.readyState == 4) 
		{    	
			if (req.status == 200) 
			{		  	
			  RuntimeNonCustomerGroupMessages();
			}
		}
}
	
	
function RuntimeNonCustomerGroupMessages() 
{	 
   
   	var batchs = req.responseXML.getElementsByTagName("Rows")[0]; 
    var _targ=document.getElementsByName('group')[0];       
    _targ.options.length=0;
    _targ.options[0]=new Option('All','0');  
    var str=""; 
    
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {	     
        var batch = batchs.childNodes[loop];
        var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
	    var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
		_targ.options[loop+1]=new Option(Name,Id);
		
    }
		
	
}
 
   
  
</script>
<body    ><!--onLoad="LoadNoncustomer('0')"-->
<%@ include file="indexinv.jsp"%>

   <form  AUTOCOMPLETE = "off"   name="frm" method="post" action="">
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
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
	 
	  	  <table width="90%" height="201" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
        <tr  >
          <td height="22"  ><div align="center"><span class="boldThirteen"> Service Customer info </span> </div>
              <div align="right"></div></td>
        </tr>
        <tr  >
          <td height="25"  >
		  
		  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
            <tr>
              <td width="85" class="boldThirteen">Branch </td>
              <td width="85"  >
			  
			  <select name="branch" id="branch"     onChange="LoadRuntimeNonCustomerGroup('servicecenter')"  class="formText135" >
                
                <%
			   	String branchid=""+session.getAttribute("INVBRANCH"); 
				String suertype=""+session.getAttribute("USRTYPE"); 
				if("F".equals(suertype) )  
				{
					out.println("<option value='0'>All</option>");								
					String sq=" Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID  ";
					String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sq);
					for(int u=0; u<shipids.length; u++)
						out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+ "  @  " +shipids[u][1] +"</option>");
				}
				else
				{
					
					String sq=" Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID and  a.INT_BRANCHID = "+branchid;
					String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sq);
					for(int u=0; u<shipids.length; u++)
						out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+ "  @  " +shipids[u][1] +"</option>");
				}	
				 
			   %>
              </select></td>
              <td width="85"  ><strong>Service Center </strong></td>
              <td width="176"  >
			    <strong>
			    <select name="servicecenter" class="formText135"  id="servicecenter"  onChange="LoadRuntimeNonCustomerGroup('servicecenter')" onBlur="LoadNoncustomer('0')"  >
			     <option value="0">All</option>
				 <%
				String readDatas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_SERVICECENTERID,CHR_CENTERNAME,CHR_SHORTNAME FROM  inv_m_servicecenter ORDER BY CHR_CENTERNAME");
				for(int u=0;u<readDatas.length;u++)
					out.println("<option value="+readDatas[u][0]+">"+readDatas[u][1]+"</option>");
				%>
			        </select>
			    </strong> </td>
              <td width="108"  ><strong>Customer Group</strong></td>
              <td width="331"  ><select name="group" class="formText135 style5" id="group" onChange="LoadNoncustomer('0')" >
			  	<option value="0">All</option>
				
              </select>              </td>
            </tr>
          </table>		  </td>
        </tr>
        <tr  >
          <td height="25"  >
	
		  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
			<tr  >
  				<td width="15%"   ><b>S.No</b></td>
    			<td width="43%"   ><b>Name</b> </td>
    			<td width="14%"   ><b>Phone</b></td>
    			<td width="14%"   ><b>Mobile</b></td>
   				<td width="14%"   ><b>E-mail</b></td>
			</tr> 
		  </table>		  </td>
        </tr>
        <tr class="MRow1">
          <td height="127" valign="top"  >
		  
		 
				<div id="divscroll" style="OVERFLOW:auto;width:100%;height:300px" 	 > </div>
				<br>
				<div align="center" id="totRec"></div>
				<br>				 </td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td>	  </td>
    </tr>
    <tr>
      <td height="10">&nbsp;</td>
    </tr>
    <tr>
      <td><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
        <tr class="para">
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('0')">All</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('A')">A</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('B')">B</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('C')">C</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('D')">D</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('E')">E</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('F')">F</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('G')">G</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('H')">H</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('I')">I</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('J')">J</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('K')">K</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('L')">L</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('M')">M</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('N')">N</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('O')">O</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('P')">P</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('Q')">Q</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('R')">R</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('S')">S</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('T')">T</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('U')">U</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('V')">V</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('W')">W</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('X')">X</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('Y')">Y</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadNoncustomer('Z')">Z</a></div></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td height="10"><input name="filename" type="hidden" value="ServiceCustomerInfo" />
        <input name="actionS" type="hidden" value="INVServiceCustomerInfoDelete" /></td>
    </tr>
    <tr>
      <td><table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
        <!--DWLayoutTable-->
        <tr>
          <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1"  value="Add"   accesskey="s"   onClick="Add()" /></td>
          <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="Edit" id="Edit" value="Edit"
					onclick="return IEdit()" /></td>
          <%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
          <td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="Submit3" value="Delete"
					onclick="return Delete()" /></td>
          <% 
		}
		%>
          <td width="56"><input type="button" class="ButtonHead"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')" /></td>
        </tr>
      </table></td>
    </tr>
</table>
  </form>
<%@ include file="../footer.jsp"%>
</body>
</html>
<%
}
catch(Exception e)
{
}

%>
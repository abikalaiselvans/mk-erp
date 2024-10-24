<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<%@ page import="com.my.org.erp.common.*"%>
<%
try
{
%>
<html>
<head>

<title> :: AMC ::</title>

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

 
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/AMC/amccustomer.js" ></script>
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="ServiceCustomerInfoAdd.jsp";
 	}
	
	function IEdit()
 	{		 
		
		
		obj = findObj("custid"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}



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
		
		
		obj = findObj("custid"); 
		if(obj == null)
		{
			alert("Delete not available");
			return false;
		}


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
  
  
  
</script>
<body    onLoad="LoadAMCCustomer('0')"><!--onLoad="LoadAMCCustomer('0')"-->
<%@ include file="index.jsp"%>

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
          <td height="22"  ><div align="center"><span class="boldThirteen"> AMC CUSTOMER INFORMATIONS </span> </div>
              <div align="right"></div></td>
        </tr>
        <tr  >
          <td height="25" align="center"  >
		  
		  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="2" class="whiteMedium">
            
            <tr>
              <td width="66"  >Branch </td>
              <td width="300"  >
			  
			  <select name="branch" id="branch"     onChange="LoadRuntimeNonCustomerGroup('servicecenter')" onBlur="LoadAMCCustomer('0')"  class="formText135" style="width:200px" >
                
                <%
			   	String branchid=""+session.getAttribute("AMCBRANCH"); 
				String suertype=""+session.getAttribute("USRTYPE"); 
				if("F".equals(suertype) )  
				{
					out.println("<option value='0'>All</option>");								
					String sq=" Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID  ";
					String shipids[][] =  CommonFunctions.QueryExecute(sq);
					for(int u=0; u<shipids.length; u++)
						out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+ "  @  " +shipids[u][1] +"</option>");
				}
				else
				{
					
					String sq=" Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID and  a.INT_BRANCHID = "+branchid;
					String shipids[][] =  CommonFunctions.QueryExecute(sq);
					for(int u=0; u<shipids.length; u++)
						out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+ "  @  " +shipids[u][1] +"</option>");
				}	
				 
			   %>
              </select>
			  <script language="javascript">setOptionValue('branch','<%=branchid%>')</script>			  </td>
              <td width="98"  >Service Center </td>
              <td width="300"  >                <select name="servicecenter" class="formText135"  id="servicecenter"   onBlur="LoadAMCCustomer('0')" style="width:200px"  >
                    <option value="0">All</option>
                    <%
				String readDatas[][] =  CommonFunctions.QueryExecute("SELECT INT_SERVICECENTERID,CHR_CENTERNAME,CHR_SHORTNAME FROM  inv_m_servicecenter ORDER BY CHR_CENTERNAME");
				for(int u=0;u<readDatas.length;u++)
					out.println("<option value="+readDatas[u][0]+">"+readDatas[u][1]+"</option>");
				%>
                                </select>              </td>
            </tr>
			
			<tr>
			  <td colspan="4" align="center" valign="middle"  ><table width="83%" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
                <tr>
                  <td>Customer Group</td>
                  <td><select name="group" class="formText135 style5" id="group" onChange="LoadAMCCustomer('0')" style="width:200px" >
                    <option value="0">All</option>
					<%
					String gData[][] =  CommonFunctions.QueryExecute("SELECT INT_GROUPID,CHR_GROUPNAME   FROM  inv_m_servicecustomergroup ORDER BY CHR_GROUPNAME");
				for(int u=0;u<gData.length;u++)
					out.println("<option value="+gData[u][0]+">"+gData[u][1]+"</option>");
				
					
					%>
					
                  </select></td>
                  <td>Search</td>
                  <td><input name="search" type="text" class="formText135" id="search" onBlur="LoadAMCCustomers()" onKeyUp="upperMe(this),LoadAMCCustomers()"></td>
                </tr>
              </table></td>
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
		  
		 
				<div id="divscrolls" style="OVERFLOW:auto;width:100%;height:300px" 	 > </div>
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
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('0')">All</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('A')">A</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('B')">B</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('C')">C</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('D')">D</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('E')">E</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('F')">F</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('G')">G</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('H')">H</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('I')">I</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('J')">J</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('K')">K</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('L')">L</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('M')">M</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('N')">N</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('O')">O</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('P')">P</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('Q')">Q</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('R')">R</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('S')">S</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('T')">T</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('U')">U</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('V')">V</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('W')">W</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('X')">X</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('Y')">Y</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadAMCCustomer('Z')">Z</a></div></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td height="10"><input name="filename" type="hidden" value="ServiceCustomerInfo" />
        <input name="actionS" type="hidden" value="AMCServiceCustomerInfoDelete" /></td>
    </tr>
    <tr>
      <td>
        <table width="224" border="0" align="center" cellpadding="1"
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
	  if("F".equals(usertype)|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	  {
	  %>
				<td width="56"><input type="submit" class="ButtonHead"
					name="Submit" id="Submit" value="Delete"
					onClick="return RDelete()" /></td>
				<%
		}
		else
		{
			out.println("<input type='hidden'  name ='Delete' id='Delete'>");
		}
		%>
            <td width="56"><input type="button" class="ButtonHead"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect('AMCmain.jsp')" /></td>
          </tr>
        </table></td></tr>
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
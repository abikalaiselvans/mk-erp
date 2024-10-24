
<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>


<%
try
{
%>
<html>
<head>

<title> :: AMC ::</title><style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>




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
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/AMC/ServiceGroup.js"></script>
<script language="JavaScript">

function Add()
{ 
	document.frm.action="ServiceGroupAction.jsp";
}
	
function IEdit()
{		 
	try
	{	
		obj = findObj("id"); 
		if(obj == null)
		{
			alert("Edit not available");
			return false;
		}
	
	
		var count;
		count=0;
		coffee1=document.forms[0].id
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
			if (document.forms[0].id.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="ServiceGroupAction.jsp";
			return true;
		}
		else
		{
			alert("Select Only one Value");
			return false;
		}
	}
	catch(err)
	{
		alert(err);
		return false;
	}	
}	
 	
	
	function Delete()
 	{		
		
		obj = findObj("id"); 
		if(obj == null)
		{
			alert("Delete not available");
			return false;
		}


		var count;
		count=0;
		coffee1=document.forms[0].id
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
			if (document.forms[0].id.checked) { count=1;}
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
 	
	 
</script>
<body   onLoad="LoadServiceGroup('0')">
<%@ include file="index.jsp"%>

   <form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth">
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
	 
	  	  <table height="198" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
        <tr >
          <td height="22" class="whiteMedium" >  CUSTOMER GROUP </td>
        </tr>
        <tr >
          <td height="22" align="center" > 
            <table border="0" align="center" cellpadding="3" cellspacing="4" class="whiteMedium">
              <tr>
                <td	 >Branch </td>
                <td>
				<select name="branch" id="branch" onChange="LoadServiceGroup('0')"  class="formText135" >
							 
							<%
			   	String branchid=""+session.getAttribute("AMCBRANCH"); 
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
				</select>
				<script language="javascript">setOptionValue('branch','<%=branchid%>')</script>
				  </td>
              </tr>
            </table>
           </td>
        </tr>
        <tr >
          <td height="25" >
	
		  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="whiteMedium">
			<tr  >
  				<td   ><b>S.No</b></td>
    			<td  ><b>Name</b> </td>
			</tr> 
		  </table>		  </td>
        </tr>
        <tr>
          <td height="127" valign="top" class="footermenu"><table width="100%">
              <tr class="MRow1">
                <td>
					<div id="divscroll" style="OVERFLOW:auto;width:100%;height:250px" 	 > </div>
					<br>
					<div align="center" id="totRec"></div>
					<br>				</td>
              </tr>
               
          </table></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td>	  </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td><table border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
        <tr  >
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('0')">All</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('A')">A</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('B')">B</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('C')">C</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('D')">D</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('E')">E</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('F')">F</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('G')">G</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('H')">H</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('I')">I</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('J')">J</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('K')">K</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('L')">L</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('M')">M</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('N')">N</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('O')">O</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('P')">P</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('Q')">Q</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('R')">R</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('S')">S</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('T')">T</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('U')">U</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('V')">V</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('W')">W</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('X')">X</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('Y')">Y</a></div></td>
          <td  ><div align="center"><a class="whiteMedium" href="javascript:LoadServiceGroup('Z')">Z</a></div></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td height="10"><input name="filename" type="hidden" value="ServiceGroup" />
        <input name="actionS" type="hidden" value="AMCServiceGroupDelete" /></td>
    </tr>
    <tr>
      <td><table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
        <!--DWLayoutTable-->
        <tr>
          <td width="56" valign="top"><input type="submit" class="ButtonHead" name="action1" id="action1"  value="Add"   accesskey="s"   onClick="Add()"  /></td>
          <td width="56" valign="top"><input type="submit" class="ButtonHead" name="Edit" id="Edit" value="Edit"
					onclick="return IEdit()" /></td>
        
		 <%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype)|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	  {
	  %>
				<td width="56"><input type="submit" class="ButtonHead"
					name="Submit" id="Submit" value="Delete"
					onClick="return Delete()" /></td>
				<%
		}
		else
		{
			out.println("<input type='hidden'  name ='Delete' id='Delete'>");
		}
		%>
		
		
		
		  
          <td width="56"><input type="button" class="ButtonHead"
					name="submit" id="submit" value="Close"   accesskey="c"  onClick="redirect('AMCmain.jsp')" /></td>
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
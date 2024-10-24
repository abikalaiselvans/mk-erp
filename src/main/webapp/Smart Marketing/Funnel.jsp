<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<%
try
{
	String sql ="";
	String usertypes=""+session.getAttribute("USRTYPE");	
%>

<html>
<head>
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

<title> :: MARKETING ::</title>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Marketing/Funnel.js"></script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %> 
<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
</head>
<script language="JavaScript">

    function GAdd()
	{ 
		document.frm.action="DaillyCallsAdd.jsp";
		//location ="ScheduleEntryStaffAction.jsp";
 	}

	function GEdit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].id
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].id.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="DaillyCallsEdit.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}	


function RDelete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].id
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
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
	
	 
	
	function  SFAUpload(rowid)
	{
		var f ="SFAUpload.jsp?rowid="+rowid;
		newWindow = window.open(f,"subWind",",,height=400,width=600,top=0,left=0");
		newWindow.focus( );
	}
	
 </script>
<body onselectstart="return false" onpaste="return false;" onCopy="return false"    onLoad="LoadFunnel('0')" >
<%@ include file="index.jsp"%>

<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="get" name="frm">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	
    <tr>
		<td><!--<table width="291" border="0" align="center" cellpadding="1"
			cellspacing="1">
           
          <tr>
            <td width="56" valign="top" align="center"><input type="submit" class="ButtonHead"  name="action1" id="Add"  value="Add"   accesskey="s"   onClick="GAdd()" /></td>
            <td width="56" valign="top" align="center"><input type="submit" class="ButtonHead" name="Edit" id="Edit" value="Edit"  onclick="return GEdit()" /></td>
            
<%

	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype)|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_DELETEUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	  {
		  
	  %>
				<td width="56" align="center"><input type="submit" class="ButtonHead"
					name="Delete" id="Delete" value="Delete"
					onClick="return RDelete()" /></td>
				<%
		}
		else
		{
			out.println("<input type='hidden' id='Delete'>");
		}
		%>
        
			 
            <td width="56" align="center"><input type="Button" class="ButtonHead" name="submit"  value="Close"   accesskey="c"  onClick="redirect('MarketingMain.jsp')" /></td>
          </tr>
      </table>--></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
	  <td><table width="90%" height="200" border="0" align="center" cellpadding="0" cellspacing="0" class="TableDesign">
	  	
        <tr>
          <td height="31"><div align="center" class="whiteMedium">FUNNEL</div></td>
        </tr>
        <tr>
          <td height="31" align="center" valign="middle"><table border="0" align="center" cellpadding="2"
					cellspacing="2" class="whiteMedium">
            <tr>
              <td  >M.E</td>
              <td  class="boldEleven"><select name="me" class="formText135" id="me" style="width:175"  onBlur="LoadFunnel('0')" >
                  <option value="0">All</option>
                  <%
			  	if(!"F".equals(usertypes))
				  {
			  		String datad[][] =CommonFunctions.getReportingEmployeeIdNames(""+session.getAttribute("EMPID"));
					for(int u=0;u<datad.length;u++)
						out.println("<option value='"+datad[u][0]+"'>"+datad[u][1]+" / " +datad[u][0]+"</option>");
				  }
				  else
				  {
					  String datad[][] = CommonFunctions.QueryExecute("SELECT CHR_EMPID,CHR_STAFFNAME  FROM com_m_staff WHERE CHR_TYPE != 'T' ORDER BY CHR_STAFFNAME");
						for(int u=0;u<datad.length;u++)
							out.println("<option value='"+datad[u][0]+"'>"+datad[u][1]+" / " +datad[u][0]+"</option>");
				  }
			  %>
                </select>
              </td>
              <td  >Customer</td>
              <td  ><span class="boldEleven">
                <select name="customer" class="formText135" id="customer" onBlur="LoadFunnel('0')" style="width:175">
                  <option value="0">All</option>
                  <%
				
 
  sql = "SELECT a.INT_CUSTOMERID,b.CHR_NAME ,FIND_A_MKT_CUSTOMER_ADDRESS(a.INT_CUSTOMERID) FROM mkt_m_customerinfo a, mkt_m_customername b  WHERE a.INT_CUSTOMERNAMEID =b.INT_CUSTOMERNAMEID  AND  a.CHR_VERIFY='Y'";
   if("A".equals(usertype) || "S".equals(usertype))
   		sql = sql + " AND CHR_HOLDER='"+session.getAttribute("EMPID")+"' ";
sql = sql + "ORDER BY b.CHR_NAME";

String cdata[][]= CommonFunctions.QueryExecute(sql);
if(cdata.length>0)
for(int u=0;u<cdata.length;u++)
	out.println("<option value='"+cdata[u][0]+"'>"+cdata[u][1]+" / "+cdata[u][2]+"</option>");
%>
                </select>
              </span></td>
              <td >Call Type</td>
              <td ><span class="boldEleven">
                <select name="calltype" class="formText135" id="calltype"   onBlur="LoadFunnel('0') " style="width:100">
                  <option value="0">All</option>
                  <%
							String ctdata[][]= CommonFunctions.QueryExecute("SELECT INT_CALLTYPEID,CHR_CALLTYPE FROM mkt_k_calltype ORDER BY CHR_CALLTYPE");
							if(ctdata.length>0)
							for(int u=0;u<ctdata.length;u++)
							out.println("<option value='"+ctdata[u][0]+"'>"+ctdata[u][1]+"</option>");
						%>
                </select>
              </span></td>
              <td >Stage</td>
              <td  ><select name="stage" id="stage" onChange="LoadFunnel('0')">
                <option value="0">All</option>
                <%
                    String stagedata[][]= CommonFunctions.QueryExecute("SELECT INT_PERCENTAGE,UPPER(CHR_STAGENAME)  FROM mkt_m_stage WHERE CHR_STATUS='Y' ORDER BY INT_PERCENTAGE");
                    if(stagedata.length>0)
                    	for(int u=0;u<stagedata.length;u++)
                    		out.println("<option value='"+stagedata[u][0]+"'>"+stagedata[u][1]+"</option>");
                %>
                
              </select></td>
              </tr>
             
          </table></td>
        </tr>
         
        <tr class="MRow1">
          <td >
		  <div id="GroupTable" style="OVERFLOW:auto;width:100%x;height:300px" class="boldEleven"></div>
		  <br><div id="totalrec"></div> <br></td>
        </tr>
         
	     
      </table></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><table width="90%" border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
          <tr class="para">
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('0')">All</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('A')">A</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('B')">B</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('C')">C</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('D')">D</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('E')">E</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('F')">F</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('G')">G</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('H')">H</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('I')">I</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('J')">J</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('K')">K</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('L')">L</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('M')">M</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('N')">N</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('O')">O</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('P')">P</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('Q')">Q</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('R')">R</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('S')">S</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('T')">T</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('U')">U</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('V')">V</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('W')">W</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('X')">X</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('Y')">Y</a></div></td>
            <td class="boldEleven"><div align="center"><a class="whiteMedium"
					href="javascript:LoadFunnel('Z')">Z</a></div></td>
          </tr>
        </table></td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
	  <td><span class="boldEleven">
      <input type="hidden" name="filename" value="DaillyCalls" />
      <input type="hidden" name="actionS" value="MKTDaillyCallsDelete" />
      </span></td>
    </tr>
	<tr>
		<td>&nbsp;</td>
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
	out.println(e.getMessage());
}
%>

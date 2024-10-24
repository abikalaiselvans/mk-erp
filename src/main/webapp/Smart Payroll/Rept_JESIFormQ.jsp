<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html>
<head>
<title><%=CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='PAY' ")[0][0]%></title>


<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
</head>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/smartcommon/LoadBranchAjax.js"></script> 
<script language="javascript">
 
 	function checkCategory()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].Category
		txt="";
		var id="";
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
				count=count+1;
				id=i;
			}
		}
		
		if(count==0)
		{
			if (document.forms[0].Category.checked) { count=1;}
		}
		if(count>=1)
		{			
			return true;	
		}
		else
		{
		    alert("Select Atleast One Category");
		    return false;
		}		
 	}
	
	
	
	
function Validate()
{ 
	if(checkNullSelect( "company","Select Company" ,'0') && 		 
		  checkNullSelect('Month','Select Month','0') && checkNullSelect('Year','Select Year','0') && checkNullSelect( "reportType","Select Export Type" ,'0'))
		return true;
	else
		return false;
}


function setfocuss()
{
	var m = document.getElementById('Month').value;
	var y = document.getElementById('Year').value;
	var m1=parseInt(m)-1;
	var y1= parseInt(y);
	document.getElementById('noofmonth').value=daysInMonth(m1, y1);
	document.getElementById('company').focus();
}

</script>
<%@ include file="index.jsp"%>
 <link href="../DropDown - Image/msdropdown/dd.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="../DropDown - Image/msdropdown/js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="../DropDown - Image/msdropdown/js/uncompressed.jquery.dd.js"></script>


<body  onpaste="return false;" onLoad="setfocuss()">


<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="42">&nbsp;</td>
	</tr>
	<tr>
		<td height="348">
		
		<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return Validate()">
		  
		  <table class="BackGround" cellspacing="0" cellpadding="0" width="498"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
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
					<td width="481">

					<table width="300" height="329" border="0" align="center" cellpadding="0"
						cellspacing="0"  >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="30" colspan="2" class="BackGround" >ESI Form Q </td>
						</tr>
						<tr>
						  <td height="19" valign="middle" class="bold1"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  <td><!--DWLayoutEmptyCell-->&nbsp;</td>
					  </tr>
						<tr>
							<td width="146" height="28" valign="middle" class="boldEleven">
							Company <span class="bolddeepred">*</span> </td>
							<td>
<select name="company" id="company"	onChange="loadBranch()" onBlur="loadBranch()" class="formText135"  style="width:150px">
<option value="0">Select</option>
<%                  
	String branch1[][]=CommonFunctions.QueryExecute("SELECT INT_COMPANYID,CHR_COMPANYNAME FROM  com_m_company ");
	for(int i=0;i<branch1.length;i++)
		out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
%>
</select>							</td>
						</tr>
						<tr>
							<td width="146" height="28" valign="middle" class="boldEleven">
							Branch <span class="bolddeepred">*</span>  <span class="bolddeepred"> </span></td>
							<td>
<select name="branch" id="branch" class="formText135" style="width:150px">
	<option value="0">All</option>
</select></td>
						</tr>
						
						<tr class="bolddeepblue">
							<td height="24" valign="middle" class="boldEleven">Department <span class="bolddeepred">*</span></td>
							<td valign="top" class="bolddeepblue"><select name="department"
								id="department" class="formText135" style="width:150px">
								<option value="0">All</option>
								<%
	 
		String deptid[][] = CommonFunctions.QueryExecute("SELECT INT_DEPARTID,CHR_DEPARTNAME FROM   com_m_depart   ORDER BY  CHR_DEPARTNAME");
		
		for(int u=0;u<deptid.length;u++)
			out.print("<option value='"+deptid[u][0]+"'>"+deptid[u][1]+"</option>"); 
	%>
							</select></td>
						</tr>
						<tr>
								  <td class="boldEleven">Category <span class="bolddeepred">*</span></td>
								  <td> <select name="category" class="formText135" id="category" style="width:150px">
	<option value="0">All</option>
	<%
	String empcategorysql=" SELECT INT_EMPLOYEECATEGORYID,CHR_CATEGORYNAME  FROM   com_m_employeecategory   ORDER BY CHR_CATEGORYNAME ";
	String empcategoryData[][]=CommonFunctions.QueryExecute(empcategorysql);
	if (empcategoryData.length>0)
		for (int i=0; i<empcategoryData.length; i++) 
			out.println("<option value="+empcategoryData[i][0]+">"+empcategoryData[i][1] +"</option>");			
	
						%>

</select></td>
					  </tr>
						
						<tr align="center" valign="middle">
							<td height="28" align="left" valign="middle" class="boldEleven">Office <span class="bolddeepred">*</span> </td>
							<td align="left" valign="middle" class="boldEleven"><span
								class="bolddeepblue"> 
<%
	String branchid=""+session.getAttribute("BRANCHID");
	String oficeid=""+session.getAttribute("OFFICEID");
%> 
<select name="Office" class="formText135" id="Office"  style="width:150px">
	<option value="0">All</option>
<%
String shipids[][] =  CommonFunctions.QueryExecute(" select INT_OFFICEID,CHR_OFFICENAME from  com_m_office  order by CHR_OFFICENAME");
	for(int u=0; u<shipids.length; u++)
			if(shipids[u][0].trim().equals(oficeid.trim()))
				out.print("<option selected = 'selected' value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
			else
				out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
							%>
							</select> </span></td>
						</tr>
						<tr align="center" valign="middle">
                          <td height="28" align="left" valign="middle"
								class="boldEleven">Month <span class="bolddeepred">*</span> </td>
						  <td align="left" valign="middle" class="boldEleven"><%@ include
								file="../JavaScript/month.jsp"%></td>
					  </tr>
						<tr>
							<td valign="middle" height="28" class="boldEleven">Year <span class="bolddeepred">*</span> </td>
							<td valign="middle" class="boldEleven"><%@ include
								file="../JavaScript/year.jsp"%> <script
								language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('Year',year1);							
				//-->
          </script></td>
						</tr>
						<tr>
						  <td valign="middle" height="28" class="boldEleven">Export Type <span class="bolddeepred">*</span> </td>
						  <td valign="middle" class="boldEleven">
                          
                          
                          <script language="javascript" type="text/javascript">
	$(document).ready(function() 
	{
		try 
		{
			$("#reportType").msDropDown();
			
		} 
		catch(e) 
		{
				
		}
	}
	)
</script>
  <select name="reportType" id="reportType" style="width:150px;" >
    <option value="0" title="../DropDown - Image/icons/export.jpg" selected="selected">Export Type</option>
    <option value="csv" title="../DropDown - Image/icons/csv.jpg">CSV </option>
    <option value="xls" title="../DropDown - Image/icons/excel.jpg">Excel </option>
    <option value="html" title="../DropDown - Image/icons/html.jpg">Html </option>
    <option value="pdf" title="../DropDown - Image/icons/pdf.jpg">Pdf </option>
    <option value="rtf" title="../DropDown - Image/icons/rtf.jpg">Rtf </option>
    <option value="txt" title="../DropDown - Image/icons/txt.jpg">Txt </option>
    <option value="xml" title="../DropDown - Image/icons/xml.jpg">Xml </option>
  </select>
                          
                          </td>
					  </tr>
						<tr>
						  <td valign="middle" height="19" class="bold1"><span class="boldEleven">
						  <input name="noofmonth" type="hidden" id="noofmonth"
								value="0">
						    <input name="filename" type="hidden" id="filename"
										value="Rept_JESIFormQNew">
                            <input name="actionS"
										type="hidden" id="actionS"
										value="PAYRept_JESIFormQ">
                            <input name="rptfilename" type="hidden" id="rptfilename" value="Rept_JESIFormQ_New">
						  </span></td>
						  <td valign="middle" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
					  </tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<div align="center">
							<table border="0" cellspacing="3" cellpadding="0">
								<tr>
									<td width="56"><input class="buttonbold14" type="submit"
										name="Submit2" value="Submit"   accesskey="s"   ></td>
									<td width="56"><input class="buttonbold14" type="Button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="redirect('Payrollmain.jsp')"></td>
								</tr>
							</table>
							</div>							</td>
						</tr>
				  </table>				  </td>
					<td nowrap="nowrap" width="9"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
					<td height="14"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="0"
						src="../Image/Smart Inventory/BRCorner.gif" width="10" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
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
	<tr>
		<td>&nbsp;</td>
</table>
 
<%@ include file="../footer.jsp"%>
</body>

</html>

<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html>
<head>
<title> :: PAYROLL ::</title>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
.style8 {font-family: Verdana;
	font-size: 12px;
}
-->
</style> <link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/smartcommon/LoadBranchAjax.js"></script> 

<script language="javascript">
 
function Validate()
{
	if(checkNullSelect('company','Select Company','0') && checkNullSelect( "reportType","Select Export Type" ,'0'))
		return true;
	else
		return false;
}
function setfocuss()
{
	document.getElementById('company').focus();
}

</script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>


<link href="../DropDown - Image/msdropdown/dd.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="../DropDown - Image/msdropdown/js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="../DropDown - Image/msdropdown/js/uncompressed.jquery.dd.js"></script>



</head>
<%@ include file="index.jsp"%>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="setfocuss()">

<br>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return Validate()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="42">&nbsp;</td>
  </tr>
  <tr> 
    <td>
	<table class="BackGround" cellspacing="0" cellpadding="0" width="390" align="center" border="0">
        <tbody>
          <tr>
            <td colspan="2" rowspan="2" valign="top"><img height="7" src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
            <td class="BorderLine" height="0"><spacer height="1" 
                        width="1" type="block" /></td>
            <td colspan="2" rowspan="2" valign="top"><img height="7" src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
          </tr>
          <tr>
            <td height="6"><spacer height="1" width="1" type="block"/></td>
          </tr>
          <tr>
            <td class="BorderLine" width="1"><spacer height="1" 
                        width="1" type="block" /></td>
            <td width="6"><spacer height="1" width="1" type="block" /></td>
            <td width="412">

	<table width="351" border="0" align="center" cellpadding="0" cellspacing="0"  >
        <!--DWLayoutTable-->
        <tr align="center" valign="middle"> 
          <td height="30" colspan="2" class="BackGround" > FROM 6A Report </td>
        </tr>
		<tr>
		  <td height="19" valign="middle" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
		  <td><!--DWLayoutEmptyCell-->&nbsp;</td>
		  </tr>
		<tr>
          <td width="115" height="28" valign="middle" class="boldEleven"> Company <span class="bolddeepred">*</span> </td>
          <td width="247">
         <select name="company" id="company"  onChange="loadBranch()"  onblur="loadBranch()" class="formText135" style="width:150px"><option value="0">Select</option>
	          <%                  
     					String queryBranch1="SELECT  INT_COMPANYID,CHR_COMPANYNAME  FROM  com_m_company ";
     					String	branch1[][]= CommonFunctions.QueryExecute(queryBranch1);
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
          </select>          </td>
        </tr>
        <tr>
          <td width="115" height="28" valign="middle" class="boldEleven"> Branch <span class="bolddeepred">*</span> </td>
          <td width="247">
          <select name="branch" id="branch" class="formText135" style="width:150px">
	          <option value="0">All</option>
          </select>          </td>
        </tr> 
        <tr align="center" valign="middle">
          <td  height="28" align="left" valign="middle" class="boldEleven">office <span class="bolddeepred">*</span> </td>
          <td align="left" valign="middle" class="boldEleven"><span class="bolddeepblue">
            <%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %>
            <select name="Office" class="formText135" id="Office"   style="width:150px"  >
              <option value="0" >All</option>
              <%
								
		String sq=" select INT_OFFICEID,CHR_OFFICENAME from  com_m_office  order by CHR_OFFICENAME";

		String shipids[][] =  CommonFunctions.QueryExecute(sq);
		for(int u=0; u<shipids.length; u++)
			if(shipids[u][0].trim().equals(oficeid.trim()))
				out.print("<option selected = 'selected' value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
			else
				out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
							%>
            </select>
          </span></td>
        </tr>
        <tr>
          <td  valign="middle"  height="28"  class="boldEleven">Year <span class="bolddeepred">*</span> </td>
          <td valign="middle" class="boldEleven">
		   <%@ include file="../JavaScript/year.jsp"%>
          <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('Year',year1);							
				//-->
          </script>		  </td>
        </tr>
        <tr>
          <td  valign="middle"  height="28"  class="boldEleven">Export Type <span class="bolddeepred">*</span> </td>
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
  <select name="reportType" id="reportType" style="width:170px;" >
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
          <td  valign="middle"  height="19"  class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td valign="middle" class="boldEleven"><input name="filename" type="hidden" id="filename"
										value="Rept_JPFForm_6A">
            <input name="actionS"
										type="hidden" id="actionS"
										value="PAYRept_JPFForm_6A">
            <input name="rptfilename" type="hidden" id="rptfilename" value="PF_Form6A"></td>
        </tr>
        <tr> 
          <td  height="28" colspan="2"  valign="middle"  class="bolddeepblue"><div align="center">
            <table border="0" cellspacing="3" cellpadding="0">
                <tr>
                  <td width="56"><input class="buttonbold14" type="submit" name="Submit2" value="Submit"   accesskey="s"   ></td>
                  <td width="56"><input class="buttonbold14" type="Button" name="Submit"  value="Close"   accesskey="c"  onClick="redirect('Payrollmain.jsp')"></td>
                </tr>
                      </table>
          </div></td>
          </tr>
      </table>	  </td>
            <td nowrap="nowrap" width="4"><spacer height="1" width="1" 
                        type="block" /></td>
            <td class="BorderLine" width="1"><spacer height="1" 
                        width="1" type="block" /></td>
          </tr>
          <tr>
            <td colspan="2" rowspan="2"><img height="7" src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
            <td height="6"><spacer height="1" width="1" type="block" /></td>
            <td colspan="2" rowspan="2"><img height="7" src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
          </tr>
          <tr>
            <td class="BorderLine" height="0"><spacer height="1" width="1" type="block" /></td>
          </tr>
        </tbody>
      </table>	  </td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  <tr>
    <td>&nbsp;</td>
</table>
  </form>
<%@ include file="../footer.jsp"%>
</body>

</html>

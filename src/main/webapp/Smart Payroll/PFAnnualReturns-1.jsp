<%@ page import="com.my.org.erp.common.CommonFunctions"%>

<%
try
{
%>
<html>
<head>

<title> :: PAYROLL ::</title>


<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>

 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Attendance/ReportAjax.js"></script>
<script language="javascript">
 
function Validate()
{
	if(checkNullSelect('company','Select Company','0') && checkNullSelect('branch','Select branch','Select') )
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
</head>
<%@ include file="index.jsp"%>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="setfocuss()">

<br>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="PFAnnualReturnsResponse-1.jsp" onSubmit="return Validate()" >
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

	<table width="455" border="0" align="center" cellpadding="0" cellspacing="0"  >
        <!--DWLayoutTable-->
        <tr align="center" valign="middle"> 
          <td height="30" colspan="2" class="BackGround">PF ANNUAL RETURNS </td>
        </tr>
		<tr>
          <td width="162" height="28" valign="middle" class="boldEleven"> Company</td>
          <td width="178">
         <select name="company" id="company"  onChange="loadBranch()"  onblur="loadBranch()" class="formText135" style="width:200px">
	          <%                  
     					String queryBranch1="SELECT INT_COMPANYID,CHR_COMPANYNAME   FROM  com_m_company ";
     					String	branch1[][]= CommonFunctions.QueryExecute(queryBranch1);
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
          </select>          </td>
        </tr>
        <tr>
          <td width="162" height="28" valign="middle" class="boldEleven"> Branch</td>
          <td width="178">
          <select name="branch" id="branch" class="formText135" style="width:200px">
	        
			<option value="0">All</option>
          </select>          </td>
        </tr> 
        <tr align="center" valign="middle">
          <td  height="28" align="left" valign="middle" class="boldEleven">office</td>
          <td align="left" valign="middle" class="boldEleven"><span class="bolddeepblue">
            <%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %>
            <select name="Office" class="formText135" id="Office"  style="width:200px"    >
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
        <tr class="bolddeepblue">
          <td height="22" valign="middle" class="boldEleven">Department</td>
          <td valign="top" class="bolddeepblue"><select name="dept"
								id="dept" class="formText135" style="width:200px">
              <option value="0">All</option>
              <%
		sq="SELECT INT_DEPARTID,CHR_DEPARTNAME FROM   com_m_depart   ORDER BY  CHR_DEPARTNAME";
		String deptid[][] =  CommonFunctions.QueryExecute(sq);
		
		for(int u=0;u<deptid.length;u++)
			out.print("<option value='"+deptid[u][0]+"'>"+deptid[u][1]+"</option>"); 
	%>
          </select></td>
        </tr>
        <tr class="bolddeepblue">
          <td height="22" valign="middle" class="boldEleven">Year</td>
          <td valign="top" class="bolddeepblue"><strong>
            <select name="Year" class="formText135" id="Year"  style="width:200px" >
               <%@ include file="../JavaScript/accountyears.jsp"%>
            </select>
            <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date();
						var month1=parseInt(d.getMonth() + 1);
						var year1=parseInt(d.getFullYear());
						var m="";
						if(month1<4)
							year1 = year1-1;
						if(month1<10) 
							m="0"+month1;
						
						setOptionValue('Year',year1);	
						 					
				//-->
                            </script>
          </strong></td>
        </tr>
        <tr class="bolddeepblue">
           
        </tr>
        <tr class="bolddeepblue">
          <td height="22" valign="middle" class="boldEleven">Including Resigned &amp; Hold </td>
          <td valign="top" class="bolddeepblue"><table width="100" border="0" cellspacing="4" cellpadding="3">
            <tr>
              <td class="boldEleven"><input name="Resigned" type="checkbox" id="Resigned" value="Y"></td>
              <td class="boldEleven">Resigned</td>
              <td class="boldEleven"><input name="Hold" type="checkbox" id="Hold" value="Y"></td>
              <td class="boldEleven">Hold</td>
            </tr>
          </table></td>
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
<%
}
catch(Exception e)
{
	out.println(""+e.getMessage());
}

%>
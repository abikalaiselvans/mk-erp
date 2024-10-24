<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
	String allowanceSql=" SELECT CHR_ACODE,CHR_ANAME from pay_m_allowance where CHR_MONTHFLAG='Y'  order by INT_ALLOWANCEID ";
	String allowanceData[][]= CommonFunctions.QueryExecute(allowanceSql);
	String field="";
	if (allowanceData.length>0)
		for (int i=0; i<allowanceData.length; i++) 
			field = field + allowanceData[i][0] + " = 0 , ";
			
	 	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<title> :: PAYROLL ::</title>


 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<script language="javascript" src="../JavaScript/comfunction.js"></script>

<script language="javascript">
    function Load()
  	{
  		if(
		
			//checkNullSelect("Allowance","Select Allowance","0")
			checkNullSelect("month","Select the month","0")
			&& checkNullSelect("year","Select the year","0")
			 
			)
  		{
			  return true;
		}
   		else
		{
   			
			return false;
  		}
		
 	}  
 </script>
 
 
 
</head>

<body  onpaste='return false;'>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

<form  AUTOCOMPLETE = "off"   id="form1" name="uploadForm" action="../SmartLoginAuth" 	 method="post" onSubmit="return Load()">
<table class="BackGround" cellspacing="0" cellpadding="0" width="390"
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
      <td width="412"><table width="500" border="0" cellspacing="2" cellpadding="2"
						 >
        <!--DWLayoutTable-->
        <tr align="center" valign="middle">
          <td height="18" colspan="2"  class="BackGround">CLEAR NON ADDED ALLOWANCE </td>
        </tr>
        <tr>
          <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td><!--DWLayoutEmptyCell-->&nbsp;</td>
        </tr>
        <tr>
          <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
          <td><!--DWLayoutEmptyCell-->&nbsp;</td>
        </tr>
        <tr>
          <td class="boldEleven">Allowance</td>
          <td><select name="Allowance" class="formText135" id="Allowance">
            <option value="0">All</option>
            <%
	
	if (allowanceData.length>0)
		for (int i=0; i<allowanceData.length; i++) 
			out.println("<option value="+allowanceData[i][0]+">"+allowanceData[i][1] +"</option>");			
	
						%>
          </select></td>
        </tr>
        <tr class="bolddeepblue">
		
		
          <td width="132" height="35" valign="middle" class="bolddeepblue">Month<font
								color='red'>&nbsp;</font></td>
          <td width="268" valign="top" class="bolddeepblue">
		  <select  name="month" id="month" class="formText135">
           <option value="0">Select Month</option>
                        <%@ include file="../JavaScript/months.jsp"%>
          </select>
		   </td>
        </tr>
        <tr>
          <td class="bolddeepblue">Year</td>
          <td><select name="year"  id="year" class="formText135">
            <option value="0">Select year</option>
            <%@ include file="../JavaScript/years.jsp"%>
          </select>
                <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
            </script>
                <input name="filename" type="hidden" id="filename" value="UploadUpdate">
                <input name="actionS" type="hidden" id="actionS" value="PAYClearAllowance">
                <input type="hidden" name="field" id="field" value="<%=field%>"></td>
        </tr>
        <tr>
          <td height="28" colspan="2" valign="middle" class="bolddeepblue"><table width="142" border="0" align="center" cellpadding="3"
								cellspacing="3">
            <tr>
              <td width="61"><input name="upload" type="submit"
										class="buttonbold14" id="submit" value="Clear"></td>
              <td width="60"><input class="buttonbold14" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="javascript:window.close()"></td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td height="2"></td>
          <td></td>
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
</table>

</form>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>
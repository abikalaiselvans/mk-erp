<%@ page import="java.lang.*,java.util.*,java.io.*,java.sql.*,com.my.org.erp.ServiceLogin.*"%>
<%
try
{
%>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
function Load()
{
	if( checkNullSelect('adressproof','Select Address Proof','0'))
		return true;
	else
		return false;
}


</script>  
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 
<title> :: COMMON ::</title>


 <style type="text/css">
<!--
.style3 {color: #FF0000}
-->
 </style>
 <body  onpaste="return false;"  >
<form  AUTOCOMPLETE = "off"   id="form1" name="uploadForm" action="StaffAddressProofViewresponse.jsp" 	  method="post" onSubmit="return Load()">
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<table width="591" border="0" align="center" cellpadding="0"
					cellspacing="0" bgcolor="#dce4f9" class="BackGround">
  <tbody>
    <tr>
      <td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/TLCorner.gif" width="7" /></td>
      <td class="BorderLine" height="1"><spacer height="1"
								width="1" type="block" /></td>
      <td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/TRCorner.gif" width="7" /></td>
    </tr>
    <tr>
      <td height="6"><spacer height="1" width="1" type="block" /></td>
    </tr>
    <tr>
      <td class="BorderLine" width="1"><spacer height="1"
								width="1" type="block" /></td>
      <td width="6"><spacer height="1" width="1" type="block"></td>
      <td width="577" valign="top"><table width="327" border="0" align="center" cellpadding="1" cellspacing="5"
	class="tabledata">
        <tr>
          <td>Staff Id</td>
          <td><%=request.getParameter("staffid")%>
              <input type="hidden"
			name="staffid" value="<%=request.getParameter("staffid")%>"></td>
        </tr>
        <tr>
          <td valign="top">Address Proof </td>
          <td><select name="adressproof" id="adressproof" class="formText135" >
              <option value="0">Select AddresProof</option>
              <%
			 
String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_ADDRESSPROOFID,CHR_PROOFCODE, CHR_PROOFNAME FROM com_m_addressproof  ORDER BY CHR_PROOFNAME");
for(int h=0;h<data.length;h++)
{
	String ssql =" SELECT "+data[h][1]+" is  null FROM com_m_staffaddressproof WHERE CHR_EMPID='"+request.getParameter("staffid")+"'";
	// System.out.println(" SELECT "+data[h][1]+" is  null FROM com_m_staffaddressproof WHERE CHR_EMPID='"+request.getParameter("staffid")+"'");
	if(!"1".equals(com.my.org.erp.common.CommonFunctions.QueryExecute(ssql)[0][0]))
		out.print("<option value='"+data[h][1]+"'>"+data[h][2]+"</option>");
}
	
		
  %>
            </select>
              <%
String data1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_ADDRESSPROOFID,CHR_PROOFCODE, CHR_PROOFNAME FROM com_m_addressproof  ORDER BY CHR_PROOFNAME");
if(data1.length>0)
{
	out.println("<br><br><br>Available AddressProof ::");
	for(int h=0;h<data1.length;h++)
	{
		String ssql =" SELECT "+data1[h][1]+" is  null FROM com_m_staffaddressproof WHERE CHR_EMPID='"+request.getParameter("staffid")+"'";
		 
		if(!"1".equals(com.my.org.erp.common.CommonFunctions.QueryExecute(ssql)[0][0]))
			out.println("<br><font class='bolddeepred'>"+data1[h][2]+"</font>");
			 
	}
}
	
		
  %></td>
        </tr>
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
          <td colspan="2"><table width="56" border="0" align="center" cellpadding="1"
			cellspacing="1">
              <tr>
                <td><input name="Submit" type="submit" class="buttonbold"
					value="Submit"></td>
              </tr>
          </table></td>
        </tr>
      </table></td>
      <td nowrap="nowrap" width="6"><spacer height="1" width="1"
								type="block" /></td>
      <td width="1" class="BorderLine"><spacer height="1"
								width="1" type="block" /></td>
    </tr>
    <tr>
      <td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/BLCorner.gif" width="7" /></td>
      <td height="6"><spacer height="1" width="1" type="block" /></td>
      <td colspan="2" rowspan="2" valign="bottom"><div align="right"><img height="7"
								src="../Image/General/BRCorner.gif" width="7" /></div></td>
    </tr>
    <tr>
      <td class="BorderLine" height="1"><spacer height="1"
								width="1" type="block" /></td>
    </tr>
  </tbody>
</table>
<p>&nbsp;</p>
</form>
</body>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
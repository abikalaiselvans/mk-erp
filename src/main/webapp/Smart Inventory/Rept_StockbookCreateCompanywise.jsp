<%@ page import="java.io.*,java.util.*" errorPage="../error/index.jsp"%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>

<body >
<%@ include file="indexinv.jsp"%>
<script language="javascript">

	function validate()
	{
		if(checkNullSelect('Company','Select Comapany','0') )
			return true;
		else
			return false;
	}
</script>
<form method="post" action="../SmartLoginAuth" onSubmit="return validate()" >
<table width="56" border="0" align="center" cellpadding="5" cellspacing="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
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
          <td width="412"><table cellspacing="2" cellpadding="2" width="298" align="center"
						border="0">
              <!--DWLayoutTable-->
              <tbody>
                <tr>
                  <td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">STOCK BOOK CREATE COMPANY WISE </td>
                </tr>
                <tr>
                  <td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory </span></td>
                </tr>
                 
                <tr>
                  <td width="199" height="17" class="boldEleven">Company  <span class="boldred">*</span> </td>
                  <td width="287" colspan="2" align="left">
				  <select name="Company"
										class="formText135" id="Company" tabindex="6" style="width:200">
										 <option value='0'>Select Company</option>
										<%
								 
								String seq="  SELECT INT_COMPANYID,CHR_COMPANYNAME FROM  com_m_company ORDER BY CHR_COMPANYNAME ";
 
								String shipidse[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(seq);
								for(int u=0; u<shipidse.length; u++)
									out.print("<option value='"+shipidse[u][0]+"'>"+shipidse[u][1] +"</option>");
							%>
						</select>				  </td>
                </tr>
                <tr>
                  <td height="17" class="boldEleven">Division  <span class="boldred">*</span> </td>
                  <td colspan="2" align="left"><select name="division"
									class="formText135" id="division" tabindex="1" style="width:200">
                    <option value='0'>All</option>
                    <%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                  </select></td>
                </tr>
                <tr>
                  <td height="17" class="boldEleven">Product Type  <span class="boldred">*</span> </td>
                  <td colspan="2" align="left">
				  <select name="Producttype" id="Producttype" style="width:200">
				  	<option value="P">Product</option>
				 	 <option value="I">Item</option>
                  </select>                  </td>
                </tr>
                <tr>
                  <td height="17" class="boldEleven">Month  <span class="boldred">*</span> </td>
                  <td colspan="2" align="left"><select name="month" class="formText135" id="month" style="width:200">
							<%@ include file="../JavaScript/Inventory/month.jsp"%>
						</select></td>
                </tr>
                <tr>
                  <td height="17" class="boldEleven">Year  <span class="boldred">*</span> </td>
                  <td colspan="2" align="left">
				  <select name="year" class="formText135" id="year" style="width:200">
							<%@ include file="../JavaScript/Inventory/year.jsp"%>
						</select> <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);	
				//-->
          </script></td>
                </tr>
                <tr>
                  <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                  <td colspan="2" align="left"><span class="boldEleven">
                    <input type="hidden" name="filename" value="StockBook" />
                    <input type="hidden" name="actionS"  value="INVStockBookCreateCompany" />
                  </span></td>
                </tr>
                 
                <tr>
                  <td height="17" colspan="3" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                      <tr>
                        <td><input name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
                        <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="javascirpt:window.close()"></td>
                      </tr>
                  </table></td>
                </tr>
                <tr>
                  <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                  <td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
                </tr>
              </tbody>
              <input type="hidden" name="mobileBookingOption" />
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
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
</form><%@ include file="../footer.jsp"%>
</body>
</html>

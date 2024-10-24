<%@ page 	import="java.lang.*,java.util.*,java.io.*,java.sql.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page 	import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
 	
function Load()
{
 	try
	{  		 
		if(   checkNullSelect('quotation','Select quotation ','0')   )
  				return true;
		else
			return false;
	}
	catch(err)
	{
		return false;
	}	
}  
	
 


	
 </script>
<HTml>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<title> :: MARKETING ::</title>

 
  
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



<BODY> <FORM name="frm" ACTION= "../SmartLoginAuth" METHOD="POST" onSubmit="return Load()">
                <br>
                <br>
                <br>
           
		   
		        <table class="BackGround" cellspacing="0" cellpadding="0" width="450"
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
                      <td  ><table width="396" border="0" align="center" cellpadding="2" cellspacing="2"  >
                        <tr>
                          <td colspan="2"><p align= "center"><B> QUOTATION
                            <%
			   String sql ="";
			   String rowid = request.getParameter("rowid");
			   sql = " SELECT d.CHR_NAME,b.CHR_ALIAS,b.CHR_CONTACTPERSON,c.CHR_CALLTYPE,a.CHR_DESC,a.INT_CUSTOMERID ";
			   sql = sql + " FROM mkt_t_daillycalls a, mkt_m_customerinfo b, mkt_k_calltype c , mkt_m_customername d";
			   sql = sql + " WHERE a.INT_CUSTOMERID =b.INT_CUSTOMERID  ";
			   sql = sql + " AND a.CHR_CALLTYPE=c.INT_CALLTYPEID AND b.INT_CUSTOMERNAMEID =d.INT_CUSTOMERNAMEID";
			   sql = sql + " AND INT_CALLID = "+rowid;
			   //out.println(sql);
			   String ctdata[][]= CommonFunctions.QueryExecute(sql);
			   %>
                          </B></td>
                        </tr>
                        <tr>
                          <td width="189">Agenda</td>
                          <td width="193"><b><%=ctdata[0][0]%> <b></td>
                        </tr>
                        <tr>
                          <td>Company / Contact</td>
                          <td><%=ctdata[0][1]%> /<%=ctdata[0][2]%></td>
                        </tr>
                        <tr>
                          <td>Call Type</td>
                          <td><%=ctdata[0][3]%></td>
                        </tr>
                        <tr>
                          <td>Description</td>
                          <td><%=ctdata[0][4]%>
                          <input name="rowid" type="hidden" id="rowid" value="<%=rowid%>">
                          <input type="hidden" name="filename" value="DaillyCalls" />
                          <input type="hidden" name="actionS" value="MKTDaillyCallsQuotationAssign" />
                          </span></td>
                        </tr>
                        <tr>
                          <td>Quotation</td>
                          <td><select name="quotation" class="formText135" id="quotation">
                              <option value="0">Select Quotation</option>
                              <%
				 String qdata[][]= CommonFunctions.QueryExecute("SELECT INT_QUOTATIONID,CHR_QUOTATIONNO from mkt_t_quotation  WHERE CHR_ASSIGNED='N' AND INT_CUSTOMERID= "+ctdata[0][5]);
				 if(qdata.length>0)
				 	for(int u=0;u<qdata.length;u++)
						out.println("<option value='"+qdata[u][0]+"'>"+qdata[u][1]+"</option>");
				 %>
                            </select>
                          </td>
                        </tr>
                        <tr>
                          <td><b> </b></td>
                          <td>&nbsp;</td>
                        </tr>
                        <tr>
                          <td colspan="2"><table width="56" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                              <td><input type="submit" name="Submit" value="Submit"   accesskey="s"   ></td>
                            </tr>
                          </table></td>
                        </tr>
                        <tr>
                          <td colspan="2"><p align="right">&nbsp; </p></td>
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
           </FORM>
</BODY>
</HTML>

<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
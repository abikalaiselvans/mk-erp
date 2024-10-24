<%@ page import="java.io.*,java.util.*"%>
<html>
<head>
<title>:: INVENTORY ::</title> 
 
<script language="javascript"
	src="../../JavaScript/Inventory/InvenAJAX.js"></script>
<script language="JavaScript" src=".././JavaScript/calendar1.js"></script>

<script language="javascript">
function validate()
  {
  
  	if(checkNullSelect('company',"Select The Company","select")   
  	&& checkNull('TxtCustName','Enter the Customer Name')
  	&& checkNull('TxtCustAdd','Enter the Customer Address')
  	)
  		return true;
  	else
  		return false;  	
  }
</script>

<style type="text/css">
<!--
.style3 {font-family: Verdana, Arial, Helvetica, sans-serif}
-->
</style>
</head>
<body >
<form  AUTOCOMPLETE = "off"   method="get" name='frmDemo' action="../SmartLoginAuth">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<%
String demo=request.getParameter("demoId");
String sql="select * from inv_t_demo where int_demoid="+Integer.parseInt(demo);
String demoData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);

 %>


	<tr>
		<td colspan="2">
		<table class="BackGround" cellspacing="0" cellpadding="0" width="424"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412">
					<table cellspacing="2" cellpadding="2" width="401" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>

							<tr>
								<td height="29" colspan="2" valign="middle" class="boldEleven">
								<div align="center" class="bold1">
								<div align="center">Demo</div>
								</div>
								</td>
							</tr>
							<tr>
								<td width="150" height="29" valign="middle" class="boldEleven">Company
								<font color="#ff0000"></font></td>
								<td width='257' valign='top' class="boldEleven">
								<%
            String sqlCompany="select * from com_m_company";                      
            String query[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sqlCompany);
            for(int i=0;i<query.length;i++)
            {
            	if(demoData[0][0].trim().equals(query[i][0].trim()))
            		out.println("<option value='"+query[i][0]+"' selected='selected'>"+query[i][1]+"</option>");                    
            	}            	
           %>
								</td>
							</tr>
							<tr>
								<td width="150" height="29" valign="middle" class="boldEleven">Branch
								<font color="#ff0000"></font></td>
								<td width='257' valign='top' class="boldEleven">
								<%
            String sql1="select * from com_m_branch where int_companyid="+Integer.parseInt(demoData[0][0]);                      
            String query1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql1);
            for(int i=0;i<query1.length;i++)
            {
            	if(demoData[0][1].trim().equals(query1[i][0].trim()))
            		out.println(""+query1[i][2]+"");                    
            	 }            	
           %>
								</td>
							</tr>
							<tr>
								<td width="150" height="29" valign="middle" class="boldEleven">Customer
								Name <font color="#ff0000"></font></td>
								<td width='257' valign='top' class="boldEleven"><%=demoData[0][4] %></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Date <span
									class="bolddeepred"> </span></td>
								<td colspan="2" align="left" class="boldEleven">
								<%
                          String dbvalue="";
						  dbvalue=demoData[0][5].trim();						
						  if(dbvalue.equalsIgnoreCase("null") || dbvalue.equalsIgnoreCase(""))
						  dbvalue="";
						  else
						  {
							 String sdt[] = dbvalue.split("-");	
							 dbvalue = sdt[2]+"-"+sdt[1]+"-"+sdt[0];
							
						 } 	
						%><%=dbvalue%></td>
							</tr>

							<tr>
								<td width="150" height="29" valign="top" class="boldEleven">Customer
								Address</td>
								<td width="257" valign="top" class="boldEleven"><%=demoData[0][6] %></td>
							</tr>
							<tr>
								<td width="150" height="29" valign="top" class="boldEleven">Description</td>
								<td valign="top" class="boldEleven"><%=demoData[0][7]%></td>
							</tr>

							<tr>
								<td width="150" height="29" valign="middle" class="boldEleven">Authorised
								By</td>
								<td width='257' valign='top' class="boldEleven"><%=demoData[0][9]%></td>
							</tr>
							<tr>
								<td width="150" height="29" valign="middle" class="boldEleven">Handled
								By</td>
								<td width='257' valign='top' class="boldEleven"><%=demoData[0][10] %></td>
							</tr>
							<tr>
								<td height="29" valign="top" class="boldEleven"></td>
								<td valign="top" class="boldEleven"><input type="checkbox"
									name="status"> Status
							</tr>
							<tr>
								<td height="29" colspan="2" valign="top" class="boldEleven">
								<table border="0" align="center" cellpadding="1" cellspacing="1">
									<tr>
									</tr>
								</table>
								</td>
							</tr>
						</tbody>
					</table>
					</td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>
		</td>
	</tr>
	<tr>
		<td width="100%"><a href='javascript:window.print()'>
		<div align="center">PRINT</div></td>
		<td width="0%">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2"></td>
	</tr>
</table>
</form>
</body>
</html>

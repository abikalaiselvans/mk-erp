<%@ page import="java.io.*,java.util.*"%>
<body >
 
		<table cellspacing="0" cellpadding="0" width="424"
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
					<td width="412">
					<table cellspacing="2" cellpadding="2" width="400" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">Direct Billing  </td>
							</tr>

							 
							<tr>
							  <td height="17" colspan="3" valign="top" class="errormessage">
							    <div align="center">
							      <%
							  	 
								String  invoiceno= request.getParameter("salesid");
								String sql=" SELECT INT_DIVIID,date_format(DAT_SALESDATE,'%d-%b-%Y'),INT_CUSTOMERID,CHR_REF,CHR_DES,DOU_AMOUNT ";
								sql = sql+" FROM inv_t_directbilling WHERE CHR_SALESNO='"+invoiceno+"'";
								
								String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								String dbdivis="",dbSaleNo="",dbsaleDate="",dbcustomer="",dbref="",dbmemo="",dbtotals="";
								if(readData.length>0)
								{
									dbdivis=readData[0][0];
									dbsaleDate=readData[0][1];
									dbcustomer=readData[0][2];
									dbref=readData[0][3];
									dbmemo=readData[0][4];
									dbtotals=readData[0][5];
								}
								 
							  %>
					            </div></td>
						  </tr>
							<tr>
								<td width="174" height="17" valign="top" class="boldEleven">Division</td>
								<td width="412" colspan="2" align="left" class="boldEleven">
								
                    <%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division WHERE INT_DIVIID="+dbdivis);
								out.print(division[0][1]);
							%>
                 
	  						  </td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Invoice Number </td>
							  <td colspan="2" align="left" class="boldEleven"><%=invoiceno%>
								 
										  <input name="SaleNo" type="hidden" id="SaleNo" value="<%=invoiceno%>"></td>
							</tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Invoice date </td>
							  <td colspan="2" align="left" class="boldEleven"><span class="boldEleven">
							    <%=dbsaleDate%>
				  </script>
				  
							  </span></td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Customer Name </td>
							  <td colspan="2" align="left" class="boldEleven">
							  <%
	  String custo[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_CUSTOMERID,FIND_A_CUSTOMER_NAME(INT_CUSTOMERID) FROM inv_m_customerinfo WHERE INT_CUSTOMERID="+dbcustomer);
		out.print(custo[0][1]);
							  
								%>
							 
				  </script>					  </td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Reference</td>
							  <td colspan="2" align="left" class="boldEleven">
							 <%
							  String empname[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_EMPID, CHR_STAFFNAME FROM com_m_staff  WHERE CHR_EMPID='"+dbref +"'");
		out.print(empname[0][1]+" / "+empname[0][1]);
		%>
					   		  </td>
						  </tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Others Description </td>
							  <td colspan="2" align="left" class="boldEleven"><%=dbmemo%></td>
							</tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Total Amount </td>
							  <td colspan="2" align="left" class="boldEleven">
							  <%=dbtotals%>						  </td>
						  </tr>
							
						</tbody>
						<input type="hidden" name="mobileBookingOption" />
					</table>
					</td>
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
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
</body>
</html>

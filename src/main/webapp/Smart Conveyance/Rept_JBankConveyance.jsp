<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
 
<title> :: CONVEYANCE ::</title>

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 
</head>
<script src="../JavaScript/AJAXFunction.js"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/Attendance/ReportAjax.js"></script>


<script language="javascript">
function validate()
{
	if(checkNullSelect( "company","Select Company" ,'Select')  
	&& checkNullSelect( "reportType","Select Export Type" ,'0'))
		return true;
	else
		return false;
}
</script>
<body  onpaste='return false;'>

<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return validate()">
<table width="900" height="150" border="0" align="center"
	cellpadding="2" cellspacing="2">
	<%
try
{
	
	 
 %>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="588"
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
					<td width="7"><spacer height="1" width="1" type="block" /></td>
					<td width="575">
					<table width="100%" border="0" cellspacing="2" cellpadding="2"
						 >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="18" colspan="2"  class="BackGround"><span
								class="boldThirteen"> Conveyance-Bank Detail </span></td>
						</tr>

						<tr class="bolddeepblue">
							<td height="22" colspan="2" valign="middle" class="style3">
							<table width="346" border="0" align="center" cellpadding="3"
								cellspacing="1">
								<tr>
								  <td colspan="2" class="boldEleven"><div align="right"><span class="bolddeepred">*</span> Mandatory </div></td>
							  </tr>
								<tr>
									<td class="boldEleven">Company</td>
									<td class="boldEleven"><select name="company" id="company"
										onChange="loadBranch()" onBlur="loadBranch()"
										class="formText135" style="width:200px">
										<option value="Select">Select Company</option>
										<option value="0">All</option>
										<%                  
     					String queryBranch1 = "SELECT * FROM  com_m_company ";
     					String	branch1[][] = CommonFunctions.QueryExecute(queryBranch1);
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
									</select></td>
								</tr>
								<tr>
									<td class="boldEleven">Branch</td>
									<td class="boldEleven"><select name="branch" id="branch"
										class="formText135" style="width:200px">
										<option value="-1">All</option>
									</select></td>
								</tr>
								<tr>
									<td class="boldEleven">office</td>
									<td class="boldEleven">
									<%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %> <select name="Office" class="formText135" id="Office">
										<option value="0">All</option>
										<%
								
		String sq=" select INT_OFFICEID,CHR_OFFICENAME from  com_m_office  order by CHR_OFFICENAME";

		String shipids[][] =  CommonFunctions.QueryExecute(sq);
		for(int u=0; u<shipids.length; u++)
			if(shipids[u][0].trim().equals(oficeid.trim()))
				out.print("<option selected = 'selected' value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
			else
				out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
			
				%>
									</select></td>
								</tr>
								<tr class="bolddeepblue">
                                  <td height="22" valign="middle" class="boldEleven">Department</td>
								  <td valign="top" class="bolddeepblue"><select name="dept"
								id="dept" class="formText135">
                                      <option value="0">All</option>
                                      <%
		sq="SELECT INT_DEPARTID,CHR_DEPARTNAME FROM   com_m_depart   ORDER BY  CHR_DEPARTNAME";
		String deptid[][] =  CommonFunctions.QueryExecute(sq);
		
		for(int u=0;u<deptid.length;u++)
			out.print("<option value='"+deptid[u][0]+"'>"+deptid[u][1]+"</option>"); 
	%>
                                  </select></td>
							  </tr>
								<tr>
                                  <td class="boldEleven">Category</td>
								  <td><select name="Category" class="formText135" id="Category">
                                      <option value="0">All</option>
                                      <%
	String empcategorysql=" SELECT INT_EMPLOYEECATEGORYID,CHR_CATEGORYNAME  FROM   com_m_employeecategory   ORDER BY CHR_CATEGORYNAME ";
	String empcategoryData[][] = CommonFunctions.QueryExecute(empcategorysql);
	if (empcategoryData.length>0)
		for (int i=0; i<empcategoryData.length; i++) 
			out.println("<option value="+empcategoryData[i][0]+">"+empcategoryData[i][1] +"</option>");			
	
						%>
                                  </select></td>
							  </tr>
								
								<tr>
									<td class="boldEleven">Paid Date</td>
									<td class="boldEleven">
									
																		
<select name="paiddate" class="formText135" id="paiddate">
 
<%
	String sql=" SELECT DATE_FORMAT(DAT_ACCDATE,'%Y-%m-%d'), DATE_FORMAT(DAT_ACCDATE,'%e-%M-%Y'),COUNT(*) FROM conveyance_t_conveyance WHERE CHR_ACCSTATUS='Y' GROUP BY DAT_ACCDATE ORDER BY DAT_ACCDATE DESC LIMIT 0,10";
	String Data[][] =  CommonFunctions.QueryExecute(sql);
	for(int u=0;u<Data.length;u++)
		out.println("<option value='"+Data[u][0]+"'>"+Data[u][1] + " - [ " +Data[u][2]+" ] </option>");
%>
</select>	

									
									  </a></td>
								</tr>
								<tr class="bolddeepblue">
                                  <td height="24" valign="middle" class="style4"><span class="boldEleven">Export Type</span> <span class="bolddeepred">*</span> </td>
								  <td valign="top" class="bolddeepblue"><span class="boldEleven">
                                    <select name="reportType" id="reportType">
                                      <option value="0">Select Export Type</option>
                                      <option value="csv">CSV</option>
                                      <option value="xls">Excel</option>
                                      <option value="html">HTML</option>
                                      <option value="pdf">PDF</option>
                                      <option value="txt">Text</option>
                                      <option value="rtf">Word</option>
                                      <option value="xml">XML</option>
                                    </select>
                                  </span></td>
							  </tr>
							</table>
							</td>
						</tr>
						<tr class="bolddeepblue">
							<td height="22" colspan="2" valign="middle" class="style3"><span class="boldEleven">
							  <input name="filename" type="hidden" id="filename"
										value="Rept_JBankDetail">
                              <input name="actionS"
										type="hidden" id="actionS"
										value="CONRept_JBankDetail">
                              <input name="rptfilename" type="hidden" id="rptfilename" value="PageWidth800">
                            </span>							</td>
						</tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<table width="142" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="61"><input name="Submit2" type="submit"
										class="buttonbold14" id="submit" value="Submit"   accesskey="s"   ></td>
									<td width="60"><input class="buttonbold14" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="redirect('Conveyancemain.jsp')"></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td width="135" height="2"></td>
							<td width="225"></td>
						</tr>
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
</table>
<%
}
catch(Exception e)
{
	 System.out.println(e.getMessage());
}
%>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>

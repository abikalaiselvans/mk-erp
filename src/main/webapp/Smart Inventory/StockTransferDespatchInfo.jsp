<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <style type="text/css">
 @import url("../JavaScript/SmartStyles.css");
 </style>
 
 <link href="../JavaScript/jquery/Time/jquery-ui.css" rel="stylesheet" type="text/css">
<link href="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui.min.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-sliderAccess.js"></script>
 

 
 
</head>
<%
	String sql="";
	String transNo=request.getParameter("transNo");
	sql=" SELECT CHR_STOCKTRANSFERID,INT_BRANCHID_FROM,INT_BRANCHID_TO,"
	+"DAT_TRANSFERDATE,CHR_DES,INT_STATUS,DAT_RECEIVEDDATE,FIND_A_EMPLOYEE_ID_NAME(CHR_TRANSFERBY),FIND_A_EMPLOYEE_ID_NAME(CHR_RECEIVEDBY), FUN_GET_BRANCH_NAME(INT_BRANCHID_FROM),FUN_GET_BRANCH_NAME(INT_BRANCHID_TO),INT_DIVIID from inv_t_stocktransfer "
	+" where CHR_STOCKTRANSFERID='"+transNo+"'";	
	String readData[][] =  CommonFunctions.QueryExecute(sql); 
	
	String fBarnch=readData[0][9];
	String tBarnch=readData[0][10];
	
	String status="";
	int s=Integer.parseInt(readData[0][5]);
	if(s==0)
		status="Transfered";
	else
		status="Received";	
 
%>
<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm"  onSubmit="return Validate()">
<div align="center"><br />
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="800"
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
					<table width="100%" border="0" align="center" cellpadding="1"
						cellspacing="1">

						<tr>
							<td width="650"></td>
						</tr>
						<tr>
							<td align="center" class="bolddeeplogin">
							<div align="center">Stock Transfer</div>							</td>
						</tr>
						<tr>
							<td>
							<table width="100%" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="154" class="boldEleven">
									<div align="left">Trans Ref No</div>									</td>
									<td width="176" class="boldEleven">
									<div align="left"><%=readData[0][0] %> <input
										name="salno" type="hidden" id="salno"
										value="<%=readData[0][0]%>"></div>									</td>
									<td width="184" class="boldEleven">
									<div align="left">
									<DIV align="left">Status</DIV>
									</div>									</td>
									<td width="253" class="boldEleven"><%=status %></td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">
									<DIV align="left">From Branch</DIV>
									</div>									</td>
									<td class="boldEleven"><%=fBarnch %></td>
									<td class="boldEleven">To Branch</td>
									<td class="boldEleven">
									<div align="left"><%=tBarnch	%>
									<div align="left"></div>									</td>
								</tr>
								<tr>
									<td class="boldEleven">Transfer Date</td>
									<td class="boldEleven"><%=readData[0][3] %></td>
									<td class="boldEleven">Received Date</td>
									<td class="boldEleven"><%=readData[0][6] %></td>
								</tr>
								<tr>
									<td class="boldEleven">Transfer By</td>
									<td class="boldEleven"><%=readData[0][7] %></td>
									<td class="boldEleven">Received By</td>
									<td class="boldEleven"><%=readData[0][8] %></td>
								</tr>
								<tr>
								  <td valign="top" class="boldEleven" id='kid1'>Courier Name<span class="boldElevenlink"> *</span></td>
								  <td class="boldEleven"  id='kid2'><select name="courier" id="courier" style="width:125" tabindex="1">
								    <option value="0">Select Courier</option>
								    <%
										String courierdata[][] =  CommonFunctions.QueryExecute("SELECT INT_COURIERID,CHR_COURIERNAME FROM inv_m_courier ORDER BY  CHR_COURIERNAME"); 
								for(int u=0; u<courierdata.length; u++)
									out.print("<option value='"+courierdata[u][0]+"'>"+courierdata[u][1]  +"</option>");
							%>
							      </select></td>
								  <td valign="top" class="boldEleven"><h1 class="boldEleven"><span id="ContentPlaceHolder1_TitleLabel"> </span>Despatch Through <span class="boldElevenlink">*</span></h1></td>
								  <td class="boldEleven"><select name="through"  id="through" style="width:125" onChange="courierEnable()">
								    <option value="0">Select Despatch</option>
								    <option value="C">Courier</option>
								    <option value="P">Person</option>
								    <option value="O">Own</option>
								    <option value="V">Vechicle</option>
							      </select></td>
							  </tr>
								<tr>
								  <td valign="top" class="boldEleven">Person/vehicle Name <span class="boldElevenlink"> *</span></td>
								  <td class="boldEleven"><input name="engname" type="text" class="formText135" id="engname" size="25" maxlength="50" style=" text-transform:uppercase" tabindex="2"></td>
								  <td valign="top" class="boldEleven">Despatch Date and Time <span class="boldElevenlink">*</span></td>
								  <td class="boldEleven"><input	name="startdate" type="text" class="formText135" id="startdate" onKeyPress="dateOnly(this)" size="25" maxlength="10" readonly />
                                  <script language="javascript">

setCurrentDateandTime('startdate'); 
$('#startdate').datetimepicker({
	showSecond: true,
	timeFormat: 'hh:mm:ss',
	stepHour: 1,
	stepMinute: 1,
	stepSecond: 10,
	minDate: -2, maxDate: "+1D" ,showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true
});

 
</script>
                                  </td>
							  </tr>
								<tr>
								  <td valign="top" class="boldEleven">Person/vehicle Contact <span class="boldElevenlink"> *</span></td>
								  <td class="boldEleven"><input name="engmobile" type="text" class="formText135" id="engmobile" size="25" maxlength="10" style=" text-transform:uppercase" tabindex="3"  onKeyPress="return numeric_only(event,'engmobile','12')"></td>
								  <td valign="top" class="boldEleven">Starting place<span class="boldElevenlink"> *</span></td>
								  <td class="boldEleven"><input name="starting" type="text" class="formText135" id="starting" style=" text-transform:uppercase" tabindex="5" value="<%=readData[0][9]%>" size="25" maxlength="50"></td>
							  </tr>
								<tr>
								  <td valign="top" class="boldEleven"  id='kid3'>Courier Amount </td>
								  <td class="boldEleven"   id='kid4'><input name="amount" type="text" class="formText135" id="amount" style='text-align:right' tabindex="4"   onKeyPress="return blockNonNumbers(this, event, true, true);"  onkeyup="extractNumber(this,2,true);"   value="0" size="25" maxlength="4"/></td>
								  <td valign="top" class="boldEleven">Ending Place <span class="boldElevenlink"> *</span></td>
								  <td class="boldEleven"><input name="endig" type="text" class="formText135" id="endig" style=" text-transform:uppercase" tabindex="6" value="<%=readData[0][10]%>" size="25" maxlength="50"></td>
							  </tr>
								<tr>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td valign="top" class="boldEleven">Travelling Kilometer <span class="boldElevenlink"> *</span></td>
								  <td class="boldEleven"><input name="kilometer" type="text"   class="formText135" id="kilometer" style='text-align:right' tabindex="4"   onKeyPress="return blockNonNumbers(this, event, true, true);"  onkeyup="extractNumber(this,2,true);" value="0" size="10" maxlength="4"/>
&nbsp;&nbsp;Pick the Kilometers
<!--<a href="javascript:pickupKilometer('Citydistance_Calculator.jsp')" ></a>-->
<script language="javascript">
								  
								  
function pickupKilometer(query)
{  
	try
	{		 
		var start = document.getElementById('starting').value;
		var end = document.getElementById('endig').value;
		if(start =="")
			start= prompt("Enter the starting place....","ABIRAMAPURAM, STORE"); 
		if(end =="")
			end = prompt("Enter the ending place....","TNAGAR, STORE"); 
		query = query+"?start="+start+"&end="+end;
		Printquery(query)	
		 
	}
	catch(err)
	{
		alert(err.description);
	}	
}

</script></td>
							  </tr>
								<tr>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td valign="top" class="boldEleven">Description<span class="boldElevenlink"> *</span></td>
								  <td class="boldEleven"><textarea name="description" cols="27" rows="5" class="formText135" id="description"  style=" text-transform:uppercase"  onKeyUp="textArea('description','450')"  tabindex="8" >Material Despatch for the Ref.No <%=transNo%></textarea></td>
							  </tr>
								<tr>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
							  </tr>
							</table>							</td>
						</tr>
						<tr>
							<td>
							  <div align="center">
							    <%
							
sql = " SELECT a.INT_ID , ";
sql = sql +" if( ";
sql = sql +" a.CHR_TYPE='I', ";
sql = sql +" (SELECT b.CHR_ITEMNAME FROM inv_m_item b WHERE b.CHR_ITEMID=a.CHR_ITEMID), ";
sql = sql +" (SELECT c.CHR_PRODUCTCODE FROM inv_m_produtlist c WHERE c.CHR_PRODUCTID=a.CHR_ITEMID)    ";
sql = sql +" ), ";
sql = sql +" if(a.CHR_TYPE='P','PRODUCT','ITEM'),  ";

sql = sql +" if( ";
sql = sql +" a.CHR_TYPE='I', ";
sql = sql +" (SELECT d.CHR_DES FROM inv_m_item d WHERE d.CHR_ITEMID=a.CHR_ITEMID), ";
sql = sql +" (SELECT e.CHR_PRODUCTDESC FROM inv_m_produtlist e WHERE e.CHR_PRODUCTID=a.CHR_ITEMID)    ";
sql = sql +" ), ";



sql = sql +" a.INT_QUANTITY  from inv_t_stocktransferitem  a WHERE a.CHR_STOCKTRANSFERID='"+readData[0][0]+"' ";
String saledata[][] = CommonFunctions.QueryExecute(sql);
out.println("<table width='80%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
out.println("<tr class='MRow1'>");
out.println("<td class='boldEleven'><b>S.No</b></td>");
out.println("<td class='boldEleven'><b>Type</b></td>");
out.println("<td class='boldEleven'><b>Item / Product </b></td>");
out.println("<td class='boldEleven'><b>Description</b></td>");
out.println("<td class='boldEleven'><b>Transfer Qty</b></td>");
out.println("</tr>");
if(saledata.length >0)
{
	for(int u=0; u<saledata.length;u++)
	{
		if(u%2==0)
			out.println("<tr class='MRow1'>");
		else
			out.println("<tr class='MRow2'>");	
		out.println("<td class='boldEleven'>"+(u+1)+".</td>");
		out.println("<td  class='boldEleven'>"+saledata[u][1]+"</td>");
		out.println("<td class='boldEleven'>"+saledata[u][2]+"</td>");
		out.println("<td class='boldEleven'  >"+saledata[u][3]+"</td>");
		out.println("<td class='boldEleven'  >"+saledata[u][4]+"</td>");
		out.println("</tr>");
	}
}
out.println("</table>");							
 %>
					          </div></td>
						</tr>
						<tr>
							<td><div align="center"></div></td>
						</tr>
						<tr>
							<td>
							  <div align="center">
							    <%
		
sql = " SELECT a.INT_ID,  ";
sql = sql+ " if(  ";
sql = sql+ " a.CHR_TYPE='I',  ";
sql = sql+ " (SELECT b.CHR_ITEMNAME FROM inv_m_item b WHERE b.CHR_ITEMID=a.CHR_ITEMID),  ";
sql = sql+ " (SELECT c.CHR_PRODUCTCODE FROM inv_m_produtlist c WHERE c.CHR_PRODUCTID=a.CHR_ITEMID)     ";
sql = sql+ " ),  ";
sql = sql+ " if(a.CHR_TYPE='P','PRODUCT','ITEM'),  ";
sql = sql+ " a.CHR_SERIALNO,a.CHR_WARRANTY,a.CHR_RECEIVEDBY, a.CHR_RECEIVEDSTATUS 	  ";
sql = sql+ " from inv_t_stocktransferitemserial a   ";
sql = sql+ " WHERE a.CHR_STOCKTRANSFERID='"+readData[0][0]+"' ";
String saledata1[][] = CommonFunctions.QueryExecute(sql);

if(saledata1.length >0)
{
	
	out.println("<table width='80%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.println("<tr class='MRow1'>");
	out.println("<td class='boldEleven'><b>S.No</b></td>");
	out.println("<td class='boldEleven'><b>Type</b></td>");
	out.println("<td class='boldEleven'><b>Item / Product </b></td>");
	out.println("<td class='boldEleven'><b>Serial</b></td>");
	out.println("<td class='boldEleven'><b>Warranty</b></td>");
	out.println("<td class='boldEleven'><b>Status</b></td>");
	out.println("</tr>");
	for(int u=0; u<saledata1.length;u++)
	{
		if(u%2==0)
			out.println("<tr class='MRow1'>");
		else
			out.println("<tr class='MRow2'>");	
		out.println("<td class='boldEleven'>"+(u+1)+".</td>");
		out.println("<td  class='boldEleven'>"+saledata1[u][1]+"</td>");
		out.println("<td class='boldEleven'>"+saledata1[u][2]+"</td>");
		out.println("<td class='boldEleven'  >"+saledata1[u][3]+"</td>");
		out.println("<td class='boldEleven'  >"+saledata1[u][4]+" -Years</td>");
		if("Y".equals(saledata1[u][6]))
			out.println("<td class='boldgreen'>Received</td>");
		else
			out.println("<td class='boldred'>Not Received</td>");
		out.println("</tr>");
	}
	out.println("</table>");
} 

 %> 
					                                   </div></td>
						</tr>
						 
						<tr>
							<td></td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<table width="100%" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="114" rowspan="4" valign="top" class="boldEleven">
									<div align="left">Memo</div>									</td>
									<td width="197" rowspan="4" valign="top" class="boldEleven">
									<div align="left"><%=readData[0][4] %></div>									</td>
									<td width="107" valign="top" class="boldEleven">
									<div align="left">&nbsp;</div>									</td>
									<td width="169" valign="top" class="boldEleven" id="totals1">
									<div align="right"></div>									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">&nbsp;</td>
									<td width="169" valign="top" class="boldEleven" id="totaldiscount1">&nbsp;</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
                                    <input name="filename" type="hidden" value="StockTransfer" /> 
                                    <input name="actionS"  type="hidden" value="INVStockTransDespatch" /> 
                                    <input type="hidden" name="transferno" id="transferno" value="<%=transNo%>">
                                     <input name="division" type="hidden" id="division" value="<%=readData[0][11]%>"></td>
									<td width="169" valign="top" class="boldEleven" id="tax1"> </td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">&nbsp;</td>
									<td width="169" valign="top" class="boldEleven" id="salestax1">&nbsp;</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<table width="133" border="0" align="center" cellpadding="3"
										cellspacing="3">
										<tr>
										  <td width="56"><input name='Submit' type='submit' class='tMLAscreenHead' value='Submit'></td>
											<td width="56"><input name="Submit2" type="button"
												class="tMLAscreenHead" value="  Close  "
												onClick="redirect('Stock Transfer.jsp')" /></td>
										</tr>
									</table>									</td>
								</tr>
							</table>							</td>
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
					<td height="6"><spacer height="1" width="1" type="block" />
					<div align="center"></div>
					</td>
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
</div>
<script language="javascript">
function Validate()
{
	try
	{	
 
		if(
				chechCourierThrough() 
				&& checkNull("starting" ,"Enter the starting place" )
				&& checkNull("endig" ,"Enter Ending Place" )
				&& checkNull("description" ,"Enter Courier Description" )
				 
		   )
		{
			
			var name=confirm("Confirm to Submit")
			if (name==true)
				return true;
			else
				return false;	
		}
		else
		{
				return false;				
		}	
	}	
	catch(err)
	{
		alert(err);
	}
} 		
	
	
function chechCourierThrough()
{
	try
	{
		 
		var c = document.getElementById('through').value;
		if(c!="C")
		{
			if(
				checkNullSelect('through' ,'Select Despatch Through','0' )
				&& checkNull("engname" ,"Enter the Engineer name" )
				&& checkNull("engmobile" ,"Enter the Engineer contact number" )
				&& checkNull("starting" ,"Enter the starting place" )
				&& checkNull("endig" ,"Enter Ending Place" )
				&& checkNull("kilometer" ,"Pick the kilometer"  )
			 )
			 	return true;
			else
				return false;	
		}
		else
		{
			if(checkNullSelect("courier" ,"Select Courier","0" ))
				return true;
			else
				return false;	
		}	
	}
	catch(err)
	{
		alert(err);
		return false;
		
	}
}	

function courierEnable()
{

 
	if(document.getElementById('through').value== "C" )
	{ 
		kid1.style.visibility="Visible";
		kid2.style.visibility="Visible";
		kid3.style.visibility="Visible";
		kid4.style.visibility="Visible";
		
	}	
	else  
	{
	
		kid1.style.visibility="hidden";
		kid2.style.visibility="hidden";
		kid3.style.visibility="hidden";
		kid4.style.visibility="hidden ";
		
	}	
}

 
</script>

</form>
<%@ include file="../footer.jsp"%>
</body>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ page import="com.my.org.erp.common.CommonFunction"%>
</html>

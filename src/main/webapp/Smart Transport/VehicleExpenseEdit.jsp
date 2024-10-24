<%@ page import="java.io.*,java.util.*"%>

<html>
<head>
<title> :: INVENTORY  ::</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<%
	String taxsql="";
	taxsql="SELECT  INT_ID,CHR_VEHICLEREGNO   FROM veh_m_vehicleinfo ORDER BY CHR_VEHICLEREGNO";
	String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(taxsql);
	String datas="";
	
	for(int u=0; u<data.length;u++)
		datas= datas+"<option value="+data[u][0]+">"+data[u][1]+"</option>";
	
%>

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"	type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InventAJAX.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenCustomerAJAX.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/Inventory/CustomerSalesCreditlimit.js"></script>
<script language="javascript">
var assigncontrol="";
 function resoffval()
{
	if(document.frm.Shipping[0].checked==true)
	{
		document.frm.shippingaddress.value=" ";
		document.getElementById('shippingaddress').disabled = true;
		document.getElementById("shippingaddress").style.visibility="hidden";
	}         
	else 
	{
		document.frm.shippingaddress.value=" ";
		document.getElementById("shippingaddress").style.visibility="visible";
		document.getElementById('shippingaddress').disabled = false;
	}
	return true;
}//end of resoffval




	var itemArray = new Array();
	var idrow=0;
	var deleteArray = new Array();
	var checkArray ;
	var drow=0;
	
	
	 
	//Intialise the Variables
	var row =1;
 	var r =1;
	var v1="";
 	var v2="";
 	var v3="";
 	var v4="";
 	var v5="";
 	var v6="";
 	var v7="";
 	var v8="";
 	var v9="";
 
 	//Dynamically insert a row in a table  -- ITEM
	function insRow()
	{
		var x=document.getElementById('myTable').insertRow(row)
		var s0= "vehileno"+r;
		var s1= "salary"+r;
		var s2 = "bata"+r;
		var s3 = "otherdesc"+r;
		var s4 = "otheramount"+r;
		var s5 = "total"+r;
		
		x.insertCell(0).innerHTML="<select  class='formText135'  name='"+s0+"' id ='"+s0+"' ><option value='Select'>Select</option><%=datas%></select>";
		x.insertCell(1).innerHTML="<input type='text' size=10 class='formText135' onblur=\"calaculatetotal(this,'"+s1+"')\" name='"+s1+"' id ='"+s1+"' style='text-align:right'/>";
		x.insertCell(2).innerHTML="<input type='text' size=10 class='formText135' onblur=\"calaculatetotal(this,'"+s1+"')\" name='"+s2+"' id ='"+s2+"' value='0' style='text-align:right'  />";
		x.insertCell(3).innerHTML="<input type='text' size=10 class='formText135' name='"+s3+"' id ='"+s3+"' value='0' style='text-align:right'  />";
		x.insertCell(4).innerHTML="<input type='text' size=10 class='formText135'  onblur=\"calaculatetotal(this,'"+s1+"')\" name='"+s4+"' id ='"+s4+"' value='0' style='text-align:right'  />";
		x.insertCell(5).innerHTML="<input type='text' size=10 class='formText135' name='"+s5+"' id ='"+s5+"' value='0' style='text-align:right'   value='0'/>";
		x.insertCell(6).innerHTML="<input class='buttonbold'  type='button' value='Delete' onclick='deleteRow(this.parentNode.parentNode.rowIndex,"+r+")' >";
		itemArray[idrow] = r	;
		row = row+1;
		r = r+1;
		idrow=idrow+1;
		display();
		document.getElementById('vehileno'+(r-1)).focus();
	}
 
 	function deleteRow(i,rx)
	{
		document.getElementById('myTable').deleteRow(i);
		row = row-1;
		if(row<=1)
			Load();
		deleteArray[drow] =rx;
		drow = drow+1;
		display();
		assigntotal() ;
	}

	function display()
	{
		var hs="";
		var hs1="";
		var hs2="";
		for(u=0; u<itemArray.length; u++)
			hs = hs+itemArray[u]+",";
		for(u=0; u<deleteArray.length; u++)
			hs1 = hs1+deleteArray[u]+",";
		
		var Array1 = hs.split(",");
		var Array2 = hs1.split(",");
		for(u=0; u<Array2.length; u++)
		{
			var a1value = Array2[u];
			for(v=0; v<Array1.length; v++)
			{
				if(Array2[u] == Array1[v])
					Array1[v]="";
			}
		}
		hs2="";
		for(v=0; v<Array1.length; v++)
			if(Array1[v]!="")
				hs2 = hs2 +	Array1[v]+",";
		
		checkArray = hs2.split(",");	
		document.getElementById('param').value=hs2;
		
	}
	
	
	 
function calaculatetotal(ctr,ctrassign)
{
	  var value =  ctr.value;
	  var idposition = ctrassign.replace("salary","");
	  var salary=parseFloat(document.getElementById("salary"+idposition).value);
	  var bata=parseFloat(document.getElementById("bata"+idposition).value);
	  var otheramount= parseFloat(document.getElementById("otheramount"+idposition).value);
	  document.getElementById("total"+idposition).value= (salary+bata+otheramount);
	  assigntotal() ;
} 
	 
	 
	 
function assigntotal() 
{
	var controls = document.getElementById('param').value;
	var vehiclearray = controls.split(",");
	var sum=0;
	var sum1=0;
	for(i=0;i<vehiclearray.length-1;i++)
	{
		var obj = findObj("total"+vehiclearray[i]);
		if(obj != null)
		{
			var total = document.getElementById("total"+vehiclearray[i]).value;
			sum1 = sum1+total;
			 
		}	
	}
	 
	document.getElementById('nettotal').value=Round(sum+sum1);
}
 
</script>
<body  onpaste='return false;'>
 <%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit=" return  Validate() ">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="700"
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
					<td width="680">
					<table cellspacing="2" cellpadding="2" width="87%" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="4" align="center" valign="top"
									class="boldThirteen">VEHICLE EXPENSES 
									
									<%
									
String serviceno = request.getParameter("id");
String sql = "   SELECT  INT_EXPENSEID, DATE_FORMAT(DAT_EXPENSEDATE,'%d-%m-%Y'),CHR_DESC,CHR_VEHICLEID,CHR_SALARY, ";
sql = sql+" CHR_BATA,CHR_OTHERDESC,CHR_OTHERAMOUNT,CHR_TOTAL,DOU_NETAMOUNT, ";
sql = sql+" CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS   FROM veh_t_expense  WHERE INT_EXPENSEID = "+serviceno;
String servicedata[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);


									%>	
									
									
								</td>
						    </tr>

							<tr>
								<td height="19" colspan="4" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
						    </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="errormessage">
							    </td>
					      </tr>
							<tr>
								<td width="118" height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
								<td width="199" align="left" valign="top"><!--DWLayoutEmptyCell-->&nbsp;																</td>
							    <td width="105" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
							    <td width="148" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;                                                                     </td>
							</tr>
							
							<tr>
							  <td height="17" valign="top" class="boldEleven"> date </td>
							  <td align="left"><span class="boldEleven">
							    <input tabindex="2"
										name="saleDate" type="text" class="formText135" id="saleDate"
										size="15" readonly="readonly" value="<%=servicedata[0][1]%>">
							    <a
										href="javascript:cal2.popup();"> <img
										src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" /> </a>
                                <script language='JavaScript'
										type="text/javascript">
		<!--			
				var cal2 = new calendar1(document.forms['frm'].elements['saleDate']);
				cal2.year_scroll = true;
				cal2.time_comp = false;
				 
		//-->
                                </script>
							  </span></td>
						      <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
						      <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Service Description</td>
							  <td colspan="3" align="left"><textarea name="memo" cols="20"
										rows="5" class="formText135" id="memo" tabindex="9"><%=servicedata[0][2]%></textarea>
							    <div align="left"></div></td>
					      </tr>
							<tr>
								<td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
								<td align="left"><span class="boldEleven">
								   
								</span></td>
							    <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
							    <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven">
							  <div id="divscroll" style="OVERFLOW:auto;width:100%;height:150px">
							<table width="100%" border="0" cellpadding="1" cellspacing="1"	id="myTable">
								<tr>
									<th class="boldEleven"><strong>Vehicle Number </strong></th>
									<th class="boldEleven"><strong>Salary</strong></th>
									<th class="boldEleven"><strong><b>Bata</strong></th>
									<th class="boldEleven"><strong><b>Other Desc</strong></th>
									<th class="boldEleven"><strong><b>Other Amount</strong></th>
									<th class="boldEleven"><strong><b>Total</strong></th>
								</tr>
							</table>
							</div>							  </td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">
							  <div align="left"><input id="buttonitemadd" type="button"
								class="tMLAscreenHead" onClick="insRow()" value="Add"
								tabindex="8" /></div>							  </td>
							  <td colspan="3" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td valign="top" class="boldEleven">Net Total </td>
							  <td valign="top" class="boldEleven"><input name="nettotal" type="text"
										class="formText135" id="nettotal"  
										style='text-align:right' tabindex="11"
										onKeyPress="doubleValue('totals','12')" value="<%=servicedata[0][9]%>" /></td>
						  </tr>
							<tr>
								<td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="3" align="left"><input name="filename" type="hidden" value="VehicleExpense" />
							    <input name="actionS"
									type="hidden" value="TRSVehicleExpenseEdit" />
							    <input name="param" type="hidden" id="param" value="0,">
							    <input name="id" type="hidden" id="id" value="<%=serviceno%>"></td>
							</tr>
							<tr>
								<td height="17" colspan="4" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" id="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
										<td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('VehicleExpense.jsp')"></td>
									</tr>
								</table>								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="3" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
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
 



<%
		String vehileno[]=servicedata[0][3].split(",");
		String salary[]=servicedata[0][4].split(",");
		String bata[]=servicedata[0][5].split(",");
		
		String otherdesc[]=servicedata[0][6].split(",");
		String otheramount[]=servicedata[0][7].split(",");
		String total[]=servicedata[0][8].split(",");
		
		
		String param="";
		for(int u=0; u<vehileno.length;u++)
		{
			param= param+(u+1)+",";
		%>
		
		
		  
  
  
  
  
  
 
		<script language="javascript" >
			insRow();
			var s1 ="vehileno<%=(u+1)%>";
			setOptionValue(s1,"<%=vehileno[u]%>");
			var s2 ="salary<%=(u+1)%>";	
			var s3 ="bata<%=(u+1)%>";
			
			var s4 ="otherdesc<%=(u+1)%>";
			var s5 ="otheramount<%=(u+1)%>";
			var s6 ="total<%=(u+1)%>";
			
			
			document.getElementById(s2).value="<%=salary[u]%>";
			document.getElementById(s3).value="<%=bata[u]%>";
			document.getElementById(s4).value="<%=otherdesc[u]%>";
			document.getElementById(s5).value="<%=otheramount[u]%>";
			document.getElementById(s6).value="<%=total[u]%>";
			 
		</script>
		<%
		//out.println("<tr><td class='boldEleven'>"+tdata[0][0]+"<td class='boldEleven' align='right'>"+taxvalue[u]+" %");
		//out.println("<td  class='boldEleven' align='right'>"+taxamount[u]);
		}	
		
		%>
		<script language="javascript">
		document.getElementById('param').value="<%=param%>";
		 
	 












function Validate()
  {

	 
	display();
	if(parseInt(checkArray.length-1)<1)
	{
		alert("Please Add atleast one vehicle...");
		document.getElementById('buttonitemadd').focus();
		return false;
	}
		
	if( checkNull( "saleDate","Enter Invoice Date" )
	 
	&& checkNull( "memo","Enter Description" )
	 
	 
	
	)
		return true;
	else
		return false;				
		
 } 	
 
  
</script> 
		<%@ include file="../footer.jsp"%></form>
</body>
</html>

<%@ page language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenCustomerAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/AJAX.js"></script>
 


<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
</head>
<body    onLoad="randomdisable()">
<%@ include file="indexinv.jsp"%>
<%
try
{ 
	String sql ="";
	String pono = request.getParameter("pono");
	String perdata[][]=CommonFunctions.QueryExecute("SELECT CHR_PURCHASEORDERNO,DAT_ORDERDATE,INT_VENDORID,INT_DIVIID,CHR_POREQUESTNO FROM inv_t_directpurchase WHERE CHR_PURCHASEORDERNO='"+pono+"'");
	
	
%>
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm"
	onSubmit="return Validate()">


<div align="center"><br />
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
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
					<table width="663" border="0" align="center" cellpadding="1"
						cellspacing="1">

						<tr>
							<td width="650"></td>
						</tr>
						<tr>
							<td>
							<div align="center"><strong>Direct Purchase Serial
							Number </strong></div>
							</td>
						</tr>
						<tr>
							<td>
							<table width="67" border="0" align="right" cellpadding="0"
								cellspacing="2">
								<tr>
									<td width="41" class="boldEleven">Item</td>
									<td width="24" class="MRow3">&nbsp;</td>
								</tr>
								<tr>
									<td height="22" class="boldEleven">Product</td>
									<td class="MRow4">&nbsp;</td>
								</tr>
							</table>
							</td>
						</tr>

						<tr>
							<td>
							<table width="673" border="0" align="center" cellpadding="5"
								cellspacing="5">
								<tr>
									<td width="119" valign="top" class="boldEleven">
									<div align="left">Purchase .No</div>
									</td>
									<td width="143" valign="top" class="boldEleven">
									<div align="left"><%=perdata[0][0]%> <input
										name="purchasenumber" type="hidden" id="purchasenumber"
										value="<%=perdata[0][0]%>"></div>
									</td>
									<td width="168" valign="top" class="boldEleven">
									<div align="left">Purchase Date</div>
									</td>
									<td width="178" valign="top" class="boldEleven">
									<div align="left"><%=perdata[0][1]%>
									  <input name="pdate" value="<%=perdata[0][1]%>" type="hidden" id="pdate">
									</div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Vendor name</div>
									</td>
									<td valign="top" class="boldEleven">
									<div align="left">
<%
sql =" SELECT  a.CHR_VENDORNAME,a.CHR_CONTACTPERSON,a.CHR_ADDRESS1,a.CHR_ADDRESS2, ";
sql = sql + " e.CHR_CITYNAME,d.CHR_DISTRICT,  ";
sql = sql + " c.CHR_STATENAME,   CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE),   ";
sql = sql + " a.INT_ACTIVE,a.CHR_PHONE,a.CHR_EMAIL     ";
sql = sql + " FROM  inv_m_vendorsinformation a, com_m_country b,com_m_state c,com_m_district d,  ";
sql = sql + " com_m_city e  ,inv_m_vendorsgroup f   ";
sql = sql + " WHERE a.INT_GROUPID = f.INT_GROUPID  ";
sql = sql + " AND a.INT_COUNTRYID = b.INT_COUNTRYID   "; 
sql = sql + " AND a.INT_STATEID =c.INT_STATEID     ";
sql = sql + " AND a.INT_DISTRICTID= d.INT_DISTRICTID  ";
sql = sql + " AND a.INT_CITYID =e.INT_CITYID AND INT_VENDORID="+perdata[0][2]; 
String vendor[][]=CommonFunctions.QueryExecute( sql);
out.println(vendor[0][0]);           	
						%>
									</div>
									</td>
									<td valign="top" class="boldEleven">
									<div align="left">Vendor Address</div>
									</td>
									<td valign="top" class="boldEleven">
									<div align="left">
									<%
							out.println(vendor[0][0]+"<br>");
							if(!"-".equals(vendor[0][1]))
								out.println(vendor[0][1]+",<br>");
							if(!"-".equals(vendor[0][2]))	
								out.println(vendor[0][2]+",<br>");
							if(!"-".equals(vendor[0][3]))
								out.println(vendor[0][3]+",<br>");
							if(!"-".equals(vendor[0][4]))
								out.println(vendor[0][4]+".<br>");
						%>
									</div>
									</td>
								</tr>

							</table>
							</td>
						</tr>
						<tr>
							<td height="9">
							<%
					  		
							
sql = " SELECT if(a.CHR_TYPE='I','ITEM','PRODUCT'), ";
sql = sql+ " if( ";
sql = sql+ " a.CHR_TYPE='I', ";
sql = sql+ " (SELECT b.CHR_ITEMNAME FROM inv_m_item b WHERE b.CHR_ITEMID= a.CHR_ITEMID) , ";
sql = sql+ " (SELECT c.CHR_PRODUCTCODE FROM inv_m_produtlist c WHERE c.CHR_PRODUCTID= a.CHR_ITEMID)  ";
sql = sql+ " ), ";
sql = sql+ " a.INT_QUANTITY ,a.INT_WARRANTY   ";
sql = sql+ " From  inv_t_directpurchaseitem a  ";
sql = sql+ " WHERE a.CHR_PURCHASEORDERNO ='"+pono+"'";
//out.println(sql);
String saledata[][] = CommonFunctions.QueryExecute(sql);
if(saledata.length>0)
{
	out.println("<table width='100%'  border='0' align='center'  cellpadding=2 cellspacing=1 bgcolor='#9900CC'  >");
	out.println("<tr class='MRow1'>");
	out.println("<td width='10%'  class='boldEleven'><b>S.No</b></td>");
	out.println("<td width='10%'  class='boldEleven'><b>Type</b></td>");
	out.println("<td width='21%'  class='boldEleven'><b>Item / Product</b></td>");
	out.println("<td width='15%'  class='boldEleven'><b>Order Qty / Units</b></td>");
	out.println("<td width='15%'  class='boldEleven'><b>Warranty</b></td>");
	out.println("</tr>");
	for(int u=0; u<saledata.length;u++)
	{
	
		if(u%2==0)
			out.println("<tr class='MRow1'>");
		else
			out.println("<tr class='MRow2'>");
			
		out.println("<td class='boldEleven' >"+(u+1)+".</td>");
		out.println("<td class='boldEleven'>"+saledata[u][0]+"</td>");
		out.println("<td class='boldEleven'>"+saledata[u][1]+"</td>");
		out.println("<td class='boldEleven' align='right'>"+saledata[u][2]+"</td>");
		out.println("<td class='boldEleven' align='center'>"+saledata[u][3]+" - Yrs</td>");
									 
		
	}
	out.println("</table>");
}	
%>
							</td>
						</tr>
						<tr>
							<td height="9">
							<div align="center" id="error" class="bolddeepred"></div>
							</td>
						</tr>
						<tr>
							<td height="9">
							<div align="center">
							<%
	
	
sql = " SELECT a.INT_ID,a.CHR_TYPE,a.CHR_ITEMID,a.CHR_PURCHASEORDERNO, ";
sql = sql + " if(a.CHR_TYPE='I','ITEM','PRODUCT'), ";

sql = sql + " if( ";
sql = sql + " a.CHR_TYPE='I', ";
sql = sql + " (SELECT b.CHR_ITEMNAME FROM inv_m_item b WHERE b.CHR_ITEMID= a.CHR_ITEMID) , ";
sql = sql + " (SELECT c.CHR_PRODUCTCODE FROM inv_m_produtlist c WHERE c.CHR_PRODUCTID= a.CHR_ITEMID)  ";
sql = sql + " ), ";

sql = sql + " if( ";
sql = sql + " a.CHR_TYPE='I', ";
sql = sql + " (SELECT d.CHR_WARRANTY FROM inv_m_item d WHERE d.CHR_ITEMID= a.CHR_ITEMID) , ";
sql = sql + " (SELECT e.CHR_WARRANTY FROM inv_m_produtlist e WHERE e.CHR_PRODUCTID= a.CHR_ITEMID)  ";
sql = sql + " ), ";

sql = sql + " a.CHR_SERIALNO,a.CHR_WARRANTY  ";
sql = sql + " FROM inv_t_vendorgoodsreceived a ";
sql = sql + " WHERE CHR_PURCHASEORDERNO ='"+pono+"'";
sql = sql + " ORDER By a.INT_ID  ";
//out.println(sql);
String recdData[][] = CommonFunctions.emptyQueryExecute(sql);
int row=1;
String mwaranty="";
if(recdData.length>0)
{
	
	
	out.print("<div align='center' id='divscroll' style='OVERFLOW:auto;width:600px;  ' class='boldEleven'>");
	out.print(" <table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.print("<tr class='MRow1'>");
	out.print("<th class='boldEleven'><b>S.No</b></th>");
	out.print("<th class='boldEleven'><b>Type</b></th>");
	out.print("<th class='boldEleven'><b>Item / Product</b></th>");
	out.print("<th class='boldEleven'><b>Serial No</b></th> ");
	out.print("<th class='boldEleven'><b>Warranty</b></th>");
	out.print("<th class='boldEleven'><b>Status</b></th>");
	out.print("</tr>");
	String h="";
	String h1="";
	for(int v=0;v<recdData.length; v++)
	{
		if(v%2==0)
			out.println("<tr class='MRow1'>");
		else
			out.println("<tr class='MRow2'>");
			
		out.println("<td class='boldEleven' >"+(v+1)+".</td>");
		out.println("<td class='boldEleven'>"+recdData[v][4]+"</td>");
		out.println("<td class='boldEleven'>"+recdData[v][5]+"</td>");	
		
		 h=" onBlur=\"LoadUniqueCheck('serial"+(v+1)+"','Valid"+(v+1)+"' , 'inv_t_vendorgoodsreceived','CHR_SERIALNO','Submit'),getValues('serial','"+recdData.length+"' ,'error' , 'Submit')\" ";
				
		h1="  onkeyup=\"upperMe(this),LoadUniqueCheck('serial"+(v+1)+"','Valid"+(v+1)+"' , 'inv_t_vendorgoodsreceived','CHR_SERIALNO','Submit')\"  ";
		
		out.print("<td>");
			out.print(" <table align=left cellpadding=0 cellspacing=0 border=0>");
			out.print(" <tr>");
			out.print(" <td><input "+h+h1+" name='serial"+row+"'   id='serial"+row+"' class='formText135' maxlength='50' size=20 	                        type='text' value='"+recdData[v][7]+"'></td>");
			out.print(" <td><div id='Valid"+row+"'></DIV></td>");
			out.print(" </table>");
		out.print("</td>");
	
	
	
		mwaranty =recdData[v][8];
		out.print("<td>");
			out.print("<select name='warranty"+row+"' id='warranty"+row+"' class='formText135' >");
		%> <jsp:include page="Warranty.jsp" flush="true" /> <%
		out.println("</select>");
		%> <script language="javascript">setOptionValue('<%="warranty"+row%>','<%=mwaranty%>')</script> 
		<%
		 
		out.print("<input name='rowid"+row+"' type='hidden' value='"+recdData[v][0]+"'>");
		out.print("<input name='itype"+row+"' type='hidden' value='"+recdData[v][1]+"'>");
		out.print("<input name='item"+row+"' type='hidden'  value='"+recdData[v][2]+"'>");
		out.print("</td>");
		
		out.print("<td><select name=\"good"+row+"\"  id=\"good"+row+"\" >");
		out.print("<option value='Y' selected=selected >Good");
		out.print("<option value='N'  >Fault");
		out.print("</select></tr>");
		row= row+1;
	
	}
	out.print("</table> ");
	out.print("</div> ");
	out.println("<input type='hidden' name='length' id='length' value='"+row+"'>");
	out.println("<input type='hidden' name='salesno' id='salesno' value='"+pono+"'>");  

}

 	
%>
							</div>
							<input name="seriallength" type="hidden" id="seriallength" value="<%=row %>"></td>
						</tr>
						<tr>
							<td>
							<%
					  	if(row>=10)
						{
					  %>
							<table width="567" height="22" border="0" align="center"
								cellpadding="0" cellspacing="0">
								<tr>
									<td valign="top" class="bolddeeplogin">Auto Assign</td>
									<td valign="top" class="bolddeeplogin"><input name="autoassign"
										type="text" class="formText135" id="autoassign"
										onBlur="autoserialAssign()"> (E.g 12,10,5,)</td>
								    <td valign="top" class="bolddeeplogin"><div align="right">
								      <textarea name="randomserials" cols="25" rows="5" id="randomserials"></textarea>
							        </div></td>
								    <td valign="top" class="bolddeeplogin" ><a href='javascript:assignrandomserial()'>Random Assign  </a><br>(E.g S12,S10,S5,)</td>
								</tr>
							</table>
							<%
					  }
					  %>
							</td>
						</tr>
						<tr>
							<td><input name="filename" type="hidden"
								value="DirectPurchase" /> <input name="actionS" type="hidden"
								value="INVDirectPurchaseAddserial" />
						    <input name="division" type="hidden" id="division" value="<%=perdata[0][3]%>">
                            
                            <%
							String buybackstocktype="N";
							sql = "SELECT COUNT(*) FROM inv_t_purchaserequest WHERE CHR_BYBACK= 'Y' AND CHR_POREQUESTNO='"+perdata[0][4]+"'";
							if("1".equals(CommonFunctions.QueryExecute(sql)[0][0]))
								buybackstocktype ="Y";
								
							%>
                             <input name="buybackstocktype" type="hidden" id="buybackstocktype" value="<%=buybackstocktype%>"> 
                            </td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td height="38" valign="top" class="boldEleven">
							<table width="56" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="56"><input name="Submit"   id="Submit" type="submit"
										class="buttonbold" value="Submit"   accesskey="s"   ></td>
									
								</tr>
							</table>
							</td>
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
</div>

<script language="JavaScript">
function autoserialAssign()
{
	 var avalue = document.getElementById("autoassign").value;
	var avalues = avalue.split(",");
	var sum=0
	var asum =parseInt("<%=row%>");
	for(i=1 ;i<avalues.length;i++)
	{
		sum= sum+parseInt(avalues[i-1]);
		 
	}
	 
	if(asum = sum)
	{	
		var j=1;
		for(i=1 ;i<avalues.length;i++)
		{
			var k= avalues[i-1];
			var startwiths	=	prompt("Please enter Starting with","Mythra");
			
			startwiths = startwiths.toUpperCase( );
			var startingno	=	parseInt(prompt("Please enter Starting number","01"));;
			var asval="";
			for(x=1;x<=k;x++)
			{
				if(startingno<10)
					asval = startwiths+"0"+startingno;
				else
					asval = startwiths+startingno
					
				startingno = (startingno+1);
				var ss ="serial"+j;
				j=j+1;
				//alert(asval);	
				document.getElementById(ss).value=asval;
			}
			
		}
		document.getElementById("serial1").focus(); 
	}
	else
	{
		alert("Check with data...");
		document.getElementById("autoassign").value="";
		document.getElementById("autoassign").focus();
	}	
}



function getValuesreturns(validstring,divname,buttonname)
 {
	
	return duplicateCheckreturn(validstring,name,divname,buttonname) ;
 }
	 

function Validate()
{
	var v ="<%=recdData.length%>";
	 
	var validstring="";
	for( i=1 ;i<=v;i++)
		validstring = validstring+document.getElementById(("serial"+i)).value+",";
	
	 
	 
	 
	//if(getValuesreturns(validstring,'error','Submit'))
	{
			for( i=1 ;i<=v;i++)
				if(checkNull( ("serial"+i),("Enter Serial Number"+i) ))
						d=1;
				else
						return false;				
	}
	/*else
	{
		alert("check your serial number");
		document.getElementById('error').innerHTML ="<b><font class='bolddeepred'>check your serial number</font></b>";
		return false;			
	}*/	
} 	
  
  
  
  
  
function assignrandomserial()
 {
 	var l=parseInt("<%=row%>");
 	var randomss = document.getElementById('randomserials').value;
	if(randomss=="")
	{
		alert("Check Random Serial Number...");
		document.getElementById('randomserials').focus();
	}
	else
	{
		var arrayarandomserial = randomss.split(",");
		if(arrayarandomserial.length<1)
		{
			alert("Check Random Serial Number...");
		}
		else
		{
			var seriallength = parseInt(arrayarandomserial.length);
			for(u=0;u<seriallength;u++)
				{
					var ty="serial"+(u+1);
					var obj = findObj(ty);
					if(obj != null)
						document.getElementById(ty).value=arrayarandomserial[u];
					
				}
				document.getElementById('serial1').focus();
			
				
		}
	}	
 }  
  
</script> 


<%
}
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
  
%>
</form>
<%@ include file="../footer.jsp"%>

</body>

</html>

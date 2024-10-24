<%@ page language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
 		
 
<head>
 <title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenCustomerAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/AJAX.js"></script>
 


</head>
<body    onLoad="randomdisable()">
<%@ include file="indexinv.jsp"%>
<%
try
{ 
	String sql ="";
	String pono = request.getParameter("pono");
	String perdata[][]=CommonFunctions.QueryExecute("SELECT CHR_PURCHASENO,DATE_FORMAT(DAT_ORDERDATE,'%d-%b-%Y'),INT_VENDORID FROM inv_t_sparepurchase WHERE CHR_PURCHASENO='"+pono+"'");
%>

<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">


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
					<td colspan="2" rowspan="2" valign="top"><img height="7" src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7" src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1" type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412">
					<table width="663" border="0" align="center" cellpadding="1"
						cellspacing="1">

						<tr>
							<td width="650"></td>
						</tr>
						<tr>
							<td>
							<div align="center"><strong>Spare Purchase Serial
							Number </strong></div>
							</td>
						</tr>
						<tr>
							<td>
							 
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
									<div align="left"><%=perdata[0][1]%></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Vendor Name</div>
									</td>
									<td valign="top" class="boldEleven">
									<div align="left">
		<%
		sql =" SELECT CHR_VENDORNAME,CHR_STREET,CHR_STREET1,CHR_CITY,CHR_MOBILE FROM  inv_m_vendorsinformation  WHERE INT_VENDORID="+perdata[0][2];
		String vendor[][]=CommonFunctions.QueryExecute(sql);
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
sql = " SELECT a.INT_SPAREID,b.CHR_SPARENAME,a.CHR_DESC ,a.INT_QUANTITY , ";
sql = sql +" a.DOU_UNITPRICE,a.DOU_DISCOUNT,a.DOU_UNITDISCOUNT, ";
sql = sql +" c.CHR_TAXNAME,a.DOU_TAX_PERCENTAGE,a.DOU_TAX_AMOUNT, ";
sql = sql +" a.DOU_TOTAL ";
sql = sql +" From  inv_t_sparepurchaseitem a, inv_m_spare b, inv_m_tax c ";
sql = sql +" WHERE a.INT_SPAREID =b.INT_SPAREID AND a.INT_TAXID = c.INT_TAXID ";
sql = sql +" AND a.CHR_PURCHASENO ='"+pono+"' ";
String saledata[][] = CommonFunctions.QueryExecute(sql);
if(saledata.length>0)
{
	out.println("<center>");
	out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.println("<tr class='MRow1' >");
	out.println("<td class='boldEleven'><b>S.No</b></td>");
	out.println("<td class='boldEleven'><b>Spare</b></td>");
	out.println("<td class='boldEleven'><b>Description</b></td>");
	out.println("<td class='boldEleven'><b>Qty / Units</b></td>");
	out.println("<td class='boldEleven'><b>Unit Price</b></td>");
	out.println("<td class='boldEleven'><b>Discount(%)</b></td>");
	out.println("<td class='boldEleven'><b>Unit Discount</b></td>");
	out.println("<td class='boldEleven'><b>Tax</b></td>");
	out.println("<td class='boldEleven'><b>Tax (%)</b></td>");
	out.println("<td class='boldEleven'><b>Tax Amount </b></td>");
	out.println("<td class='boldEleven'><b>Total</b></td>");
	out.println("</tr>");
	for(int u=0; u<saledata.length;u++)
	{
		if(u%2==0)
			out.println("<tr class='MRow1'  >");
		else
			out.println("<tr class='MRow2'  >");
			
		out.println("<td class='boldEleven' >"+(u+1)+".</td>");
		out.println("<td class='boldEleven' align='left'>"+saledata[u][1] +"</td>");
		out.println("<td class='boldEleven' align='left'>"+saledata[u][2] +"</td>");
		out.println("<td class='boldEleven' align='right'>"+saledata[u][3] +"</td>");
		out.println("<td class='boldEleven' align='right'>"+saledata[u][4] +"</td>");
		out.println("<td class='boldEleven' align='right'>"+saledata[u][5] +"</td>");
		out.println("<td class='boldEleven' align='right'>"+saledata[u][6] +"</td>");
		out.println("<td class='boldEleven' align='left'>"+saledata[u][7] +"</td>");
		out.println("<td class='boldEleven' align='right'>"+saledata[u][8] +"</td>");
		out.println("<td class='boldEleven' align='right'>"+saledata[u][9] +"</td>");
		out.println("<td class='boldEleven' align='right'>"+saledata[u][10] +"</td>");
		out.println("</tr>");
									
	}
	out.println("</table>");
	out.println("</center>");
	
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

sql =" SELECT a.INT_SERIALID,a.INT_SPAREID,b.CHR_SPARENAME,a.CHR_SERIALNO ,b.CHR_WARRANTY  ";
sql = sql +"  From  inv_t_sparegoodsreceived a, inv_m_spare b   "; 
sql = sql +"  WHERE a.INT_SPAREID =b.INT_SPAREID    ";
sql = sql +"  AND a.CHR_PURCHASENO ='"+pono+"' ORDER By a.INT_SERIALID";
String recdData[][] = CommonFunctions.QueryExecute(sql);
if(recdData.length>0)
	for(int v=0;v<recdData.length; v++)
		if("-".equals(recdData[v][3]))
			recdData[v][3]="";
			
String checkajax="";
String checkajax1="";
int row=1;
if(recdData.length>0)
{
	  
	out.print("<div align='center' id='divscroll' style='OVERFLOW:auto;width:600px;height:400px' class='boldEleven'>");
	out.print(" <table width='100%'  class='boldEleven'  id='myTable'  cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.print("<tr class='MRow1'>");
	out.print("<th   class='boldEleven'><b>S.NO</b></th>");
	out.print("<th   class='boldEleven'><b>Spare</b></th>");
	out.print("<th   class='boldEleven'><b>Serial No</b></th> ");
	out.print("<th   class='boldEleven'><b>Warranty</b></th>");
	out.print("<th   class='boldEleven'><b>Status</b></th>");
	out.print("</tr>");
	row=1;
	for(int v=0;v<recdData.length; v++)
	{	
		if(v%2==0)
			out.println("<tr class='MRow1'  >");
		else
			out.println("<tr class='MRow2'  >");
			
		out.println("<td class='boldEleven' >"+(v+1)+"</td>");
	 	out.println("<td class='boldEleven'>"+recdData[v][2] +"</td>");
		
		checkajax=" onBlur=\" LoadUniqueCheck('serial"+(v+1)+"','Valid"+(v+1)+"' , 'inv_t_sparegoodsreceived','CHR_SERIALNO','Submit'),getValues('serial','"+recdData.length+"' ,'error' , 'Submit')\" ";
				
		checkajax1="  onkeyup=\"upperMe(this),LoadUniqueCheck('serial"+(v+1)+"','Valid"+(v+1)+"' , 'inv_t_sparegoodsreceived','CHR_SERIALNO','Submit')\"  ";
		
		out.println("<td class='boldEleven'>");
			out.print("<table align=left cellpadding=0 cellspacing=0 border=0>");
			out.print("<tr>");
			out.print("<td>");
			out.print("<input "+checkajax+" name='serial"+row+"' id='serial"+row+"' "+checkajax1+" class='formText135' maxlength='50' size=20 type='text' value='"+recdData[v][3]+"'></td>");
			out.print("<td><div id='Valid"+row+"'></DIV></td>");
			out.print("</table>");
		out.print("</td>");
		
		out.println("<td class='boldEleven'>");
			out.print("<select name='warranty"+row+"' id='warranty"+row+"' class='formText135' >");
		%> 
			<jsp:include page="Warranty.jsp" flush="true" /> 
		<%
			out.println("</select>");
			out.println("<script language=\"javascript\">setOptionValue('warranty"+row+"','"+recdData[v][4]+"'); </script>");
		
		out.print("<input name='rowid"+row+"' id='rowid"+row+"' type='hidden' value='"+recdData[v][0]+"'>");
		out.print("</td>");
		
		out.println("<td class='boldEleven'>");
		out.print("<select name=\"good"+row+"\"  id=\"good"+row+"\" >");
		out.print("<option value='Y' selected=selected >Good");
		out.print("<option value='N'  >Fault");
		out.print("</select></td>");
		
		out.print("</tr>");
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
							<td>
	<input name="filename" type="hidden" value="SparePurchase" /> 
	<input name="actionS" type="hidden" value="INVSparePurchaseAddserial" />
	
	</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td height="38" valign="top" class="boldEleven">
<table width="147" border="0" align="center" cellpadding="3" cellspacing="3">
<tr>
	<td width="56"> <input name="Submit"   id="Submit" type="submit" class="tMLAscreenHead" value="Submit"   accesskey="s"   ></td>
	<td width="56"> <input name="Close"  type="button" class="tMLAscreenHead"  value="Close"   accesskey="c" onClick="redirect('SpareInwardView.jsp')" /></td>
</tr>
</table>
							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1" type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"><spacer height="1" width="1" type="block" /></td>
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
	
	{
			for( i=1 ;i<=v;i++)
				if(checkNull( ("serial"+i),("Enter Serial Number"+i) ))
						d=1;
				else
						return false;				
	}
	
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
 	System.out.println(e.getMessage());
 }
  
%>
</form>
<%@ include file="../footer.jsp"%>

</body>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
</html>

<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage="../error/index.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript"
	src="../JavaScript/Inventory/InvenCustomerAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/AJAX.js"></script>

<script language="javascript">
var ItemSerial=[
<%
String	sql=" SELECT CHR_ITEMID,CHR_SERIALNO from inv_t_vendorgoodsreceived where "+
" CHR_SERIALNO IS NOT NULL ORDER BY CHR_ITEMID";
String serialValue[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
for(int i=0;i<serialValue.length;i++)
{
	out.print("[\""+serialValue[i][0]+"\",\""+serialValue[i][1]+"\"],");
}
%>
];
	function CheckSerialNoValue(ser)	
	{		
		var txt=ser.value;
		var nam=ser.name;
		var namF=nam.substring(6);
		var valN= document.getElementById("item"+namF).value;
		var arrLen=ItemSerial.length;				
	    var found=0;
		for(i=0;i<arrLen-1;i++)
		{
			itm=ItemSerial[i][0];
			itmSer=ItemSerial[i][1];
			itmSer=itmSer.toUpperCase();
			txt=txt.toUpperCase();			
			tlen=txt.length;
			slen=itmSer.length;
			if(itm==valN && itmSer==txt)
			{
				found=1;
				break;
		    }
	    }	    
	    if(txt=="")  {
   			alert("Enter Correct Serial No....");
			return false;	    
	    }		  
		else if(found==1){
			alert("Serail Already Exits!");
			document.getElementById(nam).focus();
			return false;
		}		
	  var slen=document.getElementById('seriallength').value;
      txt=txt.toUpperCase();
	  for(i=1;i<slen;i++)
	  {
		txt1=document.getElementById("serail"+i).value;
		txt1=txt1.toUpperCase();		
	//	alert("TXT :"+txt +" -- TXT1 :"+txt1+ " LEN ::"+slen);
		if(txt1==txt && i != namF)
		{
			alert("Serail Already Entered...");
			document.getElementById("serail"+namF).focus();
			return false;
		}
	  }		
	}
	
	function checkSerialNo(ser)
	{
		var txt=ser.value;
		var nam=ser.name;
		var namF=nam.substring(6);
		var valN= document.getElementById("item"+namF).value;
		var arrLen=ItemSerial.length;
		var res="<font color='Red'> InValid</font>";
		var myTab="<div id='divscroll'  class='boldEleven'>";
		var flag=false;
		for(i=0;i<arrLen-1;i++)
		{
			itm=ItemSerial[i][0];
			itmSer=ItemSerial[i][1];
			itmSer=itmSer.toUpperCase();
			txt=txt.toUpperCase();			
			tlen=txt.length;
			slen=itmSer.length;
			//if(tlen<=slen)
			//{			
		//	 itmSer1=itmSer.substring(0,tlen)			 
			 if(itm==valN && itmSer==txt)
			 {			     
		 		 flag=true;
		 		 break;
		     } 
		   // }		   
		}
		if(txt=="") 
		  myTab=myTab+"<font color='red'>Enter Valid Serail No</font></div>";
		else if(flag==true)
			myTab=myTab+"<font color='red'>Serial Already Exits</font></div>";
		else
			myTab=myTab+"<font color='blue'>Valid Serial</font></div>";
		document.getElementById('Valid'+namF).innerHTML=myTab;

	}
	
 
</script>


</head>
<body >
<%@ include file="indexinv.jsp"%>
<%
try
{ 
	String salesno = request.getParameter("salno");
	String perdata[][]=com.my.org.erp.common.CommonInfo.RecordSetArray("SELECT * FROM inv_t_directpurchase WHERE CHR_PURCHASEORDERNO='"+salesno+"'");
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
							<table width="673" border="0" align="center" cellpadding="5"
								cellspacing="5">
								<tr>
									<td width="119" valign="top" class="boldEleven">
									<div align="left">Purchase .No</div>
									</td>
									<td width="143" valign="top" class="boldEleven">
									<div align="left"><%=perdata[0][3]%> <input
										name="purchasenumber" type="hidden" id="purchasenumber"
										value="<%=perdata[0][3]%>"></div>
									</td>
									<td width="168" valign="top" class="boldEleven">
									<div align="left">Sale Date</div>
									</td>
									<td width="178" valign="top" class="boldEleven">
									<div align="left"><%=perdata[0][4]%></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">CustomerName</div>
									</td>
									<td valign="top" class="boldEleven">
									<div align="left"><%=perdata[0][6]%></div>
									</td>
									<td valign="top" class="boldEleven">
									<div align="left">Customer Address</div>
									</td>
									<td valign="top" class="boldEleven">
									<div align="left"><%=perdata[0][7]%></div>
									</td>
								</tr>

							</table>
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
	
	sql = "SELECT INT_ID,CHR_PURCHASEORDERNO,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY ,CHR_TYPE FROM inv_t_vendorgoodsreceived WHERE CHR_PURCHASEORDERNO ='"+salesno+"' ORDER By INT_ID";
	
	
	String recdData[][]= com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
	out.print("<div align='center' id='divscroll' style='OVERFLOW:auto;width:550px;height:200px' class='boldEleven'>");
	out.print(" <table width='100%' border='1' cellpadding='1' cellspacing='1' >");
	out.print("<th   class='boldEleven'><b>Type</b></th>");
	out.print("<th   class='boldEleven'><b>Item / Product</b></th>");
	out.print("<th   class='boldEleven'><b>Serial No</b></th> ");
	out.print("<th   class='boldEleven'><b>Warranty</b></th>");
	int row=1;
	String iname="";
	String itemname="";
	String h="";
	String h1="";
	for(int v=0;v<recdData.length; v++)
	{	
		out.print("<tr>");
		if(recdData[v][5].equals("I"))
		{
			iname="Item";
			sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+recdData[v][2]+"'";
			itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
		}	
		if(recdData[v][5].equals("P"))
		{
		  iname="Product";
		  sql= "SELECT CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+recdData[v][2]+"'";
		  itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
		}	
		out.println("<tr><td   class='boldEleven' >"+iname+"</td>");
		out.println("<td  class='boldEleven' >"+itemname);
		if(recdData.length>1)
			h=" onBlur=\"getValues('serial','"+recdData.length+"' ,'error' , 'Submit')\" ";
			
h1="  onkeyup=\"upperMe(this),LoadUniqueCheck('serial"+(v+1)+"','Valid"+(v+1)+"' , 'inv_t_vendorgoodsreceived','CHR_SERIALNO','Submit')\"  ";
  
		if("-".equals(recdData[v][3]))
			recdData[v][3]="";
			
		out.print("<td   class='boldEleven' >"+recdData[v][3]+"</td>");
		 
		if("-".equals(recdData[v][4]))
			recdData[v][4]="";
			
		out.print("<td   class='boldEleven' >"+recdData[v][4]+" Years</td>");
		out.print("</tr>");
		row= row+1;
	}
	out.print("</table> ");
	out.print("</div> ");
	out.println("<input type='hidden' name='length' id='length' value='"+row+"'>");
	out.println("<input type='hidden' name='salesno' id='salesno' value='"+salesno+"'>");  
%>
							</div>
							<input name="seriallength" type="hidden" id="seriallength"
								value="<%=row %>"></td>
						</tr>
						<tr>
							<td><input name="filename" type="hidden"
								value="DirectPurchase" /> <input name="actionS" type="hidden"
								value="INVDirectPurchaseAddserial" /></td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td height="38" valign="top" class="boldEleven">
							<table width="68" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="56"><input name="Submit2" type="button"
										class="buttonbold"  value="Close"   accesskey="c" 
										onClick="redirect('Direct Purchase.jsp')"></td>
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

function Validate()
  {
	var v ="<%=recdData.length%>";
	for( i=1 ;i<=v;i++)
		if(checkNull( ("serial"+i),("Enter Serial Number"+i) ))
		{
				d=1;
		}
		else
		{
				return false;				
		}	
		
  } 	
</script> <%
}
 catch(Exception e)
 {
 	out.println(e.getMessage());
 }
  
%>
</form>
<%@ include file="../footer.jsp"%>

</body>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
</html>

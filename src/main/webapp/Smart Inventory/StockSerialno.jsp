<%@ page import="java.io.*,java.util.*" isErrorPage="false"
	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
 


<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/AJAX.js"></script>

<script language="javascript">
var ItemSerial=[
<%
String	sql=" SELECT CHR_ITEMID,CHR_SERIALNO from inv_t_vendorgoodsreceived where CHR_FLAG='N'"+
"AND CHR_GRTFLAG='N' AND CHR_SERIALNO IS NOT NULL ORDER BY CHR_ITEMID";
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
		var slen=document.getElementById('seriallength').value;
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
		alert(found);
		if(found==1)
		{
			alert("Enter Correct Serial No....");
			document.getElementById(nam).focus();
			return false;
		}
					  	  	  
      txt=txt.toUpperCase();
	  for(i=1;i<=slen;i++)
	  {
		txt1=document.getElementById("serail"+i).value;
		txt1=txt1.toUpperCase();		
		alert("TXT :"+txt +" -- TXT1 :"+txt1);
		if(txt1==txt && i != namF)
		{
			alert("Serail Already Entered...");
			document.getElementById("serail"+namF).focus();
			return false;
		}
	  }		
	  alert();
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
	
	
	function valid()
	{
   		var s = parseInt(document.getElementById('seriallength').value);
		var ss = "";
		for(j=1;j<=s;j++)
			ss= ss+"serial"+j+",";
		var v = ss.split(",");
   		var flag =false;
		for( i=0; i<v.length-1; i++)
		{
			var chk =document.getElementById(v[i]).value;
			var ck = "Enter Data..."+v[i];
			if(checkNull(v[i],ck))
				d=1;
			else
				return false;				
		}
	}
	
</script>
<body >
<%@ include file="indexinv.jsp"%>
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
					<%	
		   	try
			{
			  	String recId=request.getParameter("recId");
			  	sql = "SELECT DAT_RECIVEDDATE,CHR_RECIVEDBY FROM inv_t_vendorgoodsreceived WHERE CHR_PURCHASEORDERNO ='"+recId+"'";
				boolean flag = false;
				flag = com.my.org.erp.common.CommonInfo.RecordExist(sql);
				if(flag)
				{
				String purchaseData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		  %>
					<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm"
						onSubmit="return valid()">
					<table width="663" border="0" align="center" cellpadding="1"
						cellspacing="1">
						<tr>
							<td width="650"></td>
						</tr>
						<tr>
							<td>
							<div align="center" class="copyright">Stock Received</div>
							</td>
						</tr>
						<tr>
							<td valign="bottom">
							<table width="649" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="123" class="boldEleven">
									<div align="left">Received Ref.No.</div>
									</td>
									<td width="198" class="boldEleven"><%=recId %> <input
										type="hidden" name="recId" value="<%=recId %>"></td>
									<td width="102" class="boldEleven">
									<div align="left">Recived By</div>
									</td>
									<td width="237" class="boldEleven"><%=purchaseData[0][1]	%></td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Received Date</div>
									</td>
									<td class="boldEleven"><%=purchaseData[0][0]	%></td>
									<td class="boldEleven">&nbsp;</td>
									<td class="boldEleven">&nbsp;</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<div align="center" id="error" class="bolddeepred"></div>
							</td>
						</tr>
						<tr>
							<td>
							<div align="center">
							<%				 
				out.print("<div align='center' id='divscroll' style='OVERFLOW:auto;width:'100%';height:200px' class='boldEleven'>");
				out.print(" <table width='100%' border='1' cellpadding='1' cellspacing='1' >");
				out.print("<th class='boldEleven'>&nbsp;<b>Type</b></th>");
				out.print("<th class='boldEleven'>&nbsp;<b>Item / Product</b></th>");
                out.print("<th class='boldEleven'>&nbsp;<b>Serial No</b></th>");
                out.print("<th class='boldEleven'>&nbsp;<b></b></th>");
                out.print("<th class='boldEleven'>&nbsp;<b>Warranty</b></th>");
				int row=1;
				String iname="";
				String itemname="";
				String typecolor="";
				String iitype="";
	
				sql = "SELECT INT_ID,CHR_TYPE,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY,INT_BRANCHID,CHR_PURCHASEORDERNO FROM inv_t_vendorgoodsreceived WHERE CHR_PURCHASEORDERNO ='"+recId+"' ORDER BY INT_ID";
				String itemData[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				String h="";
				String h1="";
				for(int u=0; u<itemData.length;u++)
				{
						iname="";
						itemname="";
						iitype="";
						if(itemData[u][1].equals("I"))
						{
							iname="Item";
							sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+itemData[u][2]+"'";
							itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
							typecolor="MRow3";
							iitype="I";
						}	
						if(itemData[u][1].equals("P"))
						{
						  iname="Product";
						  sql= "SELECT CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+itemData[u][2]+"'";
						  itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
						  typecolor="MRow4";
						  iitype="P";
						}	
						
						out.println("<tr class='"+typecolor+"'><td   class='boldEleven' >"+iname+"</td>");
						out.println("<td  class='boldEleven' >"+itemname);

h="onBlur=\"getValues('serial','"+itemData.length+"' ,'error' , 'Submit')\"";
h1=" onkeyup=\"upperMe(this),LoadUniqueCheck('serial"+(u+1)+"','Valid"+(u+1)+"' , 'inv_t_vendorgoodsreceived','CHR_SERIALNO','Submit')\" ";


						out.print("<td><input id ='serial"+(u+1)+"'  value='"+itemData[u][3]+"' class='formText135' maxlength='50'  size=20 type='text'    name ='serial"+(u+1)+"' "+h+ h1+">");
						//onkeyup=CheckSerialNoValue(this)
						out.println("<td class='boldEleven' width='150'>&nbsp;<div id='Valid"+(u+1)+"'> </div>");
						
						
						out.print("<td>");
						out.print("<select name='warranty"+(u+1)+"' id='warranty"+(u+1)+"'class='formText135' >");
						%> <jsp:include page="Warranty.jsp" flush="true" /> <%
						out.println("</select>");
						out.print("<input type='hidden' name='row"+(u+1)+"' value='"+itemData[u][0]+"'>");
						out.print("<input type='hidden' name='item"+(u+1)+"' value='"+itemData[u][2]+"'>");
						out.print("<input type='hidden' name='itype"+(u+1)+"' value='"+iitype+"'>");
						out.print("</tr>");
						
				}
				out.print("</table> ");
				out.print("</div> ");
				out.println("<input type='hidden' name='length' id='length' value='"+row+"'>");				
			  %> <input name="seriallength" type="hidden" id="seriallength"
								value="<%=itemData.length%>"></div>
							</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<table width="688" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td class="boldEleven" align="center">
									<table width="121" border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
											<td width="56"><input name="Submit" type="submit"
												class="buttonbold" value="Received" /></td>
											<td width="56"><input type="button" class="buttonbold"
												onClick="redirect('StockView.jsp?recId=<%=recId%>')"
												 value="Close"   accesskey="c"  /></td>
										</tr>
									</table>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="center"><input name="actionS" type="hidden"
										value="INVStockSerialAdd" /> <input name="filename"
										type="hidden" value="StockInfo" /></div>
									</td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</form>


					<%
		  	}
			 
		}
		catch(Exception e)
		{
			out.print(e.getMessage());
		}
		
		
		  %>
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


<%@ include file="../footer.jsp"%>
</body>
</html>

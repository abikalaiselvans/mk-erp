<%@ page import="java.io.*,java.util.*"%>
<%-- <%@ page import="sun.net.smtp.SmtpClient"%> --%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html>
<head>

<title>:: ASSET ::</title>


<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
 
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"	type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenCustomerAJAX.js" type="text/javascript"></script>
 
<body  onpaste="return false;" >

<%@ include file="index.jsp"%>
<form action="../SmartLoginAuth" method="post"   name="frm"  onSubmit=" return  Validate() "  AUTOCOMPLETE = "off">
<table width="100%" border="0" align="center" cellpadding="1" cellspacing="1">
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
						src="../Image/common/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/common/TRCorner.gif" width="7" /></td>
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
									class="boldThirteen">Asset Track Edit 
									<%
				 
				String usertype=""+session.getAttribute("USRTYPE");
				 
				
				String assetid=request.getParameter("assetid");
				String sql = " SELECT INT_BRANCHID,INT_DIVIID,DATE_FORMAT(DT_PURCHASE,'%d-%m-%Y'), CHR_PURCHASEINVOICE,CHR_REF,INT_VENDORID FROM asset_t_assetentry WHERE INT_ENTRYASSETID="+assetid;
				
				String sdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				 
				 sql = " SELECT  a.INT_ENTRYASSETID, c.CHR_COMPANYNAME,b.CHR_BRANCHNAME,d.CHR_DIVICODE,e.CHR_VENDORNAME,     a.CHR_REF,  f.CHR_STAFFNAME,  DATE_FORMAT(a.DT_PURCHASE,'%d-%m-%Y'),a.CHR_PURCHASEINVOICE,a.CHR_STATUS  FROM   asset_t_assetentry a ,com_m_branch b,com_m_company c,inv_m_division d, inv_m_vendorsinformation  e,com_m_staff f  WHERE   a.INT_BRANCHID= b.INT_BRANCHID  AND b.INT_COMPANYID= c.INT_COMPANYID AND a.INT_DIVIID= d.INT_DIVIID AND a.INT_VENDORID = e.INT_VENDORID AND a.CHR_REF=f.CHR_EMPID  AND  a.INT_ENTRYASSETID="+assetid;
				 
			String sdatas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	 
				 
				 
			%>									</td>
						    </tr>

							<tr>
								<td height="19" colspan="4" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
						    </tr>
							 
							<tr>
							  <td height="17" valign="top" class="boldEleven">Company</td>
							  <td align="left" valign="top"><%=sdatas[0][1]%>
						      <input name="assetentryid" type="hidden" id="assetentryid" value="<%=assetid%>"></td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Branch</td>
							  <td align="left" valign="top"><span class="boldEleven"><%=sdatas[0][2]%></span>
							    
                   						  <input name="Branch" type="hidden" id="Branch" value="<%=sdata[0][0] %>"><%=sdata[0][0] %></td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
								<td width="118" height="17" valign="top" class="boldEleven">Division</td>
							  <td width="199" align="left" valign="top"><span class="boldEleven"><%=sdatas[0][3]%></span>
							   
							     <input name="divis" type="hidden" id="divis" value="<%=sdata[0][1] %>">							    </td>
							    <td width="105" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
							    <td width="148" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;                                                                     </td>
							</tr>
							
							<tr>
							  <td height="17" valign="top" class="boldEleven">Vendor</td>
							  <td align="left"><div align="left">
							    <%=sdatas[0][4]%> 
								
								<input name="vendorid" type="hidden" id="vendorid" value="<%=sdata[0][5] %>">
							     
                                
						      </div></td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Invoice date </td>
							  <td align="left"><span class="boldEleven">
							    <%=sdatas[0][7]%>
								
								<input name="purchasedate" type="hidden" id="purchasedate" value="<%=sdata[0][2] %>">
								
								
								
							    
							  </span></td>
						      <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
						      <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
						  </tr>
							<tr>
							  <td class="boldEleven"><div align="left">Invoice Number </div></td>
							  <td class="boldEleven"><%=sdatas[0][8]%>
							  <input name="purchasenumber" type="hidden" id="purchasenumber" value="<%=sdata[0][3] %>">							   </td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
						  </tr>
							
							
							<tr>
							  <td height="17" valign="top" class="boldEleven">Reference</td>
							  <td colspan="3" align="left"><span class="boldEleven">
							    <div align="left"><%=sdatas[0][5]%> / <%=sdatas[0][6]%></div>
							  </span>
							  
							  <input name="ref" type="hidden" id="ref" value="<%=sdata[0][4] %>">							    </td>
					      </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;							  </td>
							</tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven">
							  <div id="divscroll" style="OVERFLOW:auto;width:600;height:auto">
							  
<%


 sql = " SELECT c.CHR_GROUPNAME, b.CHR_ITEMNAME,b.CHR_DES,a.CHR_ITEMID,a.INT_QTY,b.CHR_RETURNABLE,a.CHR_ITEMID  FROM  asset_t_assetentryqty  a ,asset_m_item b,asset_m_itemgroup c WHERE a.CHR_ITEMID=b.CHR_ITEMID AND b.INT_ITEMGROUPID=c.INT_ITEMGROUPID AND a.INT_ENTRYASSETID="+assetid; 
String itemdata[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
int key=0;
if(itemdata.length>0)
{
	out.println("<center>");
	out.println("<table width=600>");
	out.println("<tr>");
	out.println("<td class='boldEleven'><strong>Item Group</strong></td>");
	out.println("<td class='boldEleven'><strong>Item</strong></td>");
	out.println("<td class='boldEleven'><strong>Description</strong></td>");
	out.println("<td class='boldEleven'><strong>Quantity</strong></td>");
	out.println("</tr>");
	
	for(int u=0;u<itemdata.length;u++)
	{
		if(u%2==0)
			out.println("<tr class='MRow1'>");
		else	
			out.println("<tr class='MRow2'>");
		out.println("<td class='boldEleven'>"+itemdata[u][0]+" </td>");
		out.println("<td class='boldEleven'>"+itemdata[u][1]+" </td>");
		out.println("<td class='boldEleven'>"+itemdata[u][2]+" </td>");
		out.println("<td class='boldEleven'>"+itemdata[u][4]+" </td>");	
		out.println("</tr>");
	}
	
	out.println("</table>");
	out.println("<center>");
}

if(itemdata.length>0)
{
	out.println("<center>");
	out.println("<table width=600>");
	out.println("<tr>");
	out.println("<td class='boldEleven'><strong>Item Group</strong></td>");
	out.println("<td class='boldEleven'><strong>Item</strong></td>");
	out.println("<td class='boldEleven'><strong>Serial</strong></td>");
	out.println("<td class='boldEleven'><strong>Status</strong></td>");
	out.println("</tr>");
	String rdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT * FROM asset_t_assetserilano");
	int maxid= 0;
	if(rdata.length>0)
	{
		String  Smaxid=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT MAX(INT_ASSETSERIALID) FROM asset_t_assetserilano")[0][0];
		maxid= Integer.parseInt(Smaxid);
	}	
	
	key=0;
	for(int u=0;u<itemdata.length;u++)
	{
		int qty = Integer.parseInt(itemdata[u][4]);
		for(int j=0;j<qty;j++)
		{
			if(j%2==0)
				out.println("<tr class='MRow1'>");
			else	
				out.println("<tr class='MRow2'>");
			out.println("<td class='boldEleven'>"+itemdata[u][0]+" </td>");
			out.println("<td class='boldEleven'>"+itemdata[u][1]+" </td>");
			out.println("<td class='boldEleven'><input name='serial"+(key+1)+"' id= 'serial"+(key+1)+"' type='text' class='formText135' value='Mythra"+(maxid+1)+"' maxlength='25' onblur=\"loadUniqueSerialNumber(this,'div"+(key+1)+"')\"/> <div id='div"+(key+1)+"'></div> </td>");
			maxid = maxid+1;
			out.println("<td class='boldEleven'>");
			out.println("<select  class='formText135'  name='statuss"+(key+1)+"' id ='statuss"+(key+1)+"'   >");	
			out.println("<option value='Y'  >Good</option> ");	
			out.println("<option value='N'  >Fault</option></select> ");	
			out.println("</td>");	
			out.println("<td class='boldEleven'>");
			out.println("<input name='returnable"+(key+1)+"' id='returnable"+(key+1)+"' value='"+itemdata[u][5]+"' type='hidden'>");	
			
			out.println("<input name='item"+(key+1)+"' id='item"+(key+1)+"' value='"+itemdata[u][6]+"' type='hidden'>");	
			
			if("Y".equals(itemdata[u][5]))
				out.println("<b>Returnable</b>");
			else	
				out.println("<b><font color='red'>Non-Returnable</font></b>");
			out.println("</td>");	
			
			out.println("</tr>");
			key= key+1;
		}	
	}
	
	out.println("</table>");
	out.println("<center>");
}


%>
							</div>							  </td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">
							  
	<script language="javascript">
	function loadUniqueSerialNumber(ctr, ctrassign) 
	{
			 
			if(ctr.value !="")
			{
				assigncontrol=ctrassign;
				var url = "../inventory?actionS=loadUniqueSerialNumber&serialnumber="+escape(ctr.value);
				initRequest(url);
				req.onreadystatechange = UniqueSerialNumberRequest;
				req.open("GET", url, true);
				req.send(null);
		 	}
			else
			{
				alert("Please Enter the Serial Number ");
				document.getElementById(ctr.name).focus();
			}
	}
	
	
	function UniqueSerialNumberRequest() 
	{	
		if(req.readyState == 4) 
    	{    	
    		if (req.status == 200)
        	{
        	   	UniqueSerialNumberMessages();
        	}
    	}
	}


function UniqueSerialNumberMessages() 
{
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("UniqueIds")[0];   
	 
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[0];
        var Exsist = batch.getElementsByTagName("Exsist")[0].childNodes[0].nodeValue;
		var tb=document.getElementById(assigncontrol);	
		if(Exsist == "TRUE")
		{
			tb.innerHTML="<font color='red'> Serial Number Exsist...</font>";
			document.getElementById('Submit').disabled = true;
			
		}
		else
		{
			tb.innerHTML="<font color='blue'> Serial Number valid...</font>";
			document.getElementById('Submit').disabled = false;
		}
		
	 }  
	   
}

</script>							  </td>
							  <td colspan="3" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven"><div id="error"></div></td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven">
							  
							  <a href="">Auto assign</a> <!--javascript:autoserialAssign()-->
<script language="javascript">
function autoserialAssign()
{
	document.getElementById('Submit').disabled=false;
	var noofserial="<%=key%>";
	if(noofserial>=1)
	{
		var startwiths	=	prompt("Please enter Starting with","MMI");
		startwiths = startwiths.toUpperCase( );
		var startingno	=	parseInt(prompt("Please enter Starting number","01"));
		
		for(u=1; u<=noofserial;u++)
		{
			var k= "serial"+u;
			var asval="";
			if(startingno<10)
				asval = startwiths+"0"+startingno;
			else
				asval = startwiths+startingno
					
			startingno = (startingno+1);
			document.getElementById(k).value=asval;
		} 
		 
	 }	 
	 
		 
	 
}

function duplicateChecked(string ,divname,buttonname,msg) 
	{
		 
		var primaryArray = new Array();
		var secondaryArray = new Array();
		primaryArray = string.split(",");	
		secondaryArray = string.split(",");	
		var s = "";
		
		ss="";
		lens = primaryArray.length-1;
		var position="";
		for(i=0;i<lens;i++)
		{
			for(j=i+1;j<lens;j++)
				if(primaryArray[i] == secondaryArray[j])
				{
					ss = ss+"true" +",";
					position=j;
				}	
				
			
		}
		var d=ss.length
		if(d >1)
		{
			alert(msg);
			document.getElementById(divname).innerHTML="<h3><font color='red'>"+msg+"</font></h3>";
			document.getElementById(buttonname).disabled=true;
			return false;
		}
		else
		{
			document.getElementById(divname).innerHTML="";
			document.getElementById(buttonname).disabled=false;
			return true;
		}	
	}

function Validate()
{
	var serialcheck="";
	var noofserial="<%=key%>";
	for(u=1; u<=noofserial;u++)
		serialcheck = serialcheck+document.getElementById("serial"+u).value+",";
	
	var s="";
	for(u=1; u<=noofserial;u++)
		s = s+("serial"+u)+",";
	var v = s.split(",");	 
	
	var serialvalue="";
	for( i=0; i<v.length-1; i++)
		serialvalue =serialvalue+document.getElementById(v[i]).value+"~";
			
 	if(
		
		duplicateChecked(serialcheck ,'error','Submit','Duplicate Serial Entered....')	
		&& DBSerialNumber(serialvalue) 
		)
	{
		for( i=0; i<v.length-1; i++)
		{
			var chk =document.getElementById(v[i]).value;
			var ck = "Enter Serial..."+v[i];
			if(checkNull(v[i],ck))
			{
				d=1;	
			}
			else
			{
				return false;				
			}	
		}
	}
	else
		return false;		
}











var df ="";

	function DBSerialNumber(serialnumber) 
	{
			 
			var url = "../inventory?actionS=CheckDBSerialNumber&serialnumber="+escape(serialnumber);
			 
			initRequest(url);
			req.onreadystatechange = DBSerialNumberRequest;
			req.open("GET", url, true);
			req.send(null);
			if(df ="TRUE")
				return true;
			else
				return false;
		 	
	}
	
	
	function DBSerialNumberRequest() 
	{	
		if(req.readyState == 4) 
    	{  
			 
    		if (req.status == 200)
        	{
        	   	DBSerialNumberMessages();
        	}
    	}
	}


function DBSerialNumberMessages() 
{
	 
	var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[0];
        var Exsist = batch.getElementsByTagName("Exsist")[0].childNodes[0].nodeValue;
		var FieldCount = batch.getElementsByTagName("FieldCount")[0].childNodes[0].nodeValue;
		
		var tb=document.getElementById('error');	
		if(Exsist == "TRUE")
		{
			var j = parseInt(FieldCount);
			var dbserial="";
			for(h=0;h<j;h++)
				dbserial =dbserial+batch.getElementsByTagName("Field"+h)[0].childNodes[0].nodeValue+" , ";
			tb.innerHTML="<font color='red'><h1> Serial Number Exsist...</h1>"+dbserial+" </font>";
			document.getElementById('Submit').disabled = true;
			df="";
			
		}
		else
		{
			tb.innerHTML="<font color='blue'> <h1> Serial Number valid...</h1> </font>";
			document.getElementById('Submit').disabled = false;
			df="TRUE";
			
		}
		
	 }  
	   
}

</script>
							   <input name="param"type="hidden" value="<%=key%>"> 					  </td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">
							  <a href="javascript:autoserialAssign()"> </a></td>
							  <td align="left"></td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;							  </td>
						  </tr>
							<tr>
								<td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="3" align="left"><input name="filename" type="hidden" value="AssetEntry" />
							    <input name="actionS"
									type="hidden" value="ASSAssetEntrySerilaAdd" />
							    <input name="assetid" type="hidden" id="assetid" value="<%=assetid%>"> </td>
							</tr>
							<tr>
								<td height="17" colspan="4" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" id="Submit" type="submit"
											class="buttonbold13" value="Update"></td>
										<td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('AssetEntry.jsp')"></td>
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
						src="../Image/common/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/common/BRCorner.gif" width="7" /></td>
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
<%@ include file="../footer.jsp"%></form>
</body>
</html>

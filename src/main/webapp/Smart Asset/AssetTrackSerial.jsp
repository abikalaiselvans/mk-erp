<%@ page import="java.io.*,java.util.*"%>
<%-- <%@ page import="sun.net.smtp.SmtpClient"%> --%>
<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.*"%> 
<%
try
{
%>
 
<html>
<head>
 
<title>:: ASSET ::</title>


<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../JavaScript/InventoryStyles.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"	type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenCustomerAJAX.js" type="text/javascript"></script>
 <script language="javascript">
 
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
} 

 </script>
<body >

<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit=" return  Validate() ">
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
				String sql = " SELECT INT_BRANCHID,INT_DIVIID,DATE_FORMAT(DT_SALES,'%d-%m-%Y'), CHR_SALEINVOICE,CHR_REF,INT_CUSTOMERID,CHR_ADDRESS FROM asset_t_asset WHERE INT_ASSETID="+assetid;
				String sdata[][] =  CommonFunctions.QueryExecute(sql);
				 
				 sql = " SELECT  a.INT_ASSETID, c.CHR_COMPANYNAME,b.CHR_BRANCHNAME,d.CHR_DIVICODE,e.CHR_CUSTOMERNAME,  a.CHR_ADDRESSFLAG,a.CHR_ADDRESS,   a.CHR_REF,  f.CHR_STAFFNAME,  DATE_FORMAT(a.DT_SALES,'%d-%m-%Y'),a.CHR_SALEINVOICE,a.CHR_STATUS  FROM   asset_t_asset a ,com_m_branch b,com_m_company c,inv_m_division d,inv_m_customerinfo e,com_m_staff f  WHERE   a.INT_BRANCHID= b.INT_BRANCHID  AND b.INT_COMPANYID= c.INT_COMPANYID AND a.INT_DIVIID= d.INT_DIVIID AND a.INT_CUSTOMERID = e.INT_CUSTOMERID AND a.CHR_REF=f.CHR_EMPID  AND  a.INT_ASSETID="+assetid;
			
			String sdatas[][] =  CommonFunctions.QueryExecute(sql);	 
				 
				 
			%>									</td>
						    </tr>

							<tr>
								<td height="19" colspan="4" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
						    </tr>
							 
							<tr>
							  <td height="17" valign="top" class="boldEleven">Company</td>
							  <td align="left" valign="top"><%=sdatas[0][1]%></td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Branch</td>
							  <td align="left" valign="top"><span class="boldEleven"><%=sdatas[0][2]%></span>
							    
                   						  <input name="Branch" type="hidden" id="Branch" value="<%=sdata[0][0] %>"></td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
								<td width="118" height="17" valign="top" class="boldEleven">Division</td>
							  <td width="199" align="left" valign="top"><span class="boldEleven"><%=sdatas[0][3]%></span>
							   
							     <input name="divis" type="hidden" id="divis" value="<%=sdata[0][1] %>">
							    </td>
							    <td width="105" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
							    <td width="148" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;                                                                     </td>
							</tr>
							
							<tr>
							  <td height="17" valign="top" class="boldEleven">Customer</td>
							  <td align="left"><div align="left">
							    <%=sdatas[0][4]%> 
								
								<input name="customerId" type="hidden" id="customerId" value="<%=sdata[0][5] %>">
							     
                                
						      </div></td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td valign="top" class="boldEleven"><div align="left">Shipping Address</div></td>
							  <td align="left"><span class="boldEleven">
			  <%
				if("S".equals(sdata[0][5]))
				{
					out.println("Same Address");
					out.println("<input name='Shipping' type='hidden' id='Shipping' value='S'>");
				}	
				else
				{
					out.println("Different Address");	
					out.println("<input name='Shipping' type='hidden' id='Shipping' value='D'>");
				}	
			  %>
							  
							    
							  </span>
							    </td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td align="left"><span class="boldEleven"><%=sdatas[0][6]%></span>
						     <input name="shippingaddress" type="hidden" id="shippingaddress" value="<%=sdata[0][6] %>">
						 </td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Sale date </td>
							  <td align="left"><span class="boldEleven">
							    <%=sdatas[0][9]%>
								
								<input name="saledate" type="hidden" id="saledate" value="<%=sdata[0][2] %>">
								
								
								
							    
							  </span></td>
						      <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
						      <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
						  </tr>
							<tr>
							  <td class="boldEleven"><div align="left">Sale Number </div></td>
							  <td class="boldEleven"><%=sdatas[0][10]%>
							  <input name="salenumber" type="hidden" id="salenumber" value="<%=sdata[0][3] %>">
							   </td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
						  </tr>
							
							
							<tr>
							  <td height="17" valign="top" class="boldEleven">Reference</td>
							  <td colspan="3" align="left"><span class="boldEleven">
							    <div align="left"><%=sdatas[0][7]%> / <%=sdatas[0][8]%></div>
							  </span>
							  
							  <input name="ref" type="hidden" id="ref" value="<%=sdata[0][4] %>">
							     
							    </td>
					      </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;							  </td>
							</tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven">
							  <div id="divscroll" style="OVERFLOW:auto;width:600;height:auto">
							  
<%

 sql = " SELECT c.CHR_GROUPNAME, b.CHR_ITEMNAME,b.CHR_DES,a.CHR_ITEMID,a.INT_QTY  FROM  asset_t_assetqty  a ,asset_m_item b,asset_m_itemgroup c WHERE a.CHR_ITEMID=b.CHR_ITEMID AND b.INT_ITEMGROUPID=c.INT_ITEMGROUPID AND a.INT_ASSETID="+assetid; 
String itemdata[][] = CommonFunctions.QueryExecute(sql);
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
%>
							<table width="80%" border="0" cellpadding="1" cellspacing="1"	id="myTable">
								<tr>
								  <th class="boldEleven"><strong>ITEM</strong></th>
								  <th class="boldEleven"><b>SERIAL NUMBER</b></th>
								  <th class="boldEleven"><strong>STATUS</strong></th>
								  <th class="boldEleven"><strong>DESCRIPTION</strong></th>
							  </tr>
							</table>
							</div>							  </td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="3" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven"><div id="error"></div></td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven">
							  <%
							  
sql = " SELECT a.INT_SERIALID,c.CHR_GROUPNAME, b.CHR_ITEMNAME,a.CHR_SERIALNUMBER,a.CHR_ITEMID   FROM  asset_t_assetserial  a ,asset_m_item b,asset_m_itemgroup c,asset_t_asset d WHERE a.CHR_ITEMID=b.CHR_ITEMID AND b.INT_ITEMGROUPID=c.INT_ITEMGROUPID AND a.CHR_SALEINVOICE = d.CHR_SALEINVOICE AND d.INT_ASSETID="+assetid; 

String serialdata[][] = CommonFunctions.QueryExecute(sql);
if(serialdata.length>0)
{
	out.println("<center>");
	out.println("<table width=600>");
	out.println("<tr>");
	out.println("<td class='boldEleven'><strong>Serial No.</strong></td>");
	out.println("<td class='boldEleven'><strong>Item Group</strong></td>");
	out.println("<td class='boldEleven'><strong>Item</strong></td>");
	out.println("<td class='boldEleven'><strong>Serial Number</strong></td>");
	out.println("<td class='boldEleven'>&nbsp;</strong></td>");
	out.println("</tr>");
	for(int u=0;u<serialdata.length;u++)
	{
		if(u%2==0)
			out.println("<tr class='MRow3'>");
		else	
			out.println("<tr class='MRow4'>");
		out.println("<td class='boldEleven'>"+(u+1)+" </td>");
		out.println("<td class='boldEleven'>"+serialdata[u][1]+" </td>");
		out.println("<td class='boldEleven'>"+serialdata[u][2]+" </td>");
		out.println("<td class='boldEleven'><input name='serial"+(u+1)+"' id='serial"+(u+1)+"'   maxlength='25' size='25' class='formText135' value='"+ CommonFunctions.QueryExecute("SELECT CHR_SERIALNUMBER FROM asset_t_assetserilano WHERE CHR_FLAG='N'  AND CHR_STATUS ='Y'  AND CHR_ITEMID='"+serialdata[u][4]+"'  AND INT_BRANCHID ="+sdata[0][0] +" LIMIT "+u+",1 ")[0][0]+"'  type='text' onkeyup=\"loadAssetSerialNumber(this,'div"+(u+1)+"','"+serialdata[u][4]+"')\" ></td>");	
		out.println("<td class='boldEleven'> <div id='div"+(u+1)+"'></div><input name='rowid"+(u+1)+"' id='rowid"+(u+1)+"'type='hidden' value='"+serialdata[u][0]+"'></td>");	
		out.println("</tr>");
	}
	
	out.println("</table>");
	out.println("<center>");
}
%><input name="param"type="hidden" value="<%=serialdata.length%>">

<script language="javascript">
	
	function loadAssetSerialNumber(ctr, ctrassign,itemid) 
	{
		assigncontrol=ctrassign;
		var url = "../Asset?actionS=loadAssetSerialNumber&serialnumber="+escape(ctr.value)+"&itemid="+itemid;
		initRequest(url);
		req.onreadystatechange = AssetSerialNumberRequest;
		req.open("GET", url, true);
		req.send(null);
	}
	
	
	function AssetSerialNumberRequest() 
	{	
		var tb=document.getElementById(assigncontrol);	
	 	tb.innerHTML="<font color='red'>Data not found</font>";
		if(req.readyState == 4) 
    	{    	
    		if (req.status == 200)
        	{
        	   	AssetSerialNumberMessages();
        	}
    	}
	}



function AssetSerialNumberMessages() 
{
	var str=""; 
	var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
	if(batchs == null)
	{
		var str = " <select name='serialselect"+assigncontrol+"' id='serialselect"+assigncontrol+"' size='5'  style='width:200'> ";
		str= str+"<option value=''>Data not found..</option><select> ";
		var tb=document.getElementById(assigncontrol);	
	 	tb.innerHTML=str;
	}	 
	else
	{
		str = " <select name='serialselect"+assigncontrol+"' id='serialselect"+assigncontrol+"' size='5' style='width:200'  ondblclick=\"setSerialno(this,'"+assigncontrol+"')\"> ";	
		for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
        	var Serial = batch.getElementsByTagName("Serial")[0].childNodes[0].nodeValue;
			var Status = batch.getElementsByTagName("Status")[0].childNodes[0].nodeValue;
			if(Status == "N")
				str= str+"<option value='"+Serial+"/"+Status+"'   style='background-color:#FF0000' >"+Serial+"</option>";
			else
				str= str+"<option value='"+Serial+"/"+Status+"'    >"+Serial+"</option>";	
		} 
	 	str= str+"<select> ";
	 	var tb=document.getElementById(assigncontrol);	
	 	tb.innerHTML=str;
	}	
}




function setSerialno(s,serials)
{
	 
	var idposition = serials.replace("div","");
	var v = s.value.split("/");
	document.getElementById("serial"+idposition).value = v[0];
	var tb=document.getElementById(serials);
  	tb.innerHTML=" &nbsp;"  ;
  	if("N"==v[1])
  		alert("Material inDAMAGED mode");
	var param="<%=serialdata.length%>";
	var serialcheck="";
	for(u=0; u<param;u++)
	{
		var vv= document.getElementById("serial"+(u+1)).value;
		if(vv.length>=1)
			serialcheck = serialcheck+document.getElementById("serial"+(u+1)).value+",";
	}	
 	var f = duplicateChecked(serialcheck ,'error','Submit','Duplicate Serial Number ....') 	
	if(f == false)
		document.getElementById("serial"+idposition).focus();
}

</script>							  </td>
						  </tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">
							  <a href="javascript:autoserialAssign()"> </a></td>
							  <td align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;							  </td>
						  </tr>
							<tr>
								<td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="3" align="left">
<input name="filename" type="hidden" value="AssetTrack" />
<input name="actionS" type="hidden" value="ASSAssetTrackSerialAdd" />
<input name="assetid" type="hidden" id="assetid" value="<%=assetid%>">							    


<script language="JavaScript">
	
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

		var param="<%=serialdata.length%>";
		var svalue="";
		for(u=0; u<param;u++)
			svalue =svalue+"serial"+(u+1)+",";
		 
		var v = svalue.split(",");
		var serialcheck="";
		for(u=0; u<param;u++)
			serialcheck = serialcheck+document.getElementById("serial"+(u+1)).value+",";
		if( duplicateChecked(serialcheck ,'error','Submit','Duplicate Serial Number ....') 	)
		{
			for( i=0; i<v.length-1; i++)
			{
				var chk =document.getElementById(v[i]).value;
				var ck = "Enter Data..."+v[i];
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
</script>
</td>
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
											onClick="redirect('AssetTrack.jsp')"></td>
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
<%
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>
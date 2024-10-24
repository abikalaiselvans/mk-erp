<%@ page import="java.io.*,java.util.*"%>
<%-- <%@ page import="sun.net.smtp.SmtpClient"%> --%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html>
<head>

<title>:: ASSET ::</title>


<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../JavaScript/InventoryStyles.css" rel="stylesheet" type="text/css">

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"	type="text/javascript"></script>
<script  language="javascript">
function disablefault()
{
	descriptions.style.visibility="hidden";
}
function enablefault()
{
	descriptions.style.visibility="Visible";
}

function enabledesc(ctr)
{
	if(ctr.value == "N")
		enablefault();
	else
		disablefault();
}


function validstatus()
{
	var ctr= document.getElementById('statuss').value;
	var ctr1= document.getElementById('description').value;
	 
	if(ctr == "N")
		if(ctr1 =="")
			{
		  		alert("Fault description should not empty...")
				document.getElementById('description').focus();
				return false;
			}	
			else
				return true;
}


</script>
<body  onpaste="return false;" onLoad="disablefault() ">

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
	  <td><table class="BackGround1" cellspacing="0" cellpadding="0" width="700"
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
            <td width="680"><table cellspacing="2" cellpadding="2" width="87%" align="center"
						border="0">
                <!--DWLayoutTable-->
                <tbody>
                  <tr>
                    <td height="16" colspan="4" align="center" valign="top"
									class="boldThirteen">Asset Entry Edit
                      <%
				 
				String usertype=""+session.getAttribute("USRTYPE");
				 
				
				String assetid=""+request.getParameter("assetid");
				String sql = " SELECT INT_BRANCHID,CHR_ITEMID,CHR_TYPE,INT_DIVIID,DATE_FORMAT(DT_PURCHASE,'%d-%m-%Y'),CHR_INVOICENUMBER,          CHR_REF,CHR_SERIALNUMBER,CHR_STATUS FROM asset_t_assetserilano WHERE INT_ASSETSERIALID="+assetid;
				 System.out.println(sql); 
				String sdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				 
			%>
                    </td>
                  </tr>
                  <tr>
                    <td height="19" colspan="4" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory </span></td>
                  </tr>
                  <tr>
                    <td height="17" valign="top" class="boldEleven">Branch</td>
                    <td align="left" valign="top"><select name="Branch" class="formText135"
							id="Branch" tabindex="6"   >
                        <%
								
				String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID ");
				if(usertype.equals("F"))
				{
				  for(int u=0; u<shipids.length; u++)
					out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
				}
				else
				{
					 
					 for(int u=0; u<shipids.length; u++)
						out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
					 					
				}
						
							%>
                      </select>
                        <script language="javascript">
						  	setOptionValue("Branch","<%=sdata[0][0] %>") 
						  </script>
                    </td>
                    <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                  </tr>
                  <tr>
                    <td width="118" height="17" valign="top" class="boldEleven">Division</td>
                    <td width="199" align="left" valign="top"><select name="divis"
							class="formText135" id="divis" tabindex="1"
							 >
                        <option value='0'>Select</option>
                        <%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division");
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                      </select>
                        <script language="javascript">
						  	setOptionValue("divis","<%=sdata[0][3] %>") 
						        </script></td>
                    <td width="105" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    <td width="148" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="17" valign="top" class="boldEleven">Invoice date </td>
                    <td align="left"><span class="boldEleven">
                      <input tabindex="2"
										name="invoicedate" type="text" class="formText135" id="invoicedate"
										size="15" readonly="readonly" value="<%=sdata[0][4] %>">
                      <a
										href="javascript:cal2.popup();"> <img
										src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" /> </a>
                      <script language='JavaScript' type="text/javascript"> 
		<!--			
				var cal2 = new calendar1(document.forms['frm'].elements['invoicedate']);
				cal2.year_scroll = true;
				cal2.time_comp = false;
				setOptionValue("invoicedate","<%=sdata[0][4] %>") 
				  
		//-->
                                </script>
                    </span></td>
                    <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="boldEleven"><div align="left">Invoice Number </div></td>
                    <td class="boldEleven"><input name="invoicenumber" type="text"
										class="formText135" id="invoicenumber" maxlength="100"
										onkeyup="upperMe(this)" readonly="readonly"   value="<%=sdata[0][5] %>"/></td>
                    <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="17" valign="top" class="boldEleven">Reference</td>
                    <td colspan="3" align="left"><select name="ref" id="ref"
										class="formText135" size="5">
                        <jsp:include page="Staffload.jsp" flush="true" />      
                    </select>
                        <script language="javascript"> setOptionValue("ref","<%=sdata[0][6] %>")    </script>
                        <div align="left"></div></td>
                  </tr>
                  <tr>
                    <td height="17" colspan="4" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="17" colspan="4" valign="top" class="boldEleven"><div id="divscroll" style="OVERFLOW:auto;height:auto">
                        <table width="80%" border="0" cellpadding="1" cellspacing="1"	id="myTable">
                          <tr>
                            <th class="boldEleven"><strong>ITEM</strong></th>
                            <th class="boldEleven"><b>SERIAL NUMBER</b></th>
                            <th class="boldEleven"><strong>STATUS</strong></th>
                            <th class="boldEleven"><strong>DESCRIPTION</strong></th>
                          </tr>
                          <tr>
                            <th class="boldEleven"><select name="Item" id="Item">
                                <%
String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_ITEMID,CHR_ITEMNAME  FROM asset_m_item WHERE  INT_ACTIVE = 1 ORDER BY CHR_ITEMNAME");
	 
	for(int u=0; u<data.length;u++)
		out.println("<option value="+data[u][0]+">"+data[u][1]+"</option>");
%>
                              </select>
                                <script language="javascript"> setOptionValue("Item","<%=sdata[0][1] %>")    </script>
                            </th>
                            <th class="boldEleven"> <input name="ItemSerial" type="text" id="ItemSerial" value="<%=sdata[0][7] %>"   onblur="loadUniqueSerialNumber(this,'error')">
                                <div id="error"></div>
                              <script language="javascript">

	function loadUniqueSerialNumber(ctr, ctrassign) 
	{
			 
			if(ctr.value !="")
			{
				assigncontrol=ctrassign;
				var url = "../Asset?actionS=loadUniqueSerialNumber&serialnumber="+escape(ctr.value);
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
        </script></th>
                            <th class="boldEleven"><b>
                                <select  class='formText135'  name='statuss' id ='statuss' onChange="enabledesc(this)"   >
                                  <option value='Y'  >Good</option>
                                  <option value='N'  >Fault</option>
                                </select>
                                <script language="javascript"> setOptionValue("statuss","<%=sdata[0][8] %>")    </script>
                            </th>
                            <th class="boldEleven" id="descriptions"> <textarea name="description" cols="25" rows="5" class="formText135" id="description"></textarea></th>
                          </tr>
                        </table>
                    </div></td>
                  </tr>
                  <tr>
                    <td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    <td colspan="3" align="left" class="boldred">* Status is fault the description field shows </td>
                  </tr>
                  <tr>
                    <td height="17" valign="top" class="boldEleven"><a href="javascript:autoserialAssign()"> </a></td>
                    <td align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                  </tr>
                  <tr>
                    <td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    <td colspan="3" align="left"><input name="filename" type="hidden" value="AssetEntry" />
                        <input name="actionS"
									type="hidden" value="ASSAssetEntryUpdate" />
                        <input name="assetid" type="hidden" id="assetid" value="<%=assetid%>">
                        <%
									
									  
									  if("N".equals(sdata[0][8]))
									  {
									  	%>
                        <script language="javascript">
											enablefault();
										</script>
                        <%
									  }
									  %>
                        <script language="JavaScript">
 
	
function Validate()
  {

	 
	 
	 
 	if(
	
	 checkNullSelect("Branch","Select Branch","0")
	&& checkNullSelect("divis","Select Division","0")
	&& checkNull( "invoicedate","Enter Invoice Date" )
	&& checkNull( "invoicenumber","Enter Invoice Number " )
	&& checkNull( "ref","Select reference" )
	&& checkNullSelect("Item","Select Item","0")
	&& checkNull( "ref"," Enter ItemSerial" )
	&& checkNullSelect("statuss","Select statuss","0")
	&& validstatus()
	)
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
                                </script></td>
                  </tr>
                  <tr>
                    <td height="17" colspan="4" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                        <tr>
                          <td><input name="Submit" id="Submit" type="submit"
											class="buttonbold13" value="Update"></td>
                          <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('AssetEntry.jsp')"></td>
                        </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                    <td colspan="3" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
                  </tr>
                </tbody>
                <input type="hidden" name="mobileBookingOption" />
            </table></td>
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
      </table></td>
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

<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.SmartInventory.Product"%>
<%
try
{
%>
<%!String productId, productName;%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<html>
<head>
<title>:: INVENTORY ::</title>
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>


<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
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
<script language="javascript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
<script language="JavaScript"><!--

function Assignptype(v)
{
	document.getElementById('Ptype').value=v;
}

function checkDecimal(ctr,len)
{
	var dot=".";
	var txtval = document.getElementById(ctr).value;
  	var keylen = txtval.length;
  	var dotlen= txtval.indexOf(dot);


	if(keylen<=len)	
	{
			if(dotlen==-1)
	  		{
	  			alert("Please follow the format : 00000.00");
	  			document.getElementById(ctr).select();
	  			return false;
	  		}
			else if(dotlen==0)
	  		{
	  			alert("Please follow the format : 00000.00");
	  			document.getElementById(ctr).select();
	  			return false;
	  		}
	  		else if ((dotlen!=-1)&&(((keylen-1)-dotlen)!=2))
			{
	  			alert("Please follow the format : 00000.00");
				document.getElementById(ctr).select();
	  			return false;
			}
		  	if(keylen==len)
			{	
				event.keyCode=0;		
				show_popup();
			}
			else
			{
				return true;
			}
	}
}




function Validate()
  {
  		eclicked();
		var t = document.getElementById('Ptype').value;
		var l=0;
		if("C" == t)	
		{
			var l=document.frm.itemList1.length;
			if(l<1)
			{
				alert("Selected Item List ");
				return false;	
			}	
		}
		else
		{
			var l=document.frm.itemList1.length;
			if(l>0)
			{
				alert("Please remove the item in Item List ");
				return false;	
			}	
		}
		
		var count,k,i,str;
		if(
			checkNull("productCode","Enter Product Name") 
			&& checkNull("hsncode","Enter HSN / SAC code ") 
		 	&& checkNull("purchasePrice","Enter Purchase price") 
			&& checkNull("salesPrice","Enter Sales price") 
			&& checkNullSelect("make","Select make...",'0') 
			&& checkNullSelect("modelCode","Select Model...",'0') 
			&& checkNullSelect("colorCode","Select Color...",'0') 
		 	&& checkNullSelect("tax","Select Tax...",'0') 
			&& checkNullSelect("productGroupId","Select Group...",'0') 
			&& checkNull("productDesc","Enter the description") 
			
			
		)
		{
		  if(parseFloat(document.getElementById('salesPrice').value) < parseFloat(document.getElementById('purchasePrice').value))
		  {
		  	alert("Sales price should not less than the purchase prices");
		  	return false;
		  }	
		  else
		  { 
		 	return true;
		  }	
		}	
		else
		{
			return false;	
		}
  } 
  
 
 
 
 
 
 
 
 
 
 
 
   
  function set()
  {
  			document.frm.productId.focus();
  }
   
  function addItem()
  {
     var count,k,i;
	 count=document.frm.itemId.length;
	 serialid=document.getElementById('serialid').value;
     var _targ=document.getElementsByName('itemList1')[0];   
 	 i=_targ.options.length;
     for(k=0;k<count;k++)
	 {
     	if(document.frm.itemId[k].selected==true)
		{     	   		
			selVal=document.frm.itemId.options[k].value;
			selText=document.frm.itemId.options[k].text;
			serialid = serialid +selVal+"~";
			/*var f = checkDuplicate(selVal,selText);
			if( f === "false")
			{
				_targ.options[i]=new Option(selText,selVal);
			}	*/
			_targ.options[i]=new Option(selText,selVal);
			i=i+1;
     	}
     }   
     _targ.options.length=i;  
      _targ.options.selectedIndex=0;  
	  document.getElementById('serialid').value = serialid;
  }
  
  function removeItem()
  {
   	var count,k,i;
    count=document.frm.itemList1.length;
	 if(count>0)
	{
	   for(k=0;k<document.frm.itemList1.length;k++)
	   {
	   		if(document.frm.itemList1[k].selected==true)
			{
				var x=document.getElementById("itemList1");
				x.remove(x.selectedIndex);
	     	}
	    }
	}
	else
	{
		alert('There is No Item to Remove');
	}
	
  } 
  
  
  function checkDuplicate(val,text)
  {
  	var f="false";
  	for(k=0;k<document.frm.itemList1.length;k++)
	   	if(document.frm.itemList1[k].value == val )
		{
			alert( " Duplicate Entry ....");
			f = "true";
	    }
		
	return f;	
  }
  
  
function eclicked()
{
	var s = "";
	for(k=0;k<document.frm.itemList1.length;k++)
	 	s= s+document.frm.itemList1.options[k].value+"~";
	document.getElementById('serialid').value = s;
}


  
function Duplicate()
{
	var s = "";
	for(k=0;k<document.frm.itemList1.length;k++)
	 	s= s+document.frm.itemList1.options[k].value+"~";
	var array1 = s.split("~");
	var array2 = s.split("~");
	var arraylength = array1.length-1;
	var count=0;
	for(u=0; u<arraylength; u++)
	{
		count=0;
		for(v=0; v<arraylength; v++)
		{
			if(array2[u] == array1[v])
				count = count +1;
			if(count > 1)
				array1[v]="";
		}
	}
	var hs2="";
	for(v=0; v<arraylength; v++)
		if(array1[v]!="")
			hs2 = hs2 +	array1[v]+",";
				
	 
}


--></script>
<body    onLoad="loadSelectProItem()">
<jsp:include page="indexinv.jsp" />

<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>
		<%
String productId=request.getParameter("productId");
String sql=" ";
sql = " SELECT INT_PRODUCTIDS,CHR_PRODUCTID,CHR_PRODUCTCODE,CHR_ITEMLIST,DOU_PURCHASEPRICE, ";
sql = sql + " DOU_SALESPRICE,INT_STOCKINHAND,CHR_WARRANTY,CHR_COLOR,CHR_MODEL,CHR_PRODUCTDESC, ";
sql = sql + " INT_PRODUCTGROUPID,INT_ACTIVE,CHR_PTYPE,CHR_PTYPE,INT_TAXID,CHR_USRNAME, ";
sql = sql + " DT_UPDATEDATE,CHR_UPDATESTATUS, DT_UPDATEDATE,CHR_UPDATESTATUS,INT_MAKEID,CHR_HSNCODE,INT_UNITID  FROM inv_m_produtlist WHERE INT_PRODUCTIDS= "+productId;
//out.println(sql);
String product[][]= CommonFunctions.QueryExecute(sql);

		%> 
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth"
			onSubmit="return Validate()">
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
					<table cellspacing="2" cellpadding="2" width="388" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">PRODUCT LIST</td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							 
							<tr>
								<td height="17" class="boldEleven">Product Code <span
									class="bolddeepred">* </span></td>
							  <td colspan="2" align="left">
<input name="productCode" 	id="productCode" size="30" value="<%=product[0][2] %>"
									type="text"     onBlur="upperMe(this)"      class="formText135"
									maxlength="50"><input type="hidden" name="productId" id="productId" value="<%=product[0][0] %>">
<span class="boldred"> <%=product[0][1]%> </span></td>
							</tr>
							<tr>
							  <td height="17" class="boldEleven">HSN/SAC Code <span
									class="bolddeepred">* </span></td>
							  <td colspan="2" align="left"><input name="hsncode"
									id="hsncode" size="30" type="text" class="formText135"
									maxlength="50"    onBlur="upperMe(this)" value="<%=product[0][22] %>" ></td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven">Purchase Price</td>
								<%
                        		if (product[0][4].equals("0.00")) 
                        			product[0][4]="";
                        %>

								<td colspan="2" align="left"><input id="purchasePrice"
									name="purchasePrice" size="30" type="text" class="formText135"
									maxlength="7" value="<%=product[0][4] %>"
									    onKeyPress="return numeric_only(event,'purchasePrice','11')" ></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Sales Price</td>
								<%
                        		if (product[0][5].equals("0.00")) 
                        			product[0][5]="";
                        %>
								<td colspan="2" align="left"><input name="salesPrice"
									size="30" type="text" class="formText135" id="salesPrice"
									maxlength="7" value="<%=product[0][5]%>"
									 onKeyPress="return numeric_only(event,'salesPrice','11')"></td>
							</tr>
							<tr>
							  <td height="17" class="boldEleven">Make <span class="bolddeepred">*</span></td>
							  <td colspan="2" align="left">
<select name="make" id="make" style="width: 200" class="formText135">
	<option value="0">Select Make</option>
	<%
		String makata[][] = CommonFunctions.QueryExecute("SELECT INT_MAKEID,CHR_MAKENAME  FROM inv_m_make  ORDER BY CHR_MAKENAME");
		for (int i = 0; i < makata.length; i++)  
			out.println("<option value='" + makata[i][0] + "'>"	+ makata[i][1] + "</option>");
	%>
</select>
<script language="javascript">setOptionValue('make','<%=product[0][21]%>')</script>							  </td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven">Model / Brand   <span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left">
								
								
<select name="modelCode" id="modelCode" style="width: 200" class="formText135">
		<option value="0">Select Model/Brand</option>
		<%
			String query = "SELECT INT_MODELID,CHR_MODELCODE  FROM inv_m_model  ORDER BY CHR_MODELCODE";
			String modelData[][] = CommonFunctions.QueryExecute(query);
			for (int i = 0; i < modelData.length; i++)  
				out.println("<option value='" + modelData[i][0] + "'>"	+ modelData[i][1] + "</option>");
		%>
</select>
<script language="javascript">setOptionValue('modelCode','<%=product[0][9]%>')</script>	 </td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Color <span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left">
								
<select name="colorCode" id="colorCode" style="width: 200" class="formText135"> 
	<option value="0">Select Color</option>
	<%
		query = "SELECT INT_COLORID,CHR_COLORCODE  FROM inv_m_color ORDER BY CHR_COLORCODE";
		String colorData[][] = CommonFunctions.QueryExecute(query);
		for (int i = 0; i < colorData.length; i++) 
			out.println("<option value='" + colorData[i][0] + "'>"+ colorData[i][1] + "</option>");
		
	%>
</select>
<script language="javascript">setOptionValue('colorCode','<%=product[0][8]%>')</script>							  </td>
							</tr>
							<tr>
							  <td height="17" class="boldEleven">Tax <span
									class="bolddeepred">*</span></td>
							  <td colspan="2" align="left"> 
                               
<select name="tax" id="tax" style="width: 200" class="formText135">
<option value="0">Select Tax</option>
<%
String taxdata[][] = CommonFunctions.QueryExecute("SELECT INT_TAXID,CHR_TAXNAME,DOU_VALUE FROM inv_m_tax ORDER BY INT_TAXID");
for(int u=0;u<taxdata.length;u++)
	out.println("<option value='"+taxdata[u][0]+"'>"+taxdata[u][1]+"</option>");
%>
</select>
<script language="javascript">setOptionValue('tax','<%=product[0][15]%>')</script>								</td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Units<span
									class="bolddeepred">*</span></td>
							  <td colspan="2" align="left"><span class="boldEleven">
							    <select name="units" id="units" style="width: 170" class="formText135">
                                  <option value="0">Select Units</option>
                                  <%
String unitsdata[][] =  CommonFunctions.QueryExecute("SELECT INT_UNITID,CHR_SYMBOL,CHR_MEASUREMENT FROM inv_m_units ORDER BY CHR_MEASUREMENT");
for(int u=0;u<unitsdata.length;u++)
	out.println("<option value='"+unitsdata[u][0]+"'>"+ unitsdata[u][2] +" / " + unitsdata[u][1] + " </option>");
%> 
                                </select><script language="javascript">setOptionValue('units','<%=product[0][23]%>')</script>
							  </span></td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven">Active <span
									class="bolddeepred">* <%
										String test=product[0][12];
										String tr="";
										String fal="";										
										if(test.equals("1"))
											tr="checked='checked'";
										else
											fal="checked='checked'";										
									%> </span></td>
								<td colspan="2" align="left">
								<table width="56" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td><input name="active" type="radio" <%=tr %> value="1"
											id="radio"></td>
										<td><font class="boldEleven">True</font></td>
										<td><input name="active" type="radio" class="boldEleven"
											<%=fal %> value="0" id="active"></td>
										<td><font class="boldEleven">False</font></td>
									</tr>
								</table>								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Product Type <span
									class="bolddeepred">* <%
							test=product[0][13];
							tr="";
							fal="";			
							String cons="";							
							if(test.equals("F"))
								tr="checked='checked'";
							if(test.equals("C"))
								fal="checked='checked'";	
							if(test.equals("S"))
								cons="checked='checked'";											
						%> </span></td>
								<td colspan="2" align="left">
								<table width="56" border="0" cellpadding="0" cellspacing="0"
									class="boldEleven">
									<tr>
										<td><input name="ptype" type="radio" value="F" <%=tr%>></td>
										<td class="boldEleven">Full</td>
										<td class="boldEleven"><input name="ptype" type="radio"
											<%=fal%> value="C"></td>
										<td class="boldEleven">Combination</td>
										<td class="boldEleven"><input name="ptype" type="radio"
											<%=cons%> value="S"></td>
										<td class="boldEleven">Consumables
									    <input name="Ptype" type="hidden" id="Ptype" value="<%=test%>"></td>
									</tr>
								</table>								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Group Name <span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left">

<select name="productGroupId" id="productGroupId" style="width: 175" class="formText135">
<option value="0">Select Group</option>
<%
	query = "SELECT INT_PRODUCTGROUPID,CHR_NAME FROM inv_m_productgroup ORDER BY CHR_NAME";
	String branch[][] = CommonFunctions.QueryExecute(query);
	for (int u = 0; u < branch.length; u++) 
		out.print("<option value ='" + branch[u][0] + "'>"+ branch[u][1] + "</option>");
	
%>
</select>			
<script language="javascript">setOptionValue('productGroupId','<%=product[0][11]%>')</script>							  </td>
							</tr>
							 
							<tr>
								<td height="17" class="boldEleven">Description<span class="bolddeepred"> *</span></td>
								<td colspan="2" align="left"><textarea rows="2" cols="30"
									class="formText135"  onKeyPress="textArea('productDesc','2000')"name="productDesc" id="productDesc"><%=product[0][10] %></textarea></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Warranty Info</td>
								<td colspan="2" align="left"> 
								<select name="warranty" id="warranty" style="width: 200"
									class="formText135">
									<option value="">Select Warranty</option>
									<jsp:include page="Warranty.jsp" flush="true" />
								</select> 
<script language="javascript"> setOptionValue("warranty","<%=product[0][7] %>")  </script></td>
							</tr>
							<tr>
								<td colspan="3">
								<table width="379">
									<tr>
										<td height="17" width="500px" class="boldEleven" valign="top">Search
										:: <input name="search" type="text" class="formText135"
											id="search" onKeyUp="loadSelectProItem()">   			</td>
										<td></td>
										<td height="17" class="boldEleven" valign="top">
										<div align="center">Selected Item List <span
											class="bolddeepred">* </span></div>										</td>
									</tr>
									<tr>
										<td align="left"><select name="itemId" id="itemId"
											multiple="multiple" size="10" style="width:250px"
											class="newsarticlesmall">
										</select></td>
										<td align="center"><input type="button" name="add"
											value=">>" onClick="addItem()" class="formText135"> <br>
										<input name="button" type="button" class="formText135"
											onClick="removeItem()" value="&lt;&lt;" /></td>
										<td><select name="itemList1" size="10" multiple
											class="newsarticlesmall" id="itemList1" style="width:200px">
											<%
												String serials="";
												String itemList[]=product[0][3].split("~");
												sql="SELECT CHR_ITEMID,CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID in (";
												for(int i=0;i<itemList.length;i++) {
													sql=sql+"'"+itemList[i]+"',";
												}
												sql=sql.substring(0,sql.length()-1);
												sql=sql+") ORDER BY CHR_ITEMNAME";
												String selList[][]= CommonFunctions.QueryExecute(sql);												
												for(int i=0;i<selList.length;i++)
												{
													out.println("<option  value='"+selList[i][0]+"'>"+selList[i][1]+" / "+selList[i][0]+"</option>");
													serials = serials+selList[i][0]+"~";
												}
											%>
										</select></td>
									</tr>
									<tr>
										<td><input name="itemList" type="hidden" id="itemList" />
										<input name="filename" type="hidden" value="ProductList" /> <input
											name="actionS" type="hidden" value="INVproductListEdit" /> <input
											name="serialid" type="hidden" id="serialid"
											value="<%=serials%>"></td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
								</table>								</td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" type="submit"
											class="buttonbold13" value="Update"></td>
										<td><input name="Close" type="Button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="location.href='ProductListView.jsp'"></td>
									</tr>
								</table>								</td>
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
		</form>
		</td>
	</tr>
	<tr>
		<td height="65">&nbsp;</td>
	</tr>
</table>
<jsp:include page="../footer.jsp" />
</body>
</html>

<%
}
catch(Exception e)
{
	 System.out.println(e.getMessage());
}
%>

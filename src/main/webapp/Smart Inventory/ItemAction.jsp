<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="../error/error.jsp"%>
<%@ page import="com.my.org.erp.SmartInventory.Product"%>
<%@ page import="com.my.org.erp.SmartInventory.Item"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%! String itemId,itemName;
    int loop=0;%>

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

<script language="JavaScript">
function LoadWindow(query)
		{
			var width="800", height="400";
			var left = (screen.width/2) - width/2;
			var top = (screen.height/2) - height/2;
			var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=no,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
			newWindow = window.open(query,"subWind",styleStr);
			newWindow.focus( );
	}
</script>

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="javascript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
<script language="JavaScript">
<%
      try
       {
    	  ArrayList productList=(ArrayList) session.getAttribute("productList");
        int i=0;
%>  var taxitems=[<%        
        while(i<productList.size())
        {
        	Product product= (Product)productList.get(i); 
        	if(i==0){
        		itemId=""+product.getProductId();
        		itemName=(String)product.getProductName();
	             %>["<%=itemId%>","<%=itemName%>"] <% }
             else{
            	 itemId=""+product.getProductId();
            	 itemName=(String)product.getProductName();
            	 %> ,["<%=itemId%>","<%=itemName%>"] <% }
              i++;       	
        }
%>];<%

       }
       catch(Exception e)
       {
    	   //System.out.println(e);
    	   
       }
%>
act="<%=request.getParameter("action1")%>";
bid="<%=request.getParameter("itemId")%>";

  function checkName()
  {	  	
	  	var lname=document.getElementById("itemId").value;
	  	var message;
	  	var messageText;	  	
	  	if(true)
	  	{
          i=0;
          var userMessageElement = document.getElementById("item");
          lname=Trim(lname);
          lname=lname.toLowerCase();
          while(i<taxitems.length)
          {
            id=taxitems[i][0];            
            taxitem=taxitems[i][1].toLowerCase();
            if(act=="Edit" && id==bid)
            {
            	window.status="Valid Name";
                message="true";
                break;
            }
            if(lname==taxitem)
            {
               window.status="Already Exists";
               message="false";
               break;
            }
            else{
	            window.status="Valid Name";
                message="true";
            }
            i++;
          }           
	     if (message == "false" || lname=="") {
	         userMessageElement.style.color = "red";
	         messageText = " Already Exists";
	         document.getElementById("submit").disabled=true;
	     } else {
	         userMessageElement.style.color = "green";
	         messageText = "Valid Name";
   	         document.getElementById("submit").disabled=false;
	     }
	     var messageBody = document.createTextNode(messageText);
	     if (userMessageElement.childNodes[0]) 
	     {
	         userMessageElement.replaceChild(messageBody, userMessageElement.childNodes[0]);
	     }
	     else 
	     {
	         userMessageElement.appendChild(messageBody);
	     }
     }
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

	if(checkNull("itemName","Enter Item Name") &&checkNullSelect("itemgroup","Select itemgroup","0"))
	{
	
		var sp = document.getElementById('salesPrice');
		var pp = document.getElementById('purPrice');

		if (pp.value!="" && sp.value==""){
			alert("Enter Sales Price");
	 		sp.focus();
	 		return false;
		}else if (sp.value!="" && pp.value=="") {			
			alert("Enter Purchase Price");
	 		pp.focus();
	 		return false;
		}
					
		var sprice = parseFloat(sp.value);
		var pprice = parseFloat(pp.value);

		if (sprice < pprice)
		{
	 		alert("Sales Price Should be Greater than Purchase Price");
	 		document.getElementById('salesPrice').select();
	 		return false;
	 	}
	 	else
			return true;	

	}
	else
			return false;	

		
  } 
   	
</script>
<%
	ArrayList productList=(ArrayList)session.getAttribute("productList");
	int totalRecord=productList.size();
	
  	String actionS="INVItemAdd";
	String productId,itemId,itemName,purPrice,salesPrice,stock,active1,active2;
	String itemDes,purDes,salesDes,warranty,color,model, itemgroup ,divid,tax;
  	productId="";
  	itemId="";
  	itemName="";
  	itemDes="";
	active1="checked='checked'";
	active2="";
  	purDes="";
  	purPrice="";
  	salesDes="";
  	salesPrice="";
  	warranty="";
  	stock="";
  	color="";
  	model="";
	divid=" ";
	itemgroup ="";
	tax="";
  	String act=request.getParameter("action1");
  	 
	if(act.equals("Add"))
	{
		actionS="INVItemAdd";
	}
	else if(act.equals("Edit"))
	{
		actionS="INVItemEdit";
		itemId=request.getParameter("itemId");		
	  	String query ="SELECT CHR_PRODUCTID,CHR_ITEMID,CHR_ITEMNAME,CHR_DES,INT_ACTIVE"+
	  	",CHR_PURCHASEDES,DOU_PURCHASEPRICE,CHR_SALESDES,DOU_SALESPRICE,CHR_WARRANTY"+
	  	",INT_STOCKINHAND,INT_COLORCODE,INT_MODELCODE ,INT_ITEMGROUPID,INT_DIVIID,INT_TAXID FROM inv_m_item WHERE CHR_ITEMID ='" +itemId+"'";
	  	String tableData[][] =  CommonFunctions.QueryExecute(query);
	  	 
 	  	itemName=tableData[0][2];
	  	itemDes=tableData[0][3];
	  	active1=tableData[0][4];
	  	purDes=tableData[0][5];
	  	purPrice=tableData[0][6];
	  	salesDes=tableData[0][7];
	  	salesPrice=tableData[0][8];
	  	warranty=tableData[0][9];
 	  	stock=tableData[0][10];
	  	color=tableData[0][11];
	  	model=tableData[0][12];
		 itemgroup=tableData[0][13];
		 divid=tableData[0][14];
		 tax=tableData[0][15];
	  	if(active1.equals("1"))
	  		active1="checked='checked'";
	  	else
	  		active2="checked='checked'";	  		
	}
%>

<script language="javascript">
	var x = "<%= request.getParameter("addMore")%>"
	if (x=="Y"){
		z = confirm("Do You Want to Add One More Record?");
		if (z==false)
			location="ItemView.jsp";
	}
</script>

<body >

<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frmItemAction"
	onSubmit="return Validate()">
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
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="400"
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
					<table cellspacing="2" cellpadding="2" width="400" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">ITEM</td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>

							<tr>
								<td width="133" height="17" class="boldEleven"></td>
								<td colspan="2" align="left" class="boldThirteen">
								<%      
            	if(act.equals("Edit")){
					out.println("<b>Item Code  :: "+itemId+"</b>");
					out.println("<input type='hidden' name='itemId' value="+itemId+">");
            	}	
            	 
            %>  </td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Item Name <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="itemName"
									value="<%=itemName %>" size="30" type="text"
									class="formText135" id="itemName" maxlength="50"
									onKeyUp="upperMe(this), CheckUnique(this,'soValid','inv_m_item','CHR_ITEMNAME')"
									onBlur="upperMe(this), CheckUnique(this,'soValid','inv_m_item','CHR_ITEMNAME')">

								<div id="soValid"></div>								</td>
							</tr>
							<tr>
								<%
					if (purPrice.equals("0.00"))
						purPrice="";
               %>

								<td height="17" class="boldEleven">Purchase Price</td>
								<td colspan="2" align="left">
								
								<input name="purPrice"  id="purPrice" value="<%=purPrice %>" size="30" type="text" class="formText135" maxlength="7" onKeyPress="return numeric_only(event,'purPrice','10')"  ></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Sales Price</td>
								<%
					if (salesPrice.equals("0.00"))
                	  salesPrice="";
               %>
								<td colspan="2" align="left"><input name="salesPrice"
									id="salesPrice" value="<%=salesPrice %>" size="30" type="text"
									class="formText135" maxlength="7"
									onKeyPress="return numeric_only(event,'salesPrice','10')"></td>
							</tr>
							 
							<tr>
								<td height="17" class="boldEleven">Active <span
									class="bolddeepred">  </span></td>
								<td colspan="2" align="left"><input name="active"
									type="radio" class="formText135" value="1" id="active"
									<%=active1 %>><font class="boldEleven"> True</font> <input
									name="active" type="radio" class="formText135" value="0"
									id="active" <%=active2 %>><font class="boldEleven">
								False</font></td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Item Group
								<span class="bolddeepred">* </span></td>
								<td align="left" valign="top"><select name="itemgroup"
									id="itemgroup" style="width: 200" class="newsarticlesmall">
									<option value="0">Select</option>
									<%
						String query ="SELECT INT_ITEMGROUPID,CHR_GROUPNAME  FROM inv_m_itemgroup ORDER BY CHR_GROUPNAME";
	  					String itemgroupData1[][] =  CommonFunctions.QueryExecute(query);
			            for(int i=0;i<itemgroupData1.length;i++)
			 	 	 		if(itemgroupData1[i][0].equals(itemgroup))
 				 		 	 	out.println("<option value='"+itemgroupData1[i][0]+"' selected>"+itemgroupData1[i][1]+"</option>");
 	 	 					else
 	 	 		 		 	 	out.println("<option value='"+itemgroupData1[i][0]+"'>"+itemgroupData1[i][1]+"</option>");
			        %>
								</select></td>
								<td align="left" valign="top"></td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Model<span class="bolddeepred"> *</span></td>
								<td width="200" align="left" valign="top"><select
									name="model" id="model" style="width: 200" class="formText135">
									<option value="0">Select</option>
									<%
						query ="SELECT INT_MODELID,CHR_MODELCODE  FROM inv_m_model  ORDER BY CHR_MODELCODE";
	  					String modelData[][] =  CommonFunctions.QueryExecute(query);
			            for(int i=0;i<modelData.length;i++)
			 	 	 	{
 	 	 					if(modelData[i][0].equals(model))
 				 		 	 	out.println("<option value='"+modelData[i][0]+"' selected>"+modelData[i][1]+"</option>");
 	 	 					else
 	 	 		 		 	 	out.println("<option value='"+modelData[i][0]+"'>"+modelData[i][1]+"</option>");
				 	 	}
			        %>
								</select></td>
								<!--ModelAction.jsp?filename=Model&actionS=INVmodelDelete&action1=Add-->
								<td width="32" align="left" valign="top"></td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Color</td>
								<td align="left" valign="top"><select name="color"
									id="color" style="width: 200" class="formText135">
									<option value="0">Select</option>
									<%
						query ="SELECT INT_COLORID,CHR_COLORCODE  FROM inv_m_color  ORDER BY CHR_COLORCODE";
	  					String colorData[][] =  CommonFunctions.QueryExecute(query);
			            for(int i=0;i<colorData.length;i++)
			 	 	 	{
 	 	 					if(colorData[i][0].equals(color))
 				 		 	 	out.println("<option value='"+colorData[i][0]+"' selected>"+colorData[i][1]+"</option>");
 	 	 					else
 	 	 		 		 	 	out.println("<option value='"+colorData[i][0]+"'>"+colorData[i][1]+"</option>");
				 	 	}			       
			        %>
								</select></td>
								<td align="left" valign="top"></td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Division
							    <span class="bolddeepred">* </span></td>
								<td colspan="2" align="left" valign="top"><select
									name="Division" id="Division" style="width: 200"
									class="formText135">
									<option value="0">Select</option>
									<%
										 query = "SELECT INT_DIVIID,CHR_DIVICODE  FROM inv_m_division ORDER BY CHR_DIVICODE";
										String divData[][] =  CommonFunctions.QueryExecute(query);
										for (int i = 0; i < divData.length; i++) {
											out.println("<option value='" + divData[i][0] + "'>"
											+ divData[i][1] + "</option>");
										}
									%>
								</select> <script language="javascript">
						setOptionValue("Division","<%=divid%>") 
						</script></td>
							</tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Tax <span
									class="bolddeepred">*</span></td>
							  <td colspan="2" align="left" valign="top"><%
							  	String sql = "SELECT INT_TAXID,CHR_TAXNAME,DOU_VALUE FROM inv_m_tax ORDER BY CHR_TAXNAME";
							  %>
                                <select name="tax" id="tax" style="width: 200" class="formText135">
                                  <%
							String taxdata[][] =  CommonFunctions.QueryExecute(sql);
							for(int u=0;u<taxdata.length;u++)
								out.println("<option value='"+taxdata[u][0]+"'>"+taxdata[u][1]+"</option>");
							%>
                                </select>
								<script language="javascript"> setOptionValue("tax","<%=tax%>")  </script>
								</td>
						  </tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Item
								Description</td>
								<td colspan="2" align="left" valign="top"><textarea
									rows="3" cols="30" class="formText135" name="itemDes"
									id="itemDes"><%=itemDes %></textarea></td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Purchase
								Description</td>
								<td colspan="2" align="left" valign="top"><textarea
									rows="3" cols="30" class="formText135" name="purDes"
									id="purDes"><%=purDes %></textarea></td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Sales
								Description</td>
								<td colspan="2" align="left" valign="top"><textarea
									rows="3" cols="30" class="formText135" name="salesDes"
									id="salesDes"><%=salesDes %></textarea></td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Warranty
								Info</td>
								<td colspan="2" align="left" valign="top"><!--              <textarea rows="3" cols="30"  class="formText135" name="warranty" id="warranty"><%=warranty %></textarea>				   -->
								<select name="warranty" id="warranty" style="width: 200"
									class="formText135">
									<jsp:include page="Warranty.jsp" flush="true" />
								</select></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><input name="filename"
									type="hidden" value="Item" /> <input name="actionS"
									type="hidden" value="<%=actionS %>" /></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" type="submit" id="Submit" class="buttonbold13" value="Submit"   accesskey="s"   ></td>
										<td><input name="Close" type="Button" class="buttonbold13" id="Close"  value="Close"   accesskey="c"  onClick="location.href='ItemView.jsp'"></td>
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
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>

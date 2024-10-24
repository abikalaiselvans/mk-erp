<%@ page import="java.io.*,java.util.*" isErrorPage="false"
	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.SmartInventory.Product"%>
<%!
 	String productId,productName;
%>
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
<script language="JavaScript">
<%
     // //System.out.println("Inside Action 2");  
      try
       {    	  
    	ArrayList productList=(ArrayList) session.getAttribute("productList");
        int i=0;
	%> var proGroupitems=[<%        
        while(i<productList.size())
        {
        	Product proGroup= (Product)productList.get(i); 
        	if(i==0){
        		productId=""+proGroup.getProductId();
        		productName=(String)proGroup.getProductName();
        		%>["<%=productId%>","<%=productName%>"] <% }
            else{
            	 productId=""+proGroup.getProductId();
            	 productName=(String)proGroup.getProductName();
            	 %> ,["<%=productId%>","<%=productName%>"] <% }
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
bid="<%=request.getParameter("productId")%>";
 function checkName()
  {	  	
	  	var lname=document.getElementById("productId").value;
	  	var message;
	  	var messageText;	  	
	  	if(true)
	  	{
          i=0;
          var userMessageElement = document.getElementById("pro");
          lname=Trim(lname);
          lname=lname.toLowerCase();
          while(i<proGroupitems.length)
          {
            id=proGroupitems[i][0];            
            item=proGroupitems[i][1].toLowerCase();
            if(act=="Edit" && id==bid)
            {
            	window.status="Valid Name";
                message="true";
                break;
            }
            if(lname==item)
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

  

  function PageBack()
  {
	     //future enhancement
  }
 	
  function Validate()
  {
   
	if(checkNull("productId","Enter Product Id") && checkNull("productName","Enter Product Name"))
		return true;
	else
		return false;	
		
  } 
  function set()
  {
  			document.frm.productId.focus();
  }
 	
</script>
<%
	String actionS="INVProductAdd";
	String productId,productName,productDes,active1,active2,groupId,priceStatus1,priceStatus2;
	productId="";
	productName="";
	productDes="";
	active1="checked='checked'";
	active2="";
	groupId="";
	priceStatus1="checked='checked'";
	priceStatus2="";
	String act=request.getParameter("action1");
	if(act.equals("Add"))
	{
		actionS="INVProductAdd";
	}
	else if(act.equals("Edit"))
	{
		actionS="INVProductEdit";
		productId=request.getParameter("productId");
		ArrayList productList=(ArrayList)session.getAttribute("productList");
		int totalRecord=productList.size();
		for(int i=0;i<totalRecord;i++)
 	 	{
 	 	 	Product product=(Product)productList.get(i);
 	 	 	String pId=product.getProductId();
 	 	 	if(pId.equals(productId)){
 	 	 		productName=product.getProductName();
 	 	 		//System.out.println(product.getProductName());
 	 			productDes=product.getProductDes();
 	 			active1="";
 	 			active2="";
 	 			if(product.isActive())
	 	 			active1="checked='checked'";
 	 			else
 		 			active2="checked='checked'";	
 	 			groupId=""+product.getProductGropuId();
 	 			priceStatus1="";
 	 			priceStatus2="";
 	 			if(product.isPriceStatus())
	 	 			priceStatus1="checked='checked'";
 	 			else
	 	 			priceStatus2="checked='checked'";
 	 	 	}
 	 	} 
	}
%>
<body    onLoad="set()">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth"
	onsubmit="return Validate()">
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
					<table cellspacing="2" cellpadding="2" width="388" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">PRODUCT</td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Product ID<span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="productId"
									id="productId" size="30" type="text" class="formText135"
									value="<%=productId %>" maxlength="15" onKeyUp="">
								<div id="pro"></div>
								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Product Name <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="productName"
									id="productName" size="30" type="text" class="formText135"
									value="<%=productName %>" maxlength="15"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven" valign="top">Product
								Description</td>
								<td colspan="2" align="left"><textarea rows="3" cols="30"
									class="formText135" name="productDes" id="productDes"><%=productDes %></textarea>
								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Active <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="active"
									type="radio" value="1" id="active" <%=active1 %>><font
									class="boldEleven"> True</font> <input name="active"
									type="radio" class="boldEleven" value="0" id="active"
									<%=active2 %>> <font class="boldEleven">False</font></td>


							</tr>
							<tr>
								<td height="17" class="boldEleven">Group Name</td>
								<td colspan="2" align="left"><select name="groupId"
									id="groupId" style="width: 175" class="formText135">
									<option value="0">Select....</option>
									<%
						  String query ="SELECT INT_PRODUCTGROUPID,CHR_NAME FROM inv_m_productgroup";
						  String branch[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(query);
						  for(int u=0; u<branch.length; u++){
							if(groupId.equals(branch[u][0]))  
							  	out.print("<option value ='"+branch[u][0]+"' selected='selected'>" +branch[u][1]+"</option>");
							else
							  	out.print("<option value ='"+branch[u][0]+"'>" +branch[u][1]+"</option>");
						  }
					  %>
								</select></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Price Status <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="priceStatus"
									type="radio" class="formText135" id="priceStatus" value="1"
									<%=priceStatus1 %>><font class="boldEleven">
								True</font> <input name="priceStatus" type="radio" class="formText135"
									id="priceStatus" value="0" <%=priceStatus2 %>><font
									class="boldEleven"> False</font></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">&nbsp;</td>
								<td colspan="2" align="left"><input name="filename"
									type="hidden" value="Product" /> <input name="actionS"
									type="hidden" value="<%=actionS%>" /></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
										<td><input name="Close" type="Button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="location.href='ProductView.jsp'"></td>
									</tr>
								</table>
								</td>
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
		<td height="65">&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</html>

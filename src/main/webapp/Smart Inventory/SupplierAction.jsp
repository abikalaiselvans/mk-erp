<%@ page import="java.lang.*,java.util.*,java.io.*"%>
<%!
	String compName,compId,street,area,city,state,phone,mobile,fax,email;
	String supplierName,supplierDes,supplierId,contactPerson;
	String actionStu;
	int pin;
%>
<%@ page import="com.my.org.erp.SmartInventory.Supplier"%>
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

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
<%
      try
       {
    	  ArrayList supplierList=(ArrayList) session.getAttribute("supplierList");
        int i=0;
%>  var supplieritems=[<%        
        while(i<supplierList.size())
        {
        	Supplier supplier= (Supplier)supplierList.get(i); 
        	if(i==0){
        		supplierId=""+supplier.getSupplierId();
        		supplierName=(String)supplier.getSupplierName();
	             %>["<%=supplierId%>","<%=supplierName%>"] <% }
             else{
            	 supplierId=""+supplier.getSupplierId();
            	 supplierName=(String)supplier.getSupplierName();
            	 %> ,["<%=supplierId%>","<%=supplierName%>"] <% }
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
bid="<%=request.getParameter("OptSupplierName")%>";
  
  function checkName()
  {	  	
	  	var aname=document.getElementById("TxtSupplierName").value;
	  	var message;
	  	var messageText;	  	
	  	if(true)
	  	{
          i=0;
          var userMessageElement = document.getElementById("sup");
          aname=aname.toLowerCase();
          while(i<supplieritems.length)
          {
            id=supplieritems[i][0];
            allowitem=supplieritems[i][1].toLowerCase();
            if(act=="Edit" && id==bid)
            {
            	window.status="Valid Name";
                message="true";
                break;
            }
            if(aname==allowitem)
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
	     if (message == "false" || aname=="") {
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
  function validate()
  {
   	var Pincode=document.getElementById("TxtPin")
  	var Phone=document.getElementById("TxtPhone")
  	var Mobile=document.getElementById("TxtMobile")  
  	var Fax=document.getElementById("TxtFax")
  	var Email=document.getElementById("TxtEmail")   				  	  	
  	if((Pincode.value)!=0)
  	{
  	if(Pincode.value.length!=6)
  	{
  	 	alert("Please Enter Correct Pincode");
  	 	Pincode.value="";
  	 	Pincode.focus();
  	 	return false;  	
  	}
  	}
  	if((Phone.value.length)!=0)
  	{
  		if(Phone.value.length!=8)
  		{
  	 		alert("Please Enter Correct Phone");
  	 		Phone.value="";
  	 		Phone.focus();
  	 		return false;  	
  		}
  	}
  	if((Mobile.value.length)!=0)
  	{
  		if(Mobile.value.length!=10)
  		{
  	 		alert("Please Enter Correct Mobile No");
  	 		Mobile.value="";
  	 		Mobile.focus();
  	 		return false;  	
  		}
  	}
  	if((Fax.value.length)!=0)
  	{
  		if(Fax.value.length!=12)
  		{
  	 		alert("Please Enter Correct Fax");
  	 		Fax.value="";
  	 		Fax.focus();
  	 		return false;  	
  		}
  	}
  	if((Email.value.length)!=0)
  	{
  		if(Email.value.length<10)
  		{
  	 		alert("Please Enter Correct Mail ID");
  	 		Email.value="";
  	 		Email.focus();
  	 		return false;  	
  		}
  	}	
  	if((checkNull("TxtSupplierName","Enter Supplier Name"))
	&&(checkNull("TxtStreet","Enter Street Name"))
	&&(checkNull("TxtArea","Enter Area Name"))
	&&(checkNull("TxtCity","Enter City Name")))
	{
  		return true; 		  	
  	}  
  	 	 
  }
  function set()
  {
     document.supplier.TxtSupplierName.focus();
  }
  function upperMe(field)
  {
  	field.value=field.value.toUpperCase();
  }
   function mainPage()
	{
	     document.supplier.action="SupplierView.jsp";	    
    }
</script>
</head>
<body      onLoad="set();">
<form  AUTOCOMPLETE = "off"   name="supplier" action="../SmartLoginAuth">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><%@ include file="indexinv.jsp"%></td>
	</tr>
	<tr>
		<td height="58"></td>
	</tr>
	<%   
  	String action=request.getParameter("action1");
	//courseName=""+request.getParameter("courseName");
	//courseId=request.getParameter("TxtCourseId");
	ArrayList supplierList=(ArrayList) session.getAttribute("supplierList");
	if(action.equals("Edit")){
		 actionStu="INVsupplierEdit";
		 supplierId=request.getParameter("OptSupplierName");		 
		 for(int i=0;i<supplierList.size();i++)
		 {
			Supplier supplier= (Supplier)supplierList.get(i);
			if(supplier.getSupplierId()==Integer.parseInt(supplierId)){
				supplierName=supplier.getSupplierName();
              	street=supplier.getStreet();
                area=supplier.getArea();
                city=supplier.getCity();
                state=supplier.getState();
                pin=supplier.getPin();
                phone=supplier.getPhone();
                mobile=supplier.getMobile();
                fax=supplier.getFax();
                email=supplier.getEmail();
                contactPerson=""+supplier.getContactPerson();
				if(contactPerson.equals("null")) contactPerson="";
                //doctor=doctor.get();
				break;
			}
		 }
	}else{
		actionStu="INVsupplierAdd";
		supplierName="";
		contactPerson="";
		street="";
        area="";
        city="";
        state="";
        pin=0;
        phone="";
        mobile="";
        fax="";
        email="";
    
	}
		
%>
	<tr>
		<td height="337">
		<table width="39%" border="1" align="center" cellpadding="1"
			cellspacing="0">
			<!--DWLayoutTable-->
			<tr>
				<td height="30" colspan="2" align="center" valign="middle"
					class="tableheadInv">Supplier</td>
			</tr>
			<tr>
				<td width="109" height="30" valign="middle" class="bolddeepblue">
				Supplier Name<font color="#ff0000">*</font></td>
				<td width="258" valign="middle"><input size="40" type="text"
					name="TxtSupplierName" value="<%=supplierName%>"
					onKeyPress="alphaNumeric('TxtSupplierName','25')"
					    onBlur="upperMe(this)"     >
				<div id="sup"></div>
				</td>
			</tr>
			<tr>
				<td width="109" height="30" valign="middle" class="bolddeepblue">
				Contact Person <font color="#ff0000">*</font></td>
				<td width="258" valign="middle"><input size="40" type="text"
					name="TxtContactPerson" value="<%=contactPerson%>"
					onKeyPress="alphaNumeric('TxtSupplierName','25')"
					    onBlur="upperMe(this)"     >
				<div id="sup"></div>
				</td>
			</tr>
			<tr>
				<td height="30" valign="middle" class="bolddeepblue">Street<font
					color="#ff0000">*</font></td>
				<td valign="middle"><input size="40" type="text"
					name="TxtStreet" value="<%=street%>"></td>
			</tr>
			<tr>
				<td height="30" valign="middle" class="bolddeepblue">Area<font
					color="#ff0000">*</font></td>
				<td valign="middle"><input size="40" type="text" name="TxtArea"
					value="<%=area %>" onKeyPress="alphaNumeric('TxtArea','25')"></td>
			</tr>
			<tr>
				<td height="30" valign="middle" class="bolddeepblue">City<font
					color="#ff0000">*</font></td>
				<td valign="middle"><input size="40" type="text" name="TxtCity"
					value="<%=city%>" onKeyPress="alphaNumeric('TxtCity','25')"></td>
			</tr>
			<tr>
				<td height="30" valign="middle" class="bolddeepblue">State</td>
				<td valign="middle"><input size="40" type="text"
					name="TxtState" value="<%=state %>"
					onKeyPress="alphaNumeric('TxtState','25')"></td>
			</tr>
			<tr>
				<td height="30" valign="middle" class="bolddeepblue">Pincode</td>
				<td valign="middle"><input size="40" type="text" name="TxtPin"
					value="<%=pin %>" onKeyPress="numericValue('TxtPin','6')"></td>
			</tr>
			<tr>
				<td height="30" valign="middle" class="bolddeepblue">Phone</td>
				<td valign="middle"><input size="40" type="text"
					name="TxtPhone" value="<%=phone %>"
					onKeyPress="numericValue('TxtPhone','8')"></td>
			</tr>
			<tr>
				<td height="30" valign="middle" class="bolddeepblue">Mobile</td>
				<td valign="middle"><input size="40" type="text"
					name="TxtMobile" value="<%=mobile %>"
					onKeyPress="numericValue('TxtMobile','10')"></td>
			</tr>
			<tr>
				<td height="30" valign="middle" class="bolddeepblue">Fax</td>
				<td valign="middle"><input size="40" type="text" name="TxtFax"
					value="<%=fax%>" onKeyPress="alphaNumeric('TxtFax','12')"></td>
			</tr>
			<tr>
				<td height="30" valign="middle" class="bolddeepblue">Email</td>
				<td valign="middle"><input size="40" type="text"
					name="TxtEmail" value="<%=email %>"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td><input type="HIDDEN" name="filename" value="Supplier">
		<input type="HIDDEN" name="actionS" value="<%=actionStu %>"> <input
			type="HIDDEN" name="supplierId" value="<%=supplierId %>"></td>
	</tr>
	<tr>
		<td height="30">
		<table width="12%" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<!--DWLayoutTable-->
			<tr>

				<td width="56"><input name="Input" type="submit"
					class="buttonbold" value="Submit"   accesskey="s"    onClick="return validate()"></td>
				<td width="56"><input name="close" type="submit"
					class="buttonbold"  value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="5"></td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</form>
</body>
</html>

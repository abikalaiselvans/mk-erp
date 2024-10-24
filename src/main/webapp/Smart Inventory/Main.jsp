<%
try
{
	CommonFunctions.autoUpdate(request,""+application.getInitParameter("Auto"));
	String usertype=""+session.getAttribute("USRTYPE");
	String officename= ""+session.getAttribute("OFFICENAME");
	String officeid= ""+session.getAttribute("OFFICEID");
	String user= ""+session.getAttribute("USRID"); 
	user=user.trim();
					
%>
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


<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="cache-control" content="no-store">
<meta http-equiv="cache-control" content="private">
<meta http-equiv="cache-control" content="max-age=0, must-revalidate">
<meta http-equiv="expires" content="now-1">
<meta http-equiv="pragma" content="no-cache">
<script language="javascript" src="../JavaScript/Servercheck.js"></script>
<script language="javascript">
loadServer()
</script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
<script language="javascript" src="../JavaScript/Inventory/branches.js"></script>
<script language="javascript">
  function Validate()
  {
	  
	obj = findObj("branchid");
	if(obj == null)
	{
		alert("Branch not available");
		return false;
	}	
	
	if(	checkNullSelect("office","Select Office","0") && OptionboxCheck())
		return true;	
	else
		return false;			
  } 
 
 
 function OptionboxCheck()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].branchid;
		txt=""
		for (i=0;i<coffee1.length;++ i)
		{
			if (coffee1[i].checked)
			{
			count=count+1;
			}
		}
		if(count==0)
		{
			if (document.forms[0].branchid.checked) { count=1;}
		}
		if(count==1){			
			 
			return true;
		}
		else
		{
		    alert("Select Only one Branch...");
		    return false;
		}
 	}

</script>

</script>
 <html>
<head>
<title>:: INVENTORY ::</title> <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
 
<body    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"    >
<center>
<%@ include file="index.jsp"%>

<center>
<div class="row">
	<div class="col-md-3">&nbsp;</div>
	<div class="col-md-6">
	
	
<div class="panel panel-primary">
	<div class="panel-heading">
	  <h3 class="panel-title">CHOOSE THE BRANCH.....</h3>
	</div>
	<div class="panel-body">
		<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">
	  	<div class="row">
			<div class="col-md-3">&nbsp;</div>
			<div class="col-md-3"><input type="hidden" name="filename"value="Control" /> <input type="hidden" name="actionS"value="INVControlAssign" />Office</div>
			<div class="col-md-3">
			<select name="office" class="boldEleven" id="office" onChange="LoadBranches()"  >
			<option value="0">Select</option>
			<%                  
				String OfficeData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT b.INT_OFFICEID,b.CHR_OFFICENAME FROM  com_m_office  b WHERE b.CHR_STATUS='Y' AND b.INT_OFFICEID IN("+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT a.CHR_OFFICELIST FROM m_user a WHERE a.CHR_USRNAME='"+user+"' ")[0][0]+" )");
			 if(OfficeData.length>0)
				for(int u=0;u<OfficeData.length;u++)
					out.println("<option value='"+OfficeData[u][0]+"'>"+OfficeData[u][1]+"</option>");
			 
				
				
				/*if("F".equals(usertype) || "B".equals(usertype)) 
				{
					String queryoffice="SELECT INT_OFFICEID,CHR_OFFICENAME FROM   com_m_office  ";
					String	officedata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(queryoffice);
					for(int i=0;i<officedata.length;i++)
						out.println("<option value='"+officedata[i][0]+"'>"+officedata[i][1]+"</option>");
				}
				if(("A".equals(usertype))) 
				{
					String queryoffice="SELECT INT_OFFICEID,CHR_OFFICENAME FROM   com_m_office   WHERE INT_OFFICEID="+officeid;
					String	officedata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(queryoffice);
					for(int i=0;i<officedata.length;i++)
						out.println("<option value='"+officedata[i][0]+"'>"+officedata[i][1]+"</option>");
					
				}*/
				
				
				
				%>
			</select>
			</div>
			<div class="col-md-3">&nbsp;</div>
		</div>
		
		<div class="row">
			<div class="col-md-12"><div id='branchTable'></div></div>
		</div>
		
		<div class="row">
			<div class="col-md-6">
					<button class="btn btn-info" name="Submit" id="Submit"  type="submit">Submit</button>
					<button class="btn btn-info" name="Close"   id="Close" onClick="redirect('../Home.jsp')">Close</button>
					 
			</div>
		</div>
	</form>					
	</div>
</div>
					  


	</div>
	<div class="col-md-3">&nbsp;</div>
</div>					  
</center>					  
 

<%@ include file="../footer.jsp"%>
</center>
</html>
<%
}
catch(Exception e)
{

}
%>

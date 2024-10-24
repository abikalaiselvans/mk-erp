<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%><html>
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
<script language="JavaScript" src="../JavaScript/calendar1.js" ></script>

<script type="text/javascript">
var divi="";
function Loaditemproduct(ctr,div) 
{
	if(ctr.value=="")
	{
		alert("Kindly select Product or Item")
		ctr.focus();
	}
	else
	{
		var url = "../inventory?actionS=INVItemProduct&id="+escape(ctr.value) ;
		divi = div;
		initRequest(url);
		req.onreadystatechange = itemproductRequest;
		req.open("GET", url, true);
		req.send(null);
	}	
}

function itemproductRequest() 
{
    if(req.readyState == 4) 
    {  
    	if (req.status == 200) 
    	{		  	
         	itemproductMessages();
        }
    }
}

function itemproductMessages() 
{
	var batchs = req.responseXML.getElementsByTagName("items")[0];   
   s1 ='item';
	var str="<select name='"+s1+"'  id='"+s1+"' size='1' class='formText135'  style='width:200'   )\"><option value=0>All"; 

    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
	    	Id= batch.getElementsByTagName("Id")[0];
	    	Idname= batch.getElementsByTagName("Idname")[0];
 			str = str+"<option value='"+Id.childNodes[0].nodeValue+"'>"+Idname.childNodes[0].nodeValue+"</option>";
       }
       str=str+"</select>";
	   var tb=document.getElementById(divi);
  	   tb.innerHTML=str  ; 
 }
 
 
 function validate()
 {
 	obj = findObj("item");
	if(obj == null)
		alert("Item / Product not available");
	
	if(
		checkNullSelect("Branch","Select Branch","")
		&& checkNullSelect("division","Select Division","")
		&& checkNullSelect("itype","Select Product Type","")
		
		&& checkNullSelect( "reportType","Select Export Type" ,'0')
		 
	)
		return true;
	else
		return false;
 }
</script>

<body >
<%@ include file="indexinv.jsp"%>
<form action="../SmartLoginAuth" method="post"   name="frm" onSubmit="return validate()"  AUTOCOMPLETE = "off">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="375"
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
					<table cellspacing="2" cellpadding="2" width="350" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">PRODUCTWISE DETAILED SALE REPORT </td>
							</tr>

							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							<tr>
							  <td height="17" class="boldEleven">Branch <%
				String branchid=""+session.getAttribute("BRANCHID");
				String usertype=""+session.getAttribute("USRTYPE");
				 	
			%> 
								<span class="boldred">*</span> </td>
								<td colspan="2" align="left">
								
								<select name="Branch" class="formText135" id="Branch" tabindex="6" onChange="loadItem('0')" style="width:200">
								<option value="">Select Branch</option>

									<%
								
								String shipids[][] =  CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID ");
								if(usertype.equals("F"))
								{
									for(int u=0; u<shipids.length; u++)
										out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
								}
								else
								{
									for(int u=0; u<shipids.length; u++)
										if(shipids[u][0].equals(branchid))
											out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
																
								}
										
							%>
								</select> <script language="javascript">
						  	setOptionValue("Branch","<%=branchid%>") 
						  </script></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Division<span class="boldred">*</span> </td>
								<td colspan="2" align="left">
								<select name="division" class="formText135" id="division" tabindex="1" style="width:200"> 
									<option value="">Select Division</option>
									<option value='0' selected="selected">All</option>
									
									<%
								String division[][] =  CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
								</select></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Product Type<span class="boldred"> *</span> </td>
								<td colspan="2" align="left"><select class='formText135'
									name='itype' id='itype' onChange="Loaditemproduct(this,'code')"  style="width:200">
									<option value="">Please Select</option>
									<option value='1'>Item</option>
									<option value='2'>Product</option>
								</select></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Item / Product Code<span class="boldred"> *</span> </td>
								<td colspan="2" align="left">
								<div id="code"></div>								</td>
							</tr>
							 <tr>
                              <td height="17" class="boldEleven">Month <span class="boldred">*</span> </td>
							  <td colspan="2" align="left"><span class="boldEleven">
                                <select name="month" id="month"   style="width:200">
								<option value="0">All</option>
                                  <%@ include file="../JavaScript/Inventory/month.jsp"%>
                                </select>
                              </span></td>
						  </tr>
							<tr>
                              <td height="17" class="boldEleven">Year<span class="boldred"> *</span> </td>
							  <td colspan="2" align="left"><span class="boldEleven">
                                <select name="year" id="year"  style="width:200">
								<option value="0">All</option>
                                  <%@ include file="../JavaScript/Inventory/year.jsp"%>
                                </select>
                                <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
                                </script>
                              </span></td>
						  </tr>
							
							<tr>
								<td height="17" class="boldEleven">Export File Type <span class="boldred">*</span></td>
								<td colspan="2" align="left"><select name="reportType" id="reportType" style=" width:130px;height:22px" >
                                  <option value="0" selected  >Export Type</option>
                                  <option value="csv" >CSV</option>
                                  <option value="xls" >Excel</option>
                                  <option value="html" >Html</option>
                                  <option value="pdf"  selected="selected">PDF</option>
                                  <option value="rtf"  >Word</option>
                                  <option value="txt" >Text</option>
                                  <option value="xml" >XML</option>
                                </select></td>
							</tr>
							<tr>
							  <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="2" align="left"><input name="filename" type="hidden" id="filename"
										value="Rept_JProductwiseDetailSaleReport">
                                <input name="actionS"
										type="hidden" id="actionS"
										value="INVRept_JProductwiseDetailSaleReport">
                                <input name="rptfilename" type="hidden" id="rptfilename" value="ProductwiseDetailSaleReport"></td>
						  </tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   
											 ></td>
										<td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="javascript:window.close()"></td>
									</tr>
								</table>								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
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

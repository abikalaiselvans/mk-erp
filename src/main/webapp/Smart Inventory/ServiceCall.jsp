<%@ page import="java.io.*,java.util.*" isErrorPage="false"
	errorPage="../error/error.jsp"%>
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
<script language="javascript" src="../JavaScript/Inventory/serviceCallBooking.js"></script>
<script language="JavaScript">

    function Add()
	{ 
		document.frm.action="ServiceCallAdd.jsp";
 	}

	function SEdit()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].Bookingid
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
			if (document.forms[0].Bookingid.checked) { count=1;}
		}
		if(count==1){			
			document.frm.action="ServiceCallEdit.jsp";
			return true;
		}
		else
		{
		    alert("Select Only one Value");
		    return false;
		}
 	}	

 	function RDelete()
 	{		
		var count;
		count=0;
		coffee1=document.forms[0].Bookingid
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
			if (document.forms[0].Bookingid.checked) { count=1;}
		}
		if(count>=1){			
			var name=confirm("Confirm to Delete")
			if (name==true)
			{ 
				document.frm.action="../SmartLoginAuth";
				return true;			
			}
			else
				return false;
		}
		else
		{
		    alert("Select Atleast One Value");
		    return false;
		}		
 	}
 	

 	 
   
 	
  	
function LoadRuntimeCustomer(ctr)
{
 	try
 	{
 		
		var _targ=document.getElementsByName('customerid')[0];
    	_targ.options.length=0;	 
		var opt = document.createElement("option");
		document.getElementById("customerid").options.add(opt); 
       	opt.text = "All";
        opt.value = "0";	 
		var branch=document.getElementById('branch').value;	 
		var id = 0;
 		var url = "../inventory?actionS=LoadRuntimeCustomer&id="+escape(id)+"&branch="+branch;
		initRequest(url);
    	req.onreadystatechange=RuntimeCustomerRequest;
		req.open("GET", url, true);
    	req.send(null);
		 
    	
    }
     
	catch(err)
	{
		
		alert(err.description);
		
	} 	
    
}
 
function RuntimeCustomerRequest() 
{
		if(req.readyState == 4) 
		{    	
			if (req.status == 200) 
			{		  	
			  RuntimeCustomerMessages();
			}
		}
}
	
	
function RuntimeCustomerMessages() 
{	 
   
   	 	var batchs = req.responseXML.getElementsByTagName("Rows")[0];   
		for(loop = 0; loop < batchs.childNodes.length; loop++) 
		{	     
			var batch = batchs.childNodes[loop];
			var Id = batch.getElementsByTagName("Id")[0].childNodes[0].nodeValue;
			var Name = batch.getElementsByTagName("Name")[0].childNodes[0].nodeValue;
			var opt = document.createElement("option");
			document.getElementById("customerid").options.add(opt); 
       		opt.text = Name;
        	opt.value = Id;
		}
		 
	 	
	
}  


</script>

<body    onLoad="LoadAMCCallBooking('0')">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="">
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
		<table width="90%" height="189" border="0" align="center"
			cellpadding="0" cellspacing="0" class="TableDesign"  
			 >
			<tr  >
				<td height="31"  >
				<div align="center" class="boldThirteen">Service call Booking Details&nbsp;&nbsp;</div>				</td>
			</tr>
			<tr  >
				<td height="31"  >
				<table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="whiteMedium">
					<tr>
					  <td height="28" colspan="6"  ><table width="500" border="0" align="center" cellpadding="3" cellspacing="4" class="whiteMedium">
                        <tr>
                          <td  >Branch </td>
                          <td  ><span  >
                            <select name="branch" id="branch"  onChange="LoadRuntimeCustomer('servicecenter')" class="formText135" onBlur="LoadAMCCallBooking('0')" >
                               <%
			   	String branchid=""+session.getAttribute("INVBRANCH"); 
				String suertype=""+session.getAttribute("USRTYPE"); 
				if("F".equals(suertype) )  
				{
					out.println("<option value='0'>All</option>");								
					String sq=" Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID  ";
					String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sq);
					for(int u=0; u<shipids.length; u++)
						out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+ "  @  " +shipids[u][1] +"</option>");
				}
				else
				{
					
					String sq=" Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID and  a.INT_BRANCHID = "+branchid;
					String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sq);
					for(int u=0; u<shipids.length; u++)
						out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+ "  @  " +shipids[u][1] +"</option>");
				}	
				 
			   %>
                            </select>
                          </span></td>
                        </tr>
                      </table></td>
				  </tr>
					<tr>
					  <td height="28"  >Customer</td>
					  <td><%

    
    String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT INT_CUSTOMERID, CHR_CUSTOMERNAME from inv_m_servicecustomerinfo WHERE INT_BRANCHID="+""+session.getAttribute("BRANCHID") +"  ORDER BY CHR_CUSTOMERNAME");
								%>
                        <select name="customerid" id="customerid" class="formText135" onChange="LoadAMCCallBooking('0')" >
                          <option value="0">All</option>
                          <%                  
			if(readData.length >= 0)
				for(int i=0;i<readData.length;i++)
					out.println("<option value='"+readData[i][0]+"'>"+readData[i][1]+"</option>");
			else
				out.println("<option>Data not found..</option>");
				
		%>
                        </select></td>
					  <td  >Booking Type</td>
					  <td><select name="bookingtype" class="formText135" id="bookingtype"  onChange="LoadAMCCallBooking('0')" >
                        <option value="0" >All</option>
                        <option value="D" >Direct</option>
                        <option value="P" >Phone</option>
                        <option value="O" >Others</option>
                      </select></td>
					  <td  >Booking Under</td>
					  <td><select name="bookingunder" class="formText135" id="bookingunder"  onChange="LoadAMCCallBooking('0')" >
                        <option value="0" >All</option>
                        <option value="A" >AMC</option>
                        <option value="W" >Warranty</option>
                        <option value="O" >On Call</option>
                      </select></td>
				  </tr>
					<tr>
					  <td height="28"  >Call Status</td>
					  <td><select name="callstatus" class="formText135" id="callstatus"  onChange="LoadAMCCallBooking('0')" >
                        <option value="0" >All</option>
                        <option value="C" >Completed</option>
                        <option value="P" >Pending</option>
                        <option value="N" >New Call</option>
						<option value="R" >Cancelled</option>
						 
                      </select></td>
					  <td  ><span  >Month</span></td>
					  <td><span class="boldThirteen">
					    <select name="month" class="formText135"
							id="month" onBlur="LoadAMCCallBooking('0')">
                          <%@ include file="../JavaScript/Inventory/month.jsp"%>
                        </select>
					  </span></td>
					  <td  ><span  >Year</span></td>
					  <td><span class="boldThirteen">
					    <select name="year" class="formText135"
							id="year" onBlur="LoadAMCCallBooking('0')">
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
				</table>				</td>
			</tr>
			<tr class="MRow1">
				<td height="127" valign="top" class="footermenu">
				
				<br><div id="divscroll" style="OVERFLOW:auto;width:100%;height:250px"
							 ></div>
				<br>
			  </td>
		  </tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="20">
		<%
			if( !"null".equals(""+request.getParameter("servicecall")) ) 
			{
			%>
			<script language="javascript">alert("Your Service call Number is :: <%=request.getParameter("servicecall")%>")</script>
			<%
			}
		%>	  </td>
	</tr>
	<tr>
		<td>
		<table  border="0" align="center" cellpadding="1"
			cellspacing="1" class="TableDesign"  >
			<tr class="para">
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('0')">All</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('A')">A</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('B')">B</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('C')">C</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('D')">D</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('E')">E</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('F')">F</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('G')">G</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('H')">H</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('I')">I</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('J')">J</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('K')">K</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('L')">L</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('M')">M</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('N')">N</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('O')">O</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('P')">P</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('Q')">Q</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('R')">R</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('S')">S</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('T')">T</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('U')">U</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('V')">V</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('W')">W</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('X')">X</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('Y')">Y</a></div>
				</td>
				<td  >
				<div align="center"><a class="whiteMedium" href="javascript:LoadAMCCallBooking('Z')">Z</a></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><input name="filename" type="hidden" value="ServiceCall" />
		<input name="actionS" type="hidden" value="INVServiceDelete" /></td>
	</tr>
	<tr>
		<td>
		<table width="224" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<!--DWLayoutTable-->
			<tr>
				<td width="56" valign="top"><input type="submit"
					class="ButtonHead" name="action1"    id="action1"    value="Add"   accesskey="s"   onClick="Add()" /></td>
				<td width="56" valign="top"><input name="Edit" type="submit"
					class="ButtonHead" id="Edit" onClick="return SEdit()"
					value="Edit" /></td>
				<%
	  String usertype=""+session.getAttribute("USRTYPE");
	  if("F".equals(usertype))
	  {
	  %>
				<td width="56" valign="top"><input name="Delete" type="submit"
					class="ButtonHead" id="Delete" onClick="return RDelete()"
					value="Delete" /></td>
				<%
		}
		else
		{
			out.println("<input type='hidden' id='Delete'>");
		}
		%>
				<td width="56"><input type="button" class="ButtonHead"
					name="submit"  value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')" /></td>
			</tr>
		</table>
		</td>
	</tr>

	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>

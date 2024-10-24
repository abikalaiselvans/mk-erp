<%@ page import="java.io.*,java.util.*" errorPage="../error/index.jsp"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>
<title>:: INVENTORY ::</title><style type="text/css">
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

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
 

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"	type="text/javascript"></script>
 <script src="../JavaScript/common/StaffloadAjax.js"></script>
<link href="../JavaScript/jquery/Time/jquery-ui.css" rel="stylesheet" type="text/css">
<link href="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui.min.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-sliderAccess.js"></script>


<body   onLoad="init()">
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit=" return  Validate() ">
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
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="60%"
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
					<td>
					<table cellspacing="2" cellpadding="2" width="99%" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="4" align="center" valign="top"
									class="boldThirteen">SALES INSTALLATION 
									
									
									<%
				 						
String sql = " ";
String salesno = request.getParameter("salesno");
sql = " SELECT a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),    ";
sql = sql + " CONCAT(FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),'<br>',b.CHR_ADDRESS1,'<br>',b.CHR_ADDRESS2,'<br>',b.CHR_MOBILE),c.CHR_DIVICODE,a.CHR_CONTACTDETAILS,a.CHR_CONTACTNO ,a.CHR_SHIPPING,a.CHR_SHIPPINGADDRESS,b.INT_CUSTOMERID,a.INT_DIVIID   ";
sql = sql + " FROM inv_t_directsales a,inv_m_customerinfo b, inv_m_division c    ";
sql = sql + " WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID    ";
sql = sql + " AND a.INT_DIVIID =c.INT_DIVIID    ";
sql = sql + " AND a.CHR_INSTALLATION='Y'    ";
sql = sql + " AND a.CHR_SALESNO ='"+salesno+"'";
//out.println(sql);
String perdata[][]=CommonFunctions.QueryExecute(sql); 

 %>									</td>
						    </tr>

							<tr>
								<td height="19" colspan="4" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
						    </tr>
							 
							<tr>
                              <td width="26%" valign="top" class="boldEleven"><div align="left">Sale .No</div></td>
							  <td width="32%" valign="top" class="boldEleven"><div align="left"><%=perdata[0][0]%></div></td>
							  <td width="17%" valign="top" class="boldEleven"><div align="left">Sale Date</div></td>
							  <td width="25%" valign="top" class="boldEleven"><div align="left"><%=perdata[0][1]%></div></td>
						  </tr>
							<tr>
							  <td valign="top" class="boldEleven">Division</td>
							  <td valign="top" class="boldEleven"><%=perdata[0][3]%></td>
							  <td valign="top" class="boldEleven">Contact Person </td>
							  <td valign="top" class="boldEleven"><div align="left"><%=perdata[0][4]%></div></td>
						  </tr>
							<tr>
                              <td valign="top" class="boldEleven"><div align="left"></div></td>
							  <td valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td valign="top" class="boldEleven"><div align="left">Contact Phone </div></td>
							  <td valign="top" class="boldEleven"><%=perdata[0][5]%></td>
						  </tr>
							
							<tr>
							  <td valign="top" class="boldEleven">CustomerName &amp; Address</td>
							  <td valign="top" class="boldEleven"><div align="left"> <%=perdata[0][2]%> </div></td>
							  <td class="boldEleven" align="left" valign="top">Shipping
							  Address </td>
							  <td class="boldEleven" align="left" valign="top">
                              <%
							  sql="SELECT a.INT_CUSTOMERID,f.CHR_NAME,a.CHR_ADDRESS1,a.CHR_ADDRESS2, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),CONCAT('Phone :',a.CHR_AREACODE,'-',a.CHR_PHONE),CONCAT('MOBILE :',a.CHR_MOBILE),CONCAT('E-Mail :',a.CHR_EMAIL),a.CHR_TIN,CHR_CST FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND a.INT_CUSTOMERID="+perdata[0][8];
			String vendor[][] =  CommonFunctions.QueryExecute(sql);
							  
						  	if("S".equals(perdata[0][6]))
							{
								
						
								 if(!"-".equals(vendor[0][1]))
							out.println(vendor[0][1]+",<br>");
						if(!"-".equals(vendor[0][2]))	
							out.println(vendor[0][2]+",<br>");
						if(!"-".equals(vendor[0][3]))
							out.println(vendor[0][3]);
						if(!"-".equals(vendor[0][4]))	
							out.println(vendor[0][4]+",<br>");	
						if(!"-".equals(vendor[0][5]))	
							out.println(vendor[0][5]+",<br>");	
							if(!"-".equals(vendor[0][6]))	
							out.println(vendor[0][6]+",<br>");
						if(!"-".equals(vendor[0][7]))	
							out.println(vendor[0][7]+",<br>");	
						if(!"-".equals(vendor[0][8]))	
							out.println(vendor[0][9]+",<br>");									
										
						 																			
										
						 
							}
							else
							{
								out.println(perdata[0][7]);
							}
							
						  %>
                              </td>
						  </tr>
							<tr>
							  <td valign="top" class="boldEleven">Installation Date and Time </td>
							  <td valign="top" class="boldEleven">
							  <span class="boldEleven">
							    
								<input tabindex="2" name="installdate"  readonly="readonly" type="text" class="formText135" id="installdate" size="28" >
							    </span> <span class="boldEleven">
								
								<!--<a
										href="javascript:cal2.popup();"> <img
										src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" /> </a> -->
                                <script language='JavaScript'
										type="text/javascript">
		<!--			
				var cal2 = new calendar1(document.forms['frm'].elements['installdate']);
				cal2.year_scroll = true;
				cal2.time_comp = true;
				setCurrentDateandTime('installdate'); 
		//-->
                                </script>
								
								
								<script language="javascript">

$('#installdate').datetimepicker({
	numberOfMonths: 1,
	showSecond: true,
	timeFormat: 'hh:mm:ss',
	minDate: 0,
	maxDate: 10,
	showOn: "button",
	buttonImage: "../JavaScript/jquery/images/calendar.gif",
	buttonImageOnly: true
});
</script>
							    </span>							  </td>
							  <td class="bold1"><span class="boldEleven"> </span></td>
							  <td class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							 
							
							
							 
							<tr>						  </tr>
							
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven">
							  <jsp:include page="../JavaScript/ajax.jsp" flush="true" />							  </td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven"><div align="center">
							    <%
	String iname="";
					String itemname="";
					
	sql = "SELECT INT_ID,CHR_SALESNO,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY,CHR_TYPE,CHR_SWAPDESC FROM inv_t_swapsalesserialno WHERE CHR_SALESNO ='"+salesno+"' ORDER By INT_ID";
	//out.println(sql);
	
	String usertype=""+session.getAttribute("USRTYPE");
	String recdData[][]= com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
	int row=1;
	iname="";
	itemname="";
	String masterwarranty="";
	String h="";
	String h1="";
	String typedesc="";
	if(recdData.length>0)
	{
		out.print(" <table width='100%' class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.print("<tr class='MRow1'>");
		out.print("<th   class='boldEleven'><b>Type</b></th>");
		out.print("<th   class='boldEleven'><b>Item / Product Code</b></th>");
		out.print("<th   class='boldEleven'><b>Description</b></th>");
		out.print("<th   class='boldEleven'><b>Serial No</b></th> ");
		out.print("<th   class='boldEleven'><b>Warranty</b></th>");
		out.print("</tr>");
		for(int v=0;v<recdData.length; v++)
		{	
			
			
			if(recdData[v][5].equals("I"))
			{
				iname="Item";
				sql = "SELECT CHR_ITEMNAME ,CHR_WARRANTY,CHR_DES FROM inv_m_item WHERE CHR_ITEMID='"+recdData[v][2]+"'";
				itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
				masterwarranty=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_WARRANTY");
				typedesc=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_DES");
			}	
			if(recdData[v][5].equals("P"))
			{
			  iname="Product";
			  sql="SELECT CHR_PRODUCTCODE,CHR_WARRANTY ,CHR_PRODUCTDESC FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+recdData[v][2]+"'";
			  itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
			  masterwarranty=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_WARRANTY");
			  typedesc=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTDESC");
			}	
			out.println("<tr class='MRow1'><td valign='top'  class='boldEleven' >"+iname+"</td>");
			out.println("<td  valign='top' class='boldEleven' >"+itemname);
			
			if(recdData.length>=1)
				h=" onBlur=\"getValues('serial','"+recdData.length+"' ,'error' , 'Submit')\" ";
	
	h1=" onKeyUp=\"upperMe(this),LoadUniqueCheckSales('serial"+(v+1)+"','Valid"+(v+1)+"' , 'inv_t_vendorgoodsreceived','CHR_SERIALNO','Submit','"+recdData[v][5]+"','"+recdData[v][2]+"')\" ";
	
		
			out.print("<td  valign='top' class='boldEleven'>"+typedesc+" <br> "+recdData[v][6]+"</td>");
			if("-".equals(recdData[v][3]))		
				recdData[v][3]="";
			
			out.print("<td  valign='top' class='boldEleven'>"+recdData[v][3]+"</td>");

			
			 
			out.print("<td  valign='top' class='boldEleven'>&nbsp;"+recdData[v][4]+" -Years</td>");
			
			
			out.print("</tr>");
			row= row+1;
		}
		out.print("</table> ");
	}		
	out.println("<input type='hidden' name='length' id='length' value='"+row+"'>");
	out.println("<input type='hidden' name='salesno' id='salesno' value='"+salesno+"'>");  
%>
						      </div></td>
						  </tr>
							<tr>
							  <td height="17" colspan="4" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;							  							  </td>
						  </tr>
							<tr>
								<td height="17" valign="top" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="3" align="left"><input name="filename" type="hidden" value="SalesInstallation" />
							    <input name="actionS"
									type="hidden" value="INVSalesInstallationAssigned" />
							    <input name="salesno" type="hidden" id="salesno" value="<%=salesno%>">
							    <input name="division" type="hidden" id="division" value="<%=perdata[0][9]%>"></td>
							</tr>
							<tr>
								<td height="17" colspan="4" class="boldEleven">
								<table width="250" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td>
										<%
										if(recdData.length>0)
											out.println("<input name='Submit' id='Submit' type='submit'class='buttonbold13' value='Installation Assigned'>");
											else
											out.println("<font class='bolddeepred'>Kindly check the Invoice, Only consumable available.</font>");
										%>										</td>
										<td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('SalesInstallation.jsp')"></td>
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
<script language="JavaScript">

function Validate()
  {

	 
	 	
	if( 
	
	 checkNull( "installdate","Enter Install date and time" )
	 && checkNull( "ename","Select engineer name" )
 	
	)
		return true;
	else
		return false;				
		
 } 	
 
  
 
  
	
  
</script> <%@ include file="../footer.jsp"%></form>
</body>
</html>
<%
}
catch(Exception e)
{
out.println(e.getMessage());
}
%>
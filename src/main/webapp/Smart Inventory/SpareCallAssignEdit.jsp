 <%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
 <%
try
{
%>

<html>
<head>
<title><%= CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='INV' ")[0][0]%></title>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<style type="text/css">
@import url("../JavaScript/SmartStyles.css");
</style>

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

 
</head>
 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script src="../JavaScript/common/StaffloadAjax.js"></script>


<link href="../JavaScript/jquery/Time/jquery-ui.css" rel="stylesheet" type="text/css">
<link href="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui.min.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-sliderAccess.js"></script>


<script language="javascript">
function validate()
{
	try
	{
		if( 
			checkNullSelect('problem','Select Problems','')
			&& checkNull('cperson','Enter the Contact person')
			&& checkNull('description','Enter the description')
			&& checkNullSelect('ename','Select Engineer','')
		)
			return true;
		else
			return false;
	}
	catch(err)
	{
		alert(err);
	}

}
 </script>

<body onLoad="init()">
<jsp:include page="indexinv.jsp" />


<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	 
	<tr>
		<td>
		<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return validate()">
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="800"
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
					<td width="5"><spacer height="1" width="1" type="block" /></td>
				  <td width="464"><table width="100%" height="323" border="0" align="center" cellpadding="2" cellspacing="2" class="boldEleven">
          
               
			  	 <tr>
			  	   <td height="22" colspan="4" align="center" class="bold1">CALL ASSIGN
                   <%
				String rowid = request.getParameter("id");
				String sql = "";
				sql = sql + " SELECT CHR_CALLASSIGNREFNO,INT_CALLNO,CHR_SERIALNO, DATE_FORMAT(DAT_CALLASSIGNDATE,'%d-%m-%Y %h:%i:%s'),  ";
				sql = sql + " CHR_PRIORITY,INT_HOURS,INT_PROBLEMID,CHR_CONTACTPERSON,  CHR_PHONE,CHR_MOBILE,CHR_EMAIL , ";  
				sql = sql + " CHR_REMARKS,CHR_ENGINEER,CHR_CREATEDBY,DT_CREATION ,  CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS  ";
				sql = sql + " FROM spare_t_callassign WHERE INT_CALLASSIGNID = "+rowid;
				//out.println(sql);
				String	calldata[][]= CommonFunctions.QueryExecute(sql);
				 
				sql =   " SELECT a.INT_ROWID, FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID), CONCAT(b.CHR_STATENAME,' [ ', b.CHR_SHORTNAME, ' ]' ), ";
				sql = sql + " c.CHR_EQUIPEMENTTYPENAME,e.CHR_MODEL,a.CHR_CATEGORY, ";
	 	 		sql = sql + " a.CHR_SERIALNO,DATE_FORMAT(a.DT_STARTDATE,'%d-%b-%Y'),DATE_FORMAT(a.DT_ENDDATE,'%d-%b-%Y'), ";  
	 	 		sql = sql + "  if(datediff(now(),a.DT_ENDDATE)<=0,'Live','Expired')  ";
	 	 		sql = sql + " FROM spare_m_equipement_master a ,com_m_state b, spare_m_equipement_type c ,  spare_m_equipement_model e ";
	 	 		sql = sql + " WHERE a.INT_ROWID > 0  AND a.INT_STATEID = b.INT_STATEID "; 
	 	 		sql = sql + " AND a.INT_EQUIPEMENTTYPEID  = c.INT_EQUIPEMENTTYPEID ";
	 	 		sql = sql + " AND a.INT_INT_EQUIPEMENTMODELID = e.INT_INT_EQUIPEMENTMODELID ";
	 	 		sql = sql + " AND a.CHR_SERIALNO = "+calldata[0][2];
				//out.println(sql);
				String	data[][]= CommonFunctions.QueryExecute(sql);
				   %>
                   
                   </td>
			  	   </tr>
			  	 <tr>
                <td width="128"  height="22"><strong>Call Number <span class="boldred">*</span></strong></td>
                <td width="236"   valign="top"><input type="text" size ="25" class="formText135"  name="callno" value="<%=calldata[0][1]%>" id="callno" maxlength="11" onKeyPress="return numeric_only(event,'callno','13')" required /></td>
                <td width="159" class="boldEleven" ><strong>Customer</strong></td>
                <td width="231"><%=data[0][1]%></td>
              </tr>
			   <tr>
                <td ><strong>Serial Number</strong></td>
                <td   valign="top" class="bolddeepred"><%=data[0][6]%><input name="serialnumber" id="serialnumber" type="hidden" value="<%=data[0][6]%>"></td>
                <td width="159" class="boldEleven" ><strong>Address</strong></td>
				<td width="231">&nbsp;</td>
              </tr>	 
			   <tr>
			     <td height="22"><strong>Date &amp; Time <span class="boldred">*</span></strong></td>
			     <td valign="top">
                  <input name="startdate" type="text" class="formText135" id="startdate"
									onKeyPress="dateOnly(this)" value="<%=calldata[0][3]%>" size="20" maxlength="10" readonly ='readonly' />  
                         <input name="endingdateandtime" type="hidden" id="endingdateandtime" value="<%=calldata[0][3]%>">
					  
                       
                      <script language="javascript">
$('#startdate').datetimepicker({
	showSecond: true,
	timeFormat: 'hh:mm:ss',
	stepHour: 1,
	stepMinute: 1,
	stepSecond: 10,
	minDate: -10, maxDate: "+1D" ,showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true
});
</script>
                 </td>
			     <td class="boldEleven" ><strong>Location</strong></td>
			     <td><%=data[0][2]%></td>
			     </tr>
			   <tr>
			     <td height="22"><strong>Priority Type
                 <%
				 String s1="",s2="";
				 if("RESP".equals(calldata[0][4]))
				 	s1 = " checked = 'checked' ";
					
				if("RESO".equals(calldata[0][4]))
				 	s2 = " checked = 'checked' ";	
				 %>
                 <span class="boldred"> *</span></strong></td>
			     <td   valign="top"><table width="100" border="0">
			       <tr class="boldEleven">
			         <td width="20"><input name="prioritytype" type="radio" id="radio" value="RESP" <%=s1%> ></td>
			         <td width="20">Response</td>
			         <td width="30"><input type="radio" name="prioritytype" id="radio" value="RESO" <%=s2%> ></td>
			         <td width="12">Resolution</td>
			         </tr>
			       </table></td>
			     <td class="boldEleven" ><strong>Equipment Type</strong></td>
			     <td><%=data[0][3]%></td>
			     </tr>
			   <tr>
			     <td height="22">&nbsp;</td>
			     <td   valign="top"><select name="inhours" class="formText135" id="inhours" style="width:200">
			       <option value="">Select Response Hours</option>
			       <option value="2">2-hrs</option>
			       <option value="4">4-hrs</option>
			       <option value="6">6-hrs</option>
			       <option value="8">8-hrs</option>
			       <option value="16">16-hrs</option>
			       <option value="24">24-hrs</option>
			       </select> 
                   <script language="javascript">setOptionValue('inhours','<%=calldata[0][5]%>')</script>
                   </td>
			     <td class="boldEleven" ><strong>Equipment Model</strong></td>
			     <td><%=data[0][4]%></td>
			     </tr>
			   <tr>
                <td height="22">&nbsp;</td>
                <td   valign="top">&nbsp;</td>
                <td width="159" class="boldEleven" ><strong>Category</strong></td>
                <td width="231"><%
				 if("A".equals(data[0][5]))
				 	out.println("AMC");
				 else if("W".equals(data[0][5]))
				 	out.println("WARRANTY");
				 else 
				 	out.println("ONCALL");
					
						
				 %></td>
              </tr>
               
               <tr>
                 <td height="22"><strong>Problems  <span class="boldred">*</span></strong></td>
                 <td valign="top"><select name="problem" class="formText135" id="problem"  style="width:200">
                   <option value="" selected>Select problem</option>
                   <%
				String readDatas[][] =  CommonFunctions.QueryExecute("SELECT INT_PROBLEMID,CHR_PROBLEM  FROM spare_m_problems  ORDER BY CHR_PROBLEM");
				for(int u=0;u<readDatas.length;u++)
					out.println("<option value="+readDatas[u][0]+">"+readDatas[u][1]+"</option>");
				%>
                 </select><%=calldata[0][6]%>
                 <script language="javascript">setOptionValue('problem','<%=calldata[0][6]%>')</script>
                 </td>
                 <td class="boldEleven" >&nbsp;</td>
                 <td>&nbsp;</td>
               </tr>
               <tr>
                 <td height="22" align="left" valign="top"><strong>Contact Person</strong> <strong> <span class="boldred">*</span></strong></td>
                 <td align="left" valign="top"><input name="cperson" type="text" required class="formText135" id="cperson" onKeyUp="upperMe(this)" value="<%=calldata[0][7]%>" size="30" maxlength="100"></td>
                 <td align="left" valign="top"><strong>Phone</strong></td>
                 <td align="left" valign="top"><input name="phone" type="text" class="formText135" id="phone" onKeyPress="return numeric_only(event,'phone','12')" value="<%=calldata[0][8]%>" size="30" maxlength="10"></td>
               </tr>
               <tr>
                 <td height="22" align="left" valign="top"><strong>Email</strong></td>
                 <td align="left" valign="top"><input name="email" type="text" class="formText135" id="email" value="<%=calldata[0][10]%>" size="30" maxlength="100"></td>
                 <td align="left" valign="top"><strong>Mobile</strong></td>
                 <td align="left" valign="top"><input name="mobile" type="text" class="formText135" id="mobile" onKeyPress="return numeric_only(event,'mobile','11')" value="<%=calldata[0][9]%>" size="30" maxlength="10"></td>
               </tr>
               <tr>
                 <td height="22" align="left" valign="top"><strong>Remarks <span class="boldred">*</span></strong></td>
                 <td colspan="3" align="left" valign="top"><textarea type="text" name="description"   cols="90" id="description" rows="3" class="formText135" required onKeyUp="textArea('description','2000')"><%=calldata[0][11]%></textarea></td>
               </tr>
               <tr>
                 <td height="22" align="left" valign="top">&nbsp;</td>
                 <td colspan="3" align="left" valign="top">&nbsp;</td>
               </tr>
               <tr>
                 <td height="22" align="left" valign="top"><strong>Engineer name <span class="boldred">*</span></strong> <%=calldata[0][12]%><br> </td>
                 <td colspan="3" align="left" valign="top">
                 <table width="100%" border="1"  cellspacing="0" cellpadding="0" bordercolor="#000000" >
  <tr >
    <td> <%=calldata[0][12]%><br>  <%@ include file="../JavaScript/ajax.jsp"%></td>
  </tr>
</table>

                 </td>
                 </tr>	
			  
			  
			  

			    
               <tr>
                 <td class="boldEleven">&nbsp;</td>
                 <td valign="top">&nbsp;</td>
                 <td>&nbsp;</td>
                 <td>&nbsp;</td>
               </tr>
               <tr>
                <td class="boldEleven">&nbsp;</td>
                <td valign="top">&nbsp;</td>
                <td><input type="hidden" name="filename" value="SpareCallAssign" />
                  <input type="hidden" name="actionS" value="INVSpareCallAssignEdit"/>
                  <input name="rowid" type="hidden" id="rowid" value=" <%=rowid%>"></td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="36" colspan="4"><table border="0" align="center" cellpadding="2"
										cellspacing="2">
                    <tr>
                      <td width="56"><input type="submit" name="Submit"	id="Submit" class="buttonbold"  value="Update"   accesskey="s"   /></td>
                      <td width="56"><input type="button" name="submit" class="buttonbold"  value="Close"   accesskey="c" 	onClick="redirect('SpareCallAssignView.jsp')" /></td>
                    </tr>
                </table></td>
              </tr>
            </table>
				  
				  
				  </td>
					<td nowrap="nowrap" width="6"><spacer height="1" width="1"
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
		out.println(e.getMessage());
}
%>

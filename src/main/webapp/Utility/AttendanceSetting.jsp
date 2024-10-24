<%@ page contentType="text/html; " language="java" import="java.sql.*" 	errorPage="../error/index.jsp"%>

<%@include file="Redirect.jsp" %>	
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!
	Connection con;
	Statement st;
	ResultSet rst;
	String timeIn,timeOut,lunchIn,lunchOut,graceIn,graceOut;
	String ondudy="",leave="",permission="",manual="",Shifttype="",smartatten="",opt1="",opt2="",opt3="",lossofday1="",lossofday2="";
	String perLimit="",lateLimit="",from="",to="";
	String leaveapply="";
	String attprocess="0";
	String dtpermission="30",dtleave="120",exceedleave="",mailid="",staffregistrationapproval="";
	int ot;
	String day="" , categorys="";
	String selfmarking="";
	boolean f = false;
%>
<html>
<head>

<title> :: UTILITY :: </title>


 
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/JTime/jquery.timePicker.js"></script>
<link href="../JavaScript/JTime/timePicker.css" rel="stylesheet" type="text/css">


<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">         
function  Valid()
{
	var name=confirm("Want to update the settings")
	if (name==true)
	{ 
		if(
			checkNull('TxtIn','Enter Time IN')
			&& checkNull('TxtOut','Enter Time OUT')
			&& checkNull('TxtLunchIn','Enter Lunch IN')
			&& checkNull('TxtLunchOut','Enter Lunch OUT')
			&& checkNull('TxtGraceIn','Enter Grace IN')
			&& checkNull('TxtGraceOut','Enter Grace OUT')
			&& checkNull('TxtOt','Enter Over Time')
			&& checkNull('TxtPermission','Enter no of permission allowed')
			&& checkNull('lossofday1','Enter Loss of Permission day ')
			&& checkNull('TxtLate','Enter no of late allowed')
			&& checkNull('lossofday2','Enter Loss of late day')
			&& checkNullSelect('dtpermission','Select Date Lock for permission Apply ','0')
			&& checkNullSelect('dtleave','Select Date Lock for permission Apply ','0')
			&& checkNullSelect('selfmarking','Select selfmarking','0')
		 
		  )
		   return true;			
		 else
		 	return false; 
	}
	else
		return false;
}		 
</script>


 <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
 </style>
</head>
 
<%
           try{
           
        	 con=conbean.getConnection();
        	 st=con.createStatement();
        	 rst=st.executeQuery("SELECT * FROM  att_m_basicsettings ");        	
			while(rst.next())
			{   
				ondudy=""+rst.getString("CHR_OD");
				leave=""+rst.getString("CHR_PER");
				permission=""+rst.getString("CHR_MANUAL");
				manual=""+rst.getString("CHR_LEAVE");
				smartatten=""+rst.getString("CHR_SMARTATTENDANCE");
				Shifttype=""+rst.getString("CHR_SHIFTTYPE");
				timeIn=""+rst.getString("TIM_TIMEIN");
				timeOut=""+rst.getString("TIM_TIMEOUT");
				lunchIn=""+rst.getString("TIM_LUNCHIN");
				lunchOut=""+rst.getString("TIM_LUNCHOUT");
				graceIn=""+rst.getString("TIM_GRACEIN");
				graceOut=""+rst.getString("TIM_GRACEOUT");
				perLimit=""+rst.getString("INT_PERLIMIT");
				lateLimit=""+rst.getString("INT_LATELIMIT");
				lossofday1=""+rst.getString("DOU_LOSSOFDAY1");
				lossofday2=""+rst.getString("DOU_LOSSOFDAY2");
				leaveapply=""+rst.getString("INT_LEAVEAPPLY");
				attprocess=""+rst.getString("INT_ATTENDANCEPROCESS");
				day=""+rst.getString("INT_ATTENDANCEMARK");
				categorys=""+rst.getString("CHR_ATT_SKIP_CATEGORY");
				selfmarking=""+rst.getString("CHR_ATTENDANCE_SELFMARKING");
				
				dtpermission=""+rst.getString("INT_DTLOCKPERMISSION");
				dtleave=""+rst.getString("INT_DTLOCKLEAVE");
				exceedleave=""+rst.getString("CHR_LEAVEEXCEED");
				mailid=""+rst.getString("CHR_ATTENDANCEPENDINGMAIL");
				staffregistrationapproval=""+rst.getString("CHR_STAFFREGISTRATION_APPROVAL_PENDING_MAILIDS");
				
				if(timeIn.equals("null")) timeIn=""; 
				if(timeOut.equals("null")) timeOut="";
				if(lunchIn.equals("null")) lunchIn="";
				if(lunchOut.equals("null")) lunchOut="";
				if(graceIn.equals("null")) graceIn="";
				if(graceOut.equals("null")) graceOut="";
				if(perLimit.equals("null")) perLimit="";
				if(lateLimit.equals("null")) lateLimit="";
				if(lossofday1.equals("null")) lossofday1="";
				if(lossofday2.equals("null")) lossofday2="";
				if(leaveapply.equals("null")) leaveapply="";
				
				ot=rst.getInt("INT_OT");
				from =rst.getString("INT_FROM");
				to =rst.getString("INT_TO");
			}
		}  
	    catch(Exception e)
		{
		} 
	        
        %>
 

<body  onpaste='return false;'>
<form name="a" action="AttendanceSettingUpdate.jsp" onSubmit="return Valid()">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
	  <td height="34" align="center"><!--DWLayoutEmptyCell-->&nbsp;</td>
    </tr>
	<tr>
	  <td height="19" align="center"><!--DWLayoutEmptyCell-->&nbsp;</td>
    </tr>
	<tr>
		<td height="170" align="center"> <div align="center">
		  <table width="800"   border="0" align="center" cellpadding="1"
			cellspacing="1">
		    <tr>
		      <td  align="center" valign="middle">
			  <div align="center">
		        <table width="100%" border="0" align="center" cellpadding="0"
					cellspacing="0" bgcolor="#dce4f9" class="BackGround">
		          <tbody>
		            <tr>
		              <td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/TLCorner.gif" width="7" /></td>
                        <td class="BorderLine" height="1"><spacer height="1"
								width="1" type="block" /></td>
                        <td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/TRCorner.gif" width="7" /></td>
                      </tr>
		            <tr>
		              <td height="6"><spacer height="1" width="1" type="block" /></td>
                      </tr>
		            <tr>
		              <td class="BorderLine" width="1"><spacer height="1"
								width="1" type="block" /></td>
                        <td width="6"><spacer height="1" width="1" type="block" /></td>
                        <td width="577" valign="top"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                          <tr>
                            <td width="100%"><div align="center" class="copyright">Smart Attendance</div></td>
                            </tr>
                          <tr>
                            <td>&nbsp;</td>
                            </tr>
                          <tr>
                            <td><div align="center">
                              <table width="100%" border="0" cellspacing="2" cellpadding="1">
                                <tr>
                                  <td width="225" class="boldEleven">OnDuty</td>
                                      <td width="169"><select name="RadioDuty" class="formText135" id="RadioDuty" style="width:100">
                                        <option value="B">BioMetric</option>
                                        <option value="S">SmartCard</option>
                                        <option value="P">Proxymity</option>
                                        <option value="M">Manual</option>
                                        </select>
                                      <script language="javascript">setOptionValue('RadioDuty','<%=ondudy%>')</script>                                  </td>
                                      <td width="166" class="boldEleven">Leave</td>
                                      <td width="197"><select name="RadioLeave" class="formText135" id="RadioLeave" style="width:100">
                                        <option value="B">BioMetric</option>
                                        <option value="S">SmartCard</option>
                                        <option value="P">Proxymity</option>
                                        <option value="M">Manual</option>
                                        </select>
                                      <script language="javascript">setOptionValue('RadioLeave','<%=leave%>')</script>                                  </td>
                                    </tr>
                                <tr>
                                  <td class="boldEleven">Permission</td>
                                      <td><select name="RadioPermission" class="formText135" id="RadioPermission" style="width:100">
                                        <option value="B">BioMetric</option>
                                        <option value="S">SmartCard</option>
                                        <option value="P">Proxymity</option>
                                        <option value="M">Manual</option>
                                        </select>
                                        <script language="javascript">setOptionValue('RadioPermission','<%=permission%>')</script>                                  </td>
                                      <td class="boldEleven">Manual</td>
                                      <td><select name="RadioManual" class="formText135" id="RadioManual" style="width:100">
                                        <option value="B">BioMetric</option>
                                        <option value="S">SmartCard</option>
                                        <option value="P">Proxymity</option>
                                        <option value="M">Manual</option>
                                        </select>
                                        <script language="javascript">setOptionValue('RadioManual','<%=manual%>')</script>                                  </td>
                                    </tr>
                                <tr>
                                  <td class="boldEleven">SmartAttendance</td>
                                      <td><select name="RadioSmart" class="formText135" id="RadioSmart" style="width:100">
                                        <option value="B">BioMetric</option>
                                        <option value="S">SmartCard</option>
                                        <option value="P">Proxymity</option>
                                        <option value="M">Manual</option>
                                        </select>
                                        <script language="javascript">setOptionValue('RadioSmart','<%=smartatten%>')</script>                                  </td>
                                      <td class="boldEleven">Shift Type </td>
                                      <td><span class="tabledata">
                                        <select name="Shifttype" class="formText135" id="Shifttype" style="width:100">
                                          <%
													String ss="";
													if("SWS".equals(Shifttype))
														ss= "  selected='selected' ";
												%>
                                          <option value="SWS" <%=ss%>>Single Entry Withshift</option>
                                          <%
													ss="";
													if("SWOS".equals(Shifttype))
														ss= "  selected='selected' ";
												%>
                                          <option value="SWOS" <%=ss%>>Single Entry Withoutshift</option>
                                          <%
													ss="";
													if("MWS".equals(Shifttype))
														ss= "  selected='selected' ";
												%>
                                          <option value="MWS" <%=ss%>>Multi Entry Withshift</option>
                                          <%
													ss="";
													if("MWOS".equals(Shifttype))
														ss= "  selected='selected' ";
												%>
                                          <option value="MWOS" <%=ss%>>Multi Entry Withoutshift</option>
                                        </select>
                                      </span></td>
                                    </tr>
                                <tr>
                                  <td colspan="4">&nbsp;</td>
                                    </tr>
                                <tr>
                                  <td colspan="4"><div align="center"><span class="tablesubhead">Time-Setting </span></div></td>
                                    </tr>
                                 
                                <tr>
                                  <td class="boldEleven">Time IN <span class="errormessage">(</span> <span class="errormessage">HH : MM :SS ) </span></td>
                                      <td><span class="boldEleven">
                                        <input
												name="TxtIn" type="text" class="formText135" id="TxtIn"
												 value="<%=timeIn%>"
												size="15" maxlength="12" />
                                      </span></td>
                                      <td class="boldEleven">Time OUT<span class="errormessage">( HH : MM :SS
                                      )</span></td>
                                      <td><input name="TxtOut" type="text"
												class="formText135" id="TxtOut"
												onKeyPress="timeOnly('TxtOut','12')" value="<%=timeOut%>"
												size="15" /></td>
                                    </tr>
                                <tr>
                                  <td class="boldEleven">Lunch IN<span class="errormessage">(
                                      HH : MM :SS )</span></td>
                                      <td><input name="TxtLunchIn" type="text"
												class="formText135" id="TxtLunchIn"
												onKeyPress="timeOnly('TxtLunchIn','12')"
												value="<%=lunchIn%>" size="15" /></td>
                                      <td class="boldEleven">Lunch OUT<span class="errormessage">(
                                      HH : MM :SS )</span></td>
                                      <td><input name="TxtLunchOut" type="text"
												class="formText135" id="TxtLunchOut"
												onKeyPress="timeOnly('TxtLunchOut','12')"
												value="<%=lunchOut%>" size="15" /></td>
                                    </tr>
                                <tr>
                                  <td class="boldEleven">Grace IN<span class="errormessage">(
                                      HH : MM :SS )</span></td>
                                      <td><input name="TxtGraceIn" type="text"
												class="formText135" id="TxtGraceIn"
												 
												value="<%=graceIn%>" size="15" maxlength="8" /></td>
                                      <td class="boldEleven">Grace OUT<span class="errormessage">(
                                      HH : MM :SS )</span></td>
                                      <td class="errormessage">
                                        <input
												name="TxtGraceOut" type="text" class="formText135"
												id="TxtGraceOut"
												 
												value="<%=graceOut%>" size="15" maxlength="8"/></td>
                                    </tr>
                                <tr>
                                  <td class="boldEleven">OT</td>
                                      <td><span class="boldEleven">
                                        <input name="TxtOt"
												type="text" class="formText135" id="TxtOt"
												onKeyPress="numericValue('TxtOt','4')" value="<%=ot%>"
												size="15" />
                                      </span></td>
                                      <td class="boldEleven">&nbsp;</td>
                                      <td>&nbsp;</td>
                                    </tr>
                                <tr>
                                  <td class="boldEleven">Permission
                                    Limit<span class="errormessage">in Nos ( Loss of pay)</span></td>
                                      <td class="errormessage">
                                        <input
												name="TxtPermission" type="text" class="formText135"
												id="TxtPermission"
												onKeyPress="numericValue('TxtPermission','1')"
												value="<%=perLimit%>" size="15" /></td>
                                      <td class="boldEleven">Loss of Day </td>
                                      <td><span class="boldEleven">
                                        <input
												name="lossofday1" type="text" class="formText135"
												id="lossofday1"
												onKeyPress="doubleValue('lossofday1','3')"
												value="<%=lossofday1%>" size="15" />
                                      </span></td>
                                    </tr>
                                <tr>
                                  <td class="boldEleven">Late
                                    Limit<span class="errormessage"> in Nos ( Loss of pay)</span></td>
                                      <td class="errormessage">
                                        <input
												name="TxtLate" type="text" class="formText135" id="TxtLate"
												onKeyPress="numericValue('TxtLate','1')"
												value="<%=lateLimit%>" size="15" /></td>
                                      <td class="boldEleven">Loss of Day </td>
                                      <td><span class="boldEleven">
                                        <input
												name="lossofday2" type="text" class="formText135"
												id="lossofday2"
												onKeyPress="doubleValue('lossofday2','3')"
												value="<%=lossofday2%>" size="15" />
                                      </span></td>
                                    </tr>
                                <tr>
                                  <td valign="top" class="boldEleven">Leave/Permission Apply (before) <span class="errormessage">(days) </span></td>
                                      <td valign="top" class="errormessage">
                                        <input
												name="leaveapply" type="text" class="formText135"
												id="leaveapply"
												onKeyPress="numericValue('leaveapply','2')"
												value="<%=leaveapply%>" size="15" /></td>
                                      <td valign="top" class="boldEleven">Category</td>
                                      <td valign="top"><select name="Category" class="formText135" id="Category" multiple="multiple" size="5">
                                        <option value="0">Select</option>
                                        <%
									
									
									
									
	String empcategorysql=" SELECT INT_EMPLOYEECATEGORYID,CHR_CATEGORYNAME  FROM   com_m_employeecategory   ORDER BY CHR_CATEGORYNAME ";
	String empcategoryData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(empcategorysql);
	/*if (empcategoryData.length>0)
		for (int i=0; i<empcategoryData.length; i++) 
			out.println("<option value="+empcategoryData[i][0]+">"+empcategoryData[i][1] +"</option>");			
	*/
	
	
	
	
	 String tdata[] = categorys.split(",");
	 for(int i=0;i<empcategoryData.length;i++) 
	 {
		 	f = false;
		  	for(int u=0; u<tdata.length;u++)
				if(tdata[u].equals(empcategoryData[i][0]) )
					f= true;
			if(f)
				out.println("<option value='"+empcategoryData[i][0]+"' selected='selected'    >"+  empcategoryData[i][1]+"</option>");
			else
				out.println("<option value='"+empcategoryData[i][0]+"'   >"+empcategoryData[i][1]+"</option>");	
				/**/
	}	 
	
	
						%>
                                      </select></td>
                                    </tr>
                                <tr>
                                  <td valign="top" class="boldEleven">Attendance Mark Up to </td>
                                      <td valign="top">
                                        <select name="day" class="formText135" id="day" style="width:100">
                                          <%
								  	for(int u=0;u<31;u++)
										out.println("<option value='"+(u+1)+"'>"+(u+1)+"</option>");
								  %>
                                        </select>
                                      <script language="javascript">setOptionValue('day','<%=day%>')</script>								                                    </td>
                                      <td valign="top" class="boldEleven">Attendance Process Lock </td>
                                      <td valign="top"><select name="attprocess" class="formText135" id="attprocess" style="width:100">
                                        <%
								  	for(int u=0;u<60;u++)
										out.println("<option value='"+(u+1)+"'>"+(u+1)+"</option>");
								  %>
                                      </select> <script language="javascript">setOptionValue('attprocess','<%=attprocess%>')</script></td>
                                    </tr>
                                <tr>
                                  <td colspan="4" class="boldEleven"><div align="center"><span class="staffsearch">Attendance Cycle 2 </span></div></td>
                                    </tr>
                                <tr>
                                  <td class="boldEleven">From date </td>
                                      <td>
                                        <select name="from" class="formText135" id="from" style="width:100">
                                          <%
								  	for(int u=15;u<30;u++)
										out.println("<option value='"+u+"'>"+u+"</option>");
								  %>
                                        </select>
                                      <script language="javascript">setOptionValue('from','<%=from%>')</script>                                  </td>
                                      <td class="boldEleven">To date </td>
                                      <td>
                                        <select name="to" class="formText135" id="to" style="width:100">
                                          <%
								  	for(int u=15;u<30;u++)
										out.println("<option value='"+u+"'>"+u+"</option>");
								  %>
                                        </select>
                                      <script language="javascript">setOptionValue('to','<%=to%>')</script>																	</td>
                                    </tr>
                                <tr>
                                  <td class="boldEleven">Leave Credit </td>
                                      <td><select name="leavecredit" class="formText135" id="leavecredit" style="width:100">
                                        <option value="C" selected="selected">Calendar Year [ January ]</option>
                                        <option value="F">Financial Year [ April ]</option>
                                        </select>                                    </td>
                                      <td class="boldEleven">Exceed the Leave </td>
                                      <td><select name="exceedleave" class="formText135" id="exceedleave" style="width:100">
                                    <option value="A">Going to Absent Entry</option>
									<option value="N">Going to Negative Entry</option>
                                  </select>
								  <script language="javascript">setOptionValue('exceedleave','<%=exceedleave%>')</script></td>
                                    </tr>
                                <tr>
                                  <td class="boldEleven">Date Lock for permission Apply </td>
                                      <td>
                                        
                                        <select name="dtpermission" class="formText135" id="dtpermission" style="width:100">
                                          <option value="0">Select Date Lock for permission Apply</option> 
                                          <%
								  	for(int u=0;u<=31;u++)
										out.println("<option value='"+(u+1)+"'>"+(u+1)+"</option>");
								  %>
                                        </select>
                                        <script language="javascript">setOptionValue('dtpermission','<%=dtpermission%>')</script>                                    </td>
                                      <td class="boldEleven">Date lock for leave apply </td>
                                      <td>
                                        <select name="dtleave" class="formText135" id="dtleave"  style="width:100">
                                          <option value="0">Select Date Lock for leave Apply</option> 
                                          <%
								  	for(int u=0;u<=120;u++)
										out.println("<option value='"+(u+1)+"'>"+(u+1)+"</option>");
								  %>
                                        </select>
                                        <script language="javascript">setOptionValue('dtleave','<%=dtleave%>')</script>                                    </td>
                                    </tr>
                                <tr>
                                  <td align="left" valign="top" class="boldEleven">Staff registration Approval Pending mail</td>
                                  <td align="left" valign="top"><textarea name="staffregistrationapproval" cols="20" rows="5" class="formText135" id="staffregistrationapproval" onKeyUp="textArea('mailid','500')"><%=staffregistrationapproval%></textarea>
								  
								  </td>
                                  <td align="left" valign="top" class="boldEleven">Attendance Pending Mailid</td>
                                  <td align="left" valign="top"><textarea name="mailid" cols="20" rows="5" class="formText135" id="mailid" onKeyUp="textArea('mailid','500')"><%=mailid%></textarea></td>
                                </tr>
                                <tr>
                                  <td colspan="4" align="center" class="copyright">Self Marking</td>
                                  </tr>
                                <tr>
                                  <td class="boldEleven">Selfmarking </td>
                                  <td>
                                  <select name="selfmarking" class="formText135" id="selfmarking">
                                  <option value="0" selected>Select self marking</option>
                                  <option value="R">Register marking</option>
                                  <option value="I">Individual marking</option>
                                  </select>
                                  <script language="javascript">setOptionValue('selfmarking','<%=selfmarking%>')</script> 
                                  </td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td>&nbsp;</td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td>&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td>&nbsp;</td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td>&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td>&nbsp;</td>
                                </tr>
                                </table>
                              </div></td>
                            </tr>
                          <tr>
                            <td></td>
                            </tr>
                          <tr>
                            <td height="28">
                              <center>
                                <table border="0" align="center" cellpadding="1"
										cellspacing="1">
                                  <tr>
                                    <td width="56"><input name="Submit2" type="submit"
												class="buttonbold" value="Submit"   accesskey="s"   ></td>
                                      <td width="56"><input class="buttonbold" type="button"
												name="Submit2"  value="Close"   accesskey="c"  onClick="redirect('Userframe.jsp')"></td>
                                    </tr>
                                  </table>
					          </center>						  </td>
                            </tr>
                        </table></td>
                        <td nowrap="nowrap" width="6"><spacer height="1" width="1"
								type="block" /></td>
                        <td width="1" class="BorderLine"><spacer height="1"
								width="1" type="block" /></td>
                      </tr>
		            <tr>
		              <td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/BLCorner.gif" width="7" /></td>
                        <td height="6"><spacer height="1" width="1" type="block" /></td>
                        <td colspan="2" rowspan="2" valign="bottom"><div align="right"><img height="7"
								src="../Image/General/BRCorner.gif" width="7" /></div></td>
                      </tr>
		            <tr>
		              <td class="BorderLine" height="1"></td>
                      </tr>
		            </tbody>
		          </table>
              </div></td>
            </tr>
	        </table>
	  </div></td>
	</tr>
</table>

</form>
</body>
</html>

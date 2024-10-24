    <%@ page import="java.sql.*,java.util.*,java.io.*"%>
 <%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>
<title>:: MANAGEMENT ::</title> 
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id,payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
 <script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>


<script type="text/javascript" src="../JavaScript/Jdateandtime/js/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../JavaScript/Jdateandtime/js/jquery.ui.core.js"></script>
<script type="text/javascript" src="../JavaScript/Jdateandtime/js/jquery.ui.widget.js"></script>
<script type="text/javascript" src="../JavaScript/Jdateandtime/js/jquery.ui.datepicker.js"></script>
<script type="text/javascript" src="../JavaScript/Jdateandtime/jsDateTimePickerV1/DateTimePicker.js"></script>

<link type="text/css" href="../JavaScript/Jdateandtime/css/jquery.ui.theme.css" rel="stylesheet" />
<link type="text/css" href="../JavaScript/Jdateandtime/css/jquery.ui.datepicker.css" rel="stylesheet" />
<link type="text/css" href="../JavaScript/Jdateandtime/css/demos.css" rel="stylesheet" />
	
    
    
<script language="JavaScript">



$(function() {
	$( "#fromdate" ).datetimepicker({
		
		showSecond: true,
		timeFormat: 'hh:mm:ss',
		stepHour: 1,
		stepMinute: 1,
		stepSecond: 10,
		changeMonth: true,
		changeYear: true,
		showOn: "button",
		buttonImage: "../JavaScript/jquery/images/calendar.gif",
		buttonImageOnly: true,
		minDate: -7, maxDate: "+60D"  
	});
}); 

$(function() {
	$( "#validupto" ).datetimepicker({
		
		showSecond: true,
		timeFormat: 'hh:mm:ss',
		stepHour: 1,
		stepMinute: 1,
		stepSecond: 10,
		changeMonth: true,
		changeYear: true,
		showOn: "button",
		buttonImage: "../JavaScript/jquery/images/calendar.gif",
		buttonImageOnly: true,
		minDate: -7, maxDate: "+60D"  
	});
}); 
 
 
 
function Validate()
  {
	
   
	if(  checkNull( "name","Enter The Name" ) 
	     &&  checkNull( "address","Enter The Address" )
		 &&  checkNull( "building","Select the Building" )
		 &&  checkNull( "floor","Select the Floor" )
		 &&  checkNull( "purpose","Select the Purpose" )
		 &&  checkNull( "whomtomeet","Enter The whom to meet" )
		 &&  checkNull( "fromdate","Enter The Time In" )
		 &&  checkNull( "mobile","Enter The mobile" )
		 &&  checkNull( "desc","Enter The description" )
		  )
		 
	
		return true;
	else
		return false;				
		
	
 } 	
 
  

</script>
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="document.getElementById('name').focus()" >
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
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
    <td><table width="75%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td width="60%"><form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">
          <table class="BackGround1" cellspacing="0" cellpadding="0" width="500"
			align="center" border="0">
            <tbody>
              <tr>
                <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
                <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
                <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
              </tr>
              <tr>
                <td height="6"><spacer height="1" width="1" type="block" /></td>
              </tr>
              <tr>
                <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
                <td width="6"><spacer height="1" width="1" type="block" /></td>
                <td width="412" valign="top"><table width="100%" border="0" align="center" cellpadding="2" cellspacing="2">
                  <tr>
                    <td colspan="2" class="bold1"><div align="center"><span class="boldThirteen">VISITORS</span>
                      <%
							String action=request.getParameter("action1");
							String id="",name="",desc="",actionS="",value="";
							String sql="";
							String link="";
							String s1= "";
							String s2= ""; 
							String taxValue="";
							String refno="";
							String building,floor,purpose,mobile;
							String address,whomtomeet,createtime;
							String fromdate,vechileno,notification,emailid,validupto;
	
							if("Add".equals(action))
							{
								id="";name=""; desc=" ";
								s1=""; s2 = " checked = 'checked' ";
								actionS="MGTVisitorsAdd";
								value="Add";taxValue="";
								building="0";floor="0";purpose="0";
								mobile="";
								address="";
								whomtomeet="";refno="";
								fromdate="";createtime="";
								vechileno="";notification="";emailid="";validupto="";
	
								
							}
							 
							else
							{
								id="";name=""; 
								id=request.getParameter("rowid");
								sql = " SELECT   INT_VISITORID, CHR_VISITORNO, CHR_VISITORNAME, CHR_ADDRESS,  ";
								sql = sql + " INT_BUILDINGID, INT_FLOORID, INT_PURPOSEID, CHR_WHOMTOMEET,";
								sql = sql + "  DATE_FORMAT(DT_TIMEIN,'%d-%m-%Y %h:%i:%s'),   ";
								sql = sql + "  CHR_VECHILENO, CHR_NOTIFICATION, INT_MOBILE,CHR_EMAILID,  ";
								sql = sql + "  DATE_FORMAT(DT_VALIDUPTO,'%d-%m-%Y %h:%i:%s'),CHR_DESC,  ";
								sql = sql + "  DATE_FORMAT(DT_CREATIONTIME,'%Y-%m-%d %h:%i:%s') ";
								sql = sql + "  from mgt_m_visitor ";
								sql = sql + "  WHERE  INT_VISITORID = "+id;
								//out.println(sql); 
								String data[][]=CommonFunctions.QueryExecute(sql);
								id=data[0][0];
								refno=data[0][1];  
								name=data[0][2];  
								address=data[0][3];  
								building=data[0][4];  
								floor=data[0][5];  
								purpose=data[0][6];  
								whomtomeet=data[0][7];  
								fromdate=data[0][8];  
								vechileno=data[0][9];  
								notification=data[0][10];  
								mobile=data[0][11];  
								emailid=data[0][12];  
								validupto=data[0][13];  
								desc=data[0][14]; 
								createtime=data[0][15]; 
								 s1="";s2="";
								 if("S".equals(notification))
								 	s1 = " checked= 'checked' ";
								 else	
								 	s2 = " checked= 'checked' ";
	
								actionS="MGTVisitorsEdit";
								value="Update";
								link=" onBlur=\"upperMe(this)\"";
							}
							
						%>
                    </div></td>
                  </tr>
                  <tr>
                    <td width="43%" class="boldEleven">Name <span class="boldred"> *</span></td>
                    <td width="57%" class="boldEleven"><input name="name" type="text" class="formText135" id="name" <%=link%>     onBlur="upperMe(this)"      value="<%=name%>" size="38" maxlength="60" tabindex="1" >
                      <div id='divunitname'></div></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="boldEleven">Address <span class="boldred">*</span></td>
                    <td align="left" valign="top" class="boldEleven"><textarea tabindex="2" name="address" cols="35" rows="5" class="formText135" id="address" onKeyPress="textArea('address','450')" ><%=address%></textarea></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="boldEleven">Building <span class="boldred">*</span></td>
                    <td align="left" valign="top" class="boldEleven"><select name="building" tabindex="3" class="formText135" id="building" style="width:280">
                      <option value="0"  >Select Building</option>
                      <%
				String buildingData[][]=  CommonFunctions.QueryExecute("SELECT INT_BUILDINGID ,CHR_BUILDINGNAME FROM  mgt_m_buildingname ORDER BY CHR_BUILDINGNAME");
			if(buildingData.length>0) 
				for(int i=0;i<buildingData.length;i++)
					out.println("<option value='"+buildingData[i][0]+"'>"+buildingData[i][1]+"</option>");
				%>
                    </select></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="boldEleven">Floor <span class="boldred">*</span></td>
                    <td align="left" valign="top" class="boldEleven"><select name="floor" tabindex="4" class="formText135" id="floor" style="width:280">
                      <option value="0"  >Select Floor</option>
                      <%
				String floorData[][]=  CommonFunctions.QueryExecute("SELECT INT_FLOORID ,CHR_FLOOR FROM  mgt_m_floor ORDER BY CHR_FLOOR");
			if(floorData.length>0) 
				for(int i=0;i<floorData.length;i++)
					out.println("<option value='"+floorData[i][0]+"'>"+floorData[i][1]+"</option>");
				%>
                    </select></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="boldEleven">Purpose <span class="boldred">*</span></td>
                    <td align="left" valign="top" class="boldEleven"><select name="purpose" tabindex="5" class="formText135" id="purpose" style="width:280">
                      <option value="0"  >Select Pupose</option>
                      <%
				String purposeData[][]=  CommonFunctions.QueryExecute("SELECT INT_PURPOSEID ,CHR_PURPOSE FROM  mgt_m_purpose ORDER BY CHR_PURPOSE");
			if(purposeData.length>0) 
				for(int i=0;i<purposeData.length;i++)
					out.println("<option value='"+purposeData[i][0]+"'>"+purposeData[i][1]+"</option>");
				%>
                    </select></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="boldEleven">Whom to Meet <span class="boldred">*</span></td>
                    <td align="left" valign="top" class="boldEleven"><input name="whomtomeet" type="text" class="formText135" id="whomtomeet" tabindex="6"     onBlur="upperMe(this)" value="<%=whomtomeet%>" size="38" maxlength="60" <%=link%>></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="boldEleven">Time IN <span class="boldred">*</span></td>
                    <td align="left" valign="top" class="boldEleven"><input name="fromdate" tabindex="7" type="text" class="formText135" id="fromdate"   value="<%=fromdate%>" size="38" readonly  style="width:260"/></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="boldEleven">Vechile No</td>
                    <td align="left" valign="top" class="boldEleven"><input name="vechileno" type="text" class="formText135" id="vechileno" tabindex="8"     onBlur="upperMe(this)" value="<%=vechileno%>" size="38" maxlength="60" <%=link%>></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="boldEleven">Notification <span class="boldred">*</span></td>
                    <td align="left" valign="top" class="boldEleven"><table width="119" border="0" cellpadding="0" cellspacing="0" class="boldEleven">
                      <tr>
                        <td><input name="notification" type="radio" id="notification" value="S" <%=s1%> tabindex="9">
                          <label for="notification"></label></td>
                        <td>SMS</td>
                        <td><input name="notification" type="radio" id="notification2" tabindex="10" <%=s2%>  value="E"  ></td>
                        <td>E-mail</td>
                      </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="boldEleven">Mobile <span class="boldred">*</span></td>
                    <td align="left" valign="top" class="boldEleven"><input name="mobile" type="text"
																class="formText135" id="mobile" tabindex="11" onKeyPress=" return numeric_only(event,'mobile','11')" value="<%=mobile%>"     
																  size="38"
																maxlength="10"/></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="boldEleven">Email</td>
                    <td align="left" valign="top" class="boldEleven"><input name="emailid" type="email" class="formText135" id="emailid" tabindex="12" value="<%=emailid%>" size="38"  maxlength="90" ></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="boldEleven">Valid Upto <span class="boldred">*</span></td>
                    <td align="left" valign="top" class="boldEleven"><input name="validupto" type="text" tabindex="13" class="formText135" id="validupto"   value="<%=validupto%>" size="38" readonly  style="width:260"/></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="boldEleven">Description</td>
                    <td align="left" valign="top" class="boldEleven"><textarea name="desc" cols="35" rows="5" tabindex="14" class="formText135" id="desc" onKeyPress="textArea('desc','450')" ><%=desc%></textarea>
                      <script language="javascript">
					  setCurrentDateandTime('fromdate');
					   setCurrentDateandTime('validupto');
					   setOptionValue('building','<%=building%>');
					   setOptionValue('floor','<%=floor%>');
					   setOptionValue('purpose','<%=purpose%>');
					  </script></td>
                  </tr>
                  <tr>
                    <td class="boldEleven">&nbsp;</td>
                    <td class="boldEleven"><input type="hidden" name="filename" value="Visitors" />
                      <input type="hidden" name="actionS"  value="<%=actionS%>" />
                      <input name="rowid" type="HIDDEN" id="rowid" value="<%=id%>">
                      <input name="userid" type="hidden" id="userid" value="<%=""+session.getAttribute("USRID")%>">
                      <input name="refno" type="hidden" id="refno" value="<%=refno%>">
                      <input name="createtime" type="hidden" id="createtime" value="<%=createtime%>"></td>
                  </tr>
                  <tr>
                    <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                      <tr>
                        <td><input name="Submit" id="Submit" type="submit" 	tabindex="15" class="buttonbold13" value="<%=value%>"></td>
                        <td><input name="Close" type="button"   class="buttonbold13" id="Close" tabindex="16"  value="Close"   accesskey="c"  	onClick="redirect('Visitors.jsp')"></td>
                      </tr>
                    </table></td>
                  </tr>
                </table></td>
                <td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
                <td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
              </tr>
              <tr>
                <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
                <td height="6"><spacer height="1" width="1" type="block" /></td>
                <td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
              </tr>
              <tr>
                <td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
              </tr>
            </tbody>
          </table>
        </form></td>
        <td width="40%" align="center" valign="middle"><table width="60%" border="0" align="center" cellpadding="3" cellspacing="3" class="boldEleven">
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td align="center">IMAGE CAPTURE</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
        </table></td>
      </tr>
    </table></td>
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
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
<%@ include file="../footer.jsp"%>

 <%	
 
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>
</body>
</html>

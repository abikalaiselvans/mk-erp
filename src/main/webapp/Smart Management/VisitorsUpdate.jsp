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
	$( "#todate" ).datetimepicker({
		
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
	
	
   
	if(  checkNull( "todate","Enter to time" ) 
		  && dateComparision('fromdate','todate','Please check Despatched Date & Time') 
	      )
		 
	
		return true;
	else
		return false;				
		
	
 } 	
 
	
function dateComparision(ctr,ctr1,msg) 
{
	try
	{
		var f1 =  document.getElementById(ctr).value;
		var f2  = document.getElementById(ctr1).value;
		var t1=f1.split(" ");
	  	var t2=f2.split(" ");
	  	f1 = t1[0].split("-")[2]+"-"+t1[0].split("-")[1]+"-"+t1[0].split("-")[0]+" "+t1[1];
		f2 = t2[0].split("-")[2]+"-"+t2[0].split("-")[1]+"-"+t2[0].split("-")[0]+" "+t2[1];
			
		var time1 = new Date(f1.replace(/\-/g,'\/').replace(/[T|Z]/g,' '));
		var time2  = new Date(f2.replace(/\-/g,'\/').replace(/[T|Z]/g,' '));
		 
		if(time1<time2)
		{
			 
			return true; 
		}
		else if(time1.getTime()==time2.getTime())	
		{
			alert("From date&time  and To date&time should not be equals");
			document.getElementById(ctr1).focus();
			return false;
			 
		}
		else if(time1>time2)
		{
			alert("From date&time should be lesser than the to date&time");
			document.getElementById(ctr1).focus();
			return false;
		}
		  
	}
	catch(err)
	{
		alert(err);
		return false;
	}

}

  

</script>
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="document.getElementById('name').focus()" >
<%@ include file="../Smart Marketing/index.jsp"%>
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
	 
							id=request.getParameter("rowid");
							sql = " SELECT   a.INT_VISITORID, a.CHR_VISITORNO, a.CHR_VISITORNAME, a.CHR_ADDRESS,  ";
							sql = sql + "  b.CHR_BUILDINGNAME, c.CHR_FLOOR, d.CHR_PURPOSE, a.CHR_WHOMTOMEET,";
							sql = sql + "  DATE_FORMAT(a.DT_TIMEIN,'%d-%m-%Y %h:%i:%s'),   ";
							sql = sql + "  a.CHR_VECHILENO, a.CHR_NOTIFICATION, a.INT_MOBILE,a.CHR_EMAILID,  ";
							sql = sql + "  DATE_FORMAT(a.DT_VALIDUPTO,'%d-%m-%Y %h:%i:%s'),a.CHR_DESC,  ";
							sql = sql + "  DATE_FORMAT(a.DT_CREATIONTIME,'%Y-%m-%d %h:%i:%s') ";
							sql = sql + "  from mgt_m_visitor a , mgt_m_buildingname b, mgt_m_floor c, mgt_m_purpose d ";
							sql = sql + "  WHERE a.INT_BUILDINGID = b.INT_BUILDINGID ";
 							sql = sql + "  AND a.INT_FLOORID = c.INT_FLOORID ";
							sql = sql + "  AND a.INT_PURPOSEID = d.INT_PURPOSEID ";
							sql = sql + "  AND  a.INT_VISITORID = "+id;
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
								s1 = " SMS ";
							 else	
								s1 = " E-Mail";

							actionS="MGTVisitorsOuttime";
							value="Update Out Time";
							link=" onBlur=\"upperMe(this)\"";
							 
							
						%>
                    </div></td>
                  </tr>
                  <tr>
                    <td width="43%" class="boldEleven">Name <span class="boldred"> </span></td>
                    <td width="57%" class="boldEleven"><%=name%></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="boldEleven">Address <span class="boldred"> </span></td>
                    <td align="left" valign="top" class="boldEleven"><%=address%></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="boldEleven">Building <span class="boldred"> </span></td>
                    <td align="left" valign="top" class="boldEleven"><%=building%></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="boldEleven">Floor <span class="boldred"> </span></td>
                    <td align="left" valign="top" class="boldEleven"><%=floor%> </td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="boldEleven">Purpose <span class="boldred"> </span></td>
                    <td align="left" valign="top" class="boldEleven"><%=purpose%> </td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="boldEleven">Whom to Meet <span class="boldred"> </span></td>
                    <td align="left" valign="top" class="boldEleven"><%=whomtomeet%></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="boldEleven">Time IN <span class="boldred"> </span></td>
                    <td align="left" valign="top" class="boldEleven"><%=fromdate%></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="boldEleven">Time OUT  <span class="boldred">*
                      <input	name="fromdate" type="hidden" id="fromdate"  value="<%=fromdate%>" />
                    </span></td>
                    <td align="left" valign="top" class="boldEleven"><input name="todate" tabindex="7" type="text" class="formText135" id="todate"   value=""  readonly  style="width:200"/>
                     <script language="javascript">setCurrentDateandTime('todate');</script>
                    </td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="boldEleven">Vechile No</td>
                    <td align="left" valign="top" class="boldEleven"><%=vechileno%></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="boldEleven">Notification <span class="boldred"></span></td>
                    <td align="left" valign="top" class="boldEleven"> <%=s1%> </td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="boldEleven">Mobile <span class="boldred"> </span></td>
                    <td align="left" valign="top" class="boldEleven"><%=mobile%></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="boldEleven">Email</td>
                    <td align="left" valign="top" class="boldEleven"><%=emailid%></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="boldEleven">Valid Upto <span class="boldred"></span></td>
                    <td align="left" valign="top" class="boldEleven"><%=validupto%></td>
                  </tr>
                  <tr>
                    <td align="left" valign="top" class="boldEleven">Description</td>
                    <td align="left" valign="top" class="boldEleven"><%=desc%></td>
                  </tr>
                  <tr>
                    <td class="boldEleven">&nbsp;</td>
                    <td class="boldEleven"><input type="hidden" name="filename" value="Visitors" />
                      <input type="hidden" name="actionS"  value="<%=actionS%>" />
                      <input name="rowid" type="HIDDEN" id="rowid" value="<%=id%>">
                      </td>
                  </tr>
                  <tr>
                    <td colspan="2" class="boldEleven"><table width="150" border="0" align="center" cellpadding="1"
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

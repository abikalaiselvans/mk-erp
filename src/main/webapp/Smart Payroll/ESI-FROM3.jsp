<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html>
<head>

<title> :: PAYROLL ::</title>


 
 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Attendance/ReportAjax.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script language="javascript" src="../JavaScript/Inventory/PurchaseRequestDate.js"></script>
<script>

$(function() {
		var dates = $( "#frmdate, #todate" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,changeYear: true,
			maxDate: "+0D" ,showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
			buttonImageOnly: true,
			onSelect: function( selectedDate ) 
			{
				var option = this.id == "frmdate" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings );
					dates.not( this ).datepicker( "option", option, date );
			}
		});
	}); 

 
	</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">
<script language="javascript">
 
function Validate()
{
	if(
	checkNullSelect('company','Select Company','0')
	&& checkNullSelect('branch','Select Branch','0')
	&& checkNullSelect('Office','Select Office','0')
	)
	
		return true;
	else
		return false;
}
function setfocuss()
{
	document.getElementById('company').focus();
}

</script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<%@ include file="index.jsp"%>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="setfocuss()">

<br>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="ESI-FORM3Print.jsp" onSubmit="return Validate()" >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="42">&nbsp;</td>
  </tr>
  <tr> 
    <td>
	<table class="BackGround" cellspacing="0" cellpadding="0" width="390" align="center" border="0">
        <tbody>
          <tr>
            <td colspan="2" rowspan="2" valign="top"><img height="7" src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
            <td class="BorderLine" height="0"><spacer height="1" 
                        width="1" type="block" /></td>
            <td colspan="2" rowspan="2" valign="top"><img height="7" src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
          </tr>
          <tr>
            <td height="6"><spacer height="1" width="1" type="block"/></td>
          </tr>
          <tr>
            <td class="BorderLine" width="1"><spacer height="1" 
                        width="1" type="block" /></td>
            <td width="6"><spacer height="1" width="1" type="block" /></td>
            <td width="412">

	<table width="455" border="0" align="center" cellpadding="0" cellspacing="0"  >
        <!--DWLayoutTable-->
        <tr align="center" valign="middle"> 
          <td height="30" colspan="2" class="BackGround" >ESI - FORM 3 </td>
        </tr>
		<tr>
          <td width="162" height="28" valign="middle" class="boldEleven"> Company <span
									class="bolddeepred">*</span></td>
          <td width="178">
         <select name="company" id="company"  onChange="loadBranch()"  onblur="loadBranch()" class="formText135" style="width:200px"><option value="0">Select</option>
	          <%                  
     					String queryBranch1="SELECT * FROM  com_m_company ";
     					String	branch1[][]= CommonFunctions.QueryExecute(queryBranch1);
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
          </select>          </td>
        </tr>
        <tr>
          <td width="162" height="28" valign="middle" class="boldEleven"> Branch <span
									class="bolddeepred">*</span></td>
          <td width="178">
          <select name="branch" id="branch" class="formText135" style="width:200px">
	          <option value="0">All</option>
          </select>          </td>
        </tr> 
        <tr align="center" valign="middle">
          <td  height="28" align="left" valign="middle" class="boldEleven">office <span
									class="bolddeepred">*</span></td>
          <td align="left" valign="middle" class="boldEleven"><span class="bolddeepblue">
            <%
			   	String branchid=""+session.getAttribute("BRANCHID");
	   			String oficeid=""+session.getAttribute("OFFICEID");
				 
			  %>
            <select name="Office" class="formText135" id="Office" style="width:200px">
              <option value="0" >Select</option>
              <%
								
		String sq=" select INT_OFFICEID,CHR_OFFICENAME from  com_m_office  order by CHR_OFFICENAME";

		String shipids[][] =  CommonFunctions.QueryExecute(sq);
		for(int u=0; u<shipids.length; u++)
			if(shipids[u][0].trim().equals(oficeid.trim()))
				out.print("<option selected = 'selected' value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
			else
				out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][1] +"</option>");
							%>
            </select>
          </span></td>
        </tr>
        <tr class="bolddeepblue">
          <td height="22" valign="middle" class="boldEleven">From <span
									class="bolddeepred">*</span></td>
          <td valign="top" class="boldEleven"><input name="frmdate"
								type="text" class="formText135" id="frmdate"
								 readonly="readonly" size="15">
             </td>
        </tr>
        <tr class="bolddeepblue">
          <td height="22" valign="middle" class="boldEleven">To <span
									class="bolddeepred">*</span></td>
          <td valign="top" class="boldEleven"><input name="todate"
								type="text" class="formText135" id="todate"
								readonly="readonly"  size="15">
              
 <script language="JavaScript">			
 
			setCurrentDate('frmdate');
			setCurrentDate('todate');			
 </script>
 </td>
        </tr>
        
         
        <tr> 
          <td  height="28" colspan="2"  valign="middle"  class="bolddeepblue"><div align="center">
            <table border="0" cellspacing="3" cellpadding="0">
                <tr>
                  <td width="56"><input class="buttonbold14" type="submit" name="Submit2" value="Submit"></td>
                  <td width="56"><input class="buttonbold14" type="Button" name="Submit"  value="Close"   accesskey="c"  onClick="redirect('Payrollmain.jsp')"></td>
                </tr>
                      </table>
          </div></td>
          </tr>
      </table>	  </td>
            <td nowrap="nowrap" width="4"><spacer height="1" width="1" 
                        type="block" /></td>
            <td class="BorderLine" width="1"><spacer height="1" 
                        width="1" type="block" /></td>
          </tr>
          <tr>
            <td colspan="2" rowspan="2"><img height="7" src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
            <td height="6"><spacer height="1" width="1" type="block" /></td>
            <td colspan="2" rowspan="2"><img height="7" src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
          </tr>
          <tr>
            <td class="BorderLine" height="0"><spacer height="1" width="1" type="block" /></td>
          </tr>
        </tbody>
      </table>	  </td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  <tr>
    <td>&nbsp;</td>
</table>
  </form>
<%@ include file="../footer.jsp"%>
</body>

</html>

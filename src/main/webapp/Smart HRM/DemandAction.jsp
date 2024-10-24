<%@ page import="java.io.*,java.util.*" %>


<%!
	String stateName,stateId;
	String districtName,districtDes,districtId;
	String actionStu;
%>
<html>
<head>

<title>:: HRM ::</title>


 
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/HRM/loadJobtitle.js"></script>
<script language="JavaScript">
function valid()
  {
  	if(
	checkNullSelect("office","Select the Location","0")
	&& checkNullSelect("jobgrade","Select the Grade","select")
	&& checkNullSelect("jobTitle","Select the jobTitle","0")
	&& checkNullSelect("demandraisedby","Select the demand raised by","0")
	&& checkNull("demandescription","Enter the Demand Description")
  	&& checkNull("demand","Enter the Demand value"))
	
	
	{
		if (document.frmDemandAction.demand.value>0)
		{
				return true;
		}
		else
		{
			alert("Demand value must be greater than 0");
			document.frmDemandAction.demand.focus();
			return false;
		}
	}
	else
		return false;	
	
  }  	
</script>
 <link href="../Styles/styles.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style3 {color: #FF0000}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
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
<body  onpaste="return false;" onLoad="document.getElementById('jobgrade').focus()">
<form  AUTOCOMPLETE = "off" method="post" name='frmDemandAction' action="../SmartLoginAuth" >
<%@ include file="indexhrm.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>	</td>
  </tr>
  <tr>
    <td height="19">&nbsp;</td>
  </tr>
  <tr>
    <td height="19">&nbsp;</td>
  </tr>
  <tr>
    <td height="19">&nbsp;</td>
  </tr>
  
  <tr>
    <td>
	<TABLE width=440 border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#dce4f9" class=BackGround>
          <TBODY>
            <TR>
              <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/TLCorner.gif" width=7></TD>
              <TD class=BorderLine height=1><SPACER height="1" 
                        width="1" type="block" /></TD>
              <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/TRCorner.gif" width=7></TD>
            </TR>
            <TR>
              <TD height=6><SPACER height="1" width="1" type="block"/></TD>
            </TR>
            <TR>
              <TD class=BorderLine width=1><SPACER height="1" 
                        width="1" type="block" /></TD>
              <TD width=6><SPACER height="1" width="1" type="block" 
                      /></TD>
              <TD width=425 valign="top">
	<table width="425" border="0" class="BackGround"   align="center" cellpadding="2" cellspacing="2"  >
	        <!--DWLayoutTable-->
        <tr align="center" valign="middle"> 
<!--          <td height="28" colspan="2" class="BackGround"  >Demand</td> -->
         <td height="28" colspan="2" >DEMAND</td>
            </tr>
         <tr class="bolddeepblue">
           <td height="29" valign="middle" class="boldEleven">&nbsp;&nbsp;&nbsp;
             <div align="left">Location<font color='red'> *</font></div></td>
           <td><select name="office" id="office" style="width:200">
		   <option value="0">Select Location </option>
		   <%
		   
		 String OfficeData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_OFFICEID,CHR_OFFICENAME FROM com_m_office  ORDER BY CHR_OFFICENAME");
		 for(int c=0;c<OfficeData.length;c++)
			out.println("<option value='"+OfficeData[c][0]+"'>"+OfficeData[c][1]+"</option>");
	 
		   %>
		   
           </select>           </td>
         </tr>
         <tr class="bolddeepblue"> 
          <td width="150" height="29" valign="middle" class="boldEleven">&nbsp;&nbsp;&nbsp;
            <div align="left">Job Grade<font color='red'> *</font></div></td>
                <td width="246"><select name="jobgrade" class="formText135" id="jobgrade" onChange="LoadDemandJobTitle(this)"  style="width:200">
            	<option value="select">Select</option>            	
            	<option value="Top">Group-1</option>
            	<option value="Middle">Group-2</option>
            	<option value="Bottom">Group-3</option>
                </select></td>
        </tr>        
       
         <tr class="bolddeepblue"> 
          <td width="150" height="29" valign="middle" class="boldEleven">&nbsp;&nbsp;&nbsp;
            <div align="left">Job Title<font color='red'> *</font></div></td>
             	            <td><select name="jobTitle" id="jobTitle" class="formText135" style="width:200" > 
          <option value="0">Select  jobTitle</option>
           </select>		</td>
        </tr>       
         <tr class="bolddeepblue">
           <td height="29" valign="top" class="boldEleven">Demand Raised By <font color='red'> *</font></td>
           <td valign="top"><select name="demandraisedby" id="demandraisedby" class="formText135" style="width:200"  >
					<option value="0">Select</option>
					<%
  
 
						String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT a.CHR_EMPID,a.CHR_STAFFNAME FROM  com_m_staff a WHERE  a.CHR_TYPE !='T'  AND a.CHR_REP='Y' ORDER BY a.CHR_STAFFNAME" );
				
						for (int i=0; i<Data.length; i++)
							out.println("<option value= '" +Data[i][0]+ "'>" +Data[i][0]+" /  " +Data[i][1]+ "</option>"); 
%>
</select></td>
         </tr>
         <tr class="bolddeepblue">
           <td height="29" valign="top" class="boldEleven"> <div align="left">Description<font color='red'> *</font></div></td>
           <td valign="top"><textarea name="demandescription" cols="30" rows="5" class="formText135" id="demandescription" onKeyUp="textArea('demandescription','1900')"></textarea></td>
         </tr>
         <tr class="bolddeepblue">
           <td height="29" valign="middle" class="boldEleven">&nbsp;&nbsp;&nbsp;
             <div align="left">Demand<font color='red'> *
               <input type="hidden" name="filename" value="Demand">
                   <input name="actionS" type="hidden" id="actionS" value="HRMdemandAdd">
             </font></div></td>
           <td valign="top"><input name="demand"  id="demand" type="text" class="formText135"  onKeyPress="return numeric_only(event,'demand','5')" size=20 maxlength="3"  ></td>
         </tr>
         <tr class="bolddeepblue"> 
          <td colspan="2" valign="middle" class="bolddeepblue">&nbsp;
            <table align="center" cellpadding="3" cellspacing="3">
            <tr>
              <td width="56" align="center" valign="top"><input name="Submit" id="submit" type="submit"  class="tMLAscreenHead" value="Submit"   accesskey="s"    onClick="return valid();"></td>
              <td width="56" valign="top"><input class="tMLAscreenHead" type="button" name="Submit"  value="Close"   accesskey="c"  onClick="redirect('DemandEntryView.jsp')"></td>
            </tr>
          </table></td>
          </tr>
        </table>		</TD>
              <TD noWrap width=7><SPACER height="1" width="1" 
                        type="block" /></TD>
              <TD class=BorderLine width=1><SPACER height="1" width="1" type="block" /></TD>
            </TR>
            <TR>
              <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/BLCorner.gif" width=7></TD>
              <TD height=6><SPACER height="1" width="1" type="block"/></TD>
              <TD colSpan=2 rowSpan=2 valign="bottom"><div align="right"><IMG height=7 src="../Image/General/BRCorner.gif" width=7></div></TD>
            </TR>
            <TR>
              <TD class=BorderLine height=1><SPACER height="1" width="1" type="block" /></TD>
            </TR>
          </TBODY>
        </TABLE>	  </td>
  </tr>
  
  <tr>
    <td>&nbsp; </td>
  </tr>
  <tr>
     <td>&nbsp;</td>
  </tr>
<tr><td height="40">&nbsp;</td>
</tr>
<tr><td><%@ include file="../footer.jsp"%></td></tr>
</table>
</form>
</body>
</html>

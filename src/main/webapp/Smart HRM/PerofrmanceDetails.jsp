<%@ page import="java.io.*,java.util.*" %>


<%!
	String stateName,stateId;
	String districtName,districtDes,districtId;
	String actionStu;
%>
<%@page import="com.my.org.erp.ServiceLogin.DateUtil"%>
<html>
<head>

<title>:: HRM ::</title>


 
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/HRM/HrmAjax.js"></script>
<script language="JavaScript">
function valid()
  {
  	if(checkNullSelect("jobid","Select the Grade","select")
  	&& checkNull("TxtDemand","Enter the Demand value"))
	{
		if (document.frmDemandAction.TxtDemand.value>0)
		{
				return true;
		}
		else
		{
			alert("Demand value must be greater than 0");
			document.frmDemandAction.TxtDemand.focus();
			return false;
		}
	}
	else
		return false;	
	
  }  	
</script>
 <link href="../Styles/styles.css" rel="stylesheet" type="text/css">
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
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style></head>
<body  onpaste="return false;" onLoad="">
<form  AUTOCOMPLETE = "off" method="post" name='frmDemandAction' action="../SmartLoginAuth" >
<%@ include file="indexhrm.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>	</td>
  </tr>
  <tr>
    <td height="19">
    <% 
    	String id=""+request.getParameter("appId");
    	String sql="SELECT CHR_APPCODE,CHR_APPNAME,DT_APPLICATIONDATE,INT_JOBID";
    	sql=sql+" FROM hrm_m_application WHERE INT_APPID="+id;
    	String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    	
    	sql="SELECT CHR_JOBGRADE,CHR_JOBCODE,CHR_JOBTITLE FROM hrm_m_jobdesign";
    	sql=sql+" WHERE INT_JOBID="+data[0][3];
    	String data1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    	
    	sql="SELECT INT_TEST,INT_INTERVIEW,INT_MEDICAL,INT_REFERENCE,INT_GD ";
    	sql=sql+" FROM hrm_m_jobperformance WHERE INT_JOBID="+data[0][3];
    	String cutoff[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    	sql="SELECT INT_TEST,INT_INTERVIEW,INT_MEDICAL,INT_REFERENCE,INT_GD ";
    	sql=sql+" FROM hrm_t_jobperformance WHERE INT_APPID="+id;
    	String takenoff[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    %>    </td>
  </tr>
  

  <tr>
    <td>
	<TABLE width=690 border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#dce4f9" class=BackGround>
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
              <TD width=676 valign="top">
	<table width="800" border="0" class="BackGround"   align="center" cellpadding="2" cellspacing="2"  >
	        <!--DWLayoutTable-->
        <tr align="center" valign="middle"> 
<!--          <td height="28" colspan="2" class="BackGround"  >Demand</td> -->
         <td height="28" colspan="4" class="tablehead1" > Performance Detailed View</td>
            </tr>
                 
         <tr class="bolddeepblue">
           <td width="110" height="34" valign="middle" class="bold1">Application Code  </td>
           <td width="180" valign="middle" class="bolddeepblue"><strong>:</strong>&nbsp;<strong><font color="#3300FF"><%= data[0][0] %></font></strong></td>
           <td width="105" valign="middle" class="bold1">Applicant Name  </td>
           <td width="206" height="34" valign="middle" class="bolddeepblue"><span class="bold1">:</span>&nbsp;<strong><font color="#3300FF"><%= data[0][1] %></font></strong></td>
         </tr>
         <tr class="bolddeepblue">
           <td height="32" valign="middle" class="bold1">Grade </td>
           <td valign="middle" class="bolddeepblue"><strong>:</strong>&nbsp;<%= data1[0][0] %> Management</td>
           <td valign="middle" class="bold1">Job Code  </td>
           <td height="32" valign="middle" class="bolddeepblue"><span class="bold1">:</span>&nbsp;<%= data1[0][1] %></td>
         </tr>
         <tr class="bolddeepblue">
           <td height="31" valign="middle" class="bold1">Job Applied </td>
           <td valign="middle" class="bolddeepblue"><strong>:</strong>&nbsp;<strong><font color="#3300FF"><%= data1[0][2] %></font></strong></td>
           <td valign="middle" class="bold1">Applied On  </td>
           <td height="31" valign="middle" class="bolddeepblue"><span class="bold1">:</span>&nbsp;<%= DateUtil.FormateDateSys(data[0][2]) %></td>         </tr>
         <tr class="bolddeepblue">
           <td height="44" colspan="4" valign="middle" class="bolddeepblue"><table width="631" height="197" border="1" align="center" cellpadding="1" cellspacing="1" bordercolor="#0066FF">
             <tr>
               <td width="118" class="bold1"><div align="center">S.No</div></td>
               <td width="118" height="31" class="bold1"><div align="center">Test Name </div></td>
               <td width="162" class="bold1"><div align="center">Requried Cut Off </div></td>
               <td width="210" class="bold1"><div align="center">Marks Obtained </div></td>
             </tr>
             <tr>
               <td class="bold1">1.</td>
               <td height="34" class="bold1">Test</td>
               <td class="boldEleven">&nbsp;
                 <div align="center"><%= cutoff[0][0] %></div></td>
               <td class="boldEleven">&nbsp;
                 <div align="center"><%= takenoff[0][0] %></div></td>
             </tr>
             <tr>
               <td class="bold1">2.</td>
               <td height="31" class="bold1">Interview</td>
               <td class="boldEleven">&nbsp;
                 <div align="center"><%= cutoff[0][1] %></div></td>
               <td class="boldEleven">&nbsp;
                 <div align="center"><%= takenoff[0][1] %></div></td>
             </tr>
             <tr>
               <td class="bold1">3.</td>
               <td height="32" class="bold1">Medical</td>
               <td class="boldEleven">&nbsp;
                 <div align="center"><%= cutoff[0][2] %></div></td>
               <td class="boldEleven">&nbsp;
                 <div align="center"><%= takenoff[0][2] %></div></td>
             </tr>
             <tr>
               <td class="bold1">4.</td>
               <td height="31" class="bold1">Reference</td>
               <td class="boldEleven">&nbsp;
                 <div align="center"><%= cutoff[0][3] %></div></td>
               <td class="boldEleven">&nbsp;
                 <div align="center"><%= takenoff[0][3] %></div></td>
             </tr>
             <tr>
               <td class="bold1">5.</td>
               <td class="bold1">G.D</td>
               <td class="boldEleven">&nbsp;
                 <div align="center"><%= cutoff[0][4] %></div></td>
               <td class="boldEleven">&nbsp;
                 <div align="center"><%= takenoff[0][4] %></div></td>
             </tr>
             <tr>
               <td class="bold1">&nbsp;</td>
               <td class="bold1">Total</td>
               <td class="boldEleven">&nbsp;
                 <div align="center">
                   <% int total=0;
               total=Integer.parseInt(cutoff[0][0])+Integer.parseInt(cutoff[0][1])+Integer.parseInt(cutoff[0][2])+Integer.parseInt(cutoff[0][3])+Integer.parseInt(cutoff[0][4]); 
               out.println(total);%>
                 </div></td>
               <td class="boldEleven">&nbsp;<div align="center"><% int ttotal=0;
               ttotal=Integer.parseInt(takenoff[0][0])+Integer.parseInt(takenoff[0][1])+Integer.parseInt(takenoff[0][2])+Integer.parseInt(takenoff[0][3])+Integer.parseInt(takenoff[0][4]); 
               out.println(ttotal);%></div></td>
             </tr>
           </table></td>
         </tr>
         <tr class="bolddeepblue"> 
          <td height="44" colspan="4" valign="middle" class="bolddeepblue">  
		  <table align="center" cellpadding="3" cellspacing="3">
            <tr>
              <td width="56" valign="top"><input class="tMLAscreenHead" type="button" name="Submit"  value="Close"   accesskey="c"  onClick="redirect('Performance.jsp')"></td>
            </tr>
          </table></td>
          </tr>
        </table>		</TD>
              <TD noWrap width=6><SPACER height="1" width="1" 
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
  <tr><td>&nbsp; </td></tr>
<tr><td>&nbsp; </td></tr>
<tr><td>&nbsp; </td></tr>
<tr><td>&nbsp; </td></tr>

<tr><td><%@ include file="../footer.jsp"%></td></tr>
</table>
</form>
</body>
</html>

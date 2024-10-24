<%@ page import="java.io.*,java.util.*" %>
 


<html>
<head>
 

<title>:: HRM ::</title>

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
.style16 {color: #666666;
	font-size: 24px;
}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/HRM/loadJobtitle.js"></script>
<script language="javascript">
 
 function validate()
  {
  
  	if(
	checkNullSelect("office","Select the Location","0")
	&& checkNullSelect("jobgrade","Select the Grade","select")
	&& checkNullSelect("jobTitle","Select the jobTitle","0")
	&& checkNullSelect("demandraisedby","Select the demand raised by","0")
	&& checkNull("demandescription","Enter the Demand Description")
  	&& checkNull("demand","Enter the Demand value"))
	{
		if (document.frm.demand.value>0)
		{
				return true;
		}
		else
		{
			alert("Demand value must be greater than 0");
			document.frm.demand.focus();
			return false;
		}
	}
	else
		return false;	
  }
      

  </script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste='return false;'>
<form  AUTOCOMPLETE = "off" name="frm" method="get" action="../SmartLoginAuth" >
<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
  
<tr>
    <td>
    <%@ include file="indexhrm.jsp"%>    </td>
  </tr>
  <tr>
    <td height="70">&nbsp;</td>
  </tr>
  <tr>
    <td height="70"><TABLE width=440 border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#dce4f9" class=BackGround>
      <TBODY>
        <TR>
          <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/TLCorner.gif" width=7></TD>
          <TD class=BorderLine height=1><SPACER height="1" width="1" type="block" /></TD>
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
          <TD width=425 valign="top"><table width="425" border="0" class="BackGround"   align="center" cellpadding="2" cellspacing="2"  >
              <!--DWLayoutTable-->
              <tr align="center" valign="middle">
                <!--          <td height="28" colspan="2" class="BackGround"  >Demand</td> -->
                <td height="28" colspan="2" >Demand    
				 <%  
  
  String rowid=request.getParameter("rowid");
  String sql="SELECT INT_JOBDEMANDID,CHR_JOBGRADE,INT_JOBID,INT_OFFICEID,trim(INT_DEMAND),DAT_REGISTERDATE,CHR_DEMANDRAISEDBY,CHR_DEMANDDESC  FROM hrm_m_jobdemand  WHERE INT_JOBDEMANDID="+rowid ; 
  String job[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    
  
 %>           </td>
              </tr>
              <tr class="bolddeepblue">
                <td height="29" valign="top" class="boldEleven"><div align="left">Location<font color='red'> *</font></div></td>
                <td><select name="office" id="office" style="width:200">
                    <option value="0">Select Location </option>
                     
                 <%
		   
		 String OfficeData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_OFFICEID,CHR_OFFICENAME FROM com_m_office  ORDER BY CHR_OFFICENAME");
		 for(int c=0;c<OfficeData.length;c++)
			out.println("<option value='"+OfficeData[c][0]+"'>"+OfficeData[c][1]+"</option>");
	 
		   %>
                  </select>
				  <script language="javascript">setOptionValue('office','<%=job[0][3]%>')</script>                </td>
              </tr>
              <tr class="bolddeepblue">
                <td width="150" height="29" valign="top" class="bolddeepblue"><div align="left">Job Grade<font color='red'> *</font></div></td>
                <td width="246"><select name="jobgrade" class="formText135" id="jobgrade" onChange="LoadDemandJobTitle(this)" style="width:200">
                    <option value="select">Select</option>
                    <option value="Top" >Group-1</option>
                    <option value="Middle" >Group-2</option>
                    <option value="Bottom"  >Group-3</option>
                  </select><script language="javascript">setOptionValue('jobgrade','<%=job[0][1].trim()%>')</script>              </tr>
              <tr class="bolddeepblue">
                <td width="150" height="29" valign="top" class="bolddeepblue"><div align="left">Job Title<font color='red'> *</font></div></td>
                <td><select name="jobTitle" id="jobTitle" class="formText135"  style="width:200">
                    <option value="0">Select  jobTitle</option>
                    <%
          String sql1="select INT_JOBID,CHR_JOBCODE,CHR_JOBTITLE from hrm_m_jobdesign where CHR_JOBGRADE='"+job[0][1].trim()+"' ";
            String query1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql1);           
            for(int j=0;j<query1.length;j++)
            	out.println("<option value='"+query1[j][0]+"'  >"+query1[j][1]+"/"+query1[j][2]+"</option>");                    
 
                 	
           %> 
                  </select> <script language="javascript">setOptionValue('jobTitle','<%=job[0][2].trim()%>')</script>                </td>
              </tr>
              <tr class="bolddeepblue">
                <td height="29" valign="top" class="boldEleven">Demand Raised By <font color='red'> *</font></td>
                <td valign="top">
				<select name="demandraisedby" id="demandraisedby" class="formText135"   style="width:200">
                    <option value="0">Select</option>
                    <%
  
 
						String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT a.CHR_EMPID,a.CHR_STAFFNAME FROM  com_m_staff a WHERE  a.CHR_TYPE !='T'  AND a.CHR_REP='Y' ORDER BY a.CHR_STAFFNAME" );
				
						for (int i=0; i<Data.length; i++)
							out.println("<option value= '" +Data[i][0]+ "'>" +Data[i][0]+" /  " +Data[i][1]+ "</option>"); 
%>
                </select>
				<script language="javascript">setOptionValue('demandraisedby','<%=job[0][6].trim()%>')</script>  
				</td>
              </tr>
              <tr class="bolddeepblue">
                <td height="29" valign="top" class="boldEleven"><div align="left">Description <font color='red'> *</font></div></td>
                <td valign="top"><textarea name="demandescription" cols="30" rows="5" class="formText135" id="demandescription" onKeyUp="textArea('demandescription','1900')"><%=job[0][7].trim()%> </textarea></td>
              </tr>
              <tr class="bolddeepblue">
                <td height="29" valign="top" class="bolddeepblue"><div align="left">Demand<font color='red'> *</font></div></td>
                <td valign="top"><input name="demand" type="text" class="formText135" id="demand"   onKeyPress="return numeric_only(event,'demand','4')"  value="<%=job[0][4].trim()%>" size=20 maxlength="3"  >
                    <input name="filename" type="HIDDEN" id="filename" value="Demand">
                    <input name="actionS" type="hidden" id="actionS" value="HRMdemandEdit">
                    <input name="rowid" type="hidden" id="rowid" value="<%=job[0][0].trim()%> "></td>
              </tr>
               
              <tr class="bolddeepblue">
                <td colspan="2" valign="middle" class="bolddeepblue">&nbsp;
                    <table align="center" cellpadding="3" cellspacing="3">
                      <tr>
                        <td width="56" align="center" valign="top"><input name="Submit2" id="submit" type="submit"  class="tMLAscreenHead" value="Update" onClick="return validate()"></td>
                        <td width="56" valign="top"><input class="tMLAscreenHead" type="button" name="Submit2"  value="Close"   accesskey="c"  onClick="redirect('DemandEntryView.jsp')"></td>
                      </tr>
                  </table></td>
              </tr>
          </table></TD>
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
    </TABLE></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
            <td nowrap="nowrap" width="4"><spacer height="1" width="1" 
                        type="block" /></td>
            <td class="BorderLine" width="1"><spacer height="1" 
                        width="1" type="block" /></td>
    </tr>
</table>              
</form>
<br><br>
<%@ include file="../footer.jsp"%>
</body>
</html>
 
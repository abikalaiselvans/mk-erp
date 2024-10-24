<%@ page import="com.my.org.erp.common.CommonFunctions" %>
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
 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
 <script language="javascript">
 function validateFields()
 {
 
 	if(
			checkNullSelect('appNo', 'Select Applicant ', '0')
			&& checkNullSelect('category','Select category','0')
			&& checkNullSelect('desigination','Select Position / Desigination','0')
			&& checkNullSelect('office','Select office','0')
			&& checkNullSelect('authority','Select Authority Name','0')
			&& checkNull('fsalary','Fixing Salary')
			&& checkNullSelect('noticeperiod','Select noticeperiod','0')
			
			
		)
		
			return true;
		else
			return false;
 }
 </script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<body  onpaste="return false;"   >
<form  AUTOCOMPLETE = "off" method="get" name="frm" action ="../SmartLoginAuth" onSubmit="return validateFields()">
<%@ include file="indexhrm.jsp"%>	
<table width="100%" align="center">
  <tr>
    <td>
	
	 
	</td>
  </tr>

  <!--DWLayoutTable-->
  <tr>
    <td height="21" colspan="6" align="center">  
  <tr>
    <td height="21" colspan="6" align="center"><TABLE width=440 border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#dce4f9" class=BackGround>
      <TBODY>
        <TR>
          <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/TLCorner.gif" width=7></TD>
          <TD class=BorderLine height=1><SPACER height="1" width="1" type="block" /></TD>
          <TD colSpan=2 rowSpan=2><IMG height=7 src="../Image/General/TRCorner.gif" width=7></TD>
        </TR>
        <TR>
          <TD height=6>&nbsp;</TD>
        </TR>
        <TR>
          <TD class=BorderLine width=1><SPACER height="1" 
                        width="1" type="block" /></TD>
          <TD width=6><SPACER height="1" width="1" type="block" 
                      /></TD>
          <TD width=425 valign="top"><table width="723" border="0" align="center" cellpadding="1" cellspacing="1">
            <tr>
              <td height="35" colspan="4" align="left" class="boldEleven"><spacer height="1" width="1" type="block"/>
                  <div align="center"><span class="tablehead"><span class="style3">OFFER LETTER </span></span></div></td>
            </tr>
            <tr>
              <td height="35" colspan="4" align="left" class="boldEleven"><table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                    <td class="bold1"><span class="style3">Application Number <span class="boldred">*</span></span></td>
                    <td class="bold1"><span class="style3">
                      <select name="appNo" class="formText135" id="appNo" tabindex="1" onChange="loadOfferLetter(this)" onBlur="loadOfferLetter(this)"   style="width:175">
                        <option value="0">Select</option>
                        <%
						String sql = " ";
						
						 //sql ="  SELECT b.INT_APPID, b.CHR_APPCODE,b.CHR_APPNAME  FROM hrm_t_interview a , hrm_m_application b,hrm_m_jobdesign c      WHERE a.INT_APPLICANTID  = b.INT_APPID     AND b.INT_JOBID=c.INT_JOBID  AND b.CHR_OFFERORDERSTATUS!='Y' AND a.CHR_ALLOWSECONDINTERVIEW='Y'    AND a.CHR_CANDIDATESTATUS='S'     AND a.CHR_FINALSTATUS='Y'  ";
  
  
  
  /*SELECT a.INT_APPID, a.CHR_APPCODE,a.CHR_APPNAME ,a.INT_ONLINETEST  
FROM hrm_m_application a    
LEFT JOIN hrm_t_interview c ON (a.INT_APPID = c.INT_APPLICANTID)
JOIN  hrm_m_jobdesign b   
WHERE a.INT_JOBID=b.INT_JOBID  
AND ( ( a.CHR_OFFERORDERSTATUS!='Y' AND c.CHR_ALLOWSECONDINTERVIEW='Y' AND c.CHR_CANDIDATESTATUS='S' AND c.CHR_FINALSTATUS='Y')    
      OR (a.INT_ONLINETEST=0 )    
  )  
GROUP BY a.INT_APPID
ORDER BY a.CHR_APPCODE
*/

sql = " SELECT a.INT_APPID, a.CHR_APPCODE,a.CHR_APPNAME ,a.INT_ONLINETEST  ";
sql = sql+ " FROM hrm_m_application a,hrm_m_jobdesign b ,hrm_t_interview c   ";
sql = sql+ " WHERE a.INT_JOBID=b.INT_JOBID   ";   
sql = sql+ " AND   "; 
sql = sql+ " (   "; 
sql = sql+ " ( a.INT_APPID = c.INT_APPLICANTID AND a.CHR_OFFERORDERSTATUS!='Y' AND c.CHR_ALLOWSECONDINTERVIEW='Y'  ";
sql = sql+ " AND c.CHR_CANDIDATESTATUS='S' AND c.CHR_FINALSTATUS='Y'  ";
sql = sql+ " )   ";
sql = sql+ " OR (a.INT_ONLINETEST=0 )   ";
sql = sql+ " )  ";
sql = sql+ " GROUP BY a.INT_APPID  ";

 
 
 
  
						
						String AppData[][] =  CommonFunctions.QueryExecute(sql);
						if(AppData.length>0)
						for (int i=0; i<AppData.length; i++)
							if("1".equals(AppData[i][3]))
								out.println("<option style='background-color:#B6E9D3' value= '" +AppData[i][0]+ "'>" +AppData[i][1]+" /  " +AppData[i][2]+ " /  ONLINE TEST"+"</option>");
							else
								out.println("<option  style='background-color:#ffffff' value= '" +AppData[i][0]+ "'>" +AppData[i][1]+" /  " +AppData[i][2]+ " /  DIRECT"+"</option>");
					
					 %>
                      </select>
                    </span></td>
                  </tr>
              </table></td>
            </tr>
            <tr>
              <td height="35" colspan="4" align="left" class="boldEleven"><div id="ResultTable"></div></td>
            </tr>
            <tr>
              <td height="35" align="left" class="boldEleven">Category <span class="boldred">*</span> </td>
              <td><select name="category" class="formText135" id="category" style="width:175">
                  <option value="0">Select</option>
                  <%
	String empcategorysql=" SELECT INT_EMPLOYEECATEGORYID,CHR_CATEGORYNAME  FROM   com_m_employeecategory   ORDER BY CHR_CATEGORYNAME ";
	String empcategoryData[][]= CommonFunctions.QueryExecute(empcategorysql);
	if (empcategoryData.length>0)
		for (int i=0; i<empcategoryData.length; i++) 
			out.println("<option value="+empcategoryData[i][0]+">"+empcategoryData[i][1] +"</option>");			
	
						%>
                </select>
              </td>
              <td height="27" align="left" class="boldEleven">Position / Designation <span class="boldred">*</span> </td>
              <td><select name="desigination" class="formText135" id="desigination" style="width:175">
                  <option value="0">Select</option>
                  <%
         		String desgdata[][]= CommonFunctions.QueryExecute("SELECT INT_DESIGID,CHR_DESIGNAME FROM  com_m_desig  ORDER BY CHR_DESIGNAME");
			for(int h=0;h<desgdata.length;h++)
				out.print("<option value='"+desgdata[h][0]+"'>"+desgdata[h][1]+"</option>");
%>
              </select></td>
            </tr>
            <tr>
              <td height="35" align="left" class="boldEleven">Office <span class="boldred">*</span> </td>
              <td><select name="office" class="formText135" id="office" style="width:175">
                  <option value="0">Select office</option>
                  <%
			String offdata[][]= CommonFunctions.QueryExecute("SELECT INT_OFFICEID,CHR_OFFICENAME FROM   com_m_office   ORDER BY CHR_OFFICENAME");
			for(int h=0;h<offdata.length;h++)
			out.print("<option value='"+offdata[h][0]+"'>"+offdata[h][1]+"</option>");
			
			
			%>
                </select>
              </td>
              <td height="27" align="left" class="boldEleven">Status</td>
              <td><input name="ChkStatus" type="checkbox" id="ChkStatus" tabindex="4" value="Y" checked>
                  <span class="boldEleven">Issued</span></td>
            </tr>
            <tr>
              <td width="145" height="35" align="left" class="boldEleven">PF</td>
              <td width="200"><table width="80" border="0" cellspacing="0"
																cellpadding="0">
                  <tr>
                    <td width="20">                      <input
																		name="pf" type="radio" class="formText135" value="C"
																		checked  />                    </td>
                    <td width="20"><span class="boldEleven">Yes</span></td>
                    <td width="24">                      <input
																		name="pf" type="radio" class="formText135" value="N"/>                    </td>
                    <td width="16"><span class="boldEleven">No</span></td>
                  </tr>
              </table></td>
              <td width="123" height="27" align="left" class="boldEleven">ESI</td>
              <td width="242"><table width="67" border="0" cellspacing="0"
																cellpadding="0">
                  <tr>
                    <td width="20">                      <input
																		name="ESI" id="ESI" type="radio" class="formText135"
																		value="C" checked />                    </td>
                    <td width="20"><span class="boldEleven">Yes</span></td>
                    <td width="20">                      <input
																		name="ESI" type="radio" class="formText135" value="N"
																		 />                    </td>
                    <td width="7"><span class="boldEleven">No</span></td>
                  </tr>
              </table></td>
            </tr>
            <tr>
              <td height="35" align="left" class="boldEleven"><span class="boldornge">Fixing Salary in gross</span> <span class="boldred">*</span> </td>
              <td height="27"><input name="fsalary" type="text" class="formText135" id="fsalary" size="30" maxlength="12"  onKeyPress="return numeric_only(event,'fsalary','12')" ></td>
              <td height="27"><span class="boldEleven">Authority Name <span class="boldred">*</span> </span></td>
              <td height="27"><select name="authority" class="formText135" id="authority"  style="width:175" >
                  <option value="0">Select Authority </option>
                  <%					

						sql = "SELECT a.CHR_EMPID,a.CHR_STAFFNAME FROM  com_m_staff a WHERE  a.CHR_TYPE !='T'  AND a.CHR_INTERVIEW='Y' ORDER BY a.CHR_STAFFNAME ";
						String Data[][] =  CommonFunctions.QueryExecute(sql);
				
						for (int i=0; i<Data.length; i++)
							out.println("<option value= '" +Data[i][0]+ "'>" +Data[i][0]+" /  " +Data[i][1]+ "</option>");
					
					 %>
              </select></td>
            </tr>
            <tr>
              <td height="35" align="left" class="boldEleven">Notice Period <span class="boldred">*</span></td>
              <td height="27"><span class="boldEleven">
                <select name="noticeperiod" size="1" class="formText135" id="noticeperiod"  style="width:175"  >
                  <option value="0"  >Select Notice period</option>
                  <%
										for(int c=1;c<100;c++)
											out.println("<option value='"+c+"'>"+c+" - days </option>");
										
									%>
                </select>
				 
              </span></td>
              <td height="27">&nbsp;</td>
              <td height="27">&nbsp;</td>
            </tr>
            <tr>
              <td height="20" colspan="6">          
            <tr>
              <td height="20" colspan="6"><table  border="0" align="center" cellpadding="2" cellspacing="2">
                  <tr>
                    <td  width="56"><input name="Save" type="submit" class="tMLAscreenHead" id="Save" value="Send Offer Letter"   tabindex="5"></td>
                    <td  width="56"><input class="tMLAscreenHead" type="button" name="Button"  value="Close"   accesskey="c"  onClick="redirect('OfferLetterView.jsp')" tabindex="7"></td>
                    <td  width="56"><input name="filename" type="hidden" id="filename" value="OfferLetter">
                        <input name="actionS" type="hidden" id="actionS" value="HRMOfferLetterAdd"></td>
                  </tr>
                </table>
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
    </TABLE>  
  <tr>
    <td height="80" colspan="6" align="center">    
         
      </td>
  </tr></table>
  
  <%@ include file="../footer.jsp"%>
</form>

<script language="javascript" src="../JavaScript/HRM/OfferLetter.js"></script>
</body>
</html>
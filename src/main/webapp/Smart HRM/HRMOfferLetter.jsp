 <%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
 
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

<%
try
{
%>
 
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body  onpaste='return false;'>
   <table width="80%" border="0" align="center" cellpadding="2"
	cellspacing="2">
	<tr>
		<td><%
String applicantid=""+request.getParameter("applicantid");
String pf ="";
String esi ="";
String sql=" ";
sql = "  SELECT g.INT_OFFERID,b.INT_APPID,b.CHR_APPCODE,b.CHR_APPNAME,b.CHR_APPFATHER,b.CHR_GENDER, 	 ";	  
sql = sql +"  DATE_FORMAT(b.DT_DOB,'%d-%m-%Y'),b.CHR_EMAILID,b.CHR_MOBILE, b.CHR_PADD1,b.CHR_PADD2,f.CHR_CITYNAME,	 ";	  
sql = sql +"  e.CHR_DISTRICT,d.CHR_STATENAME, c.CHR_COUNTRYNAME,b.INT_PPIN, a.CHR_JOBGRADE,a.CHR_JOBCODE,a.CHR_JOBTITLE ,	 ";	  
sql = sql +"  g.DT_OFFERDATE, DATE_FORMAT(g.DT_OFFERDATE,'%d-%m-%Y'),CHR_PF,CHR_ESI ,	 ";	  
sql = sql +"  h.CHR_CATEGORYNAME ,i.CHR_DESIGNAME,j.CHR_OFFICENAME,g.INT_NOTICEPERIOD	 ";	  
sql = sql +"  FROM hrm_m_jobdesign a, hrm_m_application b , com_m_country c, com_m_state d,com_m_district e,	 ";	  
sql = sql +"  com_m_city f ,hrm_t_offerletter g ,com_m_employeecategory h,com_m_desig i,com_m_office j	 ";	  
sql = sql +"  WHERE a.INT_JOBID=b.INT_JOBID 	 ";	  
sql = sql +"  AND b.INT_APPID= g.INT_APPID	 ";	  
sql = sql +"  AND b.INT_PCOUNTRYID=c.INT_COUNTRYID 	 ";	  
sql = sql +"  AND b.INT_PSTATE=d.INT_STATEID 	 ";	  
sql = sql +"  AND b.INT_PDISTRICTID=e.INT_DISTRICTID	 ";	   
sql = sql +"  AND b.INT_PCITY=f.INT_CITYID 	 ";	  
sql = sql +"  AND g.INT_CATEGORY=h.INT_EMPLOYEECATEGORYID 	 ";	  
sql = sql +"  AND g.INT_DESIGID=i.INT_DESIGID	 ";	  
sql = sql +"  AND g.INT_OFFICEID=j.INT_OFFICEID	 ";	  
sql = sql +"  AND b.INT_APPID="+applicantid;

String rowdata[][]   =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);				
String appointed=DateUtil.FormateDateSys(rowdata[0][19]);
String app=com.my.org.erp.common.CommonFunctions.Appointmentyear(appointed);
String id[]=app.split("~");				
pf =rowdata[0][21];
esi =rowdata[0][22];	


String institutionData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  INT_PFAMT,INT_ESIAMT,INT_ESILIMIT,INT_PFLIMIT,INT_PFLIMITMINIMUM ,INT_CPY_ESIAMT FROM m_institution WHERE INT_ID=1");
double pfpercentage = Double.parseDouble( institutionData[0][0]);
double esipercentage = Double.parseDouble( institutionData[0][1]);
double esilimitamount = Double.parseDouble( institutionData[0][2]);
double pfmaximumlimit = Double.parseDouble( institutionData[0][3]);
double pfminimumlimit = Double.parseDouble( institutionData[0][4]);
double esicomapnypercentage = Double.parseDouble( institutionData[0][5]);

	
			%></td>
	</tr>

	 
	<tr>
		<td  >
		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          
          <tr>
            <td width="100%" height="20" colspan="2"><div align="center"><span class="boldgre">OFFER LETTER </span></div></td>
          </tr>
          <tr>
            <td colspan="2"><div align="right"></div></td>
          </tr>
          <tr>
            <td colspan="2"></td>
          </tr>
          <tr>
            <td colspan="2"></td>
          </tr>
          <tr>
            <td height="19" colspan="2"><table width="100%" border="0" cellspacing="1" cellpadding="1">
                <tr>
                  <th width="720" height="21" class="boldEleven"  >
                    <div align="left" ><b>Mythra/OFFER-<%=rowdata[0][0]%>/<%=rowdata[0][23]%>/ <%= id[0] %><b><br/>
                  <%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DATE_FORMAT(NOW(),'%d-%m-%Y')")[0][0]%>                    </div></th>
                </tr>
                <tr>
                  <th scope="col">&nbsp;</th>
                </tr>
                <tr>
                  <th scope="col"><div align="left"> <b>To </b>
                    <br/>
                    Mr/Ms. <%= rowdata[0][3] %>,<br/>
                    <%= rowdata[0][25] %>,<br/>
				    
                    <%//= rowdata[0][9] %>
					  <%//= rowdata[0][10] %>
					  <%//= rowdata[0][11] %>
					  <%//= rowdata[0][12] %>
					  <%//= rowdata[0][13] %>
					  <%//= rowdata[0][14] %>
					  <%//= rowdata[0][15] %>
                    </span></div></th>
                </tr>
                 
                <tr>
                  <th height="85" scope="col"><div align="left" class="boldEleven"> Dear.
                     
                    Mr/Ms. <%= rowdata[0][3] %>,                   <br/>
  &nbsp;&nbsp;&nbsp;&nbsp; We are pleased to offer the post of &nbsp; <b><%= "\""+rowdata[0][24] +"\""%></b>&nbsp;in our organisation at &nbsp; <b> <%= "\""+rowdata[0][25] +"\""%></b>.&nbsp; You are expected to join us on  or before&nbsp;<b><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DATE_FORMAT(DATE_ADD(now(), INTERVAL "+rowdata[0][26]+" DAY),'%d-%b-%Y')")[0][0]%></b>&nbsp;  failing which this offer is not valid. Your salary details are as mentioned below.</div></th>
                </tr>
                 
            </table></td>
          </tr>
        </table>		 </td>
	</tr>
	 
	<tr>
	  <td   class="boldEleven">
	  
	  
	  <%
out.println("<table width='100%' border='1' align='center' cellpadding='0' cellspacing='0' bordercolor='#000000'>");
out.println("<tr>");
out.println("<td>");




out.println("<TABLE  width='100%'  border='0' align='center' cellPadding='2' cellSpacing='2'>"); 
				out.println(" <TBODY>"); 
				out.println("<TR>"); 
				out.println("<TD   colSpan='7' align='center'><h4>Annexure</h4></TD>"); 
				out.println("</TR>"); 
				
				out.println("<TR bgcolor='#666666'   >"); 
				out.println("<TD   colSpan='2'><p><strong>Particulars</strong></p></TD>"); 
				out.println("<TD   ><p><strong>&nbsp;</strong></p></TD>"); 
				out.println(" <TD   ><p><strong>Amount</strong><strong>(P   M)</strong></p>                    </TD>"); 
				out.println("<TD   <p><strong>&nbsp;</strong></p></TD>"); 
				out.println("<TD   ><p><strong>Amount   (PA)</strong></p></TD>"); 
				out.println("<TD   ><p><strong>&nbsp;</strong></p></TD>"); 
				out.println("</TR>"); 
				
			  
				
				String AllowanceData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME  FROM pay_m_allowance WHERE CHR_FLAG='Y' ORDER BY INT_ALLOWANCEID");
				String salaryband="   ";
				String grossband="";
				for(int u=0; u<AllowanceData.length;u++)
				{
					salaryband = salaryband+"  a."+AllowanceData[u][0]+",( a."+AllowanceData[u][0]+" *12) ,"; 
					grossband = grossband+"  a."+AllowanceData[u][0]+"+";
				}	
				salaryband=salaryband.trim();
				salaryband = salaryband.substring(0,salaryband.length()-1);		
				
				grossband=grossband.trim();
				grossband = grossband.substring(0,grossband.length()-1);		
				
				sql = " SELECT ROUND(a.INT_BASIC),ROUND(INT_BASIC*12),"+salaryband+" ,ROUND(a.INT_BASIC+("+grossband+")),ROUND( (a.INT_BASIC+("+grossband+"))*12 ),ROUND(a.INT_BASIC*12/100) ,ROUND((a.INT_BASIC*12/100)*12),ROUND( (a.INT_BASIC+("+grossband+"))  + (a.INT_BASIC*12/100) ) , ROUND(( (a.INT_BASIC+("+grossband+"))  + (a.INT_BASIC*12/100) )*12),ROUND( (a.INT_BASIC+("+grossband+")) - (a.INT_BASIC*12/100) )  FROM hrm_m_application b,hrm_t_allowance a ";
				sql = sql +" 	WHERE a.INT_APPID = b.INT_APPID AND a.INT_APPID= "+applicantid+"  ";
				//out.println(sql);
				String payData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				double monthbasic=0;
				double monthgross=0;
				double monthpf=0;
				double monthesi=0;
				double monthctc=0;
				
				double staffpf=0;
				double staffesi=0;
				double takehome=0;
				
				if(payData.length>0)
				{
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom'   colSpan='2'  class='boldEleven' ><p>Basic</p></TD>");
					 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
					 out.println("<TD vAlign='bottom'    align='right' class='boldEleven' ><p>"+payData[0][0]+"</p></TD>");
					 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
					 out.println("<TD vAlign='bottom'   align='right' class='boldEleven' ><p>"+payData[0][1]+"</p></TD>");
					 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
					 out.println("</TR>");
					 int g=1;
					 int v=1;
					 for(int u=0; u<AllowanceData.length;u++)
					 {
						 
						  g = g+2;
						 out.println("<TR bgcolor='CCCCCC'>");
						 out.println("<TD vAlign='bottom'  colSpan='2' class='boldEleven' ><p> "+AllowanceData[u][1]+"</p></TD>");
						 out.println("<TD vAlign='bottom'   class='boldEleven' >&nbsp;</TD>");
						  v=v+1;
						 out.println("<TD vAlign='bottom'    align='right' class='boldEleven' ><p> "+payData[0][v]+"</p></TD>");
						 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
						  v=v+1;
						 out.println("<TD vAlign='bottom'   align='right' class='boldEleven' ><p> "+payData[0][v]+"</p></TD>");
						 out.println("<TD vAlign='bottom'   class='boldEleven' >&nbsp;</TD>");
						 out.println("</TR>");
						
						 
						
					 }
					monthbasic=Double.parseDouble(payData[0][0]);
					monthgross=Double.parseDouble(payData[0][(g+1)]);
					
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom'    colSpan='2' class='boldEleven' ><p>GROSS</p></TD>");
					 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
					 out.println("<TD vAlign='bottom'    align='right' class='boldEleven' ><p>"+Math.round(monthgross)+"</p></TD>");
					 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
					 out.println("<TD vAlign='bottom'    align='right' class='boldEleven' ><p>"+Math.round(monthgross*12)+"</p></TD>");
					 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
					 out.println("</TR>"); 
					  
					 if("C".equals(pf))
					 {
						 
						if(monthbasic <= pfminimumlimit)
						{
							monthpf = (pfminimumlimit*pfpercentage/100); 
							staffpf = (pfminimumlimit*pfpercentage/100); 
							 
						}
						else if( (monthbasic>pfminimumlimit)  && (monthbasic <=pfmaximumlimit))	
						{
							monthpf = (monthbasic*pfpercentage/100); 
							staffpf = (monthbasic*pfpercentage/100); 
							 
						}
						else
						{
							monthpf = (pfmaximumlimit*pfpercentage/100);
							staffpf = (pfmaximumlimit*pfpercentage/100);
							 
						}	
				
					}
					else
					{
						monthpf = 0;
						staffpf = 0;
					}
						 out.println("<TR bgcolor='CCCCCC'>");
						 out.println("<TD vAlign='bottom'    colSpan='2' class='boldEleven' ><p>EMPLOYEER PF</p></TD>");
						 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
						 out.println("<TD vAlign='bottom'    align='right' class='boldEleven' ><p>"+Math.round(monthpf)  +"</p></TD>");
						 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
						 out.println("<TD vAlign='bottom'   align='right' class='boldEleven' ><p>"+Math.round(monthpf*12)+"</p></TD>");
						 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
						 out.println("</TR>"); 	 
						  
						  
					 	  
					 if( "C".equals(esi)  && ( monthgross <= esilimitamount))
					 {
					 		monthesi=(monthgross*esicomapnypercentage/100);
							staffesi=(monthgross*esipercentage/100);
							
					 }
					 else
					 {
							monthesi=0;
						 	staffesi=0;
					  }
					  
					  
					  
					  
			 
			  			 out.println("<TR bgcolor='CCCCCC'>");
						 out.println("<TD vAlign='bottom'   colSpan='2' class='boldEleven' ><p>EMPLOYEER ESI</p></TD>");
						 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
						 out.println("<TD vAlign='bottom'    align='right' class='boldEleven' ><p>"+Math.round(monthesi)+"</p></TD>");
						 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
						 out.println("<TD vAlign='bottom'    align='right' class='boldEleven' ><p>"+Math.round(monthesi*12)+"</p></TD>");
						 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
						 out.println("</TR>");
					  
					  
					 monthctc=monthgross+monthpf+monthesi;
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom'   colSpan='2' class='boldEleven' ><p>Total cost To Company   (TCTC)</p></TD>");
					 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
					 out.println("<TD vAlign='bottom'    align='right' class='boldEleven' ><p>"+Math.round(monthctc) +"</p></TD>");
					 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
					 out.println("<TD vAlign='bottom'     align='right' class='boldEleven' ><p>"+Math.round((monthctc)*12)+"</p></TD>");
					 out.println("<TD vAlign='bottom'     class='boldEleven' >&nbsp;</TD>");
					 out.println("</TR>"); 
					 
					 
					
					 
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom'    colSpan='2' class='boldEleven' ><p>As Applicable to your   Current Role</p></TD>");
					 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
					 out.println("<TD vAlign='bottom'    align='right' class='boldEleven' >&nbsp;</TD>");
					 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
					 out.println("<TD vAlign='bottom'    align='right' class='boldEleven' >&nbsp;</TD>");
					 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
					 out.println("</TR>"); 
					 
					 takehome=monthgross-(staffpf+staffesi);;
					 out.println("<TR bgcolor='CCCCCC'>");
					 out.println("<TD vAlign='bottom'    colSpan='2' class='boldEleven' ><b>Take Home  Salary= "+Math.round(takehome)+"</b> </TD>");
					 out.println("<TD vAlign='bottom'   class='boldEleven' >&nbsp;</TD>");
					 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
					 out.println("<TD vAlign='bottom'   class='boldEleven'  >&nbsp;</TD>");
					 out.println("<TD vAlign='bottom'    class='boldEleven' >&nbsp;</TD>");
					 out.println("<TD vAlign='bottom'   class='boldEleven'  >&nbsp;</TD>");
					 out.println("</TR>"); 
					 
				}
				
			 
				out.println("</TBODY>"); 
				out.println(" </TABLE>"); 
		 
		 
		 
out.println("</td>");
out.println("</tr>");
out.println("</table>");

%>	
<br>Your take home salary will be &nbsp; <b>Rs.<%=Math.round(takehome)%>/-</b>   </td>
    </tr>
	<tr>
	  <td   class="boldEleven">
	  <%
	  
	  String pfData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT INT_PFAMT,INT_ESIAMT,INT_CPY_PFAMT,INT_CPY_PENSIONAMT,INT_CPY_ESIAMT,INT_PFLIMIT,INT_ESILIMIT,INT_PFLIMITMINIMUM,ROUND(INT_PFLIMITMINIMUM*INT_PFAMT/100) FROM m_institution WHERE INT_ID=1 ");
	  
	  if("C".equals(pf) && "C".equals(esi))
	  {
	  %>
	  
	   PF will be deducted as per the minimum wages Act (the present level is Rs.<%=pfData[0][7]%>/-)(ie. MW Rs.<%=pfData[0][7]%>*<%=pfData[0][0]%>%=<%=pfData[0][8]%>/-).(Basic -Employee Contribution of PF is <%=pfData[0][0]%>%, Gross Contribution of ESIC <%=pfData[0][1]%>%= Take home salary). 
	   
	  
	  <%
	  	}	
		
		String taxsql="SELECT INT_GTEQL,INT_LSEQL,DOU_PERCENTAGE,DOU_AMOUNT FROM pay_m_taxvalue ORDER BY INT_ID ";
		String taxdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(taxsql);
		double taxvalue=0.0;
		
		for(int t=0;t<taxdata.length;t++)
			if((monthgross >= Integer.parseInt(taxdata[t][0])) && (monthgross <= Integer.parseInt(taxdata[t][1])))
				taxvalue= taxvalue+Double.parseDouble(taxdata[t][3]);
											
											
			
	  %>
	  Rs.<%=taxvalue%>/- per month will be deducted for professional salary as per statutory.
	  </td>
	 </tr>
	
	<tr>
	  <td class="boldEleven"  >Please confirm that the above terms are acceptable to you and that you accept the offer by signing the copy of this letter. </td>
     </tr>
	<tr>
	  <td class="boldEleven"  >Please ensure that you bring the enclosed details attached with the offer letter at the time of joining. </td>
     </tr>
	<tr>
	  <td class="boldEleven"  >Wishing you the very best. </td>
     </tr>
	 
	<tr>
	  <td class="boldEleven"  >Your sincerely </td>
     </tr>
	<tr>
	  <td class="boldEleven"  >
	  <%
	    
	  String cpyData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT CHR_NAME,CHR_ADD1,CHR_ADD2,CHR_CITY,CHR_STATE,INT_PINCODE,INT_PHONE,CHR_MAILID FROM m_institution WHERE INT_ID=1 ");
	  
	  %>
	  For <%=cpyData[0][0]%></td>
     </tr>
	<tr>
	  <td  >&nbsp;</td>
     </tr>
	 
	<tr>
	  <td class="boldEleven"  >Authorised Signatory </td>
     </tr>
	 
	<tr>
	  <td class="boldEleven"  >I Agree to accept the offer on terms and conditions mentioned in the above letter </td>
     </tr>
	<tr>
	  <td  >&nbsp;</td>
     </tr>
	<tr>
	  <td  ><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="55%" class="boldEleven"><b><%=" Date : "+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DATE_FORMAT(NOW(),'%d-%m-%Y')")[0][0]%></b></td>
          <td width="45%" class="boldEleven"><b>
          <div align="right">Signature : <b></div></td>
        </tr>
      </table></td>
     </tr>
	 
</table>
   
   
</p><br>


<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
 

<center>
<input class="tMLAscreenHead" type="button" name="Button"  value="Close"   accesskey="c"  onClick="redirect('OfferLetterView.jsp')" tabindex="7">
</center>
 
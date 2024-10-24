<%@ page import="java.io.*,java.util.*" isErrorPage="false" 	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<html>
 
<%@include file="Redirect.jsp" %>

<title>:: STAFF ::</title>

 
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
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body  onpaste="return false;" >
 
	  
	 
	  <p>&nbsp;</p>
	  <p>&nbsp;</p>
	  <TABLE width=500 border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#dce4f9" class=BackGround>
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
            <TD width=425 valign="top"><table width="500" border="0" align="center" cellpadding="3" cellspacing="3">
              <tr>
                <td width="100%" class="bold1"><div align="center">ASSET INFORMATIONS</div></td>
              </tr>
               
              <tr>
                <td class="boldEleven"> 
				
			
				
				</td>
              </tr>
              <tr>
                <td class="boldEleven"><div align="center">
		<%
 
String sql="";
sql = sql+ "  SELECT   ";
sql = sql+ "  if(a.CHR_TYPE='I','Item','Product'),    ";
sql = sql+ "  if(a.CHR_TYPE='I',     ";
sql = sql+ "  (SELECT d.CHR_ITEMNAME FROM inv_m_item d WHERE d.CHR_ITEMID=a.CHR_ITEMID)    ";
sql = sql+ "  ,    ";
sql = sql+ "  (SELECT e.CHR_PRODUCTCODE  FROM inv_m_produtlist  e WHERE e.CHR_PRODUCTID=a.CHR_ITEMID)   ";
sql = sql+ "  ),    ";  

sql = sql + " if( a.CHR_TYPE ='I' ,   ";
sql = sql + " (SELECT aa1.CHR_DES FROM inv_m_item aa1  WHERE  aa1.CHR_ITEMID =a.CHR_ITEMID),   ";
sql = sql + " (SELECT sa2.CHR_PRODUCTDESC FROM inv_m_produtlist sa2  WHERE  sa2.CHR_PRODUCTID =a.CHR_ITEMID)   "; 
sql = sql + " ) productdescription ,   ";

sql = sql+ "  a.CHR_SERIALNO,   "; 
sql = sql+ "  DATE_FORMAT(a.DAT_CREATIONDATE,'%d-%b-%Y'), a.CHR_STATUS     ";
sql = sql+ "  FROM inv_t_asset a,com_m_staff b,inv_t_vendorgoodsreceived c    ";
sql = sql+ "  WHERE a.CHR_EMPID=b.CHR_EMPID   "; 
sql = sql+ "  AND a.CHR_ITEMID = c.CHR_ITEMID    ";
sql = sql+ "  AND a.CHR_SERIALNO =c.CHR_SERIALNO    ";
sql = sql+ "  AND a.CHR_EMPID ='"+session.getAttribute("EMPID")+"'   ";
 
String Data[][] = CommonFunctions.QueryExecute(sql);
if (Data.length > 0)
{
	 
	out.println("<center>");
	out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	out.println("<tr class='MRow1'>");
	out.println("<td class='boldEleven' align='center'><b>S.No</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Type</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Product Code</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Description</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Serial Number</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Date</b></td>");
	out.println("<td class='boldEleven' align='center'><b>Status</b></td>");
	out.println("</tr>");
	for(int i=0;i<Data.length;i++)
	{ 
		if(i%2==0)
			out.println("<tr class='MRow1'>");
		else
			out.println("<tr class='MRow2'>");	
			
		out.println("<td class='boldEleven'  >"+(i+1)+"</td>");
		out.println("<td class='boldEleven'  >"+Data[i][0]+"</td>");
		out.println("<td class='boldEleven'  >"+Data[i][1]+"</td>");
		out.println("<td class='boldEleven'  >"+Data[i][2]+"</td>");
		out.println("<td class='boldEleven'  >"+Data[i][3]+"</td>");
		out.println("<td class='boldEleven'  >"+Data[i][4]+"</td>");
		if("Y".equals(Data[i][5]))
			out.println("<td class='boldEleven'  ><font class='boldgreen'>Returned</font></td>");
		else
			out.println("<td class='boldEleven'  ><font class='bolddeepred'>Not return</font></td>");	
			
		out.println("</tr>");	 
			
	}
	out.println("</table>");
	out.println("<center>");
}

 
	 
%>
	
 	 
	  
                </div></td>
              </tr>
              <tr>
                <td class="boldEleven"><table width="112" border="0" align="center" cellpadding="3"
									cellspacing="2" >
                    <tr>
                       
                      <td align="center"><input name="Close" type="button"   class="tMLAscreenHead" id="Close"  value="Close"   accesskey="c"  	onClick="redirect('Userframe.jsp')"></td>
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
</TABLE>
	  
 
	  

</body>
</html>




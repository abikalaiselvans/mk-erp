<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body> <%@ page import="com.my.org.erp.common.CommonFunctions" %>
<%
try
{
%>
<html>
<head>

<title> :: COMMON ::</title>


 
<link rel="icon" type="image/ico" href="../report/images/ERP.ico"></link>
<link rel="shortcut icon" href="../report/images/ERP.ico"></link>

<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<jsp:include page="../Smart Common/index.jsp" flush="true" />
 <%--  <jsp:include page="../Styles/dynamicStylesheet.jsp" flush="true" /> --%>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

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
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
	 <form  AUTOCOMPLETE = "off"   action="../report/SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return Validate()">
	<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
			align="center" border="0">
      <tbody>
        <tr>
          <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../report/Image/General/TLCorner.gif" width="7" /></td>
          <td class="BorderLine" height="0"> </td>
          <td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../report/Image/General/TRCorner.gif" width="7" /></td>
        </tr>
        <tr>
          <td height="6"> </td>
        </tr>
        <tr>
          <td class="BorderLine" width="1"> </td>
          <td width="6"> </td>
          <td width="412" valign="top">
		 
		    <table width="100%" border="0" align="center" cellpadding="3" cellspacing="3">
              <tr>
                <td width="100%" colspan="2" class="bold1"><div align="center">Section Report Generation</div></td>
                </tr>
              <tr>
                <td colspan="2" class="boldEleven"><table width="100%" border="0" cellspacing="5" cellpadding="5">
                  <tr>
				  <td><a href="../SmartLoginAuth?filename=Section&actionS=RPTSectionGenerate&rptfilename=PageWidth1640&reportType=pdf&companyid=1&SectionId=0"><img src="../JavaScript/img/ico_file_pdf.png" width="15" height="14" border="0">Pdf</a></td>
				   <td><a href="../SmartLoginAuth?filename=Section&actionS=RPTSectionGenerate&rptfilename=PageWidth1640&reportType=rtf&companyid=1&SectionId=0"><img src="../JavaScript/img/ico_file_rtf.png" width="16" height="16" border="0">Rtf</a></td>
				   <td><a href="../SmartLoginAuth?filename=Section&actionS=RPTSectionGenerate&rptfilename=PageWidth1640&reportType=xls&companyid=1&SectionId=0"><img border="0" src="../JavaScript/img/ico_file_excel.png" width="15" height="14" border="0">Excel</a></td>
                    <td><a href="../SmartLoginAuth?filename=Section&actionS=RPTSectionGenerate&rptfilename=PageWidth1640&reportType=csv&companyid=1&SectionId=0"><img src="../JavaScript/img/ico_file_csv.png" width="15" height="14" border="0">CSV</a></td>
                    
                     <td><a href="../SmartLoginAuth?filename=Section&actionS=RPTSectionGenerate&rptfilename=PageWidth1640&reportType=html&companyid=1&SectionId=0"><img src="../JavaScript/img/ico_file_html.png" width="15" height="14" border="0">Html</a></td>
                   
                    <td><a href="../SmartLoginAuth?filename=Section&actionS=RPTSectionGenerate&rptfilename=PageWidth1640&reportType=xml&companyid=1&SectionId=0"><img src="../JavaScript/img/ico_file_xml.png" width="15" height="14" border="0">Xml</a></td>
					<td><a href="../SmartLoginAuth?filename=Section&actionS=RPTSectionGenerate&rptfilename=PageWidth1640&reportType=txt&companyid=1&SectionId=0"><img src="../JavaScript/img/ico_file_txt.png" width="15" height="14" border="0">Txt</a></td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                  </tr>
                </table></td>
                </tr>
               
               
              
              
              <tr>
                <td colspan="2" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                
                </table></td>
                </tr>
            </table>
		 </td>
          <td nowrap="nowrap" width="4"> </td>
          <td class="BorderLine" width="1"> </td>
        </tr>
        <tr>
          <td colspan="2" rowspan="2"><img height="7"
						src="../report/Image/General/BLCorner.gif" width="7" /></td>
          <td height="6"> </td>
          <td colspan="2" rowspan="2"><img height="7"
						src="../report/Image/General/BRCorner.gif" width="7" /></td>
        </tr>
        <tr>
          <td class="BorderLine" height="0"> </td>
        </tr>
      </tbody>
    </table> </form></td>
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
<%@ include file="../../footer.jsp"%>

 
	<%	
	 
}
catch(Exception e)
{
}
%>
</body>
</html>


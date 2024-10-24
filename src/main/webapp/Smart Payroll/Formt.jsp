<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
</head>

<body  onpaste='return false;'>
<p><%@ include file="index.jsp" %></p>
<%


	String type=request.getParameter("type");
	String company=request.getParameter("company");
	int start=0,end=0;
	int year=Integer.parseInt(request.getParameter("Year"));
	String comname="",comst="",comcity="",compin="",from="",to="";
	String sql="";
	sql="select * from com_m_company where INT_COMPANYID="+company;
	String datacom[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	if(datacom.length>0)
	{
		comname=datacom[0][1];
		comst=datacom[0][3];
		comcity=datacom[0][4];
		compin=datacom[0][6];
	}
	String mon="",mon1="";
	if(type.equals("O"))
	{
		mon="'October','November','December'";
	 	mon1="'January','February','March'";
    	from="OCT-"+(year-1);
	  	to="MAR-"+year;
	  	start=year-1;
	  	end=year;
	}
	else
	{
	  	mon="'April','May','June'";
	  	mon1="'July','August','September'";
	  	from="APRIL-"+year;
	  	to="SEP-"+year;
	  	start=year;
	  	end=year;
	}
	sql="select a.CHR_EMPNAME,sum(a.DOU_WORKDAYS),sum(a.DOU_BASIC),sum(a.DOU_ESI)"+
	",b.CHR_ESINO,c.CHR_DESPNAME from pay_t_salary a,com_m_staff b,com_m_dispensary c  where "+ 
    " a.CHR_EMPID=b.CHR_EMPID and b.INT_PLACEID=c.INT_DESPID and b.CHR_ESI<>'N' and b.INT_COMPANYID="+company+" group by a.CHR_EMPID";
String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
for(int i=0;i<data.length;i++)
{
  out.println("<table width='200' border='1' align='center' cellpadding='0' cellspacing='0'>");
  out.println("<tr>");
  out.println("<th scope='col'><p><b>FORM T</b><br>");
  out.println("<span class='bolddeepblue'>Wages Slip/Leave Card<br>[See sub rule(6) of Rule 11]</span></p>");
  out.println("<p align='left'><span class='bolddeepblue'>1.Name and Address of the Establishment M/s. </span><br><br></p>");
  out.println("<table width='200' border='0' cellspacing='0' cellpadding='0'>");
  out.println("<tr>");
  out.println("<th class='bolddeepblue' scope='col'>Chennai-600017</th>");
  out.println("</tr>");
  out.println("</table>");
  out.println("<div align='left'><br>");
  out.println("<span class='bolddeepblue'>2.Name of the Person Employed</span><br>");
  out.println("<span class='bolddeepblue'><br>3.Father's or Husband's Name</span><br><br>");
  out.println("<span class='bolddeepblue'>4.Designation</span><br><br>");
  out.println("<span class='bolddeepblue'>5.Date of Entry into Service      </span>");
  out.println("</p></div>");
  out.println("<table width='715' border='0' cellspacing='0' cellpadding='0'>");
  out.println("<tr>");
  out.println("<th width='214' class='bolddeepblue' scope='col'><div align='left'>6. Wage period </div></th>");
  out.println("<th width='174' class='bolddeepblue' scope='col'><div align='left'>From </div></th>");
  out.println("<th width='327' class='bolddeepblue' scope='col'><div align='left'>To</div></th>");
  out.println("</tr>");
  out.println("</table>");
  out.println("<table width='716' height='274' border='0' align='left' cellpadding='0' cellspacing='0'>");
  out.println("<tr>");
  out.println("<td height='32' colspan='2' class='bolddeepblue'>7.Wage Earned:-</td>");
  out.println("<td width='278' class='bolddeepblue'>Deductions</td>");
  out.println("<td width='12' class='bolddeepblue'></td>");
  out.println("</tr>");
  out.println(" <tr>");
  out.println("<td width='15' height='27' class='bolddeepblue'>&nbsp;</td>");
  out.println("<td width='412' class='bolddeepblue'>(a)Basic</td>");
  out.println("<td class='bolddeepblue'>(I)Employees Provident Fund </td>");
  out.println("<td class='bolddeepblue'>&nbsp;</td>");
  out.println("</tr>");
  out.println("<tr>");
  out.println("<td height='34' class='bolddeepblue'>&nbsp;</td>");
  out.println("<td height='34' class='bolddeepblue'>(b)Dearness Allowance </td>");
  out.println("<td class='bolddeepblue'>(II)Employees State Insurance </td>");
  out.println("<td class='bolddeepblue'>&nbsp;</td>");
  out.println("</tr>");
  out.println("<tr>");
  out.println("<td height='35' class='bolddeepblue'>&nbsp;</td>");
  out.println("<td height='35' class='bolddeepblue'>(c)House Rent Allowance </td>");
  out.println("<td class='bolddeepblue'>(III)Others Deductions </td>");
  out.println("<td class='bolddeepblue'>&nbsp;</td>");
  out.println("</tr>");
  out.println("<tr>");
  out.println("<td height='28' class='bolddeepblue'>&nbsp;</td>");
  out.println("<td height='28' class='bolddeepblue'>(d)Overtime Wages </td>");
  out.println("<td class='bolddeepblue'>&nbsp;</td>");
  out.println("<td class='bolddeepblue'>&nbsp;</td>");
  out.println("</tr>");
  out.println("<tr>");
  out.println("<td height='31' class='bolddeepblue'>&nbsp;</td>");
  out.println("<td height='31' class='bolddeepblue'>(e)Leave Wages </td>");
  out.println("<td class='bolddeepblue'>&nbsp;</td>");
  out.println("<td class='bolddeepblue'>&nbsp;</td>");
  out.println("</tr>");
  out.println("<tr>");
  out.println("<td height='31' class='bolddeepblue'>&nbsp;</td>");
  out.println("<td height='31' class='bolddeepblue'>(f)Other Allowance </td>");
  out.println("<td class='bolddeepblue'>&nbsp;</td>");
  out.println("<td class='bolddeepblue'>&nbsp;</td>");
  out.println("</tr>");
  out.println("<tr>");
  out.println("<td height='28' class='bolddeepblue'>&nbsp;</td>");
  out.println("<td height='28' class='bolddeepblue'>(g)Gross Wages </td>");
  out.println("<td class='bolddeepblue'>&nbsp;</td>");
  out.println("<td class='bolddeepblue'>&nbsp;</td>");
  out.println(" </tr>");
  out.println("<tr>");
  out.println("<td colspan='2' class='bolddeepblue'>&nbsp;</td>");
  out.println("<td class='bolddeepblue'>Net Amount Paid </td>");
  out.println("<td class='bolddeepblue'>&nbsp;</td>");
  out.println("</tr>");
  out.println("<tr>");
  out.println("<td colspan='4'><table width='716' border='0' cellspacing='0' cellpadding='0'>");
  out.println("<tr>");
  out.println("<th colspan='6' scope='col'>&nbsp;</th>");
  out.println("</tr>");
  out.println("<tr>");
  out.println("<th width='336' scope='col'><div align='left' class='bolddeepblue'>8 laeve Avalied during the month </div></th>");
  out.println("<th width='25' scope='col'>&nbsp;</th>");
  out.println("<th width='105' class='bolddeepblue' scope='col'><div align='left'>CL...................</div></th>");
  out.println("<th width='71' class='bolddeepblue' scope='col'><div align='left'>SL............</div></th>");
  out.println("<th width='83' class='bolddeepblue' scope='col'><div align='left'>EL................</div></th>");
  out.println("<th width='97' class='bolddeepblue' scope='col'><div align='left'>M..............</div></th>");
  out.println("</tr>");
  out.println("<tr>");
  out.println("<th scope='col'><div align='left' class='bolddeepblue'>9 Leave at Credit  </div></th>");
  out.println("<th scope='col'>&nbsp;</th>");
  out.println("<th class='bolddeepblue' scope='col'><div align='left'>CL...................</div></th>");
  out.println("<th class='bolddeepblue' scope='col'><div align='left'>SL............</div></th>");
  out.println("<th class='bolddeepblue' scope='col'><div align='left'>EL................</div></th>");
  out.println("<th class='bolddeepblue' scope='col'><div align='left'>M..............</div></th>");
  out.println("</tr>");
  out.println("<tr>");
  out.println("<th colspan='6' scope='col'><p>&nbsp;</p>");
  out.println(" <table width='718' border='0' cellspacing='0' cellpadding='0'>");
  out.println("<tr>");
  out.println("<th class='bolddeepblue' scope='col'><div align='left'><strong>Signature of the Employer /Manager or any other authorised person </strong></div></th>");
  out.println("<th class='bolddeepblue' scope='col'><div align='left'><strong>Signature or Thump Imperssion of the Person Employed </strong></div></th>");
  out.println("</tr>");
  out.println("</table></th>");
  out.println("</tr>");
  out.println("</table></td>");
  out.println("</tr>");
  out.println("</table></th>");
  out.println("</tr>");
  out.println("</table>");
  out.println("<br><br>");
}
%>
<p>&nbsp;</p>
<table width="184" align="center" cellpadding="15" cellspacing="0">
  <tr>
    <td width="100" height="44" class="boldEleven"><strong>Export </strong></td>
    <td class="boldEleven"><div align="center"><a  title="Excel" href="javascript:;" onclick="CreateExcelSheet()"><img src="../Image/report/Excel.png" width="15" height="14" border="0" /></a> </div></td>
    <td class="boldEleven"><div align="center"><a title="Text" href="javascript:;" onclick="windowSave('Formt.txt')"><img src="../Image/report/text.gif" width="15" height="14" border="0" /></a></a></div></td>
    <td class="boldEleven"><div align="center"><a title="Document" href="javascript:;" onclick="windowSave('Formt.doc')"><img src="../Image/report/MS.GIF" width="15" height="14" border="0" /></a></div></td>
    <td class="boldEleven"><div align="center"><a title="HTML" href="javascript:;" onclick="windowSave('Formt.html')"><img src="../Image/report/IE.GIF" width="15" height="14" border="0" /></a></div></td>
  </tr>
</table>

</body>
</html>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<!-- TemplateBeginEditable name="doctitle" -->

<title> :: PAYROLL ::</title>


 
<!-- TemplateEndEditable -->
<!-- TemplateBeginEditable name="head" --><!-- TemplateEndEditable -->
 
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
body {
	margin-top: 25px;
}
.style5 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;}
-->
</style></head>

<body  onpaste='return false;'>
<%
try
{
%>
  <table width="82%" align="center"  cellpadding=2 cellspacing=1 bgcolor='#9900CC'  id='myTable' >
    <tr bgcolor='#ffffff'>
      <td align="center"   scope="col"> 
        <table width="100%" border="0" align="center" cellpadding="2" cellspacing="2">
          <tr>
            <td  ><table width="100%"   border="0" cellpadding="0" cellspacing="0">
              <tr>
                <th   scope="col"><div align="left" class="bolddeepblue">
                    <% 
					
					String comid=request.getParameter("company");
    				String branchid=request.getParameter("branch");
    				String officeid=request.getParameter("Office");
    				String year=request.getParameter("year");
    				String cpy  ="";
					String bid  ="";
					String off="";
					String yer="";
					String sql="";
					if(!"-1".equals(comid))
						cpy =" AND b.INT_COMPANYID = "+comid;
					
					if(!"-1".equals(branchid))
						bid ="  AND b.INT_BRANCHID = "+branchid;
					
					if(!"0".equals(officeid))
						off ="  AND b.INT_OFFICEID = "+officeid;
					 
					int yr=Integer.parseInt(year);
					
    		sql = " SELECT a.CHR_COMPANYNAME,a.CHR_STREET,f.CHR_CITYNAME,a.INT_PINCODE,a.CHR_PFNUMBER, ";
				sql = sql + " c.CHR_COUNTRYNAME,d.CHR_STATENAME,e.CHR_DISTRICT,f.CHR_CITYNAME  ";
				sql = sql + " FROM com_m_company a, com_m_country c, com_m_state d, com_m_district e, com_m_city f ";
				sql = sql + " WHERE a.INT_COUNTRYID= c.INT_COUNTRYID ";
				sql = sql + " AND a.INT_STATEID = d.INT_STATEID ";
				sql = sql + " AND a.INT_DISTRICTID = e.INT_DISTRICTID ";
				sql = sql + " AND a.INT_CITYID = f.INT_CITYID ";
				sql = sql + " AND a.INT_COMPANYID="+comid;
				String datac[][]=CommonFunctions.QueryExecute(sql);
				
    		 
    		 
    		%>
                  <span class="boldEleven">Only for Un-Exempted Establishments</span> </div></th>
                <th width="200" scope="col"><div align="right" class="boldEleven">(To be filled by the EPFO)</div></th>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td><table border="0" align="left" cellpadding="0" cellspacing="0">
              <tr>
                <th width="85" scope="col">&nbsp;</th>
                <th width="819" scope="col"><div align="center" class="boldEleven"><strong>FORM 12-A(Revised)<br />
                    EMPLOYEES' PROVIDENT FUND AND MISC. PROVISIONS ACT, 1952 <br />
                  EMPLOYEES' PENSION SCHEME [PARAGRAPH 20(4) ]</strong></div></th>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
              <tr>
                <th align="center" valign="top" class="boldEleven" scope="col">&nbsp;</th>
                <th align="center" valign="top" class="boldEleven" scope="col">&nbsp;</th>
                <th align="center" valign="top" class="boldEleven" scope="col">&nbsp;</th>
                <th align="center" valign="top" class="boldEleven" scope="col">&nbsp;</th>
              </tr>
              <tr>
                <th width="271" align="center" valign="top" class="boldEleven" scope="col"><div align="left" class="boldEleven">Name and Address of the establishment </div></th>
                <th width="236" align="center" valign="top" class="boldEleven" scope="col">
				<div align="left" class="boldEleven"><strong>M/s.<%=datac[0][0] %>,<br />
				    <%= datac[0][1] %>,<br />
				    <%= datac[0][2]%>-<%= datac[0][3] %>				</strong></div></th>
                <th width="125" align="center" valign="top" class="boldEleven" scope="col"><div align="left" class="boldEleven">
                    <div align="right">Establishment Status </div>
                </div></th>
                <th width="163" align="center" valign="top" class="boldEleven" scope="col"><table width="123" border="1" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                      <th class="bolddeepblue" scope="col"><div align="center"><strong class="boldEleven">Unexempted</strong></div></th>
                    </tr>
                </table></th>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td>&nbsp; </td>
          </tr>
          <tr>
            <td><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <th width="522" scope="col"><div align="left" class="boldEleven">
                  <div align="center"><strong>Currency Period from 1st April <%=yr%> to 31st March <%=(yr+1) %>                  Statement of contributions for the month of </strong></div>
                </div></th>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td><table border="0" align="left" cellpadding="0" cellspacing="0">
              <tr>
                <th colspan="3" scope="col"><table width="100%" border="0" cellspacing="2" cellpadding="2">
                  <tr>
                    <td width="9%">&nbsp;</td>
                    <td width="25%">&nbsp;</td>
                    <td width="12%">&nbsp;</td>
                    <td width="2%">&nbsp;</td>
                    <td width="35%"><div align="right"><span class="boldEleven">Group Code</span></div></td>
                    <td width="17%"><table width="124" border="0" align="right"   cellpadding=2 cellspacing=1 bgcolor='#9900CC'>
                      <tr bgcolor="#FFFFFF">
                        <th scope="col">&nbsp;</th>
                        <th scope="col">&nbsp;</th>
                        <th scope="col">&nbsp;</th>
                      </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td><span class="boldEleven">Code No </span></td>
                    <td><table width="200"   cellpadding=2 cellspacing=1 bgcolor='#9900CC'>
                      <tr bgcolor="#FFFFFF">
                        <th class="boldEleven" scope="col"><div align="center">T</div></th>
                        <th class="boldEleven" scope="col"><div align="center">N</div></th>
                        <th class="boldEleven" scope="col"><div align="center">5</div></th>
                        <th class="boldEleven" scope="col"><div align="center">0</div></th>
                        <th class="boldEleven" scope="col"><div align="center">3</div></th>
                        <th class="boldEleven" scope="col"><div align="center">6</div></th>
                        <th class="boldEleven" scope="col"><div align="center">0</div></th>
                      </tr>
                    </table></td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td><div align="right"><span class="boldEleven">Statuatory rate of Contribution</span></div></td>
                    <td><table width="123"   align="right"    cellpadding=2 cellspacing=1 bgcolor='#9900CC'>
                      <tr bgcolor="#FFFFFF">
                        <th width="39" class="boldEleven" scope="col"><div align="center">1</div></th>
                        <th width="38" class="boldEleven" scope="col"><div align="center">2</div></th>
                        <th width="38" class="boldEleven" scope="col"><div align="center">%</div></th>
                      </tr>
                    </table></td>
                  </tr>
                </table></th>
              </tr>
              <tr>
                <th width="243" scope="col">&nbsp;</th>
                <th width="541" scope="col">&nbsp;</th>
                <th width="192" scope="col">&nbsp;</th>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td><table width="100%"  id='myTable'  cellpadding=2 cellspacing=1 bgcolor='#9900CC'>
              <tr bgcolor="#FFFFFF">
                <td width="13%" rowspan="2" class="boldEleven"><div align="center"><strong><span class="paraterms">Particulars (1) </span></strong></div></td>
                <td width="11%" rowspan="2" class="boldEleven">
                <div align="center"><strong><span class="style5">Wages on Which contibutions are Payble (2) </span></strong></div></td>
                <td colspan="2" class="boldEleven">
                <div align="center"><strong><span class="style5">Amount of Contribution (3) </span></strong>
				<%
				
				sql = " select ROUND(SUM(a.DOU_BASIC)),ROUND(SUM(a.DOU_PENBASIC)),ROUND(SUM(a.DOU_PF))";
				sql =sql +" ,ROUND(SUM(a.DOU_COMPANYPF)),ROUND(SUM(a.DOU_COMPANYPENSION)),ROUND(SUM(a.DOU_ADMINCHARGE)),ROUND(SUM(a.DOU_EDLI)),";
				sql =sql +" ROUND(SUM(a.DOU_ADMINCHARGE1)) from pay_t_salary a,com_m_staff b";
				sql =sql +" where ((a.CHR_MONTH in('May','June','July','August','Septemper','October','November','December') ";
				sql =sql +"  and a.INT_YEAR="+yr+") or (a.CHR_MONTH in('January','February','March') and a.INT_YEAR="+(yr+1)+")) ";
				sql =sql +cpy;
				sql =sql +bid;
				sql =sql +off;
				//out.println(sql);
				String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				%>
				</div></td>
                <td colspan="2" class="boldEleven"><div align="center"><strong>Amount of Contributions Remitted (4) </strong></div></td>
                <td width="11%" rowspan="2" class="boldEleven"><div align="center"><strong>Amount of Aministrative Charges Due </strong></div></td>
                <td width="14%" rowspan="2" class="boldEleven"><div align="center"><strong>Amount of Administrative Charges Remitted </strong></div></td>
                <td width="13%" rowspan="2" class="boldEleven"><div align="center"><strong>Date of Remittance (Enclose Triplicate Copies of Challan) </strong></div></td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td width="9%" class="boldEleven"><div align="center"><strong>Recovered from the workers </strong></div></td>
                <td width="9%" class="boldEleven"><div align="center"><strong>Payable by the employer</strong></div></td>
                <td width="8%" class="boldEleven"><div align="center"><strong>Worker's share </strong></div></td>
                <td width="12%" class="boldEleven"><div align="center"><strong>Employer's Share </strong></div></td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td class="boldEleven"><div align="left"><strong>E.P.F.A/c.No. 01 </strong></div></td>
                <td class="boldEleven"><div align="right"><%=data[0][0]%></div></td>
                <td class="boldEleven"><div align="right"><%=data[0][2]%></div></td>
                <td class="boldEleven"><div align="right"><%=data[0][3]%></div></td>
                <td class="boldEleven"><div align="right"><%=data[0][2]%></div></td>
                <td class="boldEleven"><div align="right"><%=data[0][3]%></div></td>
                <td class="boldEleven"><div align="right"><%=data[0][5]%></div></td>
                <td class="boldEleven"><div align="right"><%=data[0][5]%></div></td>
                <td class="boldEleven"><div align="right"></div></td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td class="boldEleven"><div align="left"><strong>Pension Fund A/c. No.10</strong></div></td>
                <td class="boldEleven"><div align="right"><%=data[0][1]%></div></td>
                <td class="boldEleven"><div align="right"></div></td>
                <td class="boldEleven"><div align="right"><%=data[0][4]%></div></td>
                <td class="boldEleven"><div align="right"></div></td>
                <td class="boldEleven"><div align="right"><%=data[0][4]%></div></td>
                <td class="boldEleven"><div align="right"></div></td>
                <td class="boldEleven"><div align="right"></div></td>
                <td class="boldEleven"><div align="right"></div></td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td class="boldEleven"><div align="left"><strong>E.D.L.I. A/c.No.21</strong></div></td>
                <td class="boldEleven"><div align="right"></div></td>
                <td class="boldEleven"><div align="right"></div></td>
                <td class="boldEleven"><div align="right"><%=data[0][6]%></div></td>
                <td class="boldEleven"><div align="right"></div></td>
                <td class="boldEleven"><div align="right"><%=data[0][6]%></div></td>
                <td class="boldEleven"><div align="right"><%=data[0][7]%></div></td>
                <td class="boldEleven"><div align="right"><%=data[0][7]%></div></td>
                <td class="boldEleven"><div align="right"></div></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="68%"><table width="237" height="89"  cellpadding=2 cellspacing=1 bgcolor='#9900CC'>
                  <tr bgcolor="#FFFFFF">
                    <th colspan="3" class="boldEleven" scope="col"><strong>Total No.Of Employees </strong></th>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <th width="35" height="23" class="boldEleven" scope="row"><div align="right" class="bolddeepblue">a)</div></th>
                    <th width="114" class="boldEleven" scope="row"><div align="left" class="boldEleven">Contract</div></th>
                    <th width="80" class="boldEleven" scope="row">&nbsp;</th>
                  </tr >
                  <tr bgcolor="#FFFFFF">
                    <th height="24" class="boldEleven" scope="row"><div align="right" class="bolddeepblue">b)</div></th>
                    <th class="boldEleven" scope="row"><div align="left" class="boldEleven">Rest</div></th>
                    <th class="boldEleven" scope="row">&nbsp;</th>
                  </tr>
                  <tr bgcolor="#FFFFFF">
                    <th height="22" class="boldEleven" scope="row"><div align="right" class="bolddeepblue">c)</div></th>
                    <th class="boldEleven" scope="row"><div align="left" class="boldEleven"><strong>Total</strong></div></th>
                    <th class="boldEleven" scope="row">&nbsp;</th>
                  </tr>
                </table></td>
                <td width="20%"><span class="boldEleven">Name &amp; Address of the Bank in which the amount is remitted </span></td>
                <td width="12%">&nbsp;</td>
              </tr>
            </table>
            </td>
          </tr>
          <tr>
            <td><table width="100%"    cellpadding=2 cellspacing=1 bgcolor='#9900CC'>
              <tr bgcolor="#FFFFFF">
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven"><span class="boldEleven">E.P.F</span></td>
                <td class="boldEleven"><span class="boldEleven">Pension 
                Fund</span></td>
                <td class="boldEleven">E.D.L.I</td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td class="boldEleven"><div align="left">Details of Subscribers as per last month </div></td>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td class="boldEleven"><div align="left">No. of New Subscribers (Vide Form 5) </div></td>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td class="boldEleven"><div align="left">No. of Subscribuers left service (Vide Form 10) </div></td>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
              </tr>
              <tr bgcolor="#FFFFFF">
                <td class="boldEleven"><div align="left"><strong>(Nett.) Total Number of Subscribers </strong></div></td>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
                <td class="boldEleven">&nbsp;</td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
        </table>
     
</table>
<%
}
catch(Exception e)
{
}
%>
</body>
</html>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.io.*,java.util.*,java.lang.*,java.sql.*"%>
<%@ page import="com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>



<html>

<script language="javascript" src="../JavaScript/comfunction.js"></script>

<title> :: PAYROLL ::</title>


 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<!--ondragstart="return false" onselectstart="return false"-->
<body  onpaste="return false;"  >

<p>
  <%
  
  
try
{
	String staffid = "" + request.getParameter("ename");
	String mth = "" + request.getParameter("Month");
	String mont = DateUtil.getMonth(Integer.parseInt(mth));
	String Year = "" + request.getParameter("Year");
	String loginemp = ""+session.getAttribute("EMPID");
 
	/*if(!"ADMIN".equals(loginemp))
	{
		if(!com.my.org.erp.common.CommonFunction.RecordExist("SELECT count(*) FROM com_m_staff  WHERE  CHR_EMPID='"+staffid+"' AND CHR_REPTO='"+loginemp+"'"))
		{
		 	RequestDispatcher dispatcher3 = request.getRequestDispatcher("Payslipcantview.jsp");
			dispatcher3.forward(request, response);
			 
		}	
	}
	  
	 */
	 
	 
	 
	String staffname="";
	String cpyname="";
	String desig="";
	String office="";
	String esinumber="";
	String pfnumber="";
	String bank="";
	String sql="";
	String sallowansql="";
	String srecoverysql="";
	String addedallowance="";
	String extraallowance="";
	String addedallowancetitle="";
	String extraallowancetitle="";
	String recovery="";
	String recoverytitle="";
	String addedsum="";
	String extrasum="";
	String recsum="";
	double basic=0;
	double grosspay=0.0;
	double pf=0;
	double esi =0;
	double advance=0;
	double wrkdays=0;
	double ramount=0;
	double deduction=0;
	double originalbasic=0;
	double originalgross=0;
	double earninggross=0;
	double originalextraallowance=0;
	double extraallowances=0;
	double taxvalue=0;
	sql = " SELECT b.CHR_STAFFNAME,f.CHR_COMPANYNAME,e.CHR_DESIGNAME,d.CHR_OFFICENAME,FIND_A_BANKGROUP_NAME(b.CHR_BANK) , b.CHR_ACCNO    ";
	sql = sql + " ,b.CHR_PFNO, b.CHR_ESINO ,b.INT_SALARY,f.CHR_PFNUMBER FROM com_m_staff b,  com_m_office  d,com_m_desig e ,com_m_company f ";
	sql = sql + " WHERE b.CHR_EMPID='"+staffid+"'    ";
	 
	sql = sql + " AND b.INT_OFFICEID=d.INT_OFFICEID      ";
	sql = sql + " AND b.INT_DESIGID=e.INT_DESIGID     ";
	sql = sql + " AND f.INT_COMPANYID = b.INT_COMPANYID    ";
	
	
	sql = " SELECT b.CHR_STAFFNAME,c.CHR_COMPANYNAME,d.CHR_DESIGNAME,e.CHR_OFFICENAME,FIND_A_BANKGROUP_NAME(b.CHR_BANK),a.CHR_ACCNO,    ";
	sql = sql + " IF(b.CHR_PFNO='0','',b.CHR_PFNO), IF(b.CHR_ESINO='0','',b.CHR_ESINO) ,b.INT_SALARY,c.CHR_PFNUMBER ,";
	sql = sql + " concat(c.CHR_PFNUMBER,IF(b.CHR_PFNO='0','',b.CHR_PFNO))    ";
	sql = sql + " FROM  pay_t_salary  a ,com_m_staff b,com_m_company c,com_m_desig d,com_m_office e    ";
	sql = sql + " WHERE a.CHR_EMPID = b.CHR_EMPID    ";
	sql = sql + " AND a.INT_COMPANYID = c.INT_COMPANYID    ";
	sql = sql + " AND a.INT_DESIGID = d.INT_DESIGID    ";
	sql = sql + " AND a.INT_OFFICEID = e.INT_OFFICEID    ";
 
	sql = sql + " AND	a.CHR_EMPID='"+staffid+"'    ";
	sql = sql+" AND  a.INT_YEAR ="+Year;
	sql = sql+" AND a.CHR_MONTH='"+mont+"'";


	//out.println(sql);
	String basicdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	
	sql = " SELECT INT_SALARY FROM pay_t_salarybasic";
	sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
	sql = sql+" AND  INT_YEAR ="+Year;
	sql = sql+" AND CHR_MONTH='"+mont+"'";
	String basics[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);

	sql=" SELECT DOU_BASIC,DOU_ATOTAL1,DOU_GROSSPAY,(DOU_BASIC+DOU_ATOTAL1),DOU_ATOTAL2 FROM pay_t_salary  ";
 	sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
	sql = sql+" AND  INT_YEAR ="+Year;
	sql = sql+" AND CHR_MONTH='"+mont+"'";
	String earning[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		
	if(basicdata.length>0)
	{
		staffname=basicdata[0][0];
		cpyname=basicdata[0][1];
		desig=basicdata[0][2];
		office=basicdata[0][3];
		esinumber=basicdata[0][7];
		pfnumber=basicdata[0][6];
		bank=basicdata[0][4] +" - " +basicdata[0][5];
		originalbasic = Double.parseDouble(basics[0][0]);
		earninggross  = Double.parseDouble(earning[0][2]);
		extraallowances=Double.parseDouble(earning[0][4]);
		ramount=0;
		deduction=0;
		originalgross=0;
		originalextraallowance=0;
		 
		
		sql = "SELECT CHR_ACODE,CHR_ANAME,CHR_FLAG FROM pay_m_allowance  ORDER BY INT_ALLOWANCEID";
		String aname[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		for(int a=0;a<aname.length;a++)
			if("Y".equals(aname[a][2]))
			{
				addedallowance =addedallowance+aname[a][0]+",";
				addedallowancetitle=addedallowancetitle+aname[a][1]+",";
				addedsum = addedsum+aname[a][0]+"+";
			}
			else
			{
				extraallowance =extraallowance+aname[a][0]+",";
				extraallowancetitle=extraallowancetitle+aname[a][1]+",";
				extrasum = extrasum+aname[a][0]+"+";
			}
			
			addedallowance = addedallowance.trim();
			addedallowance = addedallowance.substring(0,addedallowance.length()-1);
			addedallowancetitle = addedallowancetitle.trim();
			addedallowancetitle = addedallowancetitle.substring(0,addedallowancetitle.length()-1);
			addedsum = addedsum.trim();
			addedsum = addedsum.substring(0,addedsum.length()-1);
			
			extraallowance = extraallowance.trim();
			extraallowance = extraallowance.substring(0,extraallowance.length()-1);
			extraallowancetitle = extraallowancetitle.trim();
			extraallowancetitle = extraallowancetitle.substring(0,extraallowancetitle.length()-1);
			extrasum = extrasum.trim();
			extrasum = extrasum.substring(0,extrasum.length()-1);
			
			 
			
		sql="SELECT ROUND(DOU_BASIC),ROUND(DOU_PF),ROUND(DOU_ESI),ROUND(DOU_ADVANCE),DOU_WORKDAYS,DOU_PAYTAX FROM pay_t_salary  ";
			sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
			sql = sql+" AND  INT_YEAR ="+Year;
			sql = sql+" AND CHR_MONTH='"+mont+"'";
			String salarydata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if(salarydata.length>0)
			{
			 	basic=Double.parseDouble(salarydata[0][0]);
				pf=Double.parseDouble(salarydata[0][1]);
				esi=Double.parseDouble(salarydata[0][2]);
				advance=Double.parseDouble(salarydata[0][3]);
				wrkdays=Double.parseDouble(salarydata[0][4]);
				taxvalue=Double.parseDouble(salarydata[0][5]);
		%>
  
  <br>
</p>
<%
out.println("<a href='../SmartLoginAuth?filename=PDF_Payslip&actionS=PAYMonthlyPayslip&ename="+staffid+"&Month="+mth+"&Year="+Year+"' target='_blank'><img border='0' src='../images/icon_pdf.gif' width='47' height='49' /></a>");

%>
<table width="700"  border=1 align="center"  cellpadding=3 cellspacing=1 
	 bordercolor="#999999" background="../images/payslip.jpg">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="15%" rowspan="4" valign="top" class="boldThirteen"><img src="../images/logo.jpg" width="159" height="49"></td>
            <td width="70%" class="boldThirteen"><div align="center"><%=cpyname%></div></td>
            <td width="15%" rowspan="4" valign="top" class="boldThirteen"><!--<img
					src="../Image/report/Wipro logo.gif" width="100" height="80">--></td>
          </tr>
          <tr>
            <td class="boldThirteen"><div align="center">PAY SLIP FOR ( <%=mont +" - " +Year%> )</div></td>
          </tr>
          <tr>
            <td class="boldThirteen"><div align="center"></div></td>
          </tr>
          <tr>
            <td class="boldThirteen"><div align="center"><%=staffname%></div></td>
          </tr>
          <tr>
            <td colspan="3" class="boldEleven"><hr width="100%" size=1>
            </td>
          </tr>
          <tr>
            <td colspan="3" class="boldEleven"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td class="boldEleven"><strong>Employee Number</strong></td>
                  <td class="boldEleven"><%=staffid%></td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><strong>PF Number</strong></td>
                  <td class="boldEleven"><%=basicdata[0][9]+basicdata[0][6]%></td>
                </tr>
                <tr>
                  <td width="21%" class="boldEleven"><strong>Designation</strong></td>
                  <td width="27%" class="boldEleven"><%=desig%></td>
                  <td width="3%" class="boldEleven">&nbsp;</td>
                  <td width="14%" class="boldEleven"><strong>ESI
                    Number </strong></td>
                  <td width="35%" class="boldEleven"><%=basicdata[0][7]%></td>
                </tr>
                <tr>
                  <td class="boldEleven"><strong>Location</strong></td>
                  <td class="boldEleven"><%=office%></td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><strong>Bank Name </strong></td>
                  <td class="boldEleven"><%=bank.split("-")[0]%> </td>
                </tr>
                <tr>
                  <td class="boldEleven"><strong>No. of working days </strong></td>
                  <td class="boldEleven"><%=wrkdays%></td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><strong>Account  No </strong></td>
                  <td class="boldEleven"><%=bank.split("-")[1]%></td>
                </tr>
                <tr>
                  <td colspan="2" valign="top" class="boldEleven">
				  <%
				  
				  	out.println("<table cellpadding=0 cellspacing=0 width='90%' border=0>");
					//out.print("<tr><td class='boldEleven'><b> Allowance Name");
					//out.print("<td  class='boldEleven' align='right'><b> Amount");
					sql = "Select "+addedallowance+" FROM pay_t_salaryallowance  ";
					sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
					sql = sql+" AND  INT_YEAR ="+Year;
					sql = sql+" AND CHR_MONTH='"+mont+"'";
					String data1[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					int columncount1 = com.my.org.erp.common.CommonFunctions.intGetColumnCount(sql);
					addedallowancetitle=addedallowancetitle+"";
					String titledata1[] = addedallowancetitle.split(",");
					out.print("<tr><td class='boldEleven'>Basic");
					out.print("<td  class='boldEleven' align='right'>"+(int)originalbasic);
					out.print("<tr><td class='boldEleven' colspan=2><b>Allowance");
					
					if(columncount1>1)
					{
						for(int x=0;x<columncount1;x++)
						{
							if((Integer.parseInt(data1[0][x]))>0)
							{
								originalgross = originalgross+Integer.parseInt(data1[0][x]);
								out.print("<tr><td class='boldEleven'> "+titledata1[x]);
								out.print("<td  class='boldEleven' align='right'>"+data1[0][x]);
							}	
						}	
						
					}
					originalgross = originalgross+originalbasic;
					out.print("<tr><td class='boldEleven'><b> Gross Pay");
					out.print("<td  class='boldEleven' align='right'>"+((int)originalgross));
					
					
					
					sql = "Select "+extraallowance+" FROM pay_t_salaryallowance  ";
					sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
					sql = sql+" AND  INT_YEAR ="+Year;
					sql = sql+" AND CHR_MONTH='"+mont+"'";
					
					String data2[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					columncount1 = com.my.org.erp.common.CommonFunctions.intGetColumnCount(sql);
					extraallowancetitle=extraallowancetitle+"";
					String titledata2[] = extraallowancetitle.split(",");
				 
					if(columncount1>1)
					{
						for(int x=0;x<columncount1;x++)
							if((Integer.parseInt(data2[0][x]))>0)
								originalextraallowance = originalextraallowance+Integer.parseInt(data2[0][x]);
						if(originalextraallowance>0)
						{
							out.print("<tr><td class='boldEleven' colspan=2><b> Extra Allowance");
							for(int x=0;x<columncount1;x++)
							{
								if((Integer.parseInt(data2[0][x]))>0)
								{
									out.print("<tr><td class='boldEleven'> "+titledata2[x]);
									out.print("<td  class='boldEleven' align='right'>"+data2[0][x]);
								}	
							}	
							//out.print("<tr><td class='boldEleven'><b>Extras");
							//out.print("<td  class='boldEleven' align='right'>"+((int)originalextraallowance));
						}
					}
					
					
					out.print("<tr><td class='boldEleven'><b>Total");
					out.print("<td  class='boldEleven' align='right'>"+(int)(originalgross+originalextraallowance));

					out.println("</table>");
				  %>				  </td>
                  <td class="boldEleven">&nbsp;</td>
                  <td colspan="2" valign="top" class="boldEleven">
				  <%
				  	sql = " SELECT CHR_RCODE,CHR_RNAME FROM pay_m_recovery ";
					String rname[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					String rallowansql="";
					for(int a=0;a<rname.length;a++)
						rallowansql =rallowansql+rname[a][0]+" , ";
						
					rallowansql=rallowansql.trim();	
					rallowansql = rallowansql.substring(0,rallowansql.length()-1);
					sql= " SELECT "+rallowansql+" FROM pay_t_salary  ";
					sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
					sql = sql+" AND  INT_YEAR ="+Year;
					sql = sql+" AND CHR_MONTH='"+mont+"'";
					String recoverydata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					out.println("<table cellpadding=0 cellspacing=0 width='90%' border=0>");
					out.print("<tr><td class='boldEleven'><b> Deductions");
					out.print("<td  class='boldEleven' align='right'><b> Amount");
					if(rname.length>1)
					{
						for(int u=0;u<rname.length;u++)
						{
						
						 ramount=0.0;
						 ramount=Double.parseDouble(recoverydata[0][u]);	
						 if(ramount>0)
						 {
							out.print("<tr><td class='boldEleven'>"+rname[u][1]);
							out.print("<td  class='boldEleven' align='right'>"+Integer.parseInt(recoverydata[0][u]));
							deduction=deduction+ramount;
						 }	
						}
					}	
					if(advance>0)
					{
						out.print("<tr><td class='boldEleven'>Advance");
						out.print("<td  class='boldEleven' align='right'>"+(int)advance);
					}
					deduction=deduction+advance;
					out.print("<tr><td class='boldEleven'>PF");
					out.print("<td  class='boldEleven' align='right'>"+(int)pf);
					deduction=deduction+pf;
					out.print("<tr><td class='boldEleven'>ESI");
					out.print("<td  class='boldEleven' align='right'>"+(int)esi);
					deduction=deduction+esi;
					
					out.print("<tr><td class='boldEleven'>Tax Deduction");
					out.print("<td  class='boldEleven' align='right'>"+(int)taxvalue);
					deduction=deduction+taxvalue;
					out.print("<tr><td class='bolddeeplogin'>Loss of pay ");
					out.print("<td  class='boldEleven' align='right'>"+(int)(originalgross-earninggross));
					
					out.print("<tr><td class='bolddeeplogin'>Total deductions ");
					out.print("<td  class='boldEleven' align='right'>"+(int)(deduction+(originalgross-earninggross)));
												
					out.println("</table>");
				  %>				  </td>
                </tr>
                <tr>
                  <td class="boldEleven"></td>
                  <td class="boldEleven"><div align="right"><span class="bolddeeplogin">Net
                    Amount </span></div></td>
                  <td class="boldEleven">&nbsp;</td>
                  <td class="boldEleven"><%=(int)((earninggross-deduction)+extraallowances)%></td>
                  <td class="boldEleven">&nbsp;</td>
                </tr>
            </table></td>
          </tr>
          <tr>
            <td colspan="3" class="boldEleven"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td valign="top" class="bolddeeplogin"><hr width="100%" size=1>
                  </td>
                </tr>
                <tr>
                  <td class="bolddeeplogin"><div id="Rupees" align="center"><script
							language="javascript">
					  	numberWord("<%=(int)((earninggross-deduction)+extraallowances)%>","Rupees") 
					                  </script></div></td>
                </tr>
                <tr>
                  <td class="bolddeeplogin"><hr width="100%" size=1>
                  </td>
                </tr>
                <tr>
                  <td class="bolddeeplogin"><div align="center" class="bolddeepblue" id="Rupees">
                      <div align="center">
					   <%
					  	sql = " SELECT CHR_PAYSLIP_FOOTER from pay_m_basicsettings ";
					 	String footerDetails[][]= CommonFunctions.QueryExecute(sql);
						out.println(""+footerDetails[0][0]);
					  %>
					  </div>
                  </div></td>
                </tr>
                <tr>
                  <td class="boldEleven"><div align="center"><strong> * Payslip generated by
                    salary package, does not require any signature. </strong></div></td>
                </tr>
            </table></td>
          </tr>
        </table>
      
    </td>
  </tr>
</table>
<p align="center">
  <br>
  
  <%
		 }
		 else
		 {
		 	out.println("Data not found...");
		 }
	}
   
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%> 

   <a href='javascript:window.print()'>Print</a></p>
</body>
</html>

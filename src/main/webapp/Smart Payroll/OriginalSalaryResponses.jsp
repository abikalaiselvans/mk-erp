<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*,com.my.org.erp.Math.*"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ taglib uri="/WEB-INF/displaytag.tld" prefix="display" %>
<%@ page import="java.util.*"%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
  
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*"%><head>
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
 
<title> :: PAYROLL ::</title>


 
  
 
<style type="text/css" media="all">
      @import url("../JavaScript/css/maven-base.css");
      @import url("../JavaScript/css/maven-theme.css");
      @import url("../JavaScript/css/site.css");
      @import url("../JavaScript/css/screen.css");
  </style> 
</head>


<title> :: PAYROLL ::</title>


  

<br>
<br>


<%
try
{


 	String  company  = request.getParameter("company");
	String  branch  = request.getParameter("branch");
	String  Office  = request.getParameter("Office");
	String Dept= request.getParameter("Dept");
	String orderby= request.getParameter("orderby");
	String Category=request.getParameter("Category");
	String resigned= request.getParameter("resigned");
	String sql ="";
	
	String allowancefield[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME,CHR_FLAG FROM  pay_m_allowance ORDER BY INT_ALLOWANCEID");
	String sumgrossallowancefield="";
	String sumothersallowancefield="";
	String allowancefields="";
	if(allowancefield.length>0)
	{
		for(int u=0;u<allowancefield.length;u++)
		{
			if("Y".equals(allowancefield[u][2]))
				sumgrossallowancefield =sumgrossallowancefield+ " o."+allowancefield[u][0]+"+";
			else
				sumothersallowancefield =sumothersallowancefield+ " o."+allowancefield[u][0]+"+";
				
			allowancefields =allowancefields+ " o."+allowancefield[u][0]+",";
		}
 	}
	
	
	 
	 
	String recoveryfield[][] = CommonFunctions.QueryExecute("SELECT CHR_RCODE,CHR_RNAME  FROM  pay_m_recovery ORDER BY INT_RECOVERYID");
	String sumrecoveryfield="";
	String recoveryfields="";
	if(recoveryfield.length>0)
	{
		for(int u=0;u<recoveryfield.length;u++)
		{
			sumrecoveryfield =sumrecoveryfield+ " p."+recoveryfield[u][0]+"+";
			recoveryfields =recoveryfields+ " p."+recoveryfield[u][0]+",";
			
		}
 	}
	

//int toalfields = 52+allowancefield.length+1+1+1+recoveryfield.length+1;	



			
	
sql = sql + " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,g.CHR_COMPANYNAME,f.CHR_BRANCHNAME,c.CHR_DEPARTNAME,i.CHR_DESIGNAME,b.CHR_OFFICENAME , ";
sql = sql + " q.CHR_CATEGORYNAME, a.INT_SALARY, ";
sql = sql + allowancefields ;
sql = sql + " ( " +sumgrossallowancefield +" 0 ) , " ;
sql = sql + " ( " +sumothersallowancefield +" 0 ) , " ;
sql = sql + " ( a.INT_SALARY +" +sumgrossallowancefield +" 0 ) , " ; 
sql = sql + recoveryfields;
sql = sql + " ( " +sumrecoveryfield +" 0 ) , " ; 
sql = sql + " a.CHR_PF ,CONCAT(g.CHR_PFNUMBER,a.CHR_PFNO), ";
sql = sql + " a.CHR_ESI ,a.CHR_ESINO,  ";
sql = sql + " a.CHR_GENDER, DATE_FORMAT(a.DT_DOB,'%d-%b-%Y'),DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),a.CHR_MARITALSTATUS, ";
sql = sql + " DATE_FORMAT(a.DT_WEDDATE,'%d-%b-%Y'), e.CHR_QUALIFICATIONNAME ,j.CHR_GROUPNAME,  ";

 
sql = sql + " FUN_GET_ADDRESS(a.CHR_EMPID,'P',','), ";
sql = sql + " FUN_GET_ADDRESS(a.CHR_EMPID,'C',','), ";

 
sql = sql + " a.CHR_EMAILID, a.CHR_MOBILE,   ";
sql = sql + " FIND_A_BANKNAME_NAME(h.INT_BANKID),CONCAT('A/c : ',a.CHR_ACCNO)  ,   ";//round(datediff(now(),a.DT_DOJCOLLEGE)/365)
sql = sql +"   FLOOR(PERIOD_DIFF(EXTRACT(YEAR_MONTH FROM NOW()),EXTRACT(YEAR_MONTH FROM a.DT_DOJCOLLEGE))/ 12)";
sql = sql + " FROM com_m_staff a , com_m_office b ,com_m_depart c ,pay_t_allowance d , ";
sql = sql + " com_m_qualification e , com_m_branch f , com_m_company g, com_m_bank h , ";
sql = sql + " com_m_desig i,com_m_bloodgroup j,  ";
 
sql = sql + " pay_t_allowance o ,pay_t_recovery p ,com_m_employeecategory q ";
sql = sql + " WHERE a.INT_DEPARTID = c.INT_DEPARTID   AND a.CHR_TYPE!='T'   AND a.CHR_HOLD !='Y'   ";
sql = sql + " AND a.INT_OFFICEID= b.INT_OFFICEID  ";
sql = sql + " AND a.CHR_EMPID =d.CHR_EMPID  ";
sql = sql + " AND a.CHR_QUALIFICATION =e.INT_QUALIFICATIONID  ";
sql = sql + " AND a.INT_BRANCHID =f.INT_BRANCHID  ";
sql = sql + " AND a.INT_COMPANYID =g.INT_COMPANYID  ";
sql = sql + " AND a.CHR_BANK =h.INT_BANKID  ";
sql = sql + " AND a.INT_DESIGID= i.INT_DESIGID  ";
sql = sql + " AND a.CHR_BG=j.INT_BLOODGROUPID  ";
 
sql = sql + " AND a.CHR_EMPID =p.CHR_EMPID  ";
sql = sql + " AND a.CHR_EMPID =o.CHR_EMPID  ";
sql = sql + " AND a.CHR_CATEGORY= q.INT_EMPLOYEECATEGORYID ";
if(!"0".equals(Office))
	sql = sql + " AND a.INT_OFFICEID="+Office;
if(!"0".equals(Dept))
	sql = sql + " AND a.INT_DEPARTID= "+Dept;

if(!"0".equals(Category))
	sql = sql + "  AND a.CHR_CATEGORY='"+Category +"' ";
	
if(!"Y".equals(resigned))
	sql = sql + "   AND a.CHR_TYPE!='T'";

//sql = sql + "   AND a.CHR_EMPID ='ADMIN'";			
sql = sql + " ORDER BY  "+orderby;
out.println(sql);
 
	String Data[][] =CommonFunctions.QueryExecute(sql);
	
	String bsql="SELECT INT_PFAMT,INT_ESIAMT,INT_CPY_PFAMT,INT_CPY_PENSIONAMT,INT_CPY_ESIAMT,INT_PFLIMITMINIMUM ,  INT_PFLIMIT,INT_ESILIMIT FROM m_institution WHERE INT_ID=1";
		String basicdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(bsql);
		
		double pf=Double.parseDouble(basicdata[0][0]);
		double esi=Double.parseDouble(basicdata[0][1]);
		double cpypf=Double.parseDouble(basicdata[0][2]);
		double cpypension=Double.parseDouble(basicdata[0][3]);
		double cpyesi=Double.parseDouble(basicdata[0][4]);
		double dbminimumpflimit=Double.parseDouble(basicdata[0][5]);
		double dbpmaximumflimit=Double.parseDouble(basicdata[0][6]);
		double dbesilimit=Double.parseDouble(basicdata[0][7]);

		String pftype="";
		double basic=0.0;
		double gross=0.0;
		double pfValue=0;
		double CompanyPF1=0;
		double CompanyPF2=0;
		String esitype ="";
		double esiValue=0.0;
		double CompanyESI=0.0;
		double recovery=0.0;
		
		Vector mn = new Vector();
	 	Vector child= null;
		for(int u=0;u<Data.length;u++)
		{
			basic=0.0;
			gross=0.0;
			pfValue=0.0;
			CompanyPF1=0;
			CompanyPF2=0;
			pftype="";
			esitype ="";
			esiValue=0.0;
			CompanyESI=0.0;
			recovery=0.0;
			child = new Vector();
			child.addElement((u+1));
			child.addElement(Data[u][0]);
			child.addElement(Data[u][1]);
			child.addElement(Data[u][2]);
			child.addElement(Data[u][3]);
			child.addElement(Data[u][4]);
			child.addElement(Data[u][5]);
			child.addElement(Data[u][6]);
			child.addElement(Data[u][7]);
			child.addElement(Data[u][8]);
			child.addElement(Data[u][9]);
			child.addElement(Data[u][10]);
			child.addElement(Data[u][11]);
			child.addElement(Data[u][12]);
			child.addElement(Data[u][13]);
			child.addElement(Data[u][14]);
			child.addElement(Data[u][15]);
			child.addElement(Data[u][16]);
			child.addElement(Data[u][17]);
			child.addElement(Data[u][18]);
			child.addElement(Data[u][19]);
			child.addElement(Data[u][20]);
			child.addElement(Data[u][21]);
			child.addElement(Data[u][22]);
			child.addElement(Data[u][23]);
			child.addElement(Data[u][24]);
			child.addElement(Data[u][25]);
			child.addElement(Data[u][26]);
			child.addElement(Data[u][27]);
			child.addElement(Data[u][28]);
			child.addElement(Data[u][29]);
			child.addElement(Data[u][30]);
			child.addElement(Data[u][31]);
			child.addElement(Data[u][32]);
			child.addElement(Data[u][33]);
			child.addElement(Data[u][34]);
			child.addElement(Data[u][35]);
			child.addElement(Data[u][36]);
			 
			if("C".equals(Data[u][37]))
				child.addElement("COMMON");
			else if("Y".equals(Data[u][37]))
				child.addElement("YES");
			else if("N".equals(Data[u][37]))
				child.addElement("NO");
				
			child.addElement(Data[u][38] );
			
			
			
			//PF CALCULATION 
			basic=Double.parseDouble(Data[u][9]);
			pftype=Data[u][37];
			
			if (!pftype.equals("N"))
			{	
				 if (pftype.equals("C"))
				{
					
					if((basic<dbpmaximumflimit) && (basic>dbminimumpflimit))//65000 , 3200
					{
						pfValue = basic * pf / 100;
						CompanyPF1=(double)(basic)*(cpypension/100);
						CompanyPF2=(double)(basic)*(cpypf/100);
						 
						
					}
					else if(basic>=dbpmaximumflimit) 
					{
						pfValue = dbpmaximumflimit * pf / 100;
						CompanyPF1=(double)(dbpmaximumflimit)*(cpypension/100);
						CompanyPF2=(double)(dbpmaximumflimit)*(cpypf/100);
						 
						
						
					}
					else
					{
						pfValue = dbminimumpflimit * pf / 100;
						CompanyPF1=(double)(dbminimumpflimit)*(cpypension/100);
						CompanyPF2=(double)(dbminimumpflimit)*(cpypf/100);
						 
						
						
					}
					 
				}
				else
				{
					pfValue=0;
					CompanyPF1=0;
					CompanyPF2=0;
				}
			}
			else
			{
				pfValue=0;
				CompanyPF1=0;
				CompanyPF2=0;
			}
			
			child.addElement(CommonFunctions.keep2Digit(pfValue) );	
			
			
			
			if("C".equals(Data[u][39]))
				child.addElement("COMMON");
			else if("Y".equals(Data[u][39]))
				child.addElement("YES");
			else if("N".equals(Data[u][39]))
				child.addElement("NO");
				
			 
			child.addElement(Data[u][40]  );	
			
			
			
			
			
			
			//ESI CALCULATION 
			gross=Double.parseDouble(Data[u][27]);
			recovery=Double.parseDouble(Data[u][36]);
			esitype =Data[u][39];
			
			if (!esitype.equals("N")) 
					{
						
						 
						if (esitype.equals("C"))
						{	
							if(gross>dbesilimit)//grosspay >=10001
							{	
								esiValue = 0;
								CompanyESI=0;
								 
							}	
							else
							{	
								esiValue =  gross  * esi / 100;
								CompanyESI=(double)(gross)*(cpyesi/100);
								 
							}	
						}
						else
						{
							esiValue=0;
							CompanyESI=0;
							 
						}
					}
					else
					{
						esiValue=0;
						CompanyESI=0;
						 
					}
					 
			
			child.addElement(CommonFunctions.keep2Digit(esiValue));	
			
			
			
			
			
			//	Employer PensionFund 
			child.addElement(CommonFunctions.keep2Digit(CompanyPF1));	
			//Employer PF 
			child.addElement(CommonFunctions.keep2Digit(CompanyPF2));
			
			
			//Employer ESI 
			child.addElement(CommonFunctions.keep2Digit(CompanyESI));
			
			
			
			
			//Total Salary 
			child.addElement(CommonFunctions.keep2Digit(gross-(pfValue+esiValue+recovery)) );	
			
			
			
			//CTC 
			child.addElement(CommonFunctions.keep2Digit(gross+pfValue+CompanyESI) );
			 
			 
				
			child.addElement(Data[u][41] );	
			child.addElement(Data[u][42] );	
			child.addElement(Data[u][43]  );
			if("M".equals(Data[u][44]))
				child.addElement("MARRIED");
			else
				child.addElement("UNMARRIED");
			
			child.addElement(Data[u][45] );	
			child.addElement(Data[u][46]);	
			child.addElement(Data[u][47] );	
			child.addElement(Data[u][48] );	
			child.addElement(Data[u][49] );
			child.addElement(Data[u][50]);	
			child.addElement(Data[u][51]);	
			
			child.addElement(Data[u][52]);	
			child.addElement(Data[u][53]);	
			child.addElement(Data[u][54] +"-Yrs");	 
			mn.add(child);
			
			 
		}
     
     
   
	 
	request.setAttribute("table",mn);
	out.println("<br><center><h3> PERSONAL INFORMATIONS AND GROSS DETAILS </h3></center><br>");
 
%>
 
<display:table   id="_table" name="table"   export="true" pagesize="25">
	 
	 				<display:setProperty name="basic.empty.showtable" value="true"/><%Vector temp= (Vector)_table;%>
					<display:column title="S.No" sortable="true"><%=temp.elementAt(0)%></display:column>
					<display:column title="Employee Id" sortable="true"><%=temp.elementAt(1)%></display:column>
					<display:column title="Employee Name" sortable="true"><%=temp.elementAt(2)%></display:column>
					<display:column title="Father Name" sortable="true"><%=temp.elementAt(3)%></display:column>
					<display:column title="Company" sortable="true"><%=temp.elementAt(4)%></display:column>
					<display:column title="Branch" sortable="true"><%=temp.elementAt(5)%></display:column>
					<display:column title="Department" sortable="true"><%=temp.elementAt(6)%></display:column>
					<display:column title="Designation" sortable="true"><%=temp.elementAt(7)%></display:column>
					<display:column title="Office" sortable="true"><%=temp.elementAt(8)%></display:column>
					<display:column title="Category" sortable="true"><%=temp.elementAt(9)%></display:column>
				    <display:column title="Basic" sortable="true"><%=temp.elementAt(10)%></display:column>
					<%
					 for(int a=0;a<allowancefield.length;a++)
					 {
					 %>
					 <display:column title="<%=""+allowancefield[a][1]%>" sortable="true"><%=temp.elementAt(10+(a+1))%></display:column>
					 <%
					 }
					 int col=10+allowancefield.length;
					%>
					 
					<display:column title="SUM1 (gross allowance)" sortable="true"><%=temp.elementAt(col+1)%></display:column>
					<display:column title=" REIMBURSEMENT" sortable="true"><%=temp.elementAt(col+2)%></display:column>
					<display:column title="GROSS" sortable="true"><%=temp.elementAt(col+3)%></display:column>
					
					 
					<%
					 col=10+allowancefield.length+3;
					 System.out.println("------------------"+temp.elementAt(1));
					 for(int a=0;a<recoveryfield.length;a++)
					 {
					 %>
					 <display:column title="<%=""+recoveryfield[a][1]%>" sortable="true"><%=temp.elementAt(col+(a+1))%></display:column>
					 <%
					 }
					 col=10+allowancefield.length+3+recoveryfield.length;
					%>
					
					<display:column title="Revoery sum" sortable="true"><%=temp.elementAt(col+1)%></display:column>
					
					<display:column title="PF Type" sortable="true"><%=temp.elementAt(col+2)%></display:column>
					<display:column title="PF Number" sortable="true"><%=temp.elementAt(col+3)%></display:column>
					<display:column title="PF AMOUNT" sortable="true"><%=temp.elementAt(col+4)%></display:column>
					
					<display:column title="ESI Type" sortable="true"><%=temp.elementAt(col+5)%></display:column>
					<display:column title="ESI Number" sortable="true"><%=temp.elementAt(col+6)%></display:column>
					<display:column title="ESI AMOUNT" sortable="true"><%=temp.elementAt(col+7)%></display:column>
					
					<display:column title="Employer PensionFund" sortable="true"><%=temp.elementAt(col+8)%></display:column>
					<display:column title="Employer PF" sortable="true"><%=temp.elementAt(col+9)%></display:column>
					<display:column title="Employer ESI" sortable="true"><%=temp.elementAt(col+10)%></display:column>
					
					<display:column title="Total Salary" sortable="true"><%=temp.elementAt(col+11)%></display:column>
					<display:column title="CTC" sortable="true"><%=temp.elementAt(col+12)%></display:column>
					
		 			
					
					
					<display:column title="GENDER" sortable="true"><%=temp.elementAt(col+13)%></display:column>
					<display:column title="DOB" sortable="true"><%=temp.elementAt(col+14)%></display:column>
					<display:column title="DOJ" sortable="true"><%=temp.elementAt(col+15)%></display:column>
					<display:column title="MARTIAL STATUS" sortable="true"><%=temp.elementAt(col+16)%></display:column>
					<display:column title="WEDDING DATE" sortable="true"><%=temp.elementAt(col+17)%></display:column>
					<display:column title="QUALIFICATION" sortable="true"><%=temp.elementAt(col+18)%></display:column>
					<display:column title="BLOOD" sortable="true"><%=temp.elementAt(col+19)%></display:column>
					<display:column title="Permanent Address " sortable="true"><%=temp.elementAt(col+20)%></display:column>
					<display:column title="Communication Address" sortable="true"><%=temp.elementAt(col+21)%></display:column>
					<display:column title="MAIL" sortable="true"><%=temp.elementAt(col+22)%></display:column>
					<display:column title="MOBILE" sortable="true"><%=temp.elementAt(col+23)%></display:column>
					
					<display:column title="BANK" sortable="true"><%=temp.elementAt(col+24)%></display:column>
					<display:column title="BANK" sortable="true"><%=temp.elementAt(col+25)%></display:column>
					
					<display:setProperty name="export.csv.filename" value="Rept_OriginalSalary.csv"/>
					<display:setProperty name="export.excel.filename" value="Rept_OriginalSalary.xls"/>
					<display:setProperty name="export.xml.filename" value="Rept_OriginalSalary.xml"/>
					<display:setProperty name="export.pdf.filename" value="Rept_OriginalSalary.pdf"/>
					<display:setProperty name="export.pdf" value="true" />
					 
</display:table>     

<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
 %>
 
 <br>
 <br />	<center>	<a href='OriginalSalary.jsp'> CLOSE</a></center>

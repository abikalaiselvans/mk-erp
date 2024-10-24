 <%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*,com.my.org.erp.common.*,com.my.org.erp.Math.*"%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>


<title> :: PAYROLL ::</title>


  
<%@ include file="index.jsp"%>
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
	
	String off="";
	String dep="";
	String cat="";
	if(!"0".equals(Office))
		off=" AND a.INT_OFFICEID="+Office;
	if(!"0".equals(Dept))
		dep=" AND a.INT_DEPARTID= "+Dept;
	
	if(!"0".equals(Category))
 		cat = " AND a.CHR_CATEGORY='"+Category +"' ";
	String resigned= request.getParameter("resigned");
	String resgsql="";
	if(!"Y".equals(resigned))
		resgsql=" AND a.CHR_TYPE!='T'";
	else
		resgsql="";	
		
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
	
	con=conbean.getConnection();
	String bsql="SELECT INT_PFAMT,INT_ESIAMT,INT_CPY_PFAMT,INT_CPY_PENSIONAMT,INT_CPY_ESIAMT,CHR_SALARY,INT_PFLIMIT,INT_ESILIMIT FROM m_institution WHERE INT_ID=1";
	String basicdata[][] = com.my.org.erp.common.CommonFunctions.RecordSetArray(con, bsql);
	double staffpf=Double.parseDouble(basicdata[0][0]);
	double staffesi=Double.parseDouble(basicdata[0][1]);
	double cpypf=Double.parseDouble(basicdata[0][2]);
	double cpypension=Double.parseDouble(basicdata[0][3]);
	double cpyesi=Double.parseDouble(basicdata[0][4]);
	double dbpflimit=Double.parseDouble(basicdata[0][6]);
	double dbesilimit=Double.parseDouble(basicdata[0][7]);
			
	
	

	
	//staffpf,staffesi,cpypf,cpypension,cpyesi
	
	//Allowance 
	sql = "SELECT CHR_ACODE,CHR_ANAME,CHR_FLAG FROM pay_m_allowance  ORDER BY INT_ALLOWANCEID";
	String aname[][] = com.my.org.erp.common.CommonFunctions.RecordSetArray(con,sql);
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
		
		
		
		 
		 
	//Recovery
 	sql = "SELECT CHR_RCODE,CHR_RNAME FROM pay_m_recovery ORDER BY INT_RECOVERYID";
 	String rname[][] = com.my.org.erp.common.CommonFunctions.RecordSetArray(con,sql);
 	for(int a=0;a<rname.length;a++)
	{
		recovery =recovery+rname[a][0]+",";
		recoverytitle=recoverytitle+rname[a][1]+",";
		recsum=recsum+rname[a][0]+"+";
	}
 	
	recovery = recovery.trim();
	recovery = recovery.substring(0,recovery.length()-1);
	recoverytitle = recoverytitle.trim();
	recoverytitle = recoverytitle.substring(0,recoverytitle.length()-1);
	recsum = recsum.trim();
	recsum = recsum.substring(0,recsum.length()-1);
	
	 
 	
	
		 
		 
		
	 
	
	String title="";
	title = title+"S.No,Empid,Name, Company, Office, Department,Designation,Category,Basic,";
	title = title+addedallowancetitle+",SUM1,"+extraallowancetitle+",SUM2,GROSSPAY,"+recoverytitle+",Recovery Sum,PF Number,PF, ESI Number,ESI,Employer PF,Employer PensionFund,Employer ESI,Total Salary,CTC,Fathername,Bloodgroup,Mobile,Emailid,Permanent Address,Communication Add,Date of Join,Date of Birth,Gender,Qualification,Experience(Yrs),Bank,Account Number,PF Date of Joinning,";
	 
	sql=" SELECT a.CHR_EMPID,a.CHR_STAFFNAME,b.CHR_COMPANYNAME,d.CHR_OFFICENAME,c.CHR_DEPARTNAME,h.CHR_DESIGNAME,i.CHR_CATEGORYNAME, a.INT_SALARY,";
	sql = sql + " a.CHR_PF,a.CHR_ESI,a.CHR_STAFFFNAME,j.CHR_GROUPNAME,a.CHR_MOBILE,a.CHR_EMAILID, ";
	sql = sql + " a.CHR_PADD1,a.CHR_PADD2,a.CHR_PCITY,e.CHR_STATENAME,a.CHR_PPIN, ";
	sql = sql + " a.CHR_SADD1,a.CHR_SADD2,a.CHR_SCITY,e.CHR_STATENAME,a.CHR_SPIN, ";
	sql = sql + " DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),DATE_FORMAT(a.DT_DOB ,'%d-%b-%Y'),a.CHR_GENDER,f.CHR_QUALIFICATIONNAME";
	sql = sql + " ,round(datediff(now(),a.DT_DOJCOLLEGE)/365) ,a.CHR_TYPE,FIND_A_BANKNAME_NAME(g.INT_BANKID),CONCAT('A/c:',a.CHR_ACCNO) ,";
	sql = sql + "   a.CHR_PFNO,a.CHR_ESINO, DATE_FORMAT(a.DAT_PFESIDATE,'%d-%b-%Y') FROM com_m_staff a, com_m_company b ,com_m_depart c , com_m_office  d , com_m_state e,com_m_qualification f  ";
	sql = sql + " ,com_m_bank g  ,com_m_desig h , com_m_employeecategory  i,com_m_bloodgroup j WHERE  A.CHR_HOLD!='Y'   "+resgsql;
	sql = sql + " AND a.INT_COMPANYID=b.INT_COMPANYID   ";
	sql = sql + " AND a.INT_OFFICEID = d.INT_OFFICEID  ";
	sql = sql + " ANd a.INT_DEPARTID = c.INT_DEPARTID   AND a.INT_DESIGID = h.INT_DESIGID ";
	sql = sql + " AND a.INT_STATEID = e.INT_STATEID AND a.CHR_CATEGORY = i.INT_EMPLOYEECATEGORYID ";
	sql = sql + " AND f.INT_QUALIFICATIONID = a.CHR_QUALIFICATION  AND a.CHR_BANK = g.INT_BANKID AND a.CHR_BG= j.INT_BLOODGROUPID";
	sql = sql +off;
	sql = sql +dep;
	sql = sql +cat;
	sql = sql+" ORDER BY  "+orderby;
	//out.println(sql);
	
	
	String data[][] = com.my.org.erp.common.CommonFunctions.RecordSetArray(con,sql);
	 
	String repdata[]=title.split(",");
	/*
	out.println("<tr bgcolor='#ffffff'>");
			for(int x=0;x<repdata.length;x++)
				out.println("<td class=\"boleEleven\"><b>"+repdata[x]);
	*/			
	out.println("<center> <table id='myTable'  cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
	if(data.length>0)
	{
		
		out.println("<tr bgcolor='#ffffff'>");
			for(int x=0;x<repdata.length;x++)
				out.println("<td class=\"boleEleven\"><b>"+repdata[x]);
	
		
		String empid="";
		String name="";
		String cpyname="";
		String office="";
		String dept="";
		String pftype="";
		double pfValue=0;
		String esitype="";
		double esiValue=0;
		double basic=0;
		int columncount1=0;
		int addedallowancegpay=0;
		int extraallowancesum=0;
		double grosspay=0;
		int recoverysum=0;
		boolean aflag =false;
		boolean aflag1 =false;
		boolean rflag =false;
		double CompanyPF1=0;
		double CompanyPF2 =0;
		double CompanyESI=0;
		double ctc=0;
		for(int a=0;a<data.length;a++)
		{
			basic=0;
			columncount1=0;
			addedallowancegpay=0;
			extraallowancesum=0;
			recoverysum=0;
			grosspay=0;
			aflag =false;
			aflag1 =false;
			rflag =false;
			pftype="";
			pfValue=0;
			esitype="";
			esiValue=0;
			CompanyPF1=0;
			CompanyPF2=0;
			CompanyESI=0;
			ctc=0;
			if(!"T".equals(data[a][28]))
				out.println("<tr bgcolor='#FFFFFF'>");
			else	
				out.println("<tr bgcolor='#CCCCCC'>");
			out.println("<td class='boldEleven'>"+(a+1));
			out.println("<td class='boldEleven'>"+data[a][0]);
			out.println("<td class='boldEleven'>"+data[a][1]);
			out.println("<td class='boldEleven'>"+data[a][2]);
			out.println("<td class='boldEleven'>"+data[a][3]);
			out.println("<td class='boldEleven'>"+data[a][4]);
			out.println("<td class='boldEleven'>"+data[a][5]);
			out.println("<td class='boldEleven'>"+data[a][6]);
			out.println("<td class='boldEleven' align='right'>"+data[a][7]);
			basic =  Double.parseDouble(data[a][7]);
			
			sql = "SELECT count(*) FROM pay_t_allowance WHERE CHR_EMPID='"+data[a][0]+"'";
			aflag= com.my.org.erp.common.CommonFunctions.RecordExist(con,sql);
			sql = "SELECT "+addedallowance+" FROM pay_t_allowance WHERE CHR_EMPID='"+data[a][0]+"'";
			String addedallowancedata[][] = com.my.org.erp.common.CommonFunctions.RecordSetArray(con,sql);
			columncount1 = com.my.org.erp.common.CommonFunctions.intGetColumnCount(con,sql);
			if(aflag)
			{
				for(int x=0; x<columncount1;x++)
				{
					out.println("<td class='boldEleven' align=right>"+addedallowancedata[0][x]);
					addedallowancegpay = addedallowancegpay+Integer.parseInt(addedallowancedata[0][x]);
				}	
			}
			else
			{
				for(int x=0; x<columncount1;x++)
					out.println("<td class='boldEleven' align=right>0");
				addedallowancegpay=0;	
			}
			out.println("<td class='boldEleven' align=right>"+addedallowancegpay);
			
			
			sql = "SELECT count(*) FROM pay_t_allowance WHERE CHR_EMPID='"+data[a][0]+"'";
			aflag= com.my.org.erp.common.CommonFunctions.RecordExist(con,sql);
			sql = "SELECT "+extraallowance+" FROM pay_t_allowance WHERE CHR_EMPID='"+data[a][0]+"'";
			String extraallowancedata[][] = com.my.org.erp.common.CommonFunctions.RecordSetArray(con,sql);
			columncount1 = com.my.org.erp.common.CommonFunctions.intGetColumnCount(con,sql);
			if(aflag)
			{
				for(int x=0; x<columncount1;x++)
				{
					out.println("<td class='boldEleven' align=right>"+extraallowancedata[0][x]);
					extraallowancesum = extraallowancesum+Integer.parseInt(extraallowancedata[0][x]);
				}	
			}
			else
			{
				for(int x=0; x<columncount1;x++)
					out.println("<td class='boldEleven' align=right>0");
				extraallowancesum=0;	
			}
			out.println("<td class='boldEleven' align=right>"+extraallowancesum);
			
			
			grosspay = Double.parseDouble(data[a][7])+addedallowancegpay;
			out.println("<td class='boldEleven' align=right>"+grosspay);
			
			sql = "SELECT count(*) FROM pay_t_recovery WHERE CHR_EMPID='"+data[a][0]+"'";
			rflag= com.my.org.erp.common.CommonFunctions.RecordExist(con,sql);
			sql = "SELECT "+recovery+" FROM pay_t_recovery WHERE CHR_EMPID='"+data[a][0]+"'";
			String recoverydata[][] = com.my.org.erp.common.CommonFunctions.RecordSetArray(con,sql);
			columncount1 = com.my.org.erp.common.CommonFunctions.intGetColumnCount(con,sql);
			if(rflag)
			{
				for(int x=0; x<columncount1;x++)
				{
					out.println("<td class='boldEleven' align=right>"+recoverydata[0][x]);
					recoverysum = recoverysum+Integer.parseInt(recoverydata[0][x]);
				}	
			}
			else
			{
				for(int x=0; x<columncount1;x++)
					out.println("<td class='boldEleven' align=right>0");
				recoverysum=0;	
			}
			out.println("<td class='boldEleven' align=right>"+recoverysum);
			
			pftype=data[a][8];
			esitype=data[a][9];
			
			//staffpf,staffesi,cpypf,cpypension,cpyesi
			//PF Calculations
			if (pftype.equals("C") || esitype.equals("C")) 
			{
					if (pftype.equals("C")) 
					{
						pfValue =  staffpf;
						pftype = "P";
					}
					if (esitype.equals("C")) 
					{
						esiValue =  staffesi;
						esitype = "P";
					}
			}
			
			
			if (!pftype.equals("N")) 
				if (pftype.equals("P"))
				{	
					
					
					if(basic<dbpflimit)
					{
						pfValue = basic * pfValue / 100;
						CompanyPF1=(double)(basic)*(cpypension/100);
						CompanyPF2=(double)(basic)*(cpypf/100);
						
					}	
					else
					{
						pfValue = 6500 * pfValue / 100;
						CompanyPF1=(double)(6500)*(cpypension/100);
						CompanyPF2=(double)(6500)*(cpypf/100);
						
					}	
					
					/*pfValue = basic * pfValue / 100;
					CompanyPF1=(double)(basic)*(cpypension/100);
					CompanyPF2=(double)(basic)*(cpypf/100);
					*/
				}	
	
	
			
			 	if (!esitype.equals("N")) 
				{
					if (esitype.equals("P"))
					{	
						
						
						if(grosspay>dbesilimit)//grosspay >=10001
							{	
								esiValue = 0;
								CompanyESI=0;
								 
							}	
							else
							{	
								esiValue =  grosspay  * esiValue / 100;
								CompanyESI=(double)(grosspay)*(cpyesi/100);
							}
						
						
						
						/*if(grosspay>=10001)//grosspay
						{	
							esiValue = 0;
							CompanyESI=0;
							
						}	
						else
						{	
							esiValue =  grosspay  * esiValue / 100;
							esiValue=Math.round(esiValue);
							CompanyESI=(double)(grosspay)*(cpyesi/100);
							CompanyESI=Math.round(CompanyESI);
							
						}*/
						
							
					}	
				}
				out.println("<td class='boldEleven' align=right>"+data[a][32]);
				out.println("<td class='boldEleven' align=right>"+com.my.org.erp.common.CommonFunctions.Round(pfValue));
				out.println("<td class='boldEleven' align=right>"+data[a][33]);
				out.println("<td class='boldEleven' align=right>"+com.my.org.erp.common.CommonFunctions.Round(esiValue));
				out.println("<td class='boldEleven' align=right>"+com.my.org.erp.common.CommonFunctions.Round(CompanyPF1));
				out.println("<td class='boldEleven' align=right>"+com.my.org.erp.common.CommonFunctions.Round(CompanyPF2));
				out.println("<td class='boldEleven' align=right>"+com.my.org.erp.common.CommonFunctions.Round(CompanyESI));
				
				//CTC Calculation 
				out.println("<td class='boldEleven' align=right>"+(grosspay-(recoverysum+pfValue+esiValue)));
				
				//CTC Calculation 
				out.println("<td class='boldEleven' align=right>"+com.my.org.erp.common.CommonFunctions.Round(grosspay+CompanyPF1+CompanyPF2+CompanyESI));
				//Personal Details
				
				out.println("<td class='boldEleven' align=right>"+data[a][10]);
				out.println("<td class='boldEleven' align=right>"+data[a][11]);
				out.println("<td class='boldEleven' align=right>"+data[a][12]);
				out.println("<td class='boldEleven' align=right>"+data[a][13]);
				out.println("<td class='boldEleven' align=right>"+data[a][14]+",<br>"+data[a][15]+",<br>"+data[a][16]+",<br>"+data[a][17]+",<br>PIN : "+data[a][18]);
				out.println("<td class='boldEleven' align=right>"+data[a][19]+",<br>"+data[a][20]+",<br>"+data[a][21]+",<br>"+data[a][22]+",<br>PIN : "+data[a][23]);
				out.println("<td class='boldEleven' align=right>"+data[a][24]);
				out.println("<td class='boldEleven' align=right>"+data[a][25]);
				out.println("<td class='boldEleven' align=right>"+data[a][26]);
				out.println("<td class='boldEleven' align=right>"+data[a][27]);
				out.println("<td class='boldEleven' align=right>"+data[a][28]);
				out.println("<td class='boldEleven' align=right>"+data[a][30]);
				out.println("<td class='boldEleven' align=right>"+data[a][31]);
				out.println("<td class='boldEleven' align=right>"+data[a][34]);
				//out.println("<td class='boldEleven' align=right>"+data[a][32]);
			
		//out.println(addedallowance+",("+addedsum+")");
		//out.println(extraallowance+",("+extrasum+")");
		//out.println(recovery+",("+recsum+")");
			
		}
	}	
	out.println("</table></center>"); 
	
	 
}
catch(Exception e)
{
}
 %>
 
 <table width="184" align="center" cellpadding="15" cellspacing="0">
	<tr>
		<td width="100" height="44" class="boldEleven"><strong>Export
		</strong></td>
		<td class="boldEleven">
		<div align="center"><a title="Excel" href=javascript:;
			onClick=" CreateExcelSheet()"><img
			src="../Image/report/Excel.png" width="15" height="14" border="0"></a>
		</div>
		</td>

		<td class="boldEleven">
		<div align="center"><a title="Text" href=javascript:;
			onClick="windowSave('Empdetails.txt')"><img
			src="../Image/report/text.gif" width="15" height="14" border="0"></a></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="Document" href=javascript:;
			onClick="windowSave('Empdetails.doc')"><img
			src="../Image/report/MS.GIF" width="15" height="14" border="0"></a></div>
		</td>
		<td class="boldEleven">
		<div align="center"><a title="HTML" href=javascript:;
			onClick="windowSave('Empdetails.html')"><img
			src="../Image/report/IE.GIF" width="15" height="14" border="0"></a></div>
		</td>

	</tr>
</table>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<%@ include file="../footer.jsp"%>
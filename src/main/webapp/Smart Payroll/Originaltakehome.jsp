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
	String bsql="SELECT INT_PFAMT,INT_ESIAMT,INT_CPY_PFAMT,INT_CPY_PENSIONAMT,INT_CPY_ESIAMT,CHR_SALARY FROM m_institution WHERE INT_ID=1";
	String basicdata[][] = com.my.org.erp.common.CommonFunctions.RecordSetArray(con, bsql);
	double staffpf=Double.parseDouble(basicdata[0][0]);
	double staffesi=Double.parseDouble(basicdata[0][1]);
	double cpypf=Double.parseDouble(basicdata[0][2]);
	double cpypension=Double.parseDouble(basicdata[0][3]);
	double cpyesi=Double.parseDouble(basicdata[0][4]);
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
	
	 
 	
	
		 
		 
		
	sql =" SELECT a.CHR_EMPID , a.CHR_STAFFNAME ,b.CHR_COMPANYNAME,d.CHR_OFFICENAME,c.CHR_DEPARTNAME,a.INT_SALARY , ";
	sql = sql + addedallowance +" , ("+addedsum+") ,"+extraallowance+" ,("+extrasum+") ,";
	sql = sql + "( a.INT_SALARY+"+addedsum+" ) ,";
	sql = sql + ""+recovery+" , ("+recsum+")";
	sql = sql + " FROM com_m_staff a, com_m_company b ,com_m_depart c , com_m_office  d  ,pay_t_allowance e, pay_t_recovery f ";
	sql = sql + " WHERE A.CHR_TYPE !='T' AND A.CHR_HOLD!='Y'  ";
	sql = sql + " AND a.INT_COMPANYID=b.INT_COMPANYID   ";
	sql = sql + " AND a.INT_OFFICEID = d.INT_OFFICEID  ";
	sql = sql + " ANd a.INT_DEPARTID = c.INT_DEPARTID  ";
	sql = sql + " AND a.CHR_EMPID = e.CHR_EMPID  ";
	sql = sql + " AND a.CHR_EMPID = f.CHR_EMPID  ";
	sql = sql + " order BY a.CHR_EMPID   ";
	String empdata[][] = com.my.org.erp.common.CommonFunctions.RecordSetArray(con,sql);
	
	String title="";
	title = title+"S.No,Empid,Name, Company, Office, Department,Basic,";
	title = title+addedallowancetitle+",SUM1,"+extraallowancetitle+",SUM2,GROSSPAY,"+recoverytitle+",Recovery Sum,StaffPF,StaffESI,CPY-PF1,CPY-PF2,CPY-ESI,";
	 
	sql=" SELECT a.CHR_EMPID,a.CHR_STAFFNAME,b.CHR_COMPANYNAME,d.CHR_OFFICENAME,c.CHR_DEPARTNAME,a.INT_SALARY,a.CHR_PF,a.CHR_ESI  ";
	sql = sql + " FROM com_m_staff a, com_m_company b ,com_m_depart c , com_m_office  d   ";
	sql = sql + " WHERE A.CHR_TYPE !='T' AND A.CHR_HOLD!='Y'   ";
	sql = sql + " AND a.INT_COMPANYID=b.INT_COMPANYID   ";
	sql = sql + " AND a.INT_OFFICEID = d.INT_OFFICEID  ";
	sql = sql + " ANd a.INT_DEPARTID = c.INT_DEPARTID  ";
	sql = sql + " order BY a.CHR_EMPID   ";
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
			out.println("<tr bgcolor='#FFFFFF'>");
			out.println("<td class='boldEleven'>"+(a+1));
			out.println("<td class='boldEleven'>"+data[a][0]);
			out.println("<td class='boldEleven'>"+data[a][1]);
			out.println("<td class='boldEleven'>"+data[a][2]);
			out.println("<td class='boldEleven'>"+data[a][3]);
			out.println("<td class='boldEleven'>"+data[a][4]);
			out.println("<td class='boldEleven' align='right'>"+data[a][5]);
			basic =  Double.parseDouble(data[a][5]);
			
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
			
			
			grosspay = Double.parseDouble(data[a][5])+addedallowancegpay;
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
			
			pftype=data[a][6];
			esitype=data[a][7];
			
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
					pfValue = basic * pfValue / 100;
					CompanyPF1=(double)(basic)*(cpypension/100);
					CompanyPF1=Math.round(CompanyPF1);
					CompanyPF2=(double)(basic)*(cpypf/100);
					CompanyPF2=Math.round(CompanyPF2);
				}	
	
	
			
			 	if (!esitype.equals("N")) 
				{
					if (esitype.equals("P"))
					{	
						if(grosspay>=10001)//grosspay
						{	
							esiValue = 0;
							CompanyESI=0;
							
						}	
						else
						{	
							esiValue =  grosspay  * esiValue / 100;
							CompanyESI=(double)(grosspay)*(cpyesi/100);
							CompanyESI=Math.round(CompanyESI);
							
						}	
					}	
				}
				out.println("<td class='boldEleven' align=right>"+pfValue);
				out.println("<td class='boldEleven' align=right>"+esiValue);
				out.println("<td class='boldEleven' align=right>"+CompanyPF1);
				out.println("<td class='boldEleven' align=right>"+CompanyPF2);
				out.println("<td class='boldEleven' align=right>"+CompanyESI);
					
				
			
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
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<%@ include file="../footer.jsp"%>
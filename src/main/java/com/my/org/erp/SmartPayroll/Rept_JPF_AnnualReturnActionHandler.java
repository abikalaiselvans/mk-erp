package com.my.org.erp.SmartPayroll;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JasperPrint;
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.SmartReport.ReportFunctions2;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JPF_AnnualReturnActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	String cmpyname="";
	String officename="";
	String deptname="";
	String hImageExpression="";
	String fImageExpression="";
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		System.out.println("Rept_JESIForm_6_3ActionHandler");
		try 
		{ 
			String action = request.getParameter("actionS");
			if (action.equals("PAYRept_JPF_AnnualReturn")) 
			{
				 
				String company=request.getParameter("company");
				String branch = request.getParameter("branch");
				String office = request.getParameter("Office");
				String department = request.getParameter("department");
				String category = request.getParameter("category");
				String rptfilename = request.getParameter("rptfilename");
				String reporttype = request.getParameter("reportType");
				int year=Integer.parseInt(request.getParameter("Year"));
				int year1 = year+1;
	        	   
				asql = " SELECT  a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,g.CHR_COMPANYNAME,f.CHR_BRANCHNAME,b.CHR_OFFICENAME ,h.CHR_CATEGORYNAME, ";
				asql = asql+ " DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y')  ";
				asql = asql+ " FROM com_m_staff a , com_m_office b  , com_m_branch f , com_m_company g ,com_m_employeecategory h ";
				asql = asql+ " WHERE  a.INT_OFFICEID= b.INT_OFFICEID  AND a.CHR_PF='C'";
				asql = asql+ " AND a.INT_BRANCHID =f.INT_BRANCHID "; 
				asql = asql+ " AND a.INT_COMPANYID =g.INT_COMPANYID  ";
				asql = asql+ " AND a.CHR_CATEGORY=h.INT_EMPLOYEECATEGORYID ";
				asql = asql+ " AND a.DT_DOJCOLLEGE <='"+year1+"-02-29' ";
				if(!"0".equals(company))
					asql = asql+ " AND a.INT_COMPANYID = "+company;
				if(!"0".equals(branch))
					asql = asql+ " AND a.INT_BRANCHID = "+branch;
				if(!"0".equals(office))
					asql = asql+ " AND a.INT_OFFICEID = "+office;
				if(!"0".equals(department))
					asql = asql+ " AND a.INT_DEPARTID = "+department;
				if(!"0".equals(category))
					asql = asql+ " AND a.CHR_CATEGORY = "+category;
				asql = asql+ " ORDER BY a.CHR_EMPID  ";
				
			    System.out.println(asql);
			    String data[][]= CommonFunctions.QueryExecute(asql);
			    
			    double p1=0,p2=0,p3=0,p4=0,p5=0,p6=0,p7=0,p8=0,p9=0,p10=0;
			    double p11=0,p12=0,p13=0,p14=0,p15=0,p16=0,p17=0,p18=0,p19=0,p20=0;
			    double p21=0,p22=0,p23=0,p24=0,p25=0,p26=0,p27=0,p28=0,p29=0,p30=0;
			    double p31=0,p32=0,p33=0,p34=0,p35=0,p36=0,p37=0,p38=0,p39=0,p40=0;
			    double p41=0,p42=0,p43=0,p44=0,p45=0,p46=0,p47=0,p48=0,p49=0,p50=0;
			    double p51=0,p52=0,p53=0,p54=0,p55=0,p56=0,p57=0,p58=0,p59=0,p60=0;
			    double p61=0,p62=0,p63=0,p64=0,p65=0,p66=0,p67=0,p68=0,p69=0,p70=0;
			    double p71=0,p72=0,p73=0,p74=0,p75=0,p76=0,p77=0,p78=0,p79=0,p80=0;
			    double p81=0,p82=0,p83=0,p84=0;
			    List<Hashtable> al=new ArrayList<Hashtable>();
			    Hashtable h3 =null;
			     
			    String sql ="";	
	        	if(data.length>0)
	        	{
	        		int y=0;
	        		for(int i=0;i<data.length;i++)
	        		{
	        	    
	        			 
	        			p1=0;p2=0;p3=0;p4=0;p5=0;p6=0;p7=0;p8=0;p9=0;p10=0;
	    			    p11=0;p12=0;p13=0;p14=0;p15=0;p16=0;p17=0;p18=0;p19=0;p20=0;
	    			    p21=0;p22=0;p23=0;p24=0;p25=0;p26=0;p27=0;p28=0;p29=0;p30=0;
	    			    p31=0;p32=0;p33=0;p34=0;p35=0;p36=0;p37=0;p38=0;p39=0;p40=0;
	    			    p41=0;p42=0;p43=0;p44=0;p45=0;p46=0;p47=0;p48=0;p49=0;p50=0;
	    			    p51=0;p52=0;p53=0;p54=0;p55=0;p56=0;p57=0;p58=0;p59=0;p60=0;
	    			    p61=0;p62=0;p63=0;p64=0;p65=0;p66=0;p67=0;p68=0;p69=0;p70=0;
	    			    p71=0;p72=0;p73=0;p74=0;p75=0;p76=0;p77=0;p78=0;p79=0;p80=0;
	    			     p81=0;p82=0;p83=0;p84=0;
	        			//March
	        			sql =" SELECT ROUND(b.DOU_BASIC,2),ROUND(b.DOU_PENBASIC,2),ROUND(b.DOU_COMPANYPF,2),ROUND(b.DOU_COMPANYPENSION,2),ROUND(b.DOU_ADMINCHARGE,2),ROUND(b.DOU_EDLI,2),ROUND(b.DOU_ADMINCHARGE1,2)  ";
	    				sql = sql +" FROM com_m_staff a, pay_t_salary b  ";
	    				sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
	    				sql = sql +" AND a.CHR_EMPID =   '"+data[i][0]+"' " ;
	    				sql = sql +" AND b.CHR_MONTH IN('March')  ";
	    				sql = sql +" AND b.INT_YEAR="+year    ;
	        			String data1[][]= CommonFunctions.QueryExecutecon(con, sql);
	        	    	if(data1.length>0)
	        	    	{
	        	    		if(!data1[0][0].equals("") || !data1[0][0].equals("-"))
			        			p1=Double.parseDouble(data1[0][0]);
			        		
	        	    		if(!data1[0][1].equals("") || !data1[0][1].equals("-"))
			        			p2=Double.parseDouble(data1[0][1]);
			        		
	        	    		if(!data1[0][2].equals("") || !data1[0][2].equals("-"))
			        			p3=Double.parseDouble(data1[0][2]);
			        		
	        	    		if(!data1[0][3].equals("") || !data1[0][3].equals("-"))
			        			p4=Double.parseDouble(data1[0][3]); 
			        		
	        	    		if(!data1[0][4].equals("") || !data1[0][4].equals("-"))
			        			p5=Double.parseDouble(data1[0][4]); 
			        		
	        	    		if(!data1[0][5].equals("") || !data1[0][5].equals("-"))
			        			p6=Double.parseDouble(data1[0][5]); 
			        		
	        	    		if(!data1[0][6].equals("") || !data1[0][6].equals("-"))
			        			p7=Double.parseDouble(data1[0][6]); 
	        	    	}
	        	    	 
	        	    	 
	        	    	//April
	        	    	sql =" SELECT ROUND(b.DOU_BASIC,2),ROUND(b.DOU_PENBASIC,2),ROUND(b.DOU_COMPANYPF,2),ROUND(b.DOU_COMPANYPENSION,2),ROUND(b.DOU_ADMINCHARGE,2),ROUND(b.DOU_EDLI,2),ROUND(b.DOU_ADMINCHARGE1,2)  ";
	    				sql = sql +" FROM com_m_staff a, pay_t_salary b  ";
	    				sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
	    				sql = sql +" AND a.CHR_EMPID =   '"+data[i][0]+"' " ;
	    				sql = sql +" AND b.CHR_MONTH IN('April')  ";
	    				sql = sql +" AND b.INT_YEAR="+year    ;
	        			String data2[][]= CommonFunctions.QueryExecutecon(con, sql);
	        	    	if(data2.length>0)
	        	    	{
	        	    		if(!data2[0][0].equals("") || !data2[0][0].equals("-"))
			        			p8=Double.parseDouble(data2[0][0]);
			        		
	        	    		if(!data2[0][1].equals("") || !data2[0][1].equals("-"))
			        			p9=Double.parseDouble(data2[0][1]);
			        		
	        	    		if(!data2[0][2].equals("") || !data2[0][2].equals("-"))
			        			p10=Double.parseDouble(data2[0][2]);
			        		
	        	    		if(!data2[0][3].equals("") || !data2[0][3].equals("-"))
			        			p11=Double.parseDouble(data2[0][3]); 
			        		
	        	    		if(!data2[0][4].equals("") || !data2[0][4].equals("-"))
			        			p12=Double.parseDouble(data2[0][4]); 
			        		
	        	    		if(!data2[0][5].equals("") || !data2[0][5].equals("-"))
			        			p13=Double.parseDouble(data2[0][5]); 
			        		
	        	    		if(!data2[0][6].equals("") || !data2[0][6].equals("-"))
			        			p14=Double.parseDouble(data2[0][6]); 
	        	    	} 
	        	    	
	        	    	//May
	        	    	sql =" SELECT ROUND(b.DOU_BASIC,2),ROUND(b.DOU_PENBASIC,2),ROUND(b.DOU_COMPANYPF,2),ROUND(b.DOU_COMPANYPENSION,2),ROUND(b.DOU_ADMINCHARGE,2),ROUND(b.DOU_EDLI,2),ROUND(b.DOU_ADMINCHARGE1,2)  ";
	    				sql = sql +" FROM com_m_staff a, pay_t_salary b  ";
	    				sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
	    				sql = sql +" AND a.CHR_EMPID =   '"+data[i][0]+"' " ;
	    				sql = sql +" AND b.CHR_MONTH IN('May')  ";
	    				sql = sql +" AND b.INT_YEAR="+year    ;
	        			String data3[][]= CommonFunctions.QueryExecutecon(con, sql);
	        	    	if(data3.length>0)
	        	    	{
	        	    		if(!data3[0][0].equals("") || !data3[0][0].equals("-"))
			        			p15=Double.parseDouble(data3[0][0]);
			        		
	        	    		if(!data3[0][1].equals("") || !data3[0][1].equals("-"))
			        			p16=Double.parseDouble(data3[0][1]);
			        		
	        	    		if(!data3[0][2].equals("") || !data3[0][2].equals("-"))
			        			p17=Double.parseDouble(data3[0][2]);
			        		
	        	    		if(!data3[0][3].equals("") || !data3[0][3].equals("-"))
			        			p18=Double.parseDouble(data3[0][3]); 
			        		
	        	    		if(!data3[0][4].equals("") || !data3[0][4].equals("-"))
			        			p19=Double.parseDouble(data3[0][4]); 
			        		
	        	    		if(!data3[0][5].equals("") || !data3[0][5].equals("-"))
			        			p20=Double.parseDouble(data3[0][5]); 
			        		
	        	    		if(!data3[0][6].equals("") || !data3[0][6].equals("-"))
			        			p21=Double.parseDouble(data3[0][6]); 
	        	    	} 
	        	    	
	        	    	//June
	        	    	sql =" SELECT ROUND(b.DOU_BASIC,2),ROUND(b.DOU_PENBASIC,2),ROUND(b.DOU_COMPANYPF,2),ROUND(b.DOU_COMPANYPENSION,2),ROUND(b.DOU_ADMINCHARGE,2),ROUND(b.DOU_EDLI,2),ROUND(b.DOU_ADMINCHARGE1,2)  ";
	    				sql = sql +" FROM com_m_staff a, pay_t_salary b  ";
	    				sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
	    				sql = sql +" AND a.CHR_EMPID =   '"+data[i][0]+"' " ;
	    				sql = sql +" AND b.CHR_MONTH IN('June')  ";
	    				sql = sql +" AND b.INT_YEAR="+year    ;
	        			String data4[][]= CommonFunctions.QueryExecutecon(con, sql);
	        	    	if(data4.length>0)
	        	    	{
	        	    		if(!data4[0][0].equals("") || !data4[0][0].equals("-"))
			        			p22=Double.parseDouble(data4[0][0]);
			        		
	        	    		if(!data4[0][1].equals("") || !data4[0][1].equals("-"))
			        			p23=Double.parseDouble(data4[0][1]);
			        		
	        	    		if(!data4[0][2].equals("") || !data4[0][2].equals("-"))
			        			p24=Double.parseDouble(data4[0][2]);
			        		
	        	    		if(!data4[0][3].equals("") || !data4[0][3].equals("-"))
			        			p25=Double.parseDouble(data4[0][3]); 
			        		
	        	    		if(!data4[0][4].equals("") || !data4[0][4].equals("-"))
			        			p26=Double.parseDouble(data4[0][4]); 
			        		
	        	    		if(!data4[0][5].equals("") || !data4[0][5].equals("-"))
			        			p27=Double.parseDouble(data4[0][5]); 
			        		
	        	    		if(!data4[0][6].equals("") || !data4[0][6].equals("-"))
			        			p28=Double.parseDouble(data4[0][6]); 
	        	    	} 
	        	    	
	        	    	//July
	        	    	sql =" SELECT ROUND(b.DOU_BASIC,2),ROUND(b.DOU_PENBASIC,2),ROUND(b.DOU_COMPANYPF,2),ROUND(b.DOU_COMPANYPENSION,2),ROUND(b.DOU_ADMINCHARGE,2),ROUND(b.DOU_EDLI,2),ROUND(b.DOU_ADMINCHARGE1,2)  ";
	    				sql = sql +" FROM com_m_staff a, pay_t_salary b  ";
	    				sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
	    				sql = sql +" AND a.CHR_EMPID =   '"+data[i][0]+"' " ;
	    				sql = sql +" AND b.CHR_MONTH IN('July')  ";
	    				sql = sql +" AND b.INT_YEAR="+year    ;
	        			String data5[][]= CommonFunctions.QueryExecutecon(con, sql);
	        	    	if(data5.length>0)
	        	    	{
	        	    		if(!data5[0][0].equals("") || !data5[0][0].equals("-"))
			        			p29=Double.parseDouble(data5[0][0]);
			        		
	        	    		if(!data5[0][1].equals("") || !data5[0][1].equals("-"))
			        			p30=Double.parseDouble(data5[0][1]);
			        		
	        	    		if(!data5[0][2].equals("") || !data5[0][2].equals("-"))
			        			p31=Double.parseDouble(data5[0][2]);
			        		
	        	    		if(!data5[0][3].equals("") || !data5[0][3].equals("-"))
			        			p32=Double.parseDouble(data5[0][3]); 
			        		
	        	    		if(!data5[0][4].equals("") || !data5[0][4].equals("-"))
			        			p33=Double.parseDouble(data5[0][4]); 
			        		
	        	    		if(!data5[0][5].equals("") || !data5[0][5].equals("-"))
			        			p34=Double.parseDouble(data5[0][5]); 
			        		
	        	    		if(!data5[0][6].equals("") || !data5[0][6].equals("-"))
			        			p35=Double.parseDouble(data5[0][6]); 
	        	    	} 
	        	    	
	        	    	//August
	        	    	sql =" SELECT ROUND(b.DOU_BASIC,2),ROUND(b.DOU_PENBASIC,2),ROUND(b.DOU_COMPANYPF,2),ROUND(b.DOU_COMPANYPENSION,2),ROUND(b.DOU_ADMINCHARGE,2),ROUND(b.DOU_EDLI,2),ROUND(b.DOU_ADMINCHARGE1,2)  ";
	    				sql = sql +" FROM com_m_staff a, pay_t_salary b  ";
	    				sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
	    				sql = sql +" AND a.CHR_EMPID =   '"+data[i][0]+"' " ;
	    				sql = sql +" AND b.CHR_MONTH IN('August')  ";
	    				sql = sql +" AND b.INT_YEAR="+year    ;
	        			String data6[][]= CommonFunctions.QueryExecutecon(con, sql);
	        	    	if(data6.length>0)
	        	    	{
	        	    		if(!data6[0][0].equals("") || !data6[0][0].equals("-"))
			        			p36=Double.parseDouble(data6[0][0]);
			        		
	        	    		if(!data6[0][1].equals("") || !data6[0][1].equals("-"))
			        			p37=Double.parseDouble(data6[0][1]);
			        		
	        	    		if(!data6[0][2].equals("") || !data6[0][2].equals("-"))
			        			p38=Double.parseDouble(data6[0][2]);
			        		
	        	    		if(!data6[0][3].equals("") || !data6[0][3].equals("-"))
			        			p39=Double.parseDouble(data6[0][3]); 
			        		
	        	    		if(!data6[0][4].equals("") || !data6[0][4].equals("-"))
			        			p40=Double.parseDouble(data6[0][4]); 
			        		
	        	    		if(!data6[0][5].equals("") || !data6[0][5].equals("-"))
			        			p41=Double.parseDouble(data6[0][5]); 
			        		
	        	    		if(!data6[0][6].equals("") || !data6[0][6].equals("-"))
			        			p42=Double.parseDouble(data6[0][6]); 
	        	    	} 
	        	    	
	        	    	//September
	        	    	sql =" SELECT ROUND(b.DOU_BASIC,2),ROUND(b.DOU_PENBASIC,2),ROUND(b.DOU_COMPANYPF,2),ROUND(b.DOU_COMPANYPENSION,2),ROUND(b.DOU_ADMINCHARGE,2),ROUND(b.DOU_EDLI,2),ROUND(b.DOU_ADMINCHARGE1,2)  ";
	    				sql = sql +" FROM com_m_staff a, pay_t_salary b  ";
	    				sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
	    				sql = sql +" AND a.CHR_EMPID =   '"+data[i][0]+"' " ;
	    				sql = sql +" AND b.CHR_MONTH IN('September')  ";
	    				sql = sql +" AND b.INT_YEAR="+year    ;
	        			String data7[][]= CommonFunctions.QueryExecutecon(con, sql);
	        	    	if(data7.length>0)
	        	    	{
	        	    		if(!data7[0][0].equals("") || !data7[0][0].equals("-"))
			        			p43=Double.parseDouble(data7[0][0]);
			        		
	        	    		if(!data7[0][1].equals("") || !data7[0][1].equals("-"))
			        			p44=Double.parseDouble(data7[0][1]);
			        		
	        	    		if(!data7[0][2].equals("") || !data7[0][2].equals("-"))
			        			p45=Double.parseDouble(data7[0][2]);
			        		
	        	    		if(!data7[0][3].equals("") || !data7[0][3].equals("-"))
			        			p46=Double.parseDouble(data7[0][3]); 
			        		
	        	    		if(!data7[0][4].equals("") || !data7[0][4].equals("-"))
			        			p47=Double.parseDouble(data7[0][4]); 
			        		
	        	    		if(!data7[0][5].equals("") || !data7[0][5].equals("-"))
			        			p48=Double.parseDouble(data7[0][5]); 
			        		
	        	    		if(!data7[0][6].equals("") || !data7[0][6].equals("-"))
			        			p49=Double.parseDouble(data7[0][6]); 
	        	    	} 
	        	    	
	        	    	//October
	        	    	sql =" SELECT ROUND(b.DOU_BASIC,2),ROUND(b.DOU_PENBASIC,2),ROUND(b.DOU_COMPANYPF,2),ROUND(b.DOU_COMPANYPENSION,2),ROUND(b.DOU_ADMINCHARGE,2),ROUND(b.DOU_EDLI,2),ROUND(b.DOU_ADMINCHARGE1,2)  ";
	    				sql = sql +" FROM com_m_staff a, pay_t_salary b  ";
	    				sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
	    				sql = sql +" AND a.CHR_EMPID =   '"+data[i][0]+"' " ;
	    				sql = sql +" AND b.CHR_MONTH IN('October')  ";
	    				sql = sql +" AND b.INT_YEAR="+year    ;
	        			String data8[][]= CommonFunctions.QueryExecutecon(con, sql);
	        	    	if(data8.length>0)
	        	    	{
	        	    		if(!data8[0][0].equals("") || !data8[0][0].equals("-"))
			        			p50=Double.parseDouble(data8[0][0]);
			        		
	        	    		if(!data8[0][1].equals("") || !data8[0][1].equals("-"))
			        			p51=Double.parseDouble(data8[0][1]);
			        		
	        	    		if(!data8[0][2].equals("") || !data8[0][2].equals("-"))
			        			p52=Double.parseDouble(data8[0][2]);
			        		
	        	    		if(!data8[0][3].equals("") || !data8[0][3].equals("-"))
			        			p53=Double.parseDouble(data8[0][3]); 
			        		
	        	    		if(!data8[0][4].equals("") || !data8[0][4].equals("-"))
			        			p54=Double.parseDouble(data8[0][4]); 
			        		
	        	    		if(!data8[0][5].equals("") || !data8[0][5].equals("-"))
			        			p55=Double.parseDouble(data8[0][5]); 
			        		
	        	    		if(!data8[0][6].equals("") || !data8[0][6].equals("-"))
			        			p56=Double.parseDouble(data8[0][6]); 
	        	    	} 
	        	    	
	        	    	//November
	        	    	sql =" SELECT ROUND(b.DOU_BASIC,2),ROUND(b.DOU_PENBASIC,2),ROUND(b.DOU_COMPANYPF,2),ROUND(b.DOU_COMPANYPENSION,2),ROUND(b.DOU_ADMINCHARGE,2),ROUND(b.DOU_EDLI,2),ROUND(b.DOU_ADMINCHARGE1,2)  ";
	    				sql = sql +" FROM com_m_staff a, pay_t_salary b  ";
	    				sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
	    				sql = sql +" AND a.CHR_EMPID =   '"+data[i][0]+"' " ;
	    				sql = sql +" AND b.CHR_MONTH IN('November')  ";
	    				sql = sql +" AND b.INT_YEAR="+year    ;
	        			String data9[][]= CommonFunctions.QueryExecutecon(con, sql);
	        	    	if(data9.length>0)
	        	    	{
	        	    		if(!data9[0][0].equals("") || !data9[0][0].equals("-"))
			        			p57=Double.parseDouble(data9[0][0]);
			        		
	        	    		if(!data9[0][1].equals("") || !data9[0][1].equals("-"))
			        			p58=Double.parseDouble(data9[0][1]);
			        		
	        	    		if(!data9[0][2].equals("") || !data9[0][2].equals("-"))
			        			p59=Double.parseDouble(data9[0][2]);
			        		
	        	    		if(!data9[0][3].equals("") || !data9[0][3].equals("-"))
			        			p60=Double.parseDouble(data9[0][3]); 
			        		
	        	    		if(!data9[0][4].equals("") || !data9[0][4].equals("-"))
			        			p61=Double.parseDouble(data9[0][4]); 
			        		
	        	    		if(!data9[0][5].equals("") || !data9[0][5].equals("-"))
			        			p62=Double.parseDouble(data9[0][5]); 
			        		
	        	    		if(!data9[0][6].equals("") || !data9[0][6].equals("-"))
			        			p63=Double.parseDouble(data9[0][6]); 
	        	    	} 
	        	    	
	        	    	
	        	    	//December
	        	    	sql =" SELECT ROUND(b.DOU_BASIC,2),ROUND(b.DOU_PENBASIC,2),ROUND(b.DOU_COMPANYPF,2),ROUND(b.DOU_COMPANYPENSION,2),ROUND(b.DOU_ADMINCHARGE,2),ROUND(b.DOU_EDLI,2),ROUND(b.DOU_ADMINCHARGE1,2)  ";
	    				sql = sql +" FROM com_m_staff a, pay_t_salary b  ";
	    				sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
	    				sql = sql +" AND a.CHR_EMPID =   '"+data[i][0]+"' " ;
	    				sql = sql +" AND b.CHR_MONTH IN('December')  ";
	    				sql = sql +" AND b.INT_YEAR="+year    ;
	        			String data10[][]= CommonFunctions.QueryExecutecon(con, sql);
	        	    	if(data10.length>0)
	        	    	{
	        	    		if(!data10[0][0].equals("") || !data10[0][0].equals("-"))
			        			p64=Double.parseDouble(data10[0][0]);
			        		
	        	    		if(!data10[0][1].equals("") || !data10[0][1].equals("-"))
			        			p65=Double.parseDouble(data10[0][1]);
			        		
	        	    		if(!data10[0][2].equals("") || !data10[0][2].equals("-"))
			        			p66=Double.parseDouble(data10[0][2]);
			        		
	        	    		if(!data10[0][3].equals("") || !data10[0][3].equals("-"))
			        			p67=Double.parseDouble(data10[0][3]); 
			        		
	        	    		if(!data10[0][4].equals("") || !data10[0][4].equals("-"))
			        			p68=Double.parseDouble(data10[0][4]); 
			        		
	        	    		if(!data10[0][5].equals("") || !data10[0][5].equals("-"))
			        			p69=Double.parseDouble(data10[0][5]); 
			        		
	        	    		if(!data10[0][6].equals("") || !data10[0][6].equals("-"))
			        			p70=Double.parseDouble(data10[0][6]); 
	        	    	} 
	        	    	
	        	    	//January
	        	    	sql =" SELECT ROUND(b.DOU_BASIC,2),ROUND(b.DOU_PENBASIC,2),ROUND(b.DOU_COMPANYPF,2),ROUND(b.DOU_COMPANYPENSION,2),ROUND(b.DOU_ADMINCHARGE,2),ROUND(b.DOU_EDLI,2),ROUND(b.DOU_ADMINCHARGE1,2)  ";
	    				sql = sql +" FROM com_m_staff a, pay_t_salary b  ";
	    				sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
	    				sql = sql +" AND a.CHR_EMPID =   '"+data[i][0]+"' " ;
	    				sql = sql +" AND b.CHR_MONTH IN('January')  ";
	    				sql = sql +" AND b.INT_YEAR="+year    ;
	        			String data11[][]= CommonFunctions.QueryExecutecon(con, sql);
	        	    	if(data11.length>0)
	        	    	{
	        	    		if(!data11[0][0].equals("") || !data11[0][0].equals("-"))
			        			p71=Double.parseDouble(data11[0][0]);
			        		
	        	    		if(!data11[0][1].equals("") || !data11[0][1].equals("-"))
			        			p72=Double.parseDouble(data11[0][1]);
			        		
	        	    		if(!data11[0][2].equals("") || !data11[0][2].equals("-"))
			        			p73=Double.parseDouble(data11[0][2]);
			        		
	        	    		if(!data11[0][3].equals("") || !data11[0][3].equals("-"))
			        			p74=Double.parseDouble(data11[0][3]); 
			        		
	        	    		if(!data11[0][4].equals("") || !data11[0][4].equals("-"))
			        			p75=Double.parseDouble(data11[0][4]); 
			        		
	        	    		if(!data11[0][5].equals("") || !data11[0][5].equals("-"))
			        			p76=Double.parseDouble(data11[0][5]); 
			        		
	        	    		if(!data11[0][6].equals("") || !data11[0][6].equals("-"))
			        			p77=Double.parseDouble(data11[0][6]); 
	        	    	} 
	        	    	
	        	    	//February
	        	    	sql =" SELECT ROUND(b.DOU_BASIC,2),ROUND(b.DOU_PENBASIC,2),ROUND(b.DOU_COMPANYPF,2),ROUND(b.DOU_COMPANYPENSION,2),ROUND(b.DOU_ADMINCHARGE,2),ROUND(b.DOU_EDLI,2),ROUND(b.DOU_ADMINCHARGE1,2)  ";
	    				sql = sql +" FROM com_m_staff a, pay_t_salary b  ";
	    				sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID  ";
	    				sql = sql +" AND a.CHR_EMPID =   '"+data[i][0]+"' " ;
	    				sql = sql +" AND b.CHR_MONTH IN('February')  ";
	    				sql = sql +" AND b.INT_YEAR="+year    ;
	        			String data12[][]= CommonFunctions.QueryExecutecon(con, sql);
	        	    	if(data12.length>0)
	        	    	{
	        	    		if(!data12[0][0].equals("") || !data12[0][0].equals("-"))
			        			p78=Double.parseDouble(data12[0][0]);
			        		
	        	    		if(!data12[0][1].equals("") || !data12[0][1].equals("-"))
			        			p79=Double.parseDouble(data12[0][1]);
			        		
	        	    		if(!data12[0][2].equals("") || !data12[0][2].equals("-"))
			        			p80=Double.parseDouble(data12[0][2]);
			        		
	        	    		if(!data12[0][3].equals("") || !data12[0][3].equals("-"))
			        			p81=Double.parseDouble(data12[0][3]); 
			        		
	        	    		if(!data12[0][4].equals("") || !data12[0][4].equals("-"))
			        			p82=Double.parseDouble(data12[0][4]); 
			        		
	        	    		if(!data12[0][5].equals("") || !data12[0][5].equals("-"))
			        			p83=Double.parseDouble(data12[0][5]); 
			        		
	        	    		if(!data12[0][6].equals("") || !data12[0][6].equals("-"))
			        			p84=Double.parseDouble(data12[0][6]); 
	        	    	} 
	        	    	h3 = new Hashtable();
	        	    	h3.put("sno", (y+1)+".");
	        	    	h3.put("empid", data[i][0]);
						h3.put("name",data[i][1]);
						h3.put("father", data[i][2]);
						h3.put("company", data[i][3]);
						h3.put("branch", data[i][4]);
						h3.put("office", data[i][5]);
						h3.put("category", data[i][6]);
						h3.put("doj", data[i][7]);
						h3.put("p1", ""+p1);
						h3.put("p2", ""+p2);
						h3.put("p3", ""+p3);
						h3.put("p4", ""+p4);
						h3.put("p5", ""+p5);
						h3.put("p6", ""+p6);
						h3.put("p7", ""+p7);
						h3.put("p8", ""+p8);
						h3.put("p9", ""+p9);
						h3.put("p10", ""+p10);
						h3.put("p11", ""+p11);
						h3.put("p12", ""+p12);
						h3.put("p13", ""+p13);
						h3.put("p14", ""+p14);
						h3.put("p15", ""+p15);
						h3.put("p16", ""+p16);
						h3.put("p17", ""+p17);
						h3.put("p18", ""+p18);
						h3.put("p19", ""+p19);
						h3.put("p20", ""+p20);
						h3.put("p21", ""+p21);
						h3.put("p22", ""+p22);
						h3.put("p23", ""+p23);
						h3.put("p24", ""+p24);
						h3.put("p25", ""+p25);
						h3.put("p26", ""+p26);
						h3.put("p27", ""+p27);
						h3.put("p28", ""+p28);
						h3.put("p29", ""+p29);
						h3.put("p30", ""+p30);
						h3.put("p31", ""+p31);
						h3.put("p32", ""+p32);
						h3.put("p33", ""+p33);
						h3.put("p34", ""+p34);
						h3.put("p35", ""+p35);
						h3.put("p36", ""+p36);
						h3.put("p37", ""+p37);
						h3.put("p38", ""+p38);
						h3.put("p39", ""+p39);
						h3.put("p40", ""+p40);
						h3.put("p41", ""+p41);
						h3.put("p42", ""+p42);
						h3.put("p43", ""+p43);
						h3.put("p44", ""+p44);
						h3.put("p45", ""+p45);
						h3.put("p46", ""+p46);
						h3.put("p47", ""+p47);
						h3.put("p48", ""+p48);
						h3.put("p49", ""+p49);
						h3.put("p50", ""+p50);
						h3.put("p51", ""+p51);
						h3.put("p52", ""+p52);
						h3.put("p53", ""+p53);
						h3.put("p54", ""+p54);
						h3.put("p55", ""+p55);
						h3.put("p56", ""+p56);
						h3.put("p57", ""+p57);
						h3.put("p58", ""+p58);
						h3.put("p59", ""+p59);
						h3.put("p60", ""+p60);
						h3.put("p61", ""+p61);
						h3.put("p62", ""+p62);
						h3.put("p63", ""+p63);
						h3.put("p64", ""+p64);
						h3.put("p65", ""+p65);
						h3.put("p66", ""+p66);
						h3.put("p67", ""+p67);
						h3.put("p68", ""+p68);
						h3.put("p69", ""+p69);
						h3.put("p70", ""+p70);
						h3.put("p71", ""+p71);
						h3.put("p72", ""+p72);
						h3.put("p73", ""+p73);
						h3.put("p74", ""+p74);
						h3.put("p75", ""+p75);
						h3.put("p76", ""+p76);
						h3.put("p77", ""+p77);
						h3.put("p78", ""+p78);
						h3.put("p79", ""+p79);
						h3.put("p80", ""+p80);
						h3.put("p81", ""+p81);
						h3.put("p82", ""+p82);
						h3.put("p83", ""+p83);
						h3.put("p84", ""+p84);
						if(p2!= 0 || p8!= 0 || p15!= 0 || p22!= 0 || p29!= 0 || p36!= 0 || p43!= 0 || p50!= 0 || p57!= 0 || p64!= 0 || p71!= 0 || p78!= 0  )
						{
							al.add(h3);
							y = y+1;
						}
	        		}	 
	        	}
			    
	        	HashMap<Object,Object> map = new HashMap<Object,Object>();
	        	map.put("year",""+year);
	        	map.put("year1",""+year1 );
	        	
			    File reportDir = new File(Path + "/report/SmartPayroll/" + rptfilename+".jrxml");	
			    jasperPrint=ReportFunctions2.createReportUsingListDS(jasperPrint, request, response, reportDir, rptfilename, al, Path,map);
			    ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
			}
		}
		catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response);
		}
	}
}
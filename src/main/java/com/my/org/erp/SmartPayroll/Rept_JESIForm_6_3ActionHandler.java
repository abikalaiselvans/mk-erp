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

public class Rept_JESIForm_6_3ActionHandler extends AbstractActionHandler 
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
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			if (action.equals("PAYRept_JESIForm_6_3")) 
			{
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				String type=request.getParameter("type");
			    String company=request.getParameter("company");
				String branch = request.getParameter("branch");
				String Office = request.getParameter("Office");
				String Category = request.getParameter("Category");
				String department = request.getParameter("department");
			    int start=0,end=0;
			    int year=Integer.parseInt(request.getParameter("Year"));
			    String  from="",to="";
			    String sql="" ;
				
			    String mon="";
			    if(type.equals("O"))
			    {
			    	mon="October,November,December,January,February,March";
			    	from=""+(year-1);
			    	to=""+year;
			    	start=year-1;
			    	end=year;
			    }
			    else
			    {
			    	mon="April,May,June,July,August,September";
			    	from=""+year;
			    	to=""+year;
			    	start=year;
			    	end=year;
			    }
			    String month[]=mon.split(",");
			 
				map.put("from",from);
	        	map.put("to",to );
	        	map.put("mon1",month[0]);
	        	map.put("mon2",month[1]);
	        	map.put("mon3",month[2]);
	        	map.put("mon4",month[3]);
	        	map.put("mon5",month[4]);
	        	map.put("mon6",month[5]);
	        	   
	        	asql = "SELECT a.CHR_ESINO,a.CHR_STAFFNAME,a.DT_DOJCOLLEGE,b.CHR_DESIGNAME,c.CHR_BRANCHNAME,";
			    asql = asql+ " a.CHR_EMPID,CONCAT('') disp ";
			    asql = asql+ " FROM com_m_staff a,com_m_desig b,com_m_branch c";
			    asql = asql+ " WHERE a.CHR_ESI<>'N' AND b.INT_DESIGID=a.INT_DESIGID ";
			    asql = asql+ " AND c.INT_BRANCHID=a.INT_BRANCHID   ";
			    if(type.equals("O"))
			    	asql = asql+ " AND a.DT_DOJCOLLEGE <= '"+end+"-03-31'";
			    else
			    	asql = asql+ " AND a.DT_DOJCOLLEGE <= '"+start+"-09-30'";
			    
			    if(type.equals("O"))
			    	asql = asql+ " AND ( a.DAT_RESIGNDATE <= '"+end+"-03-31'  OR a.DAT_RESIGNDATE IS  NULL)";
			    else
			    	asql = asql+ " AND ( a.DAT_RESIGNDATE <= '"+start+"-09-30'  OR a.DAT_RESIGNDATE IS  NULL )";
			    
			    
			    //AND a.INT_DEPARTID =1 AND a.CHR_EMPID ='CISMAR2011003613'";
			   if(!"0".equals(company))
			    	 asql = asql+ " AND a.INT_COMPANYID =  "+company;
				if(!"0".equals(branch))
			    	 asql = asql+ " AND a.INT_BRANCHID =  "+branch;
				if(!"0".equals(Office))
					 asql = asql+ "  AND a.INT_OFFICEID =  "+Office;
				if(!"0".equals(department))
					 asql = asql+ "  AND a.INT_DEPARTID =  "+department;
				if(!"0".equals(Category))
					asql = asql+ "  AND a.CHR_CATEGORY =  "+Category; 
				asql = asql+ " GROUP BY   a.CHR_EMPID ORDER BY a.CHR_STAFFNAME ";
			    System.out.println(asql);
			    String data[][]= CommonFunctions.QueryExecute(asql);
			    double p1=0,p2=0,p3=0,p4=0,p5=0,p6=0,p7=0,p8=0,p9=0,p10=0;
			    double p11=0,p12=0,p13=0,p14=0,p15=0,p16=0,p17=0,p18=0,p19=0,p20=0;
			    double p21=0;
			    List<Hashtable> al=new ArrayList<Hashtable>();
			    Hashtable h3 =null;
			    if(type.equals("O"))
			    {	
		        	if(data.length>0)
		        	{
		        		
		        		for(int i=0;i<data.length;i++)
		        		{
		        	    	 
		        			sql="SELECT DOU_WORKDAYS,DOU_CPYESI,DOU_ESI FROM  pay_t_salary WHERE CHR_EMPID='"+data[i][5]+"' AND CHR_MONTH='"+month[0]+"' AND INT_YEAR="+start+"";
		        			String data1[][]= CommonFunctions.QueryExecutecon(con, sql);
		        	    	if(data1.length>0)
		        	    	{
		        	    		if(!data1[0][0].equals("") || !data1[0][0].equals("-"))
				        			p1=Double.parseDouble(data1[0][0]);
				        		if(!data1[0][1].equals("") || !data1[0][1].equals("-"))
				        			p2=Double.parseDouble(data1[0][1]);
				        		if(!data1[0][2].equals("") || !data1[0][2].equals("-"))
				        			p3=Double.parseDouble(data1[0][2]); 
		        	    	}
		        	    	sql="SELECT DOU_WORKDAYS,DOU_CPYESI,DOU_ESI FROM  pay_t_salary WHERE CHR_EMPID='"+data[i][5]+"' AND CHR_MONTH='"+month[1]+"' AND INT_YEAR="+start+"";
		        	    	String data2[][]= CommonFunctions.QueryExecutecon(con, sql);
		        	    	if(data2.length>0)
		        	    	{
		        	    		if(!data2[0][0].equals("") || !data2[0][0].equals("-"))
				        			p4=Double.parseDouble(data2[0][0]);
				        		if(!data2[0][1].equals("") || !data2[0][1].equals("-"))
				        			p5=Double.parseDouble(data2[0][1]);
				        		if(!data2[0][2].equals("") || !data2[0][2].equals("-"))
				        			p6=Double.parseDouble(data2[0][2]); 
		        	    	}
		        	    	sql="SELECT DOU_WORKDAYS,DOU_CPYESI,DOU_ESI FROM  pay_t_salary WHERE CHR_EMPID='"+data[i][5]+"' AND CHR_MONTH='"+month[2]+"' AND INT_YEAR="+start+"";
		        	    	String data3[][]= CommonFunctions.QueryExecutecon(con, sql);
		        	    	if(data3.length>0)
		        	    	{
		        	    		if(!data3[0][0].equals("") || !data3[0][0].equals("-"))
				        			p7=Double.parseDouble(data3[0][0]);
				        		if(!data3[0][1].equals("") || !data3[0][1].equals("-"))
				        			p8=Double.parseDouble(data3[0][1]);
				        		if(!data3[0][2].equals("") || !data3[0][2].equals("-"))
				        			p9=Double.parseDouble(data3[0][2]); 
		        	    	}
		        	    	sql="SELECT DOU_WORKDAYS,DOU_CPYESI,DOU_ESI FROM  pay_t_salary WHERE CHR_EMPID='"+data[i][5]+"' AND CHR_MONTH='"+month[3]+"' AND INT_YEAR="+end+"";
		        	    	String data4[][]= CommonFunctions.QueryExecutecon(con, sql);
		        	    	if(data4.length>0)
		        	    	{ 
		        	    		if(!data4[0][0].equals("") || !data4[0][0].equals("-"))
				        			p10=Double.parseDouble(data4[0][0]);
				        		if(!data4[0][1].equals("") || !data4[0][1].equals("-"))
				        			p11=Double.parseDouble(data4[0][1]);
				        		if(!data4[0][2].equals("") || !data4[0][2].equals("-"))
				        			p12=Double.parseDouble(data4[0][2]); 
		        	    	}
		        	    	sql="SELECT DOU_WORKDAYS,DOU_CPYESI,DOU_ESI FROM  pay_t_salary WHERE CHR_EMPID='"+data[i][5]+"' AND CHR_MONTH='"+month[4]+"' AND INT_YEAR="+end+"";
		        	    	String data5[][]= CommonFunctions.QueryExecutecon(con, sql);
		        	    	if(data5.length>0)
		        	    	{
		        	    		if(!data5[0][0].equals("") || !data5[0][0].equals("-"))
				        			p13=Double.parseDouble(data5[0][0]);
				        		if(!data5[0][1].equals("") || !data5[0][1].equals("-"))
				        			p14=Double.parseDouble(data5[0][1]);
				        		if(!data5[0][2].equals("") || !data5[0][2].equals("-"))
				        			p15=Double.parseDouble(data5[0][2]); 
		        	    	}
		        	    	sql="SELECT DOU_WORKDAYS,DOU_CPYESI,DOU_ESI FROM  pay_t_salary WHERE CHR_EMPID='"+data[i][5]+"' AND CHR_MONTH='"+month[5]+"' AND INT_YEAR="+end+"";
		        	    	String data6[][]= CommonFunctions.QueryExecutecon(con, sql);
		        	    	if(data6.length>0)
		        	    	{
		        	    		if(!data6[0][0].equals("") || !data6[0][0].equals("-"))
				        			p16=Double.parseDouble(data6[0][0]);
				        		if(!data6[0][1].equals("") || !data6[0][1].equals("-"))
				        			p17=Double.parseDouble(data6[0][1]);
				        		if(!data6[0][2].equals("") || !data6[0][2].equals("-"))
				        			p18=Double.parseDouble(data6[0][2]); 
		        	    	}   
		        	    	
		        	    	h3 = new Hashtable();
		        	    	h3.put("f1", (i+1)+".");
		        	    	h3.put("insurance", data[i][0]);
							h3.put("name",data[i][1]);
							h3.put("dispen", data[i][6]);
							h3.put("design", data[i][3]);
							h3.put("f2", "");
							h3.put("f3", "");
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
							h3.put("pwagestotal",""+(p1+p4+p7+p10+p13+p16));
							h3.put("pcpytotal",""+(p2+p5+p8+p11+p14+p17));
							h3.put("pstaftotal",""+(p3+p6+p9+p12+p15+p18));
							h3.put("dailywages","");
							h3.put("remark","");
							if(p2!= 0 || p5!= 0 || p8!= 0 || p11!= 0 || p14!= 0 || p17!= 0 )
								al.add(h3);
		        		}	 
		        	}
			    }
		        else
	        	{
		        	if(data.length>0)
		        	{
		        		
		        		for(int i=0;i<data.length;i++)
		        		{
		        	    	 
		        			sql="SELECT DOU_WORKDAYS,DOU_CPYESI,DOU_ESI FROM  pay_t_salary WHERE CHR_EMPID='"+data[i][5]+"' AND CHR_MONTH='"+month[0]+"' AND INT_YEAR="+start+"";
		        			String data1[][]= CommonFunctions.QueryExecutecon(con, sql);
		        	    	if(data1.length>0)
		        	    	{
		        	    		if(!data1[0][0].equals("") || !data1[0][0].equals("-"))
				        			p1=Double.parseDouble(data1[0][0]);
				        		if(!data1[0][1].equals("") || !data1[0][1].equals("-"))
				        			p2=Double.parseDouble(data1[0][1]);
				        		if(!data1[0][2].equals("") || !data1[0][2].equals("-"))
				        			p3=Double.parseDouble(data1[0][2]); 
		        	    	}
		        	    	sql="SELECT DOU_WORKDAYS,DOU_CPYESI,DOU_ESI FROM  pay_t_salary WHERE CHR_EMPID='"+data[i][5]+"' AND CHR_MONTH='"+month[1]+"' AND INT_YEAR="+start+"";
		        	    	String data2[][]= CommonFunctions.QueryExecutecon(con, sql);
		        	    	if(data2.length>0)
		        	    	{
		        	    		if(!data2[0][0].equals("") || !data2[0][0].equals("-"))
				        			p4=Double.parseDouble(data2[0][0]);
				        		if(!data2[0][1].equals("") || !data2[0][1].equals("-"))
				        			p5=Double.parseDouble(data2[0][1]);
				        		if(!data2[0][2].equals("") || !data2[0][2].equals("-"))
				        			p6=Double.parseDouble(data2[0][2]); 
		        	    	}
		        	    	sql="SELECT DOU_WORKDAYS,DOU_CPYESI,DOU_ESI FROM  pay_t_salary WHERE CHR_EMPID='"+data[i][5]+"' AND CHR_MONTH='"+month[2]+"' AND INT_YEAR="+start+"";
		        	    	String data3[][]= CommonFunctions.QueryExecutecon(con, sql);
		        	    	if(data3.length>0)
		        	    	{
		        	    		if(!data3[0][0].equals("") || !data3[0][0].equals("-"))
				        			p7=Double.parseDouble(data3[0][0]);
				        		if(!data3[0][1].equals("") || !data3[0][1].equals("-"))
				        			p8=Double.parseDouble(data3[0][1]);
				        		if(!data3[0][2].equals("") || !data3[0][2].equals("-"))
				        			p9=Double.parseDouble(data3[0][2]); 
		        	    	}
		        	    	sql="SELECT DOU_WORKDAYS,DOU_CPYESI,DOU_ESI FROM  pay_t_salary WHERE CHR_EMPID='"+data[i][5]+"' AND CHR_MONTH='"+month[3]+"' AND INT_YEAR="+start+"";
		        	    	String data4[][]= CommonFunctions.QueryExecutecon(con, sql);
		        	    	if(data4.length>0)
		        	    	{ 
		        	    		if(!data4[0][0].equals("") || !data4[0][0].equals("-"))
				        			p10=Double.parseDouble(data4[0][0]);
				        		if(!data4[0][1].equals("") || !data4[0][1].equals("-"))
				        			p11=Double.parseDouble(data4[0][1]);
				        		if(!data4[0][2].equals("") || !data4[0][2].equals("-"))
				        			p12=Double.parseDouble(data4[0][2]); 
		        	    	}
		        	    	sql="SELECT DOU_WORKDAYS,DOU_CPYESI,DOU_ESI FROM  pay_t_salary WHERE CHR_EMPID='"+data[i][5]+"' AND CHR_MONTH='"+month[4]+"' AND INT_YEAR="+start+"";
		        	    	String data5[][]= CommonFunctions.QueryExecutecon(con, sql);
		        	    	if(data5.length>0)
		        	    	{
		        	    		if(!data5[0][0].equals("") || !data5[0][0].equals("-"))
				        			p13=Double.parseDouble(data5[0][0]);
				        		if(!data5[0][1].equals("") || !data5[0][1].equals("-"))
				        			p14=Double.parseDouble(data5[0][1]);
				        		if(!data5[0][2].equals("") || !data5[0][2].equals("-"))
				        			p15=Double.parseDouble(data5[0][2]); 
		        	    	}
		        	    	sql="SELECT DOU_WORKDAYS,DOU_CPYESI,DOU_ESI FROM  pay_t_salary WHERE CHR_EMPID='"+data[i][5]+"' AND CHR_MONTH='"+month[5]+"' AND INT_YEAR="+start+"";
		        	    	String data6[][]= CommonFunctions.QueryExecutecon(con, sql);
		        	    	if(data6.length>0)
		        	    	{
		        	    		if(!data6[0][0].equals("") || !data6[0][0].equals("-"))
				        			p16=Double.parseDouble(data6[0][0]);
				        		if(!data6[0][1].equals("") || !data6[0][1].equals("-"))
				        			p17=Double.parseDouble(data6[0][1]);
				        		if(!data6[0][2].equals("") || !data6[0][2].equals("-"))
				        			p18=Double.parseDouble(data6[0][2]); 
		        	    	}   
		        	    	
		        	    	h3 = new Hashtable();
		        	    	h3.put("f1", (i+1)+".");
		        	    	h3.put("insurance", data[i][0]);
							h3.put("name",data[i][1]);
							h3.put("dispen", data[i][6]);
							h3.put("design", data[i][3]);
							h3.put("f2", "");
							h3.put("f3", "");
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
							
							h3.put("pwagestotal",""+(p1+p4+p7+p10+p13+p16));
							h3.put("pcpytotal",""+(p2+p5+p8+p11+p14+p17));
							h3.put("pstaftotal",""+(p3+p6+p9+p12+p15+p18));
							h3.put("dailywages","");
							h3.put("remark","");
							
							if(p2!= 0 || p5!= 0 || p8!= 0 || p11!= 0 || p14!= 0 || p17!= 0 )
								al.add(h3);
		        		}	 
		        	}
	        	}
	        File reportDir = new File(Path + "/report/SmartPayroll/" + rptfilename+".jrxml");	

			jasperPrint=ReportFunctions2.createReportUsingListDS(jasperPrint, request, response, reportDir, rptfilename, al, Path,map);
			ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
			
			
	        
	        //jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename, asql, con, Path,map);
			//ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
					
			
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
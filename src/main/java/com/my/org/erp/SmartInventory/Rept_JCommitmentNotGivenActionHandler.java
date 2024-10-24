package com.my.org.erp.SmartInventory;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.util.SimpleFileResolver;
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JCommitmentNotGivenActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	String cmpyname="";
	String officename="";
	String deptname="";
	String hImageExpression="";
	String fImageExpression="";
	String showRef="";
	
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String rptfilename1 = request.getParameter("rptfilename1");
			System.out.println("rptfilename1:"+rptfilename1);
			String reporttype = request.getParameter("reportType");
			
				
			if (action.equals("INVRept_JCommitmentNotGiven")) 
			{
				try 
				{ 
				 
				
				File reportsDir = new File(Path + "/report/Inventory/direct/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
							
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportsDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
					
				String Branch=request.getParameter("Branch");
				String division = ""+request.getParameter("division");
				String salestype=request.getParameter("salestype");
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				
						String sql="";
						String sql1="";
						sql = " SELECT c.CHR_BRANCHNAME ,d.CHR_COMPANYNAME,e.CHR_DIVICODE,a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') ,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),a.DOU_TOTALAMOUNT amount FROM  inv_t_directsales a , inv_t_paymentcommitment b,com_m_branch  c , com_m_company d,inv_m_division e WHERE   a.CHR_SALESNO = b.CHR_SALESNO  AND c.INT_COMPANYID = d.INT_COMPANYID AND c.INT_BRANCHID=a.INT_BRANCHID AND e.INT_DIVIID=a.INT_DIVIID AND b.CHR_STATUS='N' AND a.CHR_CANCEL ='N'";
						if(!"0".equals(Branch))
							sql = sql + " AND a.INT_BRANCHID = "+Branch;
						if(!"0".equals(division))
							sql = sql + " AND a.INT_DIVIID = "+division;
						if(!"0".equals(month))
						sql = sql + " AND MONTH(a.DAT_SALESDATE) = '"+month+"'";
						
					if(!"0".equals(year))
						sql = sql + " AND YEAR(a.DAT_SALESDATE) = "+year;
						sql1="SELECT c.CHR_BRANCHNAME ,d.CHR_COMPANYNAME,e.CHR_DIVICODE,a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') ,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),a.DOU_NETAMOUNT amount FROM  inv_t_servicebilling a , inv_t_paymentcommitment b,com_m_branch  c , com_m_company d,inv_m_division e WHERE   a.CHR_SALESNO = b.CHR_SALESNO AND c.INT_COMPANYID = d.INT_COMPANYID AND c.INT_BRANCHID=a.INT_BRANCHID AND e.INT_DIVIID=a.INT_DIVIID AND b.CHR_STATUS='N'   AND a.CHR_CANCEL ='N'";
						if(!"0".equals(month))
							sql1 = sql1 + " AND MONTH(a.DAT_SALESDATE) = '"+month+"'";
						if(!"0".equals(year))
							sql1 = sql1 + " AND YEAR(a.DAT_SALESDATE) = "+year;
						
						
						String data1[][]=CommonFunctions.QueryExecute(sql);
						String data2[][]=CommonFunctions.QueryExecute(sql1);
						System.out.println("Sql1:"+sql1);
						if(data1.length<=0 ) 
							map.put("dataLength", "0");
						else
							map.put("dataLength", "1");
						if(data2.length<=0 ) 
							map.put("dataLength1", "0");
						else
							map.put("dataLength1", "1");
						
						if(!"0".equals(Branch))
						{
							String data[][] = CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID AND a.INT_BRANCHID ="+Branch);
							System.out.println("Sql:"+sql);
							if(!data[0][0].equals(null))
									map.put("company",data[0][2]+" @ "+data[0][1]);
						}
						else
							map.put("company","All Companies");
						if(!"0".equals(division))
						{
							String data[][] = CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND INT_DIVIID="+division);
							if(!data[0][0].equals(null))
									map.put("division",data[0][1]);
						}
						else
							map.put("division","All Divisions");
						
						String umonth=DateUtil.getMonth(Integer.parseInt(month));
						if("0".equals(month))
							map.put("month", "All Months");
						else
							map.put("month", umonth);
						if("0".equals(year))
							map.put("year", "All Years");
						else
							map.put("year", year);
						if(salestype.equals("C"))
							map.put("saletype", "Customer Sales");
						else if(salestype.equals("S"))
							map.put("saletype", "Service Billing");
						
						if(salestype.equals("S"))
						{	
							sql=sql1;
						}
						
					jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportsDir, rptfilename, sql, con, Path,map);
					ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
					
			} 
			catch (Exception e) 
				{
			
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response);
			}
		}
	}
}

	
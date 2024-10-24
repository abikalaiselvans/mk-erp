package com.my.org.erp.SmartInventory;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JasperPrint;
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JStockTransferDetailActionHandler extends AbstractActionHandler 
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
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			if (action.equals("INVRept_JStockTransferDetail")) 
			{
				File reportDir = new File(Path + "/report/Inventory/Reports1/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				String fromdate = request.getParameter("fromdate");
				String todate = request.getParameter("todate");
				String frombranch = request.getParameter("frombranch");
				String tobranch = request.getParameter("tobranch");
				fromdate= DateUtil.FormateDateSQL(fromdate);
			 	todate= DateUtil.FormateDateSQL(todate);
				String daterange= request.getParameter("daterange");
				String division = request.getParameter("division");
				String sqldaterange="";
				if("Y".equals(daterange))
				{
					sqldaterange=" AND a.DAT_TRANSFERDATE >='"+fromdate+"' AND a.DAT_TRANSFERDATE<='"+todate+"' ";
					
				}	
				String sqldivision="";
				if(!"0".equals(division))
					sqldivision=" AND a.INT_DIVIID="+division;
				String sql = "";
				sql = " SELECT a.CHR_STOCKTRANSFERID, a.INT_BRANCHID_FROM, (Select c.CHR_BRANCHNAME from com_m_branch c ,com_m_company d " +
						"where c.INT_COMPANYID = d.INT_COMPANYID AND c.INT_BRANCHID = a.INT_BRANCHID_FROM) branchFrom, " +
						"(Select d.CHR_COMPANYNAME from com_m_branch c ,com_m_company d where c.INT_COMPANYID = d.INT_COMPANYID " +
						"AND c.INT_BRANCHID = a.INT_BRANCHID_FROM) companyFrom, a.INT_BRANCHID_TO, (Select c.CHR_BRANCHNAME from com_m_branch c ," +
						"com_m_company d where c.INT_COMPANYID = d.INT_COMPANYID  AND c.INT_BRANCHID = a.INT_BRANCHID_TO) branchTo, " +
						"(Select d.CHR_COMPANYNAME from com_m_branch c ,com_m_company d where c.INT_COMPANYID = d.INT_COMPANYID " +
						"AND c.INT_BRANCHID = a.INT_BRANCHID_TO) companyTo, b.CHR_DIVICODE division, " +
						"date_format(a.DAT_TRANSFERDATE,'%d-%m-%Y'),FIND_A_EMPLOYEE_ID_NAME(a.CHR_TRANSFERBY)," +
						"date_format(a.DAT_RECEIVEDDATE,'%d-%m-%Y'), FIND_A_EMPLOYEE_ID_NAME(a.CHR_RECEIVEDBY),a.CHR_DES," +
						"a.INT_STATUS,a.INT_TRANSFERSTATUS FROM inv_t_stocktransfer a,inv_m_division b WHERE b.INT_DIVIID=a.INT_DIVIID ";	
				sql=sql+sqldaterange;
				if(!"f".equals(frombranch))
				sql=sql+" AND a.INT_BRANCHID_FROM="+frombranch;
				if(!"t".equals(tobranch))
				sql=sql+" AND a.INT_BRANCHID_TO="+tobranch;
				if(!"0".equals(frombranch))
				sql=sql+sqldivision;
				sql=sql+" ORDER BY a.CHR_STOCKTRANSFERID  ";
				System.out.println("sql:"+sql);
				 
				String data[][] = CommonFunctions.QueryExecute(sql);
				if(data.length==0 )
					map.put("dataLength", "0");
				else
					map.put("dataLength", "1");
				
				if(!"f".equals(frombranch))
				{
					String data1[][] = CommonFunctions.QueryExecute("Select a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID AND a.INT_BRANCHID="+frombranch);
					if(!data1[0][0].equals(null))
							map.put("branchfrom",data1[0][1]+" @ "+data1[0][0]);
				}
				else
					map.put("branchfrom","All Transfer From");
				if(!"t".equals(tobranch))
				{
					String data1[][] = CommonFunctions.QueryExecute("Select a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID AND a.INT_BRANCHID="+tobranch);
					if(!data1[0][0].equals(null))
							map.put("branchto",data1[0][1]+" @ "+data1[0][0]);
				}
				else
					map.put("branchto","All Trasfer To");
				if(!"0".equals(division))
				{
					String data2[][] = CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND INT_DIVIID="+division);
					if(!data2[0][0].equals(null))
							map.put("division",data2[0][1]);
				}
				else
				map.put("division","All Divisions");
			
				map.put("fromdate", fromdate);
				map.put("todate", todate);
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename, sql, con, Path,map);
				ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
				
			}
		
		} catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response);
		}
	}
}
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
 
import com.my.org.erp.common.CommonFunctions;

public class Rept_JConsaumableStockAnalysisActionHandler extends AbstractActionHandler 
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
			System.out.println("INVRept_JConsaumableStockAnalysis");
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			if (action.equals("INVRept_JConsaumableStockAnalysis")) 
			{
				System.out.println("INVRept_JConsaumableStockCount");
				File reportDir = new File(Path + "/report/Inventory/Reports1/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				String branchid = request.getParameter("Branch");
				String division = request.getParameter("division");
				System.out.println("division : "+division);
				String product = ""+request.getParameter("product");
				
				
				String sql = "";
				sql = " SELECT  e.CHR_COMPANYNAME,c.CHR_BRANCHNAME,'PRODUCT',b.CHR_PRODUCTCODE, b.CHR_PRODUCTDESC," +
						"d.CHR_DIVICODE, a.CHR_PURCHASEORDERNO,a.INT_PQTY, a.DOU_UNITPRICE,a.CHR_SALESNO,a.INT_SQTY,a.DOU_SALESUNITPRICE," +
						" a.DOU_AVGPRICE ,if(a.CHR_CANCEL='Y','CANCELLED','' ) FROM inv_t_vendorgoodsreceivedconsumable a ,inv_m_produtlist b," +
						" com_m_branch c, inv_m_division d, com_m_company e  WHERE a.CHR_ITEMID=b.CHR_PRODUCTID " +
						"AND a.INT_BRANCHID =c.INT_BRANCHID AND b.INT_DIVIID =d.INT_DIVIID AND a.CHR_TYPE ='P'  " +
						"AND b.CHR_PTYPE='S' AND c.INT_COMPANYID = e.INT_COMPANYID";
				if(!"0".equals(branchid))
					sql = sql + " AND a.INT_BRANCHID = "+branchid;
				if(!"0".equals(division))
					sql = sql + " AND b.INT_DIVIID = "+division;
				if(!"0".equals(product))
					sql = sql + "  AND a.CHR_ITEMID ='"+product+"' ";
				
				sql = sql +"   ORDER BY a.INT_ROWID ";
				System.out.println("sql:"+sql);
				 
				String data[][] = CommonFunctions.QueryExecute(sql);
				if(data.length==0 )
					map.put("dataLength", "0");
				else
					map.put("dataLength", "1");
				
				if(!"0".equals(branchid))
				{
					String data1[][] = CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID AND a.INT_BRANCHID ="+branchid);
					if(!data1[0][0].equals(null))
							map.put("company",data1[0][2]+" @ "+data1[0][1]);
				}
				else
					map.put("company","All Companies");
				if(!"0".equals(division))
				{
					String data2[][] = CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND INT_DIVIID="+division);
					if(!data2[0][0].equals(null))
							map.put("division",data2[0][1]);
				}
				else
				map.put("division","All Divisions");
				if(!"0".equals(product))
				{
					String consumables[][] =  CommonFunctions.QueryExecute("SELECT CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PTYPE='S' ORDER BY CHR_PRODUCTCODE"); 
					if(!consumables[0][0].equals(null))
							map.put("cstock",consumables[0][0]);
				}
				else
				map.put("cstock","All Consumable Stocks");
				
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
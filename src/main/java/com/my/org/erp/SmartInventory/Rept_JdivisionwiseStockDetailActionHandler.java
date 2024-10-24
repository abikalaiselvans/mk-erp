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

public class Rept_JdivisionwiseStockDetailActionHandler extends AbstractActionHandler 
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
			
			if (action.equals("INVRept_JdivisionwiseStockDetail")) 
			{
				File reportDir = new File(Path + "/report/Inventory/Reports1/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				String branchid = request.getParameter("Branch");
				String division = request.getParameter("division");
				String producttype = ""+request.getParameter("producttype");
				String sql = "";
				sql = " SELECT  FUN_GET_BRANCH_NAME(a.INT_BRANCHID),b.CHR_DIVICODE,  if( a.CHR_TYPE ='I' ,'ITEM','PRODUCT' )," +
						" if(a.CHR_TYPE='I' ,  ( SELECT FUN_GET_ITEM_GROUP_NAME(a.CHR_ITEMID)) , " +
						"( SELECT FUN_GET_PRODUCT_GROUP_NAME(a.CHR_ITEMID))  ) productcodegroup,  if( a.CHR_TYPE ='I' , " +
						"(SELECT a1.CHR_ITEMNAME FROM inv_m_item a1  WHERE  a1.CHR_ITEMID =a.CHR_ITEMID)," +
						" (SELECT a2.CHR_PRODUCTCODE FROM inv_m_produtlist a2  WHERE  a2.CHR_PRODUCTID =a.CHR_ITEMID) ) productcode," +
						" if( a.CHR_TYPE ='I',(SELECT aa1.CHR_DES FROM inv_m_item aa1  WHERE  aa1.CHR_ITEMID =a.CHR_ITEMID)," +
						"(SELECT aa2.CHR_PRODUCTDESC FROM inv_m_produtlist aa2  WHERE  aa2.CHR_PRODUCTID =a.CHR_ITEMID) ) " +
						"productdescription,COUNT(*) ,DOU_UNITPRICE,(DOU_UNITPRICE)/COUNT(*)  " +
						" FROM inv_t_vendorgoodsreceived a ,inv_m_division b WHERE a.INT_DIVIID=b.INT_DIVIID AND a.CHR_FLAG='N'" +
						" AND a.CHR_SERIALNO is not null  ";	
				if(!"0".equals(branchid))
					sql = sql + " AND a.INT_BRANCHID = "+branchid;
				if(!"0".equals(division))
					sql = sql + " AND a.INT_DIVIID = "+division;
				if(!"0".equals(producttype))
					sql = sql + "  AND a.CHR_TYPE ='"+producttype+"' ";
				sql = sql +" GROUP BY a.CHR_TYPE,a.CHR_ITEMID ORDER BY a.INT_DIVIID";
				System.out.println("sql:"+sql);
				 
				String data[][] = CommonFunctions.QueryExecute(sql);
				if(data.length<=0 )
					map.put("dataLength", "0");
				else
					map.put("dataLength", "1");
				
				if(!"0".equals(branchid))
				{
					String data1[][] = CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID AND a.INT_BRANCHID ="+branchid);
					System.out.println("Sql:"+sql);
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
				if(producttype.equals("I"))
					map.put("ptype","Item");
				else if(producttype.equals("P"))
					map.put("ptype", "Product");
				else if(producttype.equals("0"))
					map.put("ptype", "All Product Types");
				
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
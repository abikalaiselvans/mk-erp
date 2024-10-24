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

public class Rept_JdivisionwiseSaleDetailActionHandler extends AbstractActionHandler 
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
			
			if (action.equals("INVRept_JdivisionwiseSaleDetail")) 
			{
				File reportDir = new File(Path + "/report/Inventory/Reports1/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				
				String branchid = request.getParameter("Branch");
				String division = request.getParameter("division");
				String fromdate = request.getParameter("fromdate");
				String todate = request.getParameter("todate");
				String sql = "";
				sql = " SELECT b.CHR_BRANCHNAME,  if( c.CHR_TYPE ='I' ,'ITEM','PRODUCT' ) producttype, if(c.CHR_TYPE='I' ," +
						"( SELECT FUN_GET_ITEM_GROUP_NAME(c.CHR_ITEMID)) , ( SELECT FUN_GET_PRODUCT_GROUP_NAME(c.CHR_ITEMID)) ) productgroup, " +
						"if( c.CHR_TYPE ='I' , (SELECT a1.CHR_ITEMNAME FROM inv_m_item a1  WHERE  a1.CHR_ITEMID =c.CHR_ITEMID)," +
						" (SELECT a2.CHR_PRODUCTCODE FROM inv_m_produtlist a2  WHERE  a2.CHR_PRODUCTID =c.CHR_ITEMID) ) productcode," +
						" if( c.CHR_TYPE ='I' , (SELECT left(aa1.CHR_DES,100) FROM inv_m_item aa1  WHERE  aa1.CHR_ITEMID =c.CHR_ITEMID)," +
						" (SELECT left(sa2.CHR_PRODUCTDESC,100) FROM inv_m_produtlist sa2  WHERE  sa2.CHR_PRODUCTID =c.CHR_ITEMID) ) productdescription," +
						" e.CHR_DIVICODE, a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'), FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID)," +
						"FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF) ,c.INT_QUANTITY,c.DOU_UNITPRICE,c.DOU_DISCOUNT,d.CHR_TAXNAME," +
						" c.DOU_TAX_PERCENTAGE,c.DOU_TAX_AMOUNT,c.DOU_TOTAL, if(c.CHR_SWAP='Y','Swapped','') FROM inv_t_directsales a," +
						" com_m_branch b , inv_t_swapsalesitem c, inv_m_tax d, inv_m_division e WHERE a.INT_SALESSTATUS =1" +
						" AND a.INT_BRANCHID = b.INT_BRANCHID AND a.CHR_SALESNO =c.CHR_SALESNO AND c.INT_TAXID = d.INT_TAXID" +
						" AND a.INT_DIVIID =e.INT_DIVIID ";
				 
				if(!"0".equals(division))
					sql = sql +" AND a.INT_DIVIID= "+division ;	
				sql = sql +" AND a.INT_BRANCHID=   "+branchid;
				sql = sql +" AND a.DAT_SALESDATE >='"+DateUtil.FormateDateSQL(fromdate)+"' AND a.DAT_SALESDATE <='"+DateUtil.FormateDateSQL(todate)+"'  ";
				sql = sql +" ORDER BY producttype, productcode";
				
				System.out.println( sql);
				 
				String data[][] = CommonFunctions.QueryExecute(sql);
				if(data.length<=0 )
					map.put("dataLength", "0");
				else
					map.put("dataLength", "1");
				
				if(!"0".equals(branchid))
				{
					String data3[][] = CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID AND a.INT_BRANCHID ="+branchid);
					if(!data3[0][0].equals(null))
							map.put("company",data3[0][2]+" @ "+data3[0][1]);
				}
				else
					map.put("company","All Companies");
				
				if(!"0".equals(division))
				{
					String data4[][] = CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND INT_DIVIID="+division);
					if(!data4[0][0].equals(null))
							map.put("division",data4[0][1]);
				}
				else
					map.put("division","All Divisions");
				
				map.put("fdate", fromdate);
				map.put("tdate", todate);
				
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename, sql, con, Path,map);
				ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
				
			}
		
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
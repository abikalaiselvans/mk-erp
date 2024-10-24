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

public class Rept_JdeliveryInfoActionHandler extends AbstractActionHandler 
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
			
			if (action.equals("INVRept_JdeliveryInfo")) 
			{
				File reportDir = new File(Path + "/report/Inventory/Reports1/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				String branchid = request.getParameter("Branch");
				String division = request.getParameter("division");
				String ref = ""+request.getParameter("ref");
				String custid=request.getParameter("customer");
				String delivery=request.getParameter("delivery");
				String fromdate = request.getParameter("fromdate");
				String todate = request.getParameter("todate");
				String sql = "";
				sql = " SELECT a.CHR_SALESNO,c.CHR_BRANCHNAME,d.CHR_DIVICODE,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y')," +
						" FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF), FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF1),FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF2)," +
						" a.DOU_TOTALAMOUNT,if(a.CHR_PAYMENTSTATUS='N','Pending',if(a.CHR_PAYMENTSTATUS='Y','Completed','Partial'))," +
						" if(a.CHR_DELIVERY='N','Pending',if(a.CHR_DELIVERY='P','Progress',if(a.CHR_DELIVERY='Y','Delivered','Rejected')))," +
						" if(a.CHR_DELIVERYTHROUGH ='C','Courier',if(a.CHR_DELIVERYTHROUGH='P','Person',if(a.CHR_DELIVERYTHROUGH='O','Own','Vehicle')))," +
						" a.CHR_COURIER_EMPID,a.CHR_COURIER_EMPID_MOBILE, if(a.INT_COURIERID =0 ,'',(SELECT e.CHR_COURIERNAME " +
						" FROM inv_m_courier e WHERE e.INT_COURIERID =a.INT_COURIERID)) couriername, a.DOU_COURIERAMOUNT, DATE_FORMAT(a.DAT_COURIERDATE,'%d-%b-%Y %h:%m:%s')," +
						" a.CHR_STARTING_PLACE,a.CHR_ENDING_PLACE,a.INT_COURIER_KILOMETER, a.CHR_COURIER_DESC,a.CHR_RECEIVERNAME," +
						" a.CHR_RECEIVER_MOBILE,DATE_FORMAT(a.DAT_DISPATCHEDDATE,'%d-%b-%Y %h:%m:%s'), a.CHR_CLOSEDBY,a.CHR_RECEIVER_DESC," +
						" datediff(a.DAT_COURIERDATE,a.DAT_DISPATCHEDDATE) FROM inv_t_directsales a , inv_m_customerinfo b, com_m_branch c, inv_m_division d" +
						" WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID AND a.INT_BRANCHID  = c.INT_BRANCHID AND a.INT_DIVIID =d.INT_DIVIID  ";	
				if(!"0".equals(branchid))
					sql = sql + " AND a.INT_BRANCHID = "+branchid;
				if(!"0".equals(division))
					sql = sql + " AND a.INT_DIVIID = "+division;
				if(!"0".equals(custid))
					sql = sql + "  AND a.INT_CUSTOMERID="+custid ;
				if(!"0".equals(ref))
					sql = sql + "  AND a.CHR_REF ='"+ref+"' ";
				if(!"0".equals(delivery))
					sql = sql + "  AND a.CHR_DELIVERY ='"+delivery+"'";
				sql = sql +" AND a.DAT_SALESDATE >='"+DateUtil.FormateDateSQL(fromdate)+"' AND a.DAT_SALESDATE <='"+DateUtil.FormateDateSQL(todate)+"'  ";
				sql = sql +" ORDER BY a.CHR_SALESNO";
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
				String data3[][];
				if(!custid.equals("0"))
				{
					data3 = CommonFunctions.QueryExecute("SELECT CONCAT(a.CHR_CONTACTPERSON,',',f.CHR_NAME,',',e.CHR_CITYNAME) FROM  inv_m_customerinfo a,com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID AND a.INT_CITYID =e.INT_CITYID AND   a.INT_ACTIVE =1 AND a.CHR_VERIFIED ='Y' AND  a.INT_CUSTOMERID= "+custid);
					map.put("customer",data3[0][0]);
				
				}
				else
					map.put("customer","All Customers");
					String[][] showRef;
				if(!ref.equals("0"))
				{
					showRef = CommonFunctions.QueryExecute("SELECT CONCAT(CHR_EMPID,' / ',CHR_STAFFNAME)  FROM com_m_staff WHERE CHR_HOLD!='Y'  AND CHR_TYPE!='T' AND CHR_EMPID= '"+ref+"'");
					map.put("customer",showRef[0][0]);
				}
				else
					map.put("ref","All references");
				if(delivery.equals("P"))
					map.put("ds","Progress");
				else if(delivery.equals("Y"))
					map.put("ds","Deliverd");
				else if(delivery.equals("N"))
					map.put("ds","Pending");
				else if(delivery.equals("R"))
					map.put("ds","Rejected");
				else if(delivery.equals("0"))
					map.put("ds","All Delivery Types");
				
				map.put("fdate", fromdate);
				map.put("tdate", todate);
				
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename, sql, con, Path,map);
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
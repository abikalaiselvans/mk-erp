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

public class Rept_JEMDActionHandler extends AbstractActionHandler 
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
			String reporttype = request.getParameter("reportType");
			
				
			if (action.equals("INVRept_JEMD")) 
			{
				try 
				{ 
				System.out.println("INVRept_JmaterialwiseSaleWiseReport");
				
				File reportsDir = new File(Path + "/report/Inventory/SalePaymentReports/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
							
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportsDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
						//String company= request.getParameter("company");
				String Branch=request.getParameter("Branch");
				String division = ""+request.getParameter("division");
				String customer=request.getParameter("customer");
				String ref = ""+request.getParameter("ref");
				String type=request.getParameter("EmdType");
				String fromdate = ""+request.getParameter("fromdate");
				String todate = request.getParameter("todate");
						
						String sql="";
						sql = " SELECT   if(a.INT_EMD_TYPE ='E','Earnest Money Deposit',  ";
						sql = sql+ " if(a.INT_EMD_TYPE ='B','Bank Guarantee','Security Deposit')) EMDType, a.CHR_EMD_REFNUMBER, ";
						sql = sql+ " FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID ),a.DOU_EMD_AMOUNT,  ";
						sql = sql+ " DATE_FORMAT(a.DAT_TENDER_LASTDATE,'%d-%b-%Y'),  ";
						sql = sql+ " d.CHR_DIVICODE,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF),  ";
						sql = sql+ " if(a.CHR_APPROVAL='Y','Approved',if(a.CHR_APPROVAL='R','Reject','Pending')) ,  ";
						sql = sql+ " if(a.CHR_STATUS='Y','Returned','Not Returned')  ";
						sql = sql+ " FROM inv_t_emd_informations a,inv_m_customerinfo b,com_m_staff c,inv_m_division d   ";
						sql = sql+ " WHERE a.INT_DIVIID =d.INT_DIVIID AND a.INT_CUSTOMERID = b.INT_CUSTOMERID  ";
						sql = sql+ " AND  a.CHR_REF =c.CHR_EMPID  ";
						 
						if(!"0".equals(Branch))
							sql = sql + " AND a.INV_BRANCHID = "+Branch;
						if(!"0".equals(division))
							sql = sql + " AND a.INT_DIVIID = "+division;
						if(!"0".equals(customer))
							sql = sql + " AND a.INT_CUSTOMERID = "+customer;
						if(!"0".equals(type))
							sql = sql + " AND a.INT_EMD_TYPE = '"+type+"' ";
						if(!"0".equals(ref))
							sql = sql + " AND a.CHR_REF = '"+ref+"' ";	
						sql = sql + " AND a.DAT_TENDER_LASTDATE >= '" +DateUtil.FormateDateSQL(fromdate)+"' ";
						sql = sql + " AND a.DAT_TENDER_LASTDATE <= '" +DateUtil.FormateDateSQL(todate)+"' ";	
						sql = sql + " ORDER BY FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID )   ";
						 System.out.println("sql :"+sql);
						String data1[][]=CommonFunctions.QueryExecute(sql);
						System.out.println("Sql:"+sql);
						if(data1.length<=0)
							map.put("dataLength", "0");
						else
							map.put("dataLength", "1");
						
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
									map.put("divi",data[0][1]);
						}
						else
							map.put("divi","All Divisions");
						if(!"0".equals(customer))
						{
							String data[][] = CommonFunctions.QueryExecute("SELECT a.INT_CUSTOMERID,f.CHR_NAME,a.CHR_CONTACTPERSON, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE),CONCAT('Phone :',a.CHR_PHONE),CONCAT('E-Mail :',a.CHR_EMAIL) FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND   a.INT_ACTIVE =1 AND a.CHR_VERIFIED ='Y' AND a.INT_CUSTOMERID="+customer);
							if(!data[0][0].equals(null))
									map.put("customer",data[0][1]+ " ,"+data[0][2]+ "  ,"+data[0][3]+ "  ,"+data[0][4]+ "  ,"+data[0][5]+ "  ,"+data[0][6]);
						}
						else
							map.put("customer","All Customers");
						if(!"0".equals(ref))
						{
							String data[][] = CommonFunctions.QueryExecute("SELECT CHR_EMPID,CHR_STAFFNAME  FROM com_m_staff WHERE CHR_HOLD!='Y'  AND CHR_TYPE!='T' AND CHR_EMPID ="+ref);
							if(!data[0][0].equals(null))
									map.put("ref",data[0][1]+" / " +data[0][0]);
						}
						else
							map.put("ref","All references");
						if("E".equals(type))
							map.put("emdtype", "Earnest Money Deposit");
						else if("B".equals(type))
							map.put("emdtype","Bank Guarantee");
						else if("S".equals(type))
							map.put("emdtype","Security Deposit");
						else if("0".equals(type))
							map.put("emdtype","All EMD Types");
		
		
						map.put("fdate", fromdate);
						map.put("tdate", todate);
					jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportsDir, rptfilename, sql, con, Path,map);
					ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
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
}

	
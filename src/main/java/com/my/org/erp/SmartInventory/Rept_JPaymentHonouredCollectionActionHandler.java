package com.my.org.erp.SmartInventory;
import java.awt.Color;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRMapCollectionDataSource;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.util.SimpleFileResolver;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import ar.com.fdvs.dj.core.DynamicJasperHelper;
import ar.com.fdvs.dj.core.layout.ClassicLayoutManager;
import ar.com.fdvs.dj.domain.DynamicReport;
import ar.com.fdvs.dj.domain.Style;
import ar.com.fdvs.dj.domain.builders.ColumnBuilder;
import ar.com.fdvs.dj.domain.builders.DynamicReportBuilder;
import ar.com.fdvs.dj.domain.constants.Border;
import ar.com.fdvs.dj.domain.constants.Font;
import ar.com.fdvs.dj.domain.constants.HorizontalAlign;
import ar.com.fdvs.dj.domain.constants.VerticalAlign;
import ar.com.fdvs.dj.domain.entities.columns.AbstractColumn;

import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.SmartReport.ReportFunctions2;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JPaymentHonouredCollectionActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	protected JasperReport jr;
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
			
			if (action.equals("INVRept_JPaymentHonouredCollection")) 
			{
				String path=Path + "/report/Inventory/SalePaymentReports/" + rptfilename+".jrxml";
				File reportDir = new File(Path + "/report/Inventory/SalePaymentReports/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				String fromdate = request.getParameter("fromdate");
				String todate = request.getParameter("todate");
				String Branch = request.getParameter("Branch");
				String division=request.getParameter("division");
				String paytype=request.getParameter("payType");
				String mode="";
				
				if (!reportDir.exists()) 
				{
				    throw new FileNotFoundException(String.valueOf(reportDir));
				}
				
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				map.put("fdate", fromdate);
				map.put("tdate", todate);
				
				String fdt=DateUtil.FormateDateSQL(fromdate);
				String tdt=DateUtil.FormateDateSQL(todate);
				String sql= "";
				String data1[][]=null;
				if("Direct".equals(paytype))
				{
					mode = "DIRECT SALES";
					
					sql =" SELECT a.CHR_SALESNO, date_format(a.DAT_SALESDATE,'%d-%b-%Y'),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID)," +
							"c.CHR_DIVICODE,d.CHR_BRANCHNAME,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF),a.DOU_AMOUNT,a.DOU_TAXAMOUNT,a.DOU_TOTALAMOUNT," +
							"a.CHR_NOOFPAYMENTCOMMITMENT,(SELECT SUM(DOU_PAIDAMOUNT) FROM inv_t_customersalespayment e WHERE e.CHR_SALESORDERNO = a.CHR_SALESNO )," +
							"date_format(f.DT_COMMITMENTDATE,'%d-%b-%Y'),f.DOU_COMMITMENTAMOUNT,f.DOU_ACTUALAMOUNT, date_format(f.DT_RECIEVEDDATE,'%d-%b-%Y')," +
							"f.DOU_RECEIVEDAMOUNT ,if(f.DT_RECIEVEDDATE <= f.DT_COMMITMENTDATE ,'Honoured', 'Not Honoured') FROM inv_t_directsales a," +
							" inv_m_customerinfo b, inv_m_division c,com_m_branch d  , inv_t_paymentcommitment f WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID" +
							" AND a.INT_DIVIID = c.INT_DIVIID AND a.INT_BRANCHID = d.INT_BRANCHID AND a.CHR_SALESNO = f.CHR_SALESNO ";
					sql = sql+" AND a.DAT_SALESDATE >= '"+fdt+"'";
					sql = sql+" AND a.DAT_SALESDATE <= '"+tdt+"'";
					 if(!"0".equals(Branch))
						sql = sql+" AND a.INT_BRANCHID ="+Branch;
					if(!"0".equals(division))
						sql = sql+"  AND a.INT_DIVIID="+division+" ";
					sql = sql+" ORDER BY a.DAT_SALESDATE ";
					System.out.println("Sql:"+sql);
					data1 = CommonFunctions.QueryExecute(sql);	
 				}
				else if("DirectBilling".equals(paytype))
					mode = "DIRECT BILLING ";
				else if("ServiceBilling".equals(paytype))
					mode = "SERVICE BILLING";
				
				
				List<HashMap> al=new ArrayList<HashMap>();
			
				 if(data1.length==0 )
						map.put("dataNotExist", "0");
				if(data1.length>0)
				for(int i=0;i<data1.length;i++)
				{
						HashMap h3 = new HashMap();
						h3.put("sno",i+1);
					
							h3.put("paymenttype",mode);
							h3.put("saleno", data1[i][0]);
							h3.put("saledt", data1[i][1]);
							h3.put("custname", data1[i][2]);
							h3.put("division", data1[i][3]);
							h3.put("branch", data1[i][4]);
							h3.put("empname", data1[i][5]);
							Double amt=0.00,taxamt=0.00,totamt=0.00,paidamount=0.00,commitamt=0.00,actualamt=0.00,receivedamt=0.00;
							if(!data1[i][6].equals("-"))
								 amt=Double.parseDouble(data1[i][6]);
							if(!data1[i][7].equals("-"))
								taxamt=Double.parseDouble(data1[i][7]);
							if(!data1[i][8].equals("-"))
								totamt=Double.parseDouble(data1[i][8]);
							if(!data1[i][10].equals("-"))
								paidamount=Double.parseDouble(data1[i][10]);
							if(!data1[i][12].equals("-"))
								commitamt=Double.parseDouble(data1[i][12]);
							if(!data1[i][13].equals("-"))
								actualamt=Double.parseDouble(data1[i][13]);
							if(!data1[i][15].equals("-"))
								receivedamt=Double.parseDouble(data1[i][15]);
							h3.put("amount", amt);
							h3.put("taxamount", taxamt);
							h3.put("totamount",totamt);
							h3.put("paycommitmentcount", data1[i][9]);
							h3.put("paidamount", paidamount);
							h3.put("commitdt", data1[i][11]);
							h3.put("commitamount", commitamt);
							h3.put("actualamount", actualamt);
							h3.put("receiveddt", data1[i][14]);
							h3.put("receivedamount", receivedamt);
							h3.put("honourflag", data1[i][16]);
					
						
					al.add(h3);
					
				}
							
				if(!"0".equals(Branch))
				{
					data1 = CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID AND a.INT_BRANCHID ="+Branch);
					if(!data1[0][0].equals(""))
							map.put("company",data1[0][2]+" @ "+data1[0][1]);
				}
				else
					map.put("company","All Companies");
				if(!"0".equals(division))
				{
					 data1 = CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND INT_DIVIID="+division);
					if(!data1[0][0].equals(""))
							map.put("division",data1[0][1]);
				}
				else
					map.put("division","All Divisions");
				map.put("paytype",mode);
			
		          jasperPrint=ReportFunctions2.createReportUsingListDataSource(jasperPrint, request, response, reportDir, rptfilename, al, Path,map);
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
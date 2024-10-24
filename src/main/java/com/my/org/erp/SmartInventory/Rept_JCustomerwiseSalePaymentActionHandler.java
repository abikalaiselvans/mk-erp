package com.my.org.erp.SmartInventory;
import java.awt.Color;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRMapCollectionDataSource;
import net.sf.jasperreports.engine.util.SimpleFileResolver;
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
import com.ibm.icu.text.NumberFormat;
import com.ibm.icu.text.DecimalFormat;
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JCustomerwiseSalePaymentActionHandler extends AbstractActionHandler 
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
			
			if (action.equals("INVRept_JCustomerwiseSalePayment")) 
			{
				String path=Path + "/report/Inventory/SalePaymentReports/" + rptfilename+".jrxml";
				File reportDir = new File(Path + "/report/Inventory/SalePaymentReports/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				String branch = request.getParameter("Branch");
				String customer = request.getParameter("customer");	
				
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
				
				String sql= "";
				String data[][]=null;
				sql = " SELECT FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),COUNT(*) ,  SUM(b.DOU_TOTALAMOUNT) ";
				sql = sql +" FROM inv_m_customerinfo a ,inv_t_directsales b ";
				sql = sql +" WHERE a.INT_CUSTOMERID= b.INT_CUSTOMERID AND b.CHR_CANCEL='N' ";
				if(!"0".equals(branch))
					sql = sql +" AND b.INT_BRANCHID ="+branch;

				if(!"0".equals(customer))
					sql = sql +" AND b.INT_CUSTOMERID ="+customer;
				sql = sql +" GROUP BY a.INT_CUSTOMERID ";
				sql = sql +" ORDER BY FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) ";
				System.out.println("sql:"+sql);
				List<HashMap> al=new ArrayList<HashMap>();
		
		    
		    NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("en", "IN"));
		    com.ibm.icu.text.DecimalFormatSymbols decimalFormatSymbols = ((DecimalFormat) formatter).getDecimalFormatSymbols();
		    decimalFormatSymbols.setCurrencySymbol("");
		    ((DecimalFormat) formatter).setDecimalFormatSymbols(decimalFormatSymbols);
			
		    Double c=0.00;		
			
				
				data = CommonFunctions.QueryExecute(sql);
				
				if(data.length>0)
				for(int i=0;i<=data.length;i++)
				{
					HashMap h3 = new HashMap();
					if(i!=data.length)
					{
					for(int j=0;j<=3;j++)
					{
						if(j==0)
						{
							h3.put("d"+j,i+1);
						}
						
						else if(j==3)
						{
							h3.put("d"+j,formatter.format(Double.parseDouble(data[i][j-1])));
							c+=Double.parseDouble(data[i][2]);
						}
						
						else
							h3.put("d"+j,data[i][j-1]);
										
					}
					}
					else if(i==data.length )
					{
						h3.put("d2", "Grand Total :");
						h3.put("d3", formatter.format(c));
					}
					
					al.add(h3);
				}
				
			
				if(!"0".equals(branch))
				{
					data = CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID AND a.INT_BRANCHID ="+branch);
					if(!data[0][0].equals(""))
							map.put("company",data[0][2]+" @ "+data[0][1]);
				}
				else
					map.put("company","All Companies");
				if(!"0".equals(customer))
				{
					data = CommonFunctions.QueryExecute("SELECT f.CHR_NAME,a.CHR_CONTACTPERSON, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE),CONCAT('Phone :',a.CHR_PHONE),CONCAT('E-Mail :',a.CHR_EMAIL) FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND a.INT_ACTIVE =1 AND a.CHR_VERIFIED ='Y' AND a.INT_CUSTOMERID="+customer);
					if(!data[0][0].equals(""))
							map.put("customer",data[0][0]+", "+data[0][1]+", "+data[0][2]);
				}
				else
					map.put("customer","All Customers");
				
								
				  DynamicReportBuilder drb = new DynamicReportBuilder();
		          Font font = new Font(8,"Times New Roman",true);
		          Style headerStyle = new Style();
		          headerStyle.setFont(font);
		          headerStyle.setHorizontalAlign(HorizontalAlign.CENTER);
		          headerStyle.setVerticalAlign(VerticalAlign.MIDDLE);
		          headerStyle.setBorder(Border.PEN_1_POINT);
		          Color veryLightGrey = new Color(230, 230, 230);
		          headerStyle.setBackgroundColor(veryLightGrey);
		          font = new Font(7,"Verdana",false);
		          Style detailstyle = new Style();
		          detailstyle.setFont(font);
		          detailstyle.setHorizontalAlign(HorizontalAlign.LEFT);
		          detailstyle.setVerticalAlign(VerticalAlign.MIDDLE);
		          detailstyle.setBorder(Border.THIN);
		          detailstyle.setBackgroundColor(Color.cyan);
		          
		          Style amountstyle = new Style();
		          amountstyle.setFont(font);
		          amountstyle.setHorizontalAlign(HorizontalAlign.RIGHT);
		          amountstyle.setVerticalAlign(VerticalAlign.MIDDLE);
		          amountstyle.setBorder(Border.THIN);
		          
		          Style numberstyle = new Style();
		          numberstyle.setFont(font);
		          numberstyle.setHorizontalAlign(HorizontalAlign.CENTER);
		          numberstyle.setVerticalAlign(VerticalAlign.MIDDLE);
		          numberstyle.setBorder(Border.THIN);
		          
		          String title[]={"S.No.","Customer Name","No of Sale","Total Amount"};
		          int datawidth[]={50,170,60,80};
		          
		          Style list[]={detailstyle,detailstyle,detailstyle,amountstyle};
		         
		          for(int u=0;u<=3;u++)
		          {
		        	  AbstractColumn AllowanceCol = ColumnBuilder.getInstance()
					  .setColumnProperty("d"+u, String.class.getName())
			          .setTitle(title[u]).setWidth(datawidth[u])
			          .setStyle(list[u]).setHeaderStyle(headerStyle).build();
			          drb.addColumn(AllowanceCol);
				  }
				
		          drb.setUseFullPageWidth(true);
		          drb.setTemplateFile(path);
		          DynamicReport dr = drb.build();
		          jr = DynamicJasperHelper.generateJasperReport(dr, new ClassicLayoutManager(),map);
		          
		          JRMapCollectionDataSource mc = new JRMapCollectionDataSource(al); 
		          jasperPrint = JasperFillManager.fillReport(jr, map, mc); 
		          ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
		          al=null;
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
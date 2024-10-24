package com.my.org.erp.SmartConveyance;
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

import com.ibm.icu.text.DecimalFormatSymbols;
import com.ibm.icu.text.NumberFormat;
import com.ibm.icu.text.DecimalFormat;
import com.my.org.erp.SmartReport.JasperReportDesignBean;
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JBankDetailActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	protected JasperReport jr;
	JRExporter exporter;
	String hImageExpression="";
	String fImageExpression="";
	HashMap<Integer, String> titleMap=new HashMap<Integer, String>();
	HashMap<Integer, Integer> widthMap=new HashMap<Integer, Integer>();
	HashMap<Integer, Style> styleMap=new HashMap<Integer, Style>();
	  

	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			if (action.equals("CONRept_JBankDetail")) 
			{	
				String path=Path + "/report/Conveyavce/" + rptfilename+".jrxml";
				File reportDir = new File(path);
				HashMap<Object,Object> map = new HashMap<Object,Object>();
								
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
				String data1[][]=null;
				List<HashMap<String,String>> al=new ArrayList<HashMap<String,String>>();
		
			    NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("en", "IN"));
			    DecimalFormatSymbols decimalFormatSymbols = ((DecimalFormat) formatter).getDecimalFormatSymbols();
			    decimalFormatSymbols.setCurrencySymbol("");
			    ((DecimalFormat) formatter).setDecimalFormatSymbols(decimalFormatSymbols);
			   
			    String companyid=request.getParameter("company");
				String branch=request.getParameter("branch");
				String officeid=request.getParameter("Office");
				String paiddate=request.getParameter("paiddate");
				String dept=request.getParameter("dept");
				String Category=request.getParameter("Category");
			
		    	sql = " SELECT if(FIND_A_BANKGROUP_NAME(b.CHR_BANK) ='STANDARD CHARTERED BANK','BT','ACH'  ),DATE_FORMAT(NOW(),'%d/%m/%Y')," +
		    			" FLOOR(ROUND(sum(a.DOU_TOTAL),2)),b.CHR_STAFFNAME, CONCAT('',b.CHR_ACCNO), if(FIND_A_BANKGROUP_NAME(b.CHR_BANK) =" +
		    			"'STANDARD CHARTERED BANK','SCBLINBBXXX','IFC-CODE'  ),  b.CHR_EMAILID,b.CHR_STAFFNAME, concat('Conveyance for the " +
		    			"month of ',UPPER(MONTHNAME(now())),' ',YEAR(now())) FROM conveyance_t_conveyance a, com_m_staff b , com_m_office d ," +
		    			"com_m_depart e, com_m_employeecategory f WHERE a.CHR_EMPID=b.CHR_EMPID AND a.CHR_STATUS='Y' AND a.CHR_ACCSTATUS='Y' " +
		    			"AND b.INT_OFFICEID =d.INT_OFFICEID AND b.INT_DEPARTID= e.INT_DEPARTID AND b.CHR_CATEGORY = f.INT_EMPLOYEECATEGORYID   ";
		    	sql = sql + "  AND a.DAT_ACCDATE='"+paiddate+"' ";
		    	if(!"0".equals(companyid))
		    		sql = sql + "  AND b.INT_COMPANYID= "+companyid;		
		    	if(!"0".equals(officeid))
		    		sql = sql + " AND b.INT_OFFICEID = " +officeid;
		    	if(!"0".equals(branch))
		    		sql = sql + "  AND b.INT_BRANCHID = " +branch;
		    	if(!"0".equals(dept))
		    		sql = sql + "  AND b.INT_DEPARTID = " +dept;
		    	if(!"0".equals(Category))
		    		sql = sql + "  AND b.CHR_CATEGORY = " +Category;
		 	    sql=sql+"  GROUP BY a.CHR_EMPID	 ORDER BY FIND_A_BANKGROUP_NAME(b.CHR_BANK),b.CHR_STAFFNAME ";
		 	    
				System.out.println("sql1:"+sql);
				data1 = CommonFunctions.QueryExecute(sql);
				
				int columnCount=CommonFunctions.intGetColumnCount(sql);
				System.out.println("columnCount:"+columnCount);
				Double t=0.00;
				if(data1.length>0)
					for(int i=0;i<=data1.length;i++)
					{
						HashMap<String,String> h3 = new HashMap<String,String>();
						if(i!=data1.length)
						{
						for(int j=0;j<=columnCount;j++)
						{
							if(j==0)
							{
								h3.put("d"+j,Integer.toString(i+1));
							}
							else if(j==3)
							{
								h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
								t+=Double.parseDouble(data1[i][j-1]);
							}
								else
								h3.put("d"+j,data1[i][j-1]);
						}
						}
						else
						{
							if(i==data1.length )
							{
								h3.put("d2", "Grand Total :");
								h3.put("d3", formatter.format(t));
								
							}
						}
						al.add(h3);
					}
				if(!companyid.equals("0"))
				{
					String shipids[][] = CommonFunctions.QueryExecutecon(con,"SELECT CHR_COMPANYNAME FROM com_m_company  WHERE  INT_COMPANYID ="+companyid);
					companyid=shipids[0][0];
				}
				else
					companyid="All Companies";
				if(!branch.equals("0"))
				{
					String shipids[][] = CommonFunctions.QueryExecutecon(con,"SELECT CHR_BRANCHNAME FROM  com_m_branch WHERE INT_BRANCHID="+branch);
					branch= shipids[0][0];
				}
				else
					branch= "All Branches";
				if(!officeid.equals("0"))
				{
					String shipids[][] = CommonFunctions.QueryExecutecon(con,"select CHR_OFFICENAME from com_m_office where INT_OFFICEID="+officeid);
					officeid=shipids[0][0];
				}
				else
					officeid="All Offices";
				if(!dept.equals("0"))
				{
					String shipids[][] = CommonFunctions.QueryExecutecon(con,"SELECT CHR_DEPARTNAME FROM   com_m_depart where INT_DEPARTID="+dept);
					dept=shipids[0][0];
				}
				else
					dept="All Departments";
				if(!Category.equals("0"))
				{
					String shipids[][] = CommonFunctions.QueryExecutecon(con,"SELECT CHR_CATEGORYNAME  FROM   com_m_employeecategory where INT_EMPLOYEECATEGORYID="+Category);
					Category=shipids[0][0];
				}
				else
					Category="All Categories";
				
				  map.put("reportTitle", "Bank Conveyance Detail");
				  map.put("reportFilter", "Company / Branch / Office / Department / Category / Acc Date:"+companyid+" / "+branch+" / "+officeid+" / "+dept+" / "+Category+" / "+paiddate);
				 
				  try {
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
					  
					  setToBean(0,"S.No.",35,detailstyle);
					 					
					  setToBean(1,"Payment Type",50,detailstyle);
					  setToBean(2,"Payment Date",60,numberstyle);
					  setToBean(3,"Payment Amount",80,amountstyle);
					  setToBean(4,"Payee Name",100,detailstyle);
					  setToBean(5,"Payee Account No",110,detailstyle);
					  setToBean(6,"Payee Bank IFSC",90,detailstyle);
					  setToBean(7,"Email Id",120,detailstyle);
					  setToBean(8,"Customer Reference",100,detailstyle);
					  setToBean(9,"Payment Detail",150,detailstyle);
					  
					  for(int u=0;u<=columnCount;u++)
					  {
						  @SuppressWarnings("deprecation")
						  AbstractColumn AllowanceCol = ColumnBuilder.getInstance()
						  .setColumnProperty("d"+u, String.class.getName())
					      .setTitle(titleMap.get(u)).setWidth(widthMap.get(u))
					      .setStyle(styleMap.get(u)).setHeaderStyle(headerStyle).build();
					      drb.addColumn(AllowanceCol);
					  }					  		
					  drb.setUseFullPageWidth(true);
					  drb.setTemplateFile(path);
					  DynamicReport dr = drb.build();
					  jr = DynamicJasperHelper.generateJasperReport(dr, new ClassicLayoutManager(),map);
					  
					  JRMapCollectionDataSource mc = new JRMapCollectionDataSource(al); 
					  jasperPrint = JasperFillManager.fillReport(jr, map, mc); 
					  ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
					  
				} catch (Exception e) {
					e.printStackTrace();
					System.out.println(e.getMessage());
					request.setAttribute("error", e.getMessage() );
					RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
		    		dispatchers.forward(request,response);
				}
				finally
				{
		          al=null;
				}
			}
			
		} catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request,response);
		}
	}
	 private JasperReportDesignBean setToBean(int Id,String name, int width,Style align) {
		 JasperReportDesignBean designBean = new JasperReportDesignBean();
		 designBean.setId(Id);
		 designBean.setFieldTitle(name);
		 designBean.setFiledWidth(width);
		 designBean.setFieldStyle(align);
		 titleMap.put(designBean.getId(), designBean.getFieldTitle());
		 widthMap.put(designBean.getId(), designBean.getFiledWidth());
		 styleMap.put(designBean.getId(), designBean.getFieldStyle());
	     return designBean;
	   }
	
}
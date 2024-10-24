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

import com.ibm.icu.text.DecimalFormatSymbols;
import com.ibm.icu.text.NumberFormat;
import com.ibm.icu.text.DecimalFormat;
import com.my.org.erp.SmartReport.JasperReportDesignBean;
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JServiceBillAccumulatedActionHandler extends AbstractActionHandler 
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
			
			if (action.equals("INVRept_JServiceBillAccumulated")) 
			{	
				 
				String path=Path + "/report/Inventory/" + rptfilename+".jrxml";
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
			    String  company  = request.getParameter("company");
				String  branch  = request.getParameter("branch");
		      	String  division  = request.getParameter("division");
			
		    	sql = " SELECT b.CHR_BRANCHNAME , d.CHR_DIVICODE,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),COUNT(*)," +
		    			"SUM(a.DOU_AMOUNT),  SUM(a.DOU_NETAMOUNT) FROM inv_t_servicebilling a, com_m_branch b ,   " +
		    			"inv_m_division d WHERE  a.INT_BRANCHID =b.INT_BRANCHID AND a.INT_DIVIID = d.INT_DIVIID  ";
		    	if(!"0".equals(company))
			      	sql = sql + " AND b.INT_COMPANYID="+company;
			    if(!"0".equals(branch))
			    	sql = sql + " AND b.INT_BRANCHID="+branch;
			    if(!"0".equals(division))
					sql = sql+" AND d.INT_DIVIID="+division;	
		 	    sql=sql+" GROUP BY a.INT_CUSTOMERID,a.INT_DIVIID, a.INT_BRANCHID ORDER BY d.CHR_DIVICODE,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID)";
 
		 	    
				System.out.println("sql1:"+sql);
				data1 = CommonFunctions.QueryExecute(sql);
				
				int columnCount=CommonFunctions.intGetColumnCount(sql);
				System.out.println("columnCount:"+columnCount);
				int c=0;
				Double c1=0.00,c2=0.00,c3=0.00;		
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
							else if(j==4)
							{
								h3.put("d"+j,data1[i][j-1]);
								c+=Integer.parseInt(data1[i][j-1]);
							}
							else if(j==5)
							{
								h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
								c1+=Double.parseDouble(data1[i][j-1]);
							}
							else if(j==6)
							{
								h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
								c2+=Double.parseDouble(data1[i][j-1]);
							}
						
								else
								h3.put("d"+j,data1[i][j-1]);
						}
						}
						else
						{
							if(i==data1.length )
							{
								h3.put("d3", "Grand Total :");
								h3.put("d4", Integer.toString(c));
								h3.put("d5", formatter.format(c1));
								h3.put("d6", formatter.format(c2));
								
							}
						}
						al.add(h3);
					}
					
				if(!company.equals("0"))
				{
					String shipids[][] = CommonFunctions.QueryExecutecon(con,"SELECT CHR_COMPANYNAME FROM com_m_company  WHERE  INT_COMPANYID ="+company);
					company=shipids[0][0];
				}
				else
					company="All Companies";
				if(!branch.equals("0"))
				{
					String shipids[][] = CommonFunctions.QueryExecutecon(con,"SELECT CHR_BRANCHNAME FROM  com_m_branch WHERE INT_BRANCHID="+branch);
					branch= shipids[0][0];
				}
				else
					branch= "All Branches";
				if(!"0".equals(division))
				{
					 data1 = CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND INT_DIVIID="+division);
					if(!data1[0][0].equals(""))
							division=data1[0][1];
				}
				else
							division="All Divisions";
				
				  map.put("reportTitle", "Service Bill Accumulated Detail");
				  map.put("reportFilter", "Company /Branch / Division : "+company+" / "+branch+" / "+division);
				 
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
					 					
					  setToBean(1,"Branch",110,detailstyle);
					  setToBean(2,"Division",90,detailstyle);
					  setToBean(3,"Customer",120,detailstyle);
					  setToBean(4,"Bill Count",40,amountstyle);
					  setToBean(5,"Sum of Bill Amount",70,amountstyle);
					  setToBean(6,"Sum of Net Amount",70,amountstyle);
					  
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
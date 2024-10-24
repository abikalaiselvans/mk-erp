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

public class Rept_JPaidActionHandler extends AbstractActionHandler 
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
			
			if (action.equals("CONRept_JPaid")) 
			{	
				String path=Path + "/report/Conveyavce/" + rptfilename+".jrxml";
				File reportDir = new File(Path + "/report/Conveyavce/" + rptfilename+".jrxml");
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
			    
			    String date=request.getParameter("date");
			    String  company  = request.getParameter("company");
				String  branch  = request.getParameter("branch");
		      	String  office  = request.getParameter("Office");
			
		    	sql = " SELECT CONCAT(a.CHR_EMPID,' / ',b.CHR_STAFFNAME),d.CHR_OFFICENAME,e.CHR_DEPARTNAME,f.CHR_CATEGORYNAME, " +
		    			" FIND_A_BANKGROUP_NAME(b.CHR_BANK) ,b.CHR_ACCNO,DATE_FORMAT(MIN(DAT_CONDATE),'%d-%b-%Y'), DATE_FORMAT(MAX(DAT_CONDATE)," +
		    			"'%d-%b-%Y') , sum(a.DOU_TRAVEL),sum(a.DOU_TRAIN),sum(a.DOU_AUTO),sum(a.DOU_LUNCH),sum(a.DOU_TELEPHONE),sum(a.DOU_OTHERAMT), " +
		    			"(sum(a.DOU_TRAVEL)+sum(a.DOU_TRAIN)+sum(a.DOU_AUTO)+sum(a.DOU_LUNCH)+sum(a.DOU_TELEPHONE)+sum(a.DOU_OTHERAMT)) ," +
		    			"sum(a.DOU_TOTAL) FROM conveyance_t_conveyance a, com_m_staff b , " +
		    			" com_m_office  d ,com_m_depart e , com_m_employeecategory  f WHERE a.CHR_EMPID=b.CHR_EMPID AND a.CHR_STATUS='Y'" +
		    			" AND a.CHR_ACCSTATUS='Y'  AND b.INT_OFFICEID =d.INT_OFFICEID AND b.INT_DEPARTID= e.INT_DEPARTID AND " +
		    			"b.CHR_CATEGORY=f.INT_EMPLOYEECATEGORYID AND a.DAT_ACCDATE='"+date+"' ";
		    	if(!"0".equals(company))
			      	sql = sql + " AND b.INT_COMPANYID="+company;
			    if(!"0".equals(branch))
			    	sql = sql + " AND b.INT_BRANCHID="+branch;
		 	    if(!"0".equals(office))
		 	    	sql = sql + " AND b.INT_OFFICEID="+office;
		 	    sql=sql+" GROUP BY a.CHR_EMPID ORDER BY  b.CHR_STAFFNAME ";
		 	    
				System.out.println("sql1:"+sql);
				data1 = CommonFunctions.QueryExecute(sql);
				
				int columnCount=CommonFunctions.intGetColumnCount(sql);
				System.out.println("columnCount:"+columnCount);
				Double t=0.00,t1=0.00,t2=0.00,t3=0.00,t4=0.00,t5=0.00,t6=0.00,t7=0.00;
				if(data1.length>0)
				for(int i=0;i<=data1.length;i++)
				{
					HashMap<String,String> h3 = new HashMap<String,String>();
					if(i!=data1.length)
					{
					for(int j=0;j<=columnCount+1;j++)
					{
						if(j==0)
						{
							h3.put("d"+j,Integer.toString(i+1));
						}
						else if(j==9)
						{
							h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
							t+=Double.parseDouble(data1[i][j-1]);
						}
						else if(j==10)
						{
							h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
							t1+=Double.parseDouble(data1[i][j-1]);
						}
						else if(j==11)
						{
							h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
							t2+=Double.parseDouble(data1[i][j-1]);
						}
						else if(j==12)
						{
							h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
							t3+=Double.parseDouble(data1[i][j-1]);
						}
						else if(j==13)
						{
							h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
							t4+=Double.parseDouble(data1[i][j-1]);
						}
						else if(j==14)
						{
							h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
							t5+=Double.parseDouble(data1[i][j-1]);
						}
						else if(j==15)
						{
							h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
							t6+=Double.parseDouble(data1[i][j-1]);
						}
						else if(j==16)
						{
							h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
							t7+=Double.parseDouble(data1[i][j-1]);
						}
						else if(j==columnCount+1)
						{
							h3.put("d"+j,"");
						}
						else
							h3.put("d"+j,data1[i][j-1]);
					}
					}
					else
					{
						if(i==data1.length )
						{
							h3.put("d8", "Grand Total :");
							h3.put("d9", formatter.format(t));
							h3.put("d10", formatter.format(t1));
							h3.put("d11", formatter.format(t2));
							h3.put("d12", formatter.format(t3));
							h3.put("d13", formatter.format(t4));
							h3.put("d14", formatter.format(t5));
							h3.put("d15", formatter.format(t6));
							h3.put("d16", formatter.format(t7));
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
				if(!office.equals("0"))
				{
					String shipids[][] = CommonFunctions.QueryExecutecon(con,"select CHR_OFFICENAME from com_m_office where INT_OFFICEID="+office);
					office=shipids[0][0];
				}
				else
					office="All Offices";
				

				  map.put("reportTitle", "Paid Conveyance Detail");
				  map.put("reportFilter", "Company /Branch / Office /Acc Date : "+company+" / "+branch+" / "+office+" / "+date);
				 
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
					 					
					  setToBean(1,"Employee Name",110,detailstyle);
					  setToBean(2,"Office",90,detailstyle);
					  setToBean(3,"Deepartment",90,detailstyle);
					  setToBean(4,"Category",90,detailstyle);
					  setToBean(5,"Bank",110,detailstyle);
					  
					  setToBean(6,"A/C No",90,detailstyle);
					  setToBean(7,"From Date",50,numberstyle);
					  setToBean(8,"To Date",50,numberstyle);
					  setToBean(9,"Vehicle Amount",50,amountstyle);
					  setToBean(10,"Train/Bus Fare",50,amountstyle);
					  setToBean(11,"Auto Fare",50,amountstyle);
					  
					  setToBean(12,"Lunch/Dinner",50,amountstyle);
					  setToBean(13,"Telephone Charges",50,amountstyle);
					  setToBean(14,"Other Total Amount",50,amountstyle);
					  setToBean(15,"Total",50,amountstyle);
					  setToBean(16,"Net Total",50,detailstyle);
					  setToBean(17,"Signature",50,detailstyle);
					  for(int u=0;u<=columnCount+1;u++)
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
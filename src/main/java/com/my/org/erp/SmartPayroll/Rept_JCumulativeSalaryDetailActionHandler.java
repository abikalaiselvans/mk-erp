package com.my.org.erp.SmartPayroll;
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
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JCumulativeSalaryDetailActionHandler extends AbstractActionHandler 
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
			
			if (action.equals("PAYRept_JCumulativeSalaryDetail")) 
			{	
				String path=Path + "/report/SmartPayroll/" + rptfilename+".jrxml";
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
				String dept=request.getParameter("dept");
				String month=request.getParameter("Month");
				String year=request.getParameter("Year");
				String mon=DateUtil.getMonth(Integer.parseInt(month));
			
		    	sql = " SELECT a.CHR_EMPID,b.CHR_STAFFNAME,c.CHR_BRANCHNAME,e.CHR_OFFICENAME,d.CHR_DEPARTNAME,a.CHR_MONTH,a.INT_YEAR,SUM(a.INT_MONTHDAYS)," +
		    			"SUM(a.DOU_WORKDAYS),SUM(a.DOU_BASIC),SUM(a.A001),SUM(a.A002),SUM(a.A003),SUM(a.A004),SUM(a.A005)," +
		    			"SUM(a.A006),SUM(a.A007),SUM(a.A008),SUM(a.A009),SUM(a.A0010),SUM(a.A0011),SUM(a.A0012),SUM(a.A0013)," +
		    			"SUM(a.A0014),SUM(a.A0015),SUM(a.DOU_ATOTAL1) sumofallowance, SUM(DOU_ATOTAL2) reimbursement,SUM(a.DOU_GROSSPAY) gross," +
		    			"SUM(a.R001),SUM(a.R002),SUM(a.R003),SUM(a.R004),SUM(a.R005),SUM(a.R006),SUM(a.R007),SUM(a.R008),SUM(a.RTOTAL) recoverytotal," +
		    			"SUM(a.DOU_PAYTAX) professiontax,SUM(a.DOU_TOTALRECOVERY) totalrecovery,SUM(a.DOU_PF) PF,  " +
		    			"SUM(a.DOU_ESI) ESI,SUM(a.DOU_ADVANCE) ADVANCE,SUM(a.DOU_NETSAL) netsal, SUM(a.DOU_MONTHSAL) monthsal," +
		    			"SUM(a.DOU_CTC) monthctc, SUM(a.DOU_ORIGINALCTC) originalctc,SUM(a.DOU_PENBASIC) penbasic,SUM(a.DOU_CPYPF1) cpypf," +
		    			" SUM(a.DOU_CPYPF2),SUM(a.DOU_ADMINCHARGE) admincharge,SUM(a.DOU_EDLI) edli,SUM(a.DOU_ADMINCHARGE1)adcharge " +
		    			"FROM pay_t_salary a , com_m_staff b, com_m_branch c, com_m_depart d, com_m_office e WHERE a.CHR_EMPID = b.CHR_EMPID " +
		    			"AND b.INT_BRANCHID =c.INT_BRANCHID AND b.INT_DEPARTID = d.INT_DEPARTID AND b.INT_OFFICEID  = e.INT_OFFICEID ";
		    	if(!"0".equals(companyid))
		    		sql = sql + "  AND b.INT_COMPANYID= "+companyid;		
		    	if(!"0".equals(officeid))
		    		sql = sql + " AND b.INT_OFFICEID = " +officeid;
		    	if(!"0".equals(branch))
		    		sql = sql + "  AND b.INT_BRANCHID = " +branch;
		    	if(!"0".equals(dept))
		    		sql = sql + "  AND b.INT_DEPARTID = " +dept;
		    	if(!"0".equals(month))
		    		sql = sql + "  AND a.CHR_MONTH = '"+mon+"'";
		    	sql = sql + " AND a.INT_YEAR ="+year;
		 	    sql=sql+"  GROUP BY a.CHR_EMPID,b.INT_BRANCHID, b.INT_DEPARTID,b.INT_OFFICEID ORDER BY b.CHR_STAFFNAME ,c.CHR_BRANCHNAME,d.CHR_DEPARTNAME ";
		 	    
				System.out.println("sql1:"+sql);
				data1 = CommonFunctions.QueryExecute(sql);
				
				int columnCount=CommonFunctions.intGetColumnCount(sql);
				System.out.println("columnCount:"+columnCount);
				Double t[] = new Double[45];
				for(int c=0;c<t.length;c++)
					t[c]=0.00;
				System.out.println("t:"+t.length);
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
							else if(j>7 && j<t.length+8)
							{	
									h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
									t[j-8]+=Double.parseDouble(data1[i][j-1]);
							}
								else
								h3.put("d"+j,data1[i][j-1]);
						}
						}
						else
						{
							if(i==data1.length )
							{int a=8;
								h3.put("d7", "Grand Total :");
								for(int b=0;b<t.length;b++)
								{
									h3.put("d"+a, formatter.format(t[b]));
									a++;
								}
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
				if(month.equals("0"))
					mon="All Months";
				
				  map.put("reportTitle", "Cumulative Salary Detail");
				  map.put("reportFilter", "Company / Branch / Office / Department / Month / Year : "+companyid+" / "+branch+" / "+officeid+" / "+dept+" / "+mon+" / "+year);
				 
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
					 					
					  setToBean(1,"Employee ID",110,detailstyle);
					  setToBean(2,"Employee Name",150,detailstyle);
					  setToBean(3,"Branch",100,detailstyle);
					  setToBean(4,"Office",100,detailstyle);
					  setToBean(5,"Department",110,detailstyle);
					  setToBean(6,"Month",80,detailstyle);
					  setToBean(7,"Year",50,detailstyle);
					  setToBean(8,"Total days in month ",50,amountstyle);
					  setToBean(9,"Working Days",50,amountstyle);
					  setToBean(10,"Basic Salary",70,amountstyle);
					  
					  String allowancetitle[][] = CommonFunctions.QueryExecutecon(con,"SELECT CHR_ANAME FROM pay_m_allowance");
					  for(int a=0;a<allowancetitle.length;a++)
						  setToBean(a+11,allowancetitle[a][0],80,amountstyle);
					 
					  setToBean(26,"Sum of Allowance",80,amountstyle);
					  setToBean(27,"Reimbursement",80,amountstyle);
					  setToBean(28,"Gross Amount",80,amountstyle);
					  String recoverytitle[][] = CommonFunctions.QueryExecutecon(con,"SELECT CHR_RNAME FROM pay_m_recovery");
					  for(int a=0;a<recoverytitle.length;a++)
						  setToBean(a+29,recoverytitle[a][0],80,amountstyle);
					
					  setToBean(37,"Recovery Total",100,amountstyle);
					  setToBean(38,"Professional Tax",100,amountstyle);
					  setToBean(39,"Recovery Net Amount",100,amountstyle);
					  setToBean(40,"PF",80,amountstyle);
					  setToBean(41,"ESI",80,amountstyle);
					  setToBean(42,"Advance",100,amountstyle);
					  
					  setToBean(43,"Net Salary",100,amountstyle);
					  setToBean(44,"Month Salary",100,amountstyle);
					  setToBean(45,"Month CTC",100,amountstyle);
					  setToBean(46,"Original CTC",100,amountstyle);
					  setToBean(47,"Penbasic",100,amountstyle);
					  setToBean(48,"Company PF1",100,amountstyle);
					  setToBean(49,"Company PF2",100,amountstyle);
					  setToBean(50,"Admin Charges",100,amountstyle);
					  setToBean(51,"EDLI Amount",100,amountstyle);
					  setToBean(52,"Admin Charges1",100,amountstyle);
					  
					  
					  for(int u=0;u<=columnCount;u++)
					  {
						  @SuppressWarnings("deprecation")
						  AbstractColumn Col = ColumnBuilder.getInstance()
						  .setColumnProperty("d"+u, String.class.getName())
					      .setTitle(titleMap.get(u)).setWidth(widthMap.get(u))
					      .setStyle(styleMap.get(u)).setHeaderStyle(headerStyle).build();
					      drb.addColumn(Col);
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
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
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JConveyanceAllActionHandler extends AbstractActionHandler 
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
			
			if (action.equals("CONRept_JConveyanceAll")) 
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
				
			   	String fromdate=""+request.getParameter("fromdate");
				String todate=""+request.getParameter("todate");
				String company=""+request.getParameter("company");
				String branch=""+request.getParameter("branch");
				String Office=""+request.getParameter("Office");
				String Dept=""+request.getParameter("Dept");
				String Category=""+request.getParameter("Category");
				String detail=""+request.getParameter("detail");
				
				String AllowanceData[][] = CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME  FROM pay_m_allowance WHERE CHR_FLAG='Y' ORDER BY INT_ALLOWANCEID");
				String grossband="";
				for(int u=0; u<AllowanceData.length;u++)
					grossband = grossband+"  k."+AllowanceData[u][0]+"+";
				grossband=grossband.trim();
				grossband = grossband.substring(0,grossband.length()-1);
				 
			 	String institutionData[][] =  CommonFunctions.QueryExecute("SELECT  INT_PFAMT,INT_ESIAMT,INT_ESILIMIT,INT_PFLIMIT,INT_PFLIMITMINIMUM  FROM m_institution WHERE INT_ID=1");
				double pfpercentage = Double.parseDouble( institutionData[0][0]);
				double esipercentage = Double.parseDouble( institutionData[0][1]);
				double esilimitamount = Double.parseDouble( institutionData[0][2]);
				double pfminimumlimit = Double.parseDouble( institutionData[0][4]);
				
				 sql = " SELECT  a.CHR_EMPID,a.CHR_STAFFNAME,b.CHR_COMPANYNAME,c.CHR_BRANCHNAME,d.CHR_OFFICENAME,e.CHR_DEPARTNAME,f.CHR_DESIGNAME,h.CHR_CATEGORYNAME, ";
				 sql = sql + " FIND_A_BANKNAME_NAME(i.INT_BANKID) ,a.CHR_ACCNO, DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'), ";
				 sql = sql + " MONTHNAME(j.DAT_CONDATE),YEAR(j.DAT_CONDATE),SUM(j.DOU_KM), ";
				 sql = sql + " SUM(j.DOU_TRAVEL),SUM(j.DOU_TRAIN),SUM(j.DOU_AUTO),SUM(j.DOU_LUNCH),  ";
				 sql = sql + " SUM(j.DOU_TELEPHONE),SUM(j.DOU_OTHERAMT),SUM(j.DOU_TOTAL),  ";
				 sql = sql + " ROUND(a.INT_SALARY),   ";  
			 	 sql = sql + " ROUND(a.INT_SALARY+("+grossband+")),  ";
			     sql = sql + " ROUND(a.INT_SALARY*12/100) ,ROUND( (a.INT_SALARY+("+grossband+"))  + (a.INT_SALARY*12/100) ) ,a.CHR_PF,a.CHR_ESI   ";
				 
			     sql = sql + " FROM com_m_staff  a,com_m_company b,com_m_branch c, com_m_office  d,com_m_depart e,com_m_desig f, com_m_employeecategory  h,com_m_bank i, ";
				 sql = sql + " conveyance_t_conveyance j ,pay_t_allowance k";
				 sql = sql + " WHERE a.CHR_HOLD!='Y' "; 
				 if(!"Y".equals(detail))
				 	sql = sql + " AND a.CHR_TYPE!='T' ";
				 
				 sql = sql + " AND a.INT_COMPANYID = b.INT_COMPANYID ";
				 sql = sql + " AND a.INT_BRANCHID = c.INT_BRANCHID  ";
				 sql = sql + " AND a.INT_OFFICEID = d.INT_OFFICEID ";
				 sql = sql + " AND a.INT_DEPARTID = e.INT_DEPARTID  ";
				 sql = sql + " AND a.INT_DESIGID = f.INT_DESIGID ";
				 sql = sql + " AND a.CHR_CATEGORY= h.INT_EMPLOYEECATEGORYID ";
				 sql = sql + " AND a.CHR_BANK  =i.INT_BANKID ";
				 sql = sql + " AND a.CHR_EMPID = j.CHR_EMPID ";
				 sql = sql + " AND a.CHR_EMPID = k.CHR_EMPID  ";
				 sql = sql + "  AND j.CHR_STATUS='Y' ";
				 sql = sql + " AND j.CHR_ACCEPT='Y' ";
				 
				if(!"0".equals(company))
				 	sql = sql + " AND a.INT_COMPANYID ="+company;
				
				if(!"0".equals(branch))
				 	sql = sql + " AND a.INT_BRANCHID ="+branch;
				
				if(!"0".equals(Office))
				 	sql = sql + " AND a.INT_OFFICEID ="+Office;
				
				if(!"0".equals(Dept))
				 	sql = sql + " AND a.INT_DEPARTID ="+Dept;
				
				if(!"0".equals(Category))
				 	sql = sql + " AND a.CHR_CATEGORY ="+Category;
				 
					
				 sql = sql + " AND j.DAT_CONDATE >='"+DateUtil.FormateDateSQL(fromdate)+"' ";
				 sql = sql + " AND j.DAT_CONDATE <='"+DateUtil.FormateDateSQL(todate)+"' ";
				 sql = sql + " GROUP BY  a.CHR_EMPID,MONTH(j.DAT_CONDATE),YEAR(j.DAT_CONDATE) ";
				 sql = sql + " ORDER BY  a.CHR_STAFFNAME ";
				System.out.println("sql1:"+sql);
				data1 = CommonFunctions.QueryExecute(sql);
				
				int columnCount=CommonFunctions.intGetColumnCount(sql);
				System.out.println("columnCount:"+columnCount);
				Double t=0.00,t1=0.00,t2=0.00,t3=0.00,t4=0.00,t5=0.00,t6=0.00,t7=0.00;
				Double t8=0.00,t9=0.00,t10=0.00,t11=0.00,t12=0.00;
				
				if(data1.length>0)
					for(int i=0;i<=data1.length;i++)
					{
						HashMap<String,String> h3 = new HashMap<String,String>();
						if(i!=data1.length)
						{
						for(int j=0;j<=columnCount;j++)
						{
							double monthbasic=0;
							double monthgross=0;
							double monthpf=0;
							double monthesi=0;
							double monthctc=0;
							String pf="";
							String esi="";
							pf=data1[i][25];
							esi=data1[i][26]; 
							monthbasic=Double.parseDouble(data1[i][21]);
							monthgross=Double.parseDouble(data1[i][22]);
							monthpf=Double.parseDouble(data1[i][23]);
							if("C".equals(pf))
							{
								if(monthbasic < pfminimumlimit)
									monthpf = (3200*pfpercentage/100); 
								else if( (monthbasic>=3200)  && (monthbasic <=6500))	
									monthpf = (monthbasic*pfpercentage/100); 
								else
									monthpf = (6500*pfpercentage/100); 
							}
							else
								monthpf =0;
										
							if("C".equals(esi) && monthgross <=esilimitamount)
								monthesi=(monthgross*esipercentage/100);
							else
								monthesi=0;
							
							monthctc=monthgross+monthpf+monthesi;
							
							if(j==0)
							{
								h3.put("d"+j,Integer.toString(i+1));
							}
							
			
							else if(j==15)
							{
								if(!data1[i][j-1].trim().equals("-"))
								{
								h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
								t+=Double.parseDouble(data1[i][j-1]);
								}
								else
								{
									h3.put("d"+j,data1[i][j-1]);
								}
							}
							else if(j==16)
							{
								if(!data1[i][j-1].trim().equals("-"))
								{
								h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
								t1+=Double.parseDouble(data1[i][j-1]);
								}
								else
								{
									h3.put("d"+j,data1[i][j-1]);
								}
							}
							else if(j==17)
							{
								if(!data1[i][j-1].trim().equals("-"))
								{
								h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
								t2+=Double.parseDouble(data1[i][j-1]);
								}
								else
								{
									h3.put("d"+j,data1[i][j-1]);
								}
							}
							else if(j==18)
							{
								if(!data1[i][j-1].trim().equals("-"))
								{
								h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
								t3+=Double.parseDouble(data1[i][j-1]);
								}
								else
								{
									h3.put("d"+j,data1[i][j-1]);
								}
							}
							else if(j==19)
							{
								if(!data1[i][j-1].trim().equals("-"))
								{
								h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
								t4+=Double.parseDouble(data1[i][j-1]);
								}
								else
								{
									h3.put("d"+j,data1[i][j-1]);
								}
							}
							else if(j==20)
							{
								if(!data1[i][j-1].trim().equals("-"))
								{
								h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
								t5+=Double.parseDouble(data1[i][j-1]);
								}
								else
								{
									h3.put("d"+j,data1[i][j-1]);
								}
							}
							else if(j==21)
							{
								if(!data1[i][j-1].trim().equals("-"))
								{
								h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
								t6+=Double.parseDouble(data1[i][j-1]);
								}
								else
								{
									h3.put("d"+j,data1[i][j-1]);
								}
							}
							else if(j==22)
							{
								if(!data1[i][j-1].trim().equals("-"))
								{
								h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
								t7+=Double.parseDouble(data1[i][j-1]);
								}
								else
								{
									h3.put("d"+j,data1[i][j-1]);
								}
							}
							else if(j==23)
							{
								if(!data1[i][j-1].trim().equals("-"))
								{
								h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
								t8+=Double.parseDouble(data1[i][j-1]);
								}
								else
								{
									h3.put("d"+j,data1[i][j-1]);
								}
							}
							else if(j==24)
							{
								h3.put("d"+j,formatter.format(monthpf));
								t9+=monthpf;
							}
							else if(j==25)
							{
								h3.put("d"+j,formatter.format(monthesi));
								t10+=monthesi;
							}
							else if(j==26)
							{
								h3.put("d"+j,formatter.format(monthctc));
								t11+=monthctc;
							}
							else if(j==27)
							{
								h3.put("d"+j,"");
								t12+=0.00;
							}
							else
								h3.put("d"+j,data1[i][j-1]);
						}
						}
						else
						{
							if(i==data1.length )
							{
								h3.put("d14", "Grand Total :");
								h3.put("d15", formatter.format(t));
								h3.put("d16", formatter.format(t1));
								h3.put("d17", formatter.format(t2));
								h3.put("d18", formatter.format(t3));
								h3.put("d19", formatter.format(t4));
								h3.put("d20", formatter.format(t5));
								h3.put("d21", formatter.format(t6));
								h3.put("d22", formatter.format(t7));
								h3.put("d23", formatter.format(t8));
								h3.put("d24", formatter.format(t9));
								h3.put("d25", formatter.format(t10));
								h3.put("d26", formatter.format(t11));
								h3.put("d27", formatter.format(t12));
								
								
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
				if(!Office.equals("0"))
				{
					String shipids[][] = CommonFunctions.QueryExecutecon(con,"select CHR_OFFICENAME from com_m_office where INT_OFFICEID="+Office);
					Office=shipids[0][0];
				}
				else
					Office="All Offices";
				if(!Dept.equals("0"))
				{
					String shipids[][] = CommonFunctions.QueryExecutecon(con,"SELECT CHR_DEPARTNAME FROM   com_m_depart where INT_DEPARTID="+Dept);
					Dept=shipids[0][0];
				}
				else
					Dept="All Departments";
				if(!Category.equals("0"))
				{
					String shipids[][] = CommonFunctions.QueryExecutecon(con,"SELECT CHR_CATEGORYNAME  FROM   com_m_employeecategory where INT_EMPLOYEECATEGORYID="+Category);
					Category=shipids[0][0];
				}
				else
					Category="All Categories";
				
				  map.put("reportTitle", "All Conveyance Detail");
				  map.put("reportFilter", "Conveyance Date Period / Company / Branch / Office / Department / Category / Including Resigners :" +
				  		" "+fromdate+" to "+todate+" / "+company+" / "+branch+" / "+Office+" / "+Dept+" / "+Category+" / "+(detail.equals("Y")?"Yes":"No"));
				 
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
					 	
					  setToBean(1,"Employee Id",110,detailstyle);
					  setToBean(2,"Employee Name",110,detailstyle);
					  setToBean(3,"Company",160,detailstyle);
					  setToBean(4,"Branch",90,detailstyle);
					  setToBean(5,"Office",90,detailstyle);
					  setToBean(6,"Department",110,detailstyle);
					  setToBean(7,"Designation",110,detailstyle);
					  setToBean(8,"Category",90,detailstyle);
					  setToBean(9,"Bank",130,detailstyle);
					  
					  setToBean(10,"A/C No",90,detailstyle);
					  setToBean(11,"DOJ",70,numberstyle);
					  setToBean(12,"Conveyance Month",50,detailstyle);
					  setToBean(13,"Conveyance Year",50,numberstyle);
					  setToBean(14,"Total KM",70,detailstyle);
					  setToBean(15,"Travel Fare",70,amountstyle);
					  setToBean(16,"Train/Bus Fare",70,amountstyle);
					  setToBean(17,"Auto Fare",70,amountstyle);
					  
					  setToBean(18,"Lunch/Dinner",70,amountstyle);
					  setToBean(19,"Telephone Charges",70,amountstyle);
					  setToBean(20,"Other Total Amount",70,amountstyle);
					  setToBean(21,"Total",70,amountstyle);
					  setToBean(22,"Basic",70,amountstyle);
					  setToBean(23,"Gross",70,amountstyle);
					  setToBean(24,"PF",70,amountstyle);
					  setToBean(25,"ESI",70,amountstyle);
					  setToBean(26,"Total Cost To Company",70,amountstyle);
					  setToBean(27,"Sum",70,amountstyle);

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
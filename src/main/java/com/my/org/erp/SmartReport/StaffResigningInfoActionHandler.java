package com.my.org.erp.SmartReport;
import java.awt.Color;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.util.SimpleFileResolver;
import ar.com.fdvs.dj.domain.Style;
import ar.com.fdvs.dj.domain.builders.ColumnBuilder;
import ar.com.fdvs.dj.domain.builders.DynamicReportBuilder;
import ar.com.fdvs.dj.domain.constants.Border;
import ar.com.fdvs.dj.domain.constants.Font;
import ar.com.fdvs.dj.domain.constants.HorizontalAlign;
import ar.com.fdvs.dj.domain.constants.VerticalAlign;
import ar.com.fdvs.dj.domain.entities.columns.AbstractColumn;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;

public class StaffResigningInfoActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	String hImageExpression="";
	String fImageExpression="";

	public String getSqlQuery(String company,String branch,String Office,String dept,String month,String year,String orderby)
	{
		asql = "SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,DATE_FORMAT(a.DT_DOB,'%d-%b-%Y'), b.CHR_COMPANYNAME,"
				+ "c.CHR_BRANCHNAME, d.CHR_OFFICENAME, e.CHR_DEPARTNAME,f.CHR_DESIGNAME,a.CHR_GENDER,"
				+ "DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),DATE_FORMAT(g.DT_TERM_DATE,'%d-%b-%Y'),"
				+ "(PERIOD_DIFF(EXTRACT(YEAR_MONTH FROM g.DT_TERM_DATE),EXTRACT(YEAR_MONTH "
				+ "FROM a.DT_DOJCOLLEGE))/ 12), a.INT_SALARY,a.INT_GROSSSALARY ,MONTHNAME(g.DT_TERM_DATE),"
				+ "YEAR(g.DT_TERM_DATE) FROM  com_m_staff a,com_m_company b,com_m_branch c,com_m_office d,"
				+ "com_m_depart e,com_m_desig f ,pay_m_emp_termination g WHERE a.INT_COMPANYID= b.INT_COMPANYID "
				+ "AND a.INT_BRANCHID=c.INT_BRANCHID AND a.INT_OFFICEID=d.INT_OFFICEID AND a.INT_DEPARTID= "
				+ "e.INT_DEPARTID AND a.INT_DESIGID = f.INT_DESIGID AND  a.CHR_TYPE ='T' AND a.CHR_EMPID = g.CHR_EMPID";
	 if(!"0".equals(company))
	 	asql = asql +" AND a.INT_COMPANYID="+company;
	 if(!"0".equals(branch))
	 	asql = asql +" AND a.INT_BRANCHID="+branch;
	 if(!"0".equals(Office))
	 	asql = asql +" AND a.INT_OFFICEID="+Office;
	 if(!"0".equals(dept))
			asql = asql + " AND a.INT_DEPARTID= "+dept;	
	 if(!"0".equals(year))
	 	asql = asql +" AND YEAR(g.DT_TERM_DATE)="+year;
	 if(!"0".equals(month))
	 	asql = asql +" AND MONTH(g.DT_TERM_DATE)="+month;	
	 	asql = asql +" ORDER BY "+orderby;
	 	System.out.println("asql:"+asql);
		return asql;
	}
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String action = request.getParameter("actionS");
		if (action.equals("RPTStaffResigningInfo")) 
		{	
			String reportTile="Resigned Staff Detail";
			List<HashMap<String,String>> al=new ArrayList<HashMap<String,String>>();
			try 
			{ 
				String rptfilename = request.getParameter("rptfilename");
				String reporttype = request.getParameter("reportType");
				String company = request.getParameter("company");
				 String branch = request.getParameter("branch");
				 String Office = request.getParameter("Office");
				String dept = request.getParameter("dept");
				 String month = request.getParameter("month");
				 String year = request.getParameter("year");
				 String orderby = request.getParameter("orderby");
				
				HashMap<Object,Object> map = new HashMap<Object,Object>();

				asql=getSqlQuery(company,branch,Office,dept,month,year,orderby);
				String path=Path + "/report/SmartCommon/" + rptfilename+".jrxml";
				File reportDir = new File(path);

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
				String data1[][] = CommonFunctions.QueryExecute(asql);
				int columnCount=CommonFunctions.intGetColumnCount(asql);
				if(data1.length>0)
					for(int i=0;i<data1.length;i++)
					{
						HashMap<String,String> h3 = new HashMap<String,String>();

						for(int j=0;j<=columnCount;j++)
						{
							if(j==0)
							{
								h3.put("d"+j,Integer.toString(i+1)+".");
							}
							else if(j==13)
							{
								Double exp=new Double(data1[i][j-1]);
								h3.put("d"+j,Double.toString(CommonFunctions.keep2Digit(exp)));
							}
							else if(j==14)
							{
								h3.put("d"+j,CommonFunctions.indianCurrencyFormat().format(Double.parseDouble(data1[i][j-1])));
							}
							else if(j==15)
							{
								h3.put("d"+j,CommonFunctions.indianCurrencyFormat().format(Double.parseDouble(data1[i][j-1])));
							}
							else
								h3.put("d"+j,data1[i][j-1]);
						}
						al.add(h3);
					}

				DynamicReportBuilder drb = new DynamicReportBuilder();
				Font font = new Font(8,"Times New Roman",true);
				Style headerStyle = new Style();
				headerStyle.setFont(font);
				headerStyle.setHorizontalAlign(HorizontalAlign.CENTER);
				headerStyle.setVerticalAlign(VerticalAlign.MIDDLE);
				headerStyle.setBorder(Border.PEN_1_POINT);
				//Color veryLightGrey = new Color(230, 230, 230);
				headerStyle.setBackgroundColor(Color.LIGHT_GRAY);
				font = new Font(7,"Verdana",false);
				Style detailstyle = new Style();
				detailstyle.setFont(font);
				detailstyle.setHorizontalAlign(HorizontalAlign.LEFT);
				detailstyle.setVerticalAlign(VerticalAlign.MIDDLE);
				detailstyle.setBorder(Border.THIN);
				//detailstyle.setBackgroundColor(veryLightGrey);
				//detailstyle.setTransparent(false);

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
				if(data1.length>0)
					for(int u=0;u<=columnCount;u++)
					{
						if(u==0)
						{
							@SuppressWarnings("deprecation")
							AbstractColumn AllowanceCol = ColumnBuilder.getInstance()
							.setColumnProperty("d"+u, String.class.getName())
							.setTitle("S.No.").setWidth(25)
							.setStyle(detailstyle).setHeaderStyle(headerStyle)
							.build();
							drb.addColumn(AllowanceCol);
						}
						else if(u==1)
						{
							@SuppressWarnings("deprecation")
							AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
							.setTitle("Staff Id").setWidth(80).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
							drb.addColumn(AllowanceCol);
						}
						else if(u==2)
						{
							@SuppressWarnings("deprecation")
							AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
							.setTitle("Staff Name").setWidth(100).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
							drb.addColumn(AllowanceCol);
						}

						else if(u==3)
						{
							@SuppressWarnings("deprecation")
							AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
							.setTitle("Father Name").setWidth(100).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
							drb.addColumn(AllowanceCol);
						}
						else if(u==4)
						{
							@SuppressWarnings("deprecation")
							AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
							.setTitle("Date of Birth").setWidth(60).setStyle(numberstyle).setHeaderStyle(headerStyle).build();
							drb.addColumn(AllowanceCol);
						}
						else if(u==5)
						{
							@SuppressWarnings("deprecation")
							AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
							.setTitle("Company").setWidth(100).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
							drb.addColumn(AllowanceCol);
						}

						else if(u==6)
						{
							@SuppressWarnings("deprecation")
							AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
							.setTitle("Branch").setWidth(70).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
							drb.addColumn(AllowanceCol);
						}
						else if(u==7)
						{
							@SuppressWarnings("deprecation")
							AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
							.setTitle("Office").setWidth(70).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
							drb.addColumn(AllowanceCol);
						}
					
						else if(u==8)
						{
							@SuppressWarnings("deprecation")
							AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
							.setTitle("Department").setWidth(80).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
							drb.addColumn(AllowanceCol);
						}
						else if(u==9)
						{
							@SuppressWarnings("deprecation")
							AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
							.setTitle("Designation").setWidth(100).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
							drb.addColumn(AllowanceCol);
						}
						else if(u==10)
						{
							@SuppressWarnings("deprecation")
							AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
							.setTitle("Gender").setWidth(40).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
							drb.addColumn(AllowanceCol);
						}
						else if(u==11)
						{
							@SuppressWarnings("deprecation")
							AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
							.setTitle("DOJ").setWidth(60).setStyle(numberstyle).setHeaderStyle(headerStyle).build();
							drb.addColumn(AllowanceCol);
						}
						else if(u==12)
						{
							@SuppressWarnings("deprecation")
							AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
							.setTitle("Date of Releaving").setWidth(60).setStyle(numberstyle).setHeaderStyle(headerStyle).build();
							drb.addColumn(AllowanceCol);
						}
						else if(u==13)
						{
							@SuppressWarnings("deprecation")
							AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
							.setTitle("Experience").setWidth(50).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
							drb.addColumn(AllowanceCol);
						}
						else if(u==14)
						{
							
							@SuppressWarnings("deprecation")
							AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
							.setTitle("Salary").setWidth(50).setStyle(amountstyle).setHeaderStyle(headerStyle).build();
							drb.addColumn(AllowanceCol);
						}
						else if(u==15)
						{
							@SuppressWarnings("deprecation")
							AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
							.setTitle("Gross Salary").setWidth(50).setStyle(amountstyle).setHeaderStyle(headerStyle).build();
							drb.addColumn(AllowanceCol);
						}
						else if(u==16)
						{
							@SuppressWarnings("deprecation")
							AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
							.setTitle("Month").setWidth(40).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
							drb.addColumn(AllowanceCol);
						}
						else if(u==17)
						{
							@SuppressWarnings("deprecation")
							AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
							.setTitle("Year").setWidth(40).setStyle(numberstyle).setHeaderStyle(headerStyle).build();
							drb.addColumn(AllowanceCol);
						}
					}

				String scompany="",sbranch="",soffice="",sdept="",smonth="",sorderby="";
				if(!"0".equals(company))
				{
					data1= CommonFunctions.QueryExecute("SELECT CHR_COMPANYNAME FROM com_m_company where INT_COMPANYID="+company);
					if(data1.length>0)
						scompany=data1[0][0];
				}
				else
					scompany="All Companies";
				if(!"0".equals(branch))
				{
					data1= CommonFunctions.QueryExecute("SELECT CHR_BRANCHNAME FROM com_m_branch where INT_BRANCHID="+branch);
					if(data1.length>0)
						sbranch=data1[0][0];
				}
				else
					sbranch="All Branches";
				if(!"0".equals(Office))
				{
					data1= CommonFunctions.QueryExecute("SELECT CHR_OFFICENAME FROM com_m_office where INT_OFFICEID="+Office);
					if(data1.length>0)
						soffice=data1[0][0];
				}
				else
					soffice="All Offices";
				if(!"0".equals(dept))
				{
					data1= CommonFunctions.QueryExecute("SELECT CHR_DEPARTNAME FROM COM_M_DEPART where INT_DEPARTID="+dept);
					if(data1.length>0)
						sdept=data1[0][0];
				}
				else
					sdept="All Departments";
				if(!month.equals("0"))
				smonth=CommonFunctions.getMonthName(Integer.parseInt(month));
				else
					smonth="All Months";
				
				if("a.CHR_STAFFNAME".equals(orderby))
					sorderby="Staff Name";
				else if("a.DT_DOJCOLLEGE".equals(orderby))
					sorderby="Joining Date";

				String reportFilter="Company / Branch / Office / Department / Order By / Resigned Month / Resigned Year :: "+scompany+" / "+sbranch+" / "+soffice+" / "+sdept+" / "+sorderby+" / "+smonth+" / "+year;
				map.put("reportTitle", reportTile);
				map.put("reportFilters", reportFilter);
				jasperPrint =ReportFunctions.createDynamicJasperReport(drb, path, map, al);
				ReportFunctions.generateJasperReport(jasperPrint, request, response, reporttype, Path, rptfilename, reportTile);
			}
			catch (Exception e) 
			{
				System.out.println(e.getMessage());
				request.setAttribute("error", e.getMessage() );
				RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
				dispatchers.forward(request, response);
			}
			finally
			{
				al=null;
			}
		}
	}
}

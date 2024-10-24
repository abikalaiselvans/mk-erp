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

public class StaffPFInfoActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	String hImageExpression="";
	String fImageExpression="";
	
	public String getSqlQuery(String cmpy, String office, String dept, String sorting, String ss, String resigned)
	{
		
		String sql = "";
		
		sql =" SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,g.CHR_COMPANYNAME,f.CHR_BRANCHNAME,c.CHR_DEPARTNAME,  ";
		sql = sql +" i.CHR_DESIGNAME,b.CHR_OFFICENAME ,  ";
		sql = sql +" q.CHR_CATEGORYNAME,  ";
	   	sql = sql +" a.CHR_GENDER, DATE_FORMAT(a.DT_DOB,'%d-%m-%Y'),DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%m-%Y'),a.CHR_MARITALSTATUS,  ";
		sql = sql +" DATE_FORMAT(a.DT_WEDDATE,'%d-%m-%Y'), e.CHR_QUALIFICATIONNAME ,j.CHR_GROUPNAME,   ";
		sql = sql +" a.CHR_EMAILID, a.CHR_MOBILE,   ";
		sql = sql +" a.INT_SALARY,    ";
		sql = sql +" a.CHR_PF ,CONCAT(g.CHR_PFNUMBER,a.CHR_PFNO),  ";
		sql = sql +" a.CHR_ESI ,a.CHR_ESINO,   ";
	   	sql = sql +" FIND_A_BANKGROUP_NAME(a.CHR_BANK) ,CONCAT('A/c : ',a.CHR_ACCNO)    ";
		sql = sql +" FROM com_m_staff a , com_m_office b ,com_m_depart c ,pay_t_allowance d ,  ";
		sql = sql +" com_m_qualification e , com_m_branch f , com_m_company g,   ";
		sql = sql +" com_m_desig i,com_m_bloodgroup j, com_m_employeecategory q  ";
		sql = sql +" WHERE a.INT_DEPARTID = c.INT_DEPARTID   ";
		sql = sql +" AND a.INT_OFFICEID= b.INT_OFFICEID   ";
		sql = sql +" AND a.CHR_EMPID =d.CHR_EMPID   ";
		sql = sql +" AND a.CHR_QUALIFICATION =e.INT_QUALIFICATIONID   ";
		sql = sql +" AND a.INT_BRANCHID =f.INT_BRANCHID   ";
		sql = sql +" AND a.INT_COMPANYID =g.INT_COMPANYID   ";
		sql = sql +" AND a.INT_DESIGID= i.INT_DESIGID   ";
		sql = sql +" AND a.CHR_BG=j.INT_BLOODGROUPID   ";
		  
		
		sql = sql +" AND a.CHR_TYPE !='T'  ";
		sql = sql +" AND a.CHR_CATEGORY= q.INT_EMPLOYEECATEGORYID  ";
		

		if(!"Y".equals(resigned))
		 	sql = sql +" AND  a.CHR_TYPE !='T' " ;
		if(!"0".equals(cmpy))
		 	sql = sql +" AND  a.INT_COMPANYID= "+cmpy;
		if(!"0".equals(office))
		 	sql = sql +" AND  a.INT_OFFICEID= "+office;
		 if(!"0".equals(dept))
			 sql = sql +" AND  a.INT_DEPARTID= "+dept;
		sql = sql+"  ORDER BY "+ sorting +" "+ss;	 
		
		 return sql;
	}

	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String action = request.getParameter("actionS");
		if (action.equals("RPTStaffPFInfo")) 
		{	
			List<HashMap<String,String>> al=new ArrayList<HashMap<String,String>>();
			try 
			{ 
				String reportTile="Staff PF Detail";
				String rptfilename = request.getParameter("rptfilename");
				String reporttype = request.getParameter("reportType");
				String cmpy=request.getParameter("company");
				String Office = request.getParameter("Office");
				String dept = request.getParameter("dept");
				String sorting = request.getParameter("sorting");
				String ss = request.getParameter("ss");
				String Resigned = request.getParameter("Resigned");
				HashMap<Object,Object> map = new HashMap<Object,Object>();

				asql=getSqlQuery(cmpy,Office,dept,sorting,ss,Resigned);
				System.out.println("SQl:"+asql);
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
				DynamicReportBuilder drb=null;
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
							else
								h3.put("d"+j,data1[i][j-1]);
						}
						al.add(h3);
					}
				
				drb = new DynamicReportBuilder();
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
						.setTitle("Father Name").setWidth(90).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==4)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Company").setWidth(120).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==5)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Branch").setWidth(80).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==6)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Department").setWidth(100).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==7)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Designation").setWidth(100).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==8)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Office").setWidth(80).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==9)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Category").setWidth(60).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==10)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Gender").setWidth(50).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==11)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("DOB").setWidth(60).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==12)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("DOJ").setWidth(60).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==13)
					{
						if(("d"+u).equals("M"))
						{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("Married", String.class.getName())
						.setTitle("Marital Status").setWidth(50).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
						}
						else if(("d"+u).equals("U"))
						{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("Unmarried", String.class.getName())
						.setTitle("Marital Status").setWidth(50).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
						}
					}
					else if(u==14)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Wedding Date").setWidth(60).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==15)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Qualification").setWidth(100).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==16)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Blood Group").setWidth(40).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==17)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("EMail Id").setWidth(80).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==18)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Mobile").setWidth(80).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==19)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Salary").setWidth(80).setStyle(amountstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==20)
					{
						if(("d"+u).equals("Y"))
						{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("Yes", String.class.getName())
						.setTitle("PF Type").setWidth(50).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
						}
						else if(("d"+u).equals("N"))
						{
							@SuppressWarnings("deprecation")
							AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("No", String.class.getName())
							.setTitle("PF Type").setWidth(50).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
							drb.addColumn(AllowanceCol);
						}
						else if(("d"+u).equals("C"))
						{
							@SuppressWarnings("deprecation")
							AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("Common", String.class.getName())
							.setTitle("PF Type").setWidth(50).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
							drb.addColumn(AllowanceCol);
						}
					}
					else if(u==21)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("PF No").setWidth(60).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==22)
					{
						if(("d"+u).equals("Y"))
						{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("Yes", String.class.getName())
						.setTitle("ESI Type").setWidth(50).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
						}
						else if(("d"+u).equals("N"))
						{
							@SuppressWarnings("deprecation")
							AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("No", String.class.getName())
							.setTitle("ESI Type").setWidth(50).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
							drb.addColumn(AllowanceCol);
						}
						else if(("d"+u).equals("C"))
						{
							@SuppressWarnings("deprecation")
							AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("Common", String.class.getName())
							.setTitle("ESI Type").setWidth(50).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
							drb.addColumn(AllowanceCol);
						}
					}
					else if(u==23)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("ESI No").setWidth(60).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==24)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Bank").setWidth(150).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==25)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("A/c No").setWidth(80).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					
				}
				
				String scompany="",soffice="",sdept="",sresignersIncluded="";
				if(!"0".equals(cmpy))
				{
						data1= CommonFunctions.QueryExecute("SELECT CHR_COMPANYNAME FROM com_m_company where INT_COMPANYID="+cmpy);
					if(data1.length>0)
						scompany=data1[0][0];
				}
				else
					scompany="All Companies";
				
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
				
				if("Y".equals(Resigned))
					sresignersIncluded="Yes";
				else
					sresignersIncluded="No";
				
				String reportFilter="Company / Office / Department / Resigners Included :: "+scompany+" / "+soffice+" / "+sdept+" / "+sresignersIncluded;
				map.put("reportTitle", reportTile);
				map.put("reportFilters", reportFilter);
				jasperPrint =ReportFunctions.createDynamicJasperReport(drb, path, map, al);
				ReportFunctions.generateJasperReport(jasperPrint, request, response, reporttype, Path, rptfilename, reportTile);
			}
			catch(Exception e) 
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

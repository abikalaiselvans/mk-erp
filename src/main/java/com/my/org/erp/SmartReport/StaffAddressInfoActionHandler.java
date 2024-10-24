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

public class StaffAddressInfoActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	String hImageExpression="";
	String fImageExpression="";
	
	public String getSqlQuery(String cmpy, String branch, String office, String dept, String sorting, String ss,String resigned )
	{
		
		asql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,g.CHR_COMPANYNAME,f.CHR_BRANCHNAME,  ";
		asql = asql + "  FUN_GET_ADDRESS(a.CHR_EMPID,'P','\\n'),  ";
		asql = asql + "  FUN_GET_ADDRESS(a.CHR_EMPID,'S','\\n') ";
		asql = asql + " FROM com_m_staff a ,   ";
		asql = asql + " com_m_branch f , com_m_company g,   "; 
		asql = asql + " com_m_country k,com_m_state l,  ";
		asql = asql + " com_m_district m,com_m_city n    ";
		asql = asql + " WHERE  a.INT_BRANCHID =f.INT_BRANCHID   ";
		asql = asql + " AND a.INT_COMPANYID =g.INT_COMPANYID   ";
		asql = asql + " AND a.CHR_PCITY = n.INT_CITYID   ";
		asql = asql + " AND a.INT_PDISTRICTID=m.INT_DISTRICTID   ";
		asql = asql + " AND a.CHR_PSTATE=l.INT_STATEID   ";
		asql = asql + " AND a.INT_PCOUNTRYID =k.INT_COUNTRYID   ";
		asql = asql + " AND a.CHR_SCITY = n.INT_CITYID   ";
		asql = asql + " AND a.INT_CDISTRICTID=m.INT_DISTRICTID   ";
		asql = asql + " AND a.CHR_SSTATE=l.INT_STATEID   ";
		asql = asql + " AND a.INT_CCOUNTRY =k.INT_COUNTRYID    ";

		if(!"0".equals(cmpy))
			asql = asql + " AND  a.INT_COMPANYID= "+cmpy;
		 if(!"0".equals(branch))
			 	asql = asql +" AND  a.INT_BRANCHID= "+branch;
			
		if(!"0".equals(office))
			asql = asql + " AND  a.INT_OFFICEID= "+office;
		if(!"0".equals(dept))
			asql = asql + " AND  a.INT_DEPARTID= "+dept;	
			
		 if(!"Y".equals(resigned))
			 asql = asql +" AND  a.CHR_TYPE!='T' ";
		
		 
		asql = asql + " ORDER BY  "+ sorting +" "+ss;
		System.out.println(asql);
		 return asql;
	}
	


	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String action = request.getParameter("actionS");
		if (action.equals("RPTStaffAddressInfo")) 
		{	
			List<HashMap<String,String>> al=new ArrayList<HashMap<String,String>>();
			try 
			{ 
				String rptfilename = request.getParameter("rptfilename");
				String reporttype = request.getParameter("reportType");
				String cmpy=request.getParameter("company");
				String branch=request.getParameter("branch");
				String Office = request.getParameter("Office");
				String dept = request.getParameter("dept");
				String sorting = request.getParameter("sorting");
				String ss = request.getParameter("ss");
				String resigned = request.getParameter("resigned");
				HashMap<Object,Object> map = new HashMap<Object,Object>();

				asql=getSqlQuery(cmpy,branch,Office,dept,sorting,ss,resigned);
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
						.setTitle("Staff Id").setWidth(100).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
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
						.setTitle("Company").setWidth(100).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==5)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Branch").setWidth(100).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==6)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Permanent Address").setWidth(200).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==7)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Communication Address").setWidth(200).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
									}
				String reportTile="Staff Address Detail";
				String scompany="",sbranch="",soffice="",sdept="",sresignersIncluded="";
				if(!"0".equals(cmpy))
				{
						data1= CommonFunctions.QueryExecute("SELECT CHR_COMPANYNAME FROM com_m_company where INT_COMPANYID="+cmpy);
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
				
				if("Y".equals(resigned))
					sresignersIncluded="Yes";
				else if("N".equals(resigned))
					sresignersIncluded="No";
				
				String reportFilter="Company / Branch / Office / Department / Resigners Included :: "+scompany+" / "+sbranch+" / "+soffice+" / "+sdept+" / "+sresignersIncluded;
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

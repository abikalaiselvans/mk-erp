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

public class ComBranchActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	String hImageExpression="";
	String fImageExpression="";
	public String getSqlQuery(String companyid)
	{
		String sql="SELECT f.CHR_COMPANYNAME , a.CHR_BRANCHNAME ," +
				"a.CHR_STREET,e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME, b.CHR_COUNTRYNAME," +
				"a.INT_PINCODE,a.CHR_PHONE,a.CHR_FAX, a.CHR_EMAIL, a.CHR_WEBSITE," +
				"a.CHR_REGNO ,a.CHR_TNGSTNO,a.CHR_LOCALTAXNO ,a.CHR_PANNO ,a.INT_ACTIVE" +
				" FROM  com_m_branch a,com_m_country b ," +
				"com_m_state c  ,com_m_district d, com_m_city e,com_m_company f WHERE " +
				"a.INT_COMPANYID=f.INT_COMPANYID AND a.INT_COUNTRYID =b.INT_COUNTRYID " +
				"AND a.INT_STATEID=c.INT_STATEID AND a.INT_DISTRICTID = d.INT_DISTRICTID " +
				"AND a.INT_CITYID = e.INT_CITYID ";
		
		if(!"0".equals(companyid))
			sql = sql+ " AND a.INT_COMPANYID="+companyid;
		
		sql=sql+" ORDER BY a.CHR_BRANCHNAME";
		return sql;
	}
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String action = request.getParameter("actionS");
		if (action.equals("RPTComBranch")) 
		{	
			List<HashMap<String,String>> al=new ArrayList<HashMap<String,String>>();
			try 
			{ 
				String rptfilename = request.getParameter("rptfilename");
				String reporttype = request.getParameter("reportType");
				String companyId = request.getParameter("company");
				HashMap<Object,Object> map = new HashMap<Object,Object>();

				asql=getSqlQuery(companyId);
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
				
				for(int u=0;u<=columnCount;u++)
				{
					if(u==0)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("S.No.").setWidth(25).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==1)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Company").setWidth(100).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==2)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Branch").setWidth(100).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==3)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Address").setWidth(150).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==4)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("City").setWidth(100).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==5)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("District").setWidth(100).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==6)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("State").setWidth(75).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==7)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Country").setWidth(75).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==8)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Postal").setWidth(50).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==9)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Phone").setWidth(80).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==10)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Fax").setWidth(80).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==11)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Email").setWidth(120).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==12)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Website").setWidth(120).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==13)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Reg No").setWidth(75).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==14)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("TNGST No").setWidth(50).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==15)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("Local Tax No").setWidth(50).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==16)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, String.class.getName())
						.setTitle("PAN No").setWidth(75).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
					else if(u==17)
					{
						@SuppressWarnings("deprecation")
						AbstractColumn AllowanceCol = ColumnBuilder.getInstance().setColumnProperty("d"+u, Boolean.class.getName())
						.setTitle("Active Status").setWidth(50).setStyle(detailstyle).setHeaderStyle(headerStyle).build();
						drb.addColumn(AllowanceCol);
					}
				}
				String reportTile="Company Branches Detail";
				String scompany="";
				if(!"0".equals(companyId))
				{
						data1= CommonFunctions.QueryExecute("SELECT CHR_COMPANYNAME FROM com_m_company where INT_COMPANYID="+companyId);
					if(data1.length>0)
						scompany=data1[0][0];
				}
				else
					scompany="All Companies";
				String reportFilter="Company : "+scompany;
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

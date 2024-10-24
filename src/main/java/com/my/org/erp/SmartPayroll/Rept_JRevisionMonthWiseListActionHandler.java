package com.my.org.erp.SmartPayroll;

import java.awt.Color;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.batik.bridge.DynamicGVTBuilder;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRResultSetDataSource;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import ar.com.fdvs.dj.core.DynamicJasperHelper;
import ar.com.fdvs.dj.core.layout.ClassicLayoutManager;
import ar.com.fdvs.dj.domain.CustomExpression;
import ar.com.fdvs.dj.domain.DynamicReport;
import ar.com.fdvs.dj.domain.Style;
import ar.com.fdvs.dj.domain.builders.ColumnBuilder;
import ar.com.fdvs.dj.domain.builders.DynamicReportBuilder;
import ar.com.fdvs.dj.domain.constants.Border;
import ar.com.fdvs.dj.domain.constants.Font;
import ar.com.fdvs.dj.domain.constants.HorizontalAlign;
import ar.com.fdvs.dj.domain.constants.VerticalAlign;
import ar.com.fdvs.dj.domain.entities.columns.AbstractColumn;

import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JRevisionMonthWiseListActionHandler extends AbstractActionHandler 
{

	
	JRExporter exporter;
	protected JasperReport jr;
	protected JasperPrint jp;
	JRDataSource ds;
	String cmpyname="";
	String brname="";
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		System.out.println("inside CTC handle");
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			if(action.equals("PAYRept_JRevisionMonthWise")) 
			{
			
			HashMap<Object,Object> map = new HashMap<Object,Object>();
			String path=Path + "/report/SmartPayroll/" + rptfilename+".jrxml";
			File reportsDir = new File(path);
			
			
			 if (!reportsDir.exists()) 
	          {
	        	  throw new FileNotFoundException(String.valueOf(reportsDir));
	          }
			 
			 String Office= request.getParameter("Office");
			 String Dept= request.getParameter("dept");
			 String fmdate= request.getParameter("frmdate");
			 String todate= request.getParameter("todate");
			 String orderby= request.getParameter("orderby");
			 String Resign= request.getParameter("Resign");
			 fmdate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fmdate);
			 todate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate);
			  
			 
			 map.put("company",cmpyname);
	         map.put("branch", brname);
	     /*    map.put("month", repmon);
	         map.put("year", Year);
	        	*/
			
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
	          Style detailStyle = new Style();
	          detailStyle.setFont(font);
	          detailStyle.setHorizontalAlign(HorizontalAlign.LEFT);
	          detailStyle.setVerticalAlign(VerticalAlign.MIDDLE);
	          detailStyle.setBorder(Border.THIN);
	          detailStyle.setBackgroundColor(Color.cyan);
	          
	          Style amountStyle = new Style();
	          amountStyle.setFont(font);
	          amountStyle.setHorizontalAlign(HorizontalAlign.RIGHT);
	          amountStyle.setVerticalAlign(VerticalAlign.MIDDLE);
	          amountStyle.setBorder(Border.THIN);
	          amountStyle.setBackgroundColor(Color.cyan);
			
	          String sql="";
	          String allowancefield[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME,CHR_FLAG FROM  pay_m_allowance ORDER BY INT_ALLOWANCEID");
	          String sumgrossallowancefield="";
	          String sumothersallowancefield="";
	          String allowancefields="";
	          if(allowancefield.length>0)
	          {
	          	for(int u=0;u<allowancefield.length;u++)
	          	{
	          		if("Y".equals(allowancefield[u][2]))
	          		{
	          			sumgrossallowancefield =sumgrossallowancefield+ " o."+allowancefield[u][0]+"+";
	          		 	allowancefields =allowancefields+ " o."+allowancefield[u][0]+",";
	          		}
	          	}
	          }

	          String allData[]=	allowancefields.split(",");
	           
	          	 


	          sql =  " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,g.CHR_COMPANYNAME,f.CHR_BRANCHNAME,c.CHR_DEPARTNAME,i.CHR_DESIGNAME,b.CHR_OFFICENAME         ,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%m-%Y'),datediff(now(),a.DT_DOJCOLLEGE)  ,a.INT_SALARY,";
	          sql = sql + allowancefields ;
	          sql = sql + " ( " +sumgrossallowancefield +" 0 ) , " ;
	          sql = sql + " ( a.INT_SALARY +" +sumgrossallowancefield +" 0 )  " ; 
	          sql = sql + " ,a.CHR_TYPE,p.CHR_CATEGORYNAME FROM com_m_staff a , com_m_office b ,com_m_depart c ,  ";
	          sql = sql + " com_m_branch f , com_m_company g, ";
	          sql = sql + " com_m_desig i, ";
	          sql = sql + " pay_t_allowance o ,com_m_employeecategory p ";
	          sql = sql + " WHERE a.INT_DEPARTID = c.INT_DEPARTID  ";
	          sql = sql + " AND a.INT_OFFICEID= b.INT_OFFICEID  ";
	           
	          sql = sql + " AND a.INT_BRANCHID =f.INT_BRANCHID  ";
	          sql = sql + " AND a.INT_COMPANYID =g.INT_COMPANYID  ";
	          sql = sql + " AND a.INT_DESIGID= i.INT_DESIGID  ";
	          sql = sql + " AND a.CHR_EMPID =o.CHR_EMPID   AND a.CHR_CATEGORY=p.INT_EMPLOYEECATEGORYID";


	          if(!"0".equals(Office))
	          	sql = sql + " AND a.INT_OFFICEID="+Office;
	          if(!"0".equals(Dept))
	          	sql = sql + " AND a.INT_DEPARTID= "+Dept;
	          if("Y".equals(Resign))
	          	sql = sql+" AND a.CHR_TYPE !='T' ";

	          sql = sql+" AND a.DT_DOJCOLLEGE >= '"+fmdate+"' ";
	          sql = sql+" AND a.DT_DOJCOLLEGE <= '"+todate+"' "; 

	          sql = sql + " ORDER BY "+orderby ;
	      /*    out.println("sql:"+sql);
	           
	          String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				 AbstractColumn EmpIdCol = ColumnBuilder.getInstance()
				  .setColumnProperty("data[u][1])", String.class.getName())
		          .setTitle("Employee Id").setWidth(50)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(EmpIdCol);
		          
		          AbstractColumn EmpNameCol = ColumnBuilder.getInstance()
				  .setColumnProperty("data[u][2])", String.class.getName())
		          .setTitle("Employee Name").setWidth(50)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(EmpNameCol);
		          
		          AbstractColumn OfficeCol = ColumnBuilder.getInstance()
				  .setColumnProperty("data[u][3])", String.class.getName())
		          .setTitle("Office").setWidth(50)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(OfficeCol);
		          
		          AbstractColumn DeptCol = ColumnBuilder.getInstance()
				  .setColumnProperty("data[u][4])", String.class.getName())
		          .setTitle("Department").setWidth(50)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(DeptCol);
		          
		          AbstractColumn CategoryCol = ColumnBuilder.getInstance()
				  .setColumnProperty("data[u][5])", String.class.getName())
		          .setTitle("Category").setWidth(50)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(CategoryCol);
		          
		          AbstractColumn ReportingToCol = ColumnBuilder.getInstance()
				  .setColumnProperty("data[u][6])", String.class.getName())
		          .setTitle("Reporting To").setWidth(50)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(ReportingToCol);
				 for(int u=0;u<data.length;u++)
					{
					 
						//Last effective Date
						if(Integer.parseInt(data[u][0]) >1)
						{
							
							sql = "  SELECT  DATE_FORMAT(a.DAT_EFFECT,'%d-%b-%Y'), a.INT_BASIC,a.INT_INCREMENT,("+salaryband+"), ";
							sql = sql+ "(a.INT_BASIC+a.INT_INCREMENT+"+salaryband+")  FROM pay_t_rivision a ,com_m_staff b  ";
							sql = sql +" WHERE a.CHR_EMPID= b.CHR_EMPID  AND a.CHR_EMPID='"+data[u][1]+"'  AND a.INT_RIVISIONID= "+(Integer.parseInt(data[u][0])-1);
							//out.println(sql);
							String pdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							out.println("<td class=\"boldEleven\"  bgcolor='#6666CC'>"+pdata[0][0]);
							out.println("<td class=\"boldEleven\"  bgcolor='#6666CC' >"+pdata[0][1]);
							out.println("<td class=\"boldEleven\"  bgcolor='#6666CC' >"+pdata[0][2]);
							out.println("<td class=\"boldEleven\"  bgcolor='#6666CC' >"+pdata[0][3]);
							out.println("<td class=\"boldEleven\"  bgcolor='#6666CC' >"+pdata[0][4]);
					
							
							 AbstractColumn LastEffcDtCol = ColumnBuilder.getInstance()
							  .setColumnProperty("pdata[0][0]", String.class.getName())
					          .setTitle("Last Effective Date").setWidth(50)
					          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
					          drb.addColumn(LastEffcDtCol);
					          
					          AbstractColumn LastBasicCol = ColumnBuilder.getInstance()
							  .setColumnProperty("pdata[0][1]", String.class.getName())
					          .setTitle("Last Basic").setWidth(50)
					          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
					          drb.addColumn(LastBasicCol);
					          
					          AbstractColumn LastIncreCol = ColumnBuilder.getInstance()
							  .setColumnProperty("pdata[0][2]", String.class.getName())
					          .setTitle("Last Increment").setWidth(50)
					          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
					          drb.addColumn(LastIncreCol);
					          
					          AbstractColumn LastAllowanceCol = ColumnBuilder.getInstance()
							  .setColumnProperty("pdata[0][3]", String.class.getName())
					          .setTitle("Last Allowance").setWidth(50)
					          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
					          drb.addColumn(LastAllowanceCol);
					          
					          AbstractColumn LastGrossCol = ColumnBuilder.getInstance()
							  .setColumnProperty("pdata[0][4]", String.class.getName())
					          .setTitle("Last Gross").setWidth(50)
					          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
					          drb.addColumn(LastGrossCol);
					          
						
						}
						else
						{
							out.println("<td class=\"boldEleven\"   bgcolor='#6666CC'>&nbsp;");
							out.println("<td class=\"boldEleven\"   bgcolor='#6666CC'>&nbsp;");
							out.println("<td class=\"boldEleven\"   bgcolor='#6666CC'>&nbsp;");
							out.println("<td class=\"boldEleven\"   bgcolor='#6666CC'>&nbsp;");
							out.println("<td class=\"boldEleven\"   bgcolor='#6666CC'>&nbsp;");
						}
						
						out.println("<td class=\"boldEleven\"   bgcolor='#6666FF'>"+data[u][7]);
						out.println("<td class=\"boldEleven\"   bgcolor='#6666FF'>"+data[u][8]);
						out.println("<td class=\"boldEleven\"   bgcolor='#6666FF'>"+data[u][9]);
						out.println("<td class=\"boldEleven\"   bgcolor='#6666FF'>"+data[u][10]);
						out.println("<td class=\"boldEleven\" >"+data[u][11]);
						out.println("<td class=\"boldEleven\" >"+data[u][12]);
						out.println("<td class=\"boldEleven\" >"+data[u][13]);
						
						if("T".equals(data[u][14]))
							out.println("<td class=\"boldEleven\"   align=right>Resigned");
						else
							out.println("<td class=\"boldEleven\"   align=right>&nbsp;");
							
						out.println("<td class=\"boldEleven\"   align=right>"+data[u][15]);
						out.println("<td class=\"boldEleven\"   align=right>"+data[u][16]);
						out.println("<td class=\"boldEleven\"   align=right>"+data[u][17]);
				
					}
				*/
			
				 AbstractColumn SnoCol = ColumnBuilder.getInstance()
				  .setColumnProperty("@rownum:=@rownum+1", String.class.getName())
		          .setTitle("S.No").setWidth(50)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(SnoCol);
				  				 
		          AbstractColumn EMPID = ColumnBuilder.getInstance()
				  .setColumnProperty("CHR_EMPID", String.class.getName())
		          .setTitle("Employee Id").setWidth(150)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(EMPID);
		          
		          AbstractColumn EmpName = ColumnBuilder.getInstance()
				  .setColumnProperty("CHR_STAFFNAME", String.class.getName())
		          .setTitle("Name").setWidth(200)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(EmpName);
		        /*  
		          AbstractColumn Dept = ColumnBuilder.getInstance()
				  .setColumnProperty("CHR_DEPARTNAME", String.class.getName())
		          .setTitle("Department").setWidth(100)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(Dept);*/
		          
		          AbstractColumn Desig = ColumnBuilder.getInstance()
				  .setColumnProperty("CHR_DESIGNAME", String.class.getName())
		          .setTitle("Designation").setWidth(100)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(Desig);
		          
		          AbstractColumn Month = ColumnBuilder.getInstance()
				  .setColumnProperty("CHR_MONTH", String.class.getName())
		          .setTitle("Month").setWidth(80)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(Month);
		          
		          AbstractColumn Year = ColumnBuilder.getInstance()
				  .setColumnProperty("INT_YEAR", String.class.getName())
		          .setTitle("Year").setWidth(50)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(Year);
		          
		          String allowance[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_ANAME FROM pay_m_allowance ORDER BY INT_ALLOWANCEID");
		          
		      /*    for(int u=0;u<allowancedata.length;u++)
		          {
		        	 
		        	  AbstractColumn AllowanceCol = ColumnBuilder.getInstance()
					  .setColumnProperty(allowancedata[u][0], String.class.getName())
			          .setTitle(allowance[u][0]).setWidth(100)
			          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
			          drb.addColumn(AllowanceCol);
						
		        	  
		          }
		          
			 }
				 
			// }
			 
			  drb.setUseFullPageWidth(true);
	          
	          drb.setTemplateFile(path);
	          DynamicReport dr = drb.build();
	          jr = DynamicJasperHelper.generateJasperReport(dr, new ClassicLayoutManager(),map);
	          */
	          ResultSet rs = null;
   		   
			    try{
			                Statement stmt = con.createStatement();
			                rs = stmt.executeQuery(sql);  
			                ds = new JRResultSetDataSource(rs);
			        }
			        catch(Exception e)
			        {
			        	request.setAttribute("error", e.getMessage() );
						RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			    		dispatchers.forward(request, response);
			        }
			       
			          if (ds != null) {
			        	  jp = JasperFillManager.fillReport(jr, map, ds);
			          } else {
			        	  jp = JasperFillManager.fillReport(jr, map);
			          }
//						JasperExportManager.exportReportToPdfFile(jp,"C:/report-out.pdf");
			          ReportFunctions.generateAllReport(exporter, jp, request, response, reporttype, Path, rptfilename);
			          System.out.println("build report ended");
				
	 		}
		
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response);
		}
	}



	

}

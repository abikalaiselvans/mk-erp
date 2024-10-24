package com.my.org.erp.SmartPayroll;

import java.awt.Color;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

 
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRResultSetDataSource;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
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

import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JAllowanceMonthWiseActionHandler extends AbstractActionHandler 
{

	
	JRExporter exporter;
	protected JasperReport jr;
	protected JasperPrint jp;
	JRDataSource ds;
	String cmpyname="";
	String brname="";
	
	
	@SuppressWarnings("deprecation")
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		System.out.println("inside CTC handle");
		try 
		{ 
			String action = request.getParameter("actionS");
			if(action.equals("PAYRept_JAllowanceMonthWise")) 
			{
			
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			HashMap<Object,Object> map = new HashMap<Object,Object>();
			String path=Path + "/report/SmartPayroll/" + rptfilename+".jrxml";
			File reportsDir = new File(path);
			
			
			 if (!reportsDir.exists()) 
	          {
	        	  throw new FileNotFoundException(String.valueOf(reportsDir));
	          }
			 
			String compId= request.getParameter("company");
			String branchId= request.getParameter("branch");
			String mon = request.getParameter("Month");
			String year = request.getParameter("Year");
			mon=DateUtil.getMonth(Integer.parseInt(mon));
			System.out.println("mon:"+mon);
			
			if(!"Select".equals(compId))
				cmpyname = CommonFunctions.QueryExecutecon(con,"SELECT CHR_COMPANYNAME FROM  com_m_company  WHERE INT_COMPANYID="+compId)[0][0];
			else
				cmpyname="ALL";
			if(!"0".equals(branchId))
			{	brname = CommonFunctions.QueryExecutecon(con,"SELECT CHR_BRANCHNAME FROM  com_m_branch  WHERE INT_BRANCHID="+branchId)[0][0];
			}
			else
				brname="ALL";
			
			 map.put("company",cmpyname);
	         map.put("branch", brname);
	         map.put("month", mon);
	         map.put("year", year);
	        	
			
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
			
			String sql = "SELECT CHR_ACODE,CHR_ANAME FROM pay_m_allowance ORDER BY INT_ALLOWANCEID";
			String allowancedata[][] = CommonFunctions.QueryExecute(sql);
			String ssql="";
			for(int u=0;u<allowancedata.length;u++)
				ssql = ssql+" B."+allowancedata[u][0]+",";
			ssql = ssql.substring(0,ssql.length()-1);
			
			sql = "SELECT @rownum:=@rownum+1,A.CHR_EMPID,A.CHR_STAFFNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME,B.CHR_MONTH,B.INT_YEAR,"+ssql;
			sql = sql+ " FROM  com_m_staff  A,PAY_T_SALARYALLOWANCE B,  com_m_depart   C, com_m_desig  D,(SELECT @rownum:=0) r WHERE A.CHR_EMPID=B.CHR_EMPID";
			sql = sql+ " AND A.INT_DESIGID=D.INT_DESIGID AND A.INT_DEPARTID=C.INT_DEPARTID AND ";
			sql = sql + "B.CHR_MONTH='" + mon + "' AND B.INT_YEAR="	+ Integer.parseInt(year);
			sql=sql+" AND A.INT_COMPANYID="+compId;
			if(!branchId.equals("0"))
				sql=sql+" AND A.INT_BRANCHID="+branchId;	
			 System.out.println("sql:"+sql);		
			 
			 String data[][] = CommonFunctions.QueryExecute(sql);
			 
			 
			 if(data.length>0)
			 {
			
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
		          
		          AbstractColumn Dept = ColumnBuilder.getInstance()
				  .setColumnProperty("CHR_DEPARTNAME", String.class.getName())
		          .setTitle("Department").setWidth(100)
		          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
		          drb.addColumn(Dept);
		          
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
		          
		         // String allowance[][] =  CommonFunctions.QueryExecute("SELECT CHR_ANAME FROM pay_m_allowance ORDER BY INT_ALLOWANCEID");
		          for(int u=0;u<allowancedata.length;u++)
		          {
		        	  AbstractColumn AllowanceCol = ColumnBuilder.getInstance()
					  .setColumnProperty(allowancedata[u][0], String.class.getName())
			          .setTitle(allowancedata[u][1]).setWidth(100)
			          .setStyle(detailStyle).setHeaderStyle(headerStyle).build();
			          drb.addColumn(AllowanceCol);
				  }
		          
			 }
			 drb.setUseFullPageWidth(true);
	          
	          drb.setTemplateFile(path);
	          DynamicReport dr = drb.build();
	          jr = DynamicJasperHelper.generateJasperReport(dr, new ClassicLayoutManager(),map);
	          ResultSet rs = null;
   		      try
   		      {
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
			       
	          if (ds != null) 
	          {
	        	  jp = JasperFillManager.fillReport(jr, map, ds);
	          } 
	          else 
	          {
	        	  jp = JasperFillManager.fillReport(jr, map);
	          }
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

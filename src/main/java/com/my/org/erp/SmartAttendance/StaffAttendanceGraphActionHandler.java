package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;
import java.awt.BasicStroke;
import java.awt.Color;
import java.io.OutputStream;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.data.general.DefaultPieDataset;
import org.jfree.data.jdbc.JDBCPieDataset;


public class StaffAttendanceGraphActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			if ("ATTStaffAttendanceGraph".equals(action))	
			{ 
				response.setContentType("image/png");
				OutputStream outputStream = response.getOutputStream();
				JFreeChart chart = getChart( request,  response);
				int width = 800;
				int height = 600;
				ChartUtilities.writeChartAsPNG(outputStream, chart, width, height);
			}
			if ("ATTStaffAttendanceFinancialGraph".equals(action))	
			{ 
				response.setContentType("image/png");
				OutputStream outputStream = response.getOutputStream();
				JFreeChart chart = getFinancialChart( request,  response);
				int width = 800;
				int height = 600;
				ChartUtilities.writeChartAsPNG(outputStream, chart, width, height);
			}
			else if ("ATTStaffAttendanceGraphLocation".equals(action))	
			{ 
				response.setContentType("image/png");
				OutputStream outputStream = response.getOutputStream();
				JFreeChart chart = getChartLocationwise( request,  response);
				int width = 800;
				int height = 600;
				ChartUtilities.writeChartAsPNG(outputStream, chart, width, height);
			}
			else if ("ATTStaffAttendanceGraphLocation1".equals(action))	
			{ 
				JDBCPieDataset dataset = new JDBCPieDataset(con);
				try 
				{
					String office = request.getParameter("office"); 
					String month = request.getParameter("month");
					String year = request.getParameter("year");
					String monthname = "";
					if(!"0".equals(month))
						monthname = com.my.org.erp.Date.Day.getMonth(Integer.parseInt( month));
					String sql ="  ";
					sql = sql + "  SELECT b.CHR_OFFICENAME, ";
					sql = sql + "  SUM(c.DOU_PRESENT) ";
					sql = sql + "  FROM com_m_staff a , com_m_office b , att_t_register c ";
					sql = sql + "  WHERE a.INT_OFFICEID= b.INT_OFFICEID  ";
					sql = sql + "  AND a.CHR_EMPID = c.CHR_EMPID ";
					if(!"0".equals(office))
						sql = sql + "  AND a.INT_OFFICEID = "+office;
					sql = sql + "  AND c.INT_YEAR = "+year;
					if(!"0".equals(month))
						sql = sql + "  AND c.CHR_MONTH = '"+monthname+"'";
					sql = sql + "  GROUP BY b.CHR_OFFICENAME ";
					sql = sql + "  ORDER BY  b.CHR_OFFICENAME ";
					System.out.println(sql);
					dataset.executeQuery(sql);
					JFreeChart chart = ChartFactory.createPieChart
					(
					 "Source of Air Pollution ", // Title
			         dataset,                    // Data
			         true,                       // Display the legend
			         true,                       // Display tool tips
			         false                       // No URLs
					 );
					
					chart.setBorderVisible(true);
					
					if (chart != null) 
					{
						int width = 600;
						int height = 400;
						response.setContentType("image/jpeg");
						OutputStream out = response.getOutputStream();
						ChartUtilities.writeChartAsJPEG(out, chart, width, height);
					}
				}
				catch (Exception e) 
				{
					System.err.println(e.getMessage());
				}
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
	
	
	
	public JFreeChart getChart(HttpServletRequest request, HttpServletResponse response) 
	{
		
		try 
		{
			String ename = request.getParameter("ename"); 
			String month = request.getParameter("month");
			String year = request.getParameter("year");
			String monthname = com.my.org.erp.Date.Day.getMonth(Integer.parseInt( month));
			int fyear = Integer.parseInt( year); 
			String reportinghead = CommonFunctions.QueryExecute("SELECT FIND_A_EMPLOYEE_ID_NAME('"+ename+"')")[0][0];
			if(!"0".equals(month))
				reportinghead = reportinghead + " / "+monthname;
			reportinghead = reportinghead + " / "+ year ;
			String sql ="  ";
			sql = sql + "  SELECT ";
			sql = sql + "  SUM(c.DOU_PRESENT),SUM(c.DOU_ONDUTY),SUM(c.DOU_SUNDAY),SUM(c.DOU_HOLIDAY),SUM(c.DOU_LEAVE),SUM(c.DOU_ABSENT), ";
			sql = sql + "  SUM(INT_LATE),SUM(INT_PERMISSION),SUM(DOU_EXTRADAYS),SUM(DOU_EXTRAHOURS) ";
			sql = sql + "  FROM com_m_staff a , com_m_office b , att_t_register c ";
			sql = sql + "  WHERE a.INT_OFFICEID= b.INT_OFFICEID  ";
			sql = sql + "  AND a.CHR_EMPID = c.CHR_EMPID ";
			sql = sql + "  AND a.CHR_EMPID = '"+ename+"'";;
			sql = sql + "  AND c.INT_YEAR = "+year;
			if(!"0".equals(month))
				sql = sql + "  AND c.CHR_MONTH = '"+monthname+"'";
			sql = sql + "  GROUP BY a.CHR_EMPID  ";
			System.out.println(sql);
			String data[][] = CommonFunctions.QueryExecute(sql);

			DefaultPieDataset dataset = new DefaultPieDataset();
			if(data.length>0)
			{
				dataset.setValue("PRESENT", Double.parseDouble(data[0][0]));
				dataset.setValue("ONDUTY", Double.parseDouble(data[0][1]));
				dataset.setValue("SUNDAY", Double.parseDouble(data[0][2]));
				dataset.setValue("HOLIDAY", Double.parseDouble(data[0][3]));
				dataset.setValue("LEAVE", Double.parseDouble(data[0][4]));
				dataset.setValue("ABSENT", Double.parseDouble(data[0][5]));
				dataset.setValue("LATE", Double.parseDouble(data[0][6]));
				dataset.setValue("PERMISSION", Double.parseDouble(data[0][7]));
				dataset.setValue("EXTRA DAYS", Double.parseDouble(data[0][8]));
				dataset.setValue("EXTRA HOURS", Double.parseDouble(data[0][9]));
			}
			 

			boolean legend = true;
			boolean tooltips = false;
			boolean urls = false;

			JFreeChart chart = ChartFactory.createPieChart(reportinghead, dataset, legend, tooltips, urls);

			chart.setBorderPaint(Color.GREEN);
			chart.setBorderStroke(new BasicStroke(5.0f));
			chart.setBorderVisible(true);

			return chart;
		} 
		catch (NumberFormatException e) 
		{
			System.out.println(e.getMessage());
		}
		return null;
	}
	
	
	public JFreeChart getFinancialChart(HttpServletRequest request, HttpServletResponse response) 
	{
		
		try 
		{
			String ename = request.getParameter("ename"); 
			int year = Integer.parseInt(request.getParameter("Year"));
			String reportinghead = CommonFunctions.QueryExecute("SELECT FIND_A_EMPLOYEE_ID_NAME('"+ename+"')")[0][0];
			reportinghead = reportinghead + " / "+ year  +" - "+(year+1);
			String sql ="  ";
			sql = sql + "  SELECT ";
			sql = sql + "  SUM(c.DOU_PRESENT),SUM(c.DOU_ONDUTY),SUM(c.DOU_SUNDAY),SUM(c.DOU_HOLIDAY),SUM(c.DOU_LEAVE),SUM(c.DOU_ABSENT), ";
			sql = sql + "  SUM(INT_LATE),SUM(INT_PERMISSION),SUM(DOU_EXTRADAYS),SUM(DOU_EXTRAHOURS) ";
			sql = sql + "  FROM com_m_staff a , com_m_office b , att_t_register c ";
			sql = sql + "  WHERE a.INT_OFFICEID= b.INT_OFFICEID  ";
			sql = sql + "  AND a.CHR_EMPID = c.CHR_EMPID ";
			sql = sql + "  AND a.CHR_EMPID = '"+ename+"'";;
			sql = sql + " AND  (     ";
			sql = sql + "      (c.CHR_MONTH in ('April','May','June','July','August','September','October','November','December') AND c.INT_YEAR=("+year+")) "; 
			sql = sql + "      or  ";
			sql = sql + "      (c.CHR_MONTH in ('January','February', 'March') AND c.INT_YEAR=( "+(year+1)+" )  ) ";
			sql = sql + "      )  ";
			sql = sql + "  GROUP BY a.CHR_EMPID  ";
			System.out.println(sql);
			String data[][] = CommonFunctions.QueryExecute(sql);
			DefaultPieDataset dataset = new DefaultPieDataset();
			if(data.length>0)
			{
				dataset.setValue("PRESENT", Double.parseDouble(data[0][0]));
				dataset.setValue("ONDUTY", Double.parseDouble(data[0][1]));
				dataset.setValue("SUNDAY", Double.parseDouble(data[0][2]));
				dataset.setValue("HOLIDAY", Double.parseDouble(data[0][3]));
				dataset.setValue("LEAVE", Double.parseDouble(data[0][4]));
				dataset.setValue("ABSENT", Double.parseDouble(data[0][5]));
				dataset.setValue("LATE", Double.parseDouble(data[0][6]));
				dataset.setValue("PERMISSION", Double.parseDouble(data[0][7]));
				dataset.setValue("EXTRA DAYS", Double.parseDouble(data[0][8]));
				dataset.setValue("EXTRA HOURS", Double.parseDouble(data[0][9]));
			}

			boolean legend = true;
			boolean tooltips = false;
			boolean urls = false;

			JFreeChart chart = ChartFactory.createPieChart(reportinghead, dataset, legend, tooltips, urls);

			chart.setBorderPaint(Color.GREEN);
			chart.setBorderStroke(new BasicStroke(5.0f));
			chart.setBorderVisible(true);

			return chart;
		} 
		catch (NumberFormatException e) 
		{
			System.out.println(e.getMessage());
		}
		return null;
	}
	
	
	public JFreeChart getChartLocationwise(HttpServletRequest request, HttpServletResponse response) 
	{
		
		String office = request.getParameter("office"); 
		String month = request.getParameter("month");
		String year = request.getParameter("year");
		String monthname = "";
		if(!"0".equals(month))
			monthname = com.my.org.erp.Date.Day.getMonth(Integer.parseInt( month));
		String sql ="  ";
		sql = sql + "  SELECT ";
		sql = sql + "  SUM(c.DOU_PRESENT),SUM(c.DOU_ONDUTY),SUM(c.DOU_SUNDAY),SUM(c.DOU_HOLIDAY),SUM(c.DOU_LEAVE),SUM(c.DOU_ABSENT), ";
		sql = sql + "  SUM(INT_LATE),SUM(INT_PERMISSION),SUM(DOU_EXTRADAYS),SUM(DOU_EXTRAHOURS) ";
		sql = sql + "  FROM com_m_staff a , com_m_office b , att_t_register c ";
		sql = sql + "  WHERE a.INT_OFFICEID= b.INT_OFFICEID  ";
		sql = sql + "  AND a.CHR_EMPID = c.CHR_EMPID ";
		if(!"0".equals(office))
			sql = sql + "  AND a.INT_OFFICEID = "+office;
		sql = sql + "  AND c.INT_YEAR = "+year;
		if(!"0".equals(month))
			sql = sql + "  AND c.CHR_MONTH = '"+monthname+"'";
		sql = sql + "  GROUP BY b.CHR_OFFICENAME ";
		sql = sql + "  ORDER BY  b.CHR_OFFICENAME ";
		String data[][]= CommonFunctions.QueryExecute(sql);
		 
		String reportinghead = CommonFunctions.QueryExecute("SELECT CHR_OFFICENAME  FROM com_m_office WHERE INT_OFFICEID ="+office)[0][0];
		if(!"0".equals(month))
			reportinghead = reportinghead + " / "+monthname;
		reportinghead = reportinghead + " / "+ year ;
	 	 
	
		DefaultPieDataset dataset = new DefaultPieDataset();
		if(data.length>0)
		{
			dataset.setValue("PRESENT", Double.parseDouble(data[0][0]));
			dataset.setValue("ONDUTY", Double.parseDouble(data[0][1]));
			dataset.setValue("SUNDAY", Double.parseDouble(data[0][2]));
			dataset.setValue("HOLIDAY", Double.parseDouble(data[0][3]));
			dataset.setValue("LEAVE", Double.parseDouble(data[0][4]));
			dataset.setValue("ABSENT", Double.parseDouble(data[0][5]));
			dataset.setValue("LATE", Double.parseDouble(data[0][6]));
			dataset.setValue("PERMISSION", Double.parseDouble(data[0][7]));
			dataset.setValue("EXTRA DAYS", Double.parseDouble(data[0][8]));
			dataset.setValue("EXTRA HOURS", Double.parseDouble(data[0][9]));
		}

		boolean legend = true;
		boolean tooltips = false;
		boolean urls = false;

		JFreeChart chart = ChartFactory.createPieChart(reportinghead, dataset, legend, tooltips, urls);

		chart.setBorderPaint(Color.GREEN);
		chart.setBorderStroke(new BasicStroke(5.0f));
		chart.setBorderVisible(true);

		return chart;
	}
}
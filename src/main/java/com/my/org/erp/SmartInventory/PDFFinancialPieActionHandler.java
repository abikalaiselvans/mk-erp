package com.my.org.erp.SmartInventory;
 
 
import java.awt.Graphics2D;
import java.awt.geom.Rectangle2D;
import java.io.FileOutputStream;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;
 
import com.lowagie.text.Document;
import com.lowagie.text.pdf.DefaultFontMapper;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfTemplate;
import com.lowagie.text.pdf.PdfWriter;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.common.CommonFunctions;
public class PDFFinancialPieActionHandler extends AbstractActionHandler
{
	
	
	@SuppressWarnings("deprecation")
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			 
			String action=request.getParameter("actionS");
			if(action.equals("INVFinancialYearPieChart"))
			{ 
				String year = request.getParameter("year");
				int fyear = Integer.parseInt( year); 
				year = year.substring(2) +"-"+(""+(fyear+1)).substring(2);
				writeChartToPDF(generateBarChart(request), 700, 600, request.getRealPath("/")+"Smart Inventory/Pdf/Financialyear"+year+".pdf"); 
				
				con.close();   
				response.sendRedirect("Smart Inventory/Pdf/Financialyear"+year+".pdf");
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
	
	
	
	
	
	 
	
	public static void writeChartToPDF(JFreeChart chart, int width, int height, String fileName) 
	{ 
	    PdfWriter writer = null; 
	    Document document = new Document(); 
	 
	    try 
	    { 
	        writer = PdfWriter.getInstance(document, new FileOutputStream( fileName)); 
	        document.open(); 
	        PdfContentByte contentByte = writer.getDirectContent(); 
	        PdfTemplate template = contentByte.createTemplate(width, height); 
	        Graphics2D graphics2d = template.createGraphics(width, height,  new DefaultFontMapper()); 
	        Rectangle2D rectangle2d = new Rectangle2D.Double(0, 0, width,  height); 
	 
	        chart.draw(graphics2d, rectangle2d); 
	 
	        graphics2d.dispose(); 
	        contentByte.addTemplate(template, 0, 0); 
	 
	    }
	    catch (Exception e) 
	    { 
	         System.out.println(e.getMessage()); 
	    } 
	    document.close(); 
	}
	
	//PIE CHART
	public static JFreeChart generatePieChart(HttpServletRequest request) 
	{         
		DefaultPieDataset dataSet = new DefaultPieDataset();
		
		String Branch = request.getParameter("Branch");
		String  division= request.getParameter("division");
		String type = request.getParameter("type");
		String year = request.getParameter("year");
		int fyear = Integer.parseInt( year); 
		String sql ="SELECT '0','0'  ";
		if("1".equals(type))
		{
			sql = "    SELECT  CONCAT(MONTHNAME(a.DAT_SALESDATE),'-',RIGHT(YEAR(a.DAT_SALESDATE),2)), ROUND(SUM(DOU_AMOUNT)/1000000,0 ) ";
			sql = sql + " FROM inv_t_directsales a  ";
			sql = sql + " WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
			sql = sql + "  AND a.DAT_SALESDATE >='"+fyear+"-04-01'  ";
			sql = sql + " AND a.DAT_SALESDATE <='"+(fyear+1)+"-03-31' ";
			if(!"0".equals(Branch))
				sql = sql + " AND a.INT_BRANCHID = "+Branch;
			if(!"0".equals(division))
				sql = sql + " AND a.INT_DIVIID = "+division;
			sql = sql + " GROUP BY  MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
			sql = sql + " order by a.INT_BRANCHID , a.DAT_SALESDATE ";
			
		}
		else if("2".equals(type))
		{
		 	sql = " SELECT CONCAT(MONTHNAME(a.DAT_SALESDATE),'-',RIGHT(YEAR(a.DAT_SALESDATE),2)), ROUND(SUM(DOU_AMOUNT)/1000000,0)";
			sql = sql + " FROM inv_t_servicebilling a  ";
			sql = sql + " WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
			sql = sql + "  AND a.DAT_SALESDATE >='"+fyear+"-04-01'  ";
			sql = sql + " AND a.DAT_SALESDATE <='"+(fyear+1)+"-03-31' ";
			if(!"0".equals(Branch))
				sql = sql + " AND a.INT_BRANCHID = "+Branch;
			if(!"0".equals(division))
				sql = sql + " AND a.INT_DIVIID = "+division;
			sql = sql + " GROUP BY  MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
			sql = sql + " order by a.INT_BRANCHID , a.DAT_SALESDATE ";
			
			

		}
		String data[][] =  CommonFunctions.QueryExecute(sql);
		if(data.length>0)
			for(int u=0;u<data.length;u++)
				dataSet.setValue( data[u][0], Double.parseDouble(data[u][1])   );
		JFreeChart chart = ChartFactory.createPieChart(  "FINANCIAL YEAR ", dataSet, true, true, false);
		return chart;
	}      
	
	
	
	
	
	//BAR CHART
	public static JFreeChart generateBarChart(HttpServletRequest request) 
	{         
		DefaultCategoryDataset dataSet = new DefaultCategoryDataset();
		
		
		String Branch = request.getParameter("Branch");
		String  division= request.getParameter("division");
		String type = request.getParameter("type");
		String year = request.getParameter("year");
		int fyear = Integer.parseInt( year); 
		String sql ="SELECT '0','0'  ";
		if("1".equals(type))
		{
			sql = "    SELECT  CONCAT(MONTHNAME(a.DAT_SALESDATE),'-',RIGHT(YEAR(a.DAT_SALESDATE),2)), ROUND(SUM(DOU_AMOUNT)/1000000,0 ) ";
			sql = sql + " FROM inv_t_directsales a  ";
			sql = sql + " WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
			sql = sql + "  AND a.DAT_SALESDATE >='"+fyear+"-04-01'  ";
			sql = sql + " AND a.DAT_SALESDATE <='"+(fyear+1)+"-03-31' ";
			if(!"0".equals(Branch))
				sql = sql + " AND a.INT_BRANCHID = "+Branch;
			if(!"0".equals(division))
				sql = sql + " AND a.INT_DIVIID = "+division;
			sql = sql + " GROUP BY  MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
			sql = sql + " order by a.INT_BRANCHID , a.DAT_SALESDATE ";
			
		}
		else if("2".equals(type))
		{
		 	sql = " SELECT CONCAT(MONTHNAME(a.DAT_SALESDATE),'-',RIGHT(YEAR(a.DAT_SALESDATE),2)), ROUND(SUM(DOU_AMOUNT)/1000000,0)";
			sql = sql + " FROM inv_t_servicebilling a  ";
			sql = sql + " WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
			sql = sql + "  AND a.DAT_SALESDATE >='"+fyear+"-04-01'  ";
			sql = sql + " AND a.DAT_SALESDATE <='"+(fyear+1)+"-03-31' ";
			if(!"0".equals(Branch))
				sql = sql + " AND a.INT_BRANCHID = "+Branch;
			if(!"0".equals(division))
				sql = sql + " AND a.INT_DIVIID = "+division;
			sql = sql + " GROUP BY  MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
			sql = sql + " order by a.INT_BRANCHID , a.DAT_SALESDATE ";
			
			

		}
		String data[][] =  CommonFunctions.QueryExecute(sql);
		 
		if(data.length>0)
			for(int u=0;u<data.length;u++)
				dataSet.setValue(Double.parseDouble(data[u][1]), "Percentage ",data[u][0]     );
		
		//dataSet.setValue(CommonFunctions.Round((Double.parseDouble(vdata[0][3]))) , "Percentage ", data[u][1]);
		
		 
		JFreeChart chart = ChartFactory.createBarChart( "FINANCIAL YEAR  "+fyear+"-"+(fyear+1) , " MONTH ", " AMOUNT IN LAKHS ", dataSet, PlotOrientation.HORIZONTAL, false, true, false); 
		return chart;    
	}
	
	
	
}

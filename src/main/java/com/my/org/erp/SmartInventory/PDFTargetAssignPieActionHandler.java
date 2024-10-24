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
public class PDFTargetAssignPieActionHandler extends AbstractActionHandler
{
	
	
	@SuppressWarnings("deprecation")
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			 
			String action=request.getParameter("actionS");
			if(action.equals("INVPDFTargetAssignPieChart"))
			{ 
				 
				String type = request.getParameter("type");
				if("Bar".equals(type))
					writeChartToPDF(generateBarChart(request), 700, 600, request.getRealPath("/")+"Smart Inventory/Pdf/barchart.pdf");
				
				if("Pie".equals(type))
					writeChartToPDF(generatePieChart(request), 700, 600, request.getRealPath("/")+"Smart Inventory/Pdf/barchart.pdf"); 
				con.close();   
				response.sendRedirect("Smart Inventory/Pdf/barchart.pdf");
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
	
	
	public static JFreeChart generatePieChart(HttpServletRequest request) 
	{         
		DefaultPieDataset dataSet = new DefaultPieDataset();
		String years= request.getParameter("year");
		String Branch= request.getParameter("Branch");
		String division= request.getParameter("division");
		String months= request.getParameter("month");
		String sql="";
		int year = Integer.parseInt(years);
		int month = Integer.parseInt(months);
		sql ="SELECT INT_CUSTOMERGROUPID,CHR_NAME FROM inv_m_customergroup ORDER BY INT_CUSTOMERGROUPID";
		String data[][]= CommonFunctions.QueryExecute(sql);
		if(data.length>0)
		{
			 
			for(int u=0;u<data.length;u++)
			{
				sql = " SELECT count(*) ";
				sql = sql+ " FROM inv_t_customersalespayment a ,inv_t_directsales b,inv_m_customerinfo c, inv_m_customergroup d ";
				sql = sql+ " WHERE  a.CHR_SALESORDERNO = b.CHR_SALESNO ";
				sql = sql+ " AND b.INT_CUSTOMERID = c.INT_CUSTOMERID ";
				sql = sql+ " AND c.INT_CUSTOMERGROUPID= d.INT_CUSTOMERGROUPID "; 
				sql = sql+ " AND a.INT_BRANCHID= "+Branch;
				if(!"0".equals(division))
					sql = sql+ " AND b.INT_DIVIID= "+division;
				sql = sql+ " AND MONTH(a.DAT_PAYMENTDATE)= "+month;
				sql = sql+ " AND YEAR(a.DAT_PAYMENTDATE) = "+year;
				sql = sql+ " AND d.INT_CUSTOMERGROUPID= "+data[u][0] ;
				
				if(CommonFunction.RecordExist(sql))
				{	
					sql = " SELECT count(*) ,sum(a.DOU_PAIDAMOUNT),sum(DATEDIFF(a.DAT_PAYMENTDATE,b.DAT_SALESDATE)), ";
					sql = sql+ " sum(DATEDIFF(a.DAT_PAYMENTDATE,b.DAT_SALESDATE))/count(*) ";
					sql = sql+ " FROM inv_t_customersalespayment a ,inv_t_directsales b,inv_m_customerinfo c, inv_m_customergroup d ";
					sql = sql+ " WHERE  a.CHR_SALESORDERNO = b.CHR_SALESNO ";
					sql = sql+ " AND b.INT_CUSTOMERID = c.INT_CUSTOMERID ";
					sql = sql+ " AND c.INT_CUSTOMERGROUPID= d.INT_CUSTOMERGROUPID "; 
					sql = sql+ " AND a.INT_BRANCHID= "+Branch;
					if(!"0".equals(division))
						sql = sql+ " AND b.INT_DIVIID= "+division;
					sql = sql+ " AND MONTH(a.DAT_PAYMENTDATE)= "+month;
					sql = sql+ " AND YEAR(a.DAT_PAYMENTDATE) = "+year;
					sql = sql+ " AND d.INT_CUSTOMERGROUPID= "+data[u][0] ;
					String vdata[][]= CommonFunctions.QueryExecute(sql);
					dataSet.setValue( data[u][1],CommonFunctions.Round((Double.parseDouble(vdata[0][3])))   );
					 
					
					 
	   		 	}
				
				 
				
			}
		}
		
		 
		JFreeChart chart = ChartFactory.createPieChart(  "Target Achieve Avgerage Collection PieChart", dataSet, true, true, false);
		return chart;
	}      
	
	public static JFreeChart generateBarChart(HttpServletRequest request) 
	{         
		DefaultCategoryDataset dataSet = new DefaultCategoryDataset();
		
		String years= request.getParameter("year");
		String Branch= request.getParameter("Branch");
		String division= request.getParameter("division");
		String months= request.getParameter("month");
		String sql="";
		int year = Integer.parseInt(years);
		int month = Integer.parseInt(months);
		sql ="SELECT INT_CUSTOMERGROUPID,CHR_NAME FROM inv_m_customergroup ORDER BY INT_CUSTOMERGROUPID";
		String data[][]= CommonFunctions.QueryExecute(sql);
		if(data.length>0)
		{
			 
			for(int u=0;u<data.length;u++)
			{
				sql = " SELECT count(*) ";
				sql = sql+ " FROM inv_t_customersalespayment a ,inv_t_directsales b,inv_m_customerinfo c, inv_m_customergroup d ";
				sql = sql+ " WHERE  a.CHR_SALESORDERNO = b.CHR_SALESNO ";
				sql = sql+ " AND b.INT_CUSTOMERID = c.INT_CUSTOMERID ";
				sql = sql+ " AND c.INT_CUSTOMERGROUPID= d.INT_CUSTOMERGROUPID "; 
				sql = sql+ " AND a.INT_BRANCHID= "+Branch;
				if(!"0".equals(division))
					sql = sql+ " AND b.INT_DIVIID= "+division;
				sql = sql+ " AND MONTH(a.DAT_PAYMENTDATE)= "+month;
				sql = sql+ " AND YEAR(a.DAT_PAYMENTDATE) = "+year;
				sql = sql+ " AND d.INT_CUSTOMERGROUPID= "+data[u][0] ;
				
				if(CommonFunction.RecordExist(sql))
				{	
					sql = " SELECT count(*) ,sum(a.DOU_PAIDAMOUNT),sum(DATEDIFF(a.DAT_PAYMENTDATE,b.DAT_SALESDATE)), ";
					sql = sql+ " sum(DATEDIFF(a.DAT_PAYMENTDATE,b.DAT_SALESDATE))/count(*) ";
					sql = sql+ " FROM inv_t_customersalespayment a ,inv_t_directsales b,inv_m_customerinfo c, inv_m_customergroup d ";
					sql = sql+ " WHERE  a.CHR_SALESORDERNO = b.CHR_SALESNO ";
					sql = sql+ " AND b.INT_CUSTOMERID = c.INT_CUSTOMERID ";
					sql = sql+ " AND c.INT_CUSTOMERGROUPID= d.INT_CUSTOMERGROUPID "; 
					sql = sql+ " AND a.INT_BRANCHID= "+Branch;
					if(!"0".equals(division))
						sql = sql+ " AND b.INT_DIVIID= "+division;
					sql = sql+ " AND MONTH(a.DAT_PAYMENTDATE)= "+month;
					sql = sql+ " AND YEAR(a.DAT_PAYMENTDATE) = "+year;
					sql = sql+ " AND d.INT_CUSTOMERGROUPID= "+data[u][0] ;
					String vdata[][]= CommonFunctions.QueryExecute(sql);
					dataSet.setValue(CommonFunctions.Round((Double.parseDouble(vdata[0][3]))) , "Percentage ", data[u][1]);
					 
					
					 
	   		 	}
				
				 
				
			}
		}
		 
		JFreeChart chart = ChartFactory.createBarChart( "Target Achieve Avgerage Collection Bar Chart", "CUSTOMER GROUP", "TARGET ACHEIVE IN ( % ) ",                 dataSet, PlotOrientation.VERTICAL, false, true, false); 
		return chart;    
	}
	
	
	
}

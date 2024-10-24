package com.my.org.erp.SmartConveyance;
 
 
import java.awt.Graphics2D;
import java.awt.geom.Rectangle2D;
import java.io.FileOutputStream;
import java.io.IOException;
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
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
public class PDFConveyancePieActionHandler extends AbstractActionHandler
{
	
	
	@SuppressWarnings("deprecation")
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			 
			String action=request.getParameter("actionS");
			if(action.equals("CONConveyancePieChart"))
			{ 
				
				String type = request.getParameter("type");
				
				if("Bar".equals(type))
					writeChartToPDF(generateBarChart(request), 700, 600, request.getRealPath("/")+"Smart Conveyance/Pdf/barchart.pdf");
				else
				if("Pie".equals(type))
					writeChartToPDF(generatePieChart(request), 700, 600, request.getRealPath("/")+"Smart Conveyance/Pdf/barchart.pdf"); 
				con.close();   
				response.sendRedirect("Smart Conveyance/pdf/barchart.pdf");
			}
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());			
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
		String company=request.getParameter("company");
		String branch=request.getParameter("branch");
		String office=request.getParameter("office");
		String fromdate=request.getParameter("fromdate");
		String todate=request.getParameter("todate");
		String fromdatesql = DateUtil.FormateDateSQL(fromdate);
		String todatesql = DateUtil.FormateDateSQL(todate);
		String sql="";
		sql = " SELECT a.CHR_EMPID, SUM(a.DOU_TOTAL) ";
		sql = sql + " FROM conveyance_t_conveyance a, com_m_staff b,com_m_office c, com_m_depart d, com_m_employeecategory e ";
		sql = sql + " WHERE a.CHR_EMPID = b.CHR_EMPID ";
		sql = sql + " AND b.INT_OFFICEID = c.INT_OFFICEID ";
		sql = sql + " AND b.INT_DEPARTID= d.INT_DEPARTID ";
		sql = sql + " AND b.CHR_CATEGORY=e.INT_EMPLOYEECATEGORYID ";
		sql = sql + " AND a.CHR_STATUS='Y' ";
		sql = sql + " AND a.CHR_ACCEPT ='Y' ";
		sql = sql + " AND a.CHR_ACCSTATUS='Y' ";
		sql = sql + " AND a.DAT_CONDATE >='"+fromdatesql+"' ";
		sql = sql + " AND a.DAT_CONDATE <='"+todatesql+"' ";
		if(!"0".equals(company))
			sql = sql + " AND   b.INT_COMPANYID ="+company;
		if(!"0".equals(branch))
			sql = sql + " AND   b.INT_BRANCHID ="+branch;
		if(!"0".equals(office))
			sql = sql + " AND   b.INT_OFFICEID ="+office;
			
		sql = sql + " GROUP BY a.CHR_EMPID  ";
		sql = sql + " ORDER BY b.CHR_STAFFNAME,a.DAT_CONDATE ";
		String vdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		if(vdata.length>0)
		{
			 
			for(int u=0;u<vdata.length;u++)
			{
				dataSet.setValue( vdata[u][0], CommonFunctions.Round((Double.parseDouble(vdata[0][1])))   );
				
			}
			
		}
		JFreeChart chart = ChartFactory.createPieChart("Amounts ", dataSet, true, true, false);
		return chart;
	}      
	
	public static JFreeChart generateBarChart(HttpServletRequest request) 
	{         
		DefaultCategoryDataset dataSet = new DefaultCategoryDataset();
		
		String company=request.getParameter("company");
		String branch=request.getParameter("branch");
		String office=request.getParameter("office");
		String fromdate=request.getParameter("fromdate");
		String todate=request.getParameter("todate");
		String fromdatesql = DateUtil.FormateDateSQL(fromdate);
		String todatesql = DateUtil.FormateDateSQL(todate);
		String sql="";
		sql = " SELECT a.CHR_EMPID, SUM(a.DOU_TOTAL) ";
		sql = sql + " FROM conveyance_t_conveyance a, com_m_staff b,com_m_office c, com_m_depart d, com_m_employeecategory e ";
		sql = sql + " WHERE a.CHR_EMPID = b.CHR_EMPID ";
		sql = sql + " AND b.INT_OFFICEID = c.INT_OFFICEID ";
		sql = sql + " AND b.INT_DEPARTID= d.INT_DEPARTID ";
		sql = sql + " AND b.CHR_CATEGORY=e.INT_EMPLOYEECATEGORYID ";
		sql = sql + " AND a.CHR_STATUS='Y' ";
		sql = sql + " AND a.CHR_ACCEPT ='Y' ";
		sql = sql + " AND a.CHR_ACCSTATUS='Y' ";
		sql = sql + " AND a.DAT_CONDATE >='"+fromdatesql+"' ";
		sql = sql + " AND a.DAT_CONDATE <='"+todatesql+"' ";
		if(!"0".equals(company))
			sql = sql + " AND   b.INT_COMPANYID ="+company;
		if(!"0".equals(branch))
			sql = sql + " AND   b.INT_BRANCHID ="+branch;
		if(!"0".equals(office))
			sql = sql + " AND   b.INT_OFFICEID ="+office;
			
		sql = sql + " GROUP BY a.CHR_EMPID  ";
		sql = sql + " ORDER BY b.CHR_STAFFNAME,a.DAT_CONDATE ";
		String vdata[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		if(vdata.length>0)
		{
			 
			for(int u=0;u<vdata.length;u++)
			{
				dataSet.setValue( CommonFunctions.Round((Double.parseDouble(vdata[0][1]))) ,"Percentage ",vdata[u][0]    );
				
			}
			
		}
		JFreeChart chart = ChartFactory.createBarChart( "Amount", "Employee id", " IN ( % ) ",                 dataSet, PlotOrientation.VERTICAL, false, true, false); 
		return chart;    
	}
	
	
	
}

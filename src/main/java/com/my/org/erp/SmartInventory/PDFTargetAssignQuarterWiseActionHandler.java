package com.my.org.erp.SmartInventory;
 
 
import java.awt.Graphics2D;
import java.awt.geom.Rectangle2D;
import java.io.FileOutputStream;
import java.io.IOException;
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
 
import org.jfree.data.general.DefaultPieDataset;
 

import com.lowagie.text.Document;
 
 
 
import com.lowagie.text.pdf.DefaultFontMapper;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfTemplate;
import com.lowagie.text.pdf.PdfWriter;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;
public class PDFTargetAssignQuarterWiseActionHandler extends AbstractActionHandler
{
	
	
	@SuppressWarnings("deprecation")
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			 
			String action=request.getParameter("actionS");
			if(action.equals("INVPDFTargetAssignQuarterWisePieChart"))
			{ 
				String type = request.getParameter("type");
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
	        PdfTemplate template = contentByte.createTemplate(600, 600); 
	        Graphics2D graphics2d = template.createGraphics(width, height,  new DefaultFontMapper()); 
	        Rectangle2D rectangle2d = new Rectangle2D.Double(0, 0, 600,  600); 
	 
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
		HttpSession session = request.getSession();
		String usertype=""+session.getAttribute("USRTYPE");
		String userid=""+session.getAttribute("EMPID");
		
		String years= request.getParameter("year");
		String office= request.getParameter("office");
		String dept= request.getParameter("dept");
		String period= request.getParameter("period");
		String sql="";
		int year = Integer.parseInt(years);
		String title="";
		if("1".equals(period))
			title=" I QUARTER  FOR THE YEAR  ( "+year +" - "+(year+1) +" ) ";
		else if("2".equals(period))
			title=" II QUARTER FOR THE YEAR  ( "+year +" - "+(year+1) +" ) ";
		else if("3".equals(period))
			title=" III QUARTER FOR THE YEAR  ( "+year +" - "+(year+1) +" ) ";
		else if("4".equals(period))
			title=" IV QUARTER FOR THE YEAR  ( "+year +" - "+(year+1) +" ) ";
		else if("5".equals(period))
			title=" ALL QUARTER FOR THE YEAR  ( "+year +" - "+(year+1) +" ) ";
		 
		
		if("1".equals(period))
   		{
   			sql= "SELECT a.CHR_EMPID,a.CHR_STAFFNAME, b.INT_APR, b.INT_MAY, b.INT_JUN,(b.INT_APR+ b.INT_MAY+ b.INT_JUN)  " +
   					"FROM com_m_staff a , inv_t_targetassign b ";
    		sql = sql+" WHERE a.CHR_EMPID =b.CHR_EMPID ";
    		
    		if("A".equals(usertype))
    			sql = sql+" AND a.CHR_EMPID='"+userid+"' ";
    		
    		
    		if(!"0".equals(office))
    			sql = sql+" AND a.INT_OFFICEID="+office;
    		
    		if(!"0".equals(dept))
    			sql = sql+" AND a.INT_DEPARTID="+dept;
    		
    		
    		sql = sql+"  AND b.INT_YEAR = "+year+"  ORDER BY a.CHR_STAFFNAME ";
    		 
    		String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			double salessum=0;
			double achieve=0;
			double percent=0;
			 
			if(data.length>0)
			{	
				for(int u=0;u<data.length;u++)
				{
					salessum=0;
					//This is for Direct Sales
					sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-04-01' AND DAT_SALESDATE <='"+(year)+"-06-31' AND CHR_PAYMENTSTATUS !='S'";
					if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
					{	
						//Direct Sales
						sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-04-01' AND DAT_SALESDATE <='"+(year)+"-06-31' AND CHR_PAYMENTSTATUS !='S'";
						String salesdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata[0][0]));
					}	
					//Direct Billing
					sql = "SELECT count(*) FROM inv_t_directbilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-04-01' AND DAT_SALESDATE <='"+(year)+"-06-31' AND CHR_PAYMENTSTATUS !='S'";
					if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
					{
						sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directbilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-04-01' AND DAT_SALESDATE <='"+(year)+"-06-31' AND CHR_PAYMENTSTATUS !='S'";
						String salesdata1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata1[0][0]));
					}
					
					//Service Billing
					sql = "SELECT COUNT(*) FROM inv_t_servicebilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-04-01' AND DAT_SALESDATE <='"+(year)+"-06-31' AND CHR_PAYMENTSTATUS !='S'";
					if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
					{
						sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_servicebilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-04-01' AND DAT_SALESDATE <='"+(year)+"-06-31' AND CHR_PAYMENTSTATUS !='S'";
						String salesdata2[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
					}
					salessum=CommonFunctions.Round(salessum);
					achieve=CommonFunctions.Round((salessum)/100000);
					percent =CommonFunctions.Round(achieve/Double.parseDouble(data[u][5])*100);
					dataSet.setValue( data[u][1],percent );
				}
				 
 			} 
			
		}
		else if("2".equals(period))
   		{
   			sql= "SELECT a.CHR_EMPID,a.CHR_STAFFNAME, b.INT_JUL, b.INT_AUG, b.INT_SEP,(b.INT_JUL+ b.INT_AUG+ b.INT_SEP)  FROM com_m_staff a , inv_t_targetassign b ";
    		sql = sql+" WHERE a.CHR_EMPID =b.CHR_EMPID ";
    		if(!"0".equals(office))
    			sql = sql+" AND a.INT_OFFICEID="+office;
    		
    		if(!"0".equals(dept))
    			sql = sql+" AND a.INT_DEPARTID="+dept;
    		
    		
    		sql = sql+"   AND b.INT_YEAR = "+year+"  ORDER BY a.CHR_STAFFNAME ";
    		String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			double salessum=0;
			double achieve=0;
			double percent=0;
			 
			if(data.length>0)
			{	
				for(int u=0;u<data.length;u++)
				{
					salessum=0;
					//This is for Direct Sales
					sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-07-01' AND DAT_SALESDATE <='"+(year)+"-09-31' AND CHR_PAYMENTSTATUS !='S'";
					if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
					{	
						
						//Direct Sales
						sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-07-01' AND DAT_SALESDATE <='"+(year)+"-09-31' AND CHR_PAYMENTSTATUS !='S'";
						String salesdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata[0][0]));
					}	
					//Direct Billing
					sql = "SELECT count(*) FROM inv_t_directbilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-07-01' AND DAT_SALESDATE <='"+(year)+"-09-31' AND CHR_PAYMENTSTATUS !='S'";
					if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
					{
						sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directbilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-07-01' AND DAT_SALESDATE <='"+(year)+"-09-31' AND CHR_PAYMENTSTATUS !='S'";
						String salesdata1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata1[0][0]));
					}
					
					//Service Billing
					sql = "SELECT COUNT(*) FROM inv_t_servicebilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-07-01' AND DAT_SALESDATE <='"+(year)+"-09-31' AND CHR_PAYMENTSTATUS !='S'";
					if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
					{
						sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_servicebilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-07-01' AND DAT_SALESDATE <='"+(year)+"-09-31' AND CHR_PAYMENTSTATUS !='S'";
						String salesdata2[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
					}
					salessum=CommonFunctions.Round(salessum);
					achieve=CommonFunctions.Round(salessum/100000);
					percent =CommonFunctions.Round(achieve/Double.parseDouble(data[u][5])*100);
					dataSet.setValue( data[u][1],percent );
				}
				 
 			} 
 	 		 
   		}
		else if("3".equals(period))
   		{
   			sql= "SELECT a.CHR_EMPID,a.CHR_STAFFNAME, b.INT_OCT, b.INT_NOV, b.INT_DEC,(b.INT_OCT+ b.INT_NOV+ b.INT_DEC)  FROM com_m_staff a , inv_t_targetassign b ";
   			//INT_OCT INT_NOV INT_DEC INT_JAN INT_FEB INT_MAR
   			sql = sql+" WHERE a.CHR_EMPID =b.CHR_EMPID ";
   			if(!"0".equals(office))
    			sql = sql+" AND a.INT_OFFICEID="+office;
    		
    		if(!"0".equals(dept))
    			sql = sql+" AND a.INT_DEPARTID="+dept;
    		
    		
    		sql = sql+"   AND b.INT_YEAR = "+year+"  ORDER BY a.CHR_STAFFNAME ";
    		String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			double salessum=0;
			double achieve=0;
			double percent=0;
			 
			if(data.length>0)
			{	
				for(int u=0;u<data.length;u++)
				{
					salessum=0;
					//This is for Direct Sales
					sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-10-01' AND DAT_SALESDATE <='"+(year)+"-12-31' AND CHR_PAYMENTSTATUS !='S'";
					if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
					{	
						
						//Direct Sales
						sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-10-01' AND DAT_SALESDATE <='"+(year)+"-12-31' AND CHR_PAYMENTSTATUS !='S'";
						String salesdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata[0][0]));
					}	
					//Direct Billing
					sql = "SELECT count(*) FROM inv_t_directbilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-10-01' AND DAT_SALESDATE <='"+(year)+"-12-31' AND CHR_PAYMENTSTATUS !='S'";
					if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
					{
						sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directbilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-10-01' AND DAT_SALESDATE <='"+(year)+"-12-31' AND CHR_PAYMENTSTATUS !='S'";
						String salesdata1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata1[0][0]));
						
					}
					
					//Service Billing
					sql = "SELECT COUNT(*) FROM inv_t_servicebilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-10-01' AND DAT_SALESDATE <='"+(year)+"-12-31' AND CHR_PAYMENTSTATUS !='S'";
					if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
					{
						sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_servicebilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+year+"-10-01' AND DAT_SALESDATE <='"+(year)+"-12-31' AND CHR_PAYMENTSTATUS !='S'";
						String salesdata2[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
					}
					salessum=CommonFunctions.Round(salessum);
					achieve=CommonFunctions.Round(salessum/100000);
					percent =CommonFunctions.Round(achieve/Double.parseDouble(data[u][5])*100);
					dataSet.setValue( data[u][1],percent ); 
				 
				}
				 
 			} 
 	 		 
   		}
		else if("4".equals(period))
   		{
   			sql= "SELECT a.CHR_EMPID,a.CHR_STAFFNAME, b.INT_JAN, b.INT_FEB, b.INT_MAR,(b.INT_JAN+ b.INT_FEB+b.INT_MAR)  FROM com_m_staff a , inv_t_targetassign b ";
   			sql = sql+" WHERE a.CHR_EMPID =b.CHR_EMPID ";
   			if(!"0".equals(office))
    			sql = sql+" AND a.INT_OFFICEID="+office;
    		
    		if(!"0".equals(dept))
    			sql = sql+" AND a.INT_DEPARTID="+dept;
    		
    		
    		sql = sql+"   AND b.INT_YEAR = "+year+"  ORDER BY a.CHR_STAFFNAME ";
    		String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			double salessum=0;
			double achieve=0;
			double percent=0;
			 
			if(data.length>0)
			{	
				for(int u=0;u<data.length;u++)
				{
					salessum=0;
					//This is for Direct Sales
					sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year+1)+"-01-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
					if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
					{	
						//	Direct Sales
						sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year+1)+"-01-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
						String salesdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata[0][0]));
					}	
					//Direct Billing
					sql = "SELECT count(*) FROM inv_t_directbilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year+1)+"-01-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
					if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
					{
						sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directbilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year+1)+"-01-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
						String salesdata1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata1[0][0]));
					}
					
					//Service Billing
					sql = "SELECT COUNT(*) FROM inv_t_servicebilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year+1)+"-01-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
					if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
					{
						sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_servicebilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year+1)+"-01-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
						String salesdata2[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
					}
					salessum=CommonFunctions.Round(salessum);
					achieve=CommonFunctions.Round(salessum/100000);
					percent =CommonFunctions.Round((achieve/Double.parseDouble(data[u][5]))*100);
					dataSet.setValue( data[u][1],percent );  
				 
				}
				 
 			} 
 	 		 
   		}
		else if("5".equals(period))
   		{
   			sql= "SELECT a.CHR_EMPID,a.CHR_STAFFNAME, INT_APR,INT_MAY,INT_JUN,INT_JUL,INT_AUG,INT_SEP,INT_OCT,INT_NOV,INT_DEC,INT_JAN,INT_FEB,INT_MAR ,(INT_APR+INT_MAY+INT_JUN+INT_JUL+INT_AUG+INT_SEP+INT_OCT+INT_NOV+INT_DEC+INT_JAN+INT_FEB+INT_MAR)  FROM com_m_staff a , inv_t_targetassign b ";
   			sql = sql+" WHERE a.CHR_EMPID =b.CHR_EMPID ";
   			if(!"0".equals(office))
    			sql = sql+" AND a.INT_OFFICEID="+office;
    		
    		if(!"0".equals(dept))
    			sql = sql+" AND a.INT_DEPARTID="+dept;
    		
    		
    		sql = sql+"   AND b.INT_YEAR = "+year+"  ORDER BY a.CHR_STAFFNAME ";
    		String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			double salessum=0;
			
			double achieve=0;
			double percent=0;
			 
			if(data.length>0)
			{	
				for(int u=0;u<data.length;u++)
				{
					salessum=0;
					//This is for Direct Sales
					sql = "SELECT COUNT(*) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year)+"-04-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
					if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
					{	
						//Direct Sales
						sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directsales WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year)+"-04-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
						String salesdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata[0][0]));
					}	
					//Direct Billing
					sql = "SELECT count(*) FROM inv_t_directbilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year)+"-04-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
					if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
					{
						sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_directbilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year)+"-04-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
						String salesdata1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata1[0][0]));
					}
					
					//Service Billing
					sql = "SELECT COUNT(*) FROM inv_t_servicebilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year)+"-04-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
					if(com.my.org.erp.common.CommonFunction.RecordExist(sql))
					{
						sql = "SELECT SUM(DOU_AMOUNT) FROM inv_t_servicebilling WHERE CHR_REF='"+data[u][0]+"' AND DAT_SALESDATE >='"+(year)+"-04-01' AND DAT_SALESDATE <='"+(year+1)+"-03-31' AND CHR_PAYMENTSTATUS !='S'";
						String salesdata2[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						salessum = salessum+CommonFunctions.Round(Double.parseDouble(salesdata2[0][0]));
					}
					
					salessum=CommonFunctions.Round(salessum);
					achieve=CommonFunctions.Round(salessum/100000);
					percent =CommonFunctions.Round(achieve/Double.parseDouble(data[u][14])*100);
					dataSet.setValue( data[u][1],percent ); 
					 
				}
				 
 			} 
 	 		 
   		}
		
		
		
		
		
		
		
		 
		
		 
		JFreeChart chart = ChartFactory.createPieChart( title, dataSet, true, true, false);
		return chart;
	}      
	
	 
	
	
}

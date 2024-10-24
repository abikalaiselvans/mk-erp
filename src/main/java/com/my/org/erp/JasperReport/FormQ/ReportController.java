package com.my.org.erp.JasperReport.FormQ;

import com.my.org.erp.JasperReport.JdbcUtil;

import java.io.File;
import java.io.IOException;
import java.util.List;




import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperPrint;


@WebServlet("/formq")
public class ReportController extends HttpServlet 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void service(HttpServletRequest request,HttpServletResponse response)
	{
		String month=request.getParameter("month");
		String year=request.getParameter("year");
		System.out.println(month+""+year);
		String fileName=request.getParameter("file");
		String path = getServletContext().getRealPath("/jasper_report_files");
		System.out.println(fileName+"   "+path);
		String sourceFileName=path+"\\"+fileName;
		Bean bean=new Bean();
		List list= bean.generate(month,year,path,fileName,sourceFileName);
	
	 
		try 
		{
			JasperPrint jasperPrint=ReportFunctions.createArraylistReport(null, request, response, new File(path+"\\"+fileName), fileName, bean.getQuery(), JdbcUtil.getJdbcConnection(), path,list);
			ReportFunctions.generateAllReport(null, jasperPrint, request, response, "pdf", fileName);
		} 
		catch (IOException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		catch (ServletException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}
		catch (JRException e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	
 }
}

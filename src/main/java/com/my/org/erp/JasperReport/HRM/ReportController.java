package com.my.org.erp.JasperReport.HRM;

import java.io.File;
import java.util.HashMap;

import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/reports1")
public class ReportController extends HttpServlet 
{

	private static final long serialVersionUID = 1L;
	public void service(HttpServletRequest request,HttpServletResponse response)
	{
		System.out.println();
		System.out.println();
		String fileName=request.getParameter("file");
		String path = getServletContext().getRealPath("/jasper_report_files/hrm");
		String fName=fileName.substring(0,fileName.indexOf("."));
		String type=request.getParameter("export");
		String query=(String)request.getSession().getAttribute("query");
		HashMap<String,Object> param=(HashMap<String,Object>)request.getSession().getAttribute("map");
		System.out.println();
		System.out.println();
		System.out.println("File name : "+fileName);
		System.out.println("Export : " +type);
		System.out.println("Query : "+query);
		System.out.println("Map value :" +param);
		response.setContentType("application/octet-stream");
		try
		{
			ReportTemplate rtemplate=new ReportTemplate();
			byte[] output=null;
			if(fName.equalsIgnoreCase("JApplication"))
				output=rtemplate.generateJApplication(path, fileName, type,query,param);
			else
				output=rtemplate.generate(path, fileName, type,query,param);
			
			response.setHeader("Content-Disposition", "attachment; filename=\"" + fName+"."+type + "\"");
			ServletOutputStream out = response.getOutputStream();
			if(output!=null)
				out.write(output);
         
			out.close();
		 
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		 
	
}

	
}

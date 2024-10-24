package com.my.org.erp.JasperReport;


import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/reports")
public class ReportController extends HttpServlet 
{

	private static final long serialVersionUID = 1L;

	public void service(HttpServletRequest request,HttpServletResponse response)
	{
			String fileName=request.getParameter("file");
			String path = getServletContext().getRealPath("/jasper_report_files");
			System.out.println(fileName+"   "+path+"  ");
			String fName=fileName.substring(0,fileName.indexOf("."));
			String type=request.getParameter("export");
			String query=request.getParameter("query");
			response.setContentType("application/octet-stream");
			try
			{
				ReportTemplate rtemplate=new ReportTemplate();
				byte[] output=rtemplate.generate(path, fileName, type,query);
				response.setHeader("Content-Disposition", "attachment; filename=\"" + fName+"."+type + "\"");
				System.out.println(path+"\\"+fName+"."+type);
				ServletOutputStream out = response.getOutputStream();
				out.write(output);
				out.close();
			
			}
			catch(Exception e)
			{
				System.out.println(e.getMessage());
			}
	}
	
}

package com.my.org.erp.SmartUploadDownload;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.beanutils.BeanUtils;
import com.my.org.erp.bean.SmartUploadDownload.Category;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.file.FileFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class CategoryActionHandler extends AbstractActionHandler 
{

	String courseName;
	int courseId;
	String userid = "" ;
	 

	@SuppressWarnings("rawtypes")
	private void CategoryDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			Category d = new Category();
			Map map=request.getParameterMap();
			BeanUtils.populate(d,map);
			acs = con.prepareCall("{call  COM_PRO_UPLOAD (?,?,?,?,?)}");
			for (int i = 0; i < d.getIds().length; i++) 
			{
				acs.setString(1, "DELETE");
				acs.setString(2, ""+d.getIds()[i]);
				acs.setString(3, "");
				acs.setString(4, "");
				acs.setString(5, "");
				acs.addBatch();
				String directoryName1 = Path+"Smart UploadDownload/Upload/"+CommonFunctions.QueryExecute("SELECT CHR_CATEGORYNAME FROM  upload_m_category WHERE INT_CATEGORYID="+d.getIds()[i])[0][0];
				File f = new File(directoryName1);
				FileFunctions.removeDirectory(f);
				 
				
			}
			acs.executeBatch();
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}

	
	
	
	@SuppressWarnings("rawtypes")
	private void CategoryAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			Category d = new Category();
			Map map=request.getParameterMap();
			BeanUtils.populate(d,map);
			acs = con.prepareCall("{call  COM_PRO_UPLOAD (?,?,?,?,?)}");
			acs.setString(1, "INSERT");
			acs.setString(2, "1");
			acs.setString(3, d.getName());
			acs.setString(4, d.getSdescription());
			acs.setString(5, userid);
			acs.execute();
			String directoryName = Path+"Smart UploadDownload/Upload/"+d.getName();
			 
			boolean success = (new File(directoryName)).mkdir();
			String filename = Path+"Smart UploadDownload/Upload/"+d.getName()+"/index.html";
			File f =new File(filename);
			if(!f.exists())
			  f.createNewFile();
			
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}

	
	
	@SuppressWarnings("rawtypes")
	private void CategoryEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
		 
			Category d = new Category();
			Map map=request.getParameterMap();
			BeanUtils.populate(d,map);
			acs = con.prepareCall("{call  COM_PRO_UPLOAD (?,?,?,?,?)}");
			acs.setString(1, "UPDATE");
			acs.setString(2, ""+d.getId());
			acs.setString(3, d.getName());
			acs.setString(4, d.getSdescription());
			acs.setString(5, userid);
			acs.execute();
			if(d.getName() != d.getDbname())
			{
				String directoryName1 = Path+"Smart UploadDownload/Upload/"+d.getName();
				String directoryName2 = Path+"Smart UploadDownload/Upload/"+d.getDbname();
				File from = new File(directoryName2);
			    if (!from.exists() || !from.isDirectory()) 
			      return;
			    File to = new File(directoryName1);
			    if (from.renameTo(to))
			    	System.out.println("Success!");
			    else
			    	System.out.println("Error");
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
	
	

	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			userid = "" + session.getAttribute("USRID");
			if (action.equals("UPDCategoryDelete")) 
			{
				CategoryDelete(request, response);
				 
				response.sendRedirect("Smart UploadDownload/CategoryView.jsp");
	 		}
			else if (action.equals("UPDCategoryAdd")) 
			{
				CategoryAdd(request, response);
				 
				response.sendRedirect("Smart UploadDownload/CategoryView.jsp");
			} 
			else if (action.equals("UPDCategoryEdit")) 
			{
				CategoryEdit(request, response);
				 
				response.sendRedirect("Smart UploadDownload/CategoryView.jsp");
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

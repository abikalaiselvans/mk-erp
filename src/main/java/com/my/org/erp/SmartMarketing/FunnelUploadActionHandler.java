package com.my.org.erp.SmartMarketing;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
 
public class FunnelUploadActionHandler extends AbstractActionHandler {
	
	 
	 

	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{

		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			final String SAVE_DIR = "uploads"; // Directory to save files

			
			if (action.equals("MKTFunnelUpload")) 
			{
				
				response.setContentType("text/html;charset=UTF-8");
		        PrintWriter out = response.getWriter();
		        
		        // Get the file part
		        Part filePart = request.getPart("excelFile"); // "file" matches the input name in HTML
		        String fileName = filePart.getSubmittedFileName();
 
		        String savePath = Path + File.separator + SAVE_DIR;
		        File fileSaveDir = new File(savePath);
		        if (!fileSaveDir.exists()) {
		            fileSaveDir.mkdir();
		         }

		        // Save the file to the server
		        filePart.write(savePath + File.separator + fileName);
		        String filepath = savePath + File.separator + fileName ;
				System.out.println(filepath);
				 
				Workbook wb = WorkbookFactory.create(new File(filepath));
			      Sheet sheet = wb.getSheetAt(0);
			      DataFormatter df = new DataFormatter();
			      Row row1 = sheet.getRow(0);
			      int physicalCount = row1.getPhysicalNumberOfCells();
			      String value = "";
			      String ME_NAME="";
			      String CLIENT_NAME="";
			      String LOCATION = "";
			      String LOB ="";
			      String OEM ="";
			      String QTY = "";
			      String UNIT ="";
			      String VALUE = "";
			      String TOTAL="";
			      String BOTTOMLINE="";
			      String CATEGORY="";
			      String STAGE="";
			      String APPROX="";
			      String PROBABILITY="";
			      String PROPOSAL="";
			      String REMARKS="";
			    	  
			      for (Row row : sheet) {
			       
			    	  //Cell cell = row.getCell(0);
			    	  ME_NAME = row.getCell(0).toString();
				      CLIENT_NAME=row.getCell(1).toString();
				      LOCATION = row.getCell(2).toString();
				      LOB =row.getCell(3).toString();
				      OEM =row.getCell(4).toString();
				      QTY = row.getCell(5).toString();
				      UNIT =row.getCell(6).toString();
				      VALUE = row.getCell(7).toString();
				      TOTAL=row.getCell(8).toString();
				      BOTTOMLINE=row.getCell(9).toString();
				      CATEGORY=row.getCell(10).toString();
				      STAGE=row.getCell(11).toString();
				      APPROX=row.getCell(12).toString();
				      PROBABILITY=row.getCell(13).toString();
				      PROPOSAL=row.getCell(14).toString();
				      REMARKS=row.getCell(15).toString();
				      System.out.println(TOTAL);  
			      }
			     

		        
				
				/*String ids[] = request.getParameterValues("id");
				asql = " DELETE FROM mkt_m_customergroup WHERE INT_GROUPID =?";
				apstm = con.prepareStatement(asql);
				for (int i = 0; i < ids.length; i++) 
				{
					apstm.setString(1, ids[i]);
					apstm.addBatch();
					
				}
				apstm.executeBatch();
				apstm.close();
				con.close();
				*/
				response.sendRedirect("Smart Marketing/MyFunnel_Upload.jsp");
			}
			 
			
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
		}
	}

}

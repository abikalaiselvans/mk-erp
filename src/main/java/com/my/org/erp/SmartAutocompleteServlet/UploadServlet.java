package com.my.org.erp.SmartAutocompleteServlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Objects;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

import DBConnection.DBCon;
import sample.db.DBConnect;

import java.io.FileInputStream;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

@WebServlet("/UploadFunnels")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
maxFileSize = 1024 * 1024 * 10,      // 10MB
maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class UploadServlet extends HttpServlet {
    // Database credentials and query
    

    private static final String SAVE_DIR = "uploads"; // Directory to save files

    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
            
    	System.out.println("=================");
    	response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        int insertrecordcount=0;
        
        // Get the file part
        Part filePart = request.getPart("excelFile"); // "file" matches the input name in HTML
        String fileName = filePart.getSubmittedFileName();

        // Define the save path (adjust as needed for your server environment)
        String applicationPath = this.getServletContext().getRealPath("");
        String savePath = applicationPath + File.separator + SAVE_DIR;
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
         }

    	System.out.println("=================1");
        // Save the file to the server
        filePart.write(savePath + File.separator + fileName);
    	System.out.println("=================2");
        	 
		String filepath = savePath + File.separator + fileName ;
		System.out.println(filepath);
		 
		System.out.println("=================3");
        
		try {
			
			DBCon con = new DBCon();
			Connection co = con.getConnection();
			Statement st=co.createStatement();
			System.out.println("=================4");
			
	        
		      Workbook wb = WorkbookFactory.create(new File(filepath));
		      Sheet sheet = wb.getSheetAt(0);
		      DataFormatter df = new DataFormatter();
		      //Row row1 = sheet.getRow(0);
		     // int physicalCount = row1.getPhysicalNumberOfCells();
		      String value = "";
		     
		      String ME_NAME="";			String CLIENT_NAME="";			String LOCATION = "";
		      String PRODUCT = "";			String LOB ="";					String OEM ="";
		      String QTY = "0";				String UNIT ="0.0";				String VALUE = "";
		      String TOTAL="";				String BOTTOMLINE="";			String CATEGORY="";
		      String STAGE="";				String APPROX="";				String PROBABILITY="";
		      String PROPOSAL="";			String REMARKS="";				
		    	  
		      double qty=0; double unit=0; double bottomvalue=0;
		     int r=0;
		     List<Funnel> funnelList = new ArrayList<Funnel>();
		      for (Row row : sheet) {
		    	  System.out.println(r);
		    	  if(r>0) {
		    		  try 
			    		  {
				    		  Cell cell = row.getCell(0);
				    		  if(row.getCell(0).toString()!= null  && !row.getCell(0).toString().isEmpty()
				    				  && row.getCell(1).toString()!= null  && !row.getCell(1).toString().isEmpty()
				    				  && row.getCell(2).toString()!= null && !row.getCell(2).toString().isEmpty()
				    				 && row.getCell(3).toString()!= null && !row.getCell(3).toString().isEmpty()
				    				  ) {
						    	  System.out.println("inside for loop-"+r);
						    	  Funnel f = new Funnel();
						    	  f.setME_NAME(""+row.getCell(0).toString());
						    	  f.setCLIENT_NAME(""+row.getCell(1).toString());
						    	  f.setPRODUCT(""+row.getCell(2).toString());
						    	  f.setLOCATION(""+row.getCell(3).toString());
						    	  f.setLOB(""+row.getCell(4).toString());
						    	  f.setOEM(""+row.getCell(5).toString());
						    	 
						    	  if(row.getCell(6).toString()!= null  && !row.getCell(6).toString().isEmpty())
						    		  qty = Double.parseDouble(row.getCell(6).toString());
						    	  
						    	  if(row.getCell(7).toString()!= null && !row.getCell(7).toString().isEmpty())
						    		  unit = Double.parseDouble( row.getCell(7).toString());
						    	  
						    	  if(row.getCell(9).toString()!= null && !row.getCell(9).toString().isEmpty())
						    		  bottomvalue = Double.parseDouble( row.getCell(9).toString());
						    	  
						    	  
						    	  f.setQTY(""+qty);
						    	  f.setUNIT( ""+unit);
						    	  f.setTOTAL(""+(qty * unit));
						    	  f.setBOTTOMLINE(""+bottomvalue);
						    	  f.setCATEGORY(""+row.getCell(10).toString());
						    	  f.setSTAGE(""+row.getCell(11).toString());
						    	  f.setAPPROX(""+row.getCell(12).toString());
						    	  f.setPROBABILITY(""+row.getCell(13).toString());
						    	  f.setPROPOSAL(""+row.getCell(14).toString());
						    	  funnelList.add(f);
						    	  
				    		  }
					    	  
			    		} 
		    		  	catch (Exception e) {
		    		      e.printStackTrace();
		    		      System.out.println(e.getMessage());
		    		       
		    		    } 
		    	  }
		    	   r++;
		      }
		      insertrecordcount = funnelList.size();
		      System.out.println("for ============completed -"+funnelList.size());
		      
		      for (Funnel e : funnelList) {
		    	  String INSERT_SQL = " INSERT INTO mkt_t_funnel  "
				    		+ " ( CHR_ME_NAME,CHR_CLIENT_NAME, CHR_LOCATION,CHR_PRODUCT,CHR_LOB_TYPE,CHR_OEM, " 
				            +" INT_QTY,INT_UNIT,  DOU_TOTAL_VALUE,DOU_BOTTOM_VALUE,CHR_CATEGORY,CHR_STAGE, "
				            +"  CHR_APPR_CLOSURE, CHR_SATUS,CHR_WINNING, CHR_REMARK,CHR_USRNAME, DT_UPDATEDATE, CHR_UPDATESTATUS) " 
				            +" VALUES " 
				            +" ( ?,?, ?,?,?,?, " 
				            +" ?,?,?, ?,?,?,  " 
				            +" ?, ?,?, ?,?, now(), 'Y') ";
			        
					PreparedStatement apstm = co.prepareStatement(INSERT_SQL);
					 
					
		    	    if (e.getME_NAME() != null) {
		    	    		apstm.setString(1, e.getME_NAME());
		    	    		apstm.setString(2, e.getCLIENT_NAME()); 
		    	    		apstm.setString(3, e.getPRODUCT()); 
		    	    		apstm.setString(4, e.getLOCATION()); 
		    	    		apstm.setString(5, e.getLOB()); 
		    	    		apstm.setString(6, e.getOEM());  
					       	apstm.setString(7, e.getQTY());  
					       	apstm.setString(8, e.getUNIT());  
					        apstm.setString(9, e.getTOTAL()); 
					        apstm.setString(10, e.getBOTTOMLINE()); 
					       apstm.setString(11, e.getCATEGORY()); 
					       apstm.setString(12,e.getSTAGE()); 
					       apstm.setString(13, e.getAPPROX()); 
					       apstm.setString(14, e.getPROBABILITY()); 
					       apstm.setString(15, e.getPROPOSAL()); 
					       apstm.setString(16, e.getREMARKS());  
					      apstm.setString(17, "ADMIN");
					      System.out.println(apstm);
					      apstm.addBatch();

		    	    } else {
		    	        System.out.println("Null element encountered, skipping or handling appropriately.");
		    	    }
		    	    apstm.executeBatch();
				       apstm.close();
		    	}
		       
			  co.close();
		      
		    } catch (Exception e) {
		      e.printStackTrace();
		      System.out.println(e.getMessage());
		    } 

        
        
        
        
        
        
        
        out.println("<h3>File " + fileName + " uploaded  and  <b>"+insertrecordcount+"<b> records inserted successfully!</h3>");
    }
 
			/*
			 * try { System.out.println("filePart set========================"); InputStream
			 * is = filePart.getInputStream(); XSSFWorkbook workbook = new XSSFWorkbook(is)
			 * ;
			 * 
			 * System.out.println("Workbook set========================"); Sheet sheet =
			 * workbook.getSheetAt(0); for (Row row : sheet) { System.out.print(
			 * row.getCell(0).getStringCellValue()); System.out.print(
			 * row.getCell(1).getStringCellValue()); System.out.print(
			 * row.getCell(2).getStringCellValue()); }
			 * 
			 * response.getWriter().println("Import Successful"); } catch (Exception e) {
			 * e.printStackTrace(); }
			 */
     

}

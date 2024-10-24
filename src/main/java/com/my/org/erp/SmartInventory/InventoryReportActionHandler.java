package com.my.org.erp.SmartInventory;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class InventoryReportActionHandler extends AbstractActionHandler {
	
	String sql = null;
	String repName = null;
	String repHeader = null;
	int totdays;
	int year;
	int i;
	String s = "";
	

	private void WriteFile(HttpServletRequest request,
			HttpServletResponse response, int noField) throws ServletException,
			IOException {
		try {
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(sql);
			String fline = "";
			String machName=request.getLocalName();
			String filename = machName+"Report.sys";
			FileWriter fw = new FileWriter(filename);
			BufferedWriter bw = new BufferedWriter(fw);
			fline = fline + repName + "\n";
			fline = fline + repHeader + "\n";
			int rcount = 0;			
			while (rs.next()) {
				for (int i = 1; i <= noField; i++) {
					fline = fline + "   " + rs.getString(i) + "^";
				}
				fline = fline + "^\n";
				rcount = rcount + 1;
			}			
			if (rcount < 1)
				fline = fline + "Record not found...";
			bw.write(fline);
			bw.close();
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String action = request.getParameter("actionS");
			action = action.trim();
			//System.out.println("................Testing");
			if (action.equals("INVSupplierReport")) {
				repName = "Supplier Details";
				repHeader = "Id^Supplier Name^Contact Person ^Phone No^Mobile No^FAX^E-Mail^City^State^Area";
				sql="SELECT INT_SUPPLIERID,CHR_SUPPLIERNAME,CHR_CONTACTPERSON,CHR_LANLINE,CHR_MOBILE,CHR_FAX,CHR_EMAIL,";
				sql=sql+"CHR_CITY,CHR_STATE,CHR_AREA ";
				sql=sql+"FROM inv_m_supplier";
				WriteFile(request, response, 10);				
				 
				response.sendRedirect("Smart Inventory/ReportView.jsp");			
			} else if (action.equals("INVItemReport")) {
				repName = "Item Details";
				repHeader = "Id^Supplier Name^Contact Person ^Phone No^Mobile No^FAX^E-Mail^City^State^Area";
				sql="SELECT CHR_ITEMCODE,CHR_ITEMNAME,CHR_ITEMDES,CHR_LANLINE,CHR_MOBILE,CHR_FAX,CHR_EMAIL,";
				sql=sql+"CHR_CITY,CHR_STATE,CHR_AREA ";
				sql=sql+"FROM inv_m_supplier";
				WriteFile(request, response, 10);				
				 
				response.sendRedirect("Smart Inventory/ReportView.jsp");			
			} 
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			response.sendRedirect("error/index.jsp?error="
					+ e.getLocalizedMessage().toString());
		}
	}
}

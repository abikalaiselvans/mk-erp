package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
public class TDSReceivableActionHandler extends AbstractActionHandler{
	String supplierName;
	int supplierId;
	
	private void SupplierList(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		try{	
			ArrayList<Supplier> supplierList=new ArrayList<Supplier>();				
			Statement st=con.createStatement();
			ResultSet rs=st.executeQuery("SELECT * FROM INV_M_SUPPLIER");				
			while (rs.next()) {
				int supplierId = rs.getInt("INT_SUPPLIERID");
				String supplierName=rs.getString("CHR_SUPPLIERNAME");
				String street=rs.getString("CHR_STREET");
				String area=rs.getString("CHR_AREA");
				String city=rs.getString("CHR_CITY");
				String state=rs.getString("CHR_STATE");
				int pin=Integer.parseInt(rs.getString("INT_PIN"));
				String phone=rs.getString("CHR_LANLINE");
				String mobile=rs.getString("CHR_MOBILE");
				String fax=rs.getString("CHR_FAX");
				String email=rs.getString("CHR_EMAIL");
				String contactPerson=rs.getString("CHR_CONTACTPERSON");
				Supplier supplier=new Supplier(supplierId,supplierName,street,area,city,state,pin,phone,mobile,fax,email);
				supplier.setContactPerson(contactPerson);
				supplierList.add(supplier);
			HttpSession session=request.getSession();
			session.setAttribute("supplierList",supplierList);
		}}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	 
	 
 
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {

			if (action.equals("INVTDSReceivable")) {
				String length = ""+request.getParameter("dec");
				String sql = "UPDATE inv_t_customersalespayment SET CHR_TDS_ACCEPT=?, DOU_TDS_RECEIVED_AMOUNT=?, "
						+ "CHR_TDS_REMARK=?,CHR_TDS_RECEIVE_DATE=?";
				sql = sql + " WHERE CHR_SALESORDERNO=? AND INT_PAYMENTID=?"; 
				apstm = con.prepareStatement(sql);
				for (int i = 0; i < Integer.parseInt(length); i++) {
					String accept =  ""+request.getParameter("accept" + i);
					if(accept.equalsIgnoreCase("A")) {
						String ramount = ""+request.getParameter("ramount" + i);
						String remark = ""+request.getParameter("remark" + i);
						String pamount = ""+request.getParameter("pamount" + i);
						String opendate = ""+request.getParameter("opendate" + i);
						opendate = DateUtil.FormateDateSQL(opendate);
						String rowid = ""+request.getParameter("rowid" + i);
						String salesno = ""+request.getParameter("salesno" + i);
						System.out.println(salesno + "/" + rowid + "/" + accept + "/"  + "/" + ramount + "/" + "/"
								+ remark + "/" + opendate);
						double d = Double.parseDouble(pamount)+Double.parseDouble(ramount);
						apstm.setString(1, accept);
						apstm.setString(2, ""+d);
						apstm.setString(3, remark);
						apstm.setString(4, opendate);
						apstm.setString(5, salesno);
						apstm.setString(6, rowid);
						System.out.println("" + apstm);
						apstm.execute();
						System.out.println("==============");
						//apstm.addBatch();
					}
				}
				//apstm.executeBatch();
				System.out.println("==============");
				apstm.close();
				con.close();

				response.sendRedirect("Smart Inventory/TDS_REC_Payment.jsp");
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

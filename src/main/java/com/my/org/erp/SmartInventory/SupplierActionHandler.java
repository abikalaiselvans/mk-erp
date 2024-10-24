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
public class SupplierActionHandler extends AbstractActionHandler{
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
	private void SupplierDelete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		try{						
			String []SupplierId= request.getParameterValues("OptSupplierName");			
			CallableStatement cs = con.prepareCall("{call INV_PRO_SUPPLIER(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			for(int i=0;i<SupplierId.length;i++){				
				cs.setString(1, "DELETE");				
				cs.setString(2,	SupplierId[i]);
				cs.setString(3, "1");
				cs.setString(4, "1");
				cs.setString(5, "1");
				cs.setString(6, "1");
				cs.setString(7, "1");
				cs.setString(8, "1");
				cs.setString(9, "1");
				cs.setString(10, "1");
				cs.setString(11, "1");
				cs.setString(12, "1");
				cs.setString(13, "1");
				cs.setString(14, "1");		
				cs.addBatch();				
			}
			cs.executeBatch();
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	private void SupplierAdd(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		try{
					
			HttpSession session=request.getSession();			
			String userId=""+session.getAttribute("USRID");			
			String supplierName=request.getParameter("TxtSupplierName");
			String contactPerson=request.getParameter("TxtContactPerson");
			String street=request.getParameter("TxtStreet");
			String area=request.getParameter("TxtArea");
			String city=request.getParameter("TxtCity");
			String state=request.getParameter("TxtState");
			String pin=request.getParameter("TxtPin");
			String phone=request.getParameter("TxtPhone");
			String mobile=request.getParameter("TxtMobile");
			String fax=request.getParameter("TxtFax");
			String email=request.getParameter("TxtEmail");
			//System.out.println("ADD DISTR");
			CallableStatement cs = con.prepareCall("{call INV_PRO_SUPPLIER(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, "INSERT");	
			cs.setString(2, "1");
			cs.setString(3, supplierName);
			cs.setString(4, contactPerson);
			cs.setString(5, street);
			cs.setString(6, area);
			cs.setString(7, city);
			cs.setString(8, state);
			cs.setString(9, pin);
			cs.setString(10, phone);
			cs.setString(11, mobile);
			cs.setString(12, fax);
			cs.setString(13, email);
			cs.setString(14, userId);
		    cs.execute();										
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}

	private void SupplierEdit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		try{	
			
			supplierId=Integer.parseInt(request.getParameter("supplierId"));
			//String diagId=request.getParameter("diagId");
			HttpSession session=request.getSession();			
			String userId=""+session.getAttribute("USRID");			
			String supplierName=request.getParameter("TxtSupplierName");
			String contactPerson=request.getParameter("TxtContactPerson");
			String street=request.getParameter("TxtStreet");
			String area=request.getParameter("TxtArea");
			String city=request.getParameter("TxtCity");
			String state=request.getParameter("TxtState");
			String pin=request.getParameter("TxtPin");
			String phone=request.getParameter("TxtPhone");
			String mobile=request.getParameter("TxtMobile");
			String fax=request.getParameter("TxtFax");
			String email=request.getParameter("TxtEmail");
			
			CallableStatement cs = con.prepareCall("{call INV_PRO_SUPPLIER(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, "UPDATE");			
			cs.setInt(2, supplierId);
			cs.setString(3, supplierName);
			cs.setString(4, contactPerson);
			cs.setString(5, street);
			cs.setString(6, area);
			cs.setString(7, city);
			cs.setString(8, state);
			cs.setString(9, pin);
			cs.setString(10, phone);
			cs.setString(11, mobile);
			cs.setString(12, fax);
			cs.setString(13, email);
			cs.setString(14, userId);
		    cs.execute();				
											
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try{
				String action=request.getParameter("actionS");
				//System.out.println(action);
				if(action.equals("INVsupplierList")){
					SupplierList(request,response);		
					con.close();    
					response.sendRedirect("Smart Inventory/SupplierView.jsp");
				}
				else if(action.equals("INVsupplierDelete")){					
					SupplierDelete(request, response);
					SupplierList(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/SupplierView.jsp");
				}
				else if(action.equals("INVsupplierAdd")){					
					SupplierAdd(request, response);
					SupplierList(request, response);
					 
					response.sendRedirect("Smart Inventory/SupplierView.jsp?");
				}
				else if(action.equals("INVsupplierEdit")){					
					SupplierEdit(request, response);
					SupplierList(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/SupplierView.jsp?");
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

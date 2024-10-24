package com.my.org.erp.SmartMarketing;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 
public class  EnquiryCustomerInfoActionHandler extends AbstractActionHandler 
{

	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			if (action.equals("MKTEnquiryEntryDelete")) 
			{
				String ids[] = request.getParameterValues("id");
				acs = con.prepareCall("{call MKT_PRO_ENQUIRYCUSTOMER(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				for (int i = 0; i < ids.length; i++) 
				{
					acs.setString(1, "DELETE");
					acs.setString(2, ids[i]);
					acs.setString(3, "");
					acs.setString(4, "");
					acs.setString(5, "");
					acs.setString(6, "");
					acs.setString(7, "");
					acs.setString(8, "");
					acs.setString(9, "");
					acs.setString(10, "");
					acs.setString(11, "");
					acs.setString(12, "");
					acs.setString(13, "");
					acs.setString(14, "");
					acs.setString(15, "");
					acs.setString(16, "");
					acs.setString(17, "");
					acs.setString(18, "");
					acs.setString(19, "");
					acs.setString(20, "");
					acs.setString(21, "");
					acs.addBatch();
				}
				acs.executeBatch();
				acs.close();
				response.sendRedirect("Smart Marketing/Customerenquiry.jsp");
			}
			else if (action.equals("MKTEnquiryCustomerInfoAdd")) 
			{
				String name ="",cname="",subject="",desc="",contactname="",address1="",city="",district="",state="",country="",pincode="",email="",mobile1="",group="",Asssign="";
				String Ncustomer=request.getParameter("Ncustomer");
				if("Y".equals(Ncustomer))
				{
					name="0";
					cname=request.getParameter("Cusname");//new customer
					contactname=request.getParameter("contactname");
					address1=request.getParameter("address1");
					city=request.getParameter("city");
					district=request.getParameter("district");
					state=request.getParameter("state");
					country=request.getParameter("country");
					pincode=request.getParameter("pincode");
					if("".equals(pincode))
						 pincode="0"; 
					email=request.getParameter("email");
					mobile1=request.getParameter("mobile1");
					if("".equals(mobile1))
						mobile1="0";
					group=request.getParameter("group");
				}
				else
				{
					name=request.getParameter("customer");//old customer [dropdown]	
					group="0";
					city="0";
					district="0";
					state="0";
					pincode="0";
					mobile1="0";
					country="0";
				}
				
				subject=request.getParameter("subject");
				desc=request.getParameter("desc");
				Asssign=request.getParameter("assignto");
				System.out.println(name+"name...cname"+cname+"subject.."+subject+"description..."+desc+"contactname..."+contactname+"address.."+address1+"city..."+city+"district.."+district+"state..."+state+"country..."+country+"pincode..."+pincode+"email..."+email+"mobile..."+mobile1+"group..."+group+"customername..."+Ncustomer+"assignto...."+Asssign);
				java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("yyyy-MM-dd");
				java.util.Date date = new java.util.Date();
				String updatedate = "" + datetime.format(date);
				
				acs = con.prepareCall("{call MKT_PRO_ENQUIRYCUSTOMER(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				acs.setString(1, "INSERT");
				acs.setString(2, "0");
				acs.setString(3, name);
				acs.setString(4, cname);
				acs.setString(5, subject);
				acs.setString(6, desc);
				acs.setString(7, contactname);
				acs.setString(8, address1);
				acs.setString(9, city);
				acs.setString(10, district);
				acs.setString(11, state);
				acs.setString(12, country);
				acs.setString(13, pincode);
				acs.setString(14, email);
				acs.setString(15, mobile1);
				acs.setString(16, group);
				acs.setString(17, Ncustomer);
				acs.setString(18, updatedate);
				acs.setString(19, "N");
				acs.setString(20, user);
				acs.setString(21, Asssign);
				System.out.println(""+acs);
				acs.execute();
				acs.close();
				response.sendRedirect("Smart Marketing/Customerenquiry.jsp");
			} 
			else if (action.equals("MKTEnquiryCustomerInfoEdit")) 
			{
				String name="",cname="",contactname="",address1="",city="",district="",state="",country="",pincode="",email="",mobile1="",group="";
				String ncustom="",Ncustomer="";
				String enquiryid = request.getParameter("enquiryid");
				ncustom=request.getParameter("Ncustomer1");
				if("Y".equals(ncustom))
				{
					 cname=request.getParameter("Cusname");
					 contactname=request.getParameter("contactname");
					 address1=request.getParameter("address1");
					 city=request.getParameter("city");
					 district=request.getParameter("district");
					 state=request.getParameter("state");
					 country=request.getParameter("country");
					 Ncustomer=ncustom;
					 pincode=request.getParameter("pincode");
					 if("".equals(pincode))
						 pincode="0"; 
					 email=request.getParameter("email");
					 mobile1=request.getParameter("mobile1");
					 if("".equals(mobile1))
						 mobile1="0";
					 group=request.getParameter("group");
					 name="0";
				}
				else
				{
					name=request.getParameter("customer");//customer id
					group="0";
					city="0";
					district="0";
					state="0";
					pincode="0";
					mobile1="0";
					country="0";
					ncustom="";
				}
				String Asssign=request.getParameter("assignto");
				String subject=request.getParameter("subject");
				String desc=request.getParameter("desc");
				System.out.println(name+"name...cname"+cname+"subject.."+subject+"description..."+desc+"contactname..."+contactname+"address.."+address1+"city..."+city+"district.."+district+"state..."+state+"country..."+country+"pincode..."+pincode+"email..."+email+"mobile..."+mobile1+"group..."+group+"customername...assignto...."+Asssign+"enquiryid..."+enquiryid);
				java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("yyyy-MM-dd");
				java.util.Date date = new java.util.Date();
				String updatedate = "" + datetime.format(date);
				acs = con.prepareCall("{call MKT_PRO_ENQUIRYCUSTOMER(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				acs.setString(1, "UPDATE");
				acs.setString(2, enquiryid);
				acs.setString(3, name);
				acs.setString(4, cname);
				acs.setString(5, subject);
				acs.setString(6, desc);
				acs.setString(7, contactname);
				acs.setString(8, address1);
				acs.setString(9, city);
				acs.setString(10, district);
				acs.setString(11, state);
				acs.setString(12, country);
				acs.setString(13, pincode);
				acs.setString(14, email);
				acs.setString(15, mobile1);
				acs.setString(16, group);
				acs.setString(17, Ncustomer);
				acs.setString(18, updatedate);
				acs.setString(19, "N");
				acs.setString(20, user);
				acs.setString(21, Asssign);
				System.out.println(""+acs);
				acs.execute();
				acs.close();
				response.sendRedirect("Smart Marketing/Customerenquiry.jsp");
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

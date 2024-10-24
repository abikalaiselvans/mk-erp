package com.my.org.erp.Stock;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class BankBranchActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			HttpSession session=request.getSession();			
			String action=request.getParameter("actionS");
			String userid=""+session.getAttribute("USRID");
			 
			if("STKBankBranchAdd".equals(action)) 
			{
				String bankid= request.getParameter("bankid");
				String branch= request.getParameter("branch");
				String branchcode= request.getParameter("branchcode");
				String add1= request.getParameter("add1");
				String add2= request.getParameter("add2");
				String city= request.getParameter("city");
				String State= request.getParameter("State");
				String pincode= request.getParameter("pincode");
				String phone= request.getParameter("phone");
				String fax= request.getParameter("fax");
				String email= request.getParameter("email");
				String website= request.getParameter("website");
				String swiftcode= request.getParameter("swiftcode");
				acs = con.prepareCall("{call  CON_INV_PRO_BANKBRANCH (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				acs.setString(1,"INSERT");
				acs.setString(2,"1");
				acs.setString(3,bankid);
				acs.setString(4,branch);
				acs.setString(5,branchcode);
				acs.setString(6,add1);
				acs.setString(7,add2);
				acs.setString(8,city);
				acs.setString(9,State);
				acs.setString(10,pincode);
				acs.setString(11,phone);
				acs.setString(12,fax);
				acs.setString(13,email);
				acs.setString(14,website);
				acs.setString(15,swiftcode);
				acs.setString(16,userid);
				acs.execute();
				acs.close();
				con.close();
				response.sendRedirect("SmartStock/BankBranchview.jsp");
			}
			else if("STKBankBranchEdit".equals(action))
			{
				String bankbranchid= request.getParameter("bankbranchid");
				String bankid= request.getParameter("bankid");
				String branch= request.getParameter("branch");
				String branchcode= request.getParameter("branchcode");
				String add1= request.getParameter("add1");
				String add2= request.getParameter("add2");
				String city= request.getParameter("city");
				String State= request.getParameter("State");
				String pincode= request.getParameter("pincode");
				String phone= request.getParameter("phone");
				String fax= request.getParameter("fax");
				String email= request.getParameter("email");
				String website= request.getParameter("website");
				String swiftcode= request.getParameter("swiftcode");
				acs = con.prepareCall("{call CON_INV_PRO_BANKBRANCH (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				acs.setString(1, "UPDATE");
				acs.setString(2, bankbranchid);
				acs.setString(3,bankid);
				acs.setString(4,branch);
				acs.setString(5,branchcode);
				acs.setString(6,add1);
				acs.setString(7,add2);
				acs.setString(8,city);
				acs.setString(9,State);
				acs.setString(10,pincode);
				acs.setString(11,phone);
				acs.setString(12,fax);
				acs.setString(13,email);
				acs.setString(14,website);
				acs.setString(15,swiftcode);
				acs.setString(16,userid);
				acs.execute();
				acs.close();
				con.close();
				response.sendRedirect("SmartStock/BankBranchview.jsp");
			}
			else if("STKBankBranchDelete".equals(action))
			{
				String data[] =request.getParameterValues("BankBranchid");
				try 
				{
					acs = con.prepareCall("{call CON_INV_PRO_BANKBRANCH (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					for(int y=0;y<data.length;y++)
					{
						acs.setString(1, "DELETE");
						acs.setString(2,data[y]);
						acs.setString(3,"1");
						acs.setString(4,"1");
						acs.setString(5,"1");
						acs.setString(6,"1");
						acs.setString(7,"1");
						acs.setString(8,"1");
						acs.setString(9,"1");
						acs.setString(10,"1");
						acs.setString(11,"1");
						acs.setString(12,"1");
						acs.setString(13,"1");
						acs.setString(14,"1");
						acs.setString(15,"1");
						acs.setString(16, userid);
						acs.addBatch();				
					}
					acs.executeBatch();
					acs.close();
					con.close();
				}
				catch(Exception e)
				{
				
					System.out.println(e.getMessage());
				}

				response.sendRedirect("SmartStock/BankBranchview.jsp");
				
			}
			 
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());			
		}
	}	
}

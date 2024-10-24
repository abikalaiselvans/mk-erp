package com.my.org.erp.SmartInventory;
import java.io.IOException;
 
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

import org.apache.commons.beanutils.BeanUtils;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 public class BankInfoActionHandler extends AbstractActionHandler
{
	
	 public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	 {
		try
		{
				String action=request.getParameter("actionS");
				System.out.println("\n\n"+action+"\n"); 
				 
				if("INVbankInfoAdd".equals(action))
				{
					
					
					Bank d = new Bank();
					@SuppressWarnings("rawtypes")
					Map map=request.getParameterMap();
					BeanUtils.populate(d,map);
					asql ="";
					asql ="INSERT INTO com_m_bank (" ;
					asql = asql +"  INT_BANKGROUPID,CHR_BRANCH,CHR_BRANCHCODE,CHR_IFSCCODE,CHR_MCRCODE,CHR_SWIFTCOSE,  ";
					asql = asql +" CHR_ADDRESS1,CHR_ADDRESS2,INT_CITYID,INT_DISTRICTID,INT_STATEID,INT_COUNTRYID,INT_PINCODE, ";
					asql = asql +" CHR_AREACODE,CHR_PHONE,CHR_MOBILE,CHR_FAX,CHR_EMAIL,CHR_WEBSITE,   ";
					asql = asql + " CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ";
					asql = asql + " )";
					asql = asql + " VALUES (";
					asql = asql +"  ?,?,?,?,?,?,  ";
					asql = asql +" ?,?,?,?,?,?,?, ";
					asql = asql +" ?,?,?,?,?,? ,  ";
					asql = asql + " ?,DATE(NOW()),'Y' ";
					asql = asql + " )";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, ""+d.getBankgroup());
					apstm.setString(2, d.getBranchname());
					apstm.setString(3, d.getBranchcode());
					apstm.setString(4, d.getIfsccode());
					apstm.setString(5, d.getMcrcode());
					apstm.setString(6, d.getSwiftcode());
					apstm.setString(7,d.getAddress1());
					apstm.setString(8,d.getAddress2());
					apstm.setString(9,""+d.getCity());
					apstm.setString(10,""+d.getDistrict());
					apstm.setString(11,""+d.getState());
					apstm.setString(12,""+d.getCountry());
					apstm.setString(13,""+d.getPin());
					apstm.setString(14,d.getArea());
					apstm.setString(15,d.getPhone());
					apstm.setString(16,d.getMobile());
					apstm.setString(17,d.getFax());
					apstm.setString(18,d.getEmail());
					apstm.setString(19,d.getWebsite());
					apstm.setString(20,auserid);
					System.out.println(""+apstm);
					apstm.execute();
					con.close();    
					response.sendRedirect("Smart Inventory/BankInfo.jsp");
				}	
				else if("INVbankinfoUpdate".equals(action))
				{ 
					Bank d = new Bank();
					@SuppressWarnings("rawtypes")
					Map map=request.getParameterMap();
					BeanUtils.populate(d,map);
					asql ="";
					asql ="UPDATE com_m_bank  SET" ;
					asql = asql +"  INT_BANKGROUPID=?,CHR_BRANCH=?,CHR_BRANCHCODE=?,CHR_IFSCCODE=?,CHR_MCRCODE=?,CHR_SWIFTCOSE=?,  ";
					asql = asql +" CHR_ADDRESS1=?,CHR_ADDRESS2=?,INT_CITYID=?,INT_DISTRICTID=?,INT_STATEID=?,INT_COUNTRYID=?,INT_PINCODE=?, ";
					asql = asql +" CHR_AREACODE=?,CHR_PHONE=?,CHR_MOBILE=?,CHR_FAX=?,CHR_EMAIL=?,CHR_WEBSITE=?,   ";
					asql = asql + " CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y' WHERE INT_BANKID =?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, ""+d.getBankgroup());
					apstm.setString(2, d.getBranchname());
					apstm.setString(3, d.getBranchcode());
					apstm.setString(4, d.getIfsccode());
					apstm.setString(5, d.getMcrcode());
					apstm.setString(6, d.getSwiftcode());
					apstm.setString(7,d.getAddress1());
					apstm.setString(8,d.getAddress2());
					apstm.setString(9,""+d.getCity());
					apstm.setString(10,""+d.getDistrict());
					apstm.setString(11,""+d.getState());
					apstm.setString(12,""+d.getCountry());
					apstm.setString(13,""+d.getPin());
					apstm.setString(14,d.getArea());
					apstm.setString(15,d.getPhone());
					apstm.setString(16,d.getMobile());
					apstm.setString(17,d.getFax());
					apstm.setString(18,d.getEmail());
					apstm.setString(19,d.getWebsite());
					apstm.setString(20,auserid);
					apstm.setString(21,""+d.getRowid());
					System.out.println(""+apstm);
					apstm.execute();
					con.close();
					response.sendRedirect("Smart Inventory/BankInfo.jsp");
					
				}
				else if("INVbankinfoDelete".equals(action))
				{
					
					String rowids[] = request.getParameterValues("rowid");
					asql ="DELETE FROM com_m_bank Where  INT_BANKID = ?";
					apstm = con.prepareStatement(asql);
					for(int u=0; u<rowids.length;u++)
					{
						apstm.setString(1, rowids[u]);
						apstm.addBatch();
					}
					System.out.println(""+apstm);
					apstm.executeBatch();
					con.close(); 
					response.sendRedirect("Smart Inventory/BankInfo.jsp");
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
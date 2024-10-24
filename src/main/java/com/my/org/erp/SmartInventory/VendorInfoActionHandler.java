package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.BeanUtils;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class VendorInfoActionHandler extends AbstractActionHandler
{
	 public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	 {
		try
		{
				String action=request.getParameter("actionS");
				if("INVVendorInfoAdd".equals(action))
				{
					Vendor d = new Vendor();
					@SuppressWarnings("rawtypes")
					Map map=request.getParameterMap();
					BeanUtils.populate(d,map);
					asql ="";
					asql ="INSERT INTO inv_m_vendorsinformation (" ;
					asql = asql + " CHR_VENDORNAME,CHR_CONTACTPERSON,CHR_ADDRESS1,CHR_ADDRESS2, ";
					asql = asql + " INT_CITYID,INT_DISTRICTID,INT_STATEID,INT_COUNTRYID,INT_PINCODE, ";
					asql = asql + " CHR_AREACODE,CHR_PHONE,CHR_MOBILE,CHR_FAX,CHR_EMAIL,CHR_WEBSITE, ";
					asql = asql + " INT_ACTIVE, CHR_ACCNO,INT_BANKGROUPID,DOU_BALANCE, ";
					asql = asql + "  DAT_BALANCEASOF , ";
					asql = asql + " INT_GROUPID,CHR_TINNO,CHR_CSTNO,CHR_PANNO,CHR_GSTNO,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ";
					asql = asql + " )";
					asql = asql + " VALUES (";
					asql = asql + " ?,?,?,?, ";
					asql = asql + " ?,?,?,?,?, ";
					asql = asql + " ?,?,?,?,?,?,?, ";
					asql = asql + " ?,?,?,?, ";
					asql = asql + " ?, ";
					asql = asql + " ?,?,?,?,?,DATE(NOW()),'Y' ";
					asql = asql + " )";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,d.getName().replaceAll("&", " AND ").toUpperCase());
					apstm.setString(2,d.getCperson().replaceAll("&", " AND ").toUpperCase());
					apstm.setString(3,d.getAddress1());
					apstm.setString(4,d.getAddress2());
					apstm.setString(5,""+d.getCity());
					apstm.setString(6,""+d.getDistrict());
					apstm.setString(7,""+d.getState());
					apstm.setString(8,""+d.getCountry());
					apstm.setString(9,""+d.getPin());
					apstm.setString(10,d.getArea());
					apstm.setString(11,d.getPhone());
					apstm.setString(12,d.getMobile());
					apstm.setString(13,d.getFax());
					apstm.setString(14,d.getEmail());
					apstm.setString(15,d.getWebsite());
					apstm.setString(16,d.getStatus());
					apstm.setString(17,d.getAccno());
					apstm.setString(18,d.getBank());
					apstm.setString(19,""+d.getClimit());
					apstm.setString(20,DateUtil.FormateDateSQL(d.getDoh()));
					apstm.setString(21,d.getVendorgroup());
					apstm.setString(22,d.getTin());
					apstm.setString(23,d.getCst() );
					apstm.setString(24,d.getPan() );
					apstm.setString(25,d.getGst());
					apstm.setString(26,auserid);
					System.out.println(""+apstm);
					apstm.execute();
					con.close();    
					response.sendRedirect("Smart Inventory/VendorInfo.jsp");
				}	
				else if("INVVendorInfoUpdate".equals(action))
				{
					Vendor d = new Vendor();
					@SuppressWarnings("rawtypes")
					Map map=request.getParameterMap();
					BeanUtils.populate(d,map);
					asql ="";
					asql ="UPDATE inv_m_vendorsinformation SET " ;
					asql = asql + " CHR_VENDORNAME=?,CHR_CONTACTPERSON=?,CHR_ADDRESS1=?,CHR_ADDRESS2=?, ";
					asql = asql + " INT_CITYID=?,INT_DISTRICTID=?,INT_STATEID=?,INT_COUNTRYID=?,INT_PINCODE=?, ";
					asql = asql + " CHR_AREACODE=?,CHR_PHONE=?,CHR_MOBILE=?,CHR_FAX=?,CHR_EMAIL=?,CHR_WEBSITE=?, ";
					asql = asql + " INT_ACTIVE=?, CHR_ACCNO=?,INT_BANKGROUPID=?,DOU_BALANCE=?, ";
					asql = asql + "  DAT_BALANCEASOF=? , ";
					asql = asql + " INT_GROUPID=?,CHR_TINNO=?,CHR_CSTNO=?,CHR_PANNO=?,CHR_GSTNO=?,CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y' ";
					asql = asql + " WHERE INT_VENDORID=?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,d.getName().replaceAll("&", " AND ").toUpperCase());
					apstm.setString(2,d.getCperson().replaceAll("&", " AND ").toUpperCase());
					apstm.setString(3,d.getAddress1());
					apstm.setString(4,d.getAddress2());
					apstm.setString(5,""+d.getCity());
					apstm.setString(6,""+d.getDistrict());
					apstm.setString(7,""+d.getState());
					apstm.setString(8,""+d.getCountry());
					apstm.setString(9,""+d.getPin());
					apstm.setString(10,d.getArea());
					apstm.setString(11,d.getPhone());
					apstm.setString(12,d.getMobile());
					apstm.setString(13,d.getFax());
					apstm.setString(14,d.getEmail());
					apstm.setString(15,d.getWebsite());
					apstm.setString(16,d.getStatus());
					apstm.setString(17,d.getAccno());
					apstm.setString(18,d.getBank());
					apstm.setString(19,""+d.getClimit());
					apstm.setString(20,DateUtil.FormateDateSQL(d.getDoh()));
					apstm.setString(21,d.getVendorgroup());
					apstm.setString(22,d.getTin());
					apstm.setString(23,d.getCst() );
					apstm.setString(24,d.getPan() );
					apstm.setString(25,d.getGst());
					apstm.setString(26,auserid);
					apstm.setString(27,""+d.getRowid());
					System.out.println(""+apstm);
					apstm.execute();
					con.close();
					response.sendRedirect("Smart Inventory/VendorInfo.jsp");
				}
				else if("INVvendorInfoDelete".equals(action))
				{
					String vendorids[] = request.getParameterValues("rowid");
					asql ="DELETE FROM inv_m_vendorsinformation Where  INT_VENDORID = ?";
					apstm = con.prepareStatement(asql);
					for(int u=0; u<vendorids.length;u++)
					{
						apstm.setString(1, vendorids[u]);
						apstm.addBatch();
					}
					System.out.println(""+apstm);
					apstm.executeBatch();
					con.close();    
					response.sendRedirect("Smart Inventory/VendorInfo.jsp");
				}
		}
				 
		catch (Exception e) 
		{
			System.out.println(""+e.getMessage());	
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
							
			 
		}
	}	
}
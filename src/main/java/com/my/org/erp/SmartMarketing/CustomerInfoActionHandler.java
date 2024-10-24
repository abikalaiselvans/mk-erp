package com.my.org.erp.SmartMarketing;
import java.io.IOException;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.beanutils.BeanUtils;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.bean.SmartMarketing.CustomerInfo;
import com.my.org.erp.common.CommonFunctions;

 
public class  CustomerInfoActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			String createdby  = (String) session.getAttribute("EMPID");
			if (action.equals("MKTCustomerInfoDelete")) 
			{
				String ids[] = request.getParameterValues("id");
				asql = " DELETE FROM mkt_m_customerinfo WHERE INT_CUSTOMERID =?";
				apstm = con.prepareStatement(asql);
				for (int i = 0; i < ids.length; i++) 
				{
					apstm.setString(1, ids[i]);
					apstm.addBatch();
					
				}
				apstm.executeBatch();
				apstm.close();
				con.close();
				 
				response.sendRedirect("Smart Marketing/CustomerInfo.jsp");
			}
			else if (action.equals("MKTCustomerInfoAdd")) 
			{
				CustomerInfo  d = new CustomerInfo();
				@SuppressWarnings("rawtypes")
				Map map = request.getParameterMap();
				BeanUtils.populate(d, map);
				acs = con.prepareCall("{call MKT_PRO_CUSTOMERINFO(?,?,?,?,?, ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				acs.setString(1, "INSERT");
				acs.setString(2, "1");
				acs.setString(3,d.getName());
				acs.setString(4,d.getAlias());
				acs.setString(5,""+d.getCname());
				acs.setString(6,d.getAddress1());
				acs.setString(7,d.getAddress2());
				acs.setString(8,d.getAddress3());
				acs.setString(9,""+d.getCity());
				acs.setString(10,""+d.getDistrict() );
				acs.setString(11,""+d.getState());
				acs.setString(12,""+d.getCountry() );
				acs.setString(13,""+d.getPincode());
				acs.setString(14,""+d.getPhone1());
				acs.setString(15,""+d.getExtn1());
				acs.setString(16,""+d.getPhone2());
				acs.setString(17,""+d.getExtn2() );
				acs.setString(18,""+d.getMobile1() );
				acs.setString(19,""+d.getMobile2() );
				acs.setString(20,""+d.getFax() );
				acs.setString(21,d.getEmail() );
				acs.setString(22,d.getWebsite() );
				acs.setString(23,d.getActive() );
				acs.setString(24,""+d.getGroup() );
				acs.setString(25, createdby);
				acs.setString(26, "");
				acs.setString(27, d.getSalute());
				acs.setString(28, ""+d.getAreacode());
				acs.setString(29, d.getMemo());
				acs.setString(30,d.getAlias1());
				acs.setString(31,d.getSalute1());
				acs.setString(32,d.getName1());
				acs.setString(33,d.getDesigination1());
				acs.setString(34,d.getDesigination2());
				acs.setString(35, user);
				System.out.println(""+acs);
				acs.execute();
				acs.close();
				con.close();//alias1,salute1,name1,desigination1,desigination2
				response.sendRedirect("Smart Marketing/CustomerInfo.jsp");
				//response.sendRedirect("Smart Marketing/CustomerInfoAction.jsp?action1=Add&customerrowid="+d.getCname()+"&msg=Added Sucessfully...");
			} 
			else if (action.equals("MKTCustomerInfoEdit")) 
			{
				try 
				{
					CustomerInfo  d = new CustomerInfo();
					Map map = request.getParameterMap();
					BeanUtils.populate(d, map);
					asql = " UPDATE mkt_m_customerinfo SET INT_GROUPID=?,INT_CUSTOMERNAMEID=?, CHR_ALIAS=?,";
			        asql = asql + " CHR_CONTACTPERSON=?,CHR_ADDRESS1=?,CHR_ADDRESS2=?,CHR_ADDRESS3=?,  ";
			        asql = asql + " INT_CITYID=?,INT_DISTRICTID=?,INT_STATEID=?,INT_COUNTRYID=?,INT_PINCODE=?,  ";
			        asql = asql + " INT_PHONE1=?,INT_EXTN1=?,INT_PHONE2=?,INT_EXTN2=?,INT_MOBILE1=?,INT_MOBILE2=?, ";
			        asql = asql + " CHR_FAX=?,CHR_EMAIL=?,CHR_WEBSITE=?, ";
			        asql = asql + " CHR_ACTIVE=?,CHR_USRNAME=?,";
			        asql = asql + " CHR_VERIFY =?,CHR_VERIFY_DESC = ?, CHR_VERIFIEDBY = ?,  DAT_VERIFIED =NOW(), ";        
			        asql = asql + " CHR_SALUTE=?,CHR_AREACODE= ? ";
			        asql = asql + " WHERE INT_CUSTOMERID=?  ";
					apstm = con.prepareStatement(asql);
					apstm.setString(1, ""+d.getGroup());
					apstm.setString(2, ""+d.getCname());
					apstm.setString(3, d.getAlias());
					apstm.setString(4, d.getName());
					apstm.setString(5, d.getAddress1());
					apstm.setString(6, d.getAddress2());
					apstm.setString(7, d.getAddress3());
					apstm.setString(8, ""+d.getCity());
					apstm.setString(9,""+d.getDistrict() );
					apstm.setString(10,""+d.getState());
					apstm.setString(11,""+d.getCountry() );
					apstm.setString(12,""+d.getPincode());
					apstm.setString(13,""+d.getPhone1());
					apstm.setString(14,""+d.getExtn1());
					apstm.setString(15,""+d.getPhone2());
					apstm.setString(16,""+d.getExtn2() );
					apstm.setString(17,""+d.getMobile1() );
					apstm.setString(18,""+d.getMobile2() );
					apstm.setString(19,""+d.getFax() );
					apstm.setString(20,d.getEmail() );
					apstm.setString(21,d.getWebsite() );
					apstm.setString(22,d.getActive() ); 
					apstm.setString(23,auserid ); 
					apstm.setString(24, d.getVerification());
					apstm.setString(25, d.getMemo());
					apstm.setString(26, createdby);
					apstm.setString(27, d.getSalute());
					apstm.setString(28, ""+d.getAreacode());
					apstm.setString(29,""+d.getRowid());
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					con.close();
					response.sendRedirect("Smart Marketing/CustomerInfo.jsp");
				} 
				catch (Exception e) 
				{
					System.out.println(e.getMessage());
					e.printStackTrace();
				}
			}
			else if ("MKTCustomerInfoVerify".equals(action)) 
			{
				
				asql = "UPDATE mkt_m_customerinfo SET CHR_VERIFY =?,CHR_VERIFY_DESC = ?, CHR_VERIFIEDBY = ?, DAT_VERIFIED =NOW() WHERE INT_CUSTOMERID=?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,request.getParameter("verification")  );
				apstm.setString(2,request.getParameter("memo")  );
				apstm.setString(3, auserid);
				apstm.setString(4, request.getParameter("rowid"));
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				con.close();
				response.sendRedirect("Smart Marketing/CustomerInfo.jsp");
			}
			else if ("MKTCustomerInfoMEChange".equals(action)) 
			{
				 asql = "UPDATE mkt_m_customerinfo SET CHR_HOLDER =?  WHERE INT_CUSTOMERID=?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,request.getParameter("othersid")  );
				apstm.setString(2, request.getParameter("rowid"));
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				con.close();
				response.sendRedirect("Smart Marketing/CustomerInfo.jsp");
			}
			else if("MKTMovetoCustomerInfoEdit".equals(action))
			{					
				String rowid = request.getParameter("rowid");
				String group = request.getParameter("group");
				String cname = request.getParameter("cname");
				
				String pannumber = request.getParameter("pannumber");
				String tinnumber = request.getParameter("tinnumber");
				String cstnumber = request.getParameter("cstnumber");
				String taxexamption = request.getParameter("taxexamption");
				String taxexamptionno = request.getParameter("taxexamptionno");
				 
				asql ="";
				asql = " INSERT INTO inv_m_customerinfo "; 
				asql = asql +" (INT_CUSTOMERGROUPID ,CHR_ALIASNAME,CHR_CONTACTPERSON ,CHR_DEPARTYMENT,CHR_ADDRESS1 , ";
				asql = asql +" CHR_ADDRESS2 ,CHR_ADDRESS3 ,INT_CITYID ,INT_DISTRICTID ,INT_STATEID , ";
				asql = asql +" INT_COUNTRYID ,INT_PINCODE ,CHR_AREACODE ,CHR_PHONE ,CHR_MOBILE ,CHR_FAX ,  ";
				asql = asql +" CHR_EMAIL ,CHR_WEBSITE ,INT_ACTIVE ,DAT_SINCE ,CHR_ACCNO ,INT_BANKGROUPID , ";
				asql = asql +" INT_CUSTOMERTYPEID ,CHR_MODE  , ";
				asql = asql +" DOU_CREDITLIMIT,CHR_TIN,CHR_CST,CHR_PAN,CHR_TAXEXAMPTION,CHR_TAXEXAMPTIONNO, ";
				asql = asql +" CHR_USRNAME ,DT_UPDATEDATE ,CHR_UPDATESTATUS ) ";
				
				asql = asql +" SELECT ?,?,CHR_CONTACTPERSON,CHR_ALIAS,CHR_ADDRESS1, ";
				asql = asql +" CHR_ADDRESS2,CHR_ADDRESS3,INT_CITYID,INT_DISTRICTID,INT_STATEID, ";
				asql = asql +" INT_COUNTRYID,INT_PINCODE,CHR_AREACODE,INT_PHONE1,INT_MOBILE1,CHR_FAX, ";
				asql = asql +" CHR_EMAIL,CHR_WEBSITE,CONCAT('1'), DATE(NOW()) dtsince,CONCAT('') acc, CONCAT('1') bank, ";
				asql = asql +" CONCAT('"+group+"') groupid,CONCAT('S') mode, ?,?,?,?,?,?,?,DATE(NOW()),'Y'  FROM mkt_m_customerinfo WHERE INT_CUSTOMERID= ?" ;
				apstm = con.prepareStatement(asql);
				apstm.setString(1, group);
				apstm.setString(2, "");
				apstm.setString(3, "100000");
				apstm.setString(4, tinnumber);
				apstm.setString(5, cstnumber);
				apstm.setString(6, pannumber);
				apstm.setString(7, taxexamption);
				apstm.setString(8, taxexamptionno);
				apstm.setString(9, auserid);
				apstm.setString(10, rowid);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				
				asql = "UPDATE mkt_m_customerinfo SET CHR_MOVETO_INVENTORY=?,DT_DATEOFMOVE=NOW(),CHR_MOVEDBY= ?,INT_INV_INVENTORY_ID=?  WHERE INT_CUSTOMERID=?";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,"Y");
				apstm.setString(2,createdby);
				apstm.setString(3,CommonFunctions.QueryExecute("SELECT MAX(INT_CUSTOMERID) FROM inv_m_customerinfo ")[0][0]);
				apstm.setString(4,rowid);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				con.close();    
				response.sendRedirect("Smart Marketing/MovetoCustomerInfo.jsp");
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

package com.my.org.erp.SmartManagement;

import java.io.IOException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

import org.apache.commons.beanutils.BeanUtils;
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 

public class ContractStaffActionHandler extends AbstractActionHandler {

	@SuppressWarnings("rawtypes")
	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String action = request.getParameter("actionS");
			ContractStaff d = new ContractStaff();
			Map map = request.getParameterMap();
			BeanUtils.populate(d, map);
			if ("MGTContractStaffAdd".equals(action)) {

				asql = " INSERT INTO com_m_contractstaff (CHR_STAFFNAME,CHR_STAFFFNAME,CHR_GENDER,DT_DOB,";
				asql = asql
						+ " DT_DOJ,CHR_MARITALSTATUS,DT_WEDDATE,INT_BLOODGROUPID,INT_COMPANYID,INT_BRANCHID,INT_OFFICEID,";
				asql = asql
						+ " INT_DEPARTID,INT_DESIGID,INT_CATEGORY,INT_SALARY,INT_BANK,CHR_ACCNO,CHR_IFSC,CHR_P_ADD1,CHR_P_ADD2,INT_P_CITYID,";
				asql = asql
						+ " INT_P_DISTRICTID,INT_P_STATEID,INT_P_COUNTRYID,INT_P_PINCODE,CHR_P_PHONE,CHR_C_ADD1,CHR_C_ADD2,INT_C_CITYID,";
				asql = asql
						+ " INT_C_DISTRICTID,INT_C_STATEID,INT_C_COUNTRY,INT_C_PINCODE,CHR_C_PHONE,CHR_REPTO,CHR_PAN,CHR_PASSPORT,";
				asql = asql + " CHR_DRIVING,CHR_PREVIOUSDETAILS,CHR_PERMAILID,";
				asql = asql
						+ " CHR_USERNAME,DT_UPDATEDATE,CHR_USERSTATUS ) VALUES ";
				asql = asql + " (?,?,?,?,";
				asql = asql + " ?,?,?,?,?,?,?,";
				asql = asql + " ?,?,?,?,?,?,?,?,?,?,";
				asql = asql + " ?,?,?,?,?,?,?,?,";
				asql = asql + " ?,?,?,?,?,?,?,?,";
				asql = asql + " ?,?,?,";
				asql = asql + " ?,DATE(NOW()),'Y' )";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, d.getName());
				apstm.setString(2, d.getFname());
				apstm.setString(3, d.getGender());
				apstm.setString(4, d.getDob());
				apstm.setString(5, d.getDoj());
				apstm.setString(6, d.getMarry());
				apstm.setString(7, d.getWedding());
				apstm.setString(8, "" + d.getBg());
				apstm.setString(9, "" + d.getCompany());
				apstm.setString(10, "" + d.getBranch());
				apstm.setString(11, "" + d.getOff());
				apstm.setString(12, "" + d.getDepart());
				apstm.setString(13, "" + d.getDesig());
				apstm.setString(14, "" + d.getCategory());
				apstm.setString(15, "" + d.getBasic());
				apstm.setString(16, "" + d.getBank());
				apstm.setString(17, d.getNo());
				apstm.setString(18, d.getIfsccode());
				apstm.setString(19, d.getPadd1());
				apstm.setString(20, d.getPadd2());
				apstm.setString(21, "" + d.getPcity());
				apstm.setString(22, "" + d.getPdistrict());
				apstm.setString(23, "" + d.getPstate());
				apstm.setString(24, "" + d.getPcountry());
				apstm.setString(25, "" + d.getPpincode());
				apstm.setString(26, "" + d.getPphone());
				apstm.setString(27, d.getCadd1());
				apstm.setString(28, d.getCadd2());
				apstm.setString(29, "" + d.getCcity());
				apstm.setString(30, "" + d.getCdistrict());
				apstm.setString(31, "" + d.getCstate());
				apstm.setString(32, "" + d.getCcountry());
				apstm.setString(33, "" + d.getCpincode());
				apstm.setString(34, "" + d.getCphone());
				apstm.setString(35, d.getRepto());
				apstm.setString(36, d.getPannumber());
				apstm.setString(37, d.getPassportnumber());
				apstm.setString(38, d.getDrivingnumber());
				apstm.setString(39, d.getPreviousdetails());
				apstm.setString(40, d.getPeremailid());
				apstm.setString(41, auserid);
				System.out.println("" + apstm);
				apstm.execute();
				apstm.close();
				con.close();
				response.sendRedirect("Smart Management/ContractorRegistrationView.jsp");
			} else if ("MGTContractStaffEdit".equals(action)) {

				asql = " UPDATE  com_m_contractstaff SET CHR_STAFFNAME= ?,";
				asql = asql + "	CHR_STAFFFNAME = ?,";
				asql = asql + "	CHR_GENDER = ?,";
				asql = asql + "	DT_DOB =?,";
				asql = asql + "	DT_DOJ = ? ,";
				asql = asql + "	CHR_MARITALSTATUS = ?, ";
				asql = asql + "	DT_WEDDATE = ?,";
				asql = asql + "	INT_BLOODGROUPID = ?, ";
				asql = asql + "	INT_COMPANYID = ?, ";
				asql = asql + "	INT_BRANCHID = ?, ";
				asql = asql + "	INT_OFFICEID = ?,";
				asql = asql + "	INT_DEPARTID = ?, ";
				asql = asql + "	INT_DESIGID = ?, ";
				asql = asql + "	INT_CATEGORY = ?, ";
				asql = asql + "	INT_SALARY = ?, ";
				asql = asql + "	INT_BANK =?, ";
				asql = asql + "	CHR_ACCNO = ?, ";
				asql = asql + "	CHR_IFSC =?, ";
				asql = asql + "	CHR_P_ADD1 = ?,";
				asql = asql + "	CHR_P_ADD2 = ?, ";
				asql = asql + "	INT_P_CITYID = ? ,";
				asql = asql + "	INT_P_DISTRICTID = ? ,";
				asql = asql + "	INT_P_STATEID = ? ,";
				asql = asql + "	INT_P_COUNTRYID = ?,";
				asql = asql + "	INT_P_PINCODE = ?,";
				asql = asql + "	CHR_P_PHONE = ?, ";
				asql = asql + "	CHR_C_ADD1 =? ,";
				asql = asql + "	CHR_C_ADD2 = ?, ";
				asql = asql + "	INT_C_CITYID = ? ,";
				asql = asql + "	INT_C_DISTRICTID =?, ";
				asql = asql + "	INT_C_STATEID = ? ,";
				asql = asql + "	INT_C_COUNTRY = ?,";
				asql = asql + "	INT_C_PINCODE = ? ,";
				asql = asql + "	CHR_C_PHONE = ?, ";
				asql = asql + "	CHR_REPTO = ? ,";
				asql = asql + "	CHR_PAN = ? ,";
				asql = asql + "	CHR_PASSPORT =?, ";
				asql = asql + "	CHR_DRIVING = ?,";
				asql = asql + "	CHR_PREVIOUSDETAILS = ?, ";
				asql = asql + "	CHR_PERMAILID = ? ";
				asql = asql + "	WHERE  INT_CONTRACTID = ? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, d.getName());
				apstm.setString(2, d.getFname());
				apstm.setString(3, d.getGender());
				apstm.setString(4, d.getDob());
				apstm.setString(5, d.getDoj());
				apstm.setString(6, d.getMarry());
				apstm.setString(7, d.getWedding());
				apstm.setString(8, "" + d.getBg());
				apstm.setString(9, "" + d.getCompany());
				apstm.setString(10, "" + d.getBranch());
				apstm.setString(11, "" + d.getOff());
				apstm.setString(12, "" + d.getDepart());
				apstm.setString(13, "" + d.getDesig());
				apstm.setString(14, "" + d.getCategory());
				apstm.setString(15, "" + d.getBasic());
				apstm.setString(16, "" + d.getBank());
				apstm.setString(17, d.getNo());
				apstm.setString(18, d.getIfsccode());
				apstm.setString(19, d.getPadd1());
				apstm.setString(20, d.getPadd2());
				apstm.setString(21, "" + d.getPcity());
				apstm.setString(22, "" + d.getPdistrict());
				apstm.setString(23, "" + d.getPstate());
				apstm.setString(24, "" + d.getPcountry());
				apstm.setString(25, "" + d.getPpincode());
				apstm.setString(26, "" + d.getPphone());
				apstm.setString(27, d.getCadd1());
				apstm.setString(28, d.getCadd2());
				apstm.setString(29, "" + d.getCcity());
				apstm.setString(30, "" + d.getCdistrict());
				apstm.setString(31, "" + d.getCstate());
				apstm.setString(32, "" + d.getCcountry());
				apstm.setString(33, "" + d.getCpincode());
				apstm.setString(34, "" + d.getCphone());
				apstm.setString(35, d.getRepto());
				apstm.setString(36, d.getPannumber());
				apstm.setString(37, d.getPassportnumber());
				apstm.setString(38, d.getDrivingnumber());
				apstm.setString(39, d.getPreviousdetails());
				apstm.setString(40, d.getPeremailid());
				apstm.setString(41, "" + d.getStaffid());
				System.out.println("" + apstm);
				apstm.execute();
				apstm.close();

				con.close();
				response.sendRedirect("Smart Management/ContractorRegistrationView.jsp");
			} else if ("MGTContractStaffDELETE".equals(action)) {
				try {

					String staffiddel[] = request.getParameterValues("staffid");
					asql = " DELETE FROM com_m_contractstaff WHERE INT_CONTRACTID = ? ";
					apstm = con.prepareStatement(asql);
					for (int u = 0; u < staffiddel.length; u++) {
						apstm.setString(1, staffiddel[u]);
						System.out.println("" + apstm);
						apstm.addBatch();
					}
					apstm.executeBatch();
					apstm.close();
					con.close();
					response.sendRedirect("Smart Management/ContractorRegistrationView.jsp");
				} catch (Exception e) {

					System.out.println(e.getMessage());
					request.setAttribute("error", e.getMessage());
					RequestDispatcher dispatchers = request
							.getRequestDispatcher("/error/index.jsp");
					dispatchers.forward(request, response);
				}
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
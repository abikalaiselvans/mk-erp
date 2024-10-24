package com.my.org.erp.SmartUtility;

import java.io.IOException;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.BeanUtils;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class CommonSettingActionHandler extends AbstractActionHandler
{
		public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
		{
			try
			{
					String action=request.getParameter("actionS");
					
					if(action.equals("UTICommonSetting"))
					{ 
						try 
						{
							CommonSetting d = new CommonSetting();
							Map map = request.getParameterMap();
							BeanUtils.populate(d, map);
							String cycles="0,";
							for(int y=0; y<d.getLeavecarry().length;y++)
								cycles = cycles+d.getLeavecarry()[y]+",";
							asql ="UPDATE m_institution SET";
							asql = asql +" CHR_NAME=?, ";
							asql = asql +" CHR_ADD1=? , ";
							asql = asql +" CHR_CITY=?, ";
							asql = asql +" CHR_STATE=? , ";
							asql = asql +" INT_PINCODE=?, ";
							asql = asql +" INT_PHONE=? , ";
							asql = asql +" CHR_MAILID=? , ";
							asql = asql +" INT_PFAMT=? , ";
							asql = asql +" INT_ESIAMT=?, ";
							asql = asql +" INT_CPY_PFAMT=? , ";
							asql = asql +" INT_CPY_PENSIONAMT=?, ";
							asql = asql +" INT_CPY_ESIAMT=?, ";
							asql = asql +" CHR_SALARY =?, ";
							asql = asql +" DAT_LOCK=?, ";
							asql = asql +" CHR_PASSWORD=? , ";
							asql = asql +" DOU_PETROL=?, ";
							asql = asql +" INT_SESSION=?, ";
							asql = asql +" CHR_UPDATE=?, ";
							asql = asql +" INT_CONVEYANCECLEAR=?, ";
							asql = asql +" CHR_MAILALERT=? , ";
							asql = asql +" CHR_SMSALERT =?, ";
							asql = asql +" CHR_FORGETPASSWORD=? , ";
							asql = asql +" CHR_ORDERBY=?, ";
							asql = asql +" CHR_LEAVEUPDATE=? , ";
							asql = asql +" CHR_LEAVENOTCARRY=? , ";
							asql = asql +" CHR_PAYTAXDEDUCTION=? , ";
							asql = asql +" CHR_PAYTAXVALUE=? , ";
							asql = asql +" DOU_BONUS=?, ";
							asql = asql +" INT_BONUSWORKINGDAYS=? , ";
							asql = asql +" INT_LEAVELIMIT=? , ";
							asql = asql +" DOU_RESELLERPERCENTAGE=? , ";
							asql = asql +" INT_RESIGNATIONLIMIT=? , ";
							asql = asql +" CHR_PFNUMBER=? , ";
							asql = asql +" CHR_ESINUMBER=? , ";
							asql = asql +" INT_PFLIMITMINIMUM=? , ";
							asql = asql +" INT_ESILIMIT=? , ";
							asql = asql +" CHR_HRMAILID=? , ";
							asql = asql +" CHR_BILLINGMAILID=? , ";
							asql = asql +" CHR_BILLINGMAILPASSWORD=? , ";
							asql = asql +" CHR_TAXDEDUCTIONEMP=? , ";
							asql = asql +" CHR_TECHNICALEMAILID=? , ";
							asql = asql +" CHR_PRODUCTMAILID=? , ";
							asql = asql +" CHR_MAILHOST=? , ";
							asql = asql +" CHR_GROUPMAIL =? , ";
							asql = asql +" CHR_LOGINMAILDCHECK=? , ";
							asql = asql +" CHR_NEWJOINNERMAILALERT=? , ";
							asql = asql +" CHR_SHORTNAME=? , ";
							asql = asql +" CHR_ATTENDANCEMARK=? , ";
							asql = asql +" INT_GROSSLIMIT = ? , ";
							asql = asql +" INT_COMPANYSELECTION = ?  , ";
							asql = asql +" CHR_ADMININFORMATION =? ,  ";
							asql = asql +" CHR_FIRSTTIMEAUTOMATE =? ,  ";
							asql = asql +" CHR_DOJLOCK =? ,  ";
							asql = asql +" INT_DATLOCK = ? ,  ";
							asql = asql +" INT_RESIGNERLOCK = ? , ";
							asql = asql +" CHR_DISPLAYINACTIVECOMPANY = ? ,  ";
							asql = asql +" CHR_SHOW_EMPLOYEE = ? ,  ";
							asql = asql +" CHR_LOGINBY = ? ,  ";
							asql = asql +" CHR_COPYPAST = ? ,  "; 
							asql = asql +" CHR_WHATSAPP_ALERT = ?   "; 
							asql = asql +" WHERE INT_ID=1";
							apstm = con.prepareStatement(asql);
							apstm.setString(1,d.getCompanyname().trim());//name
							apstm.setString(2,d.getCompanyaddress().trim() );
							apstm.setString(3,d.getCity().trim());
							apstm.setString(4,d.getState().trim());
							apstm.setString(5,d.getPincode().trim());
							apstm.setString(6,d.getPhone().trim());
							apstm.setString(7,d.getMailid().trim());
							apstm.setString(8,d.getPf().trim());
							apstm.setString(9,d.getEsi().trim());
							apstm.setString(10,d.getCompanypf1().trim());
							apstm.setString(11,d.getCompanypf2().trim());
							apstm.setString(12,d.getCompanyesi().trim() );
							apstm.setString(13,d.getSalary().trim() );
							apstm.setString(14,d.getDtlock().trim() );
							apstm.setString(15,d.getTxtpassword().trim());
							apstm.setString(16,d.getTxtpetrol().trim());
							apstm.setString(17,d.getSessiontime().trim() );
							apstm.setString(18,d.getServerupdate().trim() );
							apstm.setString(19,d.getConveyance().trim() );
							apstm.setString(20,d.getMaialert().trim() );
							apstm.setString(21,d.getSms().trim() );
							apstm.setString(22,d.getFpass().trim() );
							apstm.setString(23,d.getOrder().trim() );
							apstm.setString(24,d.getLeaveupdation().trim() );
							apstm.setString(25,cycles );
							apstm.setString(26,d.getPaytaxdeduction().trim() );
							apstm.setString(27,d.getPaytaxvalue().trim() );
							apstm.setString(28,d.getBonus().trim() );
							apstm.setString(29,d.getBonusdays().trim() );
							apstm.setString(30,d.getLeavelimit().trim() );
							apstm.setString(31,d.getReseller().trim() );
							apstm.setString(32,d.getResignlimit().trim() );
							apstm.setString(33,d.getPfnumber().trim() );
							apstm.setString(34,d.getEsinumber().trim() );
							apstm.setString(35,d.getPflimitminimum().trim() );
							apstm.setString(36,d.getEsilimit().trim() );
							apstm.setString(37,d.getHrmailid().trim());
							apstm.setString(38,d.getBillingmailid().trim() );
							apstm.setString(39,d.getBillingmailidpassword().trim() );
							apstm.setString(40,d.getTaxdeductionemp().trim());
							apstm.setString(41,d.getTechnicalmailid().trim() );
							apstm.setString(42,d.getProductmailid().trim() );
							apstm.setString(43,d.getMailhost().trim() );
							apstm.setString(44,d.getGroupmail().trim() );
							apstm.setString(45,d.getLoginmailcheck().trim() );
							apstm.setString(46,d.getNewjoinnermailalert().trim() );
							apstm.setString(47,d.getCpyshortname().trim() );
							apstm.setString(48,d.getAutomaticattendancemark().trim() );
							apstm.setString(49,d.getGrosslimit().trim() ); 
							apstm.setString(50,d.getCompany().trim() );
							apstm.setString(51,d.getAdminhide().trim() );
							apstm.setString(52,d.getFirsttimeautomate().trim() );
							apstm.setString(53,d.getDojlock().trim() );
							apstm.setString(54,d.getJoinnerlock().trim() );
							apstm.setString(55,d.getResignerlock().trim() );
							apstm.setString(56,d.getInactivecompany().trim() );
							apstm.setString(57,d.getShow() );
							apstm.setString(58,d.getLoginby() );
							apstm.setString(59, d.getCopypaste());
							apstm.setString(60,d.getWhatsappalert() );
							System.out.println("================="+request.getParameter("whatsappalert"));
							System.out.println(""+apstm);
							System.out.println();
							apstm.execute();
							apstm.close();
							con.close();
							
							if("Y".equals(d.getServerupdate()))
								application.setAttribute("SERVERUPDATION", "Y");
							else
								application.removeAttribute("SERVERUPDATION");
							
							response.sendRedirect("CommonSetting.jsp");
						} 
						catch (Exception e) 
						{
							System.out.println(e.getMessage());
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
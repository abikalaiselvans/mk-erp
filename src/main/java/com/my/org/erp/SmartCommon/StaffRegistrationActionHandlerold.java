package com.my.org.erp.SmartCommon;
import java.io.IOException;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Map;
import java.util.Properties;
import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.common.SalaryFunctions;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.beanutils.BeanUtils;
import com.my.org.erp.ServiceLogin.AbstractActionHandler; 
import com.my.org.erp.ServiceLogin.DateUtil;

public class StaffRegistrationActionHandlerold extends AbstractActionHandler 
{
	Statement st;
	ResultSet rs;
	 
	boolean flag = false;
	String regid="";
	//17/G/0175300 1448/32935315
	 

 	
	@SuppressWarnings({ "rawtypes", "deprecation" })
	public synchronized void  handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			 
			
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String userId = (String) session.getAttribute("USRID");
			java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("yyyy-MM-dd");
    		java.util.Date date = new java.util.Date();
    		String updatedate = "" + datetime.format(date);
    		
			System.out.println(action);
			if("GENStaffRegistration".equals(action)  ) 
			{ 
				Staff d = new Staff();
				Map map=request.getParameterMap();
				BeanUtils.populate(d,map);
				boolean stffregistrationflag = true;
		   		
		   		
		   		if("N".equals(d.getRejoin()))
		   		{
		   			String sql ="";
			   		sql = sql +" SELECT COUNT(*) FROM com_m_staff ";
			   		sql = sql +" WHERE CHR_STAFFNAME='"+d.getName().toUpperCase()+"' ";
			   		sql = sql +" AND  CHR_STAFFFNAME='"+d.getFname().toUpperCase()+"' ";
			   		sql = sql +" AND CHR_MOTHERNAME='"+d.getMothername()+"' ";
			   		sql = sql +" AND DT_DOB ='"+d.getDob()+"' ";
			   		if(CommonFunction.RecordExist(sql))
			   			stffregistrationflag = false;
		   		}
		   		
		   		
		   		if(stffregistrationflag)
		   		{	
		   			regid = ""+ staffRegistrationNumber(d.getDoj(),""+d.getCompany()) ;
					acs = con.prepareCall("{call COM_PRO_STAFF_MULTIPART(" 
									+ " ?,?,?,?,?,?,?,?,?,?,"
									+ " ?,?,?,?,?,?,?,?,?,?,"
									+ " ?,?,?,?,?,?,?,?,?,?,"
									+ " ?,?,?,?,?,?,?,?,?,?,"
									+ " ?,?,?,?,?,?,?,?,?,?,"
									+ " ?,?,?,?,?,?,?,?,?,?,"
									+ " ?,?,?,?,?,?,?,?,?,?,"
									+ " ?,?,?,?,?,?,?,?,?,?,"
									+ " ?,?,?,? ,?,?,?,?,?,?," 
									+ " ?,?)}");
					acs.setString(1, "INSERT");
					acs.setString(2, "");
					acs.setString(3, "" +  d.getCompany());
					acs.setString(4, "" + d.getBranch());
					acs.setString(5, regid);
					acs.setString(6, d.getName().toUpperCase());
					acs.setString(7, d.getFname().toUpperCase());
					acs.setString(8, "" + d.getDepart());
					acs.setString(9, "" + d.getDesig());
					acs.setString(10, "" + d.getOff());
					//System.out.println("1");
					
					acs.setString(11, d.getGender());
					acs.setString(12, d.getDob());
					acs.setString(13, d.getBg());
					acs.setString(14, d.getDoj());
					acs.setString(15, d.getGrade());
					acs.setString(16, d.getCard());
					acs.setString(17, "" + d.getBalance());
					acs.setString(18, d.getStype());
					acs.setString(19, "" + d.getBasic());
					acs.setString(20, d.getPf());
					acs.setString(21, d.getEsi());
					acs.setString(22, "" + d.getGross());
					acs.setString(23, d.getMarry());
					acs.setString(24, d.getWedding());
					acs.setString(25, d.getBank());
					acs.setString(26, d.getNumber());
					acs.setString(27, "" + d.getPin()); 
					acs.setString(28, d.getPadd1().toUpperCase());
					acs.setString(29, d.getPadd2().toUpperCase());
					acs.setString(30, "" + d.getPcity());
					acs.setString(31, "" + d.getPstate());
					acs.setString(32, "" + d.getPpincode());
					acs.setString(33, d.getCadd1());
					acs.setString(34, d.getCadd2());
					acs.setString(35, "" + d.getCcity());
					acs.setString(36, "" + d.getCstate());
					acs.setString(37, "" + d.getCpincode());
					acs.setString(38, "" + d.getPphone());
					acs.setString(39, "" + d.getCphone());
					acs.setString(40, "" + d.getEmailid());
					acs.setString(41, "" + d.getPeremailid());
					acs.setString(42, d.optpf);
					acs.setString(43, "" + d.getTxtpfvalue());
					acs.setString(44, "" + d.getTxtpfno());
					acs.setString(45, d.getOptesi());
					acs.setString(46, "" + d.getTxtesivalue());
					acs.setString(47, "" + d.getTxtesno());
					acs.setString(48, userId);
					acs.setString(49,updatedate );
					acs.setString(50, "Y");
					acs.setString(51, d.getMobile());
					acs.setString(52, d.getCarry());
					acs.setString(53, "" + d.getQualification());
					acs.setString(54, d.getManagement());
					acs.setString(55, d.getRepto());
					acs.setString(56, d.getReporinghead());
					acs.setString(57, d.getHold());
					acs.setString(58, d.getDispensary());
					acs.setString(59, d.getConveyance());
					acs.setString(60, "" + d.getSalarycalculation());
					acs.setString(61, "" + d.getPayslip());
					acs.setString(62, d.getPannumber().toUpperCase());
					acs.setString(63, d.getPassportnumber().toUpperCase());
					acs.setString(64, d.getDrivingnumber().toUpperCase());
					acs.setString(65, d.getMothername());
					acs.setString(66, "N");//future10
					acs.setString(67, "");
					acs.setString(68, "" + d.getCategory());
					acs.setString(69, d.getPfesidate());
					acs.setString(70, d.getResigndate());
					acs.setString(71, d.getPreviousdetails());
					acs.setString(72, "" + d.pdistrict);
					acs.setString(73, "" + d.getPcountry());
					acs.setString(74, "" + d.getCdistrict());
					acs.setString(75, "" + d.getCcountry());
					acs.setString(76, d.getInterview());
					acs.setString(77, d.getRejoin());
					acs.setString(78, d.getNominee());
					acs.setString(79, d.getSalarysplitupby());
					acs.setString(80, ""+d.getCtc());
					acs.setString(81, d.getIfsccode().toUpperCase());
					acs.setString(82, "" + d.getAttendancecycle());
					acs.setString(83, d.getSalarytype());
					acs.setString(84, d.getRevisiondate());
					acs.setString(85, ""+d.getLocation());
					acs.setString(86, d.getPreviousempid());
					acs.setString(87, d.getPfnomineerelationship());
					acs.setString(88, d.getSpousename());
					acs.setString(89, d.getPfcalculationtype());
					acs.setString(90, d.getAadharnumber());
					acs.setString(91, d.getUannumber());
					acs.setString(92, d.getEmployeetype());
					System.out.println("" + acs);
					acs.execute();
					System.out.println("Inserted.....");
					acs.close();
					 
					//UPDATE com_m_staff SET CHR_REFEMPID = CHR_EMPID;
					asql = "UPDATE com_m_staff SET CHR_REFEMPID = ? WHERE CHR_EMPID =?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,regid );
					apstm.setString(2,regid );
					System.out.println("" + apstm);
					apstm.execute();
					
					
  					//Insert Salary Structure...
					if ("A".equals(d.getSalarysplitupby()))
					{
						SalaryFunctions.salaryBand(userId,regid,d.getGross(), d.getStype());
						asql = "UPDATE com_m_staff SET CHR_APPROVED = 'N' WHERE CHR_EMPID =?";
						apstm = con.prepareStatement(asql);
						apstm.setString(1,regid );
						apstm.execute();
						apstm.close();
					}
					else
						SalaryFunctions.salaryBandManual(regid, ""+ d.getBasic());
					System.out.println("allowance & recovery inserted");
					
					
					//Insert leave...
					StaffRegistrationMethod.insertStaffLeave(regid,apstm, con,auserid);
					System.out.println("leave inserted");
					Thread.sleep(3000);
			   		
			   		//send a Welcome Mail...
					if ("Y".equals(CommonFunctions.QueryExecute("SELECT  CHR_NEWJOINNERMAILALERT  FROM m_institution  WHERE INT_ID= 1")[0][0]))
						StaffRegistrationMethod.sendNewJoinnerInfoMailtoAllEmp(regid,request.getRealPath("/"),CommonFunctions.QueryExecute("SELECT CHR_GROUPMAIL FROM m_institution WHERE INT_ID=1")[0][0]);
					System.out.println(regid +" Mail sent...");
				
					
					// Send a Help Mail
					if ("Y".equals(CommonFunctions.QueryExecute("SELECT  CHR_NEWJOINNERMAILALERT  FROM m_institution  WHERE INT_ID= 1")[0][0]))
						StaffRegistrationMethod.sendNewJoinnerHelpMail(request,	regid, Path,d.getPeremailid());
					System.out.println(regid +" Mail sent...");
					
					
					response.sendRedirect("Smart Common/StaffaddResponse.jsp?addMore=Y&regid="+ regid+ "&Name="+ d.getName()+ "&salarysplitupby="+ d.getSalarysplitupby());
		   		
		   		}
			} 
			else if ("GENStaffRegistrationUpdate".equals(action)) 
			{
				try 
				{
					
					/*System.out.println();
					System.out.println();
					Map params = ;
					Iterator i = params.keySet().iterator();
					String keys=""; 
					while ( i.hasNext() )
					{
					 String key = (String) i.next();
					// System.out.println(key+" ---"+((String[]) params.get( key ))[ 0 ]);
					 keys =keys+key+",";
					 String value = ((String[]) params.get( key ))[ 0 ];
					 
					}*/
					
					
					Staff d = new Staff();
					Map map=request.getParameterMap();
					BeanUtils.populate(d,map);
					
					asql = " UPDATE com_m_staff SET "; 
			        asql = asql + " CHR_STAFFNAME=?,CHR_STAFFFNAME=?, ";
			        asql = asql + " CHR_GENDER=?,CHR_BG=?, ";
			        asql = asql + " CHR_GRADE=?,CHR_CARD=?,INT_BALANCE=?,INT_SALARY=?, ";
			        asql = asql + " INT_GROSSSALARY=?, ";
			        asql = asql + " CHR_MARITALSTATUS=?,DT_WEDDATE=?,CHR_BANK=?, ";
			        asql = asql + " CHR_ACCNO=?,INT_PINNO=?, ";
			        asql = asql + " CHR_PADD1=?,CHR_PADD2=?,CHR_PCITY=?,CHR_PSTATE=?, ";
			        asql = asql + " CHR_PPIN=?,CHR_SADD1=?,CHR_SADD2=?,CHR_SCITY=?,CHR_SSTATE=?,CHR_SPIN=?, ";
			        asql = asql + " CHR_PPHONE=?,CHR_SPHONE=?,CHR_EMAILID=?, ";
			        asql = asql + " CHR_MOBILE=?,";
			        asql = asql + " CHR_LEAVECARRY=?, ";
			        asql = asql + " CHR_QUALIFICATION=?,CHR_MANAGEMENT=?,CHR_REP=?,CHR_HOLD=?, ";
			        asql = asql + " CHR_CONVEYANCECLEAR=?, ";
			        asql = asql + " CHR_SALARYCALCULATE=?,CHR_PAYSLIPHIDE=?, ";
			        asql = asql + " CHR_PAN=?,CHR_PASSPORT=?,CHR_DRIVING=?,CHR_AADHARNO=?, CHR_PERMAILID=?, ";
			        asql = asql + " CHR_MOTHERNAME=?, CHR_COMPANYPFNO=?,CHR_ADDRESSSTATUS=?,CHR_FUTURE10=?, "; 
			        asql = asql + " CHR_USERNAME=?,DT_UPDATEDATE=DATE(NOW()), CHR_USERSTATUS='Y' ,";
			        asql = asql + " DAT_PFESIDATE=?, CHR_PREVIOUSDETAILS=?,";
			        asql = asql + " INT_PDISTRICTID=?,INT_PCOUNTRYID=?,INT_CDISTRICTID=?,INT_CCOUNTRY=?,";
			        asql = asql + " CHR_INTERVIEW=?,CHR_REJOIN=?,CHR_NOMINEE=?,";
			        asql = asql + " DAT_RIVISION=?, ";
			        asql = asql + " CHR_IFSC=?,INT_ATTENDANCECYCLE=?,CHR_SALARYTYPE=?, "; 
			        asql = asql + " CHR_MOTHERNAME=?, CHR_SPOUSENAME=?,CHR_MODIFICATION = 'N', ";
			        asql = asql + " DT_DOB=?, DT_ACTUAL_DOB=?, CHR_REFEMPID=?, DT_DOJCOLLEGE=?, INT_CONVEYANCE_LIMIT=? ";
			        asql = asql + " WHERE CHR_EMPID=? "; 
			        apstm = con.prepareStatement(asql);//DT_DOB DT_ACTUAL_DOB dob,adob
					apstm.setString(1, d.getName());
					apstm.setString(2, d.getFname());
					apstm.setString(3, d.getGender());
					apstm.setString(4, d.getBg());
					apstm.setString(5, d.getGrade());
					apstm.setString(6, d.getCard());
					apstm.setString(7, ""+d.getBalance());
					apstm.setString(8, ""+d.getBasic());
					apstm.setString(9, ""+d.getGross());
					apstm.setString(10, d.getMarry());
					apstm.setString(11, d.getWedding());
					apstm.setString(12, d.getBank()); 
					apstm.setString(13, d.getNumber());
					apstm.setString(14, ""+d.getPin());
					apstm.setString(15, d.getPadd1().toUpperCase());
					apstm.setString(16, d.getPadd2().toUpperCase());
					apstm.setString(17, ""+d.getPcity());
					apstm.setString(18, ""+d.getPstate());
					apstm.setString(19, ""+d.getPpincode());
					apstm.setString(20, d.getCadd1().toUpperCase());
					apstm.setString(21, d.getCadd2().toUpperCase());
					apstm.setString(22, ""+d.getCcity());
					apstm.setString(23, ""+d.getCstate());
					apstm.setString(24, ""+d.getCpincode());
					apstm.setString(25, ""+d.getPphone());
					apstm.setString(26, ""+d.getCphone());
					apstm.setString(27, ""+d.getEmailid());
					apstm.setString(28, ""+d.getMobile());
					apstm.setString(29, d.getCarry());
					apstm.setString(30, ""+d.getQualification());
					apstm.setString(31, d.getManagement());
					apstm.setString(32, d.getReporinghead());
					apstm.setString(33, d.getHold());
					apstm.setString(34, d.getConveyance());
					apstm.setString(35, d.getSalarycalculation());
					apstm.setString(36, d.getPayslip());
					apstm.setString(37, d.getPannumber());
					apstm.setString(38, d.getPassportnumber());
					apstm.setString(39, d.getDrivingnumber());
					apstm.setString(40, d.getAadharnumber());
					apstm.setString(41, d.getPeremailid());
					apstm.setString(42, d.getMothername());
					apstm.setString(43, d.getCompanypfnumber());
					apstm.setString(44, "N");
					apstm.setString(45, "N");
					apstm.setString(46, userId);
					apstm.setString(47, d.getPfesidate());
					apstm.setString(48, d.getPreviousdetails());
					apstm.setString(49, ""+d.pdistrict);
					apstm.setString(50, ""+d.getPcountry() );
					apstm.setString(51, ""+d.getCdistrict() );
					apstm.setString(52, ""+d.getCcountry());
					apstm.setString(53, d.getInterview());
					apstm.setString(54, d.getRejoin());
					apstm.setString(55, d.getNominee().toUpperCase());
					apstm.setString(56, d.getRevisiondate() );
					apstm.setString(57, d.getIfsccode().toUpperCase());
					apstm.setString(58, ""+d.getAttendancecycle());
					apstm.setString(59, d.getSalarytype());
					apstm.setString(60, d.getMothername());
					apstm.setString(61, d.getSpousename());
					apstm.setString(62, d.getDob());
					apstm.setString(63, d.getAdob());
					apstm.setString(64, d.getRefempid());
					apstm.setString(65, d.getDoj());
					apstm.setInt(66, d.getConveyancelimit());
					apstm.setString(67, d.getId());
					System.out.println(""+apstm);
					apstm.execute();
					apstm.close();
					 
					 
					con.close();   
					response.sendRedirect("Smart Common/StaffRegistrationView.jsp");
					 
					
				} 
				catch (SQLException e1) 
				{
					System.out.println(e1.getMessage());
					request.setAttribute("error", e1.getMessage());
					RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
					dispatchers.forward(request, response);

				}
				catch (Exception e) 
				{
					System.out.println(e.getMessage());
					request.setAttribute("error", e.getMessage() );
			        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			    	dispatchers.forward(request, response); 
				}
			} 
			 
			else if ("GENADDRESSUPDATION".equals(action) ) 
			{
				String empid = request.getParameter("empid");
				String padd1 = "" + request.getParameter("padd1");
				String padd2 = "" + request.getParameter("padd2");
				String pcity = "" + request.getParameter("pcity");
				String pdistrict = "" + request.getParameter("pdistrict");
				String pstate = "" + request.getParameter("pstate");
				String pcountry = "" + request.getParameter("pcountry");
				String ppin = "" + request.getParameter("ppincode");
				String pphone = "" + request.getParameter("pphone");
				
				String sadd1 = "" + request.getParameter("cadd1");
				String sadd2 = "" + request.getParameter("cadd2");
				String scity = "" + request.getParameter("ccity");
				String sdistrict = "" + request.getParameter("cdistrict");
				String sstate = "" + request.getParameter("cstate");
				String scountry = "" + request.getParameter("ccountry");
				String spin = "" + request.getParameter("cpincode");
				String sphone = "" + request.getParameter("cphone");
				String emailid = "" + request.getParameter("emailid");
				String peremailid = "" + request.getParameter("peremailid");
				String mobile = "" + request.getParameter("mobile");
				//String actualdob = "" + request.getParameter("dob");
				
				asql ="";
				asql =" UPDATE com_m_staff SET CHR_PADD1=?,CHR_PADD2=?,CHR_PCITY=?,INT_PDISTRICTID=?,CHR_PSTATE=?,INT_PCOUNTRYID=?,CHR_PPIN=?,CHR_PPHONE=?,";
				asql = asql +" CHR_SADD1=?,CHR_SADD2=?,CHR_SCITY=?,INT_CDISTRICTID=?,CHR_SSTATE=?,INT_CCOUNTRY=?,CHR_SPIN=?,CHR_SPHONE=?,CHR_ADDRESSSTATUS=? ,CHR_EMAILID=?, CHR_PERMAILID=?,CHR_MOBILE=?  WHERE CHR_EMPID=?";
				 
				apstm = con.prepareStatement(asql);
				apstm.setString(1,padd1 );
				apstm.setString(2,padd2);
				apstm.setString(3, pcity);
				apstm.setString(4,pdistrict);
				apstm.setString(5, pstate);
				apstm.setString(6,pcountry);
				apstm.setString(7, ppin);
				apstm.setString(8,pphone);
				apstm.setString(9, sadd1);
				apstm.setString(10,sadd2);
				apstm.setString(11, scity);
				apstm.setString(12,sdistrict);
				apstm.setString(13, sstate);
				apstm.setString(14,scountry);
				apstm.setString(15, spin);
				apstm.setString(16,sphone);
				apstm.setString(17,"Y");
				apstm.setString(18,emailid);
				apstm.setString(19,peremailid);
				apstm.setString(20,mobile);
				apstm.setString(21,empid);
				System.out.println(""+apstm);
				apstm.execute();
				con.close();   
				response.sendRedirect(""+session.getAttribute("PAGE"));
				
			}
			else if("GENStaffRegistrationAccountUpdation".equals(action))
			{
				String id = request.getParameter("id");
				String bank = request.getParameter("bank");
				String number = request.getParameter("number");
				String ifsccode = request.getParameter("ifsccode");
				asql = "UPDATE com_m_staff SET CHR_BANK=?,CHR_ACCNO=?,CHR_IFSC=?,CHR_ACCOUNT_UPDATEDBY=? , DT_ACCOUNT_DATE=NOW()  WHERE CHR_EMPID=? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,bank);
				apstm.setString(2,number);
				apstm.setString(3,ifsccode);
				apstm.setString(4,userId);
				apstm.setString(5,id);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				con.close(); 
				response.sendRedirect("Smart Common/Staff_Accountnumber.jsp");
			}
			else if("GENStaffRegistrationPFESIUpdation".equals(action))
			{
				String id = request.getParameter("id");
				String  pf= request.getParameter("pf");
				String  optpf= request.getParameter("optpf");
				String  txtpfno= request.getParameter("txtpfno");
				String  txtpfvalue= request.getParameter("txtpfvalue");
				String  nominee= request.getParameter("nominee");
				String  pfnomineerelationship= request.getParameter("pfnomineerelationship");
				String  esi= request.getParameter("esi");
				String  optesi= request.getParameter("optesi");
				String  txtesno= request.getParameter("txtesno");
				String  txtesivalue= request.getParameter("txtesivalue");
				String  dispensary= request.getParameter("dispensary");
				String  uannumber= request.getParameter("uannumber");
				String  professionaltax= request.getParameter("professionaltax");
				if(uannumber.length()<5)
					uannumber = null;
				if(txtpfno.length()<2)
					txtpfno = null;
				if(txtesno.length()<2)
					txtesno = null;
				asql = " INSERT INTO com_m_staff_pf_esi_changes  ";
				asql = asql +" ( ";
				asql = asql +" CHR_EMPID,CHR_PF,CHR_PF_OLD,CHR_PFTYPE,CHR_PFTYPE_OLD, ";
				asql = asql +" INT_PFAMT,INT_PFAMT_OLD,CHR_PFNO,CHR_PFNO_OLD,CHR_NOMINEE,CHR_NOMINEE_OLD, ";
				asql = asql +" CHR_NOMINEE_RELATIONSHIP,CHR_NOMINEE_RELATIONSHIP_OLD,CHR_ESI,CHR_ESI_OLD, ";
				asql = asql +" CHR_ESITYPE,CHR_ESITYPE_OLD,INT_ESIAMT,INT_ESIAMT_OLD, ";
				asql = asql +" CHR_ESINO,CHR_ESINO_OLD,INT_PLACEID,INT_PLACEID_OLD, ";
				asql = asql +" CHR_USERNAME,DT_UPDATEDATE,CHR_USERSTATUS ";
				asql = asql +" ) ";
				/*asql = asql +" VALUES ";
				asql = asql +" ( ";
				asql = asql +" ?,?,?,?,?, ";
				asql = asql +" ?,?,?,?,?,?, ";
				asql = asql +" ?,?,?,?, ";
				asql = asql +" ?,?,?,?, ";
				asql = asql +" ?,?,?,?, ";
				asql = asql +" ?,DATE(NOW()),'Y' ";
				asql = asql +" ) ";
				
				*/
				asql = asql +" SELECT "; 
				asql = asql +" CHR_EMPID,CHR_PF,'"+pf+"',CHR_PFTYPE,'"+optpf+"', ";
				asql = asql +" INT_PFAMT,'"+txtpfvalue+"',CHR_PFNO,'"+txtpfno+"',CHR_NOMINEE,'"+nominee+"', ";
				asql = asql +" CHR_NOMINEE_RELATIONSHIP,'"+pfnomineerelationship+"',CHR_ESI,'"+esi+"', ";
				asql = asql +" CHR_ESITYPE,'"+optesi+"',INT_ESIAMT,'"+txtesivalue+"', ";
				asql = asql +" CHR_ESINO,'"+txtesno+"',INT_PLACEID,'"+dispensary+"' ,";
				asql = asql +" UPPER('"+auserid+"') ,DATE(NOW()),'Y' ";
				asql = asql +" FROM com_m_staff WHERE CHR_EMPID =? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,id);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				  
				asql = "UPDATE com_m_staff SET ";
				asql = asql + " CHR_PF=?,CHR_PFTYPE=?,CHR_PFNO=?,INT_PFAMT=?, CHR_NOMINEE=?,CHR_NOMINEE_RELATIONSHIP=?, ";
				asql = asql + " CHR_ESI=?,CHR_ESITYPE=?,CHR_ESINO=? ,INT_ESIAMT=?, INT_PLACEID=?,CHR_PF_UAN=?,CHR_PROFESSIONALTAX=? ";
				asql = asql + "  WHERE CHR_EMPID=? "; 
				apstm = con.prepareStatement(asql);
				apstm.setString(1,pf);
				apstm.setString(2,optpf);
				apstm.setString(3,txtpfno);
				apstm.setString(4,txtpfvalue);
				apstm.setString(5,nominee);
				apstm.setString(6,pfnomineerelationship);
				apstm.setString(7,esi);
				apstm.setString(8,optesi); 
				apstm.setString(9,txtesno);
				apstm.setString(10,txtesivalue);
				apstm.setString(11,dispensary);
				apstm.setString(12,uannumber);
				apstm.setString(13,professionaltax);
				apstm.setString(14,id);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				
				con.close(); 
				response.sendRedirect("Smart Common/Staff_PFandESI_Changes.jsp");
			}
			else if("GENStaffRegistrationVerify".equals(action))
			{
				String id = request.getParameter("id");
				String description = request.getParameter("description");
				String modification = request.getParameter("modification");
				int modificationcount =0;
				if("Y".equals( modification))
					modificationcount =1;
				asql = "UPDATE com_m_staff SET CHR_APPROVED=?,CHR_APPROVEDBY=?,DAT_APPROVED_TIME=NOW(),CHR_APPROVED_DESC =?, CHR_MODIFICATION=?,INT_MODIFICATION_COUNT=? WHERE CHR_EMPID=? ";
				apstm = con.prepareStatement(asql);
				if("Y".equals( modification))
					apstm.setString(1,"N");
				else
					apstm.setString(1,"Y");
				apstm.setString(2,auserid.toUpperCase());
				apstm.setString(3,description);
				apstm.setString(4,modification);
				apstm.setString(5,""+modificationcount);
				apstm.setString(6,id);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				con.close(); 
				response.sendRedirect("Smart Common/StaffRegistrationView.jsp");
			}
			else if("GENStaffRegistrationPFESIClaimsUpdation".equals(action))
			{
				String id = request.getParameter("id");
				String description = request.getParameter("description");
				String claimdate = request.getParameter("claimdate");
				asql = "UPDATE com_m_staff SET CHR_PFCLAIMSTATUS=?,DAT_PFCLIAMDATE=?,CHR_PFCLIAMDESCRIPTION=? WHERE CHR_EMPID=? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,"Y");
				apstm.setString(2,DateUtil.FormateDateSQL(claimdate));
				apstm.setString(3,description);
				apstm.setString(4,id);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				con.close(); 
				response.sendRedirect("Smart Common/Staff_PFandESI_Claims.jsp");
			}
			
			

		} 
		catch (SQLException e1) 
		{
			System.out.println(e1.getMessage());
			request.setAttribute("error", e1.getMessage());
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);

		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 
	
		}
	}
	
	
	

	
	public static void sendNewJoinnerInfoMailtoAllEmp(String newempid,String peremailid,String to)
    {
    	try
    	{
    		
    		
    		
    		String ssql =" SELECT  a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,b.CHR_COMPANYNAME,c.CHR_BRANCHNAME, d.CHR_DEPARTNAME,e.CHR_DESIGNAME,f.CHR_OFFICENAME,DATE_FORMAT(DT_DOB,'%d-%b-%Y'),a.CHR_GENDER,a.CHR_MARITALSTATUS,DATE_FORMAT(a.DT_WEDDATE,'%d-%b-%Y'), a.CHR_EMAILID,a.CHR_PERMAILID ,a.CHR_MOBILE,g.CHR_QUALIFICATIONNAME,a.CHR_PREVIOUSDETAILS,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y')   FROM   com_m_staff a ,  com_m_company b,  com_m_branch c,com_m_depart d,com_m_desig e, com_m_office  f,com_m_qualification g WHERE a.INT_COMPANYID = b.INT_COMPANYID AND a.INT_BRANCHID = c.INT_BRANCHID AND a.INT_DEPARTID = d.INT_DEPARTID  AND a.INT_DESIGID = e.INT_DESIGID 	AND a.INT_OFFICEID = f.INT_OFFICEID AND a.CHR_QUALIFICATION = g.INT_QUALIFICATIONID AND a.CHR_EMPID='"+newempid+"' ";
    		String pdatas[][] =  CommonFunctions.QueryExecute(ssql);
    		String cpyshortname = CommonFunctions.QueryExecute("SELECT CHR_SHORTNAME FROM M_INSTITUTION WHERE INT_ID=1")[0][0];
			String content ="   ";
    		content=content+"<html> ";
    		content=content+"<head>";
    		content=content+"<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'> ";
    		content=content+"<title>:: SMARTCAMPUS ::</title> ";
    		content=content+"<style type='text/css'> ";
    		content=content+"<!-- ";
    		content=content+" .style12 { ";
    		content=content+"	FONT-WEIGHT: normal; ";
    		content=content+"	FONT-SIZE: 10px; ";
    		content=content+"	COLOR: #000000; ";
    		content=content+"	LINE-HEIGHT: 15px; ";
    		content=content+"	FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
    		content=content+"	TEXT-DECORATION: none ";
    		content=content+"}	 ";
    		content=content+".style15 {FONT-WEIGHT: bold; FONT-SIZE: 10px; COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; } ";
    		content=content+"--> ";
    		content=content+"</style> ";
    		content=content+"</head> ";
 
    		content=content+"<body  onpaste='return false;'> ";
    		content=content+"<table width='607' border='1' align='center' cellpadding='0' cellspacing='0' bordercolor='#0099FF'> ";
    		content=content+"  <tr> ";
    		content=content+"    <td height='50'  valign='middle'  bgcolor='#0099FF'><h3><font color='#ffffff'>DEAR ALL, Lets Welcome a new member in "+cpyshortname+" Family </font></h3></td> ";
    		content=content+"  </tr> ";
    		content=content+"  <tr> ";
    		content=content+"    <td><table width='400' border='0' align='center' cellpadding='4' cellspacing='4'> ";
    		content=content+"      <tr> ";
    		content=content+"       <td width='178'><span class='style15'>Emp Id </span></td> ";
    		content=content+"        <td width='222'><span class='style12'>"+pdatas[0][0]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"       <td><span class='style15'>Name</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][1]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		if("M".equals(pdatas[0][10]))
    			content=content+"        <td><span class='style15'>Spouse Name </span></td> ";
    		else
    			content=content+"        <td><span class='style15'>Father Name </span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][2]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"       <td><span class='style15'>Company</span></td> ";
    		content=content+"       <td><span class='style12'>"+pdatas[0][3]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"     <tr> ";
    		content=content+"        <td><span class='style15'>Branch</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][4]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"        <td><span class='style15'>Department</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][5]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"       <td><span class='style15'>Designation</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][6]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"       <td><span class='style15'>Office</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][7]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"      <tr> ";
    		content=content+"       <td><span class='style15'>Date of Joinning</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][17]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"<td><span class='style15'>Date of Birth </span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][8]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"     <tr> ";
    		content=content+"        <td><span class='style15'>Gender</span></td> ";
    		content=content+"       <td><span class='style12'>"+pdatas[0][9]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"       <td><span class='style15'>Married Status </span></td> ";
    		if("M".equals(pdatas[0][10]))
				content=content+"       <td><span class='style12'>Married</span></td> ";
			else
				content=content+"       <td><span class='style12'>Unmarried</span></td> ";
    		content=content+"     </tr> ";
    		content=content+"      <tr> ";
			if("M".equals(pdatas[0][10]))
			{
    			content=content+"       <td><span class='style15'>Wedding Date </span></td> ";
    			content=content+"       <td><span class='style12'>"+pdatas[0][11]+"</span></td> ";
    			content=content+"      </tr> ";
			}	
    		content=content+"     <tr> ";
    		content=content+"        <td><span class='style15'>Office - Email</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][12]+"</span></td> ";
    		content=content+"    </tr> ";
    		content=content+"    <tr> ";
    		content=content+"       <td><span class='style15'>Per - Email </span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][13]+"</span></td> ";
    		content=content+"     </tr> ";
    		/*content=content+"     <tr> ";
    		content=content+"      <td><span class='style15'>Mobile</span></td> ";
    		content=content+"       <td><span class='style12'>"+pdatas[0][14]+"</span></td> ";
    		content=content+"    </tr> ";*/
			content=content+"     <tr> ";
    		content=content+"      <td><span class='style15'>Qualification</span></td> ";
    		content=content+"       <td><span class='style12'>"+pdatas[0][15]+"</span></td> ";
    		content=content+"    </tr> ";
			content=content+"     <tr> ";
    		content=content+"      <td><span class='style15'>Previous Details</span></td> ";
    		content=content+"       <td><span class='style12'>"+pdatas[0][16]+"</span></td> ";
    		content=content+"    </tr> ";
    		content=content+"   </table></td> ";
    		content=content+" </tr> ";
			content=content+"  <tr> ";
    		content=content+"    <td bgcolor='#0099FF'><h4><font color='#ffffff'> Lets congratualate & wish ";
    		if("Male".equals(pdatas[0][9].trim()))
    			content=content+" him ";
    		else
    			content=content+" her ";
    		
    		content=content+" success for a good beginning towards the long journey with the team @ "+cpyshortname+".... </font></h4></td> ";
    		content=content+"  </tr> ";
    		content=content+"</table> ";
    		content=content+"</body> ";
    		content=content+"</html> ";
    		
    		 String hData[][] =  CommonFunctions.QueryExecute("SELECT CHR_HOST,CHR_USERID,CHR_PASSWORD,CHR_MAILID FROM  m_mailsetting WHERE INT_MAILID = 1");

             String host =hData[0][0]   ;
             String user =hData[0][1]   ;
             String password =hData[0][2]   ;
             String maild =hData[0][3]   ;
    		
    		Properties props = new Properties();
  	        props.setProperty("mail.transport.protocol", "smtp");
  	        props.setProperty("mail.host", ""+host);
	        props.setProperty("mail.user", ""+user);
  	        props.setProperty("mail.password", ""+password);
  	        Session mailSession = Session.getDefaultInstance(props, null);
  	        mailSession.setDebug(true);
  	        Transport transport = mailSession.getTransport();
  	        MimeMessage message = new MimeMessage(mailSession);
  	        message.setSubject("****** WELCOME TO THE "+cpyshortname.toUpperCase()+" FAMILY *****");
  	        message.setFrom(new InternetAddress(""+maild));
  	        message.setContent(content, "text/html");
  	        message.addRecipient(Message.RecipientType.BCC, new InternetAddress(to));
  	        transport.connect();
  	        transport.sendMessage(message, message.getRecipients(Message.RecipientType.BCC));
  	        transport.close();
  	        
  	        ;
    	      
    	}
    	 
    	catch (Exception e) 
    	{
    		System.out.println(e.getMessage());
    	}
    }
	
	
	//Getting Registration Number
	public static String staffRegistrationNumber(String doj,String company) 
	 {
		try 
	 	{
			String regnumber="";
			String sql = "SELECT CHR_SHORTNAME,MONTH('"	+ doj+ "'),YEAR('"+ doj+ "') FROM com_m_company WHERE INT_COMPANYID="	+company;
			String regdata[][] = CommonFunctions.QueryExecute(sql);
			String runningnumber="";
			sql =" SELECT RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) ," +
			"(MAX(INT_ID)+1),'1')   FROM com_m_staffid)),6) ";
			runningnumber =  CommonFunctions.QueryExecute(sql)[0][0];
			regnumber = ""+ regdata[0][0]+ CommonFunctions.getMonthShortName(Integer.parseInt(regdata[0][1]))+ regdata[0][2] +runningnumber;
 			return regnumber;
 	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	
}

/*
 * 
 * 
								//CommonFunctions.insertStaffImage(request.getRealPath("/")+"StaffPhoto/default.jpg", regid);
								//asql = "insert into com_m_staffaddressproof (CHR_EMPID) VALUES('"+ regid + "')";
								//CommonFunctions.Execute(asql);
								//StaffRegistrationMethod.insertUserRecord(regid,	"" + d.getOff(), flag, apstm, con);

								//Insert Salary Structure...
								if ("A".equals(d.getSalarysplitupby()))
									SalaryFunctions.salaryBand(regid,d.getGross(), d.getStype());
								else
									SalaryFunctions.salaryBandManual(regid, ""+ d.getBasic());

								//Insert leave...
								StaffRegistrationMethod.insertStaffLeave(regid,apstm, con);

								//send a Mail...
								if ("Y".equals(CommonFunctions.QueryExecute("SELECT  CHR_NEWJOINNERMAILALERT  FROM m_institution  WHERE INT_ID= 1")[0][0]))
									StaffRegistrationMethod.sendNewJoinnerInfoMailtoAllEmp(regid,Path,CommonFunctions.QueryExecute("SELECT CHR_GROUPMAIL FROM m_institution WHERE INT_ID=1")[0][0]);

								//if ("Y".equals(CommonFunctions.QueryExecute("SELECT  CHR_NEWJOINNERMAILALERT  FROM m_institution  WHERE INT_ID= 1")[0][0]))
									//StaffRegistrationMethod.sendNewJoinnerHelpMail(request,	regid, Path,d.getPeremailid());
								
 */

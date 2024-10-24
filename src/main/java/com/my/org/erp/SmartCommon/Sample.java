package com.my.org.erp.SmartCommon;

public class Sample
{
	/*
	 * 
	 * 
	 *
	
	
	
	package com.my.org.erp.SmartCommon;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import com.my.org.erp.common.CommonFunctions;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
public class StaffRegistrationActionHandler extends AbstractActionHandler {
	Statement st;
	ResultSet rs;
	PreparedStatement pstm;
	boolean flag = false;
	String regid="";
	//17/G/0175300 1448/32935315
	String sql =""; 
	@SuppressWarnings("deprecation")
	private void StaffInsertion(String compid,String branchid,String staffid, String staffname,
			String stafffname, String deptid, String desgid, String officeid,
			String gender, String dob, String blood, String doj, String grade,
			String card, String balance, String type, String salary, String pf,
			String esi, String gross, String married, String weddate,
			String bank, String accno, String stateid, String districtid,
			String pinno, String padd1, String padd2, String pcity,
			String pstate, String ppin, String sadd1, String sadd2,
			String scity, String sstate, String spin, String pphone,
			String sphone, String emailid, String peremailid,String pftype, String pfamt,
			String pfno, String esitype, String esiamt, String esino,
			String userid, String updatedate, String status,String mobile ,
			String carry,String qualif,String manag,String repto,String Reporinghead,String hold,
			String Dispensary,String conveyanceclear,String salarycalculation,String paysliphide,
			String pannumber,String passportnumber,
			String drivingnumber,String middlename,String future9,String future10,String Category,
			String pfesidate, String resigndate,String previousdetails,
			String pdistrict,String pcountry,String sdistrict,String scountry, 
			String interview,String rejoin,String nominee,String salarysplitupby,
			HttpServletRequest request) {
		try {

			
			String sql="SELECT CHR_SHORTNAME,MONTH('"+doj+"'),YEAR('"+doj+"') FROM com_m_company WHERE INT_COMPANYID="+compid;
			String regdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			String l=""+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT RIGHT(CONCAT('000000',(MAX(INT_ID)+1) ),6) from com_m_staffid")[0][0];
			regid=""+regdata[0][0]+CommonFunctions.getMonthShortName(Integer.parseInt(regdata[0][1]))+regdata[0][2]+l;
			CallableStatement cs = con.prepareCall("{call COM_PRO_STAFF(?,?,?,?,?,?,?,?,?,?,?," +
					" ?,?,?,?,?,?,?,?,?,?," +
					"?,?,?,?,?,?,?,?,?,?,?," +
					"?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, "INSERT");
			cs.setString(2, "");
			cs.setString(3, compid);
			cs.setString(4, branchid);
			cs.setString(5, regid);//staffid
			cs.setString(6, staffname);
			cs.setString(7, stafffname);
			cs.setString(8, deptid);
			cs.setString(9, desgid);
			cs.setString(10, officeid);
			cs.setString(11, gender);
			cs.setString(12, dob);
			cs.setString(13, blood);
			cs.setString(14, doj);
			cs.setString(15, grade);
			cs.setString(16, card);
			cs.setString(17, balance);
			cs.setString(18, type);
			cs.setString(19, salary);
			cs.setString(20, pf);
			cs.setString(21, esi);
			cs.setString(22,gross);
			cs.setString(23,married);
			cs.setString(24,weddate);
			cs.setString(25,bank);
			cs.setString(26,accno);
			cs.setString(27,stateid);
			cs.setString(28,districtid);
			cs.setString(29,pinno);
			cs.setString(30,padd1);
			cs.setString(31,padd2);
			cs.setString(32,pcity);
			cs.setString(33,pstate);
			cs.setString(34,ppin);
			cs.setString(35,sadd1);
			cs.setString(36,sadd2);
			cs.setString(37,scity);
			cs.setString(38,sstate );
			cs.setString(39,spin );
			cs.setString(40,pphone );
			cs.setString(41,sphone);
			cs.setString(42,emailid);
			cs.setString(43,peremailid);
			
			
			cs.setString(44,pftype);
			cs.setString(45,pfamt);
			cs.setString(46,pfno );
			cs.setString(47,esitype );
			cs.setString(48,esiamt );
			cs.setString(49,esino);
			cs.setString(50,userid);
			cs.setString(51,updatedate);
			cs.setString(52,status);
			cs.setString(53,mobile);
			cs.setString(54,carry);
			cs.setString(55,qualif);
			cs.setString(56,manag);
			cs.setString(57,repto);
			cs.setString(58,Reporinghead);
			cs.setString(59,hold );
			cs.setString(60,Dispensary  );
			cs.setString(61,conveyanceclear );
			cs.setString(62,salarycalculation );
			cs.setString(63,paysliphide);
			cs.setString(64,pannumber );
			cs.setString(65,passportnumber);
			cs.setString(66,drivingnumber);
			cs.setString(67,middlename);
			cs.setString(68,"N");//future10
			cs.setString(69,future10);
			cs.setString(70,Category );
			cs.setString(71,pfesidate );
			cs.setString(72,resigndate );
			cs.setString(73,previousdetails );
			cs.setString(74,pdistrict );
			cs.setString(75,pcountry );
			cs.setString(76,sdistrict );
			cs.setString(77,scountry );
			cs.setString(78,interview );
			cs.setString(79,rejoin );
			cs.setString(80,nominee );
			cs.setString(81,salarysplitupby );
			cs.execute();
			cs.close();   
			flag = true;
			com.my.org.erp.common.CommonFunctions.insertStaffImage(request.getRealPath("/")+"StaffPhoto/default.jpg", regid);
			
			
		} 
		catch (Exception e) 
		{
			 
			 System.out.println(""+e.getMessage());
		}
	}

	private void StaffUpdation(String comid,String branchId,String staffid, String staffname,
			String stafffname, String deptid, String desgid, String officeid,
			String gender, String dob, String blood, String doj, String grade,
			String card, String balance, String type, String salary, String pf,
			String esi, String gross, String married, String weddate,
			String bank, String accno, String stateid, String districtid,
			String pinno, String padd1, String padd2, String pcity,
			String pstate, String ppin, String sadd1, String sadd2,
			String scity, String sstate, String spin, String pphone,
			String sphone, String emailid, String peremailid,String pftype, String pfamt,
			String pfno, String esitype, String esiamt, String esino,
			String userid, String updatedate, String status,String mobile, 
			String carry,String qualif,String manag,String repto ,
			String Reporinghead,String hold,String Dispensary,
			String conveyanceclear,String salarycalculation,String payslip,String Category,String pfesidate, String resigndate,
			String pannumber,String passportnumber,String drivingnumber,String previousdetails,
			String middlename,String pdistrict,String pcountry,String sdistrict,
			String scountry,String interview,String rejoin, String nominee,
			 HttpServletResponse response) throws IOException 
			 {
		try 
		{
			 
			
			CallableStatement cs = con.prepareCall("{call COM_PRO_STAFF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, "UPDATE");
			cs.setString(2, "");
			cs.setString(3, comid);//compid
			cs.setString(4,branchId );//branchid
			cs.setString(5, staffid);//staffid
			cs.setString(6, staffname);
			cs.setString(7, stafffname);
			cs.setString(8, deptid);
			cs.setString(9, desgid);
			cs.setString(10, officeid);
			cs.setString(11, gender);
			cs.setString(12, dob);
			cs.setString(13, blood);
			cs.setString(14, doj);
			cs.setString(15, grade);
			cs.setString(16, card);
			cs.setString(17, balance);
			cs.setString(18, type);
			cs.setString(19, salary);
			cs.setString(20, pf);
			cs.setString(21, esi);
			cs.setString(22,gross);
			cs.setString(23,married);
			cs.setString(24,weddate);
			cs.setString(25,bank);
			cs.setString(26,accno);
			cs.setString(27,stateid);
			cs.setString(28,districtid);
			cs.setString(29,pinno);
			cs.setString(30,padd1);
			cs.setString(31,padd2);
			cs.setString(32,pcity);
			cs.setString(33,pstate);
			cs.setString(34,ppin);
			cs.setString(35,sadd1);
			cs.setString(36,sadd2);
			cs.setString(37,scity);
			cs.setString(38,sstate );
			cs.setString(39,spin );
			cs.setString(40,pphone );
			cs.setString(41,sphone);
			cs.setString(42,emailid);
			cs.setString(43,peremailid);
			
			
			cs.setString(44,pftype);
			cs.setString(45,pfamt);
			cs.setString(46,pfno );
			cs.setString(47,esitype );
			cs.setString(48,esiamt );
			cs.setString(49,esino);
			cs.setString(50,userid);
			cs.setString(51,updatedate);
			cs.setString(52,status);
			cs.setString(53,mobile);
			cs.setString(54,carry);
			cs.setString(55,qualif);
			cs.setString(56,manag);
			cs.setString(57,repto);
			cs.setString(58,Reporinghead);
			cs.setString(59,hold );
			cs.setString(60,Dispensary  );
			cs.setString(61,conveyanceclear );
			cs.setString(62,salarycalculation );
			cs.setString(63,payslip);//paysliphide
			cs.setString(64,pannumber );
			cs.setString(65,passportnumber);
			cs.setString(66,drivingnumber);
			cs.setString(67,middlename);
			cs.setString(68,"N");
			cs.setString(69,"");
			cs.setString(70,Category );
			cs.setString(71,pfesidate );
			cs.setString(72,resigndate );
			cs.setString(73,previousdetails );
			cs.setString(74,pdistrict );
			cs.setString(75,pcountry );
			cs.setString(76,sdistrict );
			cs.setString(77,scountry );
			cs.setString(78,interview );
			cs.setString(79,rejoin );
			cs.setString(80,nominee );
			cs.setString(81,"" );
			// System.out.println(""+cs);
			cs.execute();   
			cs.close();  
			 
			 
			flag = true;
		} 
		catch (Exception e) 
		{
			 System.out.println(""+e.getMessage());
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
		}

	}
==========================
 	private void StaffDeletion(String staffid) 
	{
		try 
		{
			String sql = "DELETE FROM  com_m_staff  ";
			sql = sql + " WHERE  CHR_EMPID ='" + staffid.trim() + "'";
			st = con.createStatement();
			st.executeUpdate(sql);
			sql = "DELETE FROM m_user ";
			sql = sql + " WHERE  CHR_EMPID ='" + staffid.trim() + "'";
			st.executeUpdate(sql);
			
			
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
		}

	} ===============================

	private void StaffUserCreation(String sql) 
	{
		try 
		{
			st = con.createStatement();
			st.executeUpdate(sql);
		}
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
		
		}

	}
	
	

	 
	
	public synchronized void  handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{

			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("yyyy-MM-dd");
			java.util.Date date = new java.util.Date();
			String updatedate = "" + datetime.format(date);
			String userId = (String) session.getAttribute("USRID");
			String leavesql="";
			leavesql="select  INT_ABOVEONEYEAR,INT_BELOWONEYEAR  from  att_m_leavetype order by INT_LEAVEID";
			String leavedata1[][] =com.my.org.erp.common.CommonFunctions.RecordSetArray(con,leavesql);
			double belowoneyearleave1=Double.parseDouble(leavedata1[0][1]);
			double belowoneyearleave2=Double.parseDouble(leavedata1[1][1]);
			double belowoneyearleave3=Double.parseDouble(leavedata1[2][1]);
			double belowoneyearleave4=Double.parseDouble(leavedata1[3][1]);
			double belowoneyearleave5=Double.parseDouble(leavedata1[4][1]);
			double belowoneyearleave6=Double.parseDouble(leavedata1[5][1]);
			 System.out.println(""+action);
			if ("GENStaffRegistration".equals(action)  ) 
			{
				try 
				{
					
					Map params = request.getParameterMap();
					Iterator i = params.keySet().iterator();
					 String keys=""; 
					while ( i.hasNext() )
					 {
					 String key = (String) i.next();
					 keys =keys+key+",";
					 String value = ((String[]) params.get( key ))[ 0 ];
					}
					 
					String comid = "" + request.getParameter("company");
					String branchid = "" + request.getParameter("branch");
					branchid.trim();
					String staffid = "" + request.getParameter("serverid");
					staffid.trim();
					String staffname = "" + request.getParameter("name");
					String stafffname = "" + request.getParameter("fname");
					String deptid = "" + request.getParameter("depart");
					if (deptid.equals("") || deptid.equals("null"))
						deptid = "0";

					String desgid = "" + request.getParameter("desig");
					if (desgid.equals("") || desgid.equals("null"))
						desgid = "0";

					String officeid = "" + request.getParameter("off");
					if (officeid.equals("") || officeid.equals("null"))
						officeid = "0";

					String gender = "" + request.getParameter("gender");
					String dob = "" + request.getParameter("dob");
					if (dob.equals("") || dob.equals("null"))
						dob = null;
					else {
						String dt[] = dob.split("-");
						dob = "" + dt[2] + "-" + dt[1] + "-" + dt[0] + "";
					}
					
					String blood = "" + request.getParameter("bg");
					String doj = "" + request.getParameter("doj");
					if (doj.equals("") || doj.equals("null"))
						doj = null;
					else {
						String dt[] = doj.split("-");
						doj = "" + dt[2] + "-" + dt[1] + "-" + dt[0] + "";
					}

					String grade = "" + request.getParameter("grade");
						if (grade.equals(""))
							grade=null;
						
					String card = "" + request.getParameter("card");
					if (card.equals("") || card.equals("null"))
						card=null;

					
					String balance = "" + request.getParameter("balance");
					if (balance.equals("") || balance.equals("null"))
						balance = "0";

					String type = "" + request.getParameter("type");
					String salary = "" + request.getParameter("basic");
					if (salary.equals("") || salary.equals("null"))
						salary = "0";

					String pf = "" + request.getParameter("pf");
					String esi = "" + request.getParameter("ESI");
					String gross = "" + request.getParameter("gross");
					if (gross.equals("") || gross.equals("null"))
						gross = "0";
					
					

					String married = "" + request.getParameter("marry");
					String weddate = "" + request.getParameter("wedding");
					if (weddate.equals("") || weddate.equals("null"))
						weddate = null;
					else {
						String dt[] = weddate.split("-");
						weddate = "" + dt[2] + "-" + dt[1] + "-" + dt[0] + "";
					}

					String bank = "" + request.getParameter("bank");
					String emailid = "" + request.getParameter("emailid");
					String peremailid = "" + request.getParameter("peremailid");
					String mobile = "" + request.getParameter("mobile");
					
					
					String accno = "" + request.getParameter("number");
					String stateid = "" + request.getParameter("st1");
					if (stateid.equals("") || stateid.equals("null"))
						stateid = "0";

					String districtid = "" + request.getParameter("dist");
					if (districtid.equals("") || districtid.equals("null"))
						districtid = "0";

					String pinno = "" + request.getParameter("pinno");
					if (pinno.equals("") || pinno.equals("null"))
						pinno = "0";
//basic
					
						
					 
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
					
					
					//pdistrict,pcountry,sdistrict,scountry
					
					
					String pftype = "" + request.getParameter("optpf");
					String pfamt = "" + request.getParameter("TxtPfValue");
					if (pfamt.equals("") || pfamt.equals("null"))
						pfamt = "0";

					String pfno = "" + request.getParameter("TxtPfNo");
					if(pfno.equals("") ||pfno.equals("null") )
						pfno=null;
					
					if("N".equals(pf))
					{
						pftype="";
						pfamt="0";
						pfno="0";
					}
					if("C".equals(pf))
						pfamt="0";
					
					
					
					String esitype = "" + request.getParameter("optesi");
					String esiamt = "" + request.getParameter("TxtEsiValue");
					if (esiamt.equals("") || esiamt.equals("null"))
						esiamt = "0";
					String esino = "" + request.getParameter("TxtEsiNo");
					if(esino.equals("") ||esino.equals("null") )
						esino=null;
					
					if("N".equals(esi))
					{
						esitype="";
						esiamt="0";
						esino="0";
					}
					if("C".equals(pf))
						esiamt="0";
					
					
					String status = "Y";
					String carry = "" + request.getParameter("carry");
					if("on".equals(carry))
						carry="Y";
					else
						carry="N";
					String management=""+request.getParameter("management");
					if("on".equals(management))
						management="Y";
					else
						management="N";
					
					String Reporinghead=""+request.getParameter("Reporinghead");
					if("on".equals(Reporinghead))
						Reporinghead="Y";
					else
						Reporinghead="N";
					
					
					String qualif= "" + request.getParameter("qualification");
					String repto= "" + request.getParameter("repto");
					String hold= "" + request.getParameter("hold");
					String Dispensary= "" + request.getParameter("Dispensary");
					String Category= "" + request.getParameter("Category");
					
					
					if(!"Y".equals(hold))
						hold="N";
					flag = false;
					
					
					String conveyanceclear=""+request.getParameter("conveyance");
					if("on".equals(conveyanceclear))
						conveyanceclear="Y";
					else
						conveyanceclear="N";
					
					String salarycalculation=""+request.getParameter("salarycalculation");
					if("on".equals(salarycalculation))
						salarycalculation="Y";
					else
						salarycalculation="N";
					
					String pfesidate = "" + request.getParameter("pfesidate");
					if (pfesidate.equals("") || pfesidate.equals("null"))
						pfesidate = null;
					else {
						pfesidate =DateUtil.FormateDateSQL(pfesidate);
						
					}
					
					
						
					
					String resigndate = "" + request.getParameter("resigndate");
					if (resigndate.equals("") || resigndate.equals("null"))
						resigndate = null;
					else {
						resigndate =DateUtil.FormateDateSQL(resigndate);
						
					}
					
					String interview = "" + request.getParameter("interview");
					if(interview.equals("Y"))
						interview="Y";
					else
						interview="N";
					
					String  future3=""; 
					String    future9="",future10="";
					
					String pannumber= ""+request.getParameter("pannumber");
					String passportnumber= ""+request.getParameter("passportnumber");
					String drivingnumber= ""+request.getParameter("drivingnumber");
					String previousdetails= ""+request.getParameter("previousdetails");
					String middlename= ""+request.getParameter("middlename");
					String rejoin= ""+request.getParameter("rejoin");
					if(rejoin.equals("Y"))
						rejoin="Y";
					else
						rejoin="N";
					String nominee= request.getParameter("nominee");
					String salarysplitupby= ""+request.getParameter("salarysplitupby");
					
					
					
					
					String ssql = " SELECT count(*) FROM m_user WHERE CHR_USRNAME='"+staffid+"'";
					
				 
					if(com.my.org.erp.common.CommonFunctions.RecordExist(con, ssql))
					{	
						ssql = " SELECT CHR_EMPID FROM m_user WHERE CHR_USRNAME='"+staffid+"'";
						String duplicate[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(ssql);
						response.sendRedirect("Smart Common/Staffadd.jsp?errM="+duplicate[0][0]+" - check data ");
					}
					 
					
					
					StaffInsertion(comid,branchid,staffid, staffname, stafffname, deptid, desgid,
							officeid, gender, dob, blood, doj, grade, card,
							balance, type, salary, pf, esi, gross, married,
							weddate, bank, accno, stateid, districtid, pinno,
							padd1, padd2, pcity, pstate, ppin, sadd1, sadd2, scity,
							sstate, spin, pphone, sphone, emailid, peremailid,pftype, pfamt,
							pfno, esitype, esiamt, esino, userId, updatedate,
							status,mobile,carry,qualif,management,repto,Reporinghead,
							hold,Dispensary,conveyanceclear,salarycalculation,future3,pannumber,passportnumber
							,drivingnumber,middlename,future9,future10,Category,pfesidate,resigndate,previousdetails,
							pdistrict,  pcountry,sdistrict,scountry ,interview,rejoin,nominee,salarysplitupby,request);
					
					 
					String password = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_PASSWORD FROM m_institution  WHERE INT_ID=1")[0][0];
					staffid=regid;
					int length = staffid.length();
					String s = staffid.substring(length-6);

					sql ="INSERT INTO M_USER (CHR_EMPID,CHR_USRNAME,CHR_USRPWD,CHR_USRDES,CHR_TYPE,DT_UPDATEDATE,CHR_UPDATESTATUS,CHR_MENUHRM,CHR_MENUATTENDANCE,CHR_MENUPAYROL,CHR_MENUMANAGEMENT,CHR_MENUMARKETING,CHR_MENUINVENTORY,CHR_MENUSTOCK,CHR_MENUACCOUNT,CHR_MENUUTILITY,CHR_MENUSTAFF,CHR_OFFICELIST)";
					sql = sql +" VALUES (";
					sql = sql +"'" +staffid+"' , ";
					sql = sql +"'" +s+"' , ";
					sql = sql +"(ENCODE('"+password+"','9865043008'))  , ";
					sql = sql +"'" +staffid+"' , ";
					sql = sql +"'S' , ";
					sql = sql +"'" +updatedate+"' ,'Y' ,'0','0', '0','0','0','0','0','0','0', ";
					//sql = sql +"'"+CommonFunctions.returnRootMenuid("SELECT INT_MENUID FROM  m_menu_hrm WHERE CHR_MENUDES ='Root'")+"' ,";// Root Element for CHR_MENUHRM
					//sql = sql +"'"+CommonFunctions.returnRootMenuid("SELECT INT_MENUID FROM  m_menu_attendance WHERE CHR_MENUDES ='Root'")+"' ,";// Root Element for CHR_MENUATTENDANCE
					//sql = sql +"'"+CommonFunctions.returnRootMenuid("SELECT INT_MENUID FROM  m_menu_payroll WHERE CHR_MENUDES ='Root'")+"' ,";// Root Element for CHR_MENUPAYROL
					//sql = sql +"'"+CommonFunctions.returnRootMenuid("SELECT INT_MENUID FROM  m_menu_management WHERE CHR_MENUDES ='Root'")+"' ,";// Root Element for CHR_MENUMANAGEMENT
					//sql = sql +"'"+CommonFunctions.returnRootMenuid("SELECT INT_MENUID FROM  m_menu_marketing WHERE CHR_MENUDES ='Root'")+"' ,";// Root Element for CHR_MENUMARKETING
					//sql = sql +"'"+CommonFunctions.returnRootMenuid("SELECT INT_MENUID FROM  m_menu_inventory WHERE CHR_MENUDES ='Root'")+"' ,";// Root Element for CHR_MENUINVENTORY
					//sql = sql +"'"+CommonFunctions.returnRootMenuid("SELECT INT_MENUID FROM  m_menu_stock WHERE CHR_MENUDES ='Root'")+"' ,";// Root Element for CHR_MENUSTOCK
					//sql = sql +"'"+CommonFunctions.returnRootMenuid("SELECT INT_MENUID FROM  m_menu_accounts WHERE CHR_MENUDES ='Root'")+"' ,";// Root Element for CHR_MENUACCOUNT
					//sql = sql +"'"+CommonFunctions.returnRootMenuid("SELECT INT_MENUID FROM  m_menu_utility WHERE CHR_MENUDES ='Root'")+"' ,";// Root Element for CHR_MENUUTILITY
					sql = sql +"'"+CommonFunctions.returnRootMenuid("SELECT INT_MENUID FROM  m_menu_staff WHERE CHR_MENUDES ='Root'")+"'  ,";// Root Element for CHR_MENUSTAFF
					sql = sql +officeid;// Root Element for CHR_OFFICELIST
					sql = sql +"  )";
					//CommonFunctions.ErrorWrite(sql); 
					

					if(flag)
					{	
						StaffUserCreation(sql);
						sql ="INSERT INTO com_m_staffid VALUES("+s+")";
						st.execute(sql);
					}
					
					 
					//leave credit
					sql = "INSERT INTO att_m_leave (CHR_EMPID,INT_YEAR,CHR_LEAVE1,INT_NOD1,INT_NOD1BALANCE";
					sql = sql +",CHR_LEAVE2,INT_NOD2,INT_NOD2BALANCE";
					sql = sql +",CHR_LEAVE3,INT_NOD3,INT_NOD3BALANCE";
					sql = sql +",CHR_LEAVE4,INT_NOD4,INT_NOD4BALANCE";
					sql = sql +",CHR_LEAVE5,INT_NOD5,INT_NOD5BALANCE";
					sql = sql +",CHR_LEAVE6,INT_NOD6,INT_NOD6BALANCE ) VALUES (";
					sql = sql +" '"+staffid+"', year(now()),";
					sql = sql +"'P',"+belowoneyearleave1+",0,";
					sql = sql +"'C',"+belowoneyearleave2+",0,";
					sql = sql +"'S',"+belowoneyearleave3+",0,";
					sql = sql +"'M',"+belowoneyearleave4+",0,";
					sql = sql +"'A',"+belowoneyearleave5+",0,";
					sql = sql +"'O',"+belowoneyearleave6+",0)";
					st.execute(sql);
					 
					
					
					//Insert Salary Structure...
					if("A".equals(salarysplitupby))
						com.my.org.erp.common.SalaryFunctions.salaryBand(staffid,Double.parseDouble(gross),type);
					else
						com.my.org.erp.common.SalaryFunctions.salaryBandManual(staffid,stateid);
					
					
					if("Y".equals(com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  CHR_NEWJOINNERMAILALERT  FROM m_institution  WHERE INT_ID= 1")[0][0]))
						sendNewJoinnerInfoMailtoAllEmp(staffid, com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_GROUPMAIL FROM m_institution WHERE INT_ID=1")[0][0]);
					
					
					//insert in to attendance register
					
					
					//insert into NA in Attendance register
					
					
					
					response.sendRedirect("Smart Common/Staffadd.jsp?addMore=Y&path=ATT&qp=ATT&regid="+regid+"&Name="+staffname+"&stateid="+stateid+"&salarysplitupby="+salarysplitupby);
				} 
				catch (RuntimeException e) 
				{
					 System.out.println(""+e.getMessage());
					
				}				
				
				
			} 
			else if ("GENStaffRegistrationUpdate".equals(action)) 
			{
				
				 
				String staffid = "" + request.getParameter("id");
				staffid.trim();
				String comid = "" + request.getParameter("company");
				String branchid = "" + request.getParameter("branch");
				branchid.trim();				
				String staffname = "" + request.getParameter("name");
				String stafffname = "" + request.getParameter("fname");
				String deptid = "" + request.getParameter("depart");
				if (deptid.equals("") || deptid.equals("null"))
					deptid = "0";
				String desgid = "" + request.getParameter("desig");
				if (desgid.equals("") || desgid.equals("null"))
					desgid = "0";
				String officeid = "" + request.getParameter("off");
				if (officeid.equals("") || officeid.equals("null"))
					officeid = "0";
				String gender = "" + request.getParameter("gender");
				String dob = "" + request.getParameter("dob");
				if (dob.equals("") || dob.equals("null"))
					dob = null;
				else {
					String dt[] = dob.split("-");
					dob = "" + dt[2] + "-" + dt[1] + "-" + dt[0] + "";
				}
				String blood = "" + request.getParameter("bg");
				String doj = "" + request.getParameter("doj");
				if (doj.equals("") || doj.equals("null"))
					doj = null;
				else {
					String dt[] = doj.split("-");
					doj = "" + dt[2] + "-" + dt[1] + "-" + dt[0] + "";
				}
				String grade = "" + request.getParameter("grade");
				String card = "" + request.getParameter("card");
				if (card.equals("") || card.equals("null"))
					card = null;
				
				String balance = "" + request.getParameter("balance");
				if (balance.equals("") || balance.equals("null"))
					balance = "0";
				String type = "" + request.getParameter("type");
				String salary = "" + request.getParameter("basic");
				if (salary.equals("") || salary.equals("null"))
					salary = "0.0";
				String pf = "" + request.getParameter("pf");
				String esi = "" + request.getParameter("ESI");
				String gross = "" + request.getParameter("gross");
				if (gross.equals("") || gross.equals("null"))
					gross = "0";
				String married = "" + request.getParameter("marry");
				String weddate = "" + request.getParameter("wedding");
				if (weddate.equals("") || weddate.equals("null"))
					weddate = null;
				else {
					String dt[] = weddate.split("-");
					weddate = "" + dt[2] + "-" + dt[1] + "-" + dt[0] + "";
				}
				
				String bank = "" + request.getParameter("bank");
				String emailid = "" + request.getParameter("emailid");
				String peremailid = "" + request.getParameter("peremailid");
				String accno = "" + request.getParameter("number");
				String stateid = "" + request.getParameter("st1");
				if (stateid.equals("") || stateid.equals("null"))
					stateid = "0";
				String districtid = "" + request.getParameter("dist");
				if (districtid.equals("") || districtid.equals("null"))
					districtid = "0";
				String pinno = "" + request.getParameter("pinno");
				if (pinno.equals("") || pinno.equals("null"))
					pinno = "0";
				
				
				String interview = "" + request.getParameter("interview");
				if(interview.equals("Y"))
					interview="Y";
				else
					interview="N";
				 
				
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
				
				//pdistrict,pcountry,sdistrict,scountry
				
				
				String pftype = "" + request.getParameter("optpf");
				String pfamt = "" + request.getParameter("TxtPfValue");
				
				if (pfamt.equals("") || pfamt.equals("null"))
					pfamt = "0";
				String pfno = "" + request.getParameter("TxtPfNo");
				if(pfno.equals("") ||pfno.equals("null") )
					pfno=null;
				String esitype = "" + request.getParameter("optesi");
				String esiamt = "" + request.getParameter("TxtEsiValue");
				if (esiamt.equals("") || esiamt.equals("null"))
					esiamt = "0";
				String esino = "" + request.getParameter("TxtEsiNo");
				if(esino.equals("") ||esino.equals("null") )
					esino=null;
				if("N".equals(pf))
				{
					pftype=pf;
					pfamt="0";
					pfno="0";
				}
				if("C".equals(pf))
					pfamt="0";
				
				if("N".equals(esi))
				{
					esitype=esi;
					esiamt="0";
					esino="0";
				}
				if("C".equals(pf))
					esiamt="0";
				String status = "Y";
				String mobile="" + request.getParameter("mobile");
				String carry = "" + request.getParameter("carry");
				String qualif= "" + request.getParameter("qualification");
				String repto= "" + request.getParameter("repto");
				if("on".equals(carry))
					carry="Y";
				else
					carry="N";
				String management=""+request.getParameter("management");
				if("on".equals(management))
					management="Y";
				else
					management="N";
				
				String Reporinghead=""+request.getParameter("Reporinghead");
				if("on".equals(Reporinghead))
					Reporinghead="Y";
				else
					Reporinghead="N";
				String hold= "" + request.getParameter("hold");
				if(!"Y".equals(hold))
					hold="N";
				
				String Dispensary= "" + request.getParameter("Dispensary");
				String conveyanceclear=""+request.getParameter("conveyance");
				if("on".equals(conveyanceclear))
					conveyanceclear="Y";
				else
					conveyanceclear="N";
				String salarycalculation=""+request.getParameter("salarycalculation");
				if("on".equals(salarycalculation))
					salarycalculation="Y";
				else
					salarycalculation="N";
				
				String payslip=""+request.getParameter("payslip");
				if("on".equals(payslip))
					payslip="Y";
				else
					payslip="N";
				
				String Category=""+request.getParameter("Category");
				String pfesidate = "" + request.getParameter("pfesidate");
				if (pfesidate.equals("") || pfesidate.equals("null"))
					pfesidate = null;
				else {
					pfesidate =DateUtil.FormateDateSQL(pfesidate);
					
				}
				
				String resigndate = "" + request.getParameter("resigndate");
				if (resigndate.equals("") || resigndate.equals("null"))
					resigndate = null;
				else {
					resigndate =DateUtil.FormateDateSQL(resigndate);
					
				}
				
				String pannumber= request.getParameter("pannumber");
				String passportnumber= request.getParameter("passportnumber");
				String drivingnumber= request.getParameter("drivingnumber");
				String previousdetails= request.getParameter("previousdetails");
				String middlename= request.getParameter("middlename");
				 
				String rejoin= ""+request.getParameter("rejoin");
				if(rejoin.equals("Y"))
					rejoin="Y";
				else
					rejoin="N";
				String nominee= request.getParameter("nominee");
				
				StaffUpdation(comid,branchid,staffid,staffname,stafffname, deptid, desgid,
						officeid, gender, dob, blood, doj, grade, card,
						balance, type, salary, pf, esi, gross, married,
						weddate, bank, accno, stateid, districtid, pinno,
						padd1, padd2, pcity, pstate, ppin, sadd1, sadd2, scity,
						sstate, spin, pphone, sphone, emailid, peremailid,pftype, pfamt,
						pfno, esitype, esiamt, esino, userId, updatedate,
						status,mobile,carry,qualif,management,repto,Reporinghead,hold,Dispensary,conveyanceclear,
						salarycalculation,payslip,Category,pfesidate,resigndate,pannumber,passportnumber,drivingnumber,
						previousdetails,middlename,pdistrict,pcountry,sdistrict,scountry,interview,rejoin,nominee, response);
				
				//Update Salary Structure...
				//com.my.org.erp.common.SalaryFunctions.salaryBandUpdation(con, staffid,Double.parseDouble(gross),type);
				
				 
				response.sendRedirect("Smart Common/StaffRegistrationView.jsp");
			} 
			else if ("COM_ATTStaffRegistrationDelete".equals(action) || "COM_PAYStaffRegistrationDelete".equals(action)) 
			{
				String staff[] = request.getParameterValues("staffid");
				String staffid = "";
				for (int i = 0; i < staff.length; i++) 
				{
					staffid = staff[i];
					staffid.trim();
					 
				}
				 
				response.sendRedirect("Smart Common/StaffRegistrationView.jsp");
				
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
				sql ="";
				sql =" UPDATE com_m_staff SET CHR_PADD1=?,CHR_PADD2=?,CHR_PCITY=?,INT_PDISTRICTID=?,CHR_PSTATE=?,INT_PCOUNTRYID=?,CHR_PPIN=?,CHR_PPHONE=?,";
				sql = sql +"                  CHR_SADD1=?,CHR_SADD2=?,CHR_SCITY=?,INT_CDISTRICTID=?,CHR_SSTATE=?,INT_CCOUNTRY=?,CHR_SPIN=?,CHR_SPHONE=?,CHR_ADDRESSSTATUS=? ,CHR_EMAILID=?, CHR_PERMAILID=?,CHR_MOBILE=?    WHERE CHR_EMPID=?";
				 
				pstm = con.prepareStatement(sql);
				pstm.setString(1,padd1 );
				pstm.setString(2,padd2);
				pstm.setString(3, pcity);
				pstm.setString(4,pdistrict);
				pstm.setString(5, pstate);
				pstm.setString(6,pcountry);
				pstm.setString(7, ppin);
				pstm.setString(8,pphone);
				pstm.setString(9, sadd1);
				pstm.setString(10,sadd2);
				pstm.setString(11, scity);
				pstm.setString(12,sdistrict);
				pstm.setString(13, sstate);
				pstm.setString(14,scountry);
				pstm.setString(15, spin);
				pstm.setString(16,sphone);
				pstm.setString(17,"Y");
				pstm.setString(18,emailid);
				pstm.setString(19,peremailid);
				pstm.setString(20,mobile);
				pstm.setString(21,empid);
				// System.out.println(""+pstm);
				pstm.execute();
				 
				response.sendRedirect(""+session.getAttribute("PAGE"));
				
			}
			
			

		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}
	
	
	

	
	public static void sendNewJoinnerInfoMailtoAllEmp(String newempid,String to)
    {
    	try
    	{
    		
    		
    		
    		String ssql =" SELECT  a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,b.CHR_COMPANYNAME,c.CHR_BRANCHNAME, d.CHR_DEPARTNAME,e.CHR_DESIGNAME,f.CHR_OFFICENAME,DATE_FORMAT(DT_DOB,'%d-%b-%Y'),a.CHR_GENDER,a.CHR_MARITALSTATUS,DATE_FORMAT(a.DT_WEDDATE,'%d-%b-%Y'), a.CHR_EMAILID,a.CHR_PERMAILID ,a.CHR_MOBILE,g.CHR_QUALIFICATIONNAME,a.CHR_PREVIOUSDETAILS,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y')   FROM   com_m_staff a ,  com_m_company b,  com_m_branch c,com_m_depart d,com_m_desig e, com_m_office  f,com_m_qualification g WHERE a.INT_COMPANYID = b.INT_COMPANYID AND a.INT_BRANCHID = c.INT_BRANCHID AND a.INT_DEPARTID = d.INT_DEPARTID  AND a.INT_DESIGID = e.INT_DESIGID 	AND a.INT_OFFICEID = f.INT_OFFICEID AND a.CHR_QUALIFICATION = g.INT_QUALIFICATIONID AND a.CHR_EMPID='"+newempid+"' ";
    		String pdatas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(ssql);
    		String cpyshortname=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_SHORTNAME FROM M_INSTITUTION WHERE INT_ID=1")[0][0];
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
    		=================content=content+"     <tr> ";
    		content=content+"      <td><span class='style15'>Mobile</span></td> ";
    		content=content+"       <td><span class='style12'>"+pdatas[0][14]+"</span></td> ";
    		content=content+"    </tr> ";=====================
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
    		content=content+"    <td bgcolor='#0099FF'><h4><font color='#ffffff'> Lets congratualate & wish her/him success for a good beginning towards the long journey with the team @ "+cpyshortname+".... </font></h4></td> ";
    		content=content+"  </tr> ";
    		content=content+"</table> ";
    		content=content+"</body> ";
    		content=content+"</html> ";
    		
    		 String hData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_HOST,CHR_USERID,CHR_PASSWORD,CHR_MAILID FROM  m_mailsetting WHERE INT_MAILID = 1");

             String host =hData[0][0]   ;
             String user =hData[0][1]   ;
             String password =hData[0][2]   ;
             String maild =hData[0][3]   ;
    		
    		Properties props = new Properties();
  	        props.setProperty("mail.transport.protocol", "smtp");
  	        props.setProperty("mail.host", ""+host);
	        props.setProperty("mail.user", ""+user);
  	        props.setProperty("mail.password", ""+password);

  	        ============
  	        Properties props = new Properties();
  	        props.setProperty("mail.transport.protocol", "smtp");
	  		props.setProperty("mail.host", "smtp.gmail.com");
	  		props.put("mail.smtp.auth", "true");
	  		props.put("mail.smtp.port", "465");
	  		props.put("mail.debug", "true");
	  		props.put("mail.smtp.socketFactory.port", "465");
	  		props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
	  		props.put("mail.smtp.socketFactory.fallback", "false");
	
	  		Session mailSession = Session.getDefaultInstance(props,new javax.mail.Authenticator() {
	  			 
	  			protected PasswordAuthentication getPasswordAuthentication() {
	  				return new PasswordAuthentication("abikalaiselvan",
	  						"abiaarthi");
	  			}
	  		});
	  		===============
  	        
  	        Session mailSession = Session.getDefaultInstance(props, null);
  	        mailSession.setDebug(true);
  	        Transport transport = mailSession.getTransport();
  	        MimeMessage message = new MimeMessage(mailSession);
  	        message.setSubject("****** WELCOME TO THE "+cpyshortname.toUpperCase()+" FAMILY *****");
  	        message.setFrom(new InternetAddress(""+maild));
  	        message.setContent(content, "text/html");
  	        message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
  	        transport.connect();
  	        transport.sendMessage(message, message.getRecipients(Message.RecipientType.TO));
  	        transport.close();
  	        
  	        ;
    	      
    	}
    	 
    	catch (Exception mex) 
    	{
    		mex.printStackTrace();
    		  
    		 
    		 
    	}
    }


}

	
	 */

}

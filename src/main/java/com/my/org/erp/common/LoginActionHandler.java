package com.my.org.erp.common;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.General.General;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.SmartAttendance.AttendanceFunctions;
import com.my.org.erp.common.CommonFunctions;
 
 
public class LoginActionHandler extends AbstractActionHandler 
{
	String userid = null;
	String pwd = null;
	String sql = null;
	HttpSession session = null;
	boolean f1 = true;
	private synchronized void checkLogin(HttpServletRequest request,	HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			application.setAttribute("LOGINMAILCHECKED", CommonFunctions.QueryExecute("SELECT  CHR_LOGINMAILDCHECK  FROM m_institution  WHERE INT_ID= 1")[0][0]);
			application.setAttribute("ERP_MESSAGE","");
			
			String currentdt[][] =CommonFunctions.QueryExecute("SELECT DAY(NOW()),if(MONTH(NOW())<10,CONCAT('0',MONTH(NOW())),MONTH(NOW())),MONTHNAME(NOW()),YEAR(NOW()),DATE_FORMAT(NOW(),'%d-%m-%Y')");
			if(currentdt.length>0)
			{
				application.setAttribute("CDAY",currentdt[0][0]);
				application.setAttribute("CNMONTH",currentdt[0][1]);
				application.setAttribute("CMMONTH",currentdt[0][2]);
				application.setAttribute("CYEAR",currentdt[0][3]);
				application.setAttribute("CDATE",currentdt[0][4]);
			}
			 
			sql = "SELECT FUN_GET_PASSWORD(a.CHR_EMPID),a.CHR_TYPE,a.CHR_EMPID,a.CHR_USRNAME, b.CHR_STAFFNAME,b.INT_OFFICEID, " +
					"c.CHR_OFFICENAME,b.INT_BRANCHID,b.CHR_EMAILID,b.CHR_MOBILE, b.CHR_PERMAILID,b.INT_DEPARTID,b.CHR_CATEGORY,a.INT_SESSIONTIME FROM m_user a ,com_m_staff b , com_m_office  c WHERE a.CHR_EMPID =b.CHR_EMPID  AND b.INT_OFFICEID = c.INT_OFFICEID AND b.CHR_TYPE !='T'  AND b.CHR_HOLD!='Y'  AND  a.CHR_USRNAME=?  AND FUN_GET_PASSWORD(a.CHR_EMPID) = ?";			
			
			session = request.getSession();
			apstm = con.prepareStatement(sql);
			apstm.setString(1, userid);
			apstm.setString(2, pwd);
			System.out.println(""+apstm);
			arst = apstm.executeQuery();
			if (arst.next()) 
			{
				try 
				{
					String type = arst.getString(2);
					String empid= arst.getString(3);
					String empname= arst.getString(5);
					String officeid = arst.getString(6);
					String officename = arst.getString(7);
					String branchid = arst.getString(8);
					String departmenid = arst.getString(12);
					String category = arst.getString(13);
					String sesdata[][]= CommonFunctions.QueryExecutecon(con,"SELECT INT_SESSION FROM m_institution WHERE INT_ID=1");
					int sessiontime = Integer.parseInt(sesdata[0][0]);
					sessiontime = Integer.parseInt(arst.getString(14));
					session.setMaxInactiveInterval(sessiontime); //10*60 = 600 seconds  
					CommonFunctions.Execute("UPDATE m_user set DAT_LOGINDATEANDTIME=NOW() WHERE CHR_USRNAME='"+userid+"'");
					
					if(!"S".equals(type.charAt(0)))
					{
						//Attendance Register creation
						if("F".equals(type.charAt(0)))
							AttendanceFunctions.registerCreation(con, apstm,userid);
						
						//Attendance Auto marking
						AttendanceFunctions.attendanceAutoMarking(con, apstm);
						//Common Holiday Auto Marking
						AttendanceFunctions.commonholidayAutoMarking(con, apstm);
					}
					
					checkUserType(type.charAt(0),session,empid,empname,officeid,officename,branchid,departmenid,category,request,response);
					
				} 
				catch (RuntimeException e) 
				{
					System.out.println(e.getMessage());
					response.sendRedirect("Login.jsp?loginmsg=Username and password do not match ");
				}
			} 
			else 
			{
				response.sendRedirect("Login.jsp?loginmsg=Username and password do not match ");
			}
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			response.sendRedirect("Unabletoserve.jsp");
		}
	}

	private void checkUserType(char type, HttpSession session,String empid,String empname,String officeid,String officename,String branchid,String departmenid, String category , HttpServletRequest request,	HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
				switch(type)
			    {
			    	case 'F': 
			    				session.setAttribute("USERTYPE", type);
			    				session.setAttribute("USRID",userid);
			    				session.setAttribute("EMPID", empid);
			    				session.setAttribute("EMPNAME", empname);
			    				session.setAttribute("USRPWD", pwd);
			    				session.setAttribute("USRTYPE", (""+type).toUpperCase());
			    				session.setAttribute("BRANCHID",branchid);
			    				session.setAttribute("OFFICEID",officeid);
			    				session.setAttribute("OFFICENAME",officename);
			    				session.setAttribute("DEPARTID",departmenid);
			    				session.setAttribute("CATEGORY",category);
			    				session.setAttribute("SESSIONID",session.getId());
			    				session.setAttribute("PAGE","sadmin.jsp");//sadmin.jsp Mainscreen.jsp Home.jsp
			    				String ldata[][] = CommonFunctions.QueryExecute("SELECT day(now())<3");
			    				if(!"0".equals(ldata[0][0]))
			    					CommonFunctions.FinancialYear();
			    				response.sendRedirect("Smart Common/Addressinformationupdate.jsp");
			    				break;
			         
			    	case 'B':
			    				session.setAttribute("USERTYPE", type);
			    				session.setAttribute("USRID", userid);
			    				session.setAttribute("EMPID", empid);
			    				session.setAttribute("EMPNAME", empname);
			    				session.setAttribute("USRPWD", pwd);
			    				session.setAttribute("USRTYPE", (""+type).toUpperCase());
			    				session.setAttribute("BRANCHID",branchid);
			    				session.setAttribute("OFFICEID",officeid);
			    				session.setAttribute("OFFICENAME",officename);
			    				session.setAttribute("DEPARTID",departmenid);
			    				session.setAttribute("CATEGORY",category);
			    				session.setAttribute("PAGE","Home.jsp");
			    				response.sendRedirect("Smart Common/Addressinformationupdate.jsp");
			         	        break;

			    	case 'A':
					    		session.setAttribute("USERTYPE", type);
								session.setAttribute("USRID", userid);
								session.setAttribute("EMPID", empid);
								session.setAttribute("EMPNAME", empname);
								session.setAttribute("USRPWD", pwd);
								session.setAttribute("USRTYPE", (""+type).toUpperCase());
								session.setAttribute("BRANCHID", branchid);
								session.setAttribute("OFFICEID", officeid);
								session.setAttribute("OFFICENAME", officename);
								session.setAttribute("DEPARTID",departmenid);
								session.setAttribute("CATEGORY",category);
								session.setAttribute("PAGE","Home.jsp");
								response.sendRedirect("Smart Common/Addressinformationupdate.jsp");
					    		break;
					    		
			    	case 'S':  
			    				session.setAttribute("USERTYPE", type);
			    				session.setAttribute("USRID", userid);
			    				session.setAttribute("EMPID", empid);
			    				session.setAttribute("EMPNAME", empname);
			    				session.setAttribute("USRPWD", pwd);
			    				session.setAttribute("USRTYPE", (""+type).toUpperCase());
			    				session.setAttribute("BRANCHID", branchid);
								session.setAttribute("OFFICEID", officeid);
								session.setAttribute("OFFICENAME", officename);
								session.setAttribute("DEPARTID",departmenid);
								session.setAttribute("CATEGORY",category);
								session.setAttribute("PAGE","Staff/index.jsp");
								response.sendRedirect("Smart Common/Addressinformationupdate.jsp");
								//response.sendRedirect("Smart Attendance/AttendanceStaffMain.jsp");
								//RequestDispatcher dispatcher3 = request.getRequestDispatcher("Smart Attendance/AttendanceStaffMain.jsp");
			    				//dispatcher3.forward(request, response);
			    				break;
			   }
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			response.sendRedirect("Unabletoserve.jsp");
			
		}
	}

	private void ResignedLogin(HttpServletRequest request,	HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			int datediff=0;
			asql = " SELECT DATEDIFF(DATE(NOW()),b.DT_TERM_DATE) FROM com_m_staff a, pay_m_emp_termination b, m_user c ";
			asql = asql +" WHERE a.CHR_EMPID =b.CHR_EMPID AND a.CHR_TYPE ='T' AND  a.CHR_EMPID =c.CHR_EMPID ";
			asql = asql +" AND  c.CHR_USRNAME ='"+userid+"'";
			System.out.println(asql);
			String dats[][] = CommonFunctions.QueryExecute(asql);
			if(dats.length>0)
				datediff= Integer.parseInt(dats[0][0]);
			int resigndays =Integer.parseInt(CommonFunctions.QueryExecute("SELECT INT_RESIGNERLOCK FROM m_institution WHERE INT_ID=1")[0][0]);
			System.out.println(datediff +"/"+ dats[0][0]+ "/"  );
			if(datediff > -1 && datediff <=resigndays )
			{	
				asql= " SELECT a.CHR_EMPID FROM  com_m_staff a ,m_user b ";
				asql = asql +" WHERE a.CHR_EMPID= b.CHR_EMPID "; //AND  a.CHR_PFCLAIMSTATUS='N'  AND a.CHR_PF!='N'
				asql = asql +" AND   a.CHR_TYPE ='T' ";
				asql = asql +" AND b.CHR_USRNAME='"+userid+"' ";
				asql = asql +" AND decode(b.CHR_USRPWD,'"+EncodeKey+"') = '"+pwd+"' ";
				String empid = CommonFunctions.QueryExecute(asql)[0][0];
				session = request.getSession();
				session.setAttribute("EMPID", empid);
				session.setAttribute("USRID", userid);
				session.setAttribute("USRPWD", pwd);
				CommonFunctions.Execute("UPDATE m_user set DAT_LOGINDATEANDTIME=NOW() WHERE CHR_USRNAME='"+userid+"'");
				response.sendRedirect("Resigned/index.jsp");
			}
			else
			{
				response.sendRedirect("Login.jsp?loginmsg=Sorry after "+resigndays+" days, Resigned people will not loggin....");
			}
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			response.sendRedirect("Login.jsp?loginmsg=Sorry, Resigned people not loggin....");
		}
	}
	
	
	
	private void suspensionLogin(HttpServletRequest request,	HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			int datediff=0;
			asql = " SELECT DATEDIFF(DATE(NOW()),b.DAT_APPROVED_DATE) FROM com_m_staff a, pay_t_temporarysuspension b, m_user c ";
			asql = asql +" WHERE a.CHR_EMPID =b.CHR_EMPID AND a.CHR_E_STATUS ='H' AND  a.CHR_EMPID =c.CHR_EMPID ";
			asql = asql +" AND  c.CHR_USRNAME ='"+userid+"'";
			 
			String dats[][] = CommonFunctions.QueryExecute(asql);
			if(dats.length>0)
				datediff= Integer.parseInt(dats[0][0]);
			int resigndays =Integer.parseInt(CommonFunctions.QueryExecute("SELECT INT_RESIGNERLOCK FROM m_institution WHERE INT_ID=1")[0][0]);
			 
			if(datediff > -1 && datediff <=resigndays )
			{	
				asql= " SELECT a.CHR_EMPID FROM  com_m_staff a ,m_user b ";
				asql = asql +" WHERE a.CHR_EMPID= b.CHR_EMPID "; 
				asql = asql +" AND   a.CHR_E_STATUS ='H' ";
				asql = asql +" AND b.CHR_USRNAME='"+userid+"' ";
				asql = asql +" AND decode(b.CHR_USRPWD,'"+EncodeKey+"') = '"+pwd+"' ";
				String empid = CommonFunctions.QueryExecute(asql)[0][0];
				session = request.getSession();
				session.setAttribute("EMPID", empid);
				session.setAttribute("USRID", userid);
				session.setAttribute("USRPWD", pwd);
				CommonFunctions.Execute("UPDATE m_user set DAT_LOGINDATEANDTIME=NOW() WHERE CHR_USRNAME='"+userid+"'");
				response.sendRedirect("suspend/index.jsp");
			}
			else
			{
				response.sendRedirect("Login.jsp?loginmsg=Sorry after "+resigndays+" days, Temporary suspension people will not loggin....");
			}
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			response.sendRedirect("Login.jsp?loginmsg=Sorry, Temporary suspension people not loggin....");
		}
	}
	
	
	
	@SuppressWarnings("deprecation")
	public synchronized void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			action = action.trim();
			userid = ""+request.getParameter("username");
			pwd = ""+request.getParameter("password"); 
			HttpSession session = request.getSession();
			
			
			String Mythra = application.getInitParameter("Mythra");
			boolean f=CommonFunctions.PackageExpired(Mythra ,request.getRealPath("/"));
			f1 =General.LockCheck(application.getInitParameter("Lock"));
			boolean f2 = PropertiesFunctions.getLicence();
			CommonFunctions.lockCheckDOB(request);
			System.out.println("f----"+f+"/"+f1+"/"+f2);
			
			if("Y".equals(application.getInitParameter("Db-Connect")) )
				if("1".equals(CommonFunctions.QueryExecute("SELECT ('"+Mythra+"'< DATE(NOW()))")[0][0]))
					CommonFunctions.ChangeRootPassword(con,"rose" );
			
			System.out.println("Path "+ Path);
			System.out.println("CHR_SYSOUT "+ CommonFunctions.QueryExecute("SELECT CHR_SYSOUT  FROM m_institution WHERE INT_ID=1")[0][0]);
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_SYSOUT  FROM m_institution WHERE INT_ID=1")[0][0]))
			{
					try {
						java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("yyyy-MM-dd");
						java.util.Date date = new java.util.Date();
						String updatedate = "" + datetime.format(date);
						System.out.println(Path + "log/" + updatedate + ".txt");
						File fi = new File(Path + "log/" + updatedate + ".txt");
						if (!fi.exists())
							fi.createNewFile();
						FileOutputStream outStr = new FileOutputStream(Path + "/log/" + updatedate + ".txt", true);
						PrintStream printStream = new PrintStream(outStr);
						System.out.println("Logfile created");
						System.setOut(printStream);
						System.out.println("Logfile created" + datetime.format(date));
					} catch (Exception e) {
						// TODO: handle exception
						System.out.println("Log file :"+e.getCause());
					}
			}
			
			if ("COM_Login".equals(action)) 
			{
				try 
				{
					String loginby = CommonFunctions.QueryExecute("SELECT CHR_LOGINBY FROM m_institution WHERE INT_ID = 1")[0][0];
					if(loginby.equals("M")){
						String domain = CommonFunctions.QueryExecute("SELECT CHR_EMAIL FROM m_company WHERE INT_CPYID = 1")[0][0].split("@")[1];
						userid = (userid + "@"+domain).toLowerCase();
						userid = CommonFunctions.QueryExecute("SELECT RIGHT(CHR_EMPID,6) FROM com_m_staff WHERE CHR_EMAILID ='"+userid+"'")[0][0];
					}
					
					//System.out.println(f+"/"+f1+"/"+f2);
					if(!"null".equals(userid) && !"null".equals(pwd)&&(f) &&(f1) && (f2))
					{	
						boolean resignedflag =false;
						boolean suspensionflag =false;
						
						session.setAttribute("COPYPAST", CommonFunctions.QueryExecute("SELECT  CHR_COPYPAST  FROM m_institution  WHERE INT_ID= 1")[0][0]);
						
						asql= " SELECT COUNT(*) FROM  com_m_staff a ,m_user b ";
						asql = asql +" WHERE a.CHR_EMPID= b.CHR_EMPID AND   a.CHR_TYPE ='T' ";
						//asql = asql +" AND  a.CHR_PFCLAIMSTATUS='N'  AND a.CHR_PF!='N'";
						asql = asql +" AND b.CHR_USRNAME='"+userid+"' ";
						asql = asql +" AND decode(b.CHR_USRPWD,'"+EncodeKey+"') = '"+pwd+"' ";
						
						resignedflag = CommonFunction.RecordExist(asql);
						
						asql= " SELECT COUNT(*) FROM  com_m_staff a ,m_user b ";
						asql = asql +" WHERE a.CHR_EMPID= b.CHR_EMPID AND   a.CHR_E_STATUS ='H' ";
						asql = asql +" AND b.CHR_USRNAME='"+userid+"' ";
						asql = asql +" AND decode(b.CHR_USRPWD,'"+EncodeKey+"') = '"+pwd+"' ";
						suspensionflag = CommonFunction.RecordExist(asql);
					
						
						if(resignedflag )
							ResignedLogin(request, response);
						else if(suspensionflag )
							suspensionLogin(request, response);
						else
							checkLogin(request, response);
					}	
					else
					{
						//PropertiesFunctions.overwriteLicence(request);
						//FileFunctions.deleteDir(new File(request.getRealPath("/")+"WEB-INF/lib"));
						//response.sendRedirect("Login.jsp?loginmsg=\" "+request.getRealPath("/") + " \", Smart Database marked as crashed and should be repaired " );
						response.sendRedirect("Login.jsp?loginmsg=check licence key");
								
					}
				}
				catch (RuntimeException e) 
				{
					System.out.println(e.getMessage());
					response.sendRedirect("Login.jsp?loginmsg=Username and password do not match :"+e.getMessage());
				}
			}
			else if (action.equalsIgnoreCase("COM_Logout")) 
			{
				session = request.getSession(false);
				session.removeAttribute("USERTYPE");
				session.removeAttribute("USRID");
				session.removeAttribute("EMPID");
				session.removeAttribute("EMPNAME");
				session.removeAttribute("USRPWD");
				session.removeAttribute("USRTYPE");
				session.removeAttribute("BRANCHID");
				session.removeAttribute("OFFICEID");
				session.removeAttribute("OFFICENAME");
				if(session != null)
				     session.invalidate();
		        request.getSession().invalidate();
		        //http://crunchify.com/simplest-spring-mvc-hello-world-example-tutorial-spring-model-view-controller-tips/
				CommonFunctions.Execute("UPDATE m_user set DAT_LOGINDATEANDTIME=NOW() WHERE CHR_USRNAME='"+userid+"'");
				System.out.println("LOGOUT ATION");
				response.sendRedirect("Login.jsp");
			}
			else if (action.equalsIgnoreCase("COM_Update")) 
			{
				String empid = request.getParameter("empid");
				String emailid = request.getParameter("emailid");
				String peremailid = request.getParameter("peremailid");
				String mobile = request.getParameter("mobile");
				String dob = request.getParameter("dob");
				sql =" UPDATE com_m_staff SET CHR_EMAILID='"+emailid.toLowerCase()+"' ,CHR_PERMAILID ='"+peremailid.toLowerCase()+"', CHR_MOBILE="+mobile.toLowerCase()+" ,DT_DOB='"+DateUtil.FormateDateSQL(dob)+"' WHERE CHR_EMPID='"+empid+"'";
				CommonFunctions.Execute(sql);
				response.sendRedirect("Login.jsp");
			}
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			response.sendRedirect("InValidSession.jsp?error=" + e.getMessage());
		}
	}
}

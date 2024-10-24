package com.my.org.erp.SmartCommon;

import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.mail.Mail;
import com.my.org.erp.setting.CommonData;

public class SmartCommonFunctions 
{
	private static String csql="";
	private static String settingmailids;
	private static String today;
	
	public static void serviceCardReport() 
	 {
		try 
	 	{
	 		
			  csql="";
			  csql =" SELECT TIME_format(now(),'%H') ";
			  String timeData[][] = CommonFunctions.QueryExecute(" SELECT TIME_format(now(),'%H') ");
			  int currenttime = Integer.parseInt(timeData[0][0]);
			   
			  csql =" SELECT CHR_DAILY_PENDING_MAIL,CHR_DAILY_PENDING_MAIL_IDS, ";
			  csql = csql + " INT_DAILY_PENDING_MAIL_TIME ";
			  csql = csql + " FROM pay_m_basicsettings  WHERE INT_ID=1 ";
			  String settingData[][] = CommonFunctions.QueryExecute(csql);
			  boolean f = false;
			  if("Y".equals(settingData[0][0] ))
				  f = true;
			  
			  settingmailids =  settingData[0][1] ;
			  
			  int settingtime = Integer.parseInt(settingData[0][2]);
			  today =CommonFunctions.QueryExecute(" SELECT date_format(now(),'%d-%m-%Y')")[0][0];
			 
			  if(f)
				  if(currenttime >=settingtime)
				  {
				  	csql =" select count(*) from  sendmail_to_t_staffservicecard  WHERE CHR_DATE = date_format(now(),'%Y-%m-%d') ";
					if(!CommonFunctions.QueryExecute(csql)[0][0].equals("1")) 
					{
						csql = "";
						csql = csql + " INSERT INTO sendmail_to_t_staffservicecard (CHR_DATE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) ";
						csql = csql + " VALUES(date_format(now(),'%Y-%m-%d') ,'ADMIN' ,date_format(now(),'%Y-%m-%d') ,'Y') ";
						CommonFunctions.Execute(csql);
						serviceCardReports();
						staffNDCReports() ;
						NDCFinal() ;
						needStaffRegistrationApproval();
						
						// staffRevisionReports() ;
						
						if("1".equals(CommonFunctions.QueryExecute("select (DAYNAME(now())='Friday')")[0][0]))
							Poorrecruitment();
						
						csql = "DELETE FROM sendmail_to_t_staffservicecard  WHERE  CHR_DATE < date_format(now(),'%Y-%m-%d')  ";
						CommonFunctions.Execute(csql);
						
					}
				  }
				  
			
	 	}
	 	catch (Exception e) 
	 	{
	 		System.out.println(e.getMessage()); 
	 	}
	 	 
	 }
	
	
	public static void  serviceCardReports() 
	 {
		String content="";
		content = content +" <style type='text/css'> ";
		content = content +" .boldred { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #FF0000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .boldgreen { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #006600; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .boldEleven { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .MRow1 { ";
		content = content +" BACKGROUND-COLOR: #fdfae7; ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana; ";
		content = content +" TEXT-DECORATION: none; ";
		content = content +" } ";
		content = content +" .MRow2 { ";
		content = content +" BACKGROUND-COLOR: #FFDAB9; ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana; ";
		content = content +" TEXT-DECORATION: none; ";
		content = content +" } "; 
		content = content +" </style> ";
		try 
	 	{
			csql="";
			
			csql = csql + " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'), c.CHR_OFFICENAME,";
			csql = csql + " if(isnull(b.IMG_IMAGE) =false ,'','Photo Need'), ";
			csql = csql + " if(isnull(b.IMG_CERTIFICATE) =false ,'','Certificate Need'), ";
			csql = csql + " if(isnull(b.IMG_PROFILE) =false ,'','Profile Need') ";
			csql = csql + " FROM com_m_staff a , com_m_staffaddressproof b, com_m_office c ";
			csql = csql + " WHERE a.CHR_EMPID = b.CHR_EMPID AND a.INT_OFFICEID= c.INT_OFFICEID ";
			csql = csql + " AND a.DT_DOJCOLLEGE >= '2013-08-01' ";
			csql = csql + " AND a.CHR_TYPE != 'T'  ";
			csql = csql + " AND ((isnull(b.IMG_IMAGE)) or (isnull(b.IMG_CERTIFICATE)) or (isnull(b.IMG_PROFILE))) ";
			csql = csql + " ORDER BY a.CHR_STAFFNAME ";
			String data[][] =CommonFunctions.QueryExecute(csql);
			 
			if(data.length>0)
			{
				content = content +" <table  border='0' width='95%' cellpadding=2 cellspacing=2  bgcolor='#000000' >" ;
				content = content +" <tr class='MRow1'>" ;
				content = content +" <td align='center'><b>S.No</b></td>" ;
				content = content +" <td align='center'><b>Employee Id</b></td>" ;
				content = content +" <td align='center'><b>Employee Name</b></td>" ;
				content = content +" <td align='center'><b>DOJ</b></td>" ;
				content = content +" <td align='center'><b>Location</b></td>" ;
				content = content +" <td align='center'><b>Photo</b></td>" ;
				content = content +" <td align='center'><b>Certificate</b></td>" ;
				content = content +" <td align='center'><b>Profile</b></td>" ;
				content = content +" </tr>" ;
				for(int u=0;u<data.length;u++)
				{
					if(u%2==0)	
						content = content +" <tr class='MRow1' >" ;
					else
						content = content +" <tr class='MRow2' >" ;
					content = content +" <td >"+(u+1)+"</td>" ;
					content = content +" <td >"+data[u][0]+"</td>" ;
					content = content +" <td >"+data[u][1]+"</td>" ;
					content = content +" <td >"+data[u][2]+"</td>" ;
					content = content +" <td >"+data[u][3]+"</td>" ;
					content = content +" <td >"+data[u][4]+"</td>" ;
					content = content +" <td >"+data[u][5]+"</td>" ;
					content = content +" <td >"+data[u][6]+"</td>" ;
					content = content +" </tr>" ;
				}
				
				content = content +" </table>";
				

				String a[] =(settingmailids+","+CommonData.mailid).split(",") ;
				Mail.SimpleHTMLMail(  a,  "[ "+today +" ] Service Card Remainder ", content);
				
			}
			 
			 
	 	}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		 
	}

	
	
	

	public static void  staffNDCReports() 
	 {
		String content="";
		content = content +" <style type='text/css'> ";
		content = content +" .boldred { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #FF0000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .boldgreen { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #006600; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .boldEleven { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .MRow1 { ";
		content = content +" BACKGROUND-COLOR: #fdfae7; ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana; ";
		content = content +" TEXT-DECORATION: none; ";
		content = content +" } ";
		content = content +" .MRow2 { ";
		content = content +" BACKGROUND-COLOR: #FFDAB9; ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana; ";
		content = content +" TEXT-DECORATION: none; ";
		content = content +" } "; 
		content = content +" </style> ";
		try 
	 	{
			csql="";
			csql = csql + " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,e.CHR_OFFICENAME, ";
			csql = csql + " b.CHR_TER_TYPE,DATE_FORMAT(b.DT_TERM_DATE,'%d-%b-%Y'),datediff(now(),b.DT_TERM_DATE), ";
			csql = csql + " if(c.CHR_STATUS = 'Y','','Need Exit interview'), ";
			//csql = csql + " if(d.CHR_FINAL = 'Y','','Need NDC Tracking'), ";
			csql = csql + " if(d.CHR_STORE='Y' , '<font color=\"green\">Closed</font>' , '<font color=\"red\"><b>Pending</font>'), ";
			csql = csql + " if(d.CHR_HR='Y' , '<font color=\"green\">Closed</font>' , '<font color=\"red\"><b>Pending</font>'), ";
			csql = csql + " if(d.CHR_ACCOUNTS='Y' , '<font color=\"green\">Closed</font>' , '<font color=\"red\"><b>Pending</font>'), ";
			csql = csql + " if(d.CHR_GENERAL='Y' , '<font color=\"green\">Closed</font>' , '<font color=\"red\"><b>Pending</font>'), ";
			csql = csql + " if(d.CHR_FINAL='Y' , '<font color=\"green\">Closed</font>' , '<font color=\"red\"><b>Pending</font>')  ";
				
			csql = csql + " FROM com_m_staff a ,pay_m_emp_termination b , pay_t_exitinterview c ,pay_t_emp_ndc d,com_m_office e ";
			csql = csql + " WHERE a.CHR_EMPID = b.CHR_EMPID AND a.CHR_EMPID = c.CHR_EMPID AND a.CHR_EMPID = d.CHR_EMPID ";
			csql = csql + " AND a.INT_OFFICEID = e.INT_OFFICEID AND CHR_TER_TYPE !='Abscond' ";
			csql = csql + " AND b.DT_TERM_DATE >= '2013-05-01' ";
			csql = csql + " AND ( c.CHR_STATUS != 'Y' OR  d.CHR_FINAL != 'Y'  ) ";
			csql = csql + " AND d.CHR_FINAL != 'Y' ";
			csql = csql + " ORDER BY  e.CHR_OFFICENAME,a.CHR_STAFFNAME ";
			
			String data[][] =CommonFunctions.QueryExecute(csql);
			 
			if(data.length>0)
			{
				content = content +" <table  border='0' width='95%' cellpadding=2 cellspacing=2  bgcolor='#000000' >" ;
				content = content +" <tr  class='MRow1'>" ;
				content = content +" <td align='center'><b>S.No</b></td>" ;
				content = content +" <td align='center'><b>Employee Id</b></td>" ;
				content = content +" <td align='center'><b>Employee Name</b></td>" ;
				content = content +" <td align='center'><b>Office</b></td>" ;
				content = content +" <td align='center'><b>Reason</b></td>" ;
				content = content +" <td align='center'><b>DOR</b></td>" ;
				content = content +" <td align='center'><b>Due</b></td>" ;
				content = content +" <td align='center'><b>Exit Interview</b></td>" ;
				content = content +" <td align='center'><b>STORE</b></td>" ;
				content = content +" <td align='center'><b>HR</b></td>" ;
				content = content +" <td align='center'><b>ACCOUNTS</b></td>" ;
				content = content +" <td align='center'><b>BUSINESS</b></td>" ;
				content = content +" <td align='center'><b>FINAL</b></td>" ;
				
				content = content +" </tr>" ;
				for(int u=0;u<data.length;u++)
				{
					if(u%2==0)	
						content = content +" <tr class='MRow1' >" ;
					else
						content = content +" <tr class='MRow2' >" ;
					 
					content = content +" <td >"+(u+1)+"</td>" ;
					content = content +" <td >"+data[u][0]+"</td>" ;
					content = content +" <td >"+data[u][1]+"</td>" ;
					content = content +" <td >"+data[u][2]+"</td>" ;
					content = content +" <td >"+data[u][3]+"</td>" ;
					content = content +" <td >"+data[u][4]+"</td>" ;
					content = content +" <td >"+data[u][5]+"</td>" ;
					content = content +" <td >"+data[u][6]+"</td>" ;
					content = content +" <td >"+data[u][7]+"</td>" ;
					content = content +" <td >"+data[u][8]+"</td>" ;
					content = content +" <td >"+data[u][9]+"</td>" ;
					content = content +" <td >"+data[u][10]+"</td>" ;
					content = content +" <td >"+data[u][11]+"</td>" ;
					content = content +" </tr>" ;
				}
				
				content = content +" </table>";		
				
				String a[] =(settingmailids+","+CommonData.mailid).split(",") ;
				Mail.SimpleHTMLMail(  a,  "[ "+today +" ] NDC Remainder ", content);
				
				
			}
			 
			 
	 	}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		 
	}

	
	public static void  staffRevisionReports() 
	 {
		String content="";
		try 
	 	{
			csql="";
			csql = csql + " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,b.CHR_COMPANYNAME,c.CHR_BRANCHNAME,d.CHR_OFFICENAME, e.CHR_CATEGORYNAME  ";
			csql = csql + " ,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),  ";
			csql = csql + " a.DAT_RIVISION ,DATEDIFF(now(),a.DAT_RIVISION) ";
			csql = csql + " FROM com_m_staff a ,com_m_company b, com_m_branch c, com_m_office d, com_m_employeecategory e  ";
			csql = csql + " WHERE a.INT_COMPANYID = b.INT_COMPANYID  ";
			csql = csql + " AND a.INT_BRANCHID = c.INT_BRANCHID  ";
			csql = csql + " AND a.INT_OFFICEID = d.INT_OFFICEID  ";
			csql = csql + " AND a.CHR_CATEGORY = e.INT_EMPLOYEECATEGORYID  ";
			csql = csql + " AND a.CHR_TYPE != 'T'  ";
			csql = csql + " AND a.DAT_RIVISION is not null  "; 
			csql = csql + " AND (  ";
			csql = csql + "       ( MONTH(a.DAT_RIVISION)=MONTH(NOW()) AND YEAR(a.DAT_RIVISION) = YEAR(NOW()) )  ";
			csql = csql + "        OR ( a.DAT_RIVISION <=DATE(NOW()) )  ";
			csql = csql + "      )  ";
			String data[][] =CommonFunctions.QueryExecute(csql);
			 
			if(data.length>0)
			{
				content = content +" <table width='100%'  class='boldEleven'  id='myTable'  border='1' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >" ;
				content = content +" <tr bgcolor='#ffffff'>" ;
				content = content +" <td align='center'><b>S.No</b></td>" ;
				content = content +" <td align='center'><b>Employee Id</b></td>" ;
				content = content +" <td align='center'><b>Employee Name</b></td>" ;
				content = content +" <td align='center'><b>Compant</b></td>" ;
				content = content +" <td align='center'><b>Branch</b></td>" ;
				content = content +" <td align='center'><b>Office</b></td>" ;
				content = content +" <td align='center'><b>Category</b></td>" ;
				content = content +" <td align='center'><b>DOJ</b></td>" ;
				content = content +" <td align='center'><b>Revision</b></td>" ;
				content = content +" <td align='center'><b>Days Difference</b></td>" ;
				content = content +" </tr>" ;
				for(int u=0;u<data.length;u++)
				{
					if(u%2==0)	
						content = content +" <tr bgcolor='#ffffff'>" ;
					else
						content = content +" <tr bgcolor='#FFDAB9'>" ;
					content = content +" <td >"+(u+1)+"</td>" ;
					content = content +" <td >"+data[u][0]+"</td>" ;
					content = content +" <td >"+data[u][1]+"</td>" ;
					content = content +" <td >"+data[u][2]+"</td>" ;
					content = content +" <td >"+data[u][3]+"</td>" ;
					content = content +" <td >"+data[u][4]+"</td>" ;
					content = content +" <td >"+data[u][5]+"</td>" ;
					content = content +" <td >"+data[u][6]+"</td>" ;
					content = content +" <td >"+data[u][7]+"</td>" ;
					content = content +" <td >"+data[u][8]+"</td>" ;
					content = content +" </tr>" ;
				}
				
				content = content +" </table>";	 	
				
				String a[] =(settingmailids+","+CommonData.mailid).split(",") ;
				Mail.SimpleHTMLMail(  a,  "[ "+today +" ] Revision Remainder ", content);
			}
			 
			 
	 	}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		 
	}

	 
	
	
	
	public static void  Poorrecruitment() 
	 {
		String content="";
		content = content +" <style type='text/css'> ";
		content = content +" .boldred { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #FF0000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .boldgreen { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #006600; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .boldEleven { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .MRow1 { ";
		content = content +" BACKGROUND-COLOR: #fdfae7; ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana; ";
		content = content +" TEXT-DECORATION: none; ";
		content = content +" } ";
		content = content +" .MRow2 { ";
		content = content +" BACKGROUND-COLOR: #FFDAB9; ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana; ";
		content = content +" TEXT-DECORATION: none; ";
		content = content +" } "; 
		content = content +" </style> ";
		try 
	 	{
			csql="";
			csql = csql + " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,c.CHR_OFFICENAME,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'), ";   
			csql = csql + "  DATE_FORMAT(b.DT_TERM_DATE,'%d-%b-%Y'),  ";
			csql = csql + "  datediff(b.DT_TERM_DATE,a.DT_DOJCOLLEGE)  ";
			csql = csql + "  FROM com_m_staff a , pay_m_emp_termination b,com_m_office c ";  
			csql = csql + "  WHERE a.CHR_EMPID =b.CHR_EMPID AND a.CHR_TYPE ='T' ";  
			csql = csql + "  AND a.INT_OFFICEID = c.INT_OFFICEID  ";
			csql = csql + "  AND a.DT_DOJCOLLEGE >= DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 60 DAY),'%Y-%m-%d') ";
			csql = csql + "  AND a.DT_DOJCOLLEGE <=date(now()) ";
			csql = csql + "  AND datediff(b.DT_TERM_DATE,a.DT_DOJCOLLEGE) <= 60 ";
			csql = csql + "  ORDER BY  a.CHR_STAFFNAME ";
			String data[][] =CommonFunctions.QueryExecute(csql);
			 
			if(data.length>0)
			{
				content = content +" <table  border='0' width='95%' cellpadding=2 cellspacing=2  bgcolor='#000000' >" ;
				content = content +" <tr class='MRow1'>" ;
				content = content +" <td align='center'><b>S.No</b></td>" ;
				content = content +" <td align='center'><b>Employee Id</b></td>" ;
				content = content +" <td align='center'><b>Employee Name</b></td>" ;
				content = content +" <td align='center'><b>Office</b></td>" ;
				content = content +" <td align='center'><b>DOJ</b></td>" ;
				content = content +" <td align='center'><b>DOR</b></td>" ;
				content = content +" <td align='center'><b>Age [ Days ]</b></td>" ;
				content = content +" </tr>" ;
				for(int u=0;u<data.length;u++)
				{
					if(u%2==0)
						content = content +" <tr class='MRow1' >" ;
					else
						content = content +" <tr  class='MRow2'  >" ;
					
					content = content +" <td >"+(u+1)+"</td>" ;
					content = content +" <td >"+data[u][0]+"</td>" ;
					content = content +" <td >"+data[u][1]+"</td>" ;
					content = content +" <td >"+data[u][2]+"</td>" ;
					content = content +" <td >"+data[u][3]+"</td>" ;
					content = content +" <td >"+data[u][4]+"</td>" ;
					content = content +" <td >"+data[u][5]+"</td>" ;
					content = content +" </tr>" ;
				}
				content = content +" </table>";	 	
				String a[] =(settingmailids+","+CommonData.mailid).split(",") ;
				Mail.SimpleHTMLMail(  a,  "[ ABORT CASES  ]  ", content);
					
			}
			
			
			
			 
	 	}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		 
	}

	 
	 
	

	public static void  NDCFinal() 
	 {
		String content="";
		content = content +" <style type='text/css'> ";
		content = content +" .boldred { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #FF0000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .boldgreen { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #006600; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .boldEleven { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .MRow1 { ";
		content = content +" BACKGROUND-COLOR: #fdfae7; ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana; ";
		content = content +" TEXT-DECORATION: none; ";
		content = content +" } ";
		content = content +" .MRow2 { ";
		content = content +" BACKGROUND-COLOR: #FFDAB9; ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana; ";
		content = content +" TEXT-DECORATION: none; ";
		content = content +" } "; 
		content = content +" </style> ";
		try 
	 	{
			csql="";
			
			csql = csql + " SELECT a.CHR_EMPID,a.CHR_STAFFNAME, ";
			csql = csql + " c.CHR_BRANCHNAME, ";
			csql = csql + " DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'), ";
			csql = csql + " DATE_FORMAT(b.DAT_CREATION_DATE,'%d-%b-%Y'), ";
			csql = csql + " DATEDIFF(NOW(),b.DAT_CREATION_DATE) ";
			csql = csql + " FROM com_m_staff a, pay_t_emp_ndc b, com_m_branch c ";
			csql = csql + " WHERE a.CHR_EMPID = b.CHR_EMPID ";
			csql = csql + " AND a.INT_BRANCHID = c.INT_BRANCHID ";
			csql = csql + " AND b.CHR_STORE='Y' ";
			csql = csql + " AND b.CHR_ACCOUNTS='Y' ";
			csql = csql + " AND b.CHR_HR='Y' ";
			csql = csql + " AND b.CHR_GENERAL='Y' ";
			csql = csql + " AND b.CHR_FINAL !='Y' ";
			csql = csql + " ORDER BY a.CHR_STAFFNAME ";
			
			String data[][] =CommonFunctions.QueryExecute(csql);
			 
			if(data.length>0)
			{
				content = content +" <table  border='0' width='95%' cellpadding=2 cellspacing=2  bgcolor='#000000' >" ;
				content = content +" <tr class='MRow1'>" ;
				content = content +" <td align='center'><b>S.No</b></td>" ;
				content = content +" <td align='center'><b>Employee Id</b></td>" ;
				content = content +" <td align='center'><b>Employee Name</b></td>" ;
				content = content +" <td align='center'><b>Office</b></td>" ;
				content = content +" <td align='center'><b>DOJ</b></td>" ;
				content = content +" <td align='center'><b>DOR</b></td>" ;
				content = content +" <td align='center'><b>Age [ Days ]</b></td>" ;
				content = content +" </tr>" ;
				for(int u=0;u<data.length;u++)
				{
					if(u%2==0)
						content = content +" <tr class='MRow1' >" ;
					else
						content = content +" <tr  class='MRow2'  >" ;
					
					content = content +" <td >"+(u+1)+"</td>" ;
					content = content +" <td >"+data[u][0]+"</td>" ;
					content = content +" <td >"+data[u][1]+"</td>" ;
					content = content +" <td >"+data[u][2]+"</td>" ;
					content = content +" <td >"+data[u][3]+"</td>" ;
					content = content +" <td >"+data[u][4]+"</td>" ;
					content = content +" <td >"+data[u][5]+"</td>" ;
					content = content +" </tr>" ;
				}
				
				content = content +" </table>";	 	
				//settingmailids
				String a[] =(settingmailids+","+CommonData.mailid).split(",") ;
				Mail.SimpleHTMLMail(  a,  "[ NDC FINAL NEDD  ]  ", content);
					
			}
			
			
			
			 
	 	}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		 
	}
	
	public static void  needStaffRegistrationApproval() 
	 {
		String content="";
		content = content +" <style type='text/css'> ";
		content = content +" .boldred { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #FF0000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .boldgreen { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #006600; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .boldEleven { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .MRow1 { ";
		content = content +" BACKGROUND-COLOR: #fdfae7; ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana; ";
		content = content +" TEXT-DECORATION: none; ";
		content = content +" } ";
		content = content +" .MRow2 { ";
		content = content +" BACKGROUND-COLOR: #FFDAB9; ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana; ";
		content = content +" TEXT-DECORATION: none; ";
		content = content +" } "; 
		content = content +" </style> ";
		try 
	 	{
			csql="";
			csql = csql + " SELECT CHR_EMPID,CHR_STAFFNAME,DATE_FORMAT(DT_CREATION_DATE,'%d-%b-%Y'), "; 
			csql = csql + " datediff(now(),DT_CREATION_DATE), timediff(now(),DT_CREATION_DATE) "; 
			csql = csql + " FROM com_m_staff  WHERE CHR_APPROVED ='N' "; 
			csql = csql + " ORDER BY  DATEDIFF(NOW(),DT_CREATION_DATE) desc "; 
			String data[][] =CommonFunctions.QueryExecute(csql);
			 
			if(data.length>0)
			{
				content = content +" <table  border='0' width='95%' cellpadding=2 cellspacing=2  bgcolor='#000000' >" ;
				content = content +" <tr class='MRow1'>" ;
				content = content +" <td align='center'><b>S.No</b></td>" ;
				content = content +" <td align='center'><b>Employee Id</b></td>" ;
				content = content +" <td align='center'><b>Employee Name</b></td>" ;
				content = content +" <td align='center'><b>Creation</b></td>" ;
				content = content +" <td align='center'><b>Days</b></td>" ;
				content = content +" <td align='center'><b>Time</b></td>" ;
				content = content +" </tr>" ;
				for(int u=0;u<data.length;u++)
				{
					if(u%2==0)
						content = content +" <tr class='MRow1' >" ;
					else
						content = content +" <tr  class='MRow2'  >" ;
					
					content = content +" <td >"+(u+1)+"</td>" ;
					content = content +" <td >"+data[u][0]+"</td>" ;
					content = content +" <td >"+data[u][1]+"</td>" ;
					content = content +" <td >"+data[u][2]+"</td>" ;
					content = content +" <td >"+data[u][3]+"</td>" ;
					content = content +" <td >"+data[u][4]+"</td>" ;
					content = content +" </tr>" ;
				}
				
				content = content +" </table>";	 	
				//settingmailids
				String a[] =(settingmailids+","+CommonData.mailid).split(",") ;
				Mail.SimpleHTMLMail(  a,  "[ NEDD STAFF REGISTRATION SPPROVAL  ]  ", content);
					
			}
			
			
			
			 
	 	}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		 
	}

}

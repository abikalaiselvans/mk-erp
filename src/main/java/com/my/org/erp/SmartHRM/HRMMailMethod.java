package com.my.org.erp.SmartHRM;

import com.my.org.erp.SmartMailtemplates.Mail;
import com.my.org.erp.SmartMailtemplates.StyleSheet;
import com.my.org.erp.SmartMailtemplates.Template2;
import com.my.org.erp.common.CommonFunctions;

public class HRMMailMethod 
{
	public static String sql =""; 
	 
	public static void  sendEmployeeVerificationMail(String verificationempid,String name,String cperson,String address,String email,String mobile,String phone)
	{
    	try
    	{
    		String mailcontent=" ";
    		String verificationname = CommonFunctions.QueryExecute("SELECT FIND_A_EMPLOYEE_NAME('"+verificationempid+"')")[0][0];
    		
    		//stylesheet
			mailcontent = mailcontent + StyleSheet.styleSheet();
			
			//top content
			mailcontent = mailcontent + Template2.topContent("CARE EMPLOYMENT VERIFICATION");
			
			//body content
			String ssql = " SELECT UPPER(a.CHR_NAME),a.CHR_ADDRESS1,a.CHR_ADDRESS2,e.CHR_CITYNAME,d.CHR_STATENAME,a.INT_PINCODE,a.CHR_PHONE, ";  
    		ssql = ssql + " a.CHR_FAX,a.CHR_EMAIL, d1.CHR_DISTRICT  ";
    		ssql = ssql + " FROM m_company a,com_m_country c, com_m_state d, com_m_district d1, com_m_city e ";  
    		ssql = ssql + "  WHERE  a.INT_CITYID = e.INT_CITYID  ";
    		ssql = ssql + "  AND a.INT_COUNTRYID = c.INT_COUNTRYID "; 
    		ssql = ssql + "  AND a.INT_STATEID =d.INT_STATEID AND a.INT_DISTRICTID =d1.INT_DISTRICTID ";  
    		System.out.println(ssql);
    		String cpydata[][]=CommonFunctions.QueryExecute(ssql);
			mailcontent = mailcontent + "<font class='boldEleven'><br>Dear Sir/ Ma'am, ";
			mailcontent = mailcontent + "<br><br>Greetings!! ";
			mailcontent = mailcontent + "<br><br>We are "+name ;
			mailcontent = mailcontent + "<br><br>This request is in regards to an employment verification check on "+verificationname; 
			mailcontent = mailcontent + "<br><br>one of the former employees of \""+cpydata[0][0]+"\" ";
			mailcontent = mailcontent + "<br><br>Therefore, we would request you to kindly verify the details with your comments as applicable.</font>"; 


			
			mailcontent = mailcontent + " <br><br>  <table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1  > ";
			mailcontent = mailcontent + "   <tbody> ";
			mailcontent = mailcontent + "   <tr  bgcolor='#20B2AA'> ";
			mailcontent = mailcontent + "   <td valign='top'  ><b>NAME</td> ";
			mailcontent = mailcontent + "   <td valign='top'  >"+name+"</td> ";
			mailcontent = mailcontent + "   </tr> ";
			
			mailcontent = mailcontent + "   <tr  bgcolor='#B0E0E6'> ";
			mailcontent = mailcontent + "   <td valign='top'  ><b>Candidate   Name</td> ";
			mailcontent = mailcontent + "   <td valign='top'  >"+cperson+"</td> ";
			mailcontent = mailcontent + "   </td> ";
			
			mailcontent = mailcontent + "   <tr  bgcolor='#20B2AA'> ";
			mailcontent = mailcontent + "   <td valign='top'  ><b>Address</td> ";
			mailcontent = mailcontent + "   <td valign='top'  >"+address+"</td> ";
			mailcontent = mailcontent + "   </td> ";
			
			mailcontent = mailcontent + "   <tr  bgcolor='#B0E0E6'> ";
			mailcontent = mailcontent + "   <td valign='top'  ><b>Email</td> ";
			mailcontent = mailcontent + "   <td valign='top'  >"+email+"</td> ";
			mailcontent = mailcontent + "   </td> ";
			
			mailcontent = mailcontent + "   <tr  bgcolor='#20B2AA'> ";
			mailcontent = mailcontent + "   <td valign='top'  ><b>Mobile</td> ";
			mailcontent = mailcontent + "   <td valign='top'  >"+mobile+"</td> ";
			mailcontent = mailcontent + "   </td> ";
			
			mailcontent = mailcontent + "   <tr  bgcolor='#B0E0E6'> ";
			mailcontent = mailcontent + "   <td valign='top'  ><b>Phone</td> ";
			mailcontent = mailcontent + "   <td valign='top'  >"+phone+"</td> ";
			mailcontent = mailcontent + "   </td> ";
			
			mailcontent = mailcontent + "   <tr  bgcolor='#B0E0E6'> ";
			mailcontent = mailcontent + "   <td valign='top'  ><b>Candidate\'s Claim:-</td> ";
			mailcontent = mailcontent + "   <td valign='top'  >"+verificationname+"<br>"+verificationempid+"</td> ";
			mailcontent = mailcontent + "   </td> ";
						
			mailcontent = mailcontent + "   </table> ";
			
			//bottom content
			mailcontent = mailcontent + Template2.bottomContent();
			
			String subject = "Employment Verification of "+verificationname +" [ "+verificationempid+" ]" ;
			String verificationmailid=CommonFunctions.QueryExecute("SELECT CHR_MAILIDS_EMPLOYEE_VERIFICATION from m_hrm_setting WHERE INT_ROWID  =1")[0][0];
			String receipiants[] = (verificationmailid).split(",");
			Mail.sendEmailWithAttachments(receipiants, subject, mailcontent, null);
			
    	}
    	catch(Exception e)
    	{
    		 System.out.println(e.getMessage());
    	}
    	 
    }
	public static void  sendEmployeeVerificationResponseMail(String rowid, String description ,String salary,String Attendance,String Status,String authority,String Path)
    {
    	
    	
		try
    	{ 	
			String mailcontent=" ";
			sql = " SELECT b.CHR_STAFFNAME,b.CHR_EMPID ,b.CHR_STAFFFNAME, ";
			sql = sql + " c.CHR_DESIGNAME,d.CHR_DEPARTNAME,DATE_FORMAT(b.DT_DOJCOLLEGE,'%d%-%b-%Y'),DATE_FORMAT(e.DT_TERM_DATE,'%d%-%b-%Y'),e.CHR_REASON,b.CHR_REPTO,a.CHR_EMAILID ";
			sql = sql + " FROM com_m_employeeverification a,com_m_staff b ,com_m_desig c ,com_m_depart d,pay_m_emp_termination e ";
			sql = sql + " WHERE a.CHR_VERIFICATIONID = b.CHR_EMPID  ";
			sql = sql + " AND b.INT_DESIGID = c.INT_DESIGID ";
			sql = sql + " AND b.INT_DEPARTID = d.INT_DEPARTID ";
			sql = sql + " AND b.CHR_EMPID  = e.CHR_EMPID  ";
			sql = sql + " AND a.INT_VERIFICATIONID="+rowid;
			String readData[][] =CommonFunctions.QueryExecute(sql);
			System.out.println(sql);
			String data[][]=CommonFunctions.QueryExecute(sql);
			
			//stylesheet
			mailcontent = mailcontent + StyleSheet.styleSheet();
			
			
			
			//top content
			mailcontent = mailcontent + Template2.topContent("CARE EMPLOYMENT VERIFICATION");
			
			//Content start
			if(!"-".equals(readData[0][9]))
			{
				
				mailcontent = mailcontent + "   <table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1  > ";
				mailcontent = mailcontent + "   <tbody> ";
				mailcontent = mailcontent + "   <tr  bgcolor='#20B2AA'> ";
				mailcontent = mailcontent + "   <td valign='top'  ><p><strong><b>Fields of Information</strong></p></td> ";
				mailcontent = mailcontent + "   <td valign='top'  ><p><strong>&nbsp;&nbsp;&nbsp; </strong><strong><b>As per HR   records</strong></p></td> ";
				mailcontent = mailcontent + "   </tr> ";
				mailcontent = mailcontent + "   <tr  bgcolor='#B0E0E6'> ";
				mailcontent = mailcontent + "   <td valign='top'  ><p><b>Candidate   Name</p></td> ";
				mailcontent = mailcontent + "   <td valign='top'  ><p>"+readData[0][0];
				mailcontent = mailcontent + "   </p></td> ";
				mailcontent = mailcontent + "   </tr> ";
				mailcontent = mailcontent + "   <tr  bgcolor='#20B2AA'> ";
				mailcontent = mailcontent + "    <td valign='top'  ><p><b>Employee   Code</p></td> ";
				mailcontent = mailcontent + "   <td valign='top'  ><p>"+readData[0][1] ;
				mailcontent = mailcontent + "   </tr> ";
				mailcontent = mailcontent + "   <tr  bgcolor='#B0E0E6'> ";
				mailcontent = mailcontent + "   <td valign='top'  ><p><b>Designation</p></td> ";
				mailcontent = mailcontent + "   <td valign='top'  ><p>"+readData[0][3] ;
				mailcontent = mailcontent + "   </tr> ";
				mailcontent = mailcontent + "   <tr  bgcolor='#20B2AA'> ";
				mailcontent = mailcontent + "   <td valign='top'><b>Department</td> ";
				mailcontent = mailcontent + "    <td valign='top'>"+readData[0][4] ;
				mailcontent = mailcontent + "   </tr> ";
				mailcontent = mailcontent + "   <tr  bgcolor='#B0E0E6'> ";
				mailcontent = mailcontent + "   <td valign='top'  ><p><b>Date of   Joining</p></td> ";
				mailcontent = mailcontent + "   <td valign='top'  ><p>"+readData[0][5]+"</p></td> ";
				mailcontent = mailcontent + "   </tr> ";
				mailcontent = mailcontent + "   <tr  bgcolor='#20B2AA'> ";
				mailcontent = mailcontent + "   <td valign='top'  ><p><b>Date of Leaving </p></td> ";
				mailcontent = mailcontent + "   <td valign='top'  ><p>"+readData[0][6]+"</p></td> ";
				mailcontent = mailcontent + "   </tr> ";
				mailcontent = mailcontent + "   <tr  bgcolor='#B0E0E6'> ";
				mailcontent = mailcontent + "   <td valign='top'  ><p><b>Supervisor&rsquo;s Name and   Designation</p></td> ";
				mailcontent = mailcontent + "   <td valign='top'  ><p>"+ CommonFunctions.QueryExecute("SELECT b.CHR_STAFFNAME,c.CHR_DESIGNAME   FROM com_m_staff b ,com_m_desig c  WHERE b.INT_DESIGID = c.INT_DESIGID AND b.CHR_EMPID  = '"+readData[0][8]+"'")[0][0]+"&nbsp;/&nbsp;"+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT b.CHR_STAFFNAME,c.CHR_DESIGNAME   FROM com_m_staff b ,com_m_desig c  WHERE b.INT_DESIGID = c.INT_DESIGID AND b.CHR_EMPID  = '"+readData[0][8]+"'")[0][1]+"</p></td> ";
				mailcontent = mailcontent + "   </tr> ";
				mailcontent = mailcontent + "   <tr  bgcolor='#20B2AA'> ";
				mailcontent = mailcontent + "   <td valign='top'  ><p><b>Remuneration </p></td> ";
				mailcontent = mailcontent + "   <td valign='top'  ><p> INR "+salary;
				mailcontent = mailcontent + "    </p></td> ";
				mailcontent = mailcontent + "   </tr> ";
				mailcontent = mailcontent + "   <tr  bgcolor='#20B2AA'> ";
				mailcontent = mailcontent + "   <td valign='top'  ><p><b>Reason for Leaving </p></td> ";
				mailcontent = mailcontent + "   <td valign='top'  ><p>"+readData[0][7]+"</p></td> ";
				mailcontent = mailcontent + "   </tr> ";
				mailcontent = mailcontent + "   <tr  bgcolor='#B0E0E6'> ";
				mailcontent = mailcontent + "   <td valign='top'  ><p><b>Attendance</p></td> ";
				mailcontent = mailcontent + "   <td valign='top'  ><p> "+Attendance;
				mailcontent = mailcontent + "   % </p></td> ";
				mailcontent = mailcontent + "   </tr> ";
				mailcontent = mailcontent + "   <tr  bgcolor='#20B2AA'> ";
				mailcontent = mailcontent + "   <td valign='top'  ><p><b>Eligibility to Rehire </p></td> ";
				mailcontent = mailcontent + "   <td valign='top'  >";
				if("Y".equals(Status))
					mailcontent = mailcontent + " Yes ";
				else
					mailcontent = mailcontent + " No ";
				mailcontent = mailcontent + "   </td> ";
				mailcontent = mailcontent + "   </tr> ";
				mailcontent = mailcontent + "   <tr  bgcolor='#B0E0E6'> ";
				mailcontent = mailcontent + "   <td valign='top'  ><p><b>Additional Comments </p></td> ";
				mailcontent = mailcontent + "   <td valign='top'  ><p> "+description.replaceAll("\n", "<br>");
				mailcontent = mailcontent + "   </p></td> ";
				mailcontent = mailcontent + "   </tr> ";
				mailcontent = mailcontent + "   <tr  bgcolor='#20B2AA'> ";
				mailcontent = mailcontent + "    <td valign='top'  ><p><b>Verifier&rsquo;s Name and   Designation</p></td> ";
				mailcontent = mailcontent + "   <td valign='top'  ><p>"+ CommonFunctions.QueryExecute("SELECT b.CHR_STAFFNAME,c.CHR_DESIGNAME   FROM com_m_staff b ,com_m_desig c  WHERE b.INT_DESIGID = c.INT_DESIGID AND b.CHR_EMPID  = '"+authority+"'")[0][0]+"&nbsp;/&nbsp;"+ CommonFunctions.QueryExecute("SELECT b.CHR_STAFFNAME,c.CHR_DESIGNAME   FROM com_m_staff b ,com_m_desig c  WHERE b.INT_DESIGID = c.INT_DESIGID AND b.CHR_EMPID  = '"+authority+"'")[0][1]+"</p></td> ";
				mailcontent = mailcontent + "   </tr> ";
				mailcontent = mailcontent + "    </tbody> ";
				mailcontent = mailcontent + "   </table> ";
				
				//bottom content
				mailcontent = mailcontent + Template2.bottomContent();
				String subject = "CARE EMPLOYMENT VERIFICATION FOR  "+readData[0][0].toUpperCase() ;
				String verificationmailid=CommonFunctions.QueryExecute("SELECT CHR_MAILIDS_EMPLOYEE_VERIFICATION from m_hrm_setting WHERE INT_ROWID  =1")[0][0];
				String receipiants[] = (readData[0][9]+","+verificationmailid).split(",");
				Mail.sendEmailWithAttachments(receipiants, subject, mailcontent, null);
				
				//HRMMailMethod.sendEmployeeVerificationMail(receipiants, subject, mailcontent, Path);
				//Mail.sendtoMail(receipiants, subject, mailcontent);
				
				 
				 
			}
			 
    		
    	}
    	catch(Exception e)
    	{
    		 
    		System.out.println(e.getMessage());
    	}
    	 
    }
}
 

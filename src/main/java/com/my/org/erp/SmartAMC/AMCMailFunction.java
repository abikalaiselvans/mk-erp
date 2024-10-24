package com.my.org.erp.SmartAMC;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.setting.CommonData;
public class AMCMailFunction 
{
	public static String sql="";
	
	
	public static String  serviceCallBookingMail(String Servicecallnumber) 
	 {
		String content="";
		try 
	 	{
			sql = " SELECT a.CHR_SERVICECALLNO, b.CHR_CUSTOMERNAME,e.CHR_SERVICEITEMNAME,a.CHR_SERIALNO,  ";
			sql = sql +" a.CHR_BOOKINGEMPID,f.CHR_STAFFNAME,a.CHR_CONTACTPERSON,  ";
			sql = sql +" a.CHR_CONTACTADDRESS,a.CHR_CONTACTMOBILE,a.CHR_CONTACTEMAIL,a.CHR_SERVICEDESC,c.CHR_CENTERNAME,c.CHR_MAIL   ";
			sql = sql +" FROM  inv_t_servicecallbooking  a, inv_m_servicecustomerinfo b ,inv_m_servicecenter c ,inv_m_serviceamc d,inv_m_serviceitems e,com_m_staff f   ";
			sql = sql +" WHERE a.INT_CUSTOMERID= b.INT_CUSTOMERID  AND b.INT_SERVICECENTERID = c.INT_SERVICECENTERID  ";
			sql = sql +" AND a.CHR_SERIALNO = d.CHR_SERIALNO  ";
			sql = sql +" AND d.INT_SERVICEITEMID = e.INT_SERVICEITEMID   ";
			sql = sql +" AND a.CHR_BOOKINGEMPID = f.CHR_EMPID  ";
			sql = sql +" AND a.CHR_SERVICECALLNO ='"+Servicecallnumber+"'  ";
			String mailData[][] = CommonFunctions.QueryExecute(sql);
			
			if(mailData.length>0)
				if(!"-".equals(mailData[0][12]))
				{
					try 
					{
						content=content+" <style type=\"text/css\"> ";
						content=content+" <!-- ";
						content=content+" .style8 {COLOR: #000000; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;} ";
						content=content+" .style11 {COLOR: #000000; font-weight: normal; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;} ";
						content=content+" .boldEleven {	FONT-WEIGHT: normal;FONT-SIZE: 10px;	COLOR: #000000;	LINE-HEIGHT: 15px;	FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif;	TEXT-DECORATION: none;}";  
						content=content+" .style15 {COLOR: #000000; font-weight: bold; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px; } ";
						content=content+" --> ";
						content=content+" </style> ";
						content=content+" <table width='600'  class='boldEleven'      cellpadding=2 cellspacing=1 bgcolor='#9900CC' > ";  
						content=content+" <tr  bgcolor='#FFFFFF'>	 ";
						content=content+" <td>	 ";

						
						content=content+" <table width='600' border='1' align='center' cellpadding='3' cellspacing='2' class='boldEleven'  bgcolor='#FFFFFF'>	 ";
						content=content+" <tr>	 ";
						content=content+" <td width='132' class='boldEleven'>Call Number </td>	 ";
						content=content+"  <td width='150' class='boldEleven'><h2>" + mailData[0][0] + "</h2> </td>	 ";
						content=content+" </tr>	 ";
						content=content+" <tr>	 ";
						content=content+" <td class='boldEleven'>Customer Name </td>	 ";
						content=content+" <td class='boldEleven'>" + mailData[0][1] + " </td>	 ";
						content=content+" </tr>	 ";
						content=content+" <tr>	 ";
						content=content+" <td class='boldEleven'>Service Item </td>	 ";
						content=content+" <td class='boldEleven'>" + mailData[0][2] + " </td>	 ";
						content=content+"  </tr>	 ";
						content=content+" <tr>	 ";
						content=content+"  <td class='boldEleven'>Serial Number </td>	 ";
						content=content+" <td class='boldEleven'>" + mailData[0][3] + " </td>	 ";
						content=content+"  </tr>	 ";
						content=content+" <tr>	 ";
						content=content+" <td class='boldEleven'>Employee id / Name </td>	 ";
						content=content+" <td class='boldEleven'>" + mailData[0][4]+" / "+ mailData[0][5]+ " </td>	 ";
						content=content+" </tr>	 ";
						content=content+" <tr>	 ";
						content=content+" <td class='boldEleven'>Contact Person </td>	 ";
						content=content+" <td class='boldEleven'>" + mailData[0][6] + " </td>	 ";
						content=content+" </tr>	 ";
						content=content+" <tr>	 ";
						content=content+"  <td class='boldEleven'>Contact Address </td>	 ";
						content=content+" <td class='boldEleven'>" + mailData[0][7] + " </td>	 ";
						content=content+" </tr>	 ";
						content=content+" <tr>	 ";
						content=content+" <td class='boldEleven'>Contact Mobile </td>	 ";
						content=content+" <td class='boldEleven'>" + mailData[0][8] + " </td>	 ";
						content=content+" </tr>	 ";
						content=content+" <tr>	 ";
						content=content+" <td class='boldEleven'>Contact Email </td>	 ";
						content=content+" <td class='boldEleven'>" + mailData[0][9] + " </td>	 ";
						content=content+" </tr>	 ";
						content=content+" <tr>	 ";
						content=content+" <td class='boldEleven'>Problem Description </td>	 ";
						content=content+" <td class='boldEleven'>" + mailData[0][10] + " </td>	 ";
						content=content+" </tr>	 ";
						content=content+" <tr>	 ";
						content=content+" <td class='boldEleven'>Service Center </td>	 ";
						content=content+" <td class='boldEleven'>" + mailData[0][11] + " </td>	 ";
						content=content+" </tr>	 ";
						content=content+" </table>	 ";
						
						content=content+" </td>	 ";
						content=content+" </tr>	 ";
						content=content+" </table>	 ";	 
						 
						String a[] =(mailData[0][12]+","+CommonData.mailid).split(",") ;
						com.my.org.erp.mail.Mail.SimpleHTMLMail(  a,  "SERVICE CALL  ::"+ mailData[0][0], content);
						
						 
					} 
					catch (RuntimeException e) 
					{
						 System.out.println(e.getMessage());
					}
					
				}
			return content;
	 	}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return content;
	}
	
	
	
	
}

package com.my.org.erp.SmartPayroll;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class PDF_PayslipMethod 
{
	
	public static void sendEmailWithAttachments( String toAddress,String subject , String message, String[] attachFiles)throws AddressException, MessagingException, IOException
	{  
	
		try 
		{
			
    		String hData[][] =  CommonFunctions.QueryExecute("SELECT CHR_HOST,CHR_USERID,CHR_PASSWORD,CHR_MAILID FROM  m_mailsetting WHERE INT_MAILID = 1");
		    String host =hData[0][0]   ;
            String user =hData[0][1]   ;
            String password =hData[0][2]   ;
            String from =hData[0][3]   ;
             
            final String fpassword =hData[0][2]   ;
            final String ffrom =hData[0][3]   ;
         
            
            Properties properties = new Properties();  
            properties.put("mail.smtp.host", host);  
            properties.put("mail.smtp.auth", "true");  
            properties.put("mail.smtp.starttls.enable", "true");  
            properties.put("mail.user", user);  
            properties.put("mail.password", password);  
            
  	        
            System.out.println();
            System.out.println(from);
            System.out.println();
        
            
            
            Session session = Session.getDefaultInstance(properties,
             new javax.mail.Authenticator() {
               protected PasswordAuthentication getPasswordAuthentication() {
         	return new PasswordAuthentication(ffrom,fpassword);
               }
             });
            
            
  	        
  	         
  	        Message msg = new MimeMessage(session);
  	        InternetAddress addressFrom = new InternetAddress(from);
  	        msg.setFrom(addressFrom);
  	        
  	        
			msg.setFrom(new InternetAddress(from));  
			InternetAddress[] toAddresses = {new InternetAddress(toAddress)};  
			msg.setRecipients(Message.RecipientType.BCC, toAddresses);  
			msg.setSubject(subject);  
			msg.setSentDate(new Date());  
     
			 
			// creates message part  
			MimeBodyPart messageBodyPart = new MimeBodyPart();  
			messageBodyPart.setContent(message, "text/html");  
			// creates multi-part  
			Multipart multipart = new MimeMultipart();  
			multipart.addBodyPart(messageBodyPart);       
     
			// adds attachments  
			if (attachFiles != null && attachFiles.length > 0) {  
			    for (String filePath : attachFiles) {  
			        MimeBodyPart attachPart = new MimeBodyPart();  
			        DataSource source = new FileDataSource(filePath);  
			        attachPart.setDataHandler(new DataHandler(source));  
			        attachPart.setFileName(new File(filePath).getName());  
     
			        multipart.addBodyPart(attachPart);  
			    }  
			}  
     
			// sets the multi-part as e-mail's content  
			msg.setContent(multipart);  
     
			// sends the e-mail  
			Transport.send(msg);
			
			
			System.out.println("main has been sent");
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
		}  
      
    }  
	
	
	public static void SendtoMail( String recipients[] ,String subject,String content)
    {
    	try
    	{
    		boolean debug = false;
    		String hData[][] =  CommonFunctions.QueryExecute("SELECT CHR_HOST,CHR_USERID,CHR_PASSWORD,CHR_MAILID FROM  m_mailsetting WHERE INT_MAILID = 1");
		    String host =hData[0][0]   ;
            String user =hData[0][1]   ;
            String password =hData[0][2]   ;
            String from =hData[0][3]   ;
            
            System.out.println();
            System.out.println();
            System.out.println(from);
            System.out.println();System.out.println();
            Properties props = new Properties();
  	        props.setProperty("mail.transport.protocol", "smtp");
  	        props.setProperty("mail.host", ""+host);
	        props.setProperty("mail.user", ""+user);
	        props.setProperty("mail.password", ""+password);
	        
  	        Session session = Session.getDefaultInstance(props, null);
  	        session.setDebug(debug); 
  	        Message msg = new MimeMessage(session);
  	        InternetAddress addressFrom = new InternetAddress(from);
  	        msg.setFrom(addressFrom);
  	        
            InternetAddress[] addressTo = new InternetAddress[recipients.length]; 
  	        for (int i = 0; i < recipients.length; i++)
  	    	   addressTo[i] = new InternetAddress(recipients[i]);
  	        msg.setRecipients(Message.RecipientType.BCC, addressTo);
  	        msg.addHeader("MyHeaderName", "myHeaderValue");
  	        msg.setSubject(subject);
  	        msg.setContent(content, "text/html");
  	        Transport.send(msg);
  	       

    	}
    	catch(Exception e)
    	{
    		 System.out.println(e.getMessage()); 
    	}
    }
	
	
	public static String  payrollContent(String staffid,String mth,String Year )
    {
    	String s ="";
		try
    	{
			String mont = DateUtil.getMonth(Integer.parseInt(mth));			
			s = s+ "<center> <table width='600' border='0' cellpadding='3' cellspacing='5' bordercolor='#0099CC' bgcolor='#0099CC'> ";
			s = s+ " <tr> ";
			s = s+ "  <td><div align='center'><h1><font color='#FFFF00'><b><center>Payslip for the month "+mont+"[ "+Year+" ] </b></font></div></td> ";
			s = s+ " </tr> ";
			s = s+ " <tr> ";
			s = s+ " <tr> ";
			s = s+ "  <td bgcolor='#ffffff'> ";
			
			String staffname="";
			String cpyname="";
			String office="";
			String bank="";
			String sql="";
			String addedallowance="";
			String extraallowance="";
			String addedallowancetitle="";
			String extraallowancetitle="";
			String addedsum="";
			String extrasum="";
			 
			double pf=0;
			double esi =0;
			double advance=0;
			double wrkdays=0;
			double ramount=0;
			double deduction=0;
			double originalbasic=0;
			double originalgross=0;
			double earninggross=0;
			double originalextraallowance=0;
			double extraallowances=0;
			double taxvalue=0;
			sql = " SELECT b.CHR_STAFFNAME,c.CHR_COMPANYNAME,d.CHR_DESIGNAME,e.CHR_OFFICENAME,FIND_A_BANKGROUP_NAME(b.CHR_BANK),a.CHR_ACCNO,    ";
			sql = sql + " b.CHR_PFNO, b.CHR_ESINO ,b.INT_SALARY,c.CHR_PFNUMBER ,concat(c.CHR_PFNUMBER,b.CHR_PFNO)    ";
			sql = sql + " FROM  pay_t_salary  a ,com_m_staff b,com_m_company c,com_m_desig d,com_m_office e    ";
			sql = sql + " WHERE a.CHR_EMPID = b.CHR_EMPID    ";
			sql = sql + " AND a.INT_COMPANYID = c.INT_COMPANYID    ";
			sql = sql + " AND a.INT_DESIGID = d.INT_DESIGID    ";
			sql = sql + " AND a.INT_OFFICEID = e.INT_OFFICEID    ";
		 
			sql = sql + " AND	a.CHR_EMPID='"+staffid+"'    ";
			sql = sql+" AND  a.INT_YEAR ="+Year;
			sql = sql+" AND a.CHR_MONTH='"+mont+"'";
			//out.println(sql);
			String basicdata[][]=CommonFunctions.QueryExecute(sql);
			
			sql = " SELECT INT_SALARY FROM pay_t_salarybasic";
			sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
			sql = sql+" AND  INT_YEAR ="+Year;
			sql = sql+" AND CHR_MONTH='"+mont+"'";
			String basics[][]=CommonFunctions.QueryExecute(sql);

			sql=" SELECT DOU_BASIC,DOU_ATOTAL1,DOU_GROSSPAY,(DOU_BASIC+DOU_ATOTAL1),DOU_ATOTAL2 FROM pay_t_salary  ";
			sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
			sql = sql+" AND  INT_YEAR ="+Year;
			sql = sql+" AND CHR_MONTH='"+mont+"'";
			String earning[][]=CommonFunctions.QueryExecute(sql);
				
			if(basicdata.length>0)
			{
				staffname=basicdata[0][0];
				cpyname=basicdata[0][1];
				office=basicdata[0][3];
				bank=basicdata[0][4] +" - " +basicdata[0][5];
				originalbasic = Double.parseDouble(basics[0][0]);
				earninggross  = Double.parseDouble(earning[0][2]);
				extraallowances=Double.parseDouble(earning[0][4]);
				ramount=0;
				deduction=0;
				originalgross=0;
				originalextraallowance=0;
				 
				
				sql = "SELECT CHR_ACODE,CHR_ANAME,CHR_FLAG FROM pay_m_allowance  ORDER BY INT_ALLOWANCEID";
				String aname[][] = CommonFunctions.QueryExecute(sql);
				for(int a=0;a<aname.length;a++)
					if("Y".equals(aname[a][2]))
					{
						addedallowance =addedallowance+aname[a][0]+",";
						addedallowancetitle=addedallowancetitle+aname[a][1]+",";
						addedsum = addedsum+aname[a][0]+"+";
					}
					else
					{
						extraallowance =extraallowance+aname[a][0]+",";
						extraallowancetitle=extraallowancetitle+aname[a][1]+",";
						extrasum = extrasum+aname[a][0]+"+";
					}
					
					addedallowance = addedallowance.trim();
					addedallowance = addedallowance.substring(0,addedallowance.length()-1);
					addedallowancetitle = addedallowancetitle.trim();
					addedallowancetitle = addedallowancetitle.substring(0,addedallowancetitle.length()-1);
					addedsum = addedsum.trim();
					addedsum = addedsum.substring(0,addedsum.length()-1);
					
					extraallowance = extraallowance.trim();
					extraallowance = extraallowance.substring(0,extraallowance.length()-1);
					extraallowancetitle = extraallowancetitle.trim();
					extraallowancetitle = extraallowancetitle.substring(0,extraallowancetitle.length()-1);
					extrasum = extrasum.trim();
					extrasum = extrasum.substring(0,extrasum.length()-1);
					
					 
					
				sql="SELECT ROUND(DOU_BASIC),ROUND(DOU_PF),ROUND(DOU_ESI),ROUND(DOU_ADVANCE),DOU_WORKDAYS,DOU_PAYTAX FROM pay_t_salary  ";
				sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
				sql = sql+" AND  INT_YEAR ="+Year;
				sql = sql+" AND CHR_MONTH='"+mont+"'";
				String salarydata[][] = CommonFunctions.QueryExecute(sql);
				if(salarydata.length>0)
				{
				 	 
					pf=Double.parseDouble(salarydata[0][1]);
					esi=Double.parseDouble(salarydata[0][2]);
					advance=Double.parseDouble(salarydata[0][3]);
					wrkdays=Double.parseDouble(salarydata[0][4]);
					taxvalue=Double.parseDouble(salarydata[0][5]);
   
					s= s+" <table width='900'  border=1 align='center'  cellpadding=3 cellspacing=1  bordercolor='#999999' background='payslip.jpg'>";
					s= s+" <tr>";
					s= s+" <td><table width='100%' border'0' cellspacing'0' cellpadding='0'>";
					s= s+" <tr>";
					s= s+" <td width='15%' rowspan='4' valign='top' ><img src='log.gif' width='159' height='49'></td>";
					s= s+" <td width='70%' ><div align='center'>"+cpyname+"</div></td>";
					s= s+" <td width='15%' rowspan='4' valign='top' ></td>";
					s= s+" </tr>";
					s= s+" <tr>";
					s= s+" <td  ><div align='center'>PAY SLIP FOR ( "+mont +" - " +Year+" )</div></td>";
					s= s+" </tr>";
					s= s+" <tr>";
					s= s+" <td  ><div align='center'></div></td>";
					s= s+" </tr>";
					s= s+" <tr>";
					s= s+" <td  ><div align='center'>"+staffname+"</div></td>";
					s= s+" </tr>";
					s= s+" <tr>";
					s= s+" <td colspan='3' ><hr width='100%' size=1>";
					s= s+" </td>";
					s= s+" </tr>";
					s= s+" <tr>";
					s= s+" <td colspan='3'  ><table width='100%' border='0' cellspacing='0' cellpadding='0'>";
					s= s+" <tr>";
					s= s+" <td  ><strong>Employee Number</strong></td>";
					s= s+" <td  >"+staffid+"</td>";
					s= s+" <td  >&nbsp;</td>";
					s= s+" <td  ><strong>PF Number</strong></td>";
					s= s+" <td  >"+basicdata[0][9]+basicdata[0][6]+"</td>";
					s= s+" </tr>";
					s= s+" <tr>";
					s= s+" <td width='21%'  ><strong>Designation</strong></td>";
					s= s+" <td width='27%''  ><%=desig%></td>";
					s= s+" <td width='3%'  >&nbsp;</td>";
					s= s+" <td width='14%'  ><strong>ESI";
					s= s+" Number </str'ng></td>";
					s= s+" <td width='35%'  >"+basicdata[0][7]+"</td>";
					s= s+" </tr>";
				                
					s= s+" <tr>";
					s= s+" <td  ><strong>Location</strong></td>";
					s= s+"  <td  >"+office+"</td>";
					s= s+" <td  >&nbsp;</td>";
					s= s+" <td  ><strong>Bank Name </strong></td>";
					s= s+" <td  >"+bank.split("-")[0]+"</td>";
					s= s+" </tr>";
					s= s+" <tr>";
					s= s+" <td  ><strong>No. of working days </strong></td>";
					s= s+" <td  >"+wrkdays+"</td>";
					s= s+" <td  >&nbsp;</td>";
					s= s+" <td  ><strong>Account  No </strong></td>";
					s= s+" <td  >"+bank.split("-")[1]+"</td>";
					s= s+"  </tr>" ;
							 
					s= s+" <tr>";
					s= s+" <td colspan='2' valign='top'  >";
					 
					s= s+"  <table cellpadding=0 cellspacing=0 width='90%' border=0>" ;
					 
					sql = "Select "+addedallowance+" FROM pay_t_salaryallowance  ";
					sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
					sql = sql+" AND  INT_YEAR ="+Year;
					sql = sql+" AND CHR_MONTH='"+mont+"'";
					String data1[][] = CommonFunctions.QueryExecute(sql);
					int columncount1 = CommonFunctions.intGetColumnCount(sql);
					addedallowancetitle=addedallowancetitle+"";
					String titledata1[] = addedallowancetitle.split(",");
					s= s+" <tr><td class='boldEleven'>Basic" ;
					s= s+" <td  class='boldEleven' align='right'>"+(int)originalbasic ;
					s= s+" <tr><td class='boldEleven' colspan=2><b>Allowance" ;
									
					if(columncount1>1)
					{
						for(int x=0;x<columncount1;x++)
						{
							if((Integer.parseInt(data1[0][x]))>0)
							{
								originalgross = originalgross+Integer.parseInt(data1[0][x]);
								s= s+" <tr><td class='boldEleven'> "+titledata1[x] ;
								s= s+" <td  class='boldEleven' align='right'>"+data1[0][x] ;
							}	
						}	
						
					}
					originalgross = originalgross+originalbasic;
					s= s+" <tr><td class='boldEleven'><b> Gross Pay" ;
					s= s+" <td  class='boldEleven' align='right'>"+((int)originalgross) ;
					
					
									
					sql = "Select "+extraallowance+" FROM pay_t_salaryallowance  ";
					sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
					sql = sql+" AND  INT_YEAR ="+Year;
					sql = sql+" AND CHR_MONTH='"+mont+"'";
					
					String data2[][] = CommonFunctions.QueryExecute(sql);
					columncount1 = CommonFunctions.intGetColumnCount(sql);
					extraallowancetitle=extraallowancetitle+"";
					String titledata2[] = extraallowancetitle.split(",");
				 
					if(columncount1>1)
					{
						for(int x=0;x<columncount1;x++)
							if((Integer.parseInt(data2[0][x]))>0)
								originalextraallowance = originalextraallowance+Integer.parseInt(data2[0][x]);
						if(originalextraallowance>0)
						{
							s= s+" <tr><td class='boldEleven' colspan=2><b> Extra Allowance" ;
							for(int x=0;x<columncount1;x++)
							{
								if((Integer.parseInt(data2[0][x]))>0)
								{
									s= s+" <tr><td class='boldEleven'> "+titledata2[x] ;
									s= s+" <td  class='boldEleven' align='right'>"+data2[0][x] ;
								}	
							}	
							 
						}
					}
									
									
					s= s+" <tr><td class='boldEleven'><b>Total" ;
					s= s+" <td  class='boldEleven' align='right'>"+(int)(originalgross+originalextraallowance) ;
					s= s+" </table>" ;
					s= s+" </td>";
					
					
					
					s= s+" <td  >&nbsp;</td> ";
					s= s+" <td colspan='2' valign='top'  >";
				    sql = " SELECT CHR_RCODE,CHR_RNAME FROM pay_m_recovery ";
					String rname[][] = CommonFunctions.QueryExecute(sql);
					String rallowansql="";
					for(int a=0;a<rname.length;a++)
						rallowansql =rallowansql+rname[a][0]+" , ";
						
					rallowansql=rallowansql.trim();	
					rallowansql = rallowansql.substring(0,rallowansql.length()-1);
					sql= " SELECT "+rallowansql+" FROM pay_t_salary  ";
					sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
					sql = sql+" AND  INT_YEAR ="+Year;
					sql = sql+" AND CHR_MONTH='"+mont+"'";
					String recoverydata[][] = CommonFunctions.QueryExecute(sql);
					s= s+" <table cellpadding=0 cellspacing=0 width='90%' border=0>" ;
					s= s+" <tr><td class='boldEleven'><b> Deductions" ;
					s= s+" <td  class='boldEleven' align='right'><b> Amount" ;
					if(rname.length>1)
					{
						for(int u=0;u<rname.length;u++)
						{
						
						 ramount=0.0;
						 ramount=Double.parseDouble(recoverydata[0][u]);	
						 if(ramount>0)
						 {
							 s= s+" <tr><td class='boldEleven'>"+rname[u][1] ;
							 s= s+" <td  class='boldEleven' align='right'>"+Integer.parseInt(recoverydata[0][u]) ;
							deduction=deduction+ramount;
						 }	
						}
					}	
					if(advance>0)
					{
						s= s+" <tr><td class='boldEleven'>Advance" ;
						s= s+" <td  class='boldEleven' align='right'>"+(int)advance ;
					}
					deduction=deduction+advance;
					s= s+" <tr><td class='boldEleven'>PF" ;
					s= s+" <td  class='boldEleven' align='right'>"+(int)pf ;
					deduction=deduction+pf;
					s= s+" <tr><td class='boldEleven'>ESI" ;
					s= s+" <td  class='boldEleven' align='right'>"+(int)esi ;
					deduction=deduction+esi;
					
					s= s+" <tr><td class='boldEleven'>Tax Deduction" ;
					s= s+" <td  class='boldEleven' align='right'>"+(int)taxvalue ;
					deduction=deduction+taxvalue;
					s= s+" <tr><td class='bolddeeplogin'>Loss of pay "  ;
					s= s+" <td  class='boldEleven' align='right'>"+(int)(originalgross-earninggross) ;
					
					s= s+" <tr><td class='bolddeeplogin'>Total deductions " ;
					s= s+" <td  class='boldEleven' align='right'>"+(int)(deduction+(originalgross-earninggross)) ;
												
					s= s+" </table>" ;
				  				 
					
					
					s= s+" </td>";
					s= s+" </tr>";
					s= s+" <tr>";
					s= s+" <td  ></td>";
					s= s+" <td  ><div align='right'><span >Net Amount </span></div></td>";
					s= s+" <td  >&nbsp;</td>";
					s= s+" <td  >"+(int)((earninggross-deduction)+extraallowances)+" </td>";
					s= s+" <td  >&nbsp;</td>";
					s= s+" </tr>";
					s= s+" </table></td>";
					s= s+"  </tr>";
					s= s+"  <tr>";
					s= s+" <td colspan='3' ><table width='100%' border='0' cellspacing='0' cellpadding='0'>";
					s= s+" <tr>";
					s= s+" <td valign='top' class='bolddeeplogin'><hr width='100%' size=1>";
					s= s+" </td>";
					s= s+" </tr>";
					s= s+" <tr>";
					
				 
					   
					s= s+" <td ><div id='Rupees' align='center'>"+"Amount in words ::"+ CommonFunctions.numberWord(""+(int)((earninggross-deduction)+extraallowances))+"</div></td>";
					s= s+" </tr>";
					s= s+" <tr>";
					s= s+" <td  ><hr width='100%' size=1>";
					s= s+" </td>";
					s= s+" </tr>";
					s= s+" <tr>";
					s= s+" <td ><div align='center' class='bolddeepblue'  >";
					s= s+" <div align='center'>H.O. : #481, 2nd Floor, Anna Salai, Nandanan, Chennai-600035. Tel.: 24340906(4 LINES)FAX:24340835</div> ";
					s= s+" </div></td>";
					s= s+" </tr>";
					s= s+" <tr>";
					s= s+" <td  ><div align='center'><strong> * Payslip generated by salary package, does not require any signature. </strong></div></td>";
					s= s+" </tr>";
					s= s+" </table></td>";
					s= s+" </tr>";
					s= s+" </table>";
					s= s+" </td>";
					s= s+" </tr>";
					s= s+" </table>";
					s= s+" <p align='center'>";
					s= s+" <br>";
				 }
				 else
				 {
					 s= s+" Data not found...";
				 }
			}
				 	
					
			s = s+ " </td> ";
			s = s+ " </tr> ";
			s = s+ " <tr> ";
			s = s+ " </table></center> ";
			 
			return s;

    	}
    	catch(Exception e)
    	{
    		 System.out.println(e.getMessage()); 
    	}
		return s;
    }
}

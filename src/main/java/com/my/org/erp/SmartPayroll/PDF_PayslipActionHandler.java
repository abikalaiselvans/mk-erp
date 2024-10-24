package com.my.org.erp.SmartPayroll;

 
import java.awt.Color;
import java.io.IOException;
 
import java.util.Date;
import java.util.Properties;

import java.io.FileOutputStream;
 
 

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.FontSelector;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.my.org.erp.SmartMail.Mail;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 
 
  
import com.my.org.erp.ServiceLogin.*;
import com.my.org.erp.common.*;
import com.my.org.erp.setting.CommonData;
public class PDF_PayslipActionHandler extends AbstractActionHandler 
{
	 
	 

	HttpSession session =  null;
	
	public void handle(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			
			
			if ("PAYMonthlyPayslip_sent_to_mail".equals(action )) 
			{
				String ename[] = request.getParameterValues("ename");
				String Month= request.getParameter("Month");
				String Year= request.getParameter("Year");
				String format= request.getParameter("format");
				String demail= request.getParameter("demailid");
				String mont = DateUtil.getMonth(Integer.parseInt(Month));
				String subject="Payslip for the month "+mont+"[ "+Year+" ]";
				String recipients[];
				if( "PDF".equals(format))
				{
					for(int u=0;u<ename.length;u++)
					{
						
						PAYMonthlyPayslipDownload(ename[u],request , response);
						String to=CommonFunctions.QueryExecute("SELECT CHR_PERMAILID FROM com_m_staff WHERE CHR_EMPID='"+ename[u]+"'")[0][0];
						to =to+","+demail;
						to= demail+",";
						recipients = to.split(",");

						String bodyText="This is a important message with Payslip attachment";
						String filename=Path+"uploadfiles/Payslip_pdf/"+ename[u]+"_"+mont+"_"+Year+".pdf";
						
						String[] attachments = new String [1];
						attachments[0] =  filename;
						Mail.sendEmailWithAttachments(recipients, subject, bodyText, attachments);
						
						if(!"-".equals(to) || !"".equals(to) || "null".equals(to))
							sendEmail(to,subject,bodyText,filename ) ;
					}
				}
				else
				{
					for(int u=0;u<ename.length;u++)
					{
						String to=CommonFunctions.QueryExecute("SELECT CHR_PERMAILID FROM com_m_staff WHERE CHR_EMPID='"+ename[u]+"'")[0][0];
						to =to+","+demail;
						to= demail+",";
						recipients = to.split(",");
						
						String message = PDF_PayslipMethod.payrollContent(ename[u], Month, Year); 
						String[] attachments = new String [2];
						attachments[0] = Path + "images/logo.jpg";
						attachments[1] = Path + "images/payslip.jpg";
						Mail.sendEmailWithAttachments(recipients, subject, message, attachments);
							
						 
					}
					
				}
					
				con.close();   
				response.sendRedirect("Smart Payroll/Payslip_send_to_mail.jsp");
				
				 
		 	}
			else if ( "PAYMonthlyPayslip".equals(action )      ) 
			{
				PAYMonthlyPayslip(request , response);
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

	
	
	public void sendEmail(String to,String subject,String bodyText,String filename ) 
	{
		String from =  CommonData.mailid;
		 
		Properties props = new Properties();
		props.setProperty("mail.transport.protocol", "smtp");
		props.setProperty("mail.host", "192.168.0.5");
		props.setProperty("mail.user", "connect");
		props.setProperty("mail.password", "connect");
		Session session = Session.getDefaultInstance(props, null);
 
		try 
		{
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(from));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
			message.setSubject(subject);
			message.setSentDate(new Date());
			// Set the email message text.
			MimeBodyPart messagePart = new MimeBodyPart();
			messagePart.setText(bodyText);
			// Set the email attachment file
			MimeBodyPart attachmentPart = new MimeBodyPart();
			FileDataSource fileDataSource = new FileDataSource(filename) 
			{
				@Override
				public String getContentType() {
				return "application/octet-stream";
			}
		};

		attachmentPart.setDataHandler(new DataHandler(fileDataSource));
		attachmentPart.setFileName(filename);
		Multipart multipart = new MimeMultipart();
		multipart.addBodyPart(messagePart);
		multipart.addBodyPart(attachmentPart);
		 
		message.setContent(multipart);
		Transport.send(message);
		
		} 
		catch (MessagingException e) 
		{
			 System.out.println(e.getMessage());
		}
}
	

	@SuppressWarnings("deprecation")
	private void PAYMonthlyPayslip(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		try
		{         
			
			
			String sql="";
	   		String staffid = "" + request.getParameter("ename");
			String mth = "" + request.getParameter("Month");
			String mont = DateUtil.getMonth(Integer.parseInt(mth));
			String Year = "" + request.getParameter("Year");
			 
			 
			
			String staffname="";
			String cpyname="";
			String desig="";
			String office="";
			String bank="";
			
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
			 
			String basicdata[][]= CommonFunctions.QueryExecute(sql);
			
			sql = " SELECT INT_SALARY FROM pay_t_salarybasic";
			sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
			sql = sql+" AND  INT_YEAR ="+Year;
			sql = sql+" AND CHR_MONTH='"+mont+"'";
			String basics[][]= CommonFunctions.QueryExecute(sql);

			sql=" SELECT DOU_BASIC,DOU_ATOTAL1,DOU_GROSSPAY,(DOU_BASIC+DOU_ATOTAL1),DOU_ATOTAL2 FROM pay_t_salary  ";
		 	sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
			sql = sql+" AND  INT_YEAR ="+Year;
			sql = sql+" AND CHR_MONTH='"+mont+"'";
			String earning[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			
			
			Document document = new Document(); 
			document.addAuthor("CARE");
			document.addCreationDate();
			document.addCreator("SmartCampus");
			document.addTitle("PAYSLIP");
			
			response.setContentType("application/pdf");
			PdfWriter.getInstance(document, response.getOutputStream());
			document.open();
			
			Image image = Image.getInstance (request.getRealPath("/")+"images/logo.jpg");
			image.setAlignment(1);
			document.add(image );
		        
			    
			FontSelector fontselector = new FontSelector();
            fontselector.addFont(new Font(Font.TIMES_ROMAN, 10));
            fontselector.addFont(new Font(Font.ZAPFDINGBATS, 10));
            fontselector.addFont(new Font(Font.SYMBOL, 10));
			
            
            
           
            
			if(basicdata.length>0)
			{
				staffname=basicdata[0][0];
				cpyname=basicdata[0][1];
				desig=basicdata[0][2];
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
				String aname[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
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
				String salarydata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(salarydata.length>0)
				{
				 	 
					pf=Double.parseDouble(salarydata[0][1]);
					esi=Double.parseDouble(salarydata[0][2]);
					advance=Double.parseDouble(salarydata[0][3]);
					wrkdays=Double.parseDouble(salarydata[0][4]);
					taxvalue=Double.parseDouble(salarydata[0][5]);
			
				
					
				 
		            String content = "";
		            
				 
					PdfPTable table=new PdfPTable(2);
					PdfPCell cell = new PdfPCell (new Paragraph (content));
					 
					fontselector = new FontSelector();
		            fontselector.addFont(new Font(Font.TIMES_ROMAN, 14));
		            fontselector.addFont(new Font(Font.ZAPFDINGBATS, 14));
		            fontselector.addFont(new Font(Font.SYMBOL, 14));
		            
		            
					cell = new PdfPCell ( new Paragraph (fontselector.process(cpyname ) ));
					cell.setColspan (2);
					cell.setHorizontalAlignment (Element.ALIGN_CENTER);
					cell.setBackgroundColor (new Color (128, 200, 128));
					table.addCell (cell);
					
					fontselector = new FontSelector();
		            fontselector.addFont(new Font(Font.TIMES_ROMAN, 7));
		            fontselector.addFont(new Font(Font.ZAPFDINGBATS, 7));
		            fontselector.addFont(new Font(Font.SYMBOL, 7));
		           
					cell = new PdfPCell ( new Paragraph (fontselector.process("PAY SLIP FOR [ "+mont +" - " +Year+" ] \n " +staffname+"\n" ) ));
					cell.setColspan (2);
					cell.setHorizontalAlignment (Element.ALIGN_CENTER);
					cell.setBackgroundColor (new Color (128, 200, 128));
					table.addCell (cell);
					
				 
					
					PdfPTable table1=new PdfPTable(2);
					table1.addCell(new PdfPCell(new Paragraph(fontselector.process("Employee Number") )  ));
					table1.addCell(new PdfPCell(new Paragraph(fontselector.process(staffid) )  ));
					table1.addCell(new PdfPCell(new Paragraph(fontselector.process("Designation") )  ));
					table1.addCell(new PdfPCell(new Paragraph(fontselector.process(desig) )  ));
					table1.addCell(new PdfPCell(new Paragraph(fontselector.process("Location") )  ));
					table1.addCell(new PdfPCell(new Paragraph(fontselector.process(office) )  ));
					table1.addCell(new PdfPCell(new Paragraph(fontselector.process("No. of working days") )  ));
					table1.addCell(new PdfPCell(new Paragraph(fontselector.process(""+wrkdays) )  ));
					 


					
					PdfPTable table2=new PdfPTable(2);
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process("PF Number") )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process( basicdata[0][9]+basicdata[0][6] ) )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process("ESI Number") )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process(basicdata[0][7]) )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process("Bank Name ") )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process(bank.split("-")[0]) )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process("Account No ") )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process(bank.split("-")[1]) )  )); 
					table.addCell (table1);
					table.addCell (table2);
					
					
					PdfPTable table4=new PdfPTable(2);
					sql = "Select "+addedallowance+" FROM pay_t_salaryallowance  ";
					sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
					sql = sql+" AND  INT_YEAR ="+Year;
					sql = sql+" AND CHR_MONTH='"+mont+"'";
					String data1[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					int columncount1 = com.my.org.erp.common.CommonFunctions.intGetColumnCount(sql);
					addedallowancetitle=addedallowancetitle+"";
					String titledata1[] = addedallowancetitle.split(",");
					
					table4.addCell(new PdfPCell(new Paragraph(fontselector.process("Basic") )  ));
					cell = new PdfPCell ( new Paragraph (fontselector.process(""+(int)originalbasic ) ));
					cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
					table4.addCell(cell);
					 
					
					cell = new PdfPCell ( new Paragraph (fontselector.process("ALLOWANCE" ) ));
					cell.setColspan (2);
					cell.setHorizontalAlignment (Element.ALIGN_CENTER);
					table4.addCell(cell);
					 

					if(columncount1>1)
					{
						for(int x=0;x<columncount1;x++)
						{
							if((Integer.parseInt(data1[0][x]))>0)
							{
								originalgross = originalgross+Integer.parseInt(data1[0][x]);
								table4.addCell(new PdfPCell(new Paragraph(fontselector.process(titledata1[x]) )  ));
								cell = new PdfPCell ( new Paragraph (fontselector.process(""+data1[0][x] ) ));
								cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
								table4.addCell(cell);
								 
								 
							}	
						}	
						
					}
					
					originalgross = originalgross+originalbasic;
					table4.addCell(new PdfPCell(new Paragraph(fontselector.process("Gross Pay") )  ));
					cell = new PdfPCell ( new Paragraph (fontselector.process(""+(int)originalgross ) ));
					cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
					table4.addCell(cell);
					 
					 
					sql = "Select "+extraallowance+" FROM pay_t_salaryallowance  ";
					sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
					sql = sql+" AND  INT_YEAR ="+Year;
					sql = sql+" AND CHR_MONTH='"+mont+"'";
					
					String data2[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					columncount1 = com.my.org.erp.common.CommonFunctions.intGetColumnCount(sql);
					extraallowancetitle=extraallowancetitle+"";
					String titledata2[] = extraallowancetitle.split(",");
				 
					if(columncount1>1)
					{
						for(int x=0;x<columncount1;x++)
							if((Integer.parseInt(data2[0][x]))>0)
								originalextraallowance = originalextraallowance+Integer.parseInt(data2[0][x]);
						if(originalextraallowance>0)
						{
							
							cell = new PdfPCell ( new Paragraph (fontselector.process("Extra Allowance" ) ));
							cell.setColspan (2);
							cell.setHorizontalAlignment (Element.ALIGN_CENTER);
							table4.addCell(cell);
							 
							 
							for(int x=0;x<columncount1;x++)
							{
								if((Integer.parseInt(data2[0][x]))>0)
								{
									table4.addCell(new PdfPCell(new Paragraph(fontselector.process(titledata2[x]) )  ));
									cell = new PdfPCell ( new Paragraph (fontselector.process(""+data2[0][x] ) ));
									cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
									table4.addCell(cell);
									
									 
									 
								}	
							}	
							 
						}
					}
					
					
					table4.addCell(new PdfPCell(new Paragraph(fontselector.process("Total") )  ));
					cell = new PdfPCell ( new Paragraph (fontselector.process(""+(int)(originalgross+originalextraallowance) ) ));
					cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
					table4.addCell(cell);
					 
					 
					
					
					
					
					PdfPTable table5=new PdfPTable(2);

				  	sql = " SELECT CHR_RCODE,CHR_RNAME FROM pay_m_recovery ";
					String rname[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					String rallowansql="";
					for(int a=0;a<rname.length;a++)
						rallowansql =rallowansql+rname[a][0]+" , ";
						
					rallowansql=rallowansql.trim();	
					rallowansql = rallowansql.substring(0,rallowansql.length()-1);
					sql= " SELECT "+rallowansql+" FROM pay_t_salary  ";
					sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
					sql = sql+" AND  INT_YEAR ="+Year;
					sql = sql+" AND CHR_MONTH='"+mont+"'";
					String recoverydata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					
					cell = new PdfPCell ( new Paragraph (fontselector.process("DEDUCTIONS" ) ));
					cell.setColspan (2);
					cell.setHorizontalAlignment (Element.ALIGN_CENTER);
					table5.addCell(cell);
					 
				 
					 
					if(rname.length>1)
					{
						for(int u=0;u<rname.length;u++)
						{
						
						 ramount=0.0;
						 ramount=Double.parseDouble(recoverydata[0][u]);	
						 if(ramount>0)
						 {
							table5.addCell(new PdfPCell(new Paragraph(fontselector.process(rname[u][1]) )  ));
							cell = new PdfPCell ( new Paragraph (fontselector.process("" +Integer.parseInt(recoverydata[0][u]) ) ));
							cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
							table5.addCell(cell);
							 deduction=deduction+ramount;
						 }	
						}
					}	
					if(advance>0)
					{
						table5.addCell(new PdfPCell(new Paragraph(fontselector.process("Advance") )  ));
						cell = new PdfPCell ( new Paragraph (fontselector.process("" +(int)advance) ));
						cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
						table5.addCell(cell);
						 
						 
					}
					deduction=deduction+advance;
					
					table5.addCell(new PdfPCell(new Paragraph(fontselector.process("PF") )  ));
					cell = new PdfPCell ( new Paragraph (fontselector.process("" +(int)pf) ));
					cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
					table5.addCell(cell);
					 			
					 
					deduction=deduction+pf;
					table5.addCell(new PdfPCell(new Paragraph(fontselector.process("ESI") )  ));
					cell = new PdfPCell ( new Paragraph (fontselector.process("" +(int)esi) ));
					cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
					table5.addCell(cell);
					 	
					 
					 
					deduction=deduction+esi;
					table5.addCell(new PdfPCell(new Paragraph(fontselector.process("Tax Deduction") )  ));
					cell = new PdfPCell ( new Paragraph (fontselector.process("" +(int)taxvalue) ));
					cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
					table5.addCell(cell);
					 
					  
					deduction=deduction+taxvalue;
					table5.addCell(new PdfPCell(new Paragraph(fontselector.process("Loss of pay") )  ));
					cell = new PdfPCell ( new Paragraph (fontselector.process("" +(int)(originalgross-earninggross)) ));
					cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
					table5.addCell(cell);
					
					 
				
					table5.addCell(new PdfPCell(new Paragraph(fontselector.process("Total deductions") )  ));
					cell = new PdfPCell ( new Paragraph (fontselector.process("" +(int)(deduction+(originalgross-earninggross))) ));
					cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
					table5.addCell(cell);
					
					 
					table.addCell (table4);
					table.addCell (table5);
					
					
					fontselector = new FontSelector();
		            fontselector.addFont(new Font(Font.TIMES_ROMAN, 8));
		            fontselector.addFont(new Font(Font.ZAPFDINGBATS, 8));
		            fontselector.addFont(new Font(Font.SYMBOL, 8));
		            
					content = "Net Amount ::"+(int)((earninggross-deduction)+extraallowances)+"/-\n" ;
					content=content+com.my.org.erp.common.CommonFunctions.numberWord(""+(int)((earninggross-deduction)+extraallowances));
					
					cell = new PdfPCell (new Paragraph (fontselector.process("")));
					cell.setColspan (2);
					cell.setHorizontalAlignment (Element.ALIGN_CENTER);
					table.addCell (cell);
					
					cell = new PdfPCell ( new Paragraph (fontselector.process(content ) ));
					cell.setColspan (2);
					cell.setHorizontalAlignment (Element.ALIGN_CENTER);
					table.addCell (cell);
					
					;
					
					/*image = Image.getInstance (request.getRealPath("/")+"Image/report/Rupee.gif");
					image.setAlignment(1);
					cell = new PdfPCell (image,true );
					cell.setColspan (2);
					cell.setHorizontalAlignment (Element.ALIGN_CENTER);
					table.addCell (cell);
					*/
					content ="H.O. : #481, 2nd Floor, Anna Salai, Nandanan, Chennai-600035. Tel.: 24340906(4 LINES) FAX:24340835 \n";
					content = content+"* Payslip generated by salary package, does not require any signature. ";
					 
					cell = new PdfPCell (new Paragraph (  fontselector.process( content)   ));
					cell.setColspan (2);
					cell.setHorizontalAlignment (Element.ALIGN_CENTER);
					cell.setBackgroundColor (new Color (128, 200, 128));
					cell.setPadding (5.0f);
					
					table.addCell (cell);
					
					
					document.add(table);
				  	 
					
				  
					 
				}
				
			}
			else
			 {
				fontselector = new FontSelector();
	            fontselector.addFont(new Font(Font.TIMES_ROMAN, 7));
	            fontselector.addFont(new Font(Font.ZAPFDINGBATS, 7));
	            fontselector.addFont(new Font(Font.SYMBOL, 7));
	            Phrase ph = fontselector.process("Data not found... ");
				document.add(new Paragraph(ph));
			   
				 
			 }
			 
			document.close(); 
		}
		catch(Exception e)
		{         
			
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
			
		}     
		
	}
	 
	
	 
	
	

	@SuppressWarnings("deprecation")
	private void PAYMonthlyPayslipDownload(String staffid,HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		try
		{         
			
			
			String sql="";
	   		 
			String mth = "" + request.getParameter("Month");
			String mont = DateUtil.getMonth(Integer.parseInt(mth));
			String Year = "" + request.getParameter("Year");
			 
			 
			 
			String staffname="";
			String cpyname="";
			String desig="";
			String office="";
			 
			String bank="";
			 
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
			sql = sql + " FROM  pay_t_salary  a ,com_m_staff b,com_m_company c,com_m_desig d,com_m_office e   ";
			sql = sql + " WHERE a.CHR_EMPID = b.CHR_EMPID    ";
			sql = sql + " AND a.INT_COMPANYID = c.INT_COMPANYID    ";
			sql = sql + " AND a.INT_DESIGID = d.INT_DESIGID    ";
			sql = sql + " AND a.INT_OFFICEID = e.INT_OFFICEID    ";
			 
			sql = sql + " AND	a.CHR_EMPID='"+staffid+"'    ";
			sql = sql+" AND  a.INT_YEAR ="+Year;
			sql = sql+" AND a.CHR_MONTH='"+mont+"'";
			 
			String basicdata[][]= CommonFunctions.QueryExecute(sql);
			
			sql = " SELECT INT_SALARY FROM pay_t_salarybasic";
			sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
			sql = sql+" AND  INT_YEAR ="+Year;
			sql = sql+" AND CHR_MONTH='"+mont+"'";
			String basics[][]= CommonFunctions.QueryExecute(sql);

			sql=" SELECT DOU_BASIC,DOU_ATOTAL1,DOU_GROSSPAY,(DOU_BASIC+DOU_ATOTAL1),DOU_ATOTAL2 FROM pay_t_salary  ";
		 	sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
			sql = sql+" AND  INT_YEAR ="+Year;
			sql = sql+" AND CHR_MONTH='"+mont+"'";
			String earning[][]= CommonFunctions.QueryExecute(sql);
			
			
			 Document document=new Document();
			 document.addAuthor("CARE");
			 document.addCreationDate();
			 document.addCreator("SmartCampus");
			 document.addTitle("PAYSLIP");
		 
			 PdfWriter.getInstance(document ,new FileOutputStream(Path+"uploadfiles/Payslip_pdf/"+staffid+"_"+mont+"_"+Year+".pdf"));
			 document.open();

			 
			 
			 Image image = Image.getInstance (request.getRealPath("/")+"images/logo.jpg");
			 image.setAlignment(1);
			 document.add(image );
				
			 
			     
			FontSelector fontselector = new FontSelector();
            fontselector.addFont(new Font(Font.TIMES_ROMAN, 10));
            fontselector.addFont(new Font(Font.ZAPFDINGBATS, 10));
            fontselector.addFont(new Font(Font.SYMBOL, 10));
			
            
            
           
            
			if(basicdata.length>0)
			{
				staffname=basicdata[0][0];
				cpyname=basicdata[0][1];
				desig=basicdata[0][2];
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
				String aname[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
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
				String salarydata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(salarydata.length>0)
				{
				 	 
					pf=Double.parseDouble(salarydata[0][1]);
					esi=Double.parseDouble(salarydata[0][2]);
					advance=Double.parseDouble(salarydata[0][3]);
					wrkdays=Double.parseDouble(salarydata[0][4]);
					taxvalue=Double.parseDouble(salarydata[0][5]);
			
				
					
				 
		            String content = "";
		            
				 
					PdfPTable table=new PdfPTable(2);
					PdfPCell cell = new PdfPCell (new Paragraph (content));
					 
					fontselector = new FontSelector();
		            fontselector.addFont(new Font(Font.TIMES_ROMAN, 14));
		            fontselector.addFont(new Font(Font.ZAPFDINGBATS, 14));
		            fontselector.addFont(new Font(Font.SYMBOL, 14));
		            
		            
					cell = new PdfPCell ( new Paragraph (fontselector.process(cpyname ) ));
					cell.setColspan (2);
					cell.setHorizontalAlignment (Element.ALIGN_CENTER);
					cell.setBackgroundColor (new Color (128, 200, 128));
					table.addCell (cell);
					
					fontselector = new FontSelector();
		            fontselector.addFont(new Font(Font.TIMES_ROMAN, 7));
		            fontselector.addFont(new Font(Font.ZAPFDINGBATS, 7));
		            fontselector.addFont(new Font(Font.SYMBOL, 7));
		           
					cell = new PdfPCell ( new Paragraph (fontselector.process("PAY SLIP FOR [ "+mont +" - " +Year+" ] \n " +staffname+"\n" ) ));
					cell.setColspan (2);
					cell.setHorizontalAlignment (Element.ALIGN_CENTER);
					cell.setBackgroundColor (new Color (128, 200, 128));
					table.addCell (cell);
					
				 
					
					PdfPTable table1=new PdfPTable(2);
					table1.addCell(new PdfPCell(new Paragraph(fontselector.process("Employee Number") )  ));
					table1.addCell(new PdfPCell(new Paragraph(fontselector.process(staffid) )  ));
					table1.addCell(new PdfPCell(new Paragraph(fontselector.process("Designation") )  ));
					table1.addCell(new PdfPCell(new Paragraph(fontselector.process(desig) )  ));
					table1.addCell(new PdfPCell(new Paragraph(fontselector.process("Location") )  ));
					table1.addCell(new PdfPCell(new Paragraph(fontselector.process(office) )  ));
					table1.addCell(new PdfPCell(new Paragraph(fontselector.process("No. of working days") )  ));
					table1.addCell(new PdfPCell(new Paragraph(fontselector.process(""+wrkdays) )  ));
					 


					
					PdfPTable table2=new PdfPTable(2);
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process("PF Number") )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process( basicdata[0][9]+basicdata[0][6] ) )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process("ESI Number") )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process(basicdata[0][7]) )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process("Bank Name ") )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process(bank.split("-")[0]) )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process("Account No ") )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process(bank.split("-")[1]) )  )); 
					table.addCell (table1);
					table.addCell (table2);
					
					
					PdfPTable table4=new PdfPTable(2);
					sql = "Select "+addedallowance+" FROM pay_t_salaryallowance  ";
					sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
					sql = sql+" AND  INT_YEAR ="+Year;
					sql = sql+" AND CHR_MONTH='"+mont+"'";
					String data1[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					int columncount1 = com.my.org.erp.common.CommonFunctions.intGetColumnCount(sql);
					addedallowancetitle=addedallowancetitle+"";
					String titledata1[] = addedallowancetitle.split(",");
					
					table4.addCell(new PdfPCell(new Paragraph(fontselector.process("Basic") )  ));
					cell = new PdfPCell ( new Paragraph (fontselector.process(""+(int)originalbasic ) ));
					cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
					table4.addCell(cell);
					 
					
					cell = new PdfPCell ( new Paragraph (fontselector.process("ALLOWANCE" ) ));
					cell.setColspan (2);
					cell.setHorizontalAlignment (Element.ALIGN_CENTER);
					table4.addCell(cell);
					 

					if(columncount1>1)
					{
						for(int x=0;x<columncount1;x++)
						{
							if((Integer.parseInt(data1[0][x]))>0)
							{
								originalgross = originalgross+Integer.parseInt(data1[0][x]);
								table4.addCell(new PdfPCell(new Paragraph(fontselector.process(titledata1[x]) )  ));
								cell = new PdfPCell ( new Paragraph (fontselector.process(""+data1[0][x] ) ));
								cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
								table4.addCell(cell);
								 
								 
							}	
						}	
						
					}
					
					originalgross = originalgross+originalbasic;
					table4.addCell(new PdfPCell(new Paragraph(fontselector.process("Gross Pay") )  ));
					cell = new PdfPCell ( new Paragraph (fontselector.process(""+(int)originalgross ) ));
					cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
					table4.addCell(cell);
					 
					 
					sql = "Select "+extraallowance+" FROM pay_t_salaryallowance  ";
					sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
					sql = sql+" AND  INT_YEAR ="+Year;
					sql = sql+" AND CHR_MONTH='"+mont+"'";
					
					String data2[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					columncount1 = com.my.org.erp.common.CommonFunctions.intGetColumnCount(sql);
					extraallowancetitle=extraallowancetitle+"";
					String titledata2[] = extraallowancetitle.split(",");
				 
					if(columncount1>1)
					{
						for(int x=0;x<columncount1;x++)
							if((Integer.parseInt(data2[0][x]))>0)
								originalextraallowance = originalextraallowance+Integer.parseInt(data2[0][x]);
						if(originalextraallowance>0)
						{
							
							cell = new PdfPCell ( new Paragraph (fontselector.process("Extra Allowance" ) ));
							cell.setColspan (2);
							cell.setHorizontalAlignment (Element.ALIGN_CENTER);
							table4.addCell(cell);
							 
							 
							for(int x=0;x<columncount1;x++)
							{
								if((Integer.parseInt(data2[0][x]))>0)
								{
									table4.addCell(new PdfPCell(new Paragraph(fontselector.process(titledata2[x]) )  ));
									cell = new PdfPCell ( new Paragraph (fontselector.process(""+data2[0][x] ) ));
									cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
									table4.addCell(cell);
									
									 
									 
								}	
							}	
							 
						}
					}
					
					
					table4.addCell(new PdfPCell(new Paragraph(fontselector.process("Total") )  ));
					cell = new PdfPCell ( new Paragraph (fontselector.process(""+(int)(originalgross+originalextraallowance) ) ));
					cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
					table4.addCell(cell);
					 
					 
					
					
					
					
					PdfPTable table5=new PdfPTable(2);

				  	sql = " SELECT CHR_RCODE,CHR_RNAME FROM pay_m_recovery ";
					String rname[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					String rallowansql="";
					for(int a=0;a<rname.length;a++)
						rallowansql =rallowansql+rname[a][0]+" , ";
						
					rallowansql=rallowansql.trim();	
					rallowansql = rallowansql.substring(0,rallowansql.length()-1);
					sql= " SELECT "+rallowansql+" FROM pay_t_salary  ";
					sql = sql+" WHERE CHR_EMPID='"+staffid+"'";
					sql = sql+" AND  INT_YEAR ="+Year;
					sql = sql+" AND CHR_MONTH='"+mont+"'";
					String recoverydata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					
					cell = new PdfPCell ( new Paragraph (fontselector.process("DEDUCTIONS" ) ));
					cell.setColspan (2);
					cell.setHorizontalAlignment (Element.ALIGN_CENTER);
					table5.addCell(cell);
					 
				 
					 
					if(rname.length>1)
					{
						for(int u=0;u<rname.length;u++)
						{
						
						 ramount=0.0;
						 ramount=Double.parseDouble(recoverydata[0][u]);	
						 if(ramount>0)
						 {
							table5.addCell(new PdfPCell(new Paragraph(fontselector.process(rname[u][1]) )  ));
							cell = new PdfPCell ( new Paragraph (fontselector.process("" +Integer.parseInt(recoverydata[0][u]) ) ));
							cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
							table5.addCell(cell);
							 deduction=deduction+ramount;
						 }	
						}
					}	
					if(advance>0)
					{
						table5.addCell(new PdfPCell(new Paragraph(fontselector.process("Advance") )  ));
						cell = new PdfPCell ( new Paragraph (fontselector.process("" +(int)advance) ));
						cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
						table5.addCell(cell);
						 
						 
					}
					deduction=deduction+advance;
					
					table5.addCell(new PdfPCell(new Paragraph(fontselector.process("PF") )  ));
					cell = new PdfPCell ( new Paragraph (fontselector.process("" +(int)pf) ));
					cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
					table5.addCell(cell);
					 			
					 
					deduction=deduction+pf;
					table5.addCell(new PdfPCell(new Paragraph(fontselector.process("ESI") )  ));
					cell = new PdfPCell ( new Paragraph (fontselector.process("" +(int)esi) ));
					cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
					table5.addCell(cell);
					 	
					 
					 
					deduction=deduction+esi;
					table5.addCell(new PdfPCell(new Paragraph(fontselector.process("Tax Deduction") )  ));
					cell = new PdfPCell ( new Paragraph (fontselector.process("" +(int)taxvalue) ));
					cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
					table5.addCell(cell);
					 
					  
					deduction=deduction+taxvalue;
					table5.addCell(new PdfPCell(new Paragraph(fontselector.process("Loss of pay") )  ));
					cell = new PdfPCell ( new Paragraph (fontselector.process("" +(int)(originalgross-earninggross)) ));
					cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
					table5.addCell(cell);
					
					 
				
					table5.addCell(new PdfPCell(new Paragraph(fontselector.process("Total deductions") )  ));
					cell = new PdfPCell ( new Paragraph (fontselector.process("" +(int)(deduction+(originalgross-earninggross))) ));
					cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
					table5.addCell(cell);
					
					 
					table.addCell (table4);
					table.addCell (table5);
					
					
					fontselector = new FontSelector();
		            fontselector.addFont(new Font(Font.TIMES_ROMAN, 8));
		            fontselector.addFont(new Font(Font.ZAPFDINGBATS, 8));
		            fontselector.addFont(new Font(Font.SYMBOL, 8));
		            
					content = "Net Amount ::"+(int)((earninggross-deduction)+extraallowances)+"/-\n" ;
					content=content+com.my.org.erp.common.CommonFunctions.numberWord(""+(int)((earninggross-deduction)+extraallowances));
					
					cell = new PdfPCell (new Paragraph (fontselector.process("")));
					cell.setColspan (2);
					cell.setHorizontalAlignment (Element.ALIGN_CENTER);
					table.addCell (cell);
					
					cell = new PdfPCell ( new Paragraph (fontselector.process(content ) ));
					cell.setColspan (2);
					cell.setHorizontalAlignment (Element.ALIGN_CENTER);
					table.addCell (cell);
					
					;
					
					 
					
					content ="H.O. : #481, 2nd Floor, Anna Salai, Nandanan, Chennai-600035. Tel.: 24340906(4 LINES) FAX:24340835 \n";
					content = content+"* Payslip generated by salary package, does not require any signature. ";
					 
					cell = new PdfPCell (new Paragraph (  fontselector.process( content)   ));
					cell.setColspan (2);
					cell.setHorizontalAlignment (Element.ALIGN_CENTER);
					cell.setBackgroundColor (new Color (128, 200, 128));
					cell.setPadding (5.0f);
					
					table.addCell (cell);
					
					
					document.add(table);
				  	 
					
				  
					 
				}
				
			}
			else
			 {
				fontselector = new FontSelector();
	            fontselector.addFont(new Font(Font.TIMES_ROMAN, 7));
	            fontselector.addFont(new Font(Font.ZAPFDINGBATS, 7));
	            fontselector.addFont(new Font(Font.SYMBOL, 7));
	            Phrase ph = fontselector.process("Data not found... ");
				document.add(new Paragraph(ph));
			   
				 
			 }
			 
			document.close();  
		}
		catch(Exception e)
		{         
			
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
			
		}     
		
	}
	 
	
	
	
	
	
	
	
	
	 
	 
	 
	
	
}

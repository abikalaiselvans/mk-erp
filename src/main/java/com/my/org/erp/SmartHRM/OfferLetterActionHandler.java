
package com.my.org.erp.SmartHRM;

import java.awt.Color;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;

 
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
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.common.SalaryFunctions;
import com.my.org.erp.mail.Mail;
import com.my.org.erp.setting.CommonData;
public class OfferLetterActionHandler extends AbstractActionHandler 
{
	 String applicantid  ="";
	 String redirectlink="Smart HRM/OfferLetterView.jsp";
	
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			if (action.equals("HRMOfferLetterAdd")) 
			{
				OfferLetterAdd(request, response);
				con.close();   
				response.sendRedirect("Smart HRM/HRMOfferLetter.jsp?applicantid="+  applicantid  );// OfferLetterView.jsp
			}
			else if (action.equals("HRMOfferLetterDelete")) 
			{
				OfferLetterDelete(request, response);
				con.close();   
				response.sendRedirect("Smart HRM/OfferLetterView.jsp"  );
			}
			 else if (action.equals("HRMSendOfferLettertoMail")) 
			{
				
				 String applicantid=""+request.getParameter("applicantid");
				 String to[][] = CommonFunctions.QueryExecute("SELECT CHR_EMAILID,CHR_APPNAME FROM hrm_m_application WHERE INT_APPID="+applicantid);
				 String a[] =(to[0][0]+","+CommonData.mailid).split(",") ;
				  
				 Mail.SimpleHTMLMail(  a, "Offer Letter For "+to[0][1], SendOfferLettertoMail(request, response));
				 
				con.close();   
				response.sendRedirect("Smart HRM/OfferLetterView.jsp"  );
			}
			else if (action.equals("HRMOfferLettertoPDF")) 
			{
				HRMOfferLettertoPDF(request, response); 
				con.close();   
				response.sendRedirect(redirectlink );
			}
			else if (action.equals("HRMOfferLetterAccept")) 
			{
				String comments = request.getParameter("comments");
				String noticeperiod = request.getParameter("noticeperiod");
				String applicantid = request.getParameter("applicantid");
				String random = request.getParameter("random");
				String notice =CommonFunctions.QueryExecute("SELECT DATE_FORMAT(DATE_ADD(now(), INTERVAL "+noticeperiod+" DAY),'%Y-%m-%d')")[0][0];
				String valid =CommonFunctions.QueryExecute( "SELECT (NOW() <='"+notice+"')")[0][0];
				if("1".equals(valid))
				{
					asql =" UPDATE hrm_t_offerletter SET CHR_ACCEPT=?,CHR_OFFERACCEPTDESC=?," +
							"CHR_RANDOMCHAR =? WHERE INT_APPID=? AND CHR_RANDOMCHAR=?";
					apstm = con.prepareStatement(asql);
					apstm.setString(1,"Y");
					apstm.setString(2, comments);
					apstm.setString(3, com.my.org.erp.Math.MathFunction.randomstring(6, 6));
					apstm.setString(4, applicantid);
					apstm.setString(5, random);
					apstm.execute();
					apstm.close();
					SendOfferLetterApprovalMail(request,response); 
				}
				con.close();  
				
				response.sendRedirect("Smart Common/exit.jsp");
				
				
			}
			else if (action.equals("HRMOfferLetterAcceptAdmin")) 
			{
				String comments = request.getParameter("comments");
				String applicantid = request.getParameter("applicantid");
				asql =" UPDATE hrm_t_offerletter SET CHR_ACCEPT=?,CHR_OFFERACCEPTDESC=?," +
						"CHR_RANDOMCHAR =? WHERE INT_APPID=? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,"Y");
				apstm.setString(2, comments);
				apstm.setString(3, com.my.org.erp.Math.MathFunction.randomstring(6, 6));
				apstm.setString(4, applicantid);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				con.close();  
				response.sendRedirect("Smart Common/exit.jsp");
				
				
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
	
	
public void OfferLetterDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
{
		try 
		{
				
				String ids[] = request.getParameterValues("rowid");
				for(int u=0;u<ids.length;u++)
				{
					
					String sql= " DELETE FROM hrm_t_offerletter WHERE INT_APPID = "+ids[u];
					com.my.org.erp.common.CommonFunctions.Execute(sql);
					
					sql= " UPDATE hrm_m_application  SET  CHR_OFFERORDERSTATUS='N' WHERE  INT_APPID = "+ids[u];
					com.my.org.erp.common.CommonFunctions.Execute(sql);
					
					sql = "DELETE FROM hrm_t_allowance WHERE INT_APPID = "+ids[u];
					com.my.org.erp.common.CommonFunctions.Execute(sql);
					
					
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
	




public void OfferLetterAdd (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
{

		HttpSession session=request.getSession();			
		String userid=""+session.getAttribute("USRID");			
		applicantid  =request.getParameter("appNo");
		String offer=request.getParameter("ChkStatus");
		String authority =request.getParameter("authority");
		String gross =request.getParameter("fsalary");
		String pf =request.getParameter("pf");
		String esi =request.getParameter("ESI");
		String category =request.getParameter("category");
		String desigination =request.getParameter("desigination");
		String office =request.getParameter("office");
		String noticeperiod =request.getParameter("noticeperiod");
		 
		try 
		{
			
			String sql= "INSERT INTO hrm_t_offerletter ";
			sql = sql + "(INT_APPID,DT_OFFERDATE," +
					"INT_DESIGID,INT_OFFICEID,INT_CATEGORY,INT_NOTICEPERIOD,DOU_SALARY," +
					"CHR_PF,CHR_ESI,CHR_AUTHORITY,CHR_APPSTATUS,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS,CHR_RANDOMCHAR)";
			sql = sql + "  values ( ?,DATE(NOW()),?,?,?,?,?,?,?,?,?,?, DATE(NOW()),'Y',? )";
			
			apstm = con.prepareStatement(sql);
			apstm.setString(1,applicantid);
			apstm.setString(2,desigination);
			apstm.setString(3, office);
			apstm.setString(4, category);
			apstm.setString(5, noticeperiod);
			apstm.setString(6, gross);
			apstm.setString(7, pf);
			apstm.setString(8, esi);
			apstm.setString(9, authority);
			apstm.setString(10, offer);
			apstm.setString(11, userid);
			apstm.setString(12, com.my.org.erp.Math.MathFunction.randomstring(6, 6) );
			apstm.execute();
			apstm.close();
			 
			CommonFunctions.Execute(sql);
			CommonFunctions.Execute("UPDATE hrm_m_application SET CHR_OFFERORDERSTATUS='Y'  WHERE INT_APPID="+applicantid);
			SalaryFunctions.offerLetterBand(applicantid, Double.parseDouble(gross));
				//com.my.org.erp.common.CommonFunctions.Execute("UPDATE hrm_m_jobdemand  SET INT_DEMAND = INT_DEMAND-1 WHERE INT_JOBID="+com.my.org.erp.common.CommonFunctions.QueryExecute(sql)[0][0]);
			
		}
		catch (Exception e) 
		{
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
				
		}
			
	}





public static String  SendOfferLettertoMail (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
{

			
				
		String applicantid  =request.getParameter("applicantid");
		String content="";
		 
		try 
		{ 
			
			content=content+"    <table width='60%' border='0' align='center' cellpadding='2' ";
			content=content+"    cellspacing='2'> ";
			content=content+"    <tr> ";
			content=content+"    <td> ";
						
			applicantid=""+request.getParameter("applicantid");
			String pf ="";
			String esi ="";

			String sql=" ";
			 


			sql = "  SELECT g.INT_OFFERID,b.INT_APPID,b.CHR_APPCODE,b.CHR_APPNAME,b.CHR_APPFATHER,b.CHR_GENDER, 	 ";	  
			sql = sql +"  DATE_FORMAT(b.DT_DOB,'%d-%m-%Y'),b.CHR_EMAILID,b.CHR_MOBILE, b.CHR_PADD1,b.CHR_PADD2,f.CHR_CITYNAME,	 ";	  
			sql = sql +"  e.CHR_DISTRICT,d.CHR_STATENAME, c.CHR_COUNTRYNAME,b.INT_PPIN, a.CHR_JOBGRADE,a.CHR_JOBCODE,a.CHR_JOBTITLE ,	 ";	  
			sql = sql +"  g.DT_OFFERDATE, DATE_FORMAT(g.DT_OFFERDATE,'%d-%m-%Y'),CHR_PF,CHR_ESI ,	 ";	  
			sql = sql +"  h.CHR_CATEGORYNAME ,i.CHR_DESIGNAME,j.CHR_OFFICENAME,g.INT_NOTICEPERIOD,b.CHR_EMAILID	,g.CHR_RANDOMCHAR ";	  
			sql = sql +"  FROM hrm_m_jobdesign a, hrm_m_application b , com_m_country c, com_m_state d,com_m_district e,	 ";	  
			sql = sql +"  com_m_city f ,hrm_t_offerletter g ,com_m_employeecategory h,com_m_desig i,com_m_office j	 ";	  
			sql = sql +"  WHERE a.INT_JOBID=b.INT_JOBID 	 ";	  
			sql = sql +"  AND b.INT_APPID= g.INT_APPID	 ";	  
			sql = sql +"  AND b.INT_PCOUNTRYID=c.INT_COUNTRYID 	 ";	  
			sql = sql +"  AND b.INT_PSTATE=d.INT_STATEID 	 ";	  
			sql = sql +"  AND b.INT_PDISTRICTID=e.INT_DISTRICTID	 ";	   
			sql = sql +"  AND b.INT_PCITY=f.INT_CITYID 	 ";	  
			sql = sql +"  AND g.INT_CATEGORY=h.INT_EMPLOYEECATEGORYID 	 ";	  
			sql = sql +"  AND g.INT_DESIGID=i.INT_DESIGID	 ";	  
			sql = sql +"  AND g.INT_OFFICEID=j.INT_OFFICEID	 ";	  
			sql = sql +"  AND b.INT_APPID="+applicantid;
			
			 
			
            String rowdata[][]   = CommonFunctions.QueryExecute(sql);				
			String appointed=DateUtil.FormateDateSys(rowdata[0][19]);
			String app= CommonFunctions.Appointmentyear(appointed);
			String id[]=app.split("~");				
			pf =rowdata[0][21];
			esi =rowdata[0][22];	
			 
			String institutionData[][] =  CommonFunctions.QueryExecute("SELECT  INT_PFAMT,INT_ESIAMT,INT_ESILIMIT,INT_PFLIMIT,INT_PFLIMITMINIMUM ,INT_CPY_ESIAMT FROM m_institution WHERE INT_ID=1");
			double pfpercentage = Double.parseDouble( institutionData[0][0]);
			double esipercentage = Double.parseDouble( institutionData[0][1]);
			double esilimitamount = Double.parseDouble( institutionData[0][2]);
			double pfmaximumlimit = Double.parseDouble( institutionData[0][3]);
			double pfminimumlimit = Double.parseDouble( institutionData[0][4]);
			double esicomapnypercentage = Double.parseDouble( institutionData[0][5]);

			content=content+" </td> ";
			content=content+" </tr> ";

			content=content+" <tr> ";
			content=content+" <td height='25'>&nbsp;</td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td height='54'> ";
			content=content+" <table width='100%' border='0' align='center' cellpadding='0' cellspacing='0'> ";
			          
			content=content+" <tr> ";
			content=content+" <td width='100%' height='20' colspan='2'><div align='center'><span class='boldgre'>OFFER LETTER </span></div></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td colspan='2'><div align='right'></div></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td colspan='2'></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td colspan='2'></td> ";
			content=content+"  </tr> ";
			content=content+" <tr> ";
			content=content+" <td height='19' colspan='2'><table width='100%' border='0' cellspacing='1' cellpadding='1'> ";
			content=content+" <tr> ";
			content=content+" <th width='720' height='21' scope='col'><div align='left'><span class='style11'> ";
			content=content+" <b>CARE/OFFER-"+rowdata[0][0]+"/"+rowdata[0][23]+"/ "+id[0] +"  <br/> ";
			content=content+ CommonFunctions.QueryExecute("SELECT DATE_FORMAT(NOW(),'%d-%m-%Y')")[0][0];				  
			content=content+" </b></span></div></th> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <th scope='col'>&nbsp;</th> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <th scope='col'><div align='left'> ";
			content=content+" <span class='style11'> ";
			                      
			content=content+" <span class='boldgre'> To  ";
			content=content+" <br/> ";
			content=content+" Mr/Ms. "+ rowdata[0][3]+" ,<br/> ";
			content=content+rowdata[0][25] +" ,<br/> ";
			content=content+" </span> ";
			                       
			content=content+" </span></div></th> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <th scope='col'>&nbsp;</th> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <th height='85' scope='col'><div align='left'><span class='boldgre'> Dear. ";
			                     
			content=content+" Mr/Ms."+rowdata[0][3]+",</span>                    <br/> ";
			content=content+" &nbsp;&nbsp;&nbsp;&nbsp; We are pleased to offer the post of &nbsp;<span class='boldgre'>\" "+rowdata[0][24] +" \" </span>&nbsp;in our organisation at &nbsp; ";
			content=content+" <span class='boldgre'> \" "+rowdata[0][25] +" \" ";
			content=content+" </span>.&nbsp; <br>You are expected to join us on  or before&nbsp;<span class='boldgre'>";
			content=content+ CommonFunctions.QueryExecute("SELECT DATE_FORMAT(DATE_ADD(now(), INTERVAL "+rowdata[0][26]+" DAY),'%d-%b-%Y')")[0][0]+" </span>&nbsp;  failing which this offer is not valid. Your salary details are as mentioned below.<br> </div></th> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <th scope='col'>&nbsp;</th> ";
			content=content+" </tr> ";
			content=content+" </table></td> ";
			content=content+" </tr> ";
			content=content+" </table>		 </td> ";
			content=content+" </tr> ";
				 
			content=content+" <tr> ";
			content=content+" <td height='54'> ";
			
			
			
			content=content+"<table width='100%' border='1' align='center' cellpadding='0' cellspacing='0' bordercolor='#000000'>";
			content=content+"<tr>";
			content=content+"<td>";




			content=content+"<TABLE  width='100%'  border='0' align='center' cellPadding='4' cellSpacing='4'>"; 
			content=content+" <TBODY>"; 
			content=content+"<TR>"; 
			content=content+"<TD   colSpan='7' align='center'><h1>Annexure</h1></TD>"; 
			content=content+"</TR>"; 
			
			content=content+"<TR bgcolor='#666666'   >"; 
			content=content+"<TD   colSpan='2'><p><strong>Particulars</strong></p></TD>"; 
			content=content+"<TD   ><p><strong>&nbsp;</strong></p></TD>"; 
			content=content+" <TD   ><p><strong>Amount</strong><strong>(P   M)</strong></p>                    </TD>"; 
			content=content+"<TD   <p><strong>&nbsp;</strong></p></TD>"; 
			content=content+"<TD   ><p><strong>Amount   (PA)</strong></p></TD>"; 
			content=content+"<TD   ><p><strong>&nbsp;</strong></p></TD>"; 
			content=content+"</TR>"; 
			
			String AllowanceData[][] = CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME  FROM pay_m_allowance WHERE CHR_FLAG='Y' ORDER BY INT_ALLOWANCEID");
			String salaryband="   ";
			String grossband="";
			for(int u=0; u<AllowanceData.length;u++)
			{
				salaryband = salaryband+"  a."+AllowanceData[u][0]+",( a."+AllowanceData[u][0]+" *12) ,"; 
				grossband = grossband+"  a."+AllowanceData[u][0]+"+";
			}	
			salaryband=salaryband.trim();
			salaryband = salaryband.substring(0,salaryband.length()-1);		
			
			grossband=grossband.trim();
			grossband = grossband.substring(0,grossband.length()-1);		
			
			sql = " SELECT ROUND(a.INT_BASIC),ROUND(INT_BASIC*12),"+salaryband+" ,ROUND(a.INT_BASIC+("+grossband+")),ROUND( (a.INT_BASIC+("+grossband+"))*12 ),ROUND(a.INT_BASIC*12/100) ,ROUND((a.INT_BASIC*12/100)*12),ROUND( (a.INT_BASIC+("+grossband+"))  + (a.INT_BASIC*12/100) ) , ROUND(( (a.INT_BASIC+("+grossband+"))  + (a.INT_BASIC*12/100) )*12),ROUND( (a.INT_BASIC+("+grossband+")) - (a.INT_BASIC*12/100) )  FROM hrm_m_application b,hrm_t_allowance a ";
			sql = sql +" 	WHERE a.INT_APPID = b.INT_APPID AND a.INT_APPID= "+applicantid+"  ";
			
			 
				
			String payData[][] = CommonFunctions.QueryExecute(sql);
			double monthbasic=0;
			double monthgross=0;
			double monthpf=0;
			double monthesi=0;
			double monthctc=0;
			
			double staffpf=0;
			double staffesi=0;
			double takehome=0;
			
			if(payData.length>0)
			{
				 content=content+"<TR bgcolor='CCCCCC'>";
				 content=content+"<TD vAlign='bottom'   colSpan='2'><p>Basic</p></TD>";
				 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
				 content=content+"<TD vAlign='bottom'    align='right'><p>"+payData[0][0]+"</p></TD>";
				 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
				 content=content+"<TD vAlign='bottom'   align='right'><p>"+payData[0][1]+"</p></TD>";
				 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
				 content=content+"</TR>";
				 int g=1;
				 int v=1;
				 for(int u=0; u<AllowanceData.length;u++)
				 {
					 g = g+2;
					 content=content+"<TR bgcolor='CCCCCC'>";
					 content=content+"<TD vAlign='bottom'  colSpan='2'><p> "+AllowanceData[u][1]+"</p></TD>";
					 content=content+"<TD vAlign='bottom'  >&nbsp;</TD>";
					 v=v+1;
					 content=content+"<TD vAlign='bottom'    align='right'><p> "+payData[0][v]+"</p></TD>";
					 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
					 v=v+1;
					 content=content+"<TD vAlign='bottom'   align='right'><p> "+payData[0][v]+"</p></TD>";
					 content=content+"<TD vAlign='bottom'  >&nbsp;</TD>";
					 content=content+"</TR>";
				}
				monthbasic=Double.parseDouble(payData[0][0]);
				monthgross=Double.parseDouble(payData[0][(g+1)]);
				
				 content=content+"<TR bgcolor='CCCCCC'>";
				 content=content+"<TD vAlign='bottom'    colSpan='2'><p>GROSS</p></TD>";
				 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
				 content=content+"<TD vAlign='bottom'    align='right'><p>"+Math.round(monthgross)+"</p></TD>";
				 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
				 content=content+"<TD vAlign='bottom'    align='right'><p>"+Math.round(monthgross*12)+"</p></TD>";
				 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
				 content=content+"</TR>"; 
					 
					
				 if("C".equals(pf))
				 {
					 
					if(monthbasic <= pfminimumlimit)
					{
						monthpf = (pfminimumlimit*pfpercentage/100); 
						staffpf = (pfminimumlimit*pfpercentage/100); 
					}
					else if( (monthbasic>pfminimumlimit)  && (monthbasic <=pfmaximumlimit))	
					{
						monthpf = (monthbasic*pfpercentage/100); 
						staffpf = (monthbasic*pfpercentage/100); 
					}
					else
					{
						monthpf = (pfmaximumlimit*pfpercentage/100);
						staffpf = (pfmaximumlimit*pfpercentage/100);
					}	
			
				}
				else
				{
					monthpf = 0;
					staffpf = 0;
				}
				 
				 
				 content=content+"<TR bgcolor='CCCCCC'>";
				 content=content+"<TD vAlign='bottom'    colSpan='2'><p>EMPLOYEER PF</p></TD>";
				 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
				 content=content+"<TD vAlign='bottom'    align='right'><p>"+Math.round(monthpf)+"</p></TD>";
				 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
				 content=content+"<TD vAlign='bottom'   align='right'><p>"+Math.round(monthpf*12)+"</p></TD>";
				 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
				 content=content+"</TR>"; 
			  
			
					 
				 if("C".equals(esi) && monthgross <=esilimitamount)
				 {
						monthesi=(monthgross*esicomapnypercentage/100);
						staffesi=(monthgross*esipercentage/100);
				 }
				 else
				 {
						monthesi=0;
					 	staffesi=0;
				 }
				 	 content=content+"<TR bgcolor='CCCCCC'>";
					 content=content+"<TD vAlign='bottom'   colSpan='2'><p>EMPLOYEER ESI</p></TD>";
					 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
					 content=content+"<TD vAlign='bottom'    align='right'><p>"+Math.round(monthesi)+"</p></TD>";
					 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
					 content=content+"<TD vAlign='bottom'    align='right'><p>"+Math.round(monthesi*12)+"</p></TD>";
					 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
					 content=content+"</TR>";
				  
					 
					 monthctc=monthgross+monthpf+monthesi;
					 content=content+"<TR bgcolor='CCCCCC'>";
					 content=content+"<TD vAlign='bottom'   colSpan='2'><p>Total cost To Company   (TCTC</p></TD>";
					 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
					 content=content+"<TD vAlign='bottom'    align='right'><p>"+Math.round(monthctc )+"</p></TD>";
					 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
					 content=content+"<TD vAlign='bottom'     align='right'><p>"+Math.round(monthctc*12)+"</p></TD>";
					 content=content+"<TD vAlign='bottom'    >&nbsp;</TD>";
					 content=content+"</TR>"; 
					 
					 
					
					 
					 content=content+"<TR bgcolor='CCCCCC'>";
					 content=content+"<TD vAlign='bottom'    colSpan='2'><p>As Applicable to your   Current Role</p></TD>";
					 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
					 content=content+"<TD vAlign='bottom'    align='right'>&nbsp;</TD>";
					 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
					 content=content+"<TD vAlign='bottom'    align='right'>&nbsp;</TD>";
					 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
					 content=content+"</TR>"; 
					 
					 takehome=monthgross-(staffpf+staffesi);;
					 content=content+"<TR bgcolor='CCCCCC'>";
					 content=content+"<TD vAlign='bottom'    colSpan='2'><p><strong>Take Home  Salary=</strong><strong>"+Math.round(takehome)+"</strong><strong></strong></p></TD>";
					 content=content+"<TD vAlign='bottom'  >&nbsp;</TD>";
					 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
					 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
					 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
					 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
					 content=content+"</TR>"; 
					 
				}
							
							content=content+"<TR >"; 
							content=content+"<TD ></TD>"; 
							content=content+"<TD ></TD>"; 
							content=content+"<TD ></TD>"; 
							content=content+"<TD ></TD>"; 
							content=content+"<TD </TD>"; 
							content=content+" <TD ></TD>"; 
							content=content+"<TD ></TD>"; 
							content=content+"</TR>"; 
							content=content+"</TBODY>"; 
							content=content+" </TABLE>"; 
					 
					 
					 
			content=content+"</td>";
			content=content+"</tr>";
			content=content+"</table>";

			 
			content=content+"<br>Your take home salary will be &nbsp; <span class='boldgre'>Rs."+Math.round(takehome)+"/-</span>  <br> </td>";
			content=content+"</tr>";
			content=content+"<tr>";
			content=content+"<td height='54'>";
			String pfData[][] = CommonFunctions.QueryExecute(" SELECT INT_PFAMT,INT_ESIAMT,INT_CPY_PFAMT,INT_CPY_PENSIONAMT,INT_CPY_ESIAMT,INT_PFLIMIT,INT_ESILIMIT,INT_PFLIMITMINIMUM,ROUND(INT_PFLIMITMINIMUM*INT_PFAMT/100) FROM m_institution WHERE INT_ID=1 ");
			if("C".equals(pf) && "C".equals(esi))
			{
				  content=content+"<br> PF will be deducted as per the minimum wages Act (the present level is Rs."+pfData[0][7]+"/-)(ie. MW Rs."+pfData[0][7]+"* "+pfData[0][0]+"%="+pfData[0][8]+"/-).(Basic -Employee Contribution of PF is "+pfData[0][0]+"%, Gross Contribution of ESIC "+pfData[0][1]+"%= Take home salary)."; 
				  content=content+"<br> <br>";
			}	
				
			String taxsql="SELECT INT_GTEQL,INT_LSEQL,DOU_PERCENTAGE,DOU_AMOUNT FROM pay_m_taxvalue ORDER BY INT_ID ";
			String taxdata[][] =  CommonFunctions.QueryExecute(taxsql);
			double taxvalue=0.0;
				
			for(int t=0;t<taxdata.length;t++)
				if((monthgross >= Integer.parseInt(taxdata[t][0])) && (monthgross <= Integer.parseInt(taxdata[t][1])))
					taxvalue= taxvalue+Double.parseDouble(taxdata[t][3]);
												
													
			 
			content=content+"Rs."+taxvalue+"/- per month will be deducted for professional salary as per statutory.";
			content=content+"<br>";
			content=content+"</td>";
			content=content+"</tr>";
			content=content+"<tr>";
			content=content+"<td  >Please confirm that the above terms are acceptable to you and that you accept the offer by signing the copy of this letter. </td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >Please ensure that you bring the enclosed details attached with the offer letter at the time of joining. </td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >Wishing you the very best. </td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >&nbsp;</td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >&nbsp;</td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >Your sincerely </td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  > ";
			String cpyData[][] = CommonFunctions.QueryExecute(" SELECT CHR_NAME,CHR_ADD1,CHR_ADD2,CHR_CITY,CHR_STATE,INT_PINCODE,INT_PHONE,CHR_MAILID FROM m_institution WHERE INT_ID=1 ");
			content=content+"For "+cpyData[0][0]+" </td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >&nbsp;</td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >&nbsp;</td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >Authorised Signatory </td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >&nbsp;</td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >&nbsp;</td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >&nbsp;</td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >I Agree to accept the offer on terms and conditions mentioned in the above letter </td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >&nbsp;</td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  ><table width='100%' border='0' cellspacing='0' cellpadding='0'> ";
			content=content+"<tr>";
			content=content+"<td width='55%'><b> Date : "+CommonFunctions.QueryExecute("SELECT DATE_FORMAT(NOW(),'%d-%m-%Y')")[0][0]+" </b></td> ";
			content=content+"<td width='45%'><b>Signature : <b></td> ";
			content=content+"</tr> ";
			content=content+"</table></td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td height='54'>&nbsp;</td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td height='54'>&nbsp;</td> ";
			content=content+"</tr> ";
			content=content+"</table> ";
		    content=content+"</p><br><br> <br> <br>  ";
		    
		    /* 
		      
		      cpanel : https://ns115.mochahost.com:2083/
		      Username: 	smartin1
		      Password: 	smartind
		      ftp : 204.93.157.98
		      
		    */

		    content=content+"<H1 COLOR='BLUE'> If you are accepting our offer then kindly acknowledge that <a href='"+com.my.org.erp.common.CommonFunctions.getPath(request)+"/Smart HRM/OfferAccept.jsp?applicantid="+applicantid+"&noticeperiod="+rowdata[0][26]+"&random="+rowdata[0][28]+"'>CLICK</a> </H1>";;
		    
			return content;
  	        
  	     
		}
		catch (Exception e )
		{
			
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
				
		}
		return content;	
	}








@SuppressWarnings("deprecation")
public void HRMOfferLettertoPDFs (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
{

		 	
		applicantid  =request.getParameter("applicantid");
		String content="";
		
		String subject="  ";
		try 
		{ 
			
			
			String applicantid=""+request.getParameter("applicantid");
			String pf ="";
			String esi ="";

			String sql=" ";
			 


			sql = "  SELECT g.INT_OFFERID,b.INT_APPID,b.CHR_APPCODE,b.CHR_APPNAME,b.CHR_APPFATHER,b.CHR_GENDER, 	 ";	  
			sql = sql +"  DATE_FORMAT(b.DT_DOB,'%d-%m-%Y'),b.CHR_EMAILID,b.CHR_MOBILE, b.CHR_PADD1,b.CHR_PADD2,f.CHR_CITYNAME,	 ";	  
			sql = sql +"  e.CHR_DISTRICT,d.CHR_STATENAME, c.CHR_COUNTRYNAME,b.INT_PPIN, a.CHR_JOBGRADE,a.CHR_JOBCODE,a.CHR_JOBTITLE ,	 ";	  
			sql = sql +"  g.DT_OFFERDATE, DATE_FORMAT(g.DT_OFFERDATE,'%d-%m-%Y'),CHR_PF,CHR_ESI ,	 ";	  
			sql = sql +"  h.CHR_CATEGORYNAME ,i.CHR_DESIGNAME,j.CHR_OFFICENAME,g.INT_NOTICEPERIOD,b.CHR_EMAILID	 ";	  
			sql = sql +"  FROM hrm_m_jobdesign a, hrm_m_application b , com_m_country c, com_m_state d,com_m_district e,	 ";	  
			sql = sql +"  com_m_city f ,hrm_t_offerletter g ,com_m_employeecategory h,com_m_desig i,com_m_office j	 ";	  
			sql = sql +"  WHERE a.INT_JOBID=b.INT_JOBID 	 ";	  
			sql = sql +"  AND b.INT_APPID= g.INT_APPID	 ";	  
			sql = sql +"  AND b.INT_PCOUNTRYID=c.INT_COUNTRYID 	 ";	  
			sql = sql +"  AND b.INT_PSTATE=d.INT_STATEID 	 ";	  
			sql = sql +"  AND b.INT_PDISTRICTID=e.INT_DISTRICTID	 ";	   
			sql = sql +"  AND b.INT_PCITY=f.INT_CITYID 	 ";	  
			sql = sql +"  AND g.INT_CATEGORY=h.INT_EMPLOYEECATEGORYID 	 ";	  
			sql = sql +"  AND g.INT_DESIGID=i.INT_DESIGID	 ";	  
			sql = sql +"  AND g.INT_OFFICEID=j.INT_OFFICEID	 ";	  
			sql = sql +"  AND b.INT_APPID="+applicantid;
			
            String rowdata[][]   =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);				
			String appointed=DateUtil.FormateDateSys(rowdata[0][19]);
			String app=com.my.org.erp.common.CommonFunctions.Appointmentyear(appointed);
			String id[]=app.split("~");				
			pf =rowdata[0][21];
			esi =rowdata[0][22];	
			
			subject="Offer Letter For "+rowdata[0][3];	
			
			
			content=content+" </td> ";
			content=content+" </tr> ";

			content=content+" <tr> ";
			content=content+" <td height='25'>&nbsp;</td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td height='54'> ";
			content=content+" <table width='100%' border='0' align='center' cellpadding='0' cellspacing='0'> ";
			          
			content=content+" <tr> ";
			content=content+" <td width='100%' height='20' colspan='2'><div align='center'><span class='boldgre'>OFFER LETTER </span></div></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td colspan='2'><div align='right'></div></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td colspan='2'></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td colspan='2'></td> ";
			content=content+"  </tr> ";
			content=content+" <tr> ";
			content=content+" <td height='19' colspan='2'><table width='100%' border='0' cellspacing='1' cellpadding='1'> ";
			content=content+" <tr> ";
			content=content+" <th width='720' height='21' scope='col'><div align='left'><span class='style11'> ";
			content=content+" <b>CARE/OFFER-"+rowdata[0][0]+"/"+rowdata[0][23]+"/ "+id[0] +"  <br/> ";
			content=content+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DATE_FORMAT(NOW(),'%d-%m-%Y')")[0][0];				  
			content=content+" </b></span></div></th> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <th scope='col'>&nbsp;</th> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <th scope='col'><div align='left'> ";
			content=content+" <span class='style11'> ";
			                      
			content=content+" <span class='boldgre'> To  ";
			content=content+" <br/> ";
			content=content+" Mr/Ms. "+ rowdata[0][3]+" ,<br/> ";
			content=content+rowdata[0][25] +" ,<br/> ";
			content=content+" </span> ";
			                       
			content=content+" </span></div></th> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <th scope='col'>&nbsp;</th> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <th height='85' scope='col'><div align='left'><span class='boldgre'> Dear. ";
			                     
			content=content+" Mr/Ms."+rowdata[0][3]+",</span>                    <br/> ";
			content=content+" &nbsp;&nbsp;&nbsp;&nbsp; We are pleased to offer the post of &nbsp;<span class='boldgre'>\" "+rowdata[0][24] +" \" </span>&nbsp;in our organisation at &nbsp; ";
			content=content+" <span class='boldgre'> \" "+rowdata[0][25] +" \" ";
			content=content+" </span>.&nbsp; <br>You are expected to join us on  or before&nbsp;<span class='boldgre'>";
			content=content+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DATE_FORMAT(DATE_ADD(now(), INTERVAL "+rowdata[0][26]+" DAY),'%d-%b-%Y')")[0][0]+" </span>&nbsp;  failing which this offer is not valid. Your salary details are as mentioned below.<br> </div></th> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <th scope='col'>&nbsp;</th> ";
			content=content+" </tr> ";
			content=content+" </table></td> ";
			content=content+" </tr> ";
			content=content+" </table>		 </td> ";
			content=content+" </tr> ";
				 
			content=content+" <tr> ";
			content=content+" <td height='54'> ";
			
			
			
			content=content+"<table width='100%' border='1' align='center' cellpadding='0' cellspacing='0' bordercolor='#000000'>";
			content=content+"<tr>";
			content=content+"<td>";




			content=content+"<TABLE  width='100%'  border='0' align='center' cellPadding='4' cellSpacing='4'>"; 
			content=content+" <TBODY>"; 
			content=content+"<TR>"; 
			content=content+"<TD   colSpan='7' align='center'><h1>Annexure</h1></TD>"; 
			content=content+"</TR>"; 
			
			content=content+"<TR bgcolor='#666666'   >"; 
			content=content+"<TD   colSpan='2'><p><strong>Particulars</strong></p></TD>"; 
			content=content+"<TD   ><p><strong>&nbsp;</strong></p></TD>"; 
			content=content+" <TD   ><p><strong>Amount</strong><strong>(P   M)</strong></p>                    </TD>"; 
			content=content+"<TD   <p><strong>&nbsp;</strong></p></TD>"; 
			content=content+"<TD   ><p><strong>Amount   (PA)</strong></p></TD>"; 
			content=content+"<TD   ><p><strong>&nbsp;</strong></p></TD>"; 
			content=content+"</TR>"; 
			
						  
							
			String AllowanceData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME  FROM pay_m_allowance WHERE CHR_FLAG='Y' ORDER BY INT_ALLOWANCEID");
			String salaryband="   ";
			String grossband="";
			for(int u=0; u<AllowanceData.length;u++)
			{
				salaryband = salaryband+"  a."+AllowanceData[u][0]+",( a."+AllowanceData[u][0]+" *12) ,"; 
				grossband = grossband+"  a."+AllowanceData[u][0]+"+";
			}	
			salaryband=salaryband.trim();
			salaryband = salaryband.substring(0,salaryband.length()-1);		
			
			grossband=grossband.trim();
			grossband = grossband.substring(0,grossband.length()-1);		
			
			sql = " SELECT ROUND(a.INT_BASIC),ROUND(INT_BASIC*12),"+salaryband+" ,ROUND(a.INT_BASIC+("+grossband+")),ROUND( (a.INT_BASIC+("+grossband+"))*12 ),ROUND(a.INT_BASIC*12/100) ,ROUND((a.INT_BASIC*12/100)*12),ROUND( (a.INT_BASIC+("+grossband+"))  + (a.INT_BASIC*12/100) ) , ROUND(( (a.INT_BASIC+("+grossband+"))  + (a.INT_BASIC*12/100) )*12),ROUND( (a.INT_BASIC+("+grossband+")) - (a.INT_BASIC*12/100) )  FROM hrm_m_application b,hrm_t_allowance a ";
			sql = sql +" 	WHERE a.INT_APPID = b.INT_APPID AND a.INT_APPID= "+applicantid+"  ";
			
			 
				
			String payData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			double monthbasic=0;
			double monthgross=0;
			double monthpf=0;
			double monthesi=0;
			double monthctc=0;
			
			double staffpf=0;
			double staffesi=0;
			double takehome=0;
			
			if(payData.length>0)
			{
				 content=content+"<TR bgcolor='CCCCCC'>";
				 content=content+"<TD vAlign='bottom'   colSpan='2'><p>Basic</p></TD>";
				 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
				 content=content+"<TD vAlign='bottom'    align='right'><p>"+payData[0][0]+"</p></TD>";
				 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
				 content=content+"<TD vAlign='bottom'   align='right'><p>"+payData[0][1]+"</p></TD>";
				 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
				 content=content+"</TR>";
				 int g=1;
				 int v=1;
				 for(int u=0; u<AllowanceData.length;u++)
				 {
					 g = g+2;
					 content=content+"<TR bgcolor='CCCCCC'>";
					 content=content+"<TD vAlign='bottom'  colSpan='2'><p> "+AllowanceData[u][1]+"</p></TD>";
					 content=content+"<TD vAlign='bottom'  >&nbsp;</TD>";
					 v=v+1;
					 content=content+"<TD vAlign='bottom'    align='right'><p> "+payData[0][v]+"</p></TD>";
					 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
					 v=v+1;
					 content=content+"<TD vAlign='bottom'   align='right'><p> "+payData[0][v]+"</p></TD>";
					 content=content+"<TD vAlign='bottom'  >&nbsp;</TD>";
					 content=content+"</TR>";
				}
				monthbasic=Double.parseDouble(payData[0][0]);
				monthgross=Double.parseDouble(payData[0][(g+1)]);
				
				 content=content+"<TR bgcolor='CCCCCC'>";
				 content=content+"<TD vAlign='bottom'    colSpan='2'><p>GROSS</p></TD>";
				 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
				 content=content+"<TD vAlign='bottom'    align='right'><p>"+Math.round(monthgross)+"</p></TD>";
				 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
				 content=content+"<TD vAlign='bottom'    align='right'><p>"+Math.round(monthgross*12)+"</p></TD>";
				 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
				 content=content+"</TR>"; 
					 
					 if("C".equals(pf))
					 {
						 monthpf = (monthbasic*12/100);
						 staffpf = (monthbasic*12/100);
						 content=content+"<TR bgcolor='CCCCCC'>";
						 content=content+"<TD vAlign='bottom'    colSpan='2'><p>EMPLOYEER PF</p></TD>";
						 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
						 content=content+"<TD vAlign='bottom'    align='right'><p>"+Math.round(monthpf)+"</p></TD>";
						 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
						 content=content+"<TD vAlign='bottom'   align='right'><p>"+Math.round(monthpf*12)+"</p></TD>";
						 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
						 content=content+"</TR>"; 
					 }	 
						  
					  
					  
					 if("C".equals(esi) && (monthgross <=15000))
					 { 
						 monthesi=(monthgross*4.75/100);
						 staffesi=(monthgross*1.75/100);
						 content=content+"<TR bgcolor='CCCCCC'>";
						 content=content+"<TD vAlign='bottom'   colSpan='2'><p>EMPLOYEER ESI</p></TD>";
						 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
						 content=content+"<TD vAlign='bottom'    align='right'><p>"+Math.round(monthesi)+"</p></TD>";
						 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
						 content=content+"<TD vAlign='bottom'    align='right'><p>"+Math.round(monthesi*12)+"</p></TD>";
						 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
						 content=content+"</TR>";
					}
					else
					{
						 monthesi=0;
						 staffesi=0;
						 content=content+"<TR bgcolor='CCCCCC'>";
						 content=content+"<TD vAlign='bottom'    colSpan='2'><p>ESI</p></TD>";
						 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
						 content=content+"<TD vAlign='bottom'   align='right'><p>0</p></TD>";
						 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
						 content=content+"<TD vAlign='bottom'    align='right'><p>0</p></TD>";
						 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
						 content=content+"</TR>"; 
					}	 
					 
					 monthctc=monthgross+monthpf+monthesi;
					 content=content+"<TR bgcolor='CCCCCC'>";
					 content=content+"<TD vAlign='bottom'   colSpan='2'><p>Total cost To Company   (TCTC</p></TD>";
					 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
					 content=content+"<TD vAlign='bottom'    align='right'><p>"+Math.round(monthctc )+"</p></TD>";
					 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
					 content=content+"<TD vAlign='bottom'     align='right'><p>"+Math.round(monthctc*12)+"</p></TD>";
					 content=content+"<TD vAlign='bottom'    >&nbsp;</TD>";
					 content=content+"</TR>"; 
					 
					 
					
					 
					 content=content+"<TR bgcolor='CCCCCC'>";
					 content=content+"<TD vAlign='bottom'    colSpan='2'><p>As Applicable to your   Current Role</p></TD>";
					 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
					 content=content+"<TD vAlign='bottom'    align='right'>&nbsp;</TD>";
					 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
					 content=content+"<TD vAlign='bottom'    align='right'>&nbsp;</TD>";
					 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
					 content=content+"</TR>"; 
					 
					 takehome=monthgross-(staffpf+staffesi);;
					 content=content+"<TR bgcolor='CCCCCC'>";
					 content=content+"<TD vAlign='bottom'    colSpan='2'><p><strong>Take Home  Salary=</strong><strong>"+Math.round(takehome)+"</strong><strong></strong></p></TD>";
					 content=content+"<TD vAlign='bottom'  >&nbsp;</TD>";
					 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
					 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
					 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
					 content=content+"<TD vAlign='bottom'   >&nbsp;</TD>";
					 content=content+"</TR>"; 
					 
				}
							
							content=content+"<TR >"; 
							content=content+"<TD ></TD>"; 
							content=content+"<TD ></TD>"; 
							content=content+"<TD ></TD>"; 
							content=content+"<TD ></TD>"; 
							content=content+"<TD </TD>"; 
							content=content+" <TD ></TD>"; 
							content=content+"<TD ></TD>"; 
							content=content+"</TR>"; 
							content=content+"</TBODY>"; 
							content=content+" </TABLE>"; 
					 
					 
					 
			content=content+"</td>";
			content=content+"</tr>";
			content=content+"</table>";

			 
			content=content+"<br>Your take home salary will be &nbsp; <span class='boldgre'>Rs."+Math.round(takehome)+"/-</span>  <br> </td>";
			content=content+"</tr>";
			content=content+"<tr>";
			content=content+"<td height='54'>";
			String pfData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT INT_PFAMT,INT_ESIAMT,INT_CPY_PFAMT,INT_CPY_PENSIONAMT,INT_CPY_ESIAMT,INT_PFLIMIT,INT_ESILIMIT,INT_PFLIMITMINIMUM,ROUND(INT_PFLIMITMINIMUM*INT_PFAMT/100) FROM m_institution WHERE INT_ID=1 ");
			if("C".equals(pf) && "C".equals(esi))
			{
				  content=content+"<br> PF will be deducted as per the minimum wages Act (the present level is Rs."+pfData[0][7]+"/-)(ie. MW Rs."+pfData[0][7]+"* "+pfData[0][0]+"%="+pfData[0][8]+"/-).(Basic -Employee Contribution of PF is "+pfData[0][0]+"%, Gross Contribution of ESIC "+pfData[0][1]+"%= Take home salary)."; 
				  content=content+"<br> <br>";
			}	
				
			String taxsql="SELECT INT_GTEQL,INT_LSEQL,DOU_PERCENTAGE,DOU_AMOUNT FROM pay_m_taxvalue ORDER BY INT_ID ";
			String taxdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(taxsql);
			double taxvalue=0.0;
				
			for(int t=0;t<taxdata.length;t++)
				if((monthgross >= Integer.parseInt(taxdata[t][0])) && (monthgross <= Integer.parseInt(taxdata[t][1])))
					taxvalue= taxvalue+Double.parseDouble(taxdata[t][3]);
												
													
			 
			content=content+"Rs."+taxvalue+"/- per month will be deducted for professional salary as per statutory.";
			content=content+"<br>";
			content=content+"</td>";
			content=content+"</tr>";
			content=content+"<tr>";
			content=content+"<td  >Please confirm that the above terms are acceptable to you and that you accept the offer by signing the copy of this letter. </td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >Please ensure that you bring the enclosed details attached with the offer letter at the time of joining. </td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >Wishing you the very best. </td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >&nbsp;</td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >&nbsp;</td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >Your sincerely </td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  > ";
			String cpyData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT CHR_NAME,CHR_ADD1,CHR_ADD2,CHR_CITY,CHR_STATE,INT_PINCODE,INT_PHONE,CHR_MAILID FROM m_institution WHERE INT_ID=1 ");
			content=content+"For "+cpyData[0][0]+" </td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >&nbsp;</td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >&nbsp;</td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >Authorised Signatory </td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >&nbsp;</td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >&nbsp;</td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >&nbsp;</td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >I Agree to accept the offer on terms and conditions mentioned in the above letter </td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  >&nbsp;</td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td  ><table width='100%' border='0' cellspacing='0' cellpadding='0'> ";
			content=content+"<tr>";
			content=content+"<td width='55%'><b> Date : "+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DATE_FORMAT(NOW(),'%d-%m-%Y')")[0][0]+" </b></td> ";
			content=content+"<td width='45%'><b>Signature : <b></td> ";
			content=content+"</tr> ";
			content=content+"</table></td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td height='54'>&nbsp;</td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td height='54'>&nbsp;</td> ";
			content=content+"</tr> ";
			content=content+"</table> ";
		    content=content+"</p><br> ";

		   
		    Document document=new Document();
		 	PdfWriter.getInstance(document,new FileOutputStream(request.getRealPath("/")+"uploadfiles/OfferLetter/"+subject+".pdf"));
		 	document.open();
		 	Image image = Image.getInstance (request.getRealPath("/")+"images/logo.jpg");
		 	document.add(new Paragraph(content));
		 	document.add(image);
		 	document.close();
  	     
		}
		catch (Exception e )
		{
			
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
				
		}
			
	}













@SuppressWarnings("deprecation")
public void HRMOfferLettertoPDF (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
{

		 
		String content="";
		String sql="";
		String subject="  ";
		try 
		{ 

			String applicantid=""+request.getParameter("applicantid");
			String pf ="";
			String esi ="";

			 
			sql = "  SELECT g.INT_OFFERID,b.INT_APPID,b.CHR_APPCODE,b.CHR_APPNAME,b.CHR_APPFATHER,b.CHR_GENDER, 	 ";	  
			sql = sql +"  DATE_FORMAT(b.DT_DOB,'%d-%m-%Y'),b.CHR_EMAILID,b.CHR_MOBILE, b.CHR_PADD1,b.CHR_PADD2,f.CHR_CITYNAME,	 ";	  
			sql = sql +"  e.CHR_DISTRICT,d.CHR_STATENAME, c.CHR_COUNTRYNAME,b.INT_PPIN, a.CHR_JOBGRADE,a.CHR_JOBCODE,a.CHR_JOBTITLE ,	 ";	  
			sql = sql +"  g.DT_OFFERDATE, DATE_FORMAT(g.DT_OFFERDATE,'%d-%m-%Y'),CHR_PF,CHR_ESI ,	 ";	  
			sql = sql +"  h.CHR_CATEGORYNAME ,i.CHR_DESIGNAME,j.CHR_OFFICENAME,g.INT_NOTICEPERIOD,b.CHR_EMAILID	 ";	  
			sql = sql +"  FROM hrm_m_jobdesign a, hrm_m_application b , com_m_country c, com_m_state d,com_m_district e,	 ";	  
			sql = sql +"  com_m_city f ,hrm_t_offerletter g ,com_m_employeecategory h,com_m_desig i,com_m_office j	 ";	  
			sql = sql +"  WHERE a.INT_JOBID=b.INT_JOBID 	 ";	  
			sql = sql +"  AND b.INT_APPID= g.INT_APPID	 ";	  
			sql = sql +"  AND b.INT_PCOUNTRYID=c.INT_COUNTRYID 	 ";	  
			sql = sql +"  AND b.INT_PSTATE=d.INT_STATEID 	 ";	  
			sql = sql +"  AND b.INT_PDISTRICTID=e.INT_DISTRICTID	 ";	   
			sql = sql +"  AND b.INT_PCITY=f.INT_CITYID 	 ";	  
			sql = sql +"  AND g.INT_CATEGORY=h.INT_EMPLOYEECATEGORYID 	 ";	  
			sql = sql +"  AND g.INT_DESIGID=i.INT_DESIGID	 ";	  
			sql = sql +"  AND g.INT_OFFICEID=j.INT_OFFICEID	 ";	  
			sql = sql +"  AND b.INT_APPID="+applicantid;
			
            String rowdata[][]   =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);				
			String appointed=DateUtil.FormateDateSys(rowdata[0][19]);
			String app=com.my.org.erp.common.CommonFunctions.Appointmentyear(appointed);
			String id[]=app.split("~");				
			pf =rowdata[0][21];
			esi =rowdata[0][22];	
			
			subject="Offer Letter For "+rowdata[0][3];	
			 
			


			String institutionData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT  INT_PFAMT,INT_ESIAMT,INT_ESILIMIT,INT_PFLIMIT,INT_PFLIMITMINIMUM ,INT_CPY_ESIAMT FROM m_institution WHERE INT_ID=1");
			double pfpercentage = Double.parseDouble( institutionData[0][0]);
			double esipercentage = Double.parseDouble( institutionData[0][1]);
			double esilimitamount = Double.parseDouble( institutionData[0][2]);
			double pfmaximumlimit = Double.parseDouble( institutionData[0][3]);
			double pfminimumlimit = Double.parseDouble( institutionData[0][4]);
			double esicomapnypercentage = Double.parseDouble( institutionData[0][5]);
			
				
             
            
            
			Document document=new Document();
			
			
			PdfWriter.getInstance(document,new FileOutputStream(request.getRealPath("/")+"uploadfiles/OfferLetter/"+subject+".pdf"));
			document.open();
			Image image = Image.getInstance (request.getRealPath("/")+"images/logo.jpg");
			image.setAlignment(1);
			document.add(image );
		     
			  
			Paragraph paragraph = new Paragraph(" \n OFFER LETTER\n ");
			paragraph.setAlignment(Element.ALIGN_CENTER);
			document.add(paragraph);
			
			 
			
			
			content="";
			content=content+"\nCARE/OFFER-"+rowdata[0][0]+"/"+rowdata[0][23]+"/ "+id[0] +" ";
			content=content+"\n"+ CommonFunctions.QueryExecute("SELECT DATE_FORMAT(NOW(),'%d-%b-%Y')")[0][0];				  
			content=content+"\nTo : ";
			content=content+"\nMr/Ms. "+ rowdata[0][3]+" , ";
			content=content+"\n"+rowdata[0][25] +",\n";
			content=content+"Dear. ";
			                     
			content=content+"Mr/Ms."+rowdata[0][3]+",\n";
			content=content+"We are pleased to offer the post of  \" "+rowdata[0][24] +" \"  in our organisation at   \" "+rowdata[0][25] +" \". ";
			content=content+"\nYou are expected to join us on  or before ";
			content=content+ CommonFunctions.QueryExecute("SELECT DATE_FORMAT(DATE_ADD(now(), INTERVAL "+rowdata[0][26]+" DAY),'%d-%b-%Y')")[0][0]+"   failing which this offer is not valid. Your salary details are as mentioned below.\n\n";
			 
			FontSelector fontselector = new FontSelector();
            fontselector.addFont(new Font(Font.TIMES_ROMAN, 7));
            fontselector.addFont(new Font(Font.ZAPFDINGBATS, 7));
            fontselector.addFont(new Font(Font.SYMBOL, 7));
            Phrase ph = fontselector.process(content);
			document.add(new Paragraph(ph));
			
			 

			PdfPTable table = new PdfPTable(3 );
			table.setWidthPercentage(100f);
			
			 
            ph = fontselector.process("ANNEXURE");
			PdfPCell cell = new PdfPCell (new Paragraph (new Paragraph(ph)));
			cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			cell.setColspan (3);
			 
			
			
			 
			cell.setBackgroundColor (new Color (128, 200, 128));
			cell.setPadding (1.0f);
			table.addCell (cell); 
			
			 
			 
			
			 
			PdfPCell c1 = new PdfPCell( new Paragraph(ph)  );
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("AMOUNT (PM)") )  );
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			
			c1 = new PdfPCell(new Paragraph(fontselector.process("AMOUNT (PA)") )  );
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			
			
			
			
			
						  
							
			String AllowanceData[][] = CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME  FROM pay_m_allowance WHERE CHR_FLAG='Y' ORDER BY INT_ALLOWANCEID");
			String salaryband="   ";
			String grossband="";
			for(int u=0; u<AllowanceData.length;u++)
			{
				salaryband = salaryband+"  a."+AllowanceData[u][0]+",( a."+AllowanceData[u][0]+" *12) ,"; 
				grossband = grossband+"  a."+AllowanceData[u][0]+"+";
			}	
			salaryband=salaryband.trim();
			salaryband = salaryband.substring(0,salaryband.length()-1);		
			
			grossband=grossband.trim();
			grossband = grossband.substring(0,grossband.length()-1);		
			
			sql = " SELECT ROUND(a.INT_BASIC),ROUND(INT_BASIC*12),"+salaryband+" ,ROUND(a.INT_BASIC+("+grossband+")),ROUND( (a.INT_BASIC+("+grossband+"))*12 ),ROUND(a.INT_BASIC*12/100) ,ROUND((a.INT_BASIC*12/100)*12),ROUND( (a.INT_BASIC+("+grossband+"))  + (a.INT_BASIC*12/100) ) , ROUND(( (a.INT_BASIC+("+grossband+"))  + (a.INT_BASIC*12/100) )*12),ROUND( (a.INT_BASIC+("+grossband+")) - (a.INT_BASIC*12/100) )  FROM hrm_m_application b,hrm_t_allowance a ";
			sql = sql +" 	WHERE a.INT_APPID = b.INT_APPID AND a.INT_APPID= "+applicantid+"  ";
			
			 
				
			String payData[][] = CommonFunctions.QueryExecute(sql);
			double monthbasic=0;
			double monthgross=0;
			double monthpf=0;
			double monthesi=0;
			double monthctc=0;
			
			double staffpf=0;
			double staffesi=0;
			double takehome=0;
			content="";
			if(payData.length>0)
			{
				
				 
				table.addCell(new PdfPCell(new Paragraph(fontselector.process("Basic") )  ));
				table.addCell(new PdfPCell(new Paragraph(fontselector.process(payData[0][0]) )  ));
				table.addCell(new PdfPCell(new Paragraph(fontselector.process(payData[0][1]) )  ));
				
				 	
				 
				 int g=1;
				 int v=1;
				 for(int u=0; u<AllowanceData.length;u++)
				 {
					 g = g+2;
					 
					 table.addCell(new PdfPCell(new Paragraph(fontselector.process(AllowanceData[u][1]) )  ));
					 
					 
					 v=v+1;
					 table.addCell(new PdfPCell(new Paragraph(fontselector.process(payData[0][v]) )  ));
					 
					 
					 v=v+1;
					 table.addCell(new PdfPCell(new Paragraph(fontselector.process(payData[0][v]) )  ));
					 
					 
					  
					 
					 
					 
				}
				monthbasic=Double.parseDouble(payData[0][0]);
				monthgross=Double.parseDouble(payData[0][(g+1)]);
				
				 
				table.addCell(new PdfPCell(new Paragraph(fontselector.process("GROSS") )  ));
				table.addCell(new PdfPCell(new Paragraph(fontselector.process(""+Math.round(monthgross)) )  ));
				table.addCell(new PdfPCell(new Paragraph(fontselector.process(""+Math.round(monthgross*12)) )  ));
				
				 
				 
				
				if("C".equals(pf))
				 {
					 
					if(monthbasic <= pfminimumlimit)
					{
						monthpf = (pfminimumlimit*pfpercentage/100); 
						staffpf = (pfminimumlimit*pfpercentage/100); 
					}
					else if( (monthbasic>pfminimumlimit)  && (monthbasic <=pfmaximumlimit))	
					{
						monthpf = (monthbasic*pfpercentage/100); 
						staffpf = (monthbasic*pfpercentage/100); 
					}
					else
					{
						monthpf = (pfmaximumlimit*pfpercentage/100);
						staffpf = (pfmaximumlimit*pfpercentage/100);
					}	
			
				}
				else
				{
					monthpf = 0;
					staffpf = 0;
				}
				
				table.addCell(new PdfPCell(new Paragraph(fontselector.process("EMPLOYEER PF" ) )  ));
				table.addCell(new PdfPCell(new Paragraph(fontselector.process(""+Math.round(monthpf)) )  ));
				table.addCell(new PdfPCell(new Paragraph(fontselector.process(""+Math.round(monthpf*12)) )  ));
							
				
				if("C".equals(esi) && monthgross <=esilimitamount)
				 {
						monthesi=(monthgross*esicomapnypercentage/100);
						staffesi=(monthgross*esipercentage/100);
				 }
				 else
				 {
						monthesi=0;
					 	staffesi=0;
				 }
				 table.addCell(new PdfPCell(new Paragraph(fontselector.process("EMPLOYEER ESI" ) )  ));
				 table.addCell(new PdfPCell(new Paragraph(fontselector.process(""+Math.round(monthesi)) )  ));
				 table.addCell(new PdfPCell(new Paragraph(fontselector.process(""+Math.round(monthesi*12)) )  ));
				   
				 monthctc=monthgross+monthpf+monthesi;
				 table.addCell(new PdfPCell(new Paragraph(fontselector.process("Total cost To Company   ( CTC )" ) )  ));
				 table.addCell(new PdfPCell(new Paragraph(fontselector.process(""+Math.round(monthctc) ) )  ));
				 table.addCell(new PdfPCell(new Paragraph(fontselector.process(""+Math.round(monthctc*12) ) )  ));
				 
				 cell.setColspan (3);
				 table.addCell(new PdfPCell(new Paragraph(fontselector.process("As Applicable to your   Current Role" ) )  ));
				 table.addCell(new PdfPCell(new Paragraph(fontselector.process(""  ) )  ));
				 table.addCell(new PdfPCell(new Paragraph(fontselector.process(""  ) )  ));
				 
				 takehome=monthgross-(staffpf+staffesi);;
				 
				  
				 cell.setColspan (3);
				 table.addCell(new PdfPCell(new Paragraph(fontselector.process("Take Home  Salary = "+Math.round(takehome) ) )  ));
				 table.addCell(new PdfPCell(new Paragraph(fontselector.process(""  ) )  ));
				 table.addCell(new PdfPCell(new Paragraph(fontselector.process(""  ) )  ));
				 	 
				}
			 table.addCell("");
			 table.addCell(" ");
			  
			 
			  

			
			
			
			document.add(table);
			
			
			
			
			
			
			
			
			 
			content="\nYour take home salary will be  Rs."+Math.round(takehome)+"/- ";
			 
			String pfData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT INT_PFAMT,INT_ESIAMT,INT_CPY_PFAMT,INT_CPY_PENSIONAMT,INT_CPY_ESIAMT,INT_PFLIMIT,INT_ESILIMIT,INT_PFLIMITMINIMUM,ROUND(INT_PFLIMITMINIMUM*INT_PFAMT/100) FROM m_institution WHERE INT_ID=1 ");
			if("C".equals(pf) && "C".equals(esi))
			{
				  content=content+"\nPF will be deducted as per the minimum wages Act (the present level is Rs."+pfData[0][7]+"/-)(ie. MW Rs."+pfData[0][7]+"* "+pfData[0][0]+"%="+pfData[0][8]+"/-).(Basic -Employee Contribution of PF is "+pfData[0][0]+"%, Gross Contribution of ESIC "+pfData[0][1]+"%= Take home salary)."; 
				  content=content+"\n";
			}	
				
			String taxsql="SELECT INT_GTEQL,INT_LSEQL,DOU_PERCENTAGE,DOU_AMOUNT FROM pay_m_taxvalue ORDER BY INT_ID ";
			String taxdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(taxsql);
			double taxvalue=0.0;
				
			for(int t=0;t<taxdata.length;t++)
				if((monthgross >= Integer.parseInt(taxdata[t][0])) && (monthgross <= Integer.parseInt(taxdata[t][1])))
					taxvalue= taxvalue+Double.parseDouble(taxdata[t][3]);
												
													
			 
			content=content+"Rs."+taxvalue+"/- per month will be deducted for professional salary as per statutory.  \n    ";
			 
			content=content+"\nPlease confirm that the above terms are acceptable to you and that you accept the offer by signing the copy of this letter.   ";
			content=content+"\nPlease ensure that you bring the enclosed details attached with the offer letter at the time of joining.   ";
			 
			content=content+"\nWishing you the very best.  ";
			 
			 
			content=content+"\nYour sincerely  \n";
			 
			String cpyData[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(" SELECT CHR_NAME,CHR_ADD1,CHR_ADD2,CHR_CITY,CHR_STATE,INT_PINCODE,INT_PHONE,CHR_MAILID FROM m_institution WHERE INT_ID=1 ");
			content=content+"\n For "+cpyData[0][0]+"   ";
			 
			content=content+"\n\nAuthorised Signatory   ";
			 
			
			fontselector = new FontSelector();
            fontselector.addFont(new Font(Font.TIMES_ROMAN, 7));
            fontselector.addFont(new Font(Font.ZAPFDINGBATS, 7));
            fontselector.addFont(new Font(Font.SYMBOL, 7));
            ph = fontselector.process(content);
			document.add(new Paragraph(ph));
		   
			
			content="\nI Agree to accept the offer on terms and conditions mentioned in the above letter   \n";
			 
			content=content+"\n\nDate : "+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DATE_FORMAT(NOW(),'%d-%m-%Y')")[0][0]+"   ";
			content=content+"                                                              Signature ";
			 

		 	
			paragraph = new Paragraph(content);
			paragraph.setAlignment(Element.ALIGN_JUSTIFIED_ALL );
			document.add(paragraph);
			
			document.close(); 
			document.close(); 
			redirectlink= "uploadfiles/OfferLetter/"+subject+".pdf" ;
			//response.sendRedirect("OfferLetter/"+subject+".pdf"  );
			
		}
		catch (Exception e )
		{
			
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
				
		}
			
	}














public void SendOfferLetterApprovalMail (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
{

		applicantid  =request.getParameter("applicantid");
		String content="";
		String to=""+CommonData.mailid;
		String subject="   ";
		try 
		{ 
			 			
			String applicantid=""+request.getParameter("applicantid");
			 
			asql = " SELECT  b.CHR_APPCODE,b.CHR_APPNAME,b.CHR_APPFATHER,b.CHR_GENDER, "; 
			asql = asql + " DATE_FORMAT(b.DT_DOB,'%d-%b-%Y'),b.CHR_EMAILID,b.CHR_MOBILE,   a.CHR_JOBGRADE,a.CHR_JOBCODE,a.CHR_JOBTITLE , "; 
			asql = asql + "   DATE_FORMAT(g.DT_OFFERDATE,'%d-%b-%Y'),  h.CHR_CATEGORYNAME ,i.CHR_DESIGNAME, "; 
			asql = asql + " j.CHR_OFFICENAME,g.INT_NOTICEPERIOD,b.CHR_EMAILID   "; 
			asql = asql + " FROM hrm_m_jobdesign a, hrm_m_application b , com_m_country c, com_m_state d,com_m_district e, com_m_city f , "; 
			asql = asql + " hrm_t_offerletter g ,com_m_employeecategory h,com_m_desig i,com_m_office j "; 
			asql = asql + " WHERE a.INT_JOBID=b.INT_JOBID AND b.INT_APPID= g.INT_APPID  "; 
			asql = asql + " AND b.INT_PCOUNTRYID=c.INT_COUNTRYID AND b.INT_PSTATE=d.INT_STATEID  "; 
			asql = asql + " AND b.INT_PDISTRICTID=e.INT_DISTRICTID AND b.INT_PCITY=f.INT_CITYID  "; 
			asql = asql + " AND g.INT_CATEGORY=h.INT_EMPLOYEECATEGORYID  "; 
			asql = asql + " AND g.INT_DESIGID=i.INT_DESIGID AND g.INT_OFFICEID=j.INT_OFFICEID  "; 
			asql = asql + " AND g.CHR_ACCEPT = 'Y' AND b.INT_APPID="+applicantid; 
			String rowdata[][]   =CommonFunctions.QueryExecute(asql);
			
			subject=" APPROVAL THE CARE OFFER FOR "+rowdata[0][0]+"/"+rowdata[0][1];
			
			content = content + " <table width='652' border='1' cellpadding='0' cellspacing='0' bordercolor='#3399CC' bgcolor='#3399CC'> ";
			content = content + " <tr> ";
			content = content + " <td width='648'><h3 align='center'>APPROVAL THE CARE OFFER  </h3></td> ";
			content = content + " </tr> ";
			content = content + " <tr> ";
			content = content + " <td bgcolor='#FFFFFF'><div align='center'> ";
			content = content + " <table border='0' cellspacing='4' cellpadding='0' width='400'> ";
			content = content + " <tr> ";
			content = content + " <td width='157'><p>Applicant Code </p></td> ";
			content = content + " <td width='231'><p>"+rowdata[0][0]+" </p></td> ";
			content = content + "  </tr> ";
			content = content + " <tr> ";
			content = content + " <td><p>Applicant Name </p></td> ";
			content = content + " <td><p>"+rowdata[0][1]+" </p></td> ";
			content = content + " </tr> ";
			content = content + " <tr> ";
			content = content + " <td><p>Father Name </p></td> ";
			content = content + " <td><p>"+rowdata[0][2]+"</p></td> ";
			content = content + " </tr> ";
			content = content + " <tr> ";
			content = content + " <td><p>Gender </p></td> ";
			content = content + " <td><p>"+rowdata[0][3]+" </p></td> ";
			content = content + " </tr> ";
			content = content + " <tr> ";
			content = content + " <td><p>Date of Birth  </p></td> ";
			content = content + " <td><p>"+rowdata[0][4]+" </p></td> ";
			content = content + " </tr> ";
			content = content + " <tr> ";
			content = content + " <td>Per - Email </td> ";
			content = content + " <td>"+rowdata[0][5]+"</td> ";
			content = content + " </tr> ";
			content = content + " <tr> ";
			content = content + " <td>Mobile</td> ";
			content = content + " <td>"+rowdata[0][6]+"</td> ";
			content = content + " </tr> ";
			content = content + " <tr> ";
			content = content + " <td>Job Grade </td> ";
			content = content + " <td>"+rowdata[0][7]+"</td> ";
			content = content + " </tr> ";
			content = content + " <tr> ";
			content = content + " <td>Job Code </td> ";
			content = content + " <td>"+rowdata[0][8]+"</td> ";
			content = content + " </tr> ";
			content = content + " <tr> ";
			content = content + " <td>Job Title </td> ";
			content = content + " <td>"+rowdata[0][9]+"</td> ";
			content = content + " </tr> ";
			content = content + " <tr> ";
			content = content + " <td>Offer Date </td> ";
			content = content + " <td>"+rowdata[0][10]+"</td> ";
			content = content + " </tr> ";
			content = content + " <tr> ";
			content = content + " <td>Offer Valid Upto </td> ";
			content = content + " <td>"+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DATE_FORMAT(DATE_ADD(now(), INTERVAL "+rowdata[0][14]+" DAY),'%d-%b-%Y')")[0][0]+"</td> ";
			content = content + " </tr> ";
			
			content = content + " <tr> ";
			content = content + " <td>Approval Date </td> ";
			content = content + " <td>"+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT DATE_FORMAT(now()   ,'%d-%b-%Y' ) ")[0][0]+"</td> ";
			content = content + " </tr> ";
			
			content = content + " <tr> ";
			content = content + " <td>Category</td> ";
			content = content + " <td>"+rowdata[0][11]+"</td> ";
			content = content + " </tr> ";
			content = content + " <tr> ";
			content = content + " <td>Designation</td> ";
			content = content + " <td>"+rowdata[0][12]+"</td> ";
			content = content + " </tr> ";
			content = content + " <tr> ";
			content = content + " <td>Office</td> ";
			content = content + " <td>"+rowdata[0][13]+"</td> ";
			content = content + " </tr> ";
			
			content = content + " <tr> ";
			content = content + " <td>Confirmation Description </td> ";
			content = content + " <td>"+request.getParameter("comments") +"</td> ";
			content = content + " </tr> ";
			
			content = content + " </table> ";
			content = content + " </div></td> ";
			content = content + " </tr> ";
			content = content + " <tr> ";
			content = content + " <td> </td> ";
			content = content + " </tr> ";
			content = content + " </table> ";
			 
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
  	         
  	        
  	        
  	        Session mailSession = Session.getDefaultInstance(props, null);
  	        mailSession.setDebug(true);
  	        Transport transport = mailSession.getTransport();
  	        MimeMessage message = new MimeMessage(mailSession);
  	        message.setSubject(subject);
  	        message.setFrom(new InternetAddress(""+maild));
  	        message.setContent(content, "text/html");
  	        message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
  	        transport.connect();
  	        transport.sendMessage(message, message.getRecipients(Message.RecipientType.TO));
  	        transport.close();
  	        
  	     
		}
		catch (Exception e )
		{
			 
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
				
		}
			
	}










}
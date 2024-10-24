package com.my.org.erp.SmartPayroll;

 
import java.io.IOException;
 
import java.math.BigDecimal;
 


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

 
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
 
 
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.FontSelector;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
 
import com.lowagie.text.pdf.PdfWriter;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;

public class PFActionHandler extends AbstractActionHandler 
{
	 
	 

	 
	
	public void handle(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			  
			if (action.equals("PAYPFMonthly")) 
			{
				PAYPFMonthly(request , response);
		 	}
			else if (action.equals("PAYForm5")) 
			{
				Form5(request , response);
		 	}
			else if (action.equals("PAYForm10")) 
			{
				Form10(request , response);
		 	}
			else if (action.equals("PAYForm6A")) 
			{
				Form6A(request , response);
		 	} 
			else if (action.equals("PAYForm3A")) 
			{
				Form3A(request , response);
		 	} 
			
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
		}
	}

	
	
	

	private void Form10(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		try
		{         
			
			Document document = new Document(); 
			document.addAuthor("CARE");
			document.addCreationDate();
			document.addCreator("SmartCampus");
			document.addTitle("PF FORM 10PDF");
			
			
			 
			 
			String sql="";
	   		String month=request.getParameter("Month");
			String year=request.getParameter("Year");
			String comid=request.getParameter("company");
			String branchid=request.getParameter("branch");
			String officeid=request.getParameter("Office");
			
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment;filename=\"PF Form10_" +month+ "_"+year+ ".pdf\"");
			
			//response.setContentType("application/pdf");
			PdfWriter.getInstance(document, response.getOutputStream());
			document.open();
			/*Image image = Image.getInstance (request.getRealPath("/")+"images/logo.jpg");
			image.setAlignment(1);
			document.add(image );
*/
			 
			 
            
			    
			    
			FontSelector fontselector = new FontSelector();
            fontselector.addFont(new Font(Font.TIMES_ROMAN, 10));
            fontselector.addFont(new Font(Font.ZAPFDINGBATS, 10));
            fontselector.addFont(new Font(Font.SYMBOL, 10));
			
			 
			
			
			Phrase ph = fontselector.process("\nFORM-10\n ");
			Paragraph paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_CENTER);
			document.add(paragraph);
			 
			fontselector = new FontSelector();
            fontselector.addFont(new Font(Font.TIMES_ROMAN, 9));
            fontselector.addFont(new Font(Font.ZAPFDINGBATS, 9));
            fontselector.addFont(new Font(Font.SYMBOL, 9));
			
			
            sql = " SELECT a.CHR_COMPANYNAME,a.CHR_STREET,f.CHR_CITYNAME,a.INT_PINCODE,a.CHR_PFNUMBER, ";
        	sql = sql + " c.CHR_COUNTRYNAME,d.CHR_STATENAME,e.CHR_DISTRICT,f.CHR_CITYNAME  ";
        	sql = sql + " FROM com_m_company a, com_m_country c, com_m_state d, com_m_district e, com_m_city f ";
        	sql = sql + " WHERE a.INT_COUNTRYID= c.INT_COUNTRYID ";
        	sql = sql + " AND a.INT_STATEID = d.INT_STATEID ";
        	sql = sql + " AND a.INT_DISTRICTID = e.INT_DISTRICTID ";
        	sql = sql + " AND a.INT_CITYID = f.INT_CITYID ";
        	sql = sql + " AND a.INT_COMPANYID="+comid;
        	String datac[][]=CommonFunctions.QueryExecute(sql);
			String content="";
			content=content+"\n Return of the members leaving service during the month - "+com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(month)) + " - " +year+"  " ;
			content=content+"\n Name & address of the Factory / Establishment : "+datac[0][0]+","+ datac[0][1] +","+datac[0][2]+"-"+ datac[0][3]+" \n\n "  ;
			 
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_JUSTIFIED);
			document.add(paragraph);
			 
			
			
			
			
			
			PdfPTable table = new PdfPTable(7 );
			table.setWidthPercentage(100f);
			
			 
			PdfPCell c1 = new PdfPCell(new Paragraph(fontselector.process("Sl.No")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell( new Paragraph(fontselector.process("Account No ")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("Name Of the Employee(in block Capitals) ")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("Father's Name(or husband's name incase married woman) ")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("Date of leaving service")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("Reason for leaving service ")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("Remarks")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			
			
			c1 = new PdfPCell(new Paragraph(fontselector.process("( 1 )")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell( new Paragraph(fontselector.process("( 2 )")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("( 3 ) ")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("( 4 ) ")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("( 5 )")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("( 6 ) ")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("( 7 )")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			
			
			 
				 
			sql="select a.CHR_EMPID,b.CHR_STAFFNAME,DATE_FORMAT(b.DAT_RESIGNDATE,'%d-%m-%Y'),a.CHR_TER_TYPE,b.CHR_STAFFFNAME,b.CHR_PFNO,DATE_FORMAT(b.DAT_RESIGNDATE,'%d-%m-%Y') from pay_m_emp_termination a,com_m_staff b";
		    sql=sql+ " where  b.CHR_ESI ='C' AND  b.CHR_PF='C'  AND  a.CHR_EMPID=b.CHR_EMPID";
		    if(!"-1".equals(comid))
				sql=sql+ " AND b.INT_COMPANYID = "+comid;
			
			if(!"-1".equals(branchid))
				sql=sql+ " AND b.INT_BRANCHID = "+branchid;
			
			if(!"0".equals(officeid))
				sql=sql+ " AND b.INT_OFFICEID = "+officeid;
			sql=sql+" and month(b.DAT_RESIGNDATE)="+month+" and year(b.DAT_RESIGNDATE)="+year+" order by a.CHR_EMPID";
			System.out.println(sql);
		    String data[][]=CommonFunctions.QueryExecute(sql);
		    String s="";
		    for(int i=0;i<data.length;i++)
			{
		    	s= (!"0".equals(data[i][5]))  ? data[i][5]  : "" ;
		    	table.addCell(new Paragraph(fontselector.process( (i+1)+".") ));;
				table.addCell(new Paragraph(fontselector.process(""+    s      )));
				table.addCell(new Paragraph(fontselector.process(data[i][1])));
				table.addCell(new Paragraph(fontselector.process(data[i][4])));
				table.addCell(new Paragraph(fontselector.process(data[i][2])));
				table.addCell(new Paragraph(fontselector.process("RESIGNED..." )));
				table.addCell("");
				 
				 
			}
		    document.add(table);
		    
			content= "\n* Please state whether the member is (a) retiring according to para 69 (1) or (b) of the Sheme: (b) leaving India for permenant settlement abroad : © reterenchment: (d) discharge: (e) resigning from or leaving service: (f) taking up employment elsewhere (The Name & address of the Employers shold be stated): (g) Date of Death A member, on attaining the age of 58, is ceased to be a member of EPS-95 Subject to eligibility he may apply for drawal of pension\n";
			 
			
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_JUSTIFIED);
			document.add(paragraph);
			
			
			 
			 
			content= "\n\nDate: "+com.my.org.erp.ServiceLogin.DateUtil.getCurrentDate() ;
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_LEFT);
			document.add(paragraph);
			

			content= "    Signature of the employer       ";
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_RIGHT);
			document.add(paragraph);
			 
			
			content= "\n\n\nStamp of the Factroy/Establishment";
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_RIGHT);
			document.add(paragraph);
			
			document.close(); 
			 
		}
		catch(Exception e)
		{         
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
			
		}     
		
	}
	 
	
	

	private void PAYPFMonthly(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		try
		{         
			
			Document document = new Document(); 
			document.addAuthor("CARE");
			document.addCreationDate();
			document.addCreator("SmartCampus");
			document.addTitle("PF FORM MONTHLY PDF");
			
			String sql="";
			String company="";
			String branch="";
			String Office="";
			String Month="";
			String Year="";
			company = request.getParameter("company");
			branch = request.getParameter("branch");
			Office = request.getParameter("Office");
			Month = request.getParameter("Month");
			Year = request.getParameter("Year");
			String repmon = com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt( Month));
			
			
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment;filename=\"PF Form5_" +repmon+ "_"+Year+ ".pdf\"");
			PdfWriter.getInstance(document, response.getOutputStream());
			document.open();
			 
			
			sql ="SELECT a.CHR_EMPID,a.CHR_EMPNAME ,d.CHR_COMPANYNAME,e.CHR_BRANCHNAME,c.CHR_OFFICENAME, ";
			sql = sql +" CONCAT(d.CHR_PFNUMBER,b.CHR_PFNO),ROUND(a.DOU_BASIC),ROUND(a.DOU_PENBASIC),ROUND(a.DOU_PF), ";
			sql = sql +" ROUND(a.DOU_COMPANYPF),ROUND(a.DOU_COMPANYPENSION), ";
			sql = sql +" ROUND(a.DOU_ADMINCHARGE),ROUND(a.DOU_EDLI),ROUND(a.DOU_ADMINCHARGE1),DATE_FORMAT(b.DAT_PFESIDATE,'%d-%b-%Y'),ROUND(DOU_WORKDAYS) ";
			sql = sql +" FROM pay_t_salary a ,com_m_staff b, com_m_office  c,com_m_company d,com_m_branch e ";
			sql = sql +" WHERE a.CHR_EMPID = b.CHR_EMPID ";
			sql = sql +" AND b.INT_OFFICEID = c.INT_OFFICEID ";
			sql = sql +" AND b.INT_COMPANYID=d.INT_COMPANYID ";
			sql = sql +" AND b.INT_BRANCHID=e.INT_BRANCHID AND a.CHR_PF !='N'  ";
			 
			sql = sql +" AND b.INT_COMPANYID=  "+company;
			if(!"0".equals(branch))
				sql = sql +" AND b.INT_BRANCHID=  "+branch;
			if(!"0".equals(Office))
				sql = sql +" AND b.INT_OFFICEID=  "+Office;
			sql = sql +" AND a.INT_YEAR= "+Year;
			sql = sql +" AND a.CHR_MONTH='"+repmon+"' ";
			 
			sql = sql +" ORDER BY b.CHR_PFNO ";  
			 
		  
			String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			String cpdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT upper(CHR_COMPANYNAME) FROM com_m_company where INT_COMPANYID =" +company);
			
			
			FontSelector fontselector = new FontSelector();
            fontselector.addFont(new Font(Font.TIMES_ROMAN, 8));
            fontselector.addFont(new Font(Font.ZAPFDINGBATS, 8));
            fontselector.addFont(new Font(Font.SYMBOL, 8));
			
			 
			
			
			Phrase ph = fontselector.process(cpdata[0][0]+"  -  PF REPORT FOR THE MONTH OF "+repmon+"-"+Year +"\n\n");
			Paragraph paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_CENTER);
			document.add(paragraph);
			 
			fontselector = new FontSelector();
            fontselector.addFont(new Font(Font.TIMES_ROMAN, 7));
            fontselector.addFont(new Font(Font.ZAPFDINGBATS, 7));
            fontselector.addFont(new Font(Font.SYMBOL, 7));
			
			double sum1=0;
			double sum2=0;
			double sum3=0;
			double sum4=0;
			double sum5=0;
			double sum6=0;
			double sum7=0;
			double sum8=0;
		    if(data.length>0)
			{
		    	PdfPTable table = new PdfPTable(16 );
				table.setWidthPercentage(100f);
				
				 
				PdfPCell c1 = new PdfPCell(new Paragraph(fontselector.process("Sl.No")));
				c1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(c1);
				c1 = new PdfPCell( new Paragraph(fontselector.process("Employee Id ")));
				c1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(c1);
				c1 = new PdfPCell(new Paragraph(fontselector.process("Employee Name) ")));
				c1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(c1);
				c1 = new PdfPCell(new Paragraph(fontselector.process("Branch ")));
				c1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(c1);
				c1 = new PdfPCell(new Paragraph(fontselector.process("Office")));
				c1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(c1);
				c1 = new PdfPCell(new Paragraph(fontselector.process("PF Date of Joinning ")));
				c1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(c1);
				c1 = new PdfPCell(new Paragraph(fontselector.process("PF Number")));
				c1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(c1);
				c1 = new PdfPCell(new Paragraph(fontselector.process("No of Working Days")));
				c1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(c1);
				c1 = new PdfPCell(new Paragraph(fontselector.process("PF Wages")));
				c1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(c1);
				c1 = new PdfPCell(new Paragraph(fontselector.process("Pen Wages ")));
				c1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(c1);
				c1 = new PdfPCell(new Paragraph(fontselector.process("Employee Contri(12%)")));
				c1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(c1);
				c1 = new PdfPCell(new Paragraph(fontselector.process("Employer PF Contri(3.67%)")));
				c1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(c1);
				c1 = new PdfPCell(new Paragraph(fontselector.process("Employer Pension Contri(8.33%)")));
				c1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(c1);
				c1 = new PdfPCell(new Paragraph(fontselector.process("Charges(1.1%)")));
				c1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(c1);
				c1 = new PdfPCell(new Paragraph(fontselector.process(" EDLI Charges(0.5%) ")));
				c1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(c1);
				c1 = new PdfPCell(new Paragraph(fontselector.process("ADMIN Charges(0.01%)")));
				c1.setHorizontalAlignment(Element.ALIGN_CENTER);
				table.addCell(c1);
				
				
				for(int u=0;u<data.length;u++)
				{
					table.addCell(new Paragraph(fontselector.process( (u+1)+".") ));;
					table.addCell(new Paragraph(fontselector.process(data[u][0] )));
					table.addCell(new Paragraph(fontselector.process(data[u][1] )));
					table.addCell(new Paragraph(fontselector.process(data[u][3] )));
					table.addCell(new Paragraph(fontselector.process(data[u][4] )));
					table.addCell(new Paragraph(fontselector.process(data[u][14]))); 
					table.addCell(new Paragraph(fontselector.process(data[u][5]))); 
					table.addCell(new Paragraph(fontselector.process(data[u][15]))); 
					table.addCell(new Paragraph(fontselector.process(data[u][6] )));
					table.addCell(new Paragraph(fontselector.process(data[u][7])));
					table.addCell(new Paragraph(fontselector.process(data[u][8] )));
					table.addCell(new Paragraph(fontselector.process(data[u][9] )));
					table.addCell(new Paragraph(fontselector.process(data[u][10]))); 
					table.addCell(new Paragraph(fontselector.process(data[u][11] )));
					table.addCell(new Paragraph(fontselector.process(data[u][12]))); 
					table.addCell(new Paragraph(fontselector.process(data[u][13]))); 
					
					
					sum1 = sum1+Double.parseDouble(data[u][6]);
					sum2 = sum2+Double.parseDouble(data[u][7]);
					sum3 = sum3+Double.parseDouble(data[u][8]);
					sum4 = sum4+Double.parseDouble(data[u][9]);
					sum5 = sum5+Double.parseDouble(data[u][10]);
					sum6 = sum6+Double.parseDouble(data[u][11]);
					sum7 = sum7+Double.parseDouble(data[u][12]);
					sum8 = sum8+Double.parseDouble(data[u][13]);
					 
				}
				table.addCell(new Paragraph(fontselector.process( "") ));;
				table.addCell(new Paragraph(fontselector.process( "") ));;
				table.addCell(new Paragraph(fontselector.process( "") ));;
				table.addCell(new Paragraph(fontselector.process( "") ));;
				table.addCell(new Paragraph(fontselector.process( "") ));;
				table.addCell(new Paragraph(fontselector.process( "") ));;
				table.addCell(new Paragraph(fontselector.process( "") ));;
				table.addCell(new Paragraph(fontselector.process( "Total") ));;
				table.addCell(new Paragraph(fontselector.process( ""+com.my.org.erp.common.CommonFunctions.Round(sum1)) ));;
				table.addCell(new Paragraph(fontselector.process( ""+com.my.org.erp.common.CommonFunctions.Round(sum2)) ));;
				table.addCell(new Paragraph(fontselector.process( ""+com.my.org.erp.common.CommonFunctions.Round(sum3)) ));;
				table.addCell(new Paragraph(fontselector.process( ""+com.my.org.erp.common.CommonFunctions.Round(sum4)) ));;
				table.addCell(new Paragraph(fontselector.process( ""+com.my.org.erp.common.CommonFunctions.Round(sum5)) ));;
				table.addCell(new Paragraph(fontselector.process( ""+com.my.org.erp.common.CommonFunctions.Round(sum6)) ));;
				table.addCell(new Paragraph(fontselector.process( ""+com.my.org.erp.common.CommonFunctions.Round(sum7)) ));;
				table.addCell(new Paragraph(fontselector.process( ""+com.my.org.erp.common.CommonFunctions.Round(sum8)) ));;
				 
 
				document.add(table);
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
	 
	
	
	
	
	
	
	

	private void Form5(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		try
		{         
			
			
			String sql="";
	   		String month=request.getParameter("Month");
			String year=request.getParameter("Year");
			String comid=request.getParameter("company");
			String branchid=request.getParameter("branch");
			String officeid=request.getParameter("Office");
			
			Document document = new Document(); 
			document.addAuthor("CARE");
			document.addCreationDate();
			document.addCreator("SmartCampus");
			document.addTitle("PF-FORM-5vPDF");
			
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment;filename=\"PF Form5_" +month+ "_"+year+ ".pdf\"");
			//response.setContentType("application/octet-stream");
			PdfWriter.getInstance(document, response.getOutputStream());
			
			document.open();
			 
			 
			
			    
			FontSelector fontselector = new FontSelector();
            fontselector.addFont(new Font(Font.TIMES_ROMAN, 10));
            fontselector.addFont(new Font(Font.ZAPFDINGBATS, 10));
            fontselector.addFont(new Font(Font.SYMBOL, 10));
			
			
			Phrase ph = fontselector.process("\nFORM-5");
			Paragraph paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_CENTER);
			document.add(paragraph);
			 
			
			
	  		sql = " SELECT a.CHR_COMPANYNAME,a.CHR_STREET,f.CHR_CITYNAME,a.INT_PINCODE,a.CHR_PFNUMBER, ";
	  		sql = sql + " c.CHR_COUNTRYNAME,d.CHR_STATENAME,e.CHR_DISTRICT,f.CHR_CITYNAME  ";
	  		sql = sql + " FROM com_m_company a, com_m_country c, com_m_state d, com_m_district e, com_m_city f ";
	  		sql = sql + " WHERE a.INT_COUNTRYID= c.INT_COUNTRYID ";
	  		sql = sql + " AND a.INT_STATEID = d.INT_STATEID ";
	  		sql = sql + " AND a.INT_DISTRICTID = e.INT_DISTRICTID ";
	  		sql = sql + " AND a.INT_CITYID = f.INT_CITYID ";
	  		sql = sql + " AND a.INT_COMPANYID="+comid;
	  		String datac[][]=CommonFunctions.QueryExecute(sql);
	  		
	  			
				
			
			String content="\nTHE EMPLOYEES' PROVIDENT FUND AND THE EMPLOYEES' PENSION SCHEME,1995";
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_CENTER);
			document.add(paragraph);
			
			content="\nEstablishment Code : "+datac[0][4];
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_CENTER);
			document.add(paragraph);
			
			content="\nName & address of the Factory / Establishment : "+datac[0][0]+","+ datac[0][1] +","+datac[0][2]+"-"+ datac[0][3]+" \n"  ;
			 
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_CENTER);
			document.add(paragraph);
			 
			
			content="\nMonth :  "+com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(month))+" /  Year :  "+year;
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_CENTER);
			document.add(paragraph);
			
			
			fontselector = new FontSelector();
            fontselector.addFont(new Font(Font.TIMES_ROMAN, 9));
            fontselector.addFont(new Font(Font.ZAPFDINGBATS, 9));
            fontselector.addFont(new Font(Font.SYMBOL, 9));
			
			
			content="\nReturn of Employees qualifiying for membership of the Provident Fund, Employees Pension Fund   Employee Deposit Linked Insurance Fund for the First Time during the month ( To be sent to the Commissioner with Form 2(EPF & EPS)) \n\n";
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_JUSTIFIED);
			document.add(paragraph);
			
			 
			
			PdfPTable table = new PdfPTable(8 );
			table.setWidthPercentage(100f);
			
			 
			PdfPCell c1 = new PdfPCell(new Paragraph(fontselector.process("Sl.No")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell( new Paragraph(fontselector.process("Account No ")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("Name of the Employee(in Block Capital )  ")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("Father's Name ")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("Date of Birth ")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("Date of Joinnig ")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("Sex")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("Remarks")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
						
			c1 = new PdfPCell(new Paragraph(fontselector.process("( 1 )")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell( new Paragraph(fontselector.process("( 2 )")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("( 3 ) ")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("( 4 ) ")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("( 5 )")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("( 6 ) ")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("( 7 )")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			
			c1 = new PdfPCell(new Paragraph(fontselector.process("( 8 )")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			 
				 
			sql="select  a.CHR_PFNO,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,DATE_FORMAT(a.DT_DOB,'%d-%b-%Y'),a.CHR_GENDER,a.DT_DOJCOLLEGE,a.CHR_EMPID,DATE_FORMAT(a.DAT_PFESIDATE,'%d-%b-%Y') from com_m_staff a,pay_t_salary b";
		  	sql=sql+ " where a.CHR_EMPID = b.CHR_EMPID AND b.CHR_ESI ='C' AND  b.CHR_PF='C'  AND  month(a.DAT_PFESIDATE)="+month+" ";  //a.CHR_EMPID = b.CHR_EMPID AND 
		  	if(!"0".equals(comid))
				sql=sql+ " AND a.INT_COMPANYID = "+comid;
			if(!"0".equals(branchid))
				sql=sql+ " AND a.INT_BRANCHID = "+branchid;
			if(!"0".equals(officeid))
				sql=sql+ "  AND a.INT_OFFICEID = "+officeid;
			sql=sql+ " and year(a.DAT_PFESIDATE)="+year+" group by a.CHR_EMPID order by a.CHR_PFNO";
		     
			String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		  
		    String s="";
		    if(data.length>0)
		    for(int i=0;i<data.length;i++)
			{
		    	s= (!"0".equals(data[i][0]))  ? datac[0][4]+data[i][0]  : "" ;
		    	table.addCell(new Paragraph(fontselector.process( (i+1)+".") ));;
		    	table.addCell(new Paragraph(fontselector.process(s)));
		    	table.addCell(new Paragraph(fontselector.process(data[i][1])));
				table.addCell(new Paragraph(fontselector.process(data[i][2])));
				table.addCell(new Paragraph(fontselector.process(data[i][3])));
				table.addCell(new Paragraph(fontselector.process(data[i][7])));
				table.addCell(new Paragraph(fontselector.process(data[i][4])));
				 
				table.addCell("");
				 
				 
			}
		    document.add(table);
		    
			
		    content= "\n* Previous A/c No.   service particulars with Form-13(revised) 2) The Scheme Certificate Control No., if any, enclosuing the certificate. 3) Details of Pension being drawn, if any under EPS, 95 (Such member shold be enrolled for PF; EDLI only) 4.Enclose form-2(Revised) giving nomination for PF   also for Pension by all members. 5) An employee who has attained the age of 58 will be eligible to become a member of EPS.95 only\n";
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_JUSTIFIED);
			document.add(paragraph);
			document.close(); 
			 
		}
		catch(Exception e)
		{         
			System.out.println(e.getMessage());
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
			
		}     
		
	}
	 
	
	
	
	
	
	
	private void Form6A(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		try
		{         
			
			Document document = new Document(); 
			document.addAuthor("CARE");
			document.addCreationDate();
			document.addCreator("SmartCampus");
			document.addTitle("PFFORM10PDF");
			 
			String company =request.getParameter("company");
			String branch =request.getParameter("branch");
			String office =request.getParameter("Office");
			String year =request.getParameter("Year");
			String cpy  ="";
			String bid  ="";
			String off="";
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition", "attachment;filename=\"PF Form6A _"+year+ ".pdf\"");
			
			PdfWriter.getInstance(document, response.getOutputStream());
			document.open();
			 
		
			 
			
			String sql="";
			sql=" SELECT a.CHR_EMPID,a.CHR_EMPNAME,CONCAT(c.CHR_PFNUMBER,b.CHR_PFNO),ROUND(sum(a.DOU_BASIC)),ROUND(sum(a.DOU_PF)),ROUND(sum(a.DOU_CPYPF2)),ROUND(sum(a.DOU_CPYPF1))";
			sql = sql+",b.CHR_TYPE,b.CHR_HOLD	FROM pay_t_salary a, com_m_staff b,com_m_company c ";                               
			sql = sql+"	WHERE a.CHR_EMPID =b.CHR_EMPID  AND a.CHR_PF !='N'   AND  b.INT_COMPANYID=c.INT_COMPANYID  ";
			if(!"0".equals(company))
				sql = sql+"	AND b.INT_COMPANYID = "+company;
			
			if(!"0".equals(branch))
				sql = sql+"	AND b.INT_BRANCHID = "+branch;
			
			if(!"0".equals(office))
				sql = sql+"	AND b.INT_OFFICEID = "+office;
				
			sql = sql+"	"+cpy;
			sql = sql+"	"+bid;
			sql = sql+"	"+ off;
			sql = sql+" AND (((a.CHR_MONTH in('April','May','June','July','August','September','October','November','December')) AND";
			sql = sql+"  (a.INT_YEAR= "+(Integer.parseInt(year)-1)+")) or((a.CHR_MONTH in('January','February','March')) ";
			sql = sql+" AND (a.INT_YEAR= "+year+")  )) group BY CHR_PFNO  "; //ORDER BY replace(CHR_PFNO,'TN/50360/','')
			 
			 
			String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			String cdata[][] =com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT upper(CHR_COMPANYNAME) FROM com_m_company WHERE INT_COMPANYID ="+company);
			double sumA=0.0;
			double sumB=0.0;
			double sumC=0.0;
			double sumD=0.0;
			 
			FontSelector fontselector = new FontSelector();
            fontselector.addFont(new Font(Font.TIMES_ROMAN, 10));
            fontselector.addFont(new Font(Font.ZAPFDINGBATS, 10));
            fontselector.addFont(new Font(Font.SYMBOL, 10));
			
			 
            
			
                     
            Phrase ph = fontselector.process(cdata[0][0]);
			Paragraph paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_CENTER);
			document.add(paragraph);
			
			ph = fontselector.process("YEAR :: "+(Integer.parseInt(year)-1)+" - "+ year );
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_CENTER);
			document.add(paragraph);
			 
			ph = fontselector.process(" FORM-6A" );
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_CENTER);
			document.add(paragraph);

			fontselector = new FontSelector();
            fontselector.addFont(new Font(Font.TIMES_ROMAN, 9));
            fontselector.addFont(new Font(Font.ZAPFDINGBATS, 9));
            fontselector.addFont(new Font(Font.SYMBOL, 9));
			
			
			String content="The Employee's Provident Fund   Scheme 1962";
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_CENTER);
			document.add(paragraph);
			
			content="(paragraph 43) and" ;
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_CENTER);
			document.add(paragraph);
			
			content="The Employee's Pension Scheme,   1995"  ;
			 
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_CENTER);
			document.add(paragraph);
			 
			
			content="paragraph 15(4)";
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_CENTER);
			document.add(paragraph);
			
			
			 
			
			PdfPTable table = new PdfPTable(11 );
			table.setWidthPercentage(100f);
			
			 
			PdfPCell c1 = new PdfPCell(new Paragraph(fontselector.process("Sl.No")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			 
			
			table.addCell(c1);
			c1 = new PdfPCell( new Paragraph(fontselector.process("Account Number")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			 
			table.addCell(c1);
			
			c1 = new PdfPCell(new Paragraph(fontselector.process("Empid")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			 
			table.addCell(c1);
			
			c1 = new PdfPCell(new Paragraph(fontselector.process("Name of the Member(in Block letter) ")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			 
			table.addCell(c1);
			
			c1 = new PdfPCell(new Paragraph(fontselector.process("Wages")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			 
			table.addCell(c1);
			
			c1 = new PdfPCell(new Paragraph(fontselector.process("EPF Amount of workers contribution deducted from the wages")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			 
			table.addCell(c1);
			
			
			
			c1 = new PdfPCell(new Paragraph(fontselector.process(" Employer's con EPF DIFFERENCE 10% & 8/3% ")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			 
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("Employer's con Pension Fund 8 1/3%")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("Refund of Advance")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("Rate of Higher voluntary contribution (if any)")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("Remarks")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			
			
			c1 = new PdfPCell(new Paragraph(fontselector.process("( 1 )")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell( new Paragraph(fontselector.process("( 2 )")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("( 3 ) ")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("( 4 ) ")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("( 5 )")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("( 6 ) ")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("( 7 )")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			
			c1 = new PdfPCell(new Paragraph(fontselector.process("( 8 )")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("( 9 ) ")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("( 10 )")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			
			c1 = new PdfPCell(new Paragraph(fontselector.process("( 11 )")));
			c1.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c1);
			
			
			
		    if(data.length>0)
		    for(int i=0;i<data.length;i++)
			{
		    	 
		    	table.addCell(new Paragraph(fontselector.process( (i+1)+".") ));;
		    	table.addCell(new Paragraph(fontselector.process(data[i][2])));
		    	table.addCell(new Paragraph(fontselector.process(data[i][0])));
		    	if(data[i][7].equals("T"))
		    		table.addCell(new Paragraph(fontselector.process(data[i][1]+"*")));
				else if(data[i][8].equals("Y"))
					table.addCell(new Paragraph(fontselector.process(data[i][1]+"**")));
				else
					table.addCell(new Paragraph(fontselector.process(data[i][1])));
				table.addCell(new Paragraph(fontselector.process(data[i][3])));
				table.addCell(new Paragraph(fontselector.process(data[i][4])));
				table.addCell(new Paragraph(fontselector.process(data[i][5])));
				table.addCell(new Paragraph(fontselector.process(data[i][6])));
				table.addCell(new Paragraph(fontselector.process("") ));;
				table.addCell(new Paragraph(fontselector.process("") ));;
				table.addCell(new Paragraph(fontselector.process("") ));;
				 
				sumA= sumA + Double.parseDouble(data[i][3]);
				sumB= sumB + Double.parseDouble(data[i][4]);
				sumC= sumC + Double.parseDouble(data[i][5]);
				sumD= sumD + Double.parseDouble(data[i][6]);
				
				 
				 
			}
		    table.addCell(new Paragraph(fontselector.process("") ));;
			table.addCell(new Paragraph(fontselector.process("") ));;
			table.addCell(new Paragraph(fontselector.process("") ));;
			table.addCell(new Paragraph(fontselector.process("") ));;
			table.addCell(new Paragraph(fontselector.process(""+BigDecimal.valueOf(sumA).toPlainString() ) ));;
			table.addCell(new Paragraph(fontselector.process(""+BigDecimal.valueOf(sumB).toPlainString()) ));;
			table.addCell(new Paragraph(fontselector.process(""+BigDecimal.valueOf(sumC).toPlainString()) ));;
			table.addCell(new Paragraph(fontselector.process(""+BigDecimal.valueOf(sumD).toPlainString()) ));;
			table.addCell(new Paragraph(fontselector.process("") ));;
			table.addCell(new Paragraph(fontselector.process("") ));;
			table.addCell(new Paragraph(fontselector.process("") ));;
			
		    
		    
		    document.add(table);
		    
			
		    content= "\n*  Note :: * ---> Resigned   , ** --->Hold";
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_JUSTIFIED);
			document.add(paragraph);
			
			
			 
		 
			
			document.close(); 
			 
		}
		catch(Exception e)
		{         
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
			
		}     
		
	}
	 
	
	
	private void Form3A(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		try
		{         
			
			Document document = new Document(); 
			document.addAuthor("CARE");
			document.addCreationDate();
			document.addCreator("SmartCampus");
			document.addTitle("PFFORM10PDF");
			
			
			int byear=0,cyear=0;
			String form2A="0.00",form3A="0.00",form4A="0.00",form4bA="0.00";
			String form2M="0.00",form3M="0.00",form4M="0.00",form4bM="0.00";
			String form2J="0.00",form3J="0.00",form4J="0.00",form4bJ="0.00";
			String form2L="0.00",form3L="0.00",form4L="0.00",form4bL="0.00";
			String form2U="0.00",form3U="0.00",form4U="0.00",form4bU="0.00";
			String form2S="0.00",form3S="0.00",form4S="0.00",form4bS="0.00";
			String form2O="0.00",form3O="0.00",form4O="0.00",form4bO="0.00";
			String form2N="0.00",form3N="0.00",form4N="0.00",form4bN="0.00";
			String form2D="0.00",form3D="0.00",form4D="0.00",form4bD="0.00";
			String form21="0.00",form31="0.00",form41="0.00",form4b1="0.00";
			String form2F="0.00",form3F="0.00",form4F="0.00",form4bF="0.00";
			String form2R="0.00",form3R="0.00",form4R="0.00",form4bR="0.00";
			 
			 
			double form2t=0.00,form3t=0.00,form4t=0.00,form4bt=0.00;
			
			 
			 
			String empid =request.getParameter("empid");
			String year =request.getParameter("Year");
			int yr=Integer.parseInt(year);
			byear=(Integer.parseInt(year));
			cyear=Integer.parseInt(year+1);
			String sql=""; 
			
			response.setContentType("application/pdf");
			PdfWriter.getInstance(document, response.getOutputStream());
			document.open();
			 
			 
			FontSelector fontselector = new FontSelector();
            fontselector.addFont(new Font(Font.TIMES_ROMAN, 10));
            fontselector.addFont(new Font(Font.ZAPFDINGBATS, 10));
            fontselector.addFont(new Font(Font.SYMBOL, 10));
			
			 
            
			
                     
            Phrase ph = fontselector.process(" FORM 3A(Revised)");
			Paragraph paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_CENTER);
			document.add(paragraph);
			
			 
		 

			fontselector = new FontSelector();
            fontselector.addFont(new Font(Font.TIMES_ROMAN, 9));
            fontselector.addFont(new Font(Font.ZAPFDINGBATS, 9));
            fontselector.addFont(new Font(Font.SYMBOL, 9));
			
            String content="";
			content="Contribution card for the Currency Period from 1st April "+byear+" to 31st March "+((yr+1))+" (FOR UNEXEMPTED ESTABLISHMENTS ONLY)";
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_CENTER);
			document.add(paragraph);
			
			sql = " SELECT a.CHR_EMPID,b.CHR_COMPANYNAME,b.CHR_STREET,b.CHR_CITY,c.CHR_STATENAME,b.CHR_POSTAL,a.CHR_STAFFNAME, b.CHR_PFNUMBER,a.CHR_ESINO  ";
			sql = sql+" FROM com_m_staff a,com_m_company b,com_m_state c ";
			sql = sql+" WHERE a.INT_COMPANYID= b.INT_COMPANYID AND b.CHR_STATE= c.INT_STATEID and a.CHR_EMPID='"+empid+"'";
			String datac[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				
			content="Name and address of the Establishment:\n" +datac[0][1]+"\n"+datac[0][2]+"\n"+datac[0][3]+"\n"+datac[0][4]+"\nPincode : "+datac[0][5]+"\n ";
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_LEFT);
			document.add(paragraph);
			 
			
			fontselector = new FontSelector();
            fontselector.addFont(new Font(Font.TIMES_ROMAN, 7));
            fontselector.addFont(new Font(Font.ZAPFDINGBATS, 7));
            fontselector.addFont(new Font(Font.SYMBOL, 7));
			
            
			PdfPTable htable = new PdfPTable(4 );
			htable.setWidthPercentage(100f);
			
			PdfPCell c1 = new PdfPCell(new Paragraph(fontselector.process("1. Account No.")));
			c1.setHorizontalAlignment(Element.ALIGN_LEFT);
			htable.addCell(c1);
			c1 = new PdfPCell( new Paragraph(fontselector.process(datac[0][7]+datac[0][8])));
			c1.setHorizontalAlignment(Element.ALIGN_LEFT);
			htable.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("4.Statutory rate of Contribution")));
			c1.setHorizontalAlignment(Element.ALIGN_LEFT);
			htable.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("12%")));
			c1.setHorizontalAlignment(Element.ALIGN_LEFT);
			htable.addCell(c1);
			
			
			c1 = new PdfPCell(new Paragraph(fontselector.process("2.Name/surname (in Block Capitals)")));
			c1.setHorizontalAlignment(Element.ALIGN_LEFT);
			htable.addCell(c1);
			c1 = new PdfPCell( new Paragraph(fontselector.process( datac[0][6].toUpperCase() )));
			c1.setHorizontalAlignment(Element.ALIGN_LEFT);
			htable.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("5.Voluntary higher rate of employee's contribution if any")));
			c1.setHorizontalAlignment(Element.ALIGN_LEFT);
			htable.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("")));
			c1.setHorizontalAlignment(Element.ALIGN_LEFT);
			htable.addCell(c1);
			
			
			
			
			c1 = new PdfPCell(new Paragraph(fontselector.process("3.Father's/Husband's Name:")));
			c1.setHorizontalAlignment(Element.ALIGN_LEFT);
			htable.addCell(c1);
			c1 = new PdfPCell( new Paragraph(fontselector.process("")));
			c1.setHorizontalAlignment(Element.ALIGN_LEFT);
			htable.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("6.Employer contribution on Hig wages to EPF(ER) Y/N ")));
			c1.setHorizontalAlignment(Element.ALIGN_LEFT);
			htable.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("")));
			c1.setHorizontalAlignment(Element.ALIGN_LEFT);
			htable.addCell(c1);
			
			c1 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c1.setHorizontalAlignment(Element.ALIGN_LEFT);
			htable.addCell(c1);
			c1 = new PdfPCell( new Paragraph(fontselector.process("")));
			c1.setHorizontalAlignment(Element.ALIGN_LEFT);
			htable.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process(" 7.Voluntary contribution to pension Y/N   ")));
			c1.setHorizontalAlignment(Element.ALIGN_LEFT);
			htable.addCell(c1);
			c1 = new PdfPCell(new Paragraph(fontselector.process("")));
			c1.setHorizontalAlignment(Element.ALIGN_LEFT);
			htable.addCell(c1);
			document.add(htable);
			 
			 
			
			PdfPTable table = new PdfPTable(8 );
			table.setWidthPercentage(100f);
			 
			PdfPCell c2 = new PdfPCell(new Paragraph(fontselector.process("Months")));
			c2.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c2);
			c2 = new PdfPCell( new Paragraph(fontselector.process("Workers Share Amount of Wages ")));
			c2.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process("Workers Share EPF(12%) ")));
			c2.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process("Employers Share  EPF(3.67%)")));
			c2.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process("Employers Share Pension Fund Contri(8.33%) ")));
			c2.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process("Refund of Advance ")));
			c2.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process("No of Days/Period of Non Contributing service if any ")));
			c2.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process("Remark")));
			c2.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c2);
		 
			
			c2 = new PdfPCell(new Paragraph(fontselector.process("( 1 )")));
			c2.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c2);
			c2 = new PdfPCell( new Paragraph(fontselector.process("( 2 )")));
			c2.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process("( 3 ) ")));
			c2.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process("( 4 ) ")));
			c2.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process("( 5 )")));
			c2.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process("( 6 ) ")));
			c2.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process("( 7 )")));
			c2.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process("( 8 )")));
			c2.setHorizontalAlignment(Element.ALIGN_CENTER);
			table.addCell(c2); 
			
			//March  Pain in APRIL
			sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_PENBASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
			sql = sql+"	FROM pay_t_salary a ";                               
			sql = sql+"	WHERE a.CHR_EMPID ='"+empid+"' ";
			sql = sql+" AND a.CHR_MONTH ='March' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
			String data1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if(data1.length>0)
			{
			   form2A=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data1[0][1]));
			   form3A=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data1[0][2]));
			   form4A=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data1[0][3]));
			   form4bA=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data1[0][4])); 
			}
			c2 = new PdfPCell(new Paragraph(fontselector.process("March paid in APRIL-"+yr)));
			c2.setHorizontalAlignment(Element.ALIGN_LEFT);
			table.addCell(c2);
			c2 = new PdfPCell( new Paragraph(fontselector.process(form2A)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form3A)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form4bA)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form4A)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process("")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2); 
			
			
			//April paid in MAY
			sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_PENBASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
			sql = sql+"	FROM pay_t_salary a ";                               
			sql = sql+"	WHERE a.CHR_EMPID ='"+empid+"' ";
			sql = sql+" AND a.CHR_MONTH ='April' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
			String data2[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if(data2.length>0)
			{
			   form2M=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data2[0][1]));
			   form3M=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data2[0][2]));
			   form4M=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data2[0][3]));
			   form4bM=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data2[0][4])); 
			}
			c2 = new PdfPCell(new Paragraph(fontselector.process("MAY-"+yr)));
			c2.setHorizontalAlignment(Element.ALIGN_LEFT);
			table.addCell(c2);
			c2 = new PdfPCell( new Paragraph(fontselector.process(form2M)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form3M)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form4bM)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form4M)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process("")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2); 
			
			
			sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_PENBASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
			sql = sql+"	FROM pay_t_salary a ";                               
			sql = sql+"	WHERE a.CHR_EMPID ='"+empid+"' ";
			sql = sql+" AND a.CHR_MONTH ='May' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
			String data3[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if(data3.length>0)
			{
			   form2J=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data3[0][1]));
			   form3J=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data3[0][2]));
			   form4J=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data3[0][3]));
			   form4bJ=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data3[0][4])); 
			}
			c2 = new PdfPCell(new Paragraph(fontselector.process("JUNE-"+yr)));
			c2.setHorizontalAlignment(Element.ALIGN_LEFT);
			table.addCell(c2);
			c2 = new PdfPCell( new Paragraph(fontselector.process(form2J)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form3J)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form4bJ)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form4J)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process("")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2); 
			
			
			
			sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_PENBASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
			sql = sql+"	FROM pay_t_salary a ";                               
			sql = sql+"	WHERE a.CHR_EMPID ='"+empid+"' ";
			sql = sql+" AND a.CHR_MONTH ='June' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
			String data4[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if(data4.length>0)
			{
			   form2L=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data4[0][1]));
			   form3L=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data4[0][2]));
			   form4L=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data4[0][3]));
			   form4bL=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data4[0][4])); 
			}
			c2 = new PdfPCell(new Paragraph(fontselector.process("JULY-"+yr)));
			c2.setHorizontalAlignment(Element.ALIGN_LEFT);
			table.addCell(c2);
			c2 = new PdfPCell( new Paragraph(fontselector.process(form2L)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form3L)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form4bL)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form4L)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process("")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2); 
			
			
			
			sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_PENBASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
			sql = sql+"	FROM pay_t_salary a ";                               
			sql = sql+"	WHERE a.CHR_EMPID ='"+empid+"' ";
			sql = sql+" AND a.CHR_MONTH ='July' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
			String data5[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if(data5.length>0)
			{
			   form2U=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data5[0][1]));
			   form3U=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data5[0][2]));
			   form4U=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data5[0][3]));
			   form4bU=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data5[0][4])); 
			}
			c2 = new PdfPCell(new Paragraph(fontselector.process("AUGUST-"+yr)));
			c2.setHorizontalAlignment(Element.ALIGN_LEFT);
			table.addCell(c2);
			c2 = new PdfPCell( new Paragraph(fontselector.process(form2U)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form3U)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form4bU)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form4U)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process("")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2); 
			
			
			
			sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_PENBASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
			sql = sql+"	FROM pay_t_salary a ";                               
			sql = sql+"	WHERE a.CHR_EMPID ='"+empid+"' ";
			sql = sql+" AND a.CHR_MONTH ='August' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
			String data6[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if(data6.length>0)
			{
			   form2S=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data6[0][1]));
			   form3S=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data6[0][2]));
			   form4S=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data6[0][3]));
			   form4bS=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data6[0][4])); 
			}
			c2 = new PdfPCell(new Paragraph(fontselector.process("SEPTEMBER-"+yr)));
			c2.setHorizontalAlignment(Element.ALIGN_LEFT);
			table.addCell(c2);
			c2 = new PdfPCell( new Paragraph(fontselector.process(form2S)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form3S)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form4bS)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form4S)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process("")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2); 
			
			
			sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_PENBASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
			sql = sql+"	FROM pay_t_salary a ";                               
			sql = sql+"	WHERE a.CHR_EMPID ='"+empid+"' ";
			sql = sql+" AND a.CHR_MONTH ='September' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
			String data7[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if(data7.length>0)
			{
			   form2O=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data7[0][1]));
			   form3O=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data7[0][2]));
			   form4O=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data7[0][3]));
			   form4bO=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data7[0][4])); 
			}
			c2 = new PdfPCell(new Paragraph(fontselector.process("OCTOBER-"+yr)));
			c2.setHorizontalAlignment(Element.ALIGN_LEFT);
			table.addCell(c2);
			c2 = new PdfPCell( new Paragraph(fontselector.process(form2O)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form3O)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form4bO)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form4O)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process("")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2); 
			
			
			
			sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_PENBASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
			sql = sql+"	FROM pay_t_salary a ";                               
			sql = sql+"	WHERE a.CHR_EMPID ='"+empid+"' ";
			sql = sql+" AND a.CHR_MONTH ='October' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
			String data8[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if(data8.length>0)
			{
			   form2N=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data8[0][1]));
			   form3N=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data8[0][2]));
			   form4N=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data8[0][3]));
			   form4bN=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data8[0][4])); 
			}
			c2 = new PdfPCell(new Paragraph(fontselector.process("NOVEMBER-"+yr)));
			c2.setHorizontalAlignment(Element.ALIGN_LEFT);
			table.addCell(c2);
			c2 = new PdfPCell( new Paragraph(fontselector.process(form2N)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form3N)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form4bN)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form4N)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process("")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2); 
			
			
			
			sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_PENBASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
			sql = sql+"	FROM pay_t_salary a ";                               
			sql = sql+"	WHERE a.CHR_EMPID ='"+empid+"' ";
			sql = sql+" AND a.CHR_MONTH ='November' AND a.INT_YEAR="+byear+" group by a.CHR_EMPID";
			String data9[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if(data9.length>0)
			{
			   form2D=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data9[0][1]));
			   form3D=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data9[0][2]));
			   form4D=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data9[0][3]));
			   form4bD=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data9[0][4])); 
			}
			c2 = new PdfPCell(new Paragraph(fontselector.process("DECEMBER-"+yr)));
			c2.setHorizontalAlignment(Element.ALIGN_LEFT);
			table.addCell(c2);
			c2 = new PdfPCell( new Paragraph(fontselector.process(form2D)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form3D)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form4bD)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form4D)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process("")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2); 
			
			
			
			sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_PENBASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
			sql = sql+"	FROM pay_t_salary a ";                               
			sql = sql+"	WHERE a.CHR_EMPID ='"+empid+"' ";
			sql = sql+" AND a.CHR_MONTH ='December' AND a.INT_YEAR="+cyear+" group by a.CHR_EMPID";
			String data10[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if(data10.length>0)
			{
			   form21=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data10[0][1]));
			   form31=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data10[0][2]));
			   form41=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data10[0][3]));
			   form4b1=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data10[0][4])); 
			}
			c2 = new PdfPCell(new Paragraph(fontselector.process("JANUARY-"+(yr+1))));
			c2.setHorizontalAlignment(Element.ALIGN_LEFT);
			table.addCell(c2);
			c2 = new PdfPCell( new Paragraph(fontselector.process(form21)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form31)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form4b1)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form41)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process("")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2); 
			
			
			sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_PENBASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
			sql = sql+"	FROM pay_t_salary a ";                               
			sql = sql+"	WHERE a.CHR_EMPID ='"+empid+"' ";
			sql = sql+" AND a.CHR_MONTH ='January' AND a.INT_YEAR="+cyear+" group by a.CHR_EMPID";
			String data11[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if(data11.length>0)
			{
			   form2F=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data11[0][1]));
			   form3F=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data11[0][2]));
			   form4F=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data11[0][3]));
			   form4bF=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data11[0][4])); 
			}
			c2 = new PdfPCell(new Paragraph(fontselector.process("FEBRUARY-"+(yr+1))));
			c2.setHorizontalAlignment(Element.ALIGN_LEFT);
			table.addCell(c2);
			c2 = new PdfPCell( new Paragraph(fontselector.process(form2F)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form3F)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form4bF)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form4F)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process("")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2); 
			
			
			
			sql=" SELECT a.CHR_EMPNAME ,sum(a.DOU_PENBASIC),sum(a.DOU_PF),sum(a.DOU_CPYPF1),sum(a.DOU_CPYPF2) ";
			sql = sql+"	FROM pay_t_salary a ";                               
			sql = sql+"	WHERE a.CHR_EMPID ='"+empid+"' ";
			sql = sql+" AND a.CHR_MONTH ='February' AND a.INT_YEAR="+cyear+" group by a.CHR_EMPID";
			String data12[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if(data12.length>0)
			{
			   form2R=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data12[0][1]));
			   form3R=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data12[0][2]));
			   form4R=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data12[0][3]));
			   form4bR=com.my.org.erp.Math.MathFunction.keep2Digit(Double.parseDouble(data12[0][4])); 
			}
			c2 = new PdfPCell(new Paragraph(fontselector.process("MARCH -"+(yr+1))));
			c2.setHorizontalAlignment(Element.ALIGN_LEFT);
			table.addCell(c2);
			c2 = new PdfPCell( new Paragraph(fontselector.process(form2R)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form3R)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form4bR)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(form4R)));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process("")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2); 
			
			
			c2 = new PdfPCell(new Paragraph(fontselector.process("TOTAL")));
			c2.setHorizontalAlignment(Element.ALIGN_LEFT);
			table.addCell(c2);
			form2t=Double.parseDouble(form2A)+Double.parseDouble(form2M)+Double.parseDouble(form2J)+Double.parseDouble(form2L)+Double.parseDouble(form2U)+Double.parseDouble(form2S)+Double.parseDouble(form2O)+Double.parseDouble(form2N)+Double.parseDouble(form2D)+Double.parseDouble(form21)+Double.parseDouble(form2F)+Double.parseDouble(form2R);
			c2 = new PdfPCell( new Paragraph(fontselector.process(""+com.my.org.erp.Math.MathFunction.keep2Digits(form2t))));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			form3t=Double.parseDouble(form3A)+Double.parseDouble(form3M)+Double.parseDouble(form3J)+Double.parseDouble(form3L)+Double.parseDouble(form3U)+Double.parseDouble(form3S)+Double.parseDouble(form3O)+Double.parseDouble(form3N)+Double.parseDouble(form3D)+Double.parseDouble(form31)+Double.parseDouble(form3F)+Double.parseDouble(form3R);
			c2 = new PdfPCell(new Paragraph(fontselector.process(""+com.my.org.erp.Math.MathFunction.keep2Digits(form3t) )));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			form4bt=Double.parseDouble(form4bA)+Double.parseDouble(form4bM)+Double.parseDouble((form4bJ))+Double.parseDouble(form4bL)+Double.parseDouble(form4bU)+Double.parseDouble(form4bS)+Double.parseDouble(form4bO)+Double.parseDouble(form4bN)+Double.parseDouble(form4bD)+Double.parseDouble(form4b1)+Double.parseDouble(form4bF)+Double.parseDouble(form4bR);
			c2 = new PdfPCell(new Paragraph(fontselector.process(""+com.my.org.erp.Math.MathFunction.keep2Digit(form4bt) )));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			form4t=Double.parseDouble(form4A)+Double.parseDouble(form4M)+Double.parseDouble(form4J)+Double.parseDouble(form4L)+Double.parseDouble(form4U)+Double.parseDouble(form4S)+Double.parseDouble(form4O)+Double.parseDouble(form4N)+Double.parseDouble(form4D)+Double.parseDouble(form41)+Double.parseDouble(form4F)+Double.parseDouble(form4R);
			c2 = new PdfPCell(new Paragraph(fontselector.process(""+com.my.org.erp.Math.MathFunction.keep2Digit(form4t))));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process("")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2);
			c2 = new PdfPCell(new Paragraph(fontselector.process(" ")));
			c2.setHorizontalAlignment(Element.ALIGN_RIGHT);
			table.addCell(c2); 
			
			
			
			
			/*
		    if(data.length>0)
		    for(int i=0;i<data.length;i++)
			{
		    	 
		    	table.addCell(new Paragraph(fontselector.process( (i+1)+".") ));;
		    	table.addCell(new Paragraph(fontselector.process(data[i][2])));
		    	table.addCell(new Paragraph(fontselector.process(data[i][0])));
		    	if(data[i][7].equals("T"))
		    		table.addCell(new Paragraph(fontselector.process(data[i][1]+"*")));
				else if(data[i][8].equals("Y"))
					table.addCell(new Paragraph(fontselector.process(data[i][1]+"**")));
				else
					table.addCell(new Paragraph(fontselector.process(data[i][1])));
				table.addCell(new Paragraph(fontselector.process(data[i][3])));
				table.addCell(new Paragraph(fontselector.process(data[i][4])));
				table.addCell(new Paragraph(fontselector.process(data[i][5])));
				table.addCell(new Paragraph(fontselector.process(data[i][6])));
				table.addCell(new Paragraph(fontselector.process("") ));;
				table.addCell(new Paragraph(fontselector.process("") ));;
				table.addCell(new Paragraph(fontselector.process("") ));;
				 
				sumA= sumA + Double.parseDouble(data[i][3]);
				sumB= sumB + Double.parseDouble(data[i][4]);
				sumC= sumC + Double.parseDouble(data[i][5]);
				sumD= sumD + Double.parseDouble(data[i][6]);
				
				 
				 
			}
		    table.addCell(new Paragraph(fontselector.process("") ));;
			table.addCell(new Paragraph(fontselector.process("") ));;
			table.addCell(new Paragraph(fontselector.process("") ));;
			table.addCell(new Paragraph(fontselector.process("") ));;
			table.addCell(new Paragraph(fontselector.process(""+BigDecimal.valueOf(sumA).toPlainString() ) ));;
			table.addCell(new Paragraph(fontselector.process(""+BigDecimal.valueOf(sumB).toPlainString()) ));;
			table.addCell(new Paragraph(fontselector.process(""+BigDecimal.valueOf(sumC).toPlainString()) ));;
			table.addCell(new Paragraph(fontselector.process(""+BigDecimal.valueOf(sumD).toPlainString()) ));;
			table.addCell(new Paragraph(fontselector.process("") ));;
			table.addCell(new Paragraph(fontselector.process("") ));;
			table.addCell(new Paragraph(fontselector.process("") ));;
			
		    */
		    
		   document.add(table);
		    
			
		    content= "Certified that the total amount of   contribution (both shares) indicated in this card i.e, Rs."+com.my.org.erp.Math.MathFunction.keep2Digits(form3t+form4t)+" has already been remitted in full in EPF A/C No. 1 and pension   Fund A/C No. 10 R "+com.my.org.erp.Math.MathFunction.keep2Digits(form4bt)+" vide below ";
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_JUSTIFIED);
			document.add(paragraph);
			
			content= "Certified that the difference between the total of the contributions shown under columns(3) and 4(a) & 4(b) of the above table and that arrived at on the total wages shown in col(2) at the prescribed rate is sloely due to rounding off of contribution to the nearest rupee under the rules.";
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_JUSTIFIED);
			document.add(paragraph);
			
			
			content= "For Care Networking Solutions (India) Pvt Ltd.,";
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_RIGHT);
			document.add(paragraph);
			
			content= "\n\nAuthorised signatory";
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_RIGHT);
			document.add(paragraph);
			
			
			content= "\n(See paragraphs 35 and 42 of the employee' Provident Funds Scheme, 1952) ";
			content=content+"\n(See paragraph 19 of the Employee's Pension Scheme 1995)"; 
			content=content+"\nNote:- In respect of Form 3(A) sent to the Regional Office during the course of the Currency period for the purpose of final settlement of the accounts of the member who had left service details of date and reason for leaving service."; 
			content=content+"\nShould be furnished under column 7(A)(B) ";
			content=content+"\nIn respect of those who are not members of the Pension Fund the employers share of contribution to the EPF will be 8-1/3 or 10% as the may be and is to be shown under Column 4(a)"; 
			ph = fontselector.process(content);
			paragraph  = new Paragraph(ph);
			paragraph.setAlignment(Element.ALIGN_JUSTIFIED);
			document.add(paragraph);
			
			
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

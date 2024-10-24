package com.my.org.erp.SmartInventory;
import java.awt.Color;
 

import java.io.IOException;
 

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

import com.lowagie.text.pdf.FontSelector;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.common.CommonInfo;
public class PDFInvoiceGeneratorActionHandler extends AbstractActionHandler
{
	@SuppressWarnings("deprecation")
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			HttpSession session=request.getSession();			
			String action=request.getParameter("actionS");
			String sql="";
			if(action.equals("INVPDFInvoiceGenerator"))
			{
				String salesno = request.getParameter("salesno");
				
				sql = " SELECT INT_COMPANYID,INT_BRANCHID,INT_SALESID,CHR_SALESNO,DATE_FORMAT(DAT_SALESDATE,'%d-%b-%Y'), ";
				sql = sql +" INT_PAYMENTTERMID ,INT_CUSTOMERID ,CHR_DES ,CHR_REF ,DOU_AMOUNT ,DOU_DISCOUNT, "; 
				sql = sql +" INT_TAXID,DOU_TAXAMOUNT,DOU_TOTALAMOUNT,INT_SALESSTATUS,CHR_PAYMENTSTATUS,CHR_SALESTYPE,  ";
				sql = sql +" CHR_SHIPPING,CHR_SHIPPINGADDRESS,CHR_OTHERREF,CHR_DELIVERYNOTE,CHR_DESPATCHTHRU,CHR_DESTINATION , ";
				sql = sql +" CHR_TERMSOFDELIVERY ,CHR_CONTACTDETAILS ,CHR_CONTACTNO ,INT_DIVIID ,CHR_ACCOUNTFLAG,CHR_ACCOUNTDESC , ";
				sql = sql +" IMG_INVOICE,CHR_NOOFPAYMENTCOMMITMENT,CHR_BYBACK ,CHR_BYBACKDESC,DOU_BYBACKAMOUNT ,CHR_USRNAME , ";
				sql = sql +" DT_UPDATEDATE CHR_UPDATESTATUS FROM inv_t_directsales ";
				sql = sql +" WHERE CHR_SALESNO='"+salesno+"'";
				
				String perdata[][]=CommonFunctions.QueryExecute(sql);;

				String ssql="SELECT b.CHR_COMPANYNAME,a.CHR_BRANCHNAME,a.CHR_STREET,e.CHR_CITYNAME,d.CHR_STATENAME,a.INT_PINCODE,a.CHR_PHONE,  ";
				ssql = ssql +" a.CHR_FAX,a.CHR_EMAIL, a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO,a.CHR_LOCALTAXNO,a.CHR_PANNO, "; 
				ssql = ssql +" b.CHR_SERVICETAX FROM com_m_branch a , com_m_company b ,com_m_country c, com_m_state d, com_m_city e ";
				ssql = ssql +" WHERE  a.INT_CITYID = e.INT_CITYID ";
				ssql = ssql +" AND a.INT_COUNTRYID = c.INT_COUNTRYID ";
				ssql = ssql +" AND a.INT_STATEID =d.INT_STATEID ";
				ssql = ssql +" AND a.INT_COMPANYID = b.INT_COMPANYID  ";
				ssql = ssql +" AND a.INT_BRANCHID="+ session.getAttribute("BRANCHID");
				String cpydata[][]=CommonFunctions.QueryExecute(ssql);
				String header ="";					   
				 header=cpydata[0][0]+"\n";
				if(!"-".equals(cpydata[0][2]))
					header=header+cpydata[0][2]+"\n";
				if(!"-".equals(cpydata[0][3]))	
					header=header+cpydata[0][3]+"\n";
				if(!"-".equals(cpydata[0][4]))
					header=header+cpydata[0][4]+"\n";
				if(!"-".equals(cpydata[0][5]))
					header=header+cpydata[0][5]+"\n";	
				if(!"-".equals(cpydata[0][6]))
					header=header+cpydata[0][6]+"\n";	
				
				
				Document document = new Document(); 
				 
				try
				{         
					response.setContentType("application/pdf");
					PdfWriter.getInstance(document, response.getOutputStream());
					document.open();
					
					
					Image image = Image.getInstance (request.getRealPath("/")+"images/logo.jpg");
					image.setAlignment(1);
					document.add(image );
				     
					  
					FontSelector fontselector = new FontSelector();
		            fontselector.addFont(new Font(Font.TIMES_ROMAN, 7));
		            fontselector.addFont(new Font(Font.ZAPFDINGBATS, 7));
		            fontselector.addFont(new Font(Font.SYMBOL, 7));
		            
					PdfPTable table=new PdfPTable(2);
					PdfPCell cell = new PdfPCell (new Paragraph ("INVOICE"));
					cell.setColspan (2);
					cell.setHorizontalAlignment (Element.ALIGN_CENTER);
					cell.setBackgroundColor (new Color (128, 200, 128));
					cell.setPadding (5.0f);
					table.addCell (cell);
					
					String s1="";
					sql="SELECT a.INT_CUSTOMERID,f.CHR_NAME,a.CHR_CONTACTPERSON, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE),CONCAT('Phone :',a.CHR_PHONE),CONCAT('E-Mail :',a.CHR_EMAIL) FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND   a.INT_CUSTOMERID="+perdata[0][6];
					String vendor[][]=CommonFunctions.QueryExecute(sql);
					if(!"-".equals(vendor[0][1]))
						s1= s1+ vendor[0][1]+",\n" ;
					if(!"-".equals(vendor[0][2]))	
						s1= s1+ vendor[0][2]+",\n" ;
					if(!"-".equals(vendor[0][3]))
						s1= s1+ vendor[0][3]+"\n" ;
					if(!"-".equals(vendor[0][4]))
						s1= s1+ vendor[0][4]+"\n" ;										
					if(!"-".equals(vendor[0][5]))
						s1= s1+ vendor[0][5]+"\n" ;										
					if(!"-".equals(vendor[0][6]))
						s1= s1+ vendor[0][6]+"\n" ;										
					if(!"-".equals(vendor[0][7]))
						s1= s1+ vendor[0][7]+"." ;	
					
					 
					
					String s2="";
					if("S".equals(perdata[0][17]))
					{
						if(!"-".equals(vendor[0][1]))
							s2= s2+ vendor[0][1]+",\n" ;
						if(!"-".equals(vendor[0][2]))	
							s2= s2+ vendor[0][2]+",\n" ;
						if(!"-".equals(vendor[0][3]))
							s2= s2+ vendor[0][3]+"\n" ;
						if(!"-".equals(vendor[0][4]))
							s2= s2+ vendor[0][4]+"\n" ;										
						if(!"-".equals(vendor[0][5]))
							s2= s2+ vendor[0][5]+"\n" ;										
						if(!"-".equals(vendor[0][6]))
							s2= s2+ vendor[0][6]+"\n" ;										
						if(!"-".equals(vendor[0][7]))
							s2= s2+ vendor[0][7]+"." ;	
					}
					else
					{
						s2= s2+perdata[0][18] ;
					}
					
					PdfPTable table1=new PdfPTable(2);
					table1.addCell(new PdfPCell(new Paragraph(fontselector.process("Sales/Invoice .No") )  ));
					table1.addCell(new PdfPCell(new Paragraph(fontselector.process(perdata[0][3]) )  ));
					table1.addCell(new PdfPCell(new Paragraph(fontselector.process("Billing Address") )  ));
					table1.addCell(new PdfPCell(new Paragraph(fontselector.process(s1) )  ));
					table1.addCell(new PdfPCell(new Paragraph(fontselector.process("Shipping Address") )  ));
					table1.addCell(new PdfPCell(new Paragraph(fontselector.process(s2) )  ));
					table1.addCell(new PdfPCell(new Paragraph(fontselector.process("TIN Number") )  ));
					table1.addCell(new PdfPCell(new Paragraph(fontselector.process(vendor[0][4]) )  ));
					 


					
					PdfPTable table2=new PdfPTable(2);
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process("Sale Date") )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process( perdata[0][4] ) )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process("Order Reference") )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process(perdata[0][19]) )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process("Payment Term") )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process(com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms WHERE INT_PAYMENTTERMID="+perdata[0][5])[0][1]) )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process("Despatch Through ") )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process(perdata[0][21]) )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process("Destination") )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process(perdata[0][22]) )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process("Terms of Delivery") )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process(perdata[0][23] ))  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process("Contact Person /Phone ") )  ));
					table2.addCell(new PdfPCell(new Paragraph(fontselector.process(perdata[0][24]+"/"+perdata[0][25]) )  ));
					  
					table.addCell (table1);
					table.addCell (table2);
					document.add(new Paragraph(""));
					
					
					
					document.add(table);
					
					
					PdfPTable table3=new PdfPTable(10);
					sql = "SELECT CHR_SALESNO,CHR_ITEMID,CHR_TYPE ,INT_QUANTITY,DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL,CHR_DESC , INT_TAXID, DOU_TAX_PERCENTAGE,DOU_TAX_AMOUNT  FROM inv_t_swapsalesitem WHERE CHR_SALESNO ='"+salesno+"'";
					
					String itemname="";
					String datas[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
					
					table3.addCell(new PdfPCell(new Paragraph(fontselector.process("Sl.No") )  ));
					table3.addCell(new PdfPCell(new Paragraph(fontselector.process("Product Code") )  ));
					table3.addCell(new PdfPCell(new Paragraph(fontselector.process("Description") )  ));
					table3.addCell(new PdfPCell(new Paragraph(fontselector.process("Quantity/Units") )  ));
					table3.addCell(new PdfPCell(new Paragraph(fontselector.process("Unit Price") )  ));
					table3.addCell(new PdfPCell(new Paragraph(fontselector.process("Discount(%)") )  ));
					table3.addCell(new PdfPCell(new Paragraph(fontselector.process("Unit Discount") )  ));
					table3.addCell(new PdfPCell(new Paragraph(fontselector.process("Tax Name") )  ));
					table3.addCell(new PdfPCell(new Paragraph(fontselector.process("Tax Amount") )  ));
					table3.addCell(new PdfPCell(new Paragraph(fontselector.process("Total") )  ));
					
					 
					for(int v=0;v<datas.length; v++)
					{	
						 
						if(datas[v][2].equals("I"))
						{
							
							sql = "SELECT CHR_ITEMNAME ,CHR_WARRANTY,CHR_DES FROM inv_m_item WHERE CHR_ITEMID='"+datas[v][1]+"'";
							itemname = CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
							
						}	
						if(datas[v][2].equals("P"))
						{
						  
						  sql= "SELECT CHR_PRODUCTCODE,CHR_WARRANTY,CHR_PRODUCTDESC FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+datas[v][1]+"'";
						  itemname=CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
						  
						}	
						
						
						table3.addCell(new PdfPCell(new Paragraph(fontselector.process(""+(v+1)+".") )  ));
						table3.addCell(new PdfPCell(new Paragraph(fontselector.process(itemname) )  ));
						table3.addCell(new PdfPCell(new Paragraph(fontselector.process(datas[v][8] ) )  ));
						
						cell = new PdfPCell ( new Paragraph (fontselector.process(datas[v][3] ) ));
						cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
						table3.addCell(cell);
						cell = new PdfPCell ( new Paragraph (fontselector.process(datas[v][4] ) ));
						cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
						table3.addCell(cell);
						cell = new PdfPCell ( new Paragraph (fontselector.process(datas[v][5] ) ));
						cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
						table3.addCell(cell);
						cell = new PdfPCell ( new Paragraph (fontselector.process(datas[v][6] ) ));
						cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
						table3.addCell(cell);
						
						cell = new PdfPCell ( new Paragraph (fontselector.process(com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_TAXNAME,DOU_VALUE FROM inv_m_tax WHERE INT_TAXID ="+datas[v][9])[0][0] +" ("+datas[v][10]+"  % )" ) ));
						cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
						table3.addCell(cell);
						cell = new PdfPCell ( new Paragraph (fontselector.process(datas[v][11] ) ));
						cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
						table3.addCell(cell);
						 
						
						
						cell = new PdfPCell ( new Paragraph (fontselector.process(datas[v][7] ) ));
						cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
						table3.addCell(cell);
					 
					 
					}	
					document.add(table3);
					
					
					
					
					
					PdfPTable table4=new PdfPTable(2);
					table4.addCell(new PdfPCell(new Paragraph(fontselector.process("Total Discount " ) )  ));
					cell = new PdfPCell ( new Paragraph (fontselector.process(perdata[0][10]+"( %)" ) ));
					cell.setColspan (2);
					cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
					table4.addCell(cell);
					table4.addCell(new PdfPCell(new Paragraph(fontselector.process("Tax Name" ) )  ));
					 
					sql = "SELECT CHR_TAXNAME,DOU_VALUE FROM inv_m_tax WHERE INT_TAXID ="+perdata[0][11];
					String taxdata[][] = CommonInfo.RecordSetArray(sql);
					 
					cell = new PdfPCell ( new Paragraph (fontselector.process(taxdata[0][0] ) ));
					cell.setColspan (2);
					cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
					table4.addCell(cell);
					
					table4.addCell(new PdfPCell(new Paragraph(fontselector.process("Tax" ) )  ));
					cell = new PdfPCell ( new Paragraph (fontselector.process(taxdata[0][1] ) ));
					cell.setColspan (2);
					cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
					table4.addCell(cell);
					  
					if("Y".equals(perdata[0][31]))
						table4.addCell(new PdfPCell(new Paragraph(fontselector.process(" By Back Description :: " ) )  ));
						 
					else
						table4.addCell(new PdfPCell(new Paragraph(fontselector.process("   " ) )  ));
					
					if("Y".equals(perdata[0][31]))
						table4.addCell(new PdfPCell(new Paragraph(fontselector.process(perdata[0][32] ) )  ));
						 
					else
						table4.addCell(new PdfPCell(new Paragraph(fontselector.process("   " ) )  ));

					
					PdfPTable table5=new PdfPTable(2);
					table5.addCell(new PdfPCell(new Paragraph(fontselector.process("Total" ) )  ));
					cell = new PdfPCell ( new Paragraph (fontselector.process(perdata[0][9]  ) ));
					cell.setColspan (2);
					cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
					table5.addCell(cell);
					
				 
					table5.addCell(new PdfPCell(new Paragraph(fontselector.process("Tax Amount" ) )  ));
					cell = new PdfPCell ( new Paragraph (fontselector.process(perdata[0][12]  ) ));
					cell.setColspan (2);
					cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
					table5.addCell(cell);
					
					  
					if("Y".equals(perdata[0][31]))
						table5.addCell(new PdfPCell(new Paragraph(fontselector.process("<b>By Back Amount</b>" ) )  ));
						 
					else
						table5.addCell(new PdfPCell(new Paragraph(fontselector.process(" " ) )  ));
					
					if("Y".equals(perdata[0][31]))
						table5.addCell(new PdfPCell(new Paragraph(fontselector.process(perdata[0][33] ) )  ));
						 
					else
						table5.addCell(new PdfPCell(new Paragraph(fontselector.process("" ) )  ));
					
					table5.addCell(new PdfPCell(new Paragraph(fontselector.process("Net Total " ) )  ));
					cell = new PdfPCell ( new Paragraph (fontselector.process(perdata[0][13]  ) ));
					cell.setColspan (2);
					cell.setHorizontalAlignment (Element.ALIGN_RIGHT);
					table5.addCell(cell);
					  
					
					PdfPTable table6=new PdfPTable(2);
					table6.addCell (table4);
					table6.addCell (table5);
					document.add(new Paragraph(""));
					document.add(table6);
					
					
					String amt[] =perdata[0][13].trim().replace(".", "-").split("-");
					
					
					PdfPTable table7=new PdfPTable(1);
					cell = new PdfPCell ( new Paragraph (fontselector.process(  "Amount in words ::"+com.my.org.erp.common.CommonFunctions.numberWord(amt[0]) ) ));
					cell.setHorizontalAlignment (Element.ALIGN_CENTER);
					table7.addCell(cell);
					document.add(table7);
					
					PdfPTable  table8=new PdfPTable(2);
					table8.addCell(new PdfPCell(new Paragraph(fontselector.process("PAN Number") )  ));
					table8.addCell(new PdfPCell(new Paragraph(fontselector.process(cpydata[0][14]) )  ));
					table8.addCell(new PdfPCell(new Paragraph(fontselector.process("CST  Number") )  ));
					table8.addCell(new PdfPCell(new Paragraph(fontselector.process(cpydata[0][10]) )  ));
					table8.addCell(new PdfPCell(new Paragraph(fontselector.process("TIN  Number") )  ));
					table8.addCell(new PdfPCell(new Paragraph(fontselector.process(cpydata[0][12]) )  ));
					table8.addCell(new PdfPCell(new Paragraph(fontselector.process("SERVICE TAX Number") )  ));
					table8.addCell(new PdfPCell(new Paragraph(fontselector.process(cpydata[0][15]) )  ));
					
					
				 
					
					PdfPTable  table9=new PdfPTable(2);
					cell = new PdfPCell ( new Paragraph (fontselector.process( "For  "+cpydata[0][0] +"\n\n\n\n (Authorised Signatory )" ) ));
					cell.setColspan (2);
					cell.setHorizontalAlignment (Element.ALIGN_CENTER);
					table9.addCell(cell);
					cell = new PdfPCell ( new Paragraph (fontselector.process( " \n\n\n( Receiver Sign & Seal )" ) ));
					cell.setColspan (2);
					cell.setHorizontalAlignment (Element.ALIGN_CENTER);
					table9.addCell(cell);
					  
					
					PdfPTable table10=new PdfPTable(2);
					table10.addCell (table8);
					table10.addCell (table9);
					document.add(new Paragraph(""));
					document.add(table10);
					
					PdfPTable table11=new PdfPTable(1);
					cell = new PdfPCell ( new Paragraph (fontselector.process( " Declaration :We declare that this invoice shows the actual price of the good descibed and that all particulars are true and correct. "  ) ));
					cell.setHorizontalAlignment (Element.ALIGN_CENTER);
					cell.setBackgroundColor (new Color (128, 200, 128));
					table11.addCell(cell);
					document.add(table11);
					
					PdfPTable table12=new PdfPTable(1);
					cell = new PdfPCell ( new Paragraph (fontselector.process( "* Terms : Goods once sold can't be taken back, Our responsibility ceases immediately after goods are delivered to the Carriers, Interest @24% p.a. will be charged extra if bills are not paid within the above mentioned payment terms. "  ) ));
					cell.setHorizontalAlignment (Element.ALIGN_CENTER);
					cell.setBackgroundColor (new Color (128, 200, 128));
					table12.addCell(cell);
					document.add(table12);
					
					  
				
				
				  String content = cpydata[0][0]+" " ;
					if(!"-".equals(cpydata[0][2]))
						content=content+cpydata[0][2];
					if(!"-".equals(cpydata[0][3]))	
						content=content+cpydata[0][3]+", " ;
					if(!"-".equals(cpydata[0][4])) 
						content=content+cpydata[0][4]+", " ;
					if(!"-".equals(cpydata[0][5]))
						content=content+" PIN  : " +cpydata[0][5]+". " ;	
					if(!"-".equals(cpydata[0][6]))
						content=content+" Phone : " +cpydata[0][6]+". " ;	
				
					PdfPTable table13=new PdfPTable(1);
					cell = new PdfPCell ( new Paragraph (fontselector.process( content  ) ));
					cell.setHorizontalAlignment (Element.ALIGN_CENTER);
					table13.addCell(cell);
					document.add(table13);
					document.close();
					
					
					
				}
				catch(Exception e)
				{         
					 System.out.println(e.getMessage());
				}     
				document.close(); 
				con.close();   
				response.sendRedirect("Smart Inventory/InventoryMain.jsp");
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
}

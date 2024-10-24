package com.my.org.erp.SmartInventory;

import com.my.org.erp.common.CommonFunctions;

public class InvoiceMail 
{
	public static String mailContent(String salesno ,String branchid)
	{
		String content="";
		String s ="";
		try
		{
			
			String sql="";
			String perdata[][]= CommonFunctions.QueryExecute("SELECT * FROM inv_t_directsales WHERE CHR_SALESNO='"+salesno+"'");
			
			String ssql="SELECT b.CHR_COMPANYNAME,a.CHR_BRANCHNAME,a.CHR_STREET,e.CHR_CITYNAME,d.CHR_STATENAME,a.INT_PINCODE,a.CHR_PHONE,  ";
			ssql = ssql +" a.CHR_FAX,a.CHR_EMAIL, a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO,a.CHR_LOCALTAXNO,a.CHR_PANNO, "; 
			ssql = ssql +" b.CHR_SERVICETAX FROM com_m_branch a , com_m_company b ,com_m_country c, com_m_state d, com_m_city e ";
			ssql = ssql +" WHERE  a.INT_CITYID = e.INT_CITYID ";
			ssql = ssql +" AND a.INT_COUNTRYID = c.INT_COUNTRYID ";
			ssql = ssql +" AND a.INT_STATEID =d.INT_STATEID ";
			ssql = ssql +" AND a.INT_COMPANYID = b.INT_COMPANYID  ";
			ssql = ssql +" AND a.INT_BRANCHID="+ branchid;
			String cpydata[][] =CommonFunctions.QueryExecute(ssql);
			String header ="";					   
			 header=cpydata[0][0]+"<br>";
			if(!"-".equals(cpydata[0][2]))
				header=header+cpydata[0][2]+"<br>";
			if(!"-".equals(cpydata[0][3]))	
				header=header+cpydata[0][3]+"<br>";
			if(!"-".equals(cpydata[0][4]))
				header=header+cpydata[0][4]+"<br>";
			if(!"-".equals(cpydata[0][5]))
				header=header+cpydata[0][5]+"<br>";	
			if(!"-".equals(cpydata[0][6]))
				header=header+cpydata[0][6]+"<br>";	

			
			
			
			s= s+ "<style type='text/css'> ";
			s= s+ ".style3 {	font-size: 18px; ";
			s= s+ "font-weight: bold; ";
			s= s+ "} ";
			s= s+ ".style7 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;} ";
		
			s= s+ ".boldEleven { ";
			s= s+ "FONT-WEIGHT: normal; ";
			s= s+ "FONT-SIZE: 10px; ";
			s= s+ "COLOR: #000000; ";
			s= s+ "LINE-HEIGHT: 15px; ";
			s= s+ "FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
			s= s+ "TEXT-DECORATION: none ";
			s= s+ "} ";
			s= s+ "</style> ";
			s= s+ "<center><body  onpaste='return false;'  ><div align='center'><br /> ";
			s= s+ "<table width='100%' border='0' cellspacing='1' cellpadding='1'   align='center'> ";
			s= s+ "<tr> ";
			s= s+ "<td><table width='600' border='1' align='center'   id='masterTbl' ";
			s= s+ "  bordercolor='red'  cellpadding=2 cellspacing=1   >  ";
			s= s+ "<tr> ";
			s= s+ "<td height='757'><table width='700' border='0' align='center' cellpadding='1' ";
			s= s+ "cellspacing='1'> ";
			s= s+ "<tr> ";
			s= s+ "<td width='650'></td> ";  
			s= s+ "</tr> ";
			s= s+ "<tr> ";
			s= s+ "<td>&nbsp;</td> ";
			s= s+ "</tr> ";
			s= s+ "<tr> ";
			s= s+ "<td><div align='center' class='style3'>Invoice</div></td> ";
			s= s+ "</tr> ";
			s= s+ "<tr> ";
			s= s+ "<td><table width='100%' border='0' align='center' cellpadding='2' cellspacing='2'> ";
			s= s+ "<tr> ";
			s= s+ "<td colspan='3' valign='top' class='boldEleven'>  ";
			
			 					   
			s= s+ "<b>"+cpydata[0][0]+"</b>,<br>" ;
			if(!"-".equals(cpydata[0][2]))
				s= s+ cpydata[0][2]+",<br>" ;
			if(!"-".equals(cpydata[0][3]))	
				s= s+ cpydata[0][3]+",<br>"  ;
			if(!"-".equals(cpydata[0][4]))
				s= s+ cpydata[0][4]+",<br>"  ;
			if(!"-".equals(cpydata[0][5]))
				s= s+ "PIN  : " +cpydata[0][5]+"." ;	
			if(!"-".equals(cpydata[0][6]))
				s= s+ "Phone : " +cpydata[0][6]+"." ;	
		   
								 
			s= s+ "</td> ";
			s= s+ "</tr> ";
			s= s+ "<tr> ";
			s= s+ "<td width='308' valign='top' class='boldEleven'><table width='100%' border='0' cellspacing='2' cellpadding='0'> ";
			s= s+ "<tr> ";
			s= s+ "<td width='36%' valign='top' class='boldEleven' align='left'><strong> Sales/Invoice .No </strong></td> ";
			s= s+ "<td width='64%' valign='top' class='boldEleven' align='left'>"+perdata[0][3]+"</td> ";
			s= s+ "</tr> ";
			s= s+ "<tr> ";
			s= s+ "<td valign='top' class='boldEleven' align='left'><strong>Billing  Address </strong></td>";
			s= s+ " <td valign='top' class='boldEleven' align='left'>";
				
			
			
			sql="SELECT a.INT_CUSTOMERID,f.CHR_NAME,a.CHR_ADDRESS1,a.CHR_ADDRESS2, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),CONCAT('Phone :',a.CHR_AREACODE,'-',a.CHR_PHONE),CONCAT('MOBILE :',a.CHR_MOBILE),CONCAT('E-Mail :',a.CHR_EMAIL),a.CHR_TIN,CHR_CST FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND a.INT_CUSTOMERID="+perdata[0][6];
			String vendor[][] =  CommonFunctions.QueryExecute(sql);
			
			if(!"-".equals(vendor[0][1]))
				s= s+ vendor[0][1]+",<br>" ;
			if(!"-".equals(vendor[0][2]))	
				s= s+ vendor[0][2]+",<br>" ;
			if(!"-".equals(vendor[0][3]))
				s= s+ vendor[0][3]+"<br>" ;
			if(!"-".equals(vendor[0][4]))
				s= s+ vendor[0][4]+"<br>" ;										
			if(!"-".equals(vendor[0][5]))
				s= s+ vendor[0][5]+"<br>" ;										
			if(!"-".equals(vendor[0][6]))
				s= s+ vendor[0][6]+"<br>" ;										
			if(!"-".equals(vendor[0][7]))
				s= s+ vendor[0][7]+"." ;										
				s= s+ " </td> ";
				s= s+ " </tr> ";
				s= s+ " <tr> ";
				s= s+ " <td valign='top' class='boldEleven' align='left'><strong>Shipping Address </strong></td> ";
				s= s+ " <td valign='top' class='boldEleven' align='left'> "  ;
						 
			  	if("S".equals(perdata[0][17]))
				{
			  		if(!"-".equals(vendor[0][1]))
						s= s+ vendor[0][1]+",<br>" ;
					if(!"-".equals(vendor[0][2]))	
						s= s+ vendor[0][2]+",<br>" ;
					if(!"-".equals(vendor[0][3]))
						s= s+ vendor[0][3]+"<br>" ;
					if(!"-".equals(vendor[0][4]))
						s= s+ vendor[0][4]+"<br>" ;										
					if(!"-".equals(vendor[0][5]))
						s= s+ vendor[0][5]+"<br>" ;										
					if(!"-".equals(vendor[0][6]))
						s= s+ vendor[0][6]+"<br>" ;										
					if(!"-".equals(vendor[0][7]))
						s= s+ vendor[0][7]+"." ;	
				}
				else
				{
					s= s+ perdata[0][18] ;
				}
				
			   
			  	s= s+ " </td>";
			  	s= s+ "  </tr>";
			  	s= s+ " <tr>";
			  	s= s+ " <td valign='top' class='boldEleven'><strong>TIN Number </strong></td>";
			  	s= s+ " <td valign='top' class='boldEleven'>"+vendor[0][11]+"</td>";
			  	s= s+ " </tr>";
			  	
			  	s= s+ " <tr>";
			  	s= s+ " <td valign='top' class='boldEleven'><strong>CST Number </strong></td>";
			  	s= s+ " <td valign='top' class='boldEleven'>"+vendor[0][12]+"</td>";
			  	s= s+ " </tr>";
			  	
			  	
			  	 
			  	s= s+ " </table></td>";
			  	s= s+ " <td width='278' valign='top' class='boldEleven'><table width='100%' height='185' border='0' cellpadding='0'	cellspacing='2'>";
			  	s= s+ " <tr>";
			  	s= s+ " <td width='40%' valign='top' class='boldEleven'><strong>Sale Date </strong></td>";
			  	s= s+ " <td width='60%' valign='top' class='boldEleven'>"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(perdata[0][4])+"</td>";
			  	s= s+ " </tr>";
			  	s= s+ " <tr>";
			  	s= s+ " <td valign='top' class='boldEleven'><strong>Order Reference </strong></td>";
			  	s= s+ " <td valign='top' class='boldEleven'>"+perdata[0][19]+"</td>";
			  	s= s+ " </tr>";
			  	s= s+ " <tr>";
			  	s= s+ " <td valign='top' class='boldEleven'><strong>Delivery Note </strong></td>";
			  	s= s+ " <td valign='top' class='boldEleven'>"+perdata[0][20]+"</td>";
			  	s= s+ " </tr>";
			  	s= s+ " <tr>";
			  	s= s+ " <td valign='top' class='boldEleven'><strong>Despatch Through </strong></td>";
			  	s= s+ " <td valign='top' class='boldEleven'>"+perdata[0][21]+"</td>";
			  	s= s+ " </tr>";
			  	s= s+ " <tr>";
			  	s= s+ " <td valign='top' class='boldEleven'><strong>Destination</strong></td>";
			  	s= s+ " <td valign='top' class='boldEleven'>"+perdata[0][22]+"</td>";
			  	s= s+ " </tr>";
			  	s= s+ " <tr>";
			  	s= s+ " <td valign='top' class='boldEleven'><strong>Terms of Delivery </strong></td>";
			  	s= s+ " <td valign='top' class='boldEleven'>"+perdata[0][23]+"</td>";
			  	s= s+ " </tr>";
			  	s= s+ " <tr>";
			  	s= s+ " <td valign='top' class='boldEleven'><strong>Contact Person </strong></td>";
			  	s= s+ " <td valign='top' class='boldEleven'>"+perdata[0][24]+"</td>";
			  	s= s+ " </tr>";
			  	s= s+ " <tr>";
			  	s= s+ " <td valign='top' class='boldEleven'><strong>Contact No </strong></td>";
			  	s= s+ " <td valign='top' class='boldEleven'>"+perdata[0][25]+"</td>";
			  	s= s+ " </tr>";
			  	s= s+ " </table></td>";
			  	s= s+ " </tr>";
			  	s= s+ " </table></td>";
			  	s= s+ " </tr>";
			  	s= s+ " <tr>";
			  	s= s+ " <td height='9'>";
			  	
			  					
			  					sql = " SELECT a.CHR_SALESNO,a.CHR_ITEMID, ";
			  					sql = sql + " a.CHR_TYPE , ";
			  					sql = sql + " a.INT_QUANTITY,a.DOU_UNITPRICE, ";
			  					sql = sql + " a.DOU_DISCOUNT,a.DOU_UNITDISCOUNT,a.DOU_TOTAL,a.CHR_DESC, b.CHR_TAXNAME, "; 
			  					sql = sql + " a.DOU_TAX_PERCENTAGE,a.DOU_TAX_AMOUNT, ";
			  					sql = sql + " if(a.CHR_TYPE='I','ITEM', 'PRODUCT' ),  ";
			  					sql = sql + " if(a.CHR_TYPE='I',  ";
			  					sql = sql + " ( SELECT b.CHR_ITEMNAME FROM inv_m_item b WHERE b.CHR_ITEMID=a.CHR_ITEMID), "; 
			  					sql = sql + " ( SELECT c.CHR_PRODUCTCODE FROM inv_m_produtlist c WHERE c.CHR_PRODUCTID=a.CHR_ITEMID) ), ";
			  					sql = sql + " if(a.CHR_TYPE='I',  ";
			  					sql = sql + "  ( SELECT b1.CHR_DES FROM inv_m_item b1 WHERE b1.CHR_ITEMID=a.CHR_ITEMID), ";
			  					sql = sql + "   ( SELECT c1.CHR_PRODUCTDESC FROM inv_m_produtlist c1 WHERE c1.CHR_PRODUCTID=a.CHR_ITEMID) ) ";   
			  					sql = sql + "   FROM inv_t_swapsalesitem  a, inv_m_tax b WHERE a.INT_TAXID =b.INT_TAXID AND a.CHR_SALESNO ='"+salesno+"'";

			  						
			  					 
								String datas[][] =  CommonFunctions.QueryExecute(sql);
								 
								 	
								s = s+ "<table border=1 width=99% cellpadding=0 cellspacing=0 >";
								s= s+ "<tr><th class='boldEleven'><strong>Sl.No</strong></th>";
								s= s+ "<th class='boldEleven'><strong >Product Code</strong></th>";
								s= s+ "<th class='boldEleven'><strong >Description</strong></th>";
								s= s+ "<th class='boldEleven'><strong >Quantity/Units</strong></th>";
								s= s+ "<th class='boldEleven'><strong >Unit Price</strong></th>";
								s= s+ "<th class='boldEleven'><strong >Discount(%)</strong></th>";
								s= s+ "<th class='boldEleven'><strong >Unit Discount</strong></th>";
								s= s+ "<th class='boldEleven'><strong >Tax Name</strong></th>";
								s= s+ "<th class='boldEleven'><strong >Tax Amount</strong></th>";
								s= s+ "<th class='boldEleven'><strong >Total</strong></th>";
								    
								for(int v=0;v<datas.length; v++)
								{	
									s= s+ "<tr>" ;
									 	
									s= s+ "<tr><td   class='boldEleven' >"+(v+1)+"</td>";
									s= s+ "<td valign='top'   class='boldEleven' >"+datas[v][13] +"</td>";
									s= s+ "<td valign='top'   class='boldEleven' >"+datas[v][8] +"</td>";
									s= s+ "<td valign='top'   class='boldEleven'  align='right' >"+datas[v][3] +"</td>";
									s= s+ "<td valign='top'   class='boldEleven'  align='right'>"+datas[v][4]  +"</td>";;
									s= s+ "<td valign='top'   class='boldEleven'  align='right'>"+datas[v][5]  +"</td>";
									s= s+ "<td valign='top'   class='boldEleven'  align='right'>"+datas[v][6]  +"</td>";
									s= s+ "<td valign='top'   class='boldEleven'  align='right'>"+datas[v][9]  +"</td>";
									s= s+ "<td valign='top'   class='boldEleven'  align='right'>"+datas[v][11] +"</td>";
									s= s+ "<td valign='top'   class='boldEleven'  align='right' >"+datas[v][7] +"</td>";
								}	
								s= s+ "</table>";	
								 
								
								
								
								s= s+ "</td> ";
								s= s+ "</tr> ";
								s= s+ "<tr> ";
								s= s+ "<td valign='top'><table cellspacing='1' cellpadding='1' width='100%' align='center' border='0'> ";
								s= s+ "<tbody> ";
								s= s+ "<tr> ";
								s= s+ "<td width='240' rowspan='3' valign='top'><table width='227' border='0' cellspacing='2' cellpadding='0'> ";
								s= s+ "<tr> ";
								s= s+ "<td width='92' class='boldEleven'><strong>Total Discount </strong></td> ";
								s= s+ "<td class='boldEleven'><div align='right'>"+perdata[0][10]+"(%)</div></td> ";
								s= s+ "</tr> ";
								s= s+ "<tr> ";
								s= s+ "<td class='boldEleven'><strong>Tax Name </strong></td> ";
								s= s+ "<td class='boldEleven'><div align='right'> ";
								
	                    
								sql = "SELECT CHR_TAXNAME,DOU_VALUE FROM inv_m_tax WHERE INT_TAXID ="+perdata[0][11];
								String taxdata[][] =  CommonFunctions.QueryExecute(sql);
								s= s+ taxdata[0][0] ;
								  
								s= s+ "</div></td> ";
								s= s+ "</tr> ";
								s= s+ "<tr> ";
								s= s+ "<td class='boldEleven'><strong>Tax </strong></td> ";
								s= s+ "<td class='boldEleven'><div align='right'>"+taxdata[0][1] +"(%)</div></td> ";
								s= s+ "</tr> ";
								s= s+ "</table></td> ";
								s= s+ "<td valign='top' width='121'>&nbsp;</td> ";
								s= s+ "<td width='140' valign='top' class='boldEleven'><div align='left'><strong>Total</strong></div></td> ";
								s= s+ "<td width='182' valign='top' class='boldEleven' id='totals1'><div align='right'>"+perdata[0][9]+"</div></td> ";
								s= s+ "</tr> ";
								s= s+ "<tr> ";
								s= s+ "<td valign='top' width='121'>&nbsp;</td> ";
								s= s+ "<td valign='top' class='boldEleven'><div align='left'><strong> Tax Amount </strong></div></td> ";
								s= s+ "<td width='182' valign='top' class='boldEleven' id='totaldiscount1'><div align='right'>"+perdata[0][12]+"</div></td> ";
								s= s+ "</tr> ";
								s= s+ "<tr> ";
								s= s+ "<td valign='top' width='121'>&nbsp;</td> ";
								s= s+ "<td valign='top' class='boldEleven'><div align='left'><strong>Net Total </strong></div></td> ";
								s= s+ "<td width='182' valign='top' class='boldEleven' id='tax1'><div align='right'>"+perdata[0][13]+"</div></td> ";
								s= s+ "</tr> ";
								s= s+ "</tbody> ";
								s= s+ "</table></td> ";
								s= s+ "</tr> ";
								s= s+ " <tr> ";
								s= s+ "<td class='bolddeeplogin'>Amount in words ::</td> ";
								s= s+ "</tr> ";
								s= s+ "<tr> ";
								s= s+ "<td><table width='80%' border='0' align='center' cellpadding='0' cellspacing='0'> ";
								s= s+ "<tr> ";
								s= s+ "<td align='center' class='boldEleven'><div id='Rupees'> ";
								String amt[] =perdata[0][13].trim().replace(".", "-").split("-");
								s= s+ com.my.org.erp.common.CommonFunctions.numberWord(amt[0]);
								s= s+ "</div></td> ";
	                            s= s+ "</tr> ";
	                            s= s+ "</table></td> ";
	                            s= s+ "</tr> ";
	                            s= s+ "<tr> ";
	                            s= s+ "<td align='center' class='bold1'></td> ";
	                            s= s+ "</tr> ";
	                            s= s+ "<tr> ";
	                            s= s+ "<td>&nbsp;</td> ";
	                            s= s+ "</tr> ";
	                            s= s+ "<tr> ";
	                            s= s+ "<td><div align='center'> ";
	                            
			                       
				int row=1;
				 
				sql = "SELECT INT_ID,CHR_SALESNO,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY,CHR_TYPE,CHR_SWAPDESC,CHR_DESC FROM inv_t_swapsalesserialno WHERE CHR_SALESNO ='"+salesno+"' ORDER By INT_ID";
				String recdData[][]=  CommonFunctions.QueryExecute(sql);
				 
							
			 
				
				if(recdData.length>0)
				{
					String spec="Serial Number :";
					if(recdData.length>1)
						spec="Serial Numbers :";
					s= s+ "<table align='left' cellspacing=0 cellpadding=0><tr><td class='boldElevenPrint'><b>"+spec+"</b><tr>";
					int cv=1;
					for(int v=0;v<recdData.length; v++)
					{
						s= s+ "<td class='boldElevenPrint' width='125'>"+recdData[v][3]+",  ";
						if(cv ==7 )
						{
							cv =0;
							s= s+ "<tr>";
						}
						cv = cv+1;
					}
					s= s+ "</table>";
				}
			 
				
				
				
			 
				s= s+ "<input name='seriallength' type='hidden' id='seriallength' value='"+row+"'>"; 
				s= s+ "</div></td>";
				s= s+ " </tr>";
				s= s+ "<tr>";
				s= s+ "<td><input name='filename' type='hidden' value='DirectSale' />"; 
				s= s+ "<input name='actionS' type='hidden' value='INVDirectSaleAddserial' /></td>"; 
				s= s+ "</tr>"; 
				s= s+ "<tr>"; 
				s= s+ "<td></td>"; 
				s= s+ "</tr>"; 
				s= s+ "<tr>"; 
				s= s+ "<td height='38' valign='top' class='boldEleven'><table width='99%' border='1' align='center' cellpadding='0'	cellspacing='0'>"; 
				s= s+ "<tr>"; 
				s= s+ "<td width='46%' valign='top'><table width='100%' border='0' cellspacing='2' cellpadding='2'>"; 
				s= s+ "<tr>"; 
				s= s+ "<td class='boldEleven'><strong>Local Tax No</strong>. "+cpydata[0][13]+"</td>"; 
				s= s+ "</tr>"; 
				s= s+ "<tr>"; 
				s= s+ "<td class='boldEleven'><strong>CST No : </strong> "+cpydata[0][10]+" </td>";
				s= s+ "</tr> ";
				s= s+ "<tr> ";
				s= s+ "<td><strong>TIN No : </strong><span class='style7'>"+cpydata[0][12]+"</span></td> ";
				s= s+ "</tr> ";
				s= s+ "<tr> ";
				s= s+ "<td class='boldEleven'><strong>Declaration </strong>:</td> ";
				s= s+ "</tr> ";
				s= s+ "<tr> ";
				s= s+ "<td class='boldEleven'><div align='justify'>We declare that this invoice shows ";
				s= s+ "the actual price of the good descibed and that all particulars ";
				s= s+ "are true and correct.</div></td> ";
				s= s+ "</tr> ";
				s= s+ "</table></td> ";
				s= s+ "<td width='54%' valign='top'><table width='100%' border='0' cellspacing='2' cellpadding='2'> ";
				s= s+ "<tr> ";
				s= s+ "<td class='bolddeeplogin'><div align='right'> ";
				s= s+ "'For  "+cpydata[0][0] ;
									 
				s= s+ "</div></td> ";
				s= s+ "</tr> ";
				s= s+ "<tr> ";
				s= s+ "<td class='boldEleven'>&nbsp;</td> ";
				s= s+ "</tr> ";
				s= s+ "<tr> ";
				s= s+ "<td class='boldEleven'>&nbsp;</td> ";
				s= s+ "</tr> ";
				s= s+ "<tr> ";
				s= s+ "<td class='boldEleven'>&nbsp;</td> ";
				s= s+ "</tr> ";
				s= s+ "<tr> ";
				s= s+ "<td class='boldEleven'><div align='right'><strong>(Authorised ";
				s= s+ "Signatory ) </strong></div></td> ";
				s= s+ "</tr> ";
				s= s+ "</table></td> ";
				s= s+ "</tr> ";
				
				
			  
			  
				s= s+ "</table></td> ";
				s= s+ "</tr> ";
				s= s+ "<tr> ";
				s= s+ "<td><table width='100%' border='0' cellspacing='0' cellpadding='0'> ";
				s= s+ "<tr> ";
				s= s+ "<td width='72%'><div align='justify'><strong>* Terms :</strong> <span class='boldEleven'>Goods once sold can't be taken back, Our responsibility ceases immediately after goods are delivered to the Carriers, Interest @24% p.a. will be charged extra if bills are not paid within the above mentioned payment terms. </span></div></td> ";
				s= s+ "<td width='28%' valign='bottom'><div align='right'><strong>(Receiver Sign &amp; Seal ) </strong></div></td> ";
				s= s+ "</tr> ";
				s= s+ "</table></td> ";
				s= s+ " </tr> ";
				s= s+ "</table></td> ";
				s= s+ "</tr> ";
				s= s+ "</table></td> ";
				s= s+ "</tr> ";
				s= s+ "<tr> ";
				s= s+ "<td>&nbsp;</td> ";
			       s= s+ "</tr> ";
			      s= s+ "</table> ";
			    s= s+ "</div> </body></center>";
			 
			    content=s;
			
			
			
			
			
			
			
			
			return content;
		}
		catch(Exception e)
		{
			 
		}
		return null;
	
	}
}

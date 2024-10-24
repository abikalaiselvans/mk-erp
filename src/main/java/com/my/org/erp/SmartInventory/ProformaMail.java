package com.my.org.erp.SmartInventory;

import com.my.org.erp.common.CommonFunctions;

public class ProformaMail 
{


	public static String mailContent(String Quotationid ,String branchid)
	{
		 
		String s=" ";
		try
		{ 
			String ssql="SELECT b.CHR_COMPANYNAME,a.CHR_BRANCHNAME,a.CHR_STREET,e.CHR_CITYNAME,d.CHR_STATENAME,a.INT_PINCODE,a.CHR_PHONE,  ";
			ssql = ssql +" a.CHR_FAX,a.CHR_EMAIL, a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO,a.CHR_LOCALTAXNO,a.CHR_PANNO, "; 
			ssql = ssql +" b.CHR_SERVICETAX ,d1.CHR_DISTRICT FROM com_m_branch a , com_m_company b ,com_m_country c, com_m_state d, com_m_district d1, com_m_city e ";
			ssql = ssql +" WHERE  a.INT_CITYID = e.INT_CITYID ";
			ssql = ssql +" AND a.INT_COUNTRYID = c.INT_COUNTRYID ";
			ssql = ssql +" AND a.INT_STATEID =d.INT_STATEID AND a.INT_DISTRICTID =d1.INT_DISTRICTID  ";
			ssql = ssql +" AND a.INT_COMPANYID = b.INT_COMPANYID  ";
			ssql = ssql +" AND a.INT_BRANCHID="+ branchid;
			String cpydata[][]=CommonFunctions.QueryExecute(ssql);
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
			
			 
			String poId=Quotationid;
			String sql="SELECT INT_PROFORMAID,CHR_PROFORMANO,INT_CUSTOMERID,"+
			" DATE_FORMAT(DAT_PROFORMADATE,'%d-%b-%Y'),DATE_FORMAT(DAT_REQUESTDATE,'%d-%b-%Y'),CHR_ONHOLD,INT_CONDITIONID,"+
			" CHR_DES,CHR_REF,INT_TAXID,DOU_DISCOUNT,DOU_TAXAMOUNT,"+
			" DOU_TOTALAMOUNT,CHR_STATUS,DOU_AMOUNT,CHR_ADDRESSID1,CHR_ADDRESSID2,CHR_CONTACTDETAILS,CHR_CONTACTNO,ROUND(DOU_TOTALAMOUNT,2) "+
			" from  inv_t_proforma  where CHR_PROFORMANO='"+poId+"'";
			//out.println(sql);			
			String purchaseInfo[][] =  CommonFunctions.QueryExecute(sql);	

			s = s + " <table width='800' border='1' cellpadding='0' cellspacing='0' bordercolor='#999999'> ";
			s = s + " <tr> ";
			s = s + " <td align='center' valign='middle'> ";
			s = s + " <table width='95%' border='0' align='center' cellpadding='1' cellspacing='1'> ";
			s = s + " 	<tr> ";
			s = s + " <td  ></td> ";
			s = s + " </tr> ";
			s = s + " <tr> ";
			s = s + " <td>&nbsp;</td> ";
			s = s + " </tr> ";
			s = s + " <tr> ";
			s = s + " <td height='27' class='boldEleven'> ";
			s = s + " <div align='center' ><h2><b>PROFORMA</b></h2></div>				</td> ";
			s = s + " </tr> ";
			s = s + " <tr> ";
			s = s + " <td  class='boldEleven'> ";
			
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
		   
			
			s = s + " </td> ";
			s = s + " </tr> ";
			s = s + " <tr> ";
			s = s + " <td> ";
			s = s + " <table width='99%' border='0' align='center' cellpadding='5'	cellspacing='3'> ";
			s = s + " <tr><td width='123' class='boldEleven'> <div align='left'><strong>PROFORM NO</strong></div></td> ";
			s = s + " <td width='229' class='boldEleven'> <div align='left'>"+purchaseInfo[0][1]+"</div></td> ";
			s = s + " <td width='107' class='boldEleven'>	<div align='left'><strong> </strong><strong>Payment Terms </strong></div>						</td> ";
			s = s + " <td width='201' class='boldEleven'><div align='left'> ";
			String paymentids[][] =  CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms where INT_PAYMENTTERMID="+purchaseInfo[0][6]);
			s = s + paymentids[0][1]; 
			s = s + " </div> </td> ";
			s = s + " </tr> ";
						
			s = s + " <tr> ";
			s = s + " <td class='boldEleven'><strong>Contact Person </strong></td> "  ;
			s = s + " <td class='boldEleven'>"+ purchaseInfo[0][17] +"</td> "  ;
			s = s + " <td class='boldEleven'><div align='left'><strong>Quo Date</strong></div></td> ";
			s = s + " <td class='boldEleven'><div align='left'>"+purchaseInfo[0][3] +"</div></td> ";
			s = s + " </tr> ";
			
			s = s + " <tr> ";
			s = s + " <td class='boldEleven'><strong>Contact Number </strong></td> "  ;
			s = s + " <td class='boldEleven'>"+ purchaseInfo[0][18]  +"</td> "  ;
			s = s + " <td class='boldEleven'><strong>Request Date</strong></td> ";
			s = s + " <td class='boldEleven'>"+purchaseInfo[0][4]+"</td> ";
			s = s + " </tr> ";
			
			s = s + " <tr> ";
			s = s + " <td valign='top' class='boldEleven'><strong>Order From </strong></td> ";
			s = s + " <td class='boldEleven'>"+purchaseInfo[0][15]+"</td> ";
			s = s + " <td valign='top' class='boldEleven'><strong>Shipping To </strong></td> "  ;
			s = s + " <td class='boldEleven'>"+purchaseInfo[0][16]+"</td> "  ;
			s = s + " </tr> "  ;
					 
			 
			s = s + " <tr> "  ;
			s = s + " <td class='boldEleven'><strong>Description :: </strong></td> "  ;
			s = s + "  <td align='left' valign='top' class='boldEleven'>"+purchaseInfo[0][7] ;
			s = s + "  </td> "  ;
			s = s + " </tr> "  ;
			s = s + " </table> "  ;
			s = s + " </td> "  ;
			s = s + " </tr> "  ;
			s = s + " <tr> "  ;
			s = s + " <td> "  ;
			
			 
			s = s + "  <table width='100%'  border='1' cellspacing='1' cellpadding='1' >";
			s = s + " <tr>";
			s = s + " <td  class='boldEleven' align='center'><b>S.No</b></td>";
			s = s + " <td  class='boldEleven' align='center'><b>Type</b></td>";
			s = s + " <td  class='boldEleven' align='center'><b>Item / Product</b></td>";
			s = s + " <td  class='boldEleven' align='center'><b>Description</b></td>";
			s = s + " <td  class='boldEleven' align='center'><b>Quantity</b></td>";
			s = s + " <td  class='boldEleven' align='center'><b>Warranty</b></td>";
			s = s + " <td  class='boldEleven' align='center'><b>Unit Price</b></td>";
			//s = s + " <td  class='boldEleven'><b>Discount(%)</b></td>";
			//s = s + " <td  class='boldEleven'><b>Unit Discount</b></td>";
			//s = s + " <td  class='boldEleven'><b>Tax</b></td>";
			//s = s + " <td  class='boldEleven'><b>Tax (%)</b></td>";
			//s = s + " <td  class='boldEleven'><b>Tax Amount </b></td>";
			s = s + " <td  class='boldEleven'><b>Total</b></td>";
			s = s + " </tr>";
			sql = " SELECT  ";
			sql = sql +" if(a.CHR_TYPE='I','Item','Product'), ";
			sql = sql +" if( a.CHR_TYPE ='I' , ";
			sql = sql +" (SELECT a1.CHR_ITEMNAME FROM inv_m_item a1  WHERE  a1.CHR_ITEMID =a.CHR_ITEMID), ";
			sql = sql +" (SELECT a2.CHR_PRODUCTCODE FROM inv_m_produtlist a2  WHERE  a2.CHR_PRODUCTID =a.CHR_ITEMID)";
			sql = sql +" ) productcode, ";
			sql = sql +" a.CHR_DESC,a.INT_QUANTITY,a.DOU_UNITPRICE,a.DOU_DISCOUNT,a.DOU_UNITDISCOUNT,  ";
			sql = sql +" b.CHR_TAXNAME,a.DOU_TAX_PERCENTAGE, ";
			sql = sql +" a.DOU_TOTAL ,a.DOU_TAX_AMOUNT,IF(a.INT_WARRANTY=0,'NO WARRANTY',CONCAT(a.INT_WARRANTY,'-Yrs')) ";
			sql = sql +" from inv_t_proformaitem  a,inv_m_tax b ";
			sql = sql +"  WHERE a.INT_TAXID =b.INT_TAXID AND CHR_PROFORMANO ='"+poId+"' ";
			 String purchaseItem[][] =  CommonFunctions.QueryExecute(sql);	
			 
			for(int i=0;i<purchaseItem.length;i++)
			{
				s = s + " <tr>";
				s = s + "  <td class='boldEleven'>&nbsp;"+(i+1)+".</td>";	
				s = s + "  <td class='boldEleven'>&nbsp;"+purchaseItem[i][0]+"</td>";		
				s = s + "  <td class='boldEleven'>&nbsp;"+purchaseItem[i][1]+"</td>";		
				s = s + " <td class='boldEleven'>&nbsp;"+purchaseItem[i][2]+"</td>";		
				s = s + " <td class='boldEleven'>&nbsp;"+purchaseItem[i][3]+"</td>";
				s = s + " <td class='boldEleven'>&nbsp;"+purchaseItem[i][11]+"</td>";
				s = s + " <td class='boldEleven' align='right'>&nbsp;"+purchaseItem[i][4]+"</td>";		
				//s = s + " <td class='boldEleven' align='right'>&nbsp;"+purchaseItem[i][5]+"</td>";		
				//s = s + " <td class='boldEleven' align='right'>&nbsp;"+purchaseItem[i][6]+"</td>";		
				//s = s + " <td class='boldEleven' align='right'>&nbsp;"+purchaseItem[i][7]+"</td>";		
				//s = s + " <td class='boldEleven' align='right'>&nbsp;"+purchaseItem[i][8]+"</td>";		
				//s = s + " <td class='boldEleven' align='right'>&nbsp;"+purchaseItem[i][9]+"</td>";		
				s = s + " <td class='boldEleven' align='right'>&nbsp;"+purchaseItem[i][10]+"</td>";		
				s = s + " </tr>";
			}
			s = s + " </table>";
			
			 
		 
					 
				s = s + " </td> ";
				s = s + " </tr> ";
				s = s + " <tr> ";
				s = s + " <td> ";
				s = s + " <div align='left'></div> ";
				s = s + " </td> ";
				s = s + " </tr> ";
				s = s + " <tr> ";
				s = s + " <td></td> ";
				s = s + " </tr> ";
				s = s + " <tr> ";
				s = s + " <td valign='top' class='boldEleven'> ";
				
				
				
				
				

				s = s + " <table width='100%' border='0' align='center' cellpadding='1' cellspacing='1'> ";
				s = s + " <tr> ";
				s = s + " <td rowspan='3' align='left' valign='top' class='boldEleven'><div align='left'> ";
				s = s + " <table border='1' cellpadding='2' cellspacing='0' bordercolor='#CCCCCC' width='300'>";
				s = s + " <tr   bgcolor='#ffffff'>";
				s = s + " <td class='boldEleven' align='center'><b>Tax</b></td>";
				s = s + " <td class='boldEleven' align='center'><b> Value</b></td>";
				s = s + " <td class='boldEleven' align='center'><b>Tax Amount</b></td>";
				s = s + " </tr>";
				double tvalue=0;
				sql="SELECT SUM(a.DOU_UNITPRICE*a.INT_QUANTITY),b.CHR_TAXNAME,a.DOU_TAX_PERCENTAGE,SUM(a.DOU_TAX_AMOUNT)";
				sql = sql + " FROM inv_t_customerquotationitem a, inv_m_tax b ";
				sql = sql+ "  WHERE a.INT_TAXID = b.INT_TAXID AND a.DOU_TAX_PERCENTAGE >0 ";
				sql = sql+ "  AND a.CHR_QUOTATIONNO ='"+poId+"' ";
				sql = sql+ "  GROUP BY a.INT_TAXID ";
				String tData[][] =  CommonFunctions.QueryExecute(sql);
				if(tData.length>0)
				{
					for(int k=0; k<tData.length;k++)
					{
						s = s + " <tr   bgcolor='#ffffff'>";
						s = s + " <td class='boldEleven' >"+tData[k][1]+"</td>";
						s = s + " <td class='boldEleven'  align='right' >"+tData[k][0]+"</td>";
						s = s + " <td class='boldEleveboldElevennPrint'  align='right' >"+tData[k][3]+"</td>";
						tvalue = tvalue + Double.parseDouble(tData[k][3]);
						s = s + " </tr>";
					}
				}
				sql ="SELECT CHR_TAXNAME,DOU_VALUE FROM inv_m_tax WHERE INT_TAXID ="+purchaseInfo[0][9];
				double taxvalues = Double.parseDouble(CommonFunctions.QueryExecute(sql)[0][1]);
				if(taxvalues>0)
				{
					s = s + " <tr   bgcolor='#ffffff'>";
					s = s + " <td class='boldEleven' >"+CommonFunctions.QueryExecute(sql)[0][0]+"</td>";
					s = s + " <td class='boldEleven' align='right' >"+ purchaseInfo[0][14] +"</td>";
					s = s + " <td class='boldEleven' align='right' >"+ purchaseInfo[0][11] +"</td>";
					tvalue = tvalue + Double.parseDouble(purchaseInfo[0][11]);
					s = s + " </tr>";
				}	
				s = s + " </table>";

				 
				s = s + " </div></td> ";
				s = s + " <td width='148'   valign='top' class='boldEleven'><div align='left'><strong>Total</strong></div></td> ";
				s = s + " <td  valign='top' class='boldEleven' id='totals1'><div align='right'>"+purchaseInfo[0][14]+" </div></td> ";
				s = s + " </tr> ";
				s = s + " <tr> ";
				s = s + " <td valign='top' class='boldEleven'><strong>Tax Amount </strong></td> ";
				s = s + " <td valign='top' class=''boldEleven' '><div align='right'>"+tvalue+"</div></td> ";
				s = s + " </tr> ";
				s = s + " <tr> ";
				s = s + " <td valign='top' class='boldEleven'><div align='left'><strong>Net Total </strong></div> ";
				s = s + " <strong> </strong></td> ";
				s = s + " <td width='123' valign='top' class='boldEleven' ";
				s = s + " id='totaldiscount1'><div align='right'>"+purchaseInfo[0][12]+"</div></td> ";
				s = s + " </tr> ";

 
				s = s + " <td colspan='4' class='boldEleven'><span class='bolddeeplogin'>Amount in words ::</span></td> ";
				s = s + " </tr> ";
				s = s + " <tr> ";
				s = s + " <td colspan='4' class='boldEleven'><div id='Rupees' align='center'> ";
				String amt[] =purchaseInfo[0][12].trim().replace(".", "-").split("-");
				s= s+  CommonFunctions.numberWord(amt[0]);		     
				s = s + " </div></td> ";
			  	s = s + "  </tr> ";
			  	s = s + " </table> ";
			  	
			  	s = s + " </td> ";
			  	s = s + " </tr> ";
			  	s = s + " </table> ";
			  	s = s + " </td> ";
			  	s = s + " </tr> ";
			  	s = s + " </table> ";
			  
			
			
			
			return s;
		}
		catch(Exception e)
		{
			 
		}
		return null;
	
	}

}

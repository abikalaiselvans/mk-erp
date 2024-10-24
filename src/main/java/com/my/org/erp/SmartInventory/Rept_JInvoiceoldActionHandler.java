package com.my.org.erp.SmartInventory;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JasperPrint;
 
import com.my.org.erp.SmartReport.ReportFunctions2;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JInvoiceoldActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	String cmpyname="";
	String officename="";
	String deptname="";
	String hImageExpression="";
	String fImageExpression="";
	String RsImgExpression="";
	String logoImgExpression="";
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			String salesno = request.getParameter("salno");
			String chkserial = ""+request.getParameter("serialyes");
			
			if (action.equals("INVRept_JInvoice")) 
			{
				File reportDir = new File(Path + "/report/Inventory/" + rptfilename+".jrxml");
				File rupeesImage = new File(Path + "/Image/report/Rupee.jpeg");
				File logoImage = new File(Path + "/images/hImage.jpg");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				List<Hashtable> al=new ArrayList<Hashtable>();
				 
				
				RsImgExpression=(rupeesImage.exists())?"../../Image/report/Rupee.jpeg":null;
				logoImgExpression=(logoImage.exists())?"../../images/hImage.jpg":null;
				map.put("RsImgExpression", RsImgExpression);
				map.put("logoImgExpression", logoImgExpression);
				try
				{ 
					String sql="";
					String perdata[][]=CommonFunctions.QueryExecute("SELECT CHR_SALESNO,DAT_SALESDATE,FIND_A_CUSTOMER_ADDRESS3(INT_CUSTOMERID)," +
							"CHR_SHIPPING,CHR_SHIPPINGADDRESS,CHR_OTHERREF,INT_PAYMENTTERMID,CHR_DESPATCHTHRU,CHR_DESTINATION," +
							"CHR_TERMSOFDELIVERY,CHR_CONTACTDETAILS,CHR_CONTACTNO,DOU_AMOUNT,DOU_DISCOUNT,INT_TAXID,DOU_TAXAMOUNT,DOU_TOTALAMOUNT," +
							"CHR_BYBACK,CHR_BYBACKDESC,DOU_BYBACKAMOUNT FROM inv_t_directsales WHERE CHR_SALESNO='"+salesno+"'");
					map.put("invoiceNo", perdata[0][0]);
					String dt=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(perdata[0][1]);
					map.put("dt",dt);
					String ssql=" ";
				ssql = " SELECT b.CHR_COMPANYNAME,a.CHR_BRANCHNAME,a.CHR_STREET,e.CHR_CITYNAME,d.CHR_STATENAME,a.INT_PINCODE,a.CHR_PHONE,  ";
				ssql = ssql +" a.CHR_FAX,a.CHR_EMAIL, a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO,a.CHR_LOCALTAXNO,a.CHR_PANNO, "; 
				ssql = ssql +" b.CHR_SERVICETAX FROM com_m_branch a , com_m_company b ,com_m_country c, com_m_state d, com_m_city e ";
				ssql = ssql +" WHERE  a.INT_CITYID = e.INT_CITYID ";
				ssql = ssql +" AND a.INT_COUNTRYID = c.INT_COUNTRYID ";
				ssql = ssql +" AND a.INT_STATEID =d.INT_STATEID ";
				ssql = ssql +" AND a.INT_COMPANYID = b.INT_COMPANYID  ";
				ssql = ssql +" AND a.INT_BRANCHID=20";//+ request.getAttribute("BRANCHID");
				String cpydata[][]=CommonFunctions.QueryExecute(ssql);
						 				map.put("cusAddr", perdata[0][2]);
										map.put("cusTIN", "");
										map.put("cusCST", "");
									
										  	if("S".equals(perdata[0][3]))
											{
										  		map.put("cusDeliAddr",perdata[0][2]);
											}
											else
											{
												map.put("cusDeliAddr", perdata[0][4]);
											}
										  	map.put("orderRef", perdata[0][5]);
										  	map.put("payTerm", com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms WHERE INT_PAYMENTTERMID="+perdata[0][6])[0][1]);
										  	map.put("despatchThrough", perdata[0][7]);
										  	map.put("destination", perdata[0][8]);
										  	map.put("termsOfDelivery", perdata[0][9]);
										  	map.put("cp", perdata[0][10]);
											map.put("ph", perdata[0][11]);
										
									sql = "SELECT CHR_SALESNO,CHR_ITEMID,CHR_TYPE ,INT_QUANTITY,DOU_UNITPRICE,DOU_DISCOUNT, DOU_UNITDISCOUNT,DOU_TOTAL,CHR_DESC, INT_TAXID, DOU_TAX_PERCENTAGE,DOU_TAX_AMOUNT  FROM inv_t_swapsalesitem WHERE CHR_SALESNO ='"+salesno+"'";
									 
									String itemname="";
									String datas[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
									String typedesc="";	
								
									int i=0; 
									map.put("t1Length", datas.length);
									for(int v=0;v<datas.length; v++)
									{
										Hashtable h1 = new Hashtable();
									if(!datas[v][1].equals(null))
									{
										++i;
										h1.put("sno", ""+i);
										if(datas[v][2].equals("I"))
										{
											 
											sql = "SELECT CHR_ITEMNAME ,CHR_WARRANTY,CHR_DES FROM inv_m_item WHERE CHR_ITEMID='"+datas[v][1]+"'";
											itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
										
											h1.put("itemType", datas[v][2]);
											h1.put("itemname", itemname);
											typedesc=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_DES");
											h1.put("typedesc", typedesc);
											
										}	
										if(datas[v][2].equals("P"))
										{
										  
										  sql= "SELECT CHR_PRODUCTCODE,CHR_WARRANTY,CHR_PRODUCTDESC FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+datas[v][1]+"'";
										  itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
										  h1.put("itemType", datas[v][2]);
										  h1.put("itemname", itemname);
										  typedesc=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTDESC");
										  h1.put("typedesc", typedesc);
										  
										}	
										
										
										h1.put("qty", datas[v][3]);
										h1.put("unitPrice", Double.parseDouble(datas[v][4]));
										h1.put("discount", Double.parseDouble(datas[v][5]));
										h1.put("unitDiscount", Double.parseDouble(datas[v][6]));
										h1.put("tax",CommonFunctions.QueryExecute("SELECT CHR_TAXNAME,DOU_VALUE FROM inv_m_tax WHERE INT_TAXID ="+datas[v][9])[0][0]+" ("+datas[v][10]+"%)");
										h1.put("taxAmt", Double.parseDouble(datas[v][11]));
										h1.put("tot", Double.parseDouble(datas[v][7]));
										
										al.add(h1);
									}
									}	
									
									
									sql = "SELECT CHR_TAXNAME,DOU_VALUE FROM inv_m_tax WHERE INT_TAXID ="+perdata[0][14];
									String taxdata[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
									map.put("sTotDiscount",perdata[0][13]+"%"); 
									map.put("tax1",taxdata[0][0]);
									map.put("taxDiscount",taxdata[0][1]+"%");
									
									map.put("sTot",Double.parseDouble(perdata[0][12]));
									map.put("sTaxAmt",Double.parseDouble(perdata[0][15]));
									
															if("Y".equals(perdata[0][17])){
																map.put("colon", ":");
																map.put("sTaxDestitle","By Back Amount");
									  							map.put("sTaxDes",perdata[0][19]);						
									  							map.put("sTaxDestitle1","By Back Description :");
																map.put("sTaxDes1",perdata[0][18]);
															}
																map.put("netAmt",Double.parseDouble(perdata[0][16]));		
																String nAmt=""+Math.round(Double.parseDouble(perdata[0][16]));
																map.put("netAmountWord",CommonFunctions.numberWord1(nAmt));
												
				
					 
					itemname="";
					sql = "SELECT INT_ID,CHR_SALESNO,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY,CHR_TYPE,CHR_SWAPDESC,CHR_DESC FROM inv_t_swapsalesserialno WHERE CHR_SALESNO ='"+salesno+"' ORDER By INT_ID";
						
						String recdData[][]= com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
						String srNo="";
						int serialNoHeader=0;	
					if("true".equals(chkserial) && recdData.length > 0)
					{	
						serialNoHeader=1;
						map.put("serialNoHeader", serialNoHeader);
						int j=0;
						for(int v=0;v<recdData.length; v++)
						{	
							 Hashtable h2 = new Hashtable();
							 if(!recdData[v][2].equals(null))	 
							 {
								++j;
								h2.put("sno1", ""+j);
							if(recdData[v][5].equals("I"))
							{
								 
								sql = "SELECT CHR_ITEMNAME ,CHR_WARRANTY,CHR_DES FROM inv_m_item WHERE CHR_ITEMID='"+recdData[v][2]+"'";
								itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");								h2.put("t2itemname",itemname);
							}	
							if(recdData[v][5].equals("P"))
							{
							  
							  sql="SELECT CHR_PRODUCTCODE,CHR_WARRANTY ,CHR_PRODUCTDESC FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+recdData[v][2]+"'";
							  itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
							  h2.put("t2itemname",itemname);
							}
						
							h2.put("es", "");
							h2.put("t2desc", recdData[v][7]);
							
							if("-".equals(recdData[v][3]))		
								recdData[v][3]="";
						
							h2.put("t2seriNo",recdData[v][3]);
							if(recdData[v][4].equals("1"))
							h2.put("t2warranty",recdData[v][4]+"-Year");
							else
							h2.put("t2warranty",recdData[v][4]+"-Years");
							al.add(h2);
						}
						}
				}
				else
				{
					map.put("serialNoHeader", serialNoHeader);
					if(recdData.length>0)
					{
						for(int v=0;v<recdData.length; v++)
						{
							if(v>=1)
								srNo=srNo+",  ";
							srNo=srNo+recdData[v][3];
						}
						map.put("srNo",srNo);
					}
				}
									 map.put("cpy",cpydata[0][0]);
									 map.put("cpyPAN", cpydata[0][14]);  
									 map.put("cpyCST", cpydata[0][10]);
									 map.put("cpyTIN", cpydata[0][12]);
									 map.put("cpyTAX", cpydata[0][15]);
									 String sql1 ="SELECT CHR_NAME,CHR_ADD1,CHR_ADD2,CHR_CITY,CHR_STATE,INT_PHONE FROM m_institution";
									 String instidata[][]=CommonFunctions.QueryExecute(sql1);
									 map.put("cpyAdd1",instidata[0][1] );
									 map.put("cpyCity",instidata[0][3] );
									 map.put("cpySt",instidata[0][4] );
									 map.put("cpyPh",instidata[0][5] );
							}
				 catch(Exception e)
				 {
				 	System.out.println(e.getMessage());
				 }
				
				jasperPrint=ReportFunctions2.createReportUsingListDS(jasperPrint, request, response, reportDir, rptfilename, al, Path,map);	
				ReportFunctions2.generateAllReport1(exporter, jasperPrint, request, response, reporttype, Path, rptfilename,salesno);
				map=null;
				al=null;
			}
	
		} catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response);
		}
	}
}
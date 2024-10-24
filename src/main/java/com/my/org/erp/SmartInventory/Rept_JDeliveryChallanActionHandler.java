package com.my.org.erp.SmartInventory;
import java.io.File;
import java.io.FileNotFoundException;
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
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.SimpleFileResolver;
import ar.com.fdvs.dj.domain.Style;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JDeliveryChallanActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	protected JasperReport jr;
	JRExporter exporter;
	String hImageExpression="";
	String fImageExpression="";
	HashMap<Integer, String> titleMap=new HashMap<Integer, String>();
	HashMap<Integer, Integer> widthMap=new HashMap<Integer, Integer>();
	HashMap<Integer, Style> styleMap=new HashMap<Integer, Style>();

	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			System.out.println("inside handle");
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String subrptfilename1 = request.getParameter("subrptfilename1");
			String reporttype = request.getParameter("reportType");

			if (action.equals("INVRept_JDeliveryChallan")) 
			{	
				System.out.println("inside action");
				String path=Path + "/report/Inventory/direct/" + rptfilename+".jrxml";

				String path1=Path + "/report/Inventory/direct/" + subrptfilename1+".jrxml";
				File reportDir = new File(path);
				File subReport1Dir = new File(path1);
				HashMap<Object,Object> map = new HashMap<Object,Object>();

				if (!reportDir.exists() ) 
				{
					throw new FileNotFoundException(String.valueOf(reportDir));
				}
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");

				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;

				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);

				String sql= "";
				List<Hashtable<String,String>> al=new ArrayList<Hashtable<String,String>>();

				String dcno= ""+request.getParameter("dcno");
				String branch= ""+request.getParameter("branch");

				String ssql = "SELECT b.CHR_COMPANYNAME,a.CHR_BRANCHNAME,a.CHR_STREET,e.CHR_CITYNAME,d.CHR_STATENAME,a.INT_PINCODE,a.CHR_PHONE,  ";
				ssql = ssql +" a.CHR_FAX,a.CHR_EMAIL,a.CHR_LOCALTAXNO,a.CHR_CSTNO,a.CHR_TINNO, b.CHR_SERVICETAX,a.CHR_TNGSTNO,a.CHR_REGNO,a.CHR_PANNO "; 
				ssql = ssql +" FROM com_m_branch a , com_m_company b ,com_m_country c, com_m_state d, com_m_city e ";
				ssql = ssql +" WHERE  a.INT_CITYID = e.INT_CITYID ";
				ssql = ssql +" AND a.INT_COUNTRYID = c.INT_COUNTRYID ";
				ssql = ssql +" AND a.INT_STATEID =d.INT_STATEID ";
				ssql = ssql +" AND a.INT_COMPANYID = b.INT_COMPANYID  ";
				ssql = ssql +" AND a.INT_BRANCHID="+ branch;
				//System.out.println("company_sql:"+ssql);
				String cpydata[][]=CommonFunctions.QueryExecute(ssql);
				map.put("company", cpydata[0][0]);
				map.put("street", cpydata[0][2]);
				map.put("city", cpydata[0][3]);
				map.put("state", cpydata[0][4]);
				map.put("pin", cpydata[0][5]);
				map.put("phone", cpydata[0][6]);
				map.put("localTax", cpydata[0][9]);
				map.put("cst", cpydata[0][10]);
				map.put("tin", cpydata[0][11]);
				map.put("serviceTax", cpydata[0][12]);

				sql = "SELECT INT_DIVIID,CHR_DCNO,DATE_FORMAT(DAT_DCDATE,'%d-%b-%Y'),INT_CUSTOMERID,CHR_REF,CHR_DES,";
				sql = sql+" CHR_DCSTATUS,CHR_SHIPPING,CHR_SHIPPINGADDRESS,CHR_OTHERREF,	CHR_DELIVERYNOTE,";
				sql = sql+" CHR_DESPATCHTHRU,CHR_DESTINATION,CHR_TERMSOFDELIVERY,CHR_CONTACTDETAILS,CHR_CONTACTNO";
				sql = sql+" FROM inv_t_deliverychallan WHERE CHR_DCNO='"+dcno+"'";
				//System.out.println("shipping_addr_sql"+sql);
				String data[][] = CommonFunctions.QueryExecute(sql);

				sql="SELECT a.INT_CUSTOMERID,f.CHR_NAME,a.CHR_ADDRESS1,a.CHR_ADDRESS2,e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME, "
						+ " CONCAT('PIN :',a.INT_PINCODE),CONCAT('Phone :',a.CHR_AREACODE,'-',a.CHR_PHONE),CONCAT('MOBILE :',a.CHR_MOBILE),"
						+ "CONCAT('E-Mail :',a.CHR_EMAIL),a.CHR_TIN,CHR_CST FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,"
						+ "com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   "
						+ "AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   "
						+ "AND a.INT_CITYID =e.INT_CITYID AND a.INT_CUSTOMERID="+data[0][3];
				//System.out.println("cus_addr_sql: "+sql);
				String vendor[][] =  CommonFunctions.QueryExecute(sql);
				map.put("dcno", dcno);

				if(!"-".equals(vendor[0][1]))
					map.put("cusAddress",vendor[0][1]+"\n"+vendor[0][2]+"\n"+vendor[0][3]+"\n"+vendor[0][4]+"\n"+vendor[0][5]+"\n"+vendor[0][6]+"\n"+vendor[0][7]+"\n"+vendor[0][8]+"\n"+vendor[0][9]+"\n"+vendor[0][10]);
				map.put("cusTIN",vendor[0][11]);
				map.put("cusCST",vendor[0][12]);


				if("S".equals(data[0][7]))
				{
					if(!"-".equals(vendor[0][1]))
						map.put("shippingAddr",vendor[0][1]+"\n"+vendor[0][2]+"\n"+vendor[0][3]+"\n"+vendor[0][4]+"\n"+vendor[0][5]+"\n"+vendor[0][6]+"\n"+vendor[0][7]+"\n"+vendor[0][8]+"\n"+vendor[0][11]+"\n"+vendor[0][12]);

				}
				else
				{
					if(!"-".equals(data[0][8]))
						map.put("shippingAddr",data[0][8]);
				}
				map.put("saleDt",data[0][2]);
				map.put("otherRef",data[0][9]);
				map.put("deliveryNote",data[0][10]);
				map.put("despatchThrough",data[0][11]);
				map.put("destination",data[0][12]);
				map.put("termsOfDelivery",data[0][13]);
				map.put("contactPerson",data[0][14]);
				map.put("ContactNo",data[0][15]);

				sql="SELECT CHR_TYPE,CHR_ITEMID FROM inv_t_deliverychallanitem WHERE CHR_DCNO='"+dcno+"'";
				sql = " SELECT  ";
				sql = sql + "  if(a.CHR_TYPE='I','Item','Product') ptype,  ";
				sql = sql + "  if(a.CHR_TYPE='I',  ";
				sql = sql + "  (SELECT b.CHR_ITEMNAME FROM inv_m_item b WHERE b.CHR_ITEMID=a.CHR_ITEMID)  ";
				sql = sql + "  , ";
				sql = sql + "  (SELECT c.CHR_PRODUCTCODE  FROM inv_m_produtlist  c WHERE c.CHR_PRODUCTID=a.CHR_ITEMID)   ";
				sql = sql + "  ) pmodel,  ";
				sql = sql + "  if(a.CHR_TYPE='I',  ";
				sql = sql + "  (SELECT d.CHR_DES FROM inv_m_item d WHERE d.CHR_ITEMID=a.CHR_ITEMID)  ";
				sql = sql + "  ,  ";
				sql = sql + "  (SELECT e.CHR_PRODUCTDESC  FROM inv_m_produtlist  e WHERE e.CHR_PRODUCTID=a.CHR_ITEMID)  ";
				sql = sql + "  ) pdesc ";
				sql = sql + ",INT_QTY  FROM inv_t_deliverychallanitem  a WHERE a.CHR_DCNO='"+dcno+"'";
				//System.out.println("product_list_sql: "+sql);
				String srSQL="SELECT if(CHR_TYPE='I','Item','Product') ptype, if(CHR_TYPE='I',(SELECT d.CHR_ITEMNAME FROM inv_m_item d WHERE "
						+ "d.CHR_ITEMID=a.CHR_ITEMID),(SELECT e.CHR_PRODUCTCODE  FROM inv_m_produtlist  e WHERE e.CHR_PRODUCTID=a.CHR_ITEMID)) pmodel,  "
						+ "if(a.CHR_TYPE='I',(SELECT d1.CHR_DES FROM inv_m_item d1 WHERE d1.CHR_ITEMID=a.CHR_ITEMID),(SELECT e1.CHR_PRODUCTDESC  "
						+ "FROM inv_m_produtlist  e1 WHERE e1.CHR_PRODUCTID=a.CHR_ITEMID)) pdesc,CHR_SERIALNO FROM inv_t_deliverychallanitemserial a "
						+ "WHERE CHR_DCNO='"+dcno+"'";
				//System.out.println("product_srNo_sql: "+sql);
				jasperPrint=ReportFunctions.createDoubleSubReport(jasperPrint, request, response,con, reportDir, rptfilename,path, map, sql,subReport1Dir,  srSQL);
				ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
			}

		} catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request,response);
		}
	}


}
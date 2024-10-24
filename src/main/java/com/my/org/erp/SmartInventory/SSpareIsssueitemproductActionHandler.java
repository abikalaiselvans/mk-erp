package com.my.org.erp.SmartInventory;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class SSpareIsssueitemproductActionHandler extends AbstractActionHandler{
	String Sparenumber=null;
	String demandnumber=null;
	String spareissue=null;
	
	private void sparesitemproductdelete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{
			String []rowid= request.getParameterValues("id");
			String readData1[][]=null;
			String demandno=null;
			String serialno=null;
			String productcode=null;
			for(int i=0;i<rowid.length;i++)
			{	
				
				int row=Integer.parseInt(rowid[i]);
				asql = " Select CHR_DEMANDNO,CHR_ISSUED_SERIALNUMBER,CHR_PRODUCTCODE from inv_ss_t_sparedemandissue   WHERE INT_ISSUEID = "+row+"";
				readData1 = CommonFunctions.QueryExecute(asql);
				demandno=readData1[0][0];
				serialno=readData1[0][1];
				productcode=readData1[0][2];
				
				Sparedeleteserial(productcode,serialno);
				Sparedeleteconsumable(productcode,demandno);
				Sparedeletedemandissue(row);
			}
		}
		catch(Exception e)
		{
			 request.setAttribute("error", e.getMessage() );
			 RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			 dispatchers.forward(request, response); 
			 System.out.println(e.getMessage());
		}
	}
	
	private void Sparedeleteserial(String productid,String serialno)throws IOException
	{
		try
		{
			
			asql=" UPDATE inv_t_vendorgoodsreceived SET ";
			asql = asql + "CHR_FLAG=? WHERE CHR_SERIALNO=?"; 
			System.out.println("asql...."+asql);
			apstm =con.prepareStatement(asql);
			apstm.setString(1,"N");
			apstm.setString(2,serialno);
			apstm.execute();
			apstm.close();
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
	}
	
	private void Sparedeleteconsumable(String productid,String demandno)throws IOException
	{
		try
		{
			
			asql ="DELETE FROM inv_t_vendorgoodsreceivedconsumable WHERE CHR_ITEMID=? AND CHR_SALESNO=?";
			apstm = con.prepareStatement(asql);
			apstm.setString(1,productid);
			apstm.setString(2,demandno);
			apstm.execute();
			apstm.close();
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
	}
	
	private void Sparedeletedemandissue(int rowid)throws IOException
	{
		try
		{
			asql ="DELETE FROM inv_ss_t_sparedemandissue WHERE INT_ISSUEID=?";
			apstm = con.prepareStatement(asql);
			apstm.setInt(1,rowid);
			apstm.execute();
			apstm.close();
		}
		catch(Exception e)
		{
			 System.out.println(e.getMessage());
		}
	}
	
	
	private void spareissueitemproductreopen(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{
			String demandno= request.getParameter("demandno");
			String reopenid= request.getParameter("id");
			String sql_Update_Query ="UPDATE inv_ss_sparedemand SET CHR_ISSUED = ? WHERE CHR_DEMANDNO=? AND INT_DEMANID=?";
			apstm = con.prepareStatement(sql_Update_Query);
			apstm.setString(1,"N");
			apstm.setString(2,demandno);
			apstm.setString(3,reopenid);
			apstm.execute();		
		}
		catch(Exception e)
		{
			 request.setAttribute("error", e.getMessage() );
			 RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			 dispatchers.forward(request, response); 
			 System.out.println(e.getMessage());
		}
	}
	
	private void spareissueitemproductAdd(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{
			String qty;
			String sql1;
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");
			demandnumber=""+request.getParameter("demandnumber");
			String sparetype=""+request.getParameter("sparetype");
			String serialproduct=""+request.getParameter("serialproducttype");
			String productcode=""+request.getParameter("consumableproduct");
			if("C".equals(sparetype))
				qty=""+request.getParameter("qty");
			else
				qty="0";
			
			String serialno=""+request.getParameter("serialno");
			spareissue=""+request.getParameter("spareissue");
			String issueDate=""+request.getParameter("issueDate");
			String despatchthrough=""+request.getParameter("despatchthrough");
			String despatchdetail=""+request.getParameter("despatchdetail");
			sql1 = " Select CHR_DEMANDNO from inv_ss_sparedemand   WHERE INT_DEMANID = '"+demandnumber+"'";
	 	 	String readData1[][] =  CommonFunctions.QueryExecute(sql1);
	 	 	demandnumber=readData1[0][0];
			Sparenumber="ISS/"+InventoryInvoiceFunctions.accountYear()+InventoryInvoiceFunctions.sspareIssueNumber();
			asql=" INSERT INTO inv_ss_t_sparedemandissue ";
			asql = asql + " (CHR_ISSUEDNO,CHR_DEMANDNO,CHR_SPARETYPE,CHR_TYPE,CHR_PRODUCTCODE,INT_QTY,CHR_ISSUED_SERIALNUMBER,CHR_ISSUED,CHR_ISSUED_BY,DAT_ISSUED_DATE,CHR_ISSUE_THROUGH,CHR_ISSUE_DESC,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
			asql = asql + " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,DATE(NOW()),'Y')";
			apstm =con.prepareStatement(asql);
			apstm.setString(1,Sparenumber);
			apstm.setString(2,demandnumber);
			apstm.setString(3,sparetype);
			apstm.setString(4,serialproduct);
			apstm.setString(5,productcode);
			apstm.setString(6,qty);
			apstm.setString(7,serialno);
			apstm.setString(8,spareissue);
			apstm.setString(9,userid);
			apstm.setString(10,DateUtil.FormateDateandTimeSQL(issueDate));
			apstm.setString(11,despatchthrough);
			apstm.setString(12,despatchdetail);
			apstm.setString(13,userid);
			apstm.execute();
			apstm.close();
			if("S".equals(sparetype))
			{
				asql=" UPDATE inv_t_vendorgoodsreceived SET ";
				asql = asql + "CHR_FLAG=? WHERE CHR_SERIALNO=? "; 
				System.out.println("asql...."+asql);
				apstm =con.prepareStatement(asql);
				apstm.setString(1,"S");
				apstm.setString(2,serialno);
				apstm.execute();
				apstm.close();
			}
			else
			{
				String invbranchid=""+session.getAttribute("INVBRANCH");
				String sql = "SELECT DOU_AVGPRICE FROM inv_t_vendorgoodsreceivedconsumable WHERE CHR_ITEMID='"+productcode +"' ORDER BY INT_ROWID desc limit 1";
				String serialnoData[][] = CommonFunctions.QueryExecute(sql);
				System.out.println("sql...."+sql);
				asql=" INSERT INTO inv_t_vendorgoodsreceivedconsumable ";
				asql = asql + " (INT_BRANCHID,CHR_TYPE,INT_DIVIID,CHR_ITEMID,CHR_SALESNO,INT_SQTY,DOU_SALESUNITPRICE,DOU_AVGPRICE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
				asql = asql + " VALUES(?,?,?,?,?,?,?,?,?,DATE(NOW()),'Y')";
				apstm =con.prepareStatement(asql);
				System.out.println("asql..."+asql);
				
				apstm.setString(1,invbranchid);
				apstm.setString(2,"P");
				apstm.setString(3,"1");
				apstm.setString(4,productcode);
				apstm.setString(5,demandnumber);
				apstm.setString(6,qty);
				apstm.setString(7,"0");
				apstm.setString(8,serialnoData[0][0]);
				apstm.setString(9,userid);
				apstm.execute();
				apstm.close();
			}
		}
		catch(Exception e)
		{
			 request.setAttribute("error", e.getMessage() );
			 RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			 dispatchers.forward(request, response); 
			 System.out.println(e.getMessage());
		}
	}
	
	private void spareissueitemproductEdit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{	

			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");
			
			String prodid=""+request.getParameter("prodid");
			String qty=""+request.getParameter("qty");
			if("".equals(qty) || "null".equals(qty))
				qty = "0";
			String sdemandno=""+request.getParameter("sdemandno");
			String sparetype=""+request.getParameter("sparetype");
			String serialno=""+request.getParameter("serialno");
			String oldserialno=""+request.getParameter("oldserialno");
			String spareissue=""+request.getParameter("spareissue");
			String issueDate=""+request.getParameter("issueDate") ;
			String despatchthrough=""+request.getParameter("despatchthrough");
			String despatchdetail=""+request.getParameter("despatchdetail");
			String issid=""+request.getParameter("id");
			asql=" UPDATE inv_ss_t_sparedemandissue SET ";
			asql = asql + "CHR_PRODUCTCODE=?,INT_QTY=?,CHR_ISSUED_SERIALNUMBER=?," +
					"CHR_ISSUED=?,CHR_ISSUED_BY=?,DAT_ISSUED_DATE=?," +
					"CHR_ISSUE_THROUGH=?,CHR_ISSUE_DESC=? " +
					"WHERE INT_ISSUEID=?"; 
			apstm =con.prepareStatement(asql);
			apstm.setString(1,prodid);
			apstm.setString(2,qty);
			apstm.setString(3,serialno);
			apstm.setString(4,spareissue);
			apstm.setString(5,userid);
			apstm.setString(6,DateUtil.FormateDateandTimeSQL(issueDate));
			apstm.setString(7,despatchthrough);
			apstm.setString(8,despatchdetail);
			apstm.setString(9,issid);
			System.out.println(asql);
			apstm.execute();
			apstm.close();
			if("S".equals(sparetype))
			{
				asql=" UPDATE inv_t_vendorgoodsreceived SET ";
				asql = asql + "CHR_FLAG=? WHERE CHR_SERIALNO=?"; 
				apstm =con.prepareStatement(asql);
				apstm.setString(1,"S");
				apstm.setString(2,serialno);
				System.out.println(asql);
				apstm.execute();
				apstm.close();
				
				asql=" UPDATE inv_t_vendorgoodsreceived SET ";
				asql = asql + "CHR_FLAG=? WHERE CHR_SERIALNO=?"; 
				apstm =con.prepareStatement(asql);
				apstm.setString(1,"N");
				apstm.setString(2,oldserialno);
				System.out.println(asql);
				apstm.execute();
				apstm.close();
			}
			else
			{
				asql=" UPDATE inv_t_vendorgoodsreceivedconsumable SET ";
				asql = asql + "CHR_ITEMID=?,INT_SQTY=? WHERE CHR_SALESNO=? AND CHR_ITEMID=?"; 
				apstm =con.prepareStatement(asql);
				apstm.setString(1,prodid);
				apstm.setString(2,qty);
				apstm.setString(3,sdemandno);
				apstm.setString(4,prodid);
				System.out.println(asql);
				apstm.execute();
				apstm.close();
			}
		}
		catch(Exception e)
		{
			 request.setAttribute("error", e.getMessage() );
			 RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			 dispatchers.forward(request, response); 
			 System.out.println(e.getMessage());
		}
	}
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
				String action=request.getParameter("actionS");
				if(action.equals("INVSpareissueitemproductDelete"))
				{
					sparesitemproductdelete(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/SSpareissueview.jsp");
				}
				if("INVSpareissueitemproductadd".equals(action))
				{					
					spareissueitemproductAdd(request, response);
					con.close(); 
					response.sendRedirect("Smart Inventory/SSpareissueadd.jsp?addrecord=R&issueid="+Sparenumber+"&demandno="+demandnumber+"&spareissuestatus="+spareissue);
				}
				else if("INVSpareissueitemproductedit".equals(action))
				{					
					spareissueitemproductEdit(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/SSpareissueview.jsp");
				}
				else if("INVSpareissueitemproductreopen".equals(action))
				{					
					spareissueitemproductreopen(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/SSpareissueview.jsp");
				}
			
		} 
		catch(Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage());
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
 		}
	}
}


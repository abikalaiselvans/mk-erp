package com.my.org.erp.SmartMarketing;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.bean.SmartMarketing.MyFunnel;
public class MyFunnelActionHandler extends AbstractActionHandler 
{
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			if ( "MKTMyFunnelAdd".equals(action) ) 
			{
				
				MyFunnel d = new MyFunnel();
				Map map=request.getParameterMap();
				BeanUtils.populate(d,map);
				String field = " ( CHR_CLIENT_NAME,CHR_LOCATION,CHR_PRODUCT,CHR_LOB_TYPE,CHR_OEM, ";
				field = field + " INT_QTY,  INT_UNITVALUE,  DOU_TOTAL_VALUE, DOU_BOTTOM_VALUE, CHR_CATEGORY,CHR_STAGE,  ";
				field = field + " CHR_APPR_CLOSURE,CHR_SATUS,CHR_WINNING,CHR_PROPOSAL,CHR_REMARK, CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )  ";
				 
				String sql = " INSERT INTO mkt_t_funnel " + field
						+ " VALUES (?,?,?,?,?,?,?,?, ?,?,?,?,?,?,?,?,?, now(), 'Y')";
				PreparedStatement ps=con.prepareStatement(sql);
				ps.setString(1, d.getClientname());
				ps.setString(2, d.getLocation());
				ps.setString(3, d.getProduct());
				ps.setString(4, d.getLob());
				ps.setString(5, d.getOem());
				ps.setInt(6, d.getQty());
				ps.setDouble(7, d.getUnitvalue());
				ps.setDouble(8, d.getTotalvalue());
				ps.setDouble(9, d.getBottomlinevalue());
				ps.setString(10, d.getCategory());
				ps.setString(11, d.getStage());
				ps.setString(12, d.getApproxclosure());
				ps.setString(13, d.getStatus());
				ps.setString(14, d.getProbabilitywinning());
				ps.setString(15, d.getProposal());
				ps.setString(16, d.getRemarks());
				ps.setString(17, user);
				System.out.println(""+ps);
				ps.execute();
				ps.close();
				con.close();
				response.sendRedirect("Smart Marketing/MyFunnel_View.jsp");
			} 
			else if (action.equals("MKTMyFunnelEdit")) 
			{
				String id=request.getParameter("id");
				MyFunnel d = new MyFunnel();
				Map map=request.getParameterMap();
				BeanUtils.populate(d,map);
				
				String field = " ( CHR_CLIENT_NAME,CHR_LOCATION,CHR_PRODUCT,CHR_LOB_TYPE,CHR_OEM, ";
				field = field + " INT_QTY,  INT_UNITVALUE,  DOU_TOTAL_VALUE, DOU_BOTTOM_VALUE, CHR_CATEGORY,CHR_STAGE,  ";
				field = field + " CHR_APPR_CLOSURE,CHR_SATUS,CHR_WINNING,CHR_PROPOSAL,CHR_REMARK, CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )  ";
				
				String sql = " UPDATE mkt_t_funnel SET CHR_CLIENT_NAME=?,CHR_LOCATION=?,CHR_PRODUCT=?,CHR_LOB_TYPE=?,CHR_OEM=?, ";
				sql = sql + " INT_QTY=?,  INT_UNITVALUE=?,  DOU_TOTAL_VALUE=?, DOU_BOTTOM_VALUE=?, CHR_CATEGORY=?,CHR_STAGE=?,  ";
				sql = sql + " CHR_APPR_CLOSURE=?,CHR_SATUS=?, CHR_WINNING=?,CHR_PROPOSAL=?,CHR_REMARK=?, CHR_USRNAME=?,DT_UPDATEDATE=now(),CHR_UPDATESTATUS='Y'  WHERE INT_FUNNELID=?";
				PreparedStatement ps=con.prepareStatement(sql);
				ps.setString(1, d.getClientname());
				ps.setString(2, d.getLocation());
					
				ps.setString(3, d.getProduct());
				ps.setString(4, d.getLob());
				ps.setString(5, d.getOem());
				ps.setInt(6, d.getQty());
				ps.setDouble(7, d.getUnitvalue());
				ps.setDouble(8, d.getTotalvalue());
				ps.setDouble(9, d.getBottomlinevalue());
				ps.setString(10, d.getCategory());
				ps.setString(11, d.getStage());
				ps.setString(12, d.getApproxclosure());
				ps.setString(13, d.getStatus());
				ps.setString(14, d.getProbabilitywinning());
				ps.setString(15, d.getProposal());
				ps.setString(16, d.getRemarks());
				ps.setString(17, user);
				ps.setString(18, d.getRowid());
				System.out.println(""+ps);
				ps.execute();
				ps.close();
				con.close();    
				response.sendRedirect("Smart Marketing/MyFunnel_View.jsp");
			}
			else if (action.equals("MKTMyFunnelDelete")) 
			{
			
				String rowids[] = request.getParameterValues("rowid");
				String sql = " DELETE from  mkt_t_funnel WHERE INT_FUNNELID=?";
				apstm=con.prepareStatement(sql);
				for(int u=0; u<rowids.length;u++)
				{
					apstm.setString(1, rowids[u]);
					System.out.println(""+apstm);
					apstm.addBatch();
				}
				apstm.executeBatch();
				apstm.close();
				con.close();
			}
			response.sendRedirect("Smart Marketing/MyFunnel_View.jsp");
			
		} catch (Exception e) 
		{
			System.out.println(e.getMessage());
	 		request.setAttribute("error", e.getMessage());
	 		RequestDispatcher dispatchers = request	.getRequestDispatcher("/error/index.jsp");
	 		dispatchers.forward(request, response);
		}
	}

}

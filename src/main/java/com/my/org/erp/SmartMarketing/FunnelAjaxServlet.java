package com.my.org.erp.SmartMarketing;

import com.google.gson.Gson;
import com.my.org.erp.SmartAutocompleteServlet.Funnel;
import com.my.org.erp.bean.SmartMarketing.MyFunnel;
import com.my.org.erp.common.CommonFunctions;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/FunnelAjax")
public class FunnelAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("actionS");
		String searchText = request.getParameter("query");
		String sql = "";
		if("Loadfunnelinfos".equals(action) )
		 {
			String actions=request.getParameter("day");
    		String day=request.getParameter("day");
    		String month=request.getParameter("month");
    		String year=request.getParameter("year");
    		String search=request.getParameter("search");
    		String me=request.getParameter("me");
    		System.out.println(search);
    		
    		HttpSession session = request.getSession();
			String usertype  = (""+session.getAttribute("USERTYPE")).toUpperCase();
			 
			sql =  " SELECT INT_FUNNELID, CHR_USRNAME, CHR_CLIENT_NAME,CHR_LOCATION,CHR_PRODUCT,CHR_LOB_TYPE,CHR_OEM,INT_QTY,  ";
			sql = sql + " INT_UNITVALUE,  DOU_TOTAL_VALUE, DOU_BOTTOM_VALUE, CHR_CATEGORY,CHR_STAGE, CHR_APPR_CLOSURE,CHR_SATUS,CHR_WINNING,CHR_PROPOSAL, ";
			sql = sql + "  CHR_REMARK, DT_UPDATEDATE  from mkt_t_funnel  WHERE INT_FUNNELID >0  ";   
			
			if(!"0".equals(day))
				sql = sql + " AND DAY(DT_UPDATEDATE) = "+day;
			if(!"0".equals(month))
				sql = sql + " AND MONTH(DT_UPDATEDATE) = "+month;
			if(!"0".equals(year))
				sql = sql + " AND YEAR(DT_UPDATEDATE) = "+year;
			if(!"0".equals(search))
				sql = sql + " AND CHR_CLIENT_NAME LIKE '"+search+"%' " ;
			 
 	 		sql = sql +" ORDER BY DT_UPDATEDATE ";
 	 		System.out.println(sql);
 	 		String jsondata = getFunnelJsonObject(sql);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(jsondata);
		 }
		else
			response.setStatus(HttpServletResponse.SC_NO_CONTENT);

	}


	 static String getFunnelJsonObject(String sql) {
			String data[][] = CommonFunctions.QueryExecute(sql);
			List<MyFunnel> listdata = new ArrayList<MyFunnel>();
			if (data.length > 0) {
				for (int i = 0; i < data.length; i++) {
					MyFunnel n = new MyFunnel();
					n.setRowid(data[i][0]);
					n.setMename(data[i][1]);
					n.setClientname(data[i][2]);
					n.setLocation(data[i][3]);
					n.setProduct(data[i][4]);
					n.setLob(data[i][5]);
					n.setOem(data[i][6]);
					n.setQty(Integer.parseInt(data[i][7]));
					n.setUnitvalue(Double.parseDouble(data[i][8]));
					n.setTotalvalue(Double.parseDouble(data[i][9]));
					n.setBottomlinevalue(Double.parseDouble(data[i][10]));
					n.setCategory(data[i][11]);
					n.setStage(data[i][12]);
					n.setApproxclosure(data[i][13]);
					n.setStatus(data[i][14]);
					n.setProbabilitywinning(data[i][15]);
					n.setProposal(data[i][16]);
					n.setRemarks(data[i][17]);
					listdata.add(n);
					
					

				}
			}
			System.out.println("Record size:"+listdata.size());
			Gson gson = new Gson();
			String jsondata = gson.toJson(listdata);
			return jsondata;
		}

}

package com.my.org.erp.SmartMarketing;

import com.google.gson.Gson;
import com.my.org.erp.SmartAutocompleteServlet.Funnel;
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

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
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
			sql = sql + " SELECT INT_FUNNELID,CHR_ME_NAME,CHR_CLIENT_NAME,CHR_LOCATION,CHR_PRODUCT,CHR_LOB_TYPE,CHR_OEM,INT_QTY, "; 
			sql = sql + " INT_UNIT,DOU_VALUE,  DOU_TOTAL_VALUE, CHR_STAGE,  DT_UPDATEDATE  from mkt_t_funnel ";
			sql = sql + " WHERE INT_FUNNELID >0    ";
			
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
			List<Funnel> listdata = new ArrayList<Funnel>();
			if (data.length > 0) {
				for (int i = 0; i < data.length; i++) {
					Funnel n = new Funnel();
					n.setROWID(data[i][0]);
					n.setME_NAME(data[i][1]);
					n.setCLIENT_NAME(data[i][2]);
					n.setLOCATION(data[i][3]);
					n.setPRODUCT(data[i][4]);
					n.setLOB(data[i][5]);
					n.setOEM(data[i][6]);
					n.setQTY(data[i][7]);
					n.setUNIT(data[i][8]);
					n.setVALUE(data[i][9]);
					n.setTOTAL(data[i][10]);
					n.setSTAGE(data[i][11]);
					n.setFDATE(data[i][12]);
					listdata.add(n);

				}
			}
			System.out.println("Record size:"+listdata.size());
			Gson gson = new Gson();
			String jsondata = gson.toJson(listdata);
			return jsondata;
		}

}

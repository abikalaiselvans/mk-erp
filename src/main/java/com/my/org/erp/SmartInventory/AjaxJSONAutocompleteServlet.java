package com.my.org.erp.SmartInventory;

import com.google.gson.Gson;
import com.my.org.erp.SmartAutocompleteServlet.AjaxKeyValue;
import com.my.org.erp.common.CommonFunctions;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Get_Product_Json")
public class AjaxJSONAutocompleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 
			 
			String sql = " select CHR_PRODUCTID, UPPER(CHR_PRODUCTCODE) from inv_m_produtlist  WHERE INT_ACTIVE=1 ORDER BY CHR_PRODUCTCODE"; 
			System.out.println(sql);
			String jsondata = getJsonObject(sql);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(jsondata);
		 

	}

	String getJsonObject(String sql) {
		String data[][] = CommonFunctions.QueryExecute(sql);
		List<AjaxKeyValue> listdata = new ArrayList<AjaxKeyValue>();
		if (data.length > 0) {
			for (int i = 0; i < data.length; i++) {
				AjaxKeyValue n = new AjaxKeyValue();
				n.setId(data[i][0]);
				n.setName(data[i][1]);
				listdata.add(n);

			}
		}

		Gson gson = new Gson();
		String jsondata = gson.toJson(listdata);
		return jsondata;
	}

}

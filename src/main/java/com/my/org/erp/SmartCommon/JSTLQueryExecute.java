package com.my.org.erp.SmartCommon;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;
import com.my.org.erp.common.CommonFunctions;
@SuppressWarnings("serial")
public class JSTLQueryExecute extends BodyTagSupport
{
	private String  sqlQuery;
	
 	public void setsqlQuery(String sqlQuery)
 	{
 		this.sqlQuery = sqlQuery;
 	}
 	
 	public String getsqlQuery()
 	{
 		return(sqlQuery);
 	}
 
 	public int doStartTag()
 	{
		 try
		 {
			 System.out.println("========================");
			 JspWriter out = pageContext.getOut();
			 String sql = sqlQuery;
			 out.println(sql);
			 System.out.println(sql);
			 String[][] data= CommonFunctions.QueryExecute(sql);
			 pageContext.setAttribute("result",data);
		 }
		 catch(Exception ex)
		 {
			 System.out.println(ex.getMessage());
		 }
		return SKIP_BODY;
	  }
}
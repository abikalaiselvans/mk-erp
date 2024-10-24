<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page  import="java.awt.*" %>
<%@ page  import="java.io.*" %>
<%@ page  import="org.jfree.chart.*" %>
<%@ page  import="org.jfree.chart.entity.*" %>
<%@ page  import ="org.jfree.data.general.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
  final DefaultPieDataset data = new DefaultPieDataset();
 String sql = "";
		  sql = " SELECT  c.CHR_CALLTYPE, COUNT(*) FROM mkt_t_daillycalls a, mkt_k_calltype c WHERE a.CHR_CALLTYPE=c.INT_CALLTYPEID GROUP BY   a.CHR_CALLTYPE ORDER BY  c.CHR_CALLTYPE  ";
		    String[][] datas = CommonFunctions.QueryExecute(sql);
			
			
			for(int u=0;u<datas.length;u++)
				data.setValue(""+datas[u][0], new Double(datas[u][1]));	

  JFreeChart chart = ChartFactory.createPieChart
  ("Pie Chart ", data, true, true, false);

 try {
 final ChartRenderingInfo info = new 
  ChartRenderingInfo(new StandardEntityCollection());
  final File file1 = new File(request.getRealPath("/")+"Smart Marketing/piechart.png");
  ChartUtilities.saveChartAsPNG(
   file1, chart, 600, 400, info);
  } catch (Exception e) {
  out.println(e);
  }
%>
<html>
  <head>
  <meta http-equiv="Content-Type" 
  content="text/html; charset=UTF-8">
  <title>JSP Page</title>
  </head>
  <body onselectstart="return false" onpaste="return false;" onCopy="return false" >
  <IMG SRC="piechart.png" WIDTH="600" HEIGHT="400" 
   BORDER="0" USEMAP="#chart">
  </body>
</html>
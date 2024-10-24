<%-- 
    Document   : jspmultiplepiechart
    Created on : 1 Sep, 2008, 1:11:29 PM
    Author     : komal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">


<%@ page  import="java.awt.*" %>
<%@ page  import="java.io.*" %>
<%@ page  import="org.jfree.chart.*" %>
<%@ page  import="org.jfree.chart.entity.*" %>
<%@ page  import="org.jfree.chart.plot.*"%>
<%@ page  import ="org.jfree.data.category.*"%>
<%@ page  import ="org.jfree.data.general.*"%>
<%@ page  import ="org.jfree.util.*"%>

<%
            final double[][] data = new double[][]{
                {3.0, 4.0, 3.0, 5.0},
                {5.0, 7.0, 6.0, 8.0},
                {5.0, 7.0, 3.0, 8.0},
                {1.0, 2.0, 3.0, 4.0},
                {2.0, 3.0, 2.0, 3.0}
            };

            final CategoryDataset dataset = DatasetUtilities.createCategoryDataset(
                    "Region ", "Sales/Q", data);
            final JFreeChart chart = ChartFactory.createMultiplePieChart(
                    "Multiple Pie Chart", dataset, TableOrder.BY_ROW, true, true, false);
            chart.setBackgroundPaint(new Color(249, 231, 236));
            try {
                final ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
                final File file1 = new File(request.getRealPath("/")+"JFreeChart/multipiechart.png");
                ChartUtilities.saveChartAsPNG(file1, chart, 800, 600, info);
            } catch (Exception e) {
                out.println(e);
            }
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body  onpaste='return false;'>
        <IMG SRC="multipiechart.png" WIDTH="600" HEIGHT="400" BORDER="0" USEMAP="#chart">
    </body>
</html>


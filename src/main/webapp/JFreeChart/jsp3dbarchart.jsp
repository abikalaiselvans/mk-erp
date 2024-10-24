<%-- 
    Document   : jsp3dbarchart
    Created on : 1 Sep, 2008, 12:19:04 PM
    Author     : komal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
   
   
<%@ page  import="java.awt.*" %>
<%@ page  import="java.io.*" %>
<%@ page  import="org.jfree.chart.*" %>
<%@ page  import="org.jfree.chart.axis.*" %>
<%@ page  import="org.jfree.chart.entity.*" %>
<%@ page  import="org.jfree.chart.labels.*" %>
<%@ page  import="org.jfree.chart.plot.*" %>
<%@ page  import="org.jfree.chart.renderer.category.*" %>
<%@ page  import="org.jfree.chart.urls.*" %>
<%@ page  import="org.jfree.data.category.*" %>
<%@ page  import="org.jfree.data.general.*" %>

<%
            final double[][] data = new double[][]{
                {210, 300, 320, 265, 299},
                {200, 304, 201, 201, 340}
            };

            final CategoryDataset dataset = DatasetUtilities.createCategoryDataset(
                    "Team ", "", data);

            JFreeChart chart = null;
            BarRenderer renderer3D = null;
            CategoryPlot plot = null;


            final CategoryAxis3D categoryAxis = new CategoryAxis3D("Match");
            final ValueAxis valueAxis = new NumberAxis3D("Run");
            renderer3D = new BarRenderer3D();

            plot = new CategoryPlot(dataset, categoryAxis, valueAxis, renderer3D);
            plot.setOrientation(PlotOrientation.VERTICAL);
            chart = new JFreeChart("Srore Bord", JFreeChart.DEFAULT_TITLE_FONT, plot, true);

            chart.setBackgroundPaint(new Color(249, 231, 236));

            try {
                final ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
                final File file1 = new File(request.getRealPath("/")+"JFreeChart/3dbarchart.png");
                ChartUtilities.saveChartAsPNG(file1, chart, 600, 400, info);
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
        <IMG SRC="3dbarchart.png" WIDTH="600" HEIGHT="400" BORDER="0" USEMAP="#chart">
    </body>
</html>


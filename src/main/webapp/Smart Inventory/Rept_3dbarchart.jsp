<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.*"%>
 
   
   
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
            
		String reportheader=" CUMULATIVE SALES "; 
		String Branch = request.getParameter("Branch");
		String  division= request.getParameter("division");
		String type = request.getParameter("type");
		String year = request.getParameter("year");
		int fyear = Integer.parseInt( year); 
		String link = "Branch="+Branch+"&division="+division+"&type="+type+"&year="+year;
		String sql ="SELECT '0','0'  ";
		if("1".equals(type))
		{
			sql = "    SELECT  MONTH(a.DAT_SALESDATE), ROUND(SUM(DOU_AMOUNT),0 ) ";
			sql = sql + " FROM inv_t_directsales a  ";
			sql = sql + " WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
			sql = sql + "  AND a.DAT_SALESDATE >='"+fyear+"-04-01'  ";
			sql = sql + " AND a.DAT_SALESDATE <='"+(fyear+1)+"-03-31' ";
			if(!"0".equals(Branch))
				sql = sql + " AND a.INT_BRANCHID = "+Branch;
			if(!"0".equals(division))
				sql = sql + " AND a.INT_DIVIID = "+division;
			sql = sql + " GROUP BY  MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
			sql = sql + " order by a.INT_BRANCHID , a.DAT_SALESDATE ";
			
		}
		else if("2".equals(type))
		{
		 	sql = " SELECT  MONTH(a.DAT_SALESDATE), ROUND(SUM(DOU_AMOUNT),0)";
			sql = sql + " FROM inv_t_servicebilling a  ";
			sql = sql + " WHERE a.CHR_CANCEL='N' AND a.INT_SALESSTATUS=1 ";
			sql = sql + "  AND a.DAT_SALESDATE >='"+fyear+"-04-01'  ";
			sql = sql + " AND a.DAT_SALESDATE <='"+(fyear+1)+"-03-31' ";
			if(!"0".equals(Branch))
				sql = sql + " AND a.INT_BRANCHID = "+Branch;
			if(!"0".equals(division))
				sql = sql + " AND a.INT_DIVIID = "+division;
			sql = sql + " GROUP BY  MONTH(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE) ";
			sql = sql + " order by a.INT_BRANCHID , a.DAT_SALESDATE ";
			
			

		}
		 
		final double  data[][] =  CommonFunction.doubleRecordSetArrays(sql);
		
		
		 
            final CategoryDataset dataset = DatasetUtilities.createCategoryDataset("Team ", "", data);

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
        <IMG SRC="3dbarchart.png" WIDTH="600" HEIGHT="400" BORDER="0" USEMAP="#chart">
    </body>
</html>


<%@ page import="com.crystaldecisions.report.web.viewer.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.data.*"%>
<%@ page import="com.crystaldecisions.reports.sdk.ReportClientDocument"%>
<%

Object reportSource = session.getAttribute("reportSource");
if (reportSource == null)
{
    String report = "Smart Inventory/Reports/Customerlabel.rpt";
    ReportClientDocument reportClientDoc = new ReportClientDocument();
    reportClientDoc.open(report, 0);
    reportSource = reportClientDoc.getReportSource();
    session.setAttribute("reportSource", reportSource);
}
CrystalReportViewer viewer = new CrystalReportViewer();
viewer.setReportSource(reportSource);
viewer.setOwnPage(true);
viewer.processHttpRequest(request, response, getServletConfig().getServletContext(), null);

%>


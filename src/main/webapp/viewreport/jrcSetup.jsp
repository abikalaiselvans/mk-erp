<%@ page
	import="com.crystaldecisions.report.web.viewer.ReportExportControl"%>
<%@ page import="com.crystaldecisions.reports.sdk.ReportClientDocument"%>
<%@ page
	import="com.crystaldecisions.sdk.occa.report.exportoptions.ExportOptions"%>
<%@ page
	import="com.crystaldecisions.sdk.occa.report.exportoptions.ReportExportFormat"%>
<%@ page
	import="com.crystaldecisions.sdk.occa.report.exportoptions.RTFWordExportFormatOptions"%>
<%

    Object reportSource = session.getAttribute("reportSource");
    if (reportSource == null)
    {

       //String report = "CrystalReport1.rpt";
       String report =  "Smart Inventory/Reports/Customerlabel.rpt";
       
       ReportClientDocument reportClientDoc = new ReportClientDocument();
       reportClientDoc.open(report, 0);
       reportSource = reportClientDoc.getReportSource();
       session.setAttribute("reportSource", reportSource);

    }
    ReportExportControl exportControl = new ReportExportControl();
    ExportOptions exportOptions = new ExportOptions();
    exportOptions.setExportFormatType(ReportExportFormat.RTF);
    RTFWordExportFormatOptions RTFExpOpts = new RTFWordExportFormatOptions();
    RTFExpOpts.setStartPageNumber(1);
    RTFExpOpts.setEndPageNumber(3);
    exportOptions.setFormatOptions(RTFExpOpts);    
    exportControl.setReportSource(reportSource);
    exportControl.setExportOptions(exportOptions);
    exportControl.setExportAsAttachment(true);
    exportControl.processHttpRequest(request, response, getServletConfig().getServletContext(), null);

%>

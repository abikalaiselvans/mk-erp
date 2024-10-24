<%@ page contentType="text/html; charset=utf-8"%>

<%@ page import="com.crystaldecisions.report.web.viewer.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.exportoptions.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.data.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.lib.*"%>
<%@ page import="com.crystaldecisions.reports.sdk.ReportClientDocument"%>
<%@ page import="com.crystaldecisions.reports.sdk.PrintOutputController"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>



<%
  // This page exports the report to the appropriate file format.
%>

<%  
	ReportExportControl exportControl = new ReportExportControl();
	Object reportSource = session.getAttribute("reportSource");
	exportControl.setReportSource(reportSource);
	ExportOptions exportOptions = new ExportOptions();
    exportControl.setExportOptions(exportOptions);
    exportControl.setExportAsAttachment(true);
    exportControl.setOwnForm(true);
    exportControl.setOwnPage(true);

    String selectedFormat = (String) session.getAttribute("exportFormat");

    if(selectedFormat.equals("0")/*Crystal Report*/){
        exportOptions.setExportFormatType(ReportExportFormat.crystalReports);
    }
    else if(selectedFormat.equals("1")/*Word*/){
        exportOptions.setExportFormatType(ReportExportFormat.MSWord);
    }
    else if(selectedFormat.equals("2")/*Excel*/){
        exportOptions.setExportFormatType(ReportExportFormat.MSExcel);
    }
    else if(selectedFormat.equals("3")/*Rich Text Format*/){
        exportOptions.setExportFormatType(ReportExportFormat.RTF);
    }
    else if(selectedFormat.equals("5")/*PDF*/){
        exportOptions.setExportFormatType(ReportExportFormat.PDF);
    }
    else if(selectedFormat.equals("6")/*Excel without formatting*/){
        exportOptions.setExportFormatType(ReportExportFormat.recordToMSExcel);
    }
    else if(selectedFormat.equals("7")/*Text*/){
        exportOptions.setExportFormatType(ReportExportFormat.text);
    }
    else if(selectedFormat.equals("8")/*editable RTF*/){
        exportOptions.setExportFormatType(ReportExportFormat.editableRTF);
    }
    else if(selectedFormat.equals("9")/*Server Side CSV*/){
	    ReportClientDocument reportClientDoc = (ReportClientDocument)session.getAttribute("reportClientDoc");
	     PrintOutputController printOutputController = reportClientDoc.getPrintOutputController();
    	ByteArrayInputStream byteIS = (ByteArrayInputStream) printOutputController.export(ReportExportFormat.characterSeparatedValues);
		byte[] buf = new byte[2000 * 1024];
		int nRead = 0;
		response.reset();
		response.setHeader("content-disposition", "inline;filename=example.csv");
		response.setContentType("application/csv");
		while ((nRead = byteIS.read(buf)) != -1) {
  			response.getOutputStream().write(buf, 0, nRead);
		}
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}
	if (!selectedFormat.equals("9")/*Don't use the export control for CSV*/){
   		exportControl.processHttpRequest(request, response, getServletContext(), null);
   		exportControl.dispose();
   	}
%>


<html>
<head>
<!-- #include file=../Utilities.jsp -->
</head>
<body  onpaste='return false;'>
</body>
</html>

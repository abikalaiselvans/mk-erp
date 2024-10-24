<%//Crystal Java Reporting Component (JRC) imports.%>
<%@ page import="com.crystaldecisions.reports.sdk.*" %>
<%@ page import="com.crystaldecisions.sdk.occa.report.lib.*" %>
<%@ page import="com.crystaldecisions.sdk.occa.report.document.*" %>

<%
//Report can be opened from the relative location specified in the CRConfig.xml, or the report location
//tag can be removed to open the reports as Java resources or using an absolute path (absolute path not recommended
//for Web applications).
final String REPORT_NAME = "Smart Inventory/Reports/Customerlabel.rpt";
%>

<%

try {
	
	//Open report.
	ReportClientDocument reportClientDoc = new ReportClientDocument();
	reportClientDoc.open(REPORT_NAME, 0);

	//Create and set print options.
	PrintReportOptions printOptions = new PrintReportOptions();
	//Note: Printer with the 'printer name' below must already be configured.
	printOptions.setPrinterName("\\\\vanprt04\\H4-4050N-CS");
	printOptions.setJobTitle("Sample Print Job from JRC.");
	printOptions.setPrinterDuplex(PrinterDuplex.horizontal);
	printOptions.setPaperSource(PaperSource.auto);
	printOptions.setPaperSize(PaperSize.paperLetter);
	printOptions.setNumberOfCopies(1);
	printOptions.setCollated(false);
			
	PrintReportOptions.PageRange printPageRange = new PrintReportOptions.PageRange(1,1);
	printOptions.addPrinterPageRange(printPageRange);
			
	//NOTE: If parameters or database login credentials are required, they need to be set before.
	//calling the printReport() method of the PrintOutputController.
			
	//Print report.
	reportClientDoc.getPrintOutputController().printReport(printOptions);
			
	//Release report.
	reportClientDoc.close();
								
	out.println("Successfully sent report to the printer.");
		
}
catch(ReportSDKException ex) {	
	out.println(ex);
}
catch(Exception ex) {
	out.println(ex);			
}
%>
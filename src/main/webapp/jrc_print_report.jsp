
<%
/* 
 * Applies to versions:	XI Release 2
 * Date Created: December 2005
 * Description: This sample demonstrates how to print a report directly to a printer (server-side printing).
 * 				NOTE: If the report is based on a secured database the database login credentials
 * 				will need to be set before calling the export method below.  Also, if the report
 * 				has parameters, then values will need to be set for the report before export method can
 * 				be called or an error will be thrown.  See the ViewReportParameters or ViewReportLogon samples 
 * 				for samples on how to set parameters and login credentials through the JRC SDK.   
 * Author: CW.
 */
%>

<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>

<%//Crystal Java Reporting Component (JRC) imports.%>
<%@ page import="com.crystaldecisions.reports.sdk.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.lib.*"%>
<%@ page import="com.crystaldecisions.sdk.occa.report.document.*"%>

<%
//Report can be opened from the relative location specified in the CRConfig.xml, or the report location
//tag can be removed to open the reports as Java resources or using an absolute path (absolute path not recommended
//for Web applications).
final String REPORT_NAME = "jrc_print_report.rpt";
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

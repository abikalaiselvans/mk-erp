package com.my.org.erp.pdf;


import java.awt.Color;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Hashtable;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfGState;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;
import com.itextpdf.text.pdf.PdfWriter;

public class PDFWaterMarkText {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		 
		PDFWaterMarkText tool = new PDFWaterMarkText();
		tool.init();
		String[] params = {"drawText", "Sample Watermark Text"};
		tool.createWaterMarkPDF(params, "D:/Tomcat 5.0/webapps/SmartCampus/uploadfiles/Payslip_pdf/CISAUG2010003026_February_2011.pdf", "D:/Tomcat 5.0/webapps/SmartCampus/uploadfiles/Payslip_pdf/CISAUG2010003026_February_20112.pdf");
	}
	
		private static final long serialVersionUID = 1L;

		Hashtable<String, String> defaults = new Hashtable<String, String>();

		public void init() {
			// Initialize defaults.  These are 'commands' that are run before any commands
			// passed in to the extension through the args list
			defaults.put("x", "30");
			defaults.put("y", "30");
			defaults.put("textAngle", "auto");
			defaults.put("textAlign", "L");
			defaults.put("textAlpha", "20");
			defaults.put("textSize", "45");
			defaults.put("textColor", "0xD3D3D3");
		}

		public void createWaterMarkPDF(String[] args, String input, String output) {
			try {
				ArrayList<String[]> actions = new ArrayList<String[]>();

				Enumeration<String> e = defaults.keys();
				while (e.hasMoreElements()) {
					String k = e.nextElement();
					actions.add(new String[] { k, defaults.get(k) });
				}
				for (int i = 0; i < args.length; i += 2) {
					actions.add(new String[] { args[i], args[i + 1] });
				}
				
				// Source file
				InputStream is = new FileInputStream(input);
				
				// Watermarked resultant file
				OutputStream os = new FileOutputStream(output);

				PdfReader reader = new PdfReader(is);

				int n = reader.getNumberOfPages();

				PdfStamper stamp = new PdfStamper(reader, os);
				stamp.setEncryption(
						PdfWriter.STANDARD_ENCRYPTION_128 | PdfWriter.DO_NOT_ENCRYPT_METADATA, 
						null, null,
						PdfWriter.ALLOW_PRINTING | PdfWriter.ALLOW_COPY
							| PdfWriter.ALLOW_FILL_IN | PdfWriter.ALLOW_SCREENREADERS
							| PdfWriter.ALLOW_DEGRADED_PRINTING);

				for (int i = 1; i <= n; i++) {
					PdfContentByte pageContent = stamp.getOverContent(i);
					com.itextpdf.text.Rectangle pageSize = reader
							.getPageSizeWithRotation(i);

					watermarkPage(pageContent, actions, pageSize.getWidth(),
							pageSize.getHeight());
				}

				stamp.close();
				is.close();
				os.close();
				is = null;
				os = null;
			} catch (Exception e) {
				 System.out.println(e.getMessage());
			}
		}

		private void watermarkPage(PdfContentByte pageContent,
				ArrayList<String[]> actions, float width, float height)
				throws Exception {
			float x = 0;
			float y = 0;
			double textAngle = 0;
			int textAlign = PdfContentByte.ALIGN_CENTER;
			int fontSize = 14;

			pageContent.beginText();

			for (int i = 0; i < actions.size(); i++) {
				String action = actions.get(i)[0];
				String value = actions.get(i)[1];

				if (action.equals("x")) {
					x = Float.parseFloat(value) / 100 * width;
					continue;
				}

				if (action.equals("y")) {
					y = Float.parseFloat(value) / 100 * height;
					continue;
				}

				if (action.equals("textColor")) {
					pageContent.setColorFill(new BaseColor(Color.decode(value)));
					pageContent.setColorStroke(new BaseColor(Color.decode(value)));
					continue;
				}

				if (action.equals("textAlpha")) {
					PdfGState gs1 = new PdfGState();
					gs1.setFillOpacity(Float.parseFloat(value) / 100f);
					gs1.setStrokeOpacity((Float.parseFloat(value)) / 200f);
					pageContent.setGState(gs1);
					continue;
				}

				if (action.equals("textAngle")) {
					if (value.equals("auto")) {
						textAngle = (float) Math.atan2(height, width);
					} else {
						textAngle = Math.toRadians( Double.parseDouble(value) );
					}
					continue;
				}

				if (action.equals("textAlign")) {
					if (value.equals("L")) {
						textAlign = PdfContentByte.ALIGN_LEFT;
					} else if (value.equals("R")) {
						textAlign = PdfContentByte.ALIGN_RIGHT;
					} else {
						textAlign = PdfContentByte.ALIGN_CENTER;
					}
					continue;
				}

				if (action.equals("textSize")) {
					fontSize = Integer.parseInt(value);
					pageContent.setTextRenderingMode(PdfContentByte.TEXT_RENDER_MODE_FILL_STROKE); 
					pageContent.setFontAndSize(BaseFont
							.createFont(BaseFont.HELVETICA, BaseFont.WINANSI,
									BaseFont.EMBEDDED), fontSize);
					continue;
				}

				// x,y is top left/center/right of text, so that when we move the
				// cursor at the end of a line, we can cater for subsequent fontSize 
				// changes
				if (action.equals("drawText")) {
					pageContent.showTextAligned(textAlign, value,
							(float) (x + fontSize * Math.sin(textAngle)),
							(float) (y - fontSize * Math.cos(textAngle)),
							(float) Math.toDegrees(textAngle));

					x += fontSize * 1.2 * Math.sin(textAngle);
					y -= fontSize * 1.2 * Math.cos(textAngle);
					continue;
				}

				throw new Exception("Unknown command '" + action + "'");
			}

			pageContent.endText();
		}
	}
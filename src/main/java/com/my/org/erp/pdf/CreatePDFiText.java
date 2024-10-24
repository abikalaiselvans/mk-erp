package com.my.org.erp.pdf;


import java.awt.Color;
import java.io.*;

import com.lowagie.text.Document;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Chunk;
import com.lowagie.text.pdf.PdfWriter;
import com.lowagie.text.pdf.PdfContentByte;

public class CreatePDFiText {
	public static void main(String[] args) {
		try {

			Document document = new Document(PageSize.A4, 50, 50, 50, 50);
			PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream("C:/kalaipdf/AbciTextTest.pdf"));
            document.open();

            // create a chunk object using chunk class of itext library.
			Chunk underlined = new Chunk("This is sample pdf file created by : ");

			// set the distance between text and line.
			underlined.setTextRise(8.0f);

			// set the width of the line, 'y' position, color and design of the line
			underlined.setUnderline(new Color(0x00, 0x00, 0xFF),0.0f, 0.2f, 3.0f, 0.0f,PdfContentByte.LINE_CAP_PROJECTING_SQUARE);

			// finally add object to the document.
			document.add(underlined);
            document.add(new Paragraph("Mahendra Singh",
            FontFactory.getFont(FontFactory.COURIER, 14, Font.BOLD, new Color(255, 150, 200))));;
			document.close();
		} 
		catch (Exception e2) {
			System.out.println(e2.getMessage());
		}
	}
}

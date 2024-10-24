package com.my.org.erp.test.imageupload;

import java.awt.Color;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.MalformedURLException;

import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.List;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfWriter;

public class ITextWritePdfFile {

	public static void main(String[] args) {
		try {
			File file = new File("c:/itext-test.pdf");
			FileOutputStream fileout = new FileOutputStream(file);
			Document document = new Document();
			PdfWriter.getInstance(document, fileout);
			document.addAuthor("Me");
			document.addTitle("My iText Test");

			document.open();

			Chunk chunk = new Chunk("iText Test");
			Font font = new Font(Font.COURIER);
			font.setStyle(Font.UNDERLINE);
			font.setStyle(Font.ITALIC);
			chunk.setFont(font);
			chunk.setBackground(Color.CYAN);
			document.add(chunk);

			Paragraph paragraph = new Paragraph();
			paragraph.add("Hello World");
			paragraph.setAlignment(Element.ALIGN_CENTER);
			document.add(paragraph);

			Image image;
			try {
				image = Image.getInstance("c:/apple.jpg");
				image.setAlignment(Image.MIDDLE);
				document.add(image);
			} catch (MalformedURLException e) {
				 System.out.println(e.getMessage());
			} catch (IOException e) {
				 System.out.println(e.getMessage());
			}

			List list = new List(true, 15);
			list.add("ABC");
			list.add("DEF");
			document.add(list);

			document.close();
		} catch (FileNotFoundException e) {
			 System.out.println(e.getMessage());
		} catch (DocumentException e) {
			 System.out.println(e.getMessage());
		}
	}
}

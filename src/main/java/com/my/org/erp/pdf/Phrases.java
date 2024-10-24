
package com.my.org.erp.pdf;
import java.awt.Color;
import java.io.FileOutputStream;
import java.io.IOException;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfWriter;
public class Phrases {
	public static void main(String[] args)throws Exception 
                   {
		System.out.println("Phrases");
		Document document = new Document();
		PdfWriter.getInstance(document, new FileOutputStream("C:/kalaipdf/Phrasespdf.pdf"));
                	document.open();
			Phrase phrase0 = new Phrase();
			Phrase phrase1 = new Phrase("This is a phrase\n");
			Phrase phrase2 = new Phrase(25,"This is a phrase with leading 25. \n");
			Phrase phrase3 = new Phrase("This is a phrase with a red, normal font Courier20",FontFactory.getFont(FontFactory.COURIER, 20, Font.NORMAL,new Color(255, 0, 0)));
			Phrase phrase4 = new Phrase(new Chunk("(4) this is a phrase\n"));
			Phrase phrase5 = new Phrase(18,new Chunk("This is a phrase in Helvetica, bold, red and size 16 with a given leading of 18 points.\n",FontFactory.getFont(FontFactory.HELVETICA, 16,Font.BOLD, new Color(255, 0, 0))));
			Chunk chunk = new Chunk(" This is a font: ");
                        Phrase phrase6=new Phrase();
                      	phrase6.add(chunk);
			phrase6.add(new Chunk("Helvetica", FontFactory.getFont(FontFactory.HELVETICA, 12)));
			phrase6.add(chunk);
			phrase6.add(new Chunk("ZapfDingBats", FontFactory.getFont(FontFactory.ZAPFDINGBATS, 12)));
			Phrase phrase7 = new Phrase("If you don't add a newline !");
			document.add(phrase1);
			document.add(phrase2);
			document.add(phrase3);
			document.add(phrase4);
			document.add(phrase5);
			document.add(phrase6);
			document.add(phrase7);		
		document.close();
	}
}
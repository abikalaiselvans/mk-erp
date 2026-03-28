package com.my.org.erp.SmartAutocompleteServlet;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Iterator;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ReadExcelExample {
    public static void main(String[] args) {
    	
    	 try (FileInputStream file = new FileInputStream("C:\\Users\\KALAI\\eclipse-workspace2021\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\mk-erp-24-0\\uploads\\Funnel Report.xlsx");
         		XSSFWorkbook workbook = new XSSFWorkbook(file)) {

               XSSFSheet sheet = workbook.getSheetAt(0);

               Iterator<Row> rowIterator = sheet.iterator();
               while (rowIterator.hasNext()) {
                   Row row = rowIterator.next();
                   Iterator<Cell> cellIterator = row.cellIterator();

                   while (cellIterator.hasNext()) {
                       Cell cell = cellIterator.next();
                        
                            
                               System.out.print(cell.getStringCellValue() + "\t");
                               
                        
                   }
                   System.out.println();
               }

           } catch (IOException e) {
               e.printStackTrace();
           }
    	
    }
}

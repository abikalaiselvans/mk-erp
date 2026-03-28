package com.my.org.erp.SmartAutocompleteServlet;

import java.io.*;
import java.sql.*;
import java.util.*;
 
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.*;
 
/**
 * Sample Java program that imports data from an Excel file to MySQL database.
 *
 * @author Nam Ha Minh - https://www.codejava.net
 *
 */
public class Excel2DatabaseTest {
 
    public static void main(String[] args) {
        
        String excelFilePath = "C:\\Users\\KALAI\\Downloads\\Funnel Report.xlsx";
 
        int batchSize = 20;
  
 
        try {
            long start = System.currentTimeMillis();
             
            FileInputStream inputStream = new FileInputStream(excelFilePath);
 
            Workbook workbook = new XSSFWorkbook(inputStream);
 
            Sheet firstSheet = workbook.getSheetAt(0);
            Iterator<Row> rowIterator = firstSheet.iterator();
  
             
            int count = 0;
             
            rowIterator.next(); // skip the header row
             
            while (rowIterator.hasNext()) {
                Row nextRow = rowIterator.next();
                Iterator<Cell> cellIterator = nextRow.cellIterator();
 
                while (cellIterator.hasNext()) {
                    Cell nextCell = cellIterator.next();
 
                    int columnIndex = nextCell.getColumnIndex();
                     String value = nextCell.getStringCellValue();
                     System.out.println(value);
                     
 
                }
                  
                 
                if (++count % batchSize == 0) {
                     
                }              
 
            }
 
            workbook.close();
             
            
   
            long end = System.currentTimeMillis();
            System.out.printf("Import done in %d ms\n", (end - start));
             
        } catch (Exception ex1) {
            System.out.println("Error reading file");
            ex1.printStackTrace();
        }  
 
    }
}
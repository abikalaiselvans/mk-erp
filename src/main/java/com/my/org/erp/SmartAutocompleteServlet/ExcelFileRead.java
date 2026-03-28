package com.my.org.erp.SmartAutocompleteServlet;

import org.apache.poi.ss.usermodel.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

@WebServlet("/ExcelUploadServlet")
@MultipartConfig
public class ExcelFileRead extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        Part filePart = request.getPart("excelFile");
        try (InputStream is = filePart.getInputStream();
             Workbook workbook = WorkbookFactory.create(is)) {
            Sheet sheet = workbook.getSheetAt(0);
            List<List<String>> data = new ArrayList<>();
            for (Row row : sheet) {
                List<String> rowData = new ArrayList<>();
                for (Cell cell : row) {
                    rowData.add(cell.toString()); // Basic cell reading
                }
                data.add(rowData);
            }
            System.out.println(" ================== "+data);
            request.setAttribute("data", data);
            request.getRequestDispatcher("display.jsp").forward(request, response);
        }
    }
}
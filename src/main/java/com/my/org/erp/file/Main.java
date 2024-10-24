package com.my.org.erp.file;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;

/**
 *
 * @author www.javadb.com
 */
public class Main {

    public void readInputFromUser() {

        BufferedWriter bw = null;
        
        try {
            
            InputStream in = System.in;
            bw = new BufferedWriter(new FileWriter("output.txt"));

            StringBuilder builder = new StringBuilder();
            int letter;

            while ((letter = in.read()) != -1) {

                bw.write((char)letter);
                bw.flush();

                builder.append((char) letter);

                if (builder.toString().endsWith("finished")) {
                    System.exit(0);
                }
            }
        } catch (IOException e) {
             System.out.println(e.getMessage());
        } finally {
            if (bw != null) {
                try {
                    bw.close();
                } catch (IOException ex) {
                    ex.printStackTrace();
                }
            }
        }
    }

    public static void main(String[] args) {
        new Main().readInputFromUser();
    }
}

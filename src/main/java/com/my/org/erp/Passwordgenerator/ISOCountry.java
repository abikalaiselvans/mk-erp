package com.my.org.erp.Passwordgenerator;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
 
public class ISOCountry {
    public static void main(String[] args) {
        List<Country> countries = new ArrayList<Country>();
        BufferedReader br = null;
        try {
            br = new BufferedReader(new FileReader("D:/countries.csv"));
            String line = "";
            while((line = br.readLine()) != null) {
                String[] tokens = line.split(",");
                if(tokens.length == 4) {
                    countries.add(
                    new Country(tokens[0],
                    tokens[1],
                    tokens[2],
                    Integer.valueOf(tokens[3])));
                }
            }
            Collections.sort(countries);
            for(Country c : countries) {
                System.out.print(String.format("%03d", c.getNumericCode()));
                System.out.println(" - " + c);
            }
 
        } catch (IOException e) {
             System.out.println(e.getMessage());
        } finally {
            try {
                br.close();
            } catch (IOException e) {
                 System.out.println(e.getMessage());
            }
        }
    }
}
 

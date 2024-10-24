package com.my.org.erp.common;

import java.text.DecimalFormat;

public class UtilityFunctions {
  private static final DecimalFormat decfor = new DecimalFormat("0.00");
  
  public static double getDoubleplace(double num) {
    try {
      return Double.parseDouble(decfor.format(num));
    } catch (Exception e) {
      System.out.println(e.getMessage());
      return num;
    } 
  }
  
  public static String ConvertExponentialformtoDecimalnumber(double num) {
    try {
      return String.format("%.2f", new Object[] { Double.valueOf(num) });
    } catch (Exception e) {
      System.out.println(e.getMessage());
      return "0.00";
    } 
  }
}

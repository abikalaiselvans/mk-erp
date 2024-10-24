package com.my.org.erp.example.util;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class MainClass2 {
  public static void main(String args[]) {
    String orig[] = { "I", "P", "E", "G", "P" };
    String act[] = { "P", "P", "S" };
    Set origSet = new HashSet(Arrays.asList(orig));
    List actList = Arrays.asList(act);

    System.out.println(origSet.removeAll(actList));
    System.out.println(origSet);
  }
}
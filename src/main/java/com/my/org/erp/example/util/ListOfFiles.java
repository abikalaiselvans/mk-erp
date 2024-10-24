package com.my.org.erp.example.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.Enumeration;
import java.util.NoSuchElementException;

public class ListOfFiles implements Enumeration<FileInputStream> {

  private String[] listOfFiles;
  private int current = 0;

  public ListOfFiles(String[] listOfFiles) {
    this.listOfFiles = listOfFiles;
  }

  public boolean hasMoreElements() {
    if (current < listOfFiles.length)
      return true;
    else
      return false;
  }

  public FileInputStream nextElement() {
    FileInputStream in = null;

    if (!hasMoreElements())
      throw new NoSuchElementException("No more files.");
    else {
      String nextElement = listOfFiles[current];
      current++;
      try {
        in = new FileInputStream(nextElement);
      } catch (FileNotFoundException e) {
        System.err.println("ListOfFiles: Can't open " + nextElement);
      }
    }
    return in;
  }
}

   
package com.my.org.erp.file;

import java.io.File;
import java.io.FileFilter;

/**
 *
 * @author www.javadb.com
 */
public class FileUtil {

    public void myListFiles(String dir) {

        File directory = new File(dir);

        if (!directory.isDirectory()) {
            System.out.println("No directory provided");
            return;
        }
        
        File[] files = directory.listFiles(filefilter);
        System.out.println(files.length);
        for (File f : files) 
        {
            System.out.println(f.getName());
        }
    }

    //create a FileFilter and override its accept-method
    FileFilter filefilter = new FileFilter() {

        public boolean accept(File file) {
            //if the file extension is .txt return true, else false
            if (file.getName().endsWith(".pdf")) {
                return true;
            }
            return false;
        }
    };

    public static void main(String[] args) {
        FileUtil fileutil = new FileUtil();
        fileutil.myListFiles("C:/");
    }
}
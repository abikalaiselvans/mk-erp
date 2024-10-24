package com.my.org.erp.test.imageupload;
import java.io.File;
import java.io.FileFilter;
import java.io.IOException;

import org.apache.commons.io.IOCase;
import org.apache.commons.io.filefilter.PrefixFileFilter;

public class PrefixFileFilterTest {

	public static void main(String[] args) throws IOException {
		File directory = new File(".");

		File[] files = directory.listFiles();
		System.out.println("All files and directories:");
		displayFiles(files);

		System.out.println("\nFiles beginning with 'Test' (case sensitive):");
		//files = directory.listFiles((FileFilter) new PrefixFileFilter("Test", IOCase.SENSITIVE));
		displayFiles(files);

		System.out.println("\nFiles beginning with 'Test' (case insensitive):");
		//files = directory.listFiles((FileFilter) new PrefixFileFilter("Test", IOCase.INSENSITIVE));
		displayFiles(files);

	}

	public static void displayFiles(File[] files) {
		for (File file : files) {
			System.out.println(file.getName());
		}
	}

}

package com.my.org.erp.test.imageupload;
import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.util.Arrays;
import java.util.Date;

import org.apache.commons.io.comparator.NameFileComparator;
import org.apache.commons.io.filefilter.FileFileFilter;

public class NameFileComparatorTest {

	public static void main(String[] args) throws IOException {
		File directory = new File(".");
		// get just files, not directories
		File[] files = directory.listFiles((FileFilter) FileFileFilter.FILE);

		System.out.println("Default order");
		displayFiles(files);

		Arrays.sort(files, NameFileComparator.NAME_COMPARATOR);
		System.out.println("\nNames, case sensitive ascending order (NAME_COMPARATOR)");
		displayFiles(files);

		Arrays.sort(files, NameFileComparator.NAME_INSENSITIVE_COMPARATOR);
		System.out.println("\nNames, case insensitive ascending order (NAME_INSENSITIVE_COMPARATOR)");
		displayFiles(files);

		Arrays.sort(files, NameFileComparator.NAME_REVERSE);
		System.out.println("\nNames, case sensitive descending order (NAME_REVERSE)");
		displayFiles(files);

		Arrays.sort(files, NameFileComparator.NAME_INSENSITIVE_REVERSE);
		System.out.println("\nNames, case insensitive descending order (NAME_INSENSITIVE_REVERSE)");
		displayFiles(files);

	}

	public static void displayFiles(File[] files) {
		for (File file : files) {
			System.out.printf("File: %-20s Last Modified:" + new Date(file.lastModified()) + "\n", file.getName());
		}
	}

}


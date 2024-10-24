package com.my.org.erp.test.imageupload;
import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;

public class CopyFileTest {

	public static void main(String[] args) throws IOException {

		File file1 = new File("test1.txt");
		File file2 = new File("test1-copy.txt");
		checkExists(file1);
		checkExists(file2);

		System.out.println("\nCopying " + file1.getName() + " to " + file2.getName() + "\n");
		FileUtils.copyFile(file1, file2);

		checkExists(file1);
		checkExists(file2);

	}

	public static void checkExists(File file) {
		System.out.println(file.getName() + " exists? " + file.exists());
	}

}

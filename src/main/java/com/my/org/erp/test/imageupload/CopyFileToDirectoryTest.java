package com.my.org.erp.test.imageupload;
import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;

public class CopyFileToDirectoryTest {

	public static void main(String[] args) throws IOException {

		File file = new File("test1.txt");
		File destinationDir = new File("test-directory");

		FileUtils.copyFileToDirectory(file, destinationDir);

	}

}

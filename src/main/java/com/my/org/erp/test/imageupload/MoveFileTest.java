package com.my.org.erp.test.imageupload;
import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;

public class MoveFileTest {

	public static void main(String[] args) throws IOException {

		File sourceFile = new File("directory-source/test1.txt");
		File destinationFile = new File("directory-destination/test1.txt");

		//FileUtils.moveFile(sourceFile, destinationFile);
		
		//File sourceFile = new File("directory-source/test1.txt");
		//File destinationDir = new File("directory-destination");

		//FileUtils.moveFileToDirectory(sourceFile, destinationDir, true);



	}

}

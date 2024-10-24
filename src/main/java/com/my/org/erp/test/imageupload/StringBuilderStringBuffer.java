package com.my.org.erp.test.imageupload;
import java.util.Date;

public class StringBuilderStringBuffer {

	public static void main(String[] args) {

		long totalStringBufferTest = 0;
		long totalStringBuilderTest = 0;
		for (int i = 0; i < 10; i++) {
			totalStringBufferTest += stringBufferTest();
			totalStringBuilderTest += stringBuilderTest();
		}

		System.out.println("Total time in milliseconds for StringBuffer test:" + totalStringBufferTest);
		System.out.println("Total time in milliseconds for StringBuilder test:" + totalStringBuilderTest);

	}

	public static long stringBufferTest() {
		Date start = new Date();
		StringBuffer stringBuffer = new StringBuffer();
		for (int i = 0; i < 5000000; i++) {
			stringBuffer.append("a");
		}
		Date end = new Date();
		long millis = end.getTime() - start.getTime();
		System.out.println("StringBuffer time in milliseconds:" + millis);
		return millis;
	}

	public static long stringBuilderTest() {
		Date start = new Date();
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < 5000000; i++) {
			stringBuilder.append("a");
		}
		Date end = new Date();
		long millis = end.getTime() - start.getTime();
		System.out.println("StringBuilder time in milliseconds:" + millis);
		return millis;
	}

}

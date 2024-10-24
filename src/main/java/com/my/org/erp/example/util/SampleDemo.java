package com.my.org.erp.example.util;

class MyThread extends Thread
{
	public void run()
	{
		for(int i=0;i<10;i++)
		{
			System.out.println("child thread");
			Thread.yield();
		}
	}
}


class SampleDemo
{
	public static void main (String a[])
	{
		MyThread t = new MyThread();
		t.start();
		
		
		for(int i=0;i<10;i++);
		{
			System.out.println("main thread");
		}
	}
}

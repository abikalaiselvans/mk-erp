package com.my.org.erp.example.util;

public class MultipleThreads 
{
	public static void main(String[] args) 
	{
		System.out.println("The main thread of execution started");
		RunCounters rct1 = new RunCounters("First Thread");
		RunCounters rct2 = new RunCounters("Second Thread");
		RunCounters rct3 = new RunCounters("Third Thread");
	}
}

class RunCounters implements Runnable 
{
 Thread myThread;
 RunCounters(String name) 
 {
	 myThread = new Thread(this, name);
	 myThread.start();
 }
 
 public void run() 
 {
	 for ( int i=1; i<=5; i++) 
	 {
		 System.out.println("Thread: " + myThread.getName() + " Count: " + i);
	 }
 }
}
package com.my.org.erp.example.util;

public class ThreadTest 
{
	public static void main(String[] args) 
	{
		/*Counter ct = new Counter();
		ct.start();
		System.out.println("The thread has been started");
		System.out.println("The thread has been started");
		System.out.println("The thread has been started");
		System.out.println("The thread has been started");
		*/
		
		RunCounter rct = new RunCounter();
		Thread th = new Thread(rct);
		
		System.out.println("The thread has been started");
		th.start();
	}
}


class Counter extends Thread 
{
	public void run() 
	{
		for ( int i=1; i<=5; i++) 
		{
			System.out.println("Count: " + i);
		}
	}
}

//----------------------------------------------
class RunCounter extends Nothing implements Runnable 
{
	public void run() 
	{
		for ( int i=1; i<=5; i++) 
		{
			System.out.println("Count: " + i);
		}
	}
}

class Nothing 
{
}
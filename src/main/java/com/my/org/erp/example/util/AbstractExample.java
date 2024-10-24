package com.my.org.erp.example.util;

public class AbstractExample {

	/**
	 * @param args
	 */
	public static void main(String[] args) 
	{
		 

		aexexample a1 = new aexexample();
		D d = new D();
		d.display();
		pTest p = new pTest();
		 
	}

}


abstract class aexample
{
	
}

class aexexample extends aexample
{
	
}

class pTest
{
	public void add(int i,long j, long k)
	{
		System.out.println("Inside int long long");
		System.out.println("Result is :"+(i+j+k));
	}
	public void add(long i,int j,int k)
	{
		System.out.println("Inside long,int,int");
		System.out.println("Result is :"+(i+j+k));
	}
}	
	
class As
{
	public void display(){System.out.println("kalai");};
	
}

class Bs extends As
{
	public void display(){ System.out.println("selvan");};
}


class D extends As 
{
	public void display()
	{
		System.out.println("K.");
	}
}
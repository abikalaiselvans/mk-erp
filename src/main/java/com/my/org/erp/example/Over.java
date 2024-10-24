package com.my.org.erp.example;

public class Over {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		Ap b =  new B ();
		b.Mdis(12);
	}

}



class Ap
{
	public void Mdis (int a)
	{
		System.out.println("A");
	}
}


class B extends Ap
{
	public void Mdis (int a)
	{
		System.out.println("B");
	}
}

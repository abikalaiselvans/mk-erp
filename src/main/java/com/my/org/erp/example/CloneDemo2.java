package com.my.org.erp.example;

class TestClone1 implements Cloneable {
	  int a;

	  double b;

	  public Object clone() {
	    try {
	      return super.clone();
	    } catch (CloneNotSupportedException e) {
	      System.out.println("Cloning not allowed.");
	      return this;
	    }
	  }
	}

	class CloneDemo2 {
	  public static void main(String args[]) {
	    TestClone1 x1 = new TestClone1();
	    TestClone1 x2;

	    x1.a = 10;
	    x1.b = 20.98;

	    x2 = (TestClone1) x1.clone();

	    System.out.println("x1: " + x1.a + " " + x1.b);
	    System.out.println("x2: " + x2.a + " " + x2.b);
	  }
	}
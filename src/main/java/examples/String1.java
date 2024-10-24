package examples;

public class String1 {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		String s;
		String h = new String("kalai");
		String h1 = "kalai";
		System.out.println(h.equals(h1) +"/" +(h == h1));
		int i;
		System.out.println( );
		String str = "null";
		 if (str == null) 
		  System.out.println("null");
		 else if(str.length() == 0) 
		 	System.out.println("zero");
		 else 
		  System.out.println("some");
		 
	}

}

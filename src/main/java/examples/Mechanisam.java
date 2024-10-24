package examples;

import java.io.IOException;
import java.nio.CharBuffer;

/**
 *
 * @author Administrator
 */
public class Mechanisam {
    
    static void single() 
    {
        Runnable ob;
        ob = new Runnable() 
        {
            public void run() 
            {
                System.out.println("executed" +Thread.currentThread().getName());
           }
        };
        
        
        Thread one = new Thread(ob);
        Thread two = new Thread(ob);
        one.setName("thread1");
        two.setName("thread2");
        two.setPriority(10);
        one.setPriority(1);
        one.start();
        two.start();
        System.out.println(one.getPriority());
        System.out.println("---");
        
        System.out.println(one.isAlive());
        System.out.println(two.isAlive());
        System.out.println(one.isAlive()); 
        System.out.println(one.getState());
        System.out.println(two.getState());
    }
    
    public static void main(String args[]) throws InterruptedException 
    {
        single();
    }
}

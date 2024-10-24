package com.my.org.erp.SessionFactory;

import java.util.Arrays;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.my.org.erp.bean.inventory.Color;

 

public class HColorInsertion 
{
	
	public static void insert(Color c)
	{
		try 
		{
			Session session=HibernateSessionFactory.getSession();
			Transaction tx=session.beginTransaction();
			session.save(c);
			tx.commit();
			session.close();
			System.out.println("The data has been inserted......");
			
		} 
		catch (HibernateException e) 
		{
			System.out.println(e.getMessage());
		}
	}
	
	public static void update(Color c)
	{
		try 
		{
			Session session=HibernateSessionFactory.getSession();
			Transaction tx=session.beginTransaction();
			session.update(c);
			tx.commit();
			session.close();
			System.out.println("The data has been updated......");
			
		} 
		catch (HibernateException e) 
		{
			System.out.println(e.getMessage());
		}
	}
	
	public static void delete(Color c )
	{
		try 
		{
			Session session=HibernateSessionFactory.getSession();
			Transaction tx=session.beginTransaction();
			session.delete(c);
			tx.commit();
			session.close();
			System.out.println("The data has been delete......");
			
		} 
		catch (HibernateException e) 
		{
			System.out.println(e.getMessage());
		}
	}
	
	public static List view(  )
	{
		try 
		{
			Session session=HibernateSessionFactory.getSession();
			Query q = session.createQuery(" INT_COLORID,CHR_COLORCODE from inv_m_color");  
			List reviews = q.list(); 
			session.close();
			System.out.println("The data has been delete......");
			return reviews;
			
		} 
		catch (HibernateException e) 
		{
			System.out.println(e.getMessage());
		}
		return null;
	}
	
 
	
}

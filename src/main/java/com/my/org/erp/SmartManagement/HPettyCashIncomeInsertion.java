package com.my.org.erp.SmartManagement;
 
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
 

import com.my.org.erp.SessionFactory.HibernateSessionFactory;
import com.my.org.erp.bean.management.PettyCashIncome;

 

public class HPettyCashIncomeInsertion 
{
	
	public static void insert(PettyCashIncome c)
	{
		try 
		{
			Session session=HibernateSessionFactory.getSession();
			Transaction tx=session.beginTransaction();
			System.out.println(""+c);
			session.save(c);
			System.out.println(""+c);
			tx.commit();
			session.close();
			
		} 
		catch (HibernateException e) 
		{
			System.out.println(e.getMessage());
		}
	}
	
	public static void update(PettyCashIncome c)
	{
		try 
		{
			Session session=HibernateSessionFactory.getSession();
			Transaction tx=session.beginTransaction();
			session.update(c);
			tx.commit();
			session.close();
			
		} 
		catch (HibernateException e) 
		{
			System.out.println(e.getMessage());
		}
	}
	
	public static void delete(PettyCashIncome c )
	{
		try 
		{
			Session session=HibernateSessionFactory.getSession();
			Transaction tx=session.beginTransaction();
			session.delete(c);
			tx.commit();
			session.close();
			
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
			Query q = session.createQuery("");  
			List reviews = q.list(); 
			session.close();
			return reviews;
			
		} 
		catch (HibernateException e) 
		{
			System.out.println(e.getMessage());
		}
		return null;
	}
	
 
	
}

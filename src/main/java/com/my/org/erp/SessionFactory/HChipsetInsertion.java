package com.my.org.erp.SessionFactory;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import com.my.org.erp.bean.inventory.Chipset;
 
public class HChipsetInsertion 
{
	
	public static void insert(Chipset c)
	{
		try 
		{
			Session session=HibernateSessionFactory.getSession();
			Transaction tx=session.beginTransaction();
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
	
	public static void update(Chipset c)
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
	
	public static void delete(Chipset c )
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
			Query q = session.createQuery(" INT_PROCESSORID,CHR_PROCESSORNAME,CHR_DESC  FROM inv_m_processor ");  
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

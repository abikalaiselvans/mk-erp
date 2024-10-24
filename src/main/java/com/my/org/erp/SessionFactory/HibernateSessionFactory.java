package com.my.org.erp.SessionFactory;

import org.hibernate.*;
import org.hibernate.cfg.*;

public class HibernateSessionFactory 
{
	
	private static SessionFactory sessionFactory;
	
	static
	{
		Configuration cfg=new Configuration();
		cfg.configure();
		sessionFactory=cfg.buildSessionFactory();
		 
		sessionFactory = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
		 
	}
	
	private HibernateSessionFactory()
	{
		
	}
	
	public static Session getSession()
	{
		return sessionFactory.openSession();
	}
	
	public static void closeSessionFactory()
	{
		if(sessionFactory!=null)
		{
			sessionFactory.close();
		}
	}

}

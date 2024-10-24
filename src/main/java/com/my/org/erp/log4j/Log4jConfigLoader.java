/**
 * Copyright 2007 laliluna.de
 * Sebastian Hennebrueder
 * 
 */
package com.my.org.erp.log4j;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

@SuppressWarnings("serial")

public class Log4jConfigLoader extends HttpServlet {

    private Thread thread;
    
    @Override
    public void destroy() {
	thread.interrupt();
	super.destroy();
	
    }

    @Override
    public void init() throws ServletException {
	super.init();
	MonitorThread monitorThread = new MonitorThread();
	monitorThread.setCheckIntervalMillis(10000);
	monitorThread.setUrl(Log4jConfigLoader.class.getResource("/log4j.xml"));
	thread = new Thread(monitorThread);
	thread.start();
    }

}

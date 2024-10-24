package examples;


import java.sql.*;
import java.util.*;

/** A class for preallocating, recycling, and managing
 *  JDBC connections.
 *  <P>
 *  Taken from Core Servlets and JavaServer Pages
 *  from Prentice Hall and Sun Microsystems Press,
 *  http://www.coreservlets.com/.
 *  &copy; 2000 Marty Hall; may be freely used or adapted.
 */

public class ConnectionPool implements Runnable 
{
  private String driver, url, username, password;
  private int maxConnections;
  private boolean waitIfBusy;
  private Vector availableConnections, busyConnections;
  private boolean connectionPending = false;


  public ConnectionPool(String driver, String url, String username, String password,
                        int initialConnections,int maxConnections,boolean waitIfBusy)throws SQLException 
  {
    this.driver = driver;
    this.url = url;
    this.username = username;
    this.password = password;
    this.maxConnections = maxConnections;
    this.waitIfBusy = waitIfBusy;
    if (initialConnections > maxConnections) 
    {
      initialConnections = maxConnections;
    }
    availableConnections = new Vector(initialConnections);
    busyConnections = new Vector();
    
    for(int i=0; i<initialConnections; i++) 
    {
      availableConnections.addElement(makeNewConnection());
    }
  }
  
  
  
  
  
  public synchronized Connection getConnection() throws SQLException 
  {
    if (!availableConnections.isEmpty()) 
    {
    	Connection existingConnection =
        (Connection)availableConnections.lastElement();
    	int lastIndex = availableConnections.size() - 1;
    	availableConnections.removeElementAt(lastIndex);
      
    		if (existingConnection.isClosed()) 
    		{
    			notifyAll(); // Freed up a spot for anybody waiting
    			return(getConnection());
    		} 
    		else 
    		{
    			busyConnections.addElement(existingConnection);
    			return(existingConnection);
    		}
    } 
    else 
    {
      
       if ((totalConnections() < maxConnections) && !connectionPending) 
       {
        makeBackgroundConnection();
       } 
       else if (!waitIfBusy) 
       {
        throw new SQLException("Connection limit reached");
       }
      
       try 
       {
        wait();
      } 
       catch(InterruptedException ie) {}
      return(getConnection());
    }
  }

  
    private void makeBackgroundConnection() 
    {
    	connectionPending = true;
    	try 
    	{
    		Thread connectThread = new Thread(this);
    		connectThread.start();
    	} 
    	catch(OutOfMemoryError oome) 
    	{
    	}
  }

    
  public void run() 
  {
    try 
    {
      Connection connection = makeNewConnection();
      synchronized(this) 
      {
        availableConnections.addElement(connection);
        connectionPending = false;
        notifyAll();
      }
    } 
    catch(Exception e) 
    { 
    }
  }

  private Connection makeNewConnection() throws SQLException 
  {
    try 
    {
    	Class.forName(driver);
      	Connection connection =
      	DriverManager.getConnection(url, username, password);
      	return(connection);
    } 
    catch(ClassNotFoundException cnfe) 
    {
      throw new SQLException("Can't find class for driver: " + driver);
    }
  }

  
  public synchronized void free(Connection connection) 
  {
    busyConnections.removeElement(connection);
    availableConnections.addElement(connection);
    notifyAll(); 
  }
    
  
  public synchronized int totalConnections() 
  {
    return(availableConnections.size() + busyConnections.size());
  }

  
  public synchronized void closeAllConnections() 
  {
    closeConnections(availableConnections);
    availableConnections = new Vector();
    closeConnections(busyConnections);
    busyConnections = new Vector();
  }

  
  private void closeConnections(Vector connections) 
  {
    try 
    {
      for(int i=0; i<connections.size(); i++) 
      {
        Connection connection =  (Connection)connections.elementAt(i);
        if (!connection.isClosed()) 
        {
          connection.close();
        }
      }
    }
    catch(SQLException sqle) 
    {
    }
  }
  
  
  public synchronized String toString() 
  {
    String info =
      "ConnectionPool(" + url + "," + username + ")" +
      ", available=" + availableConnections.size() +
      ", busy=" + busyConnections.size() +
      ", max=" + maxConnections;
    return(info);
  }
}


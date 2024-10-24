package com.my.org.erp.Jmail;
import javax.mail.*;

public class MailUserBean
{

    private Folder folder;
    private String hostname;
    private String username;
    private String password;
    private Session session;
    private Store store;
    private URLName url;
    private String protocol;
    private String mbox;

    public MailUserBean()
    {
        protocol = "imap";
        mbox = "INBOX";
    }

    public Folder getFolder()
    {
        return folder;
    }

    public String getHostname()
    {
        return hostname;
    }

    public int getMessageCount()
        throws MessagingException
    {
        return folder.getMessageCount();
    }

    public String getPassword()
    {
        return password;
    }

    public Session getSession()
    {
        return session;
    }

    public Store getStore()
    {
        return store;
    }

    public URLName getUrl()
    {
        return url;
    }

    public String getUsername()
    {
        return username;
    }

    public boolean isLoggedIn()
    {
        return store.isConnected();
    }

    public void login()
        throws Exception
    {
        url = new URLName(protocol, getHostname(), -1, mbox, getUsername(), getPassword());
        java.util.Properties properties = System.getProperties();
        session = Session.getInstance(properties, null);
        store = session.getStore(url);
        store.connect();
        folder = session.getFolder(url);
        folder.open(2);
    }

    public void login(String s, String s1, String s2)
        throws Exception
    {
        hostname = s;
        username = s1;
        password = s2;
        login();
    }

    public void logout()
        throws MessagingException
    {
        folder.close(false);
        store.close();
        store = null;
        session = null;
    }

    public void setHostname(String s)
    {
        hostname = s;
    }

    public void setPassword(String s)
    {
        password = s;
    }

    public void setSession(Session session1)
    {
        session = session1;
    }

    public void setStore(Store store1)
    {
        store = store1;
    }

    public void setUsername(String s)
    {
        username = s;
    }
}

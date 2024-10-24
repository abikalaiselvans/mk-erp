package com.my.org.erp.chats;
 
import javax.servlet.ServletContext;
import javax.servlet.http.*;

// Referenced classes of package sukhwinder.chat:
//            ChatRoomList, ChatRoom, Chatter

public class SessionListener
    implements HttpSessionAttributeListener
{

    public void attributeAdded(HttpSessionBindingEvent httpsessionbindingevent)
    {
    }

    public void attributeReplaced(HttpSessionBindingEvent httpsessionbindingevent)
    {
    }

    public void attributeRemoved(HttpSessionBindingEvent httpsessionbindingevent)
    {
        String s = httpsessionbindingevent.getName();
        HttpSession httpsession = httpsessionbindingevent.getSession();
        if("nickname".equalsIgnoreCase(s))
        {
            String s1 = (String)httpsessionbindingevent.getValue();
            if(s1 != null)
            {
                ServletContext servletcontext = httpsession.getServletContext();
                if(servletcontext != null)
                {
                    Object obj = servletcontext.getAttribute("chatroomlist");
                    if(obj != null)
                    {
                        ChatRoomList chatroomlist = (ChatRoomList)obj;
                        ChatRoom chatroom = chatroomlist.getRoomOfChatter(s1);
                        if(chatroom != null)
                        {
                            Object obj1 = chatroom.removeChatter(s1);
                            @SuppressWarnings("unused")
							String s2;
                            if(obj1 != null)
                            {
                                s2 = ((Chatter)obj1).getName();
                            }
                        }
                    }
                } else
                {
                    System.out.println("ServletContext is null");
                }
            }
        }
    }

    public SessionListener()
    {
    }
}

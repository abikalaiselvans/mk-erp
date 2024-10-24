package com.my.org.erp.chats;

public class Message
{

    private String chatterName;
    private String message;
    private long timeStamp;

    public String getChatterName()
    {
        return chatterName;
    }

    public String getMessage()
    {
        return message;
    }

    public long getTimeStamp()
    {
        return timeStamp;
    }

    private final void _mththis()
    {
        chatterName = null;
        message = null;
    }

    public Message(String s, String s1, long l)
    {
        _mththis();
        chatterName = s;
        message = s1;
        timeStamp = l;
    }
}

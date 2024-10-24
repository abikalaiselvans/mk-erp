package com.my.org.erp.chat;

import java.io.*;
import java.net.*;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;


@SuppressWarnings("serial")
public class ChatServer extends JFrame {
//implements ActionListener{
//static ChatClient cObj;
//static String yname;
static String yourname;
@SuppressWarnings("static-access")
public ChatServer(String title)
{

output = new TextArea (15,40);
output.setEditable (false);
output.setFont(f);
output.setForeground(Color.blue);
this.yourname="Fatima";

setTitle(title);
setJMenuBar(menuBar);
JMenu fileMenu = new JMenu("File");
JMenu colorMenu = new JMenu("Color");
JMenu helpMenu = new JMenu("Help");

//Main menu Shortcuts:
fileMenu.setMnemonic('F');
colorMenu.setMnemonic('C');
helpMenu.setMnemonic('H');

addMenuItem(fileMenu,exitAction = new FileAction("Exit"));

//Color pulldown menu:

//Set Background Colors:
addMenuItem (colorMenu, redAction = new ColorAction("Red BackGround", Color.red));
addMenuItem (colorMenu, yellowAction = new ColorAction("Yellow BackGround", Color.yellow));
addMenuItem (colorMenu, greenAction = new ColorAction("Green BackGround", Color.green));
addMenuItem (colorMenu, blueAction = new ColorAction("Blue BackGround", Color.blue));
addMenuItem (colorMenu, magentaAction = new ColorAction("Magenta BackGround",Color.magenta));
addMenuItem (colorMenu, cyanAction = new ColorAction("Cyan BackGround", Color.cyan));
addMenuItem (colorMenu, blackAction = new ColorAction("Black BackGround", Color.black));
addMenuItem (colorMenu, grayAction = new ColorAction("Gray BackGround", Color.gray));
addMenuItem (colorMenu, darkGrayAction = new ColorAction("DarkGray BackGround", Color.darkGray));
addMenuItem (colorMenu, pinkAction = new ColorAction("Pink BackGround", Color.pink));
addMenuItem (colorMenu, orangeAction = new ColorAction("Orange BackGround", Color.orange));
addMenuItem (colorMenu, whiteAction = new ColorAction("White BackGround", Color.white));


//About Dialog init:
aboutItem = new JMenuItem("About");
//aboutItem.addActionListener((ActionListener)this);
helpMenu.add(aboutItem);
addMenuItem(helpMenu,aboutAction = new AboutAction("About"));

//Initialize menu items:
menuBar.add(fileMenu);
menuBar.add(colorMenu);
menuBar.add(helpMenu);

enableEvents(AWTEvent.WINDOW_EVENT_MASK);

}

class AboutAction extends AbstractAction
{
JOptionPane opt;
String name;
public AboutAction(String Name)
{
this.name=Name;
}
//About menu event:
public void actionPerformed(ActionEvent ae)
{
//if(ae.getSource() == aboutAction)
 {
 JOptionPane.showMessageDialog (opt,"ChitChat Broadcast Messenger\nCopyright Fatima Ahmed  2004","About ChitChat Broadcast Messenger",JOptionPane.INFORMATION_MESSAGE);
 }
}
}


protected void processWindowEvent(WindowEvent e)
{
if (e.getID() == WindowEvent.WINDOW_CLOSING)
{
dispose();
System.exit(0);
}
super.processWindowEvent(e);
}

private JMenuItem addMenuItem(JMenu menu,Action action)
{
JMenuItem item = menu.add(action);
KeyStroke keyStroke = (KeyStroke)action.getValue("j");//action.ACCELERATOR_KEY);
if(keyStroke != null)
item.setAccelerator(keyStroke);
return item;
}

//Main menu init:
private JMenuBar menuBar = new JMenuBar();
//About menu init:
private JMenuItem aboutItem;

//File Menu Action:
class FileAction extends AbstractAction
{
public FileAction(String NAME,KeyStroke keyStroke)
	{
	super(NAME);
	}
String name;

public FileAction(String name)
{
super(name);
this.name=name;
}
public void actionPerformed(ActionEvent e)
 {
 String name= (String)getValue(NAME);
 if(name.equals(exitAction.getValue(NAME)))
	{
	dispose();
	System.exit(0);
	}
 }
}

//Background color Action
//Inner Class definition
class ColorAction extends AbstractAction
{
public ColorAction(String name,Color color)
{
super(name);
this.color=color;
}
public void actionPerformed(ActionEvent e)
{
elementColor = color;
getContentPane().setBackground(color);
}
private Color color;
}

@SuppressWarnings("unused")
private AboutAction aboutAction;
private FileAction exitAction;
@SuppressWarnings("unused")
private Color elementColor;
@SuppressWarnings("unused")
private ColorAction redAction,yellowAction,greenAction,blueAction,magentaAction,cyanAction,blackAction,grayAction,darkGrayAction,pinkAction,orangeAction,whiteAction;

public static TextArea output;
Font f=new Font("SansSerif",Font.PLAIN,16);

public static void main (String args[]) throws IOException {

ChatServer ServerWindow = new ChatServer("ChitChat Broadcast Messenger: Server Window");
Toolkit theKit = ServerWindow.getToolkit();
Dimension wndSize = theKit.getScreenSize();

ServerWindow.setBounds(wndSize.width/4,wndSize.height/4,wndSize.width/2,wndSize.height/2);
ServerWindow.setVisible(true);
ServerWindow.getContentPane().add ("North", output);
ServerWindow.getContentPane().setLayout(new FlowLayout(FlowLayout.CENTER));

ServerWindow.pack();

    if (args.length != 1)
      throw new IllegalArgumentException ("Syntax: ChatServer <port>");
    int port = Integer.parseInt (args[0]);
    @SuppressWarnings("unused")
	String logins;
    ServerSocket server = new ServerSocket (port);
    while (true) {
      Socket client = server.accept ();
///////////////////////////////////
   //logins = JOptionPane.showInputDialog("Enter Login name:");
//yname=cObj.Fun();
//      //System.out.println ("Accepted from " + client.getInetAddress ()+" with name "+logins);
      ChatHandler handler = new ChatHandler (client,yourname);
      handler.start ();
output.append ("\n Accepted from " + client.getInetAddress ()+"\n");

    }
}

}

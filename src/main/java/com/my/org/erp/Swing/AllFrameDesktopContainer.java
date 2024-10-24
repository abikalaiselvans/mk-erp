package com.my.org.erp.Swing;
import javax.swing.*;
import javax.swing.event.*;


public class AllFrameDesktopContainer{
	JDesktopPane desk;
	JInternalFrame iframe;
	JFrame frame;
	public static void main(String[] args) {
		@SuppressWarnings("unused")
		AllFrameDesktopContainer d = new AllFrameDesktopContainer();
	}

	public AllFrameDesktopContainer(){
		frame = new JFrame("All Frames in a JDesktopPane Container");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		desk = new JDesktopPane();
		try{
			String str = JOptionPane.showInputDialog(null, "Enter number of frames :", "Roseindia.net", 1);
			int i = Integer.parseInt(str);
			for (int j = 1; j <= i; j++){
				iframe = new JInternalFrame("Internal Frame: " + j, true, true, true, true);
				iframe.setBounds(j*20, j*20, 150, 100);
				iframe.setVisible(true);
				desk.add(iframe);
				iframe.setToolTipText("Internal Frame :" + j);
			}
		}
		catch(NumberFormatException ne){
			JOptionPane.showMessageDialog(null, "Please enter number value.", "Roseindia.net", 1);
			System.exit(0);
		}
		JMenuBar menubar = new JMenuBar();
		JMenu count = new JMenu("Count Total Frames");
		count.addMenuListener(new MyAction());
		menubar.add(count);
		frame.setJMenuBar(menubar);
		frame.add(desk);
		frame.setSize(400,400);
		frame.setVisible(true);
	}

	public class MyAction implements MenuListener{
		public void menuSelected(MenuEvent me){
			int i = desk.getAllFrames().length;
			JOptionPane.showMessageDialog(null, "Total visible internal frames is : " + i, "Roseindia.net", 1);
		}

		public void menuCanceled(MenuEvent me){}

		public void menuDeselected(MenuEvent me){}
	}
}
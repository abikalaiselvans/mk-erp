package com.my.org.erp.SampleProject;

import java.awt.*;
import java.awt.event.*;
public class Calculator	extends	WindowAdapter implements
				ActionListener
{
	static 	TextField tf = new TextField(20);
	int a=0;
	int b=0;
	public static void main(String[] args) 
	{
		Calculator c = new Calculator();
		Frame f = new Frame("Calculator");
		
		Panel pGrid = new Panel();
		pGrid.setLayout(new GridLayout(4,5));
		Button b7 = new Button("7");
		b7.addActionListener(c);
		Button b8 = new Button("8");
		b8.addActionListener(new Calculator());
		Button b9 = new Button("9");
		b9.addActionListener(new Calculator());
		Button b4 = new Button("4");
		Button b5 = new Button("5");
		Button b6 = new Button("6");
		Button b1 = new Button("1");
		Button b2 = new Button("2");
		Button b3 = new Button("3");
		Button b0 = new Button("0");
		Button bMc = new Button("MC");
		Button bMr = new Button("MR");
		Button bMs = new Button("MS");
		Button bmPlus = new Button("M+");
		bmPlus.addActionListener(c);
		Button bdiv = new Button("/");
		Button bmul = new Button("*");
		Button badd = new Button("+");
		badd.addActionListener(c);
		Button bsub = new Button("-");
		Button beq = new Button("=");
		beq.addActionListener(c);
		Button bdot = new Button(".");

		Button bBack = new Button("Backspace");
		Button bCe = new Button("CE");
		Button bC = new Button("C");

		MenuItem Copy = new MenuItem("Copy");
		MenuItem Paste = new MenuItem("Paste");
		MenuItem New = new MenuItem("New");
		MenuItem Quit = new MenuItem("Quit");
		Quit.addActionListener(c);
		CheckboxMenuItem Open = new CheckboxMenuItem("Open");
		Open.addActionListener(c);

		Menu FileMenu = new Menu("File");
		FileMenu.add(New);
		FileMenu.add(Open);
		FileMenu.add(Quit);

		Menu EditMenu = new Menu("Edit");
		EditMenu.add(Copy);
		EditMenu.add(Paste);

		MenuBar mb = new MenuBar();
		mb.add(FileMenu);
		mb.add(EditMenu);

		f.setMenuBar(mb);

		pGrid.add(bMc);
		pGrid.add(b7);
		pGrid.add(b8);
		pGrid.add(b9);
		pGrid.add(bdiv);
		
		pGrid.add(bMr);
		pGrid.add(b4);
		pGrid.add(b5);
		pGrid.add(b6);
		pGrid.add(bmul);

		pGrid.add(bMs);
		pGrid.add(b1);
		pGrid.add(b2);
		pGrid.add(b3);
		pGrid.add(bsub);

		pGrid.add(bmPlus);
		pGrid.add(b0);
		pGrid.add(bdot);
		pGrid.add(beq);
		pGrid.add(badd);

		Panel pFlow = new Panel();
		
		pFlow.add(bBack);
		pFlow.add(bCe);
		pFlow.add(bC);

		
		f.setBackground(new Color(156,134,135));
		f.setSize(200,200);
		f.setResizable(false);
		f.setLocation(200,200);

		f.add(tf,BorderLayout.NORTH);
		f.add(pFlow,BorderLayout.CENTER);
		f.add(pGrid,BorderLayout.SOUTH);
		f.addWindowListener(new Calculator());
		f.setVisible(true);
	}

	public void actionPerformed(ActionEvent e)
	{
				
		String command = e.getActionCommand();
		System.out.println(command);
		if(command.equals("+"))
		{
			this.a = Integer.parseInt(tf.getText()); 
			tf.setText("");
//			System.out.println("a : " + a);
		}
		else if(command.equals("="))
		{
			b = Integer.parseInt(tf.getText());
			int c = a+b;
			
			tf.setText(c+"");
		}
		else if(command.equals("Quit"))
		{
			System.exit(1);
		}
		else
		{
			tf.setText(tf.getText()+command);
		}
	}

	public void windowClosing(WindowEvent e)
	{
		System.exit(0);
	}
}

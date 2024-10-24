package com.my.org.erp.jfree;

import java.awt.*;
import org.jfree.chart.*;
import org.jfree.chart.title.*;
import org.jfree.data.general.DefaultPieDataset;
import org.jfree.ui.*;
import org.jfree.chart.plot.*;
import org.jfree.util.*;

public class Pie3D{
public static void main(String arg[]){
  DefaultPieDataset pieDataset = new DefaultPieDataset();
  pieDataset.setValue("One", new Integer(10));
  pieDataset.setValue("Two", new Integer(20));
  pieDataset.setValue("Three", new Integer(30));
  pieDataset.setValue("Four", new Integer(10));
  pieDataset.setValue("Five", new Integer(20));
  pieDataset.setValue("Six", new Integer(10));
  JFreeChart chart = ChartFactory.createPieChart3D
  ("3D Pie Chart", pieDataset, true,true,true);
  PiePlot3D p=(PiePlot3D)chart.getPlot();
  p.setForegroundAlpha(0.5f);
  ChartFrame frame1=new ChartFrame("3D Pie Chart",chart);
  frame1.setVisible(true);
  frame1.setSize(300,300);
  }
}
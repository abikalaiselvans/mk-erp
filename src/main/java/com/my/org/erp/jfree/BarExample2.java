package com.my.org.erp.jfree;

import org.jfree.chart.*;
import org.jfree.data.category.*;

import org.jfree.chart.plot.*;
import java.awt.*;

public class BarExample2{
public static void main(String arg[]){
	DefaultCategoryDataset dataset = new DefaultCategoryDataset();
	dataset.setValue(6, "Science", "Rahul");
	dataset.setValue(8, "Maths", "Rahul");
	dataset.setValue(5, "Science", "Deepak");
	dataset.setValue(3, "Maths", "Deepak");
	dataset.setValue(6, "Science", "Vinod");
	dataset.setValue(9, "Maths", "Vinod");
	dataset.setValue(2, "Science", "Chandan");
	dataset.setValue(4, "Maths", "Chandan");
    JFreeChart chart = ChartFactory.createBarChart3D("Comparison between Students","Students", "Marks", dataset, PlotOrientation.VERTICAL, true,true, false);
	chart.setBackgroundPaint(Color.yellow);
	chart.getTitle().setPaint(Color.blue); 
	CategoryPlot p = chart.getCategoryPlot(); 
	p.setRangeGridlinePaint(Color.red); 
	ChartFrame frame1=new ChartFrame("3D Bar Chart",chart);
	frame1.setVisible(true);
	frame1.setSize(300,300);
	}
}
package com.my.org.erp.jfree;


import java.awt.Color;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;

import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.general.DatasetUtilities;
import org.jfree.ui.ApplicationFrame;
import org.jfree.ui.RefineryUtilities;

public class HorizontalBarChart extends ApplicationFrame {

    public HorizontalBarChart(String title) {
        super(title);

        CategoryDataset dataset = createDataset();
        JFreeChart chart = createChart(dataset);

        ChartPanel chartPanel = new ChartPanel(chart);
        chartPanel.setPreferredSize(new java.awt.Dimension(600, 350));
        setContentPane(chartPanel);
    }

    private CategoryDataset createDataset() { 
        final double[][] data = new double[][] {
            {4,2,-1,-3,-3,-1,2,4,2},
            {3,1,-2,-4,-2,1,3,3,1}
        };
        return DatasetUtilities.createCategoryDataset("Team ", "Match ", data);
    }

    private JFreeChart createChart(final CategoryDataset dataset) {

        final JFreeChart chart = ChartFactory.createBarChart(
                "Score Bord", "Match", "Score", dataset,
                PlotOrientation.HORIZONTAL, true, false, false);
        
        chart.setBackgroundPaint(new Color(249,231,236));

        CategoryPlot plot = chart.getCategoryPlot();
        plot.getRenderer().setSeriesPaint(0, new Color(128, 0, 0));
        plot.getRenderer().setSeriesPaint(1, new Color(0, 0, 255));
        
        return chart;
    }

    public static void main(final String[] args) {
        BarChartDemo2 chart = new BarChartDemo2("Score Bord");
        chart.pack();
        RefineryUtilities.centerFrameOnScreen(chart);
        chart.setVisible(true);
    }
}


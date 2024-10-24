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


public class StackedBarChart3D extends ApplicationFrame {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	StackedBarChart3D(String titel) {
        super(titel);

        final CategoryDataset dataset = createDataset();
        final JFreeChart chart = createChart(dataset);
        final ChartPanel chartPanel = new ChartPanel(chart);
        chartPanel.setPreferredSize(new java.awt.Dimension(700, 450));
        setContentPane(chartPanel);
    }

    private CategoryDataset createDataset() {
        double[][] data = new double[][]{
            {210, 300, 320, 265, 299, 100, 200, 300, 400, 200},
            {200, 304, 201, 201, 340, 200, 400, 200, 100, 300},
            {210, 300, 320, 265, 299, 100, 200, 300, 400, 200},
        };
        return DatasetUtilities.createCategoryDataset("Team ", "", data);
    }

    private JFreeChart createChart(final CategoryDataset dataset) {

        final JFreeChart chart = ChartFactory.createStackedBarChart3D(
                "Stacked Bar Chart ", "Match", "Score",
                dataset, PlotOrientation.VERTICAL, true, true, false);

        chart.setBackgroundPaint(new Color(249, 231, 236));

        CategoryPlot plot = chart.getCategoryPlot();
        plot.getRenderer().setSeriesPaint(0, new Color(30, 100, 175));
        plot.getRenderer().setSeriesPaint(1, new Color(90, 190, 110));
        plot.getRenderer().setSeriesPaint(2, new Color(225, 45, 45));

        return chart;
    }

    public static void main(final String[] args) {
        final StackedBarChart3D demo = new StackedBarChart3D("Stacked 3D Bar Chart");
        demo.pack();
        RefineryUtilities.centerFrameOnScreen(demo);
        demo.setVisible(true);
    }
}

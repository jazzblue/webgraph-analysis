#Webgraph Analysis

In this project we show one method to perform basic analysis over a relatively large web graph. The dataset is represented using the Resource Description Framework (RDF), where each record represents one edge in the graph. It was uploaded to Amazon's Web Services in S3 and the total size of the dataset is about 550GB.

This project was a homework assignment in a class of University of Washington created by Ph.D. Bill Howe. The data was also provided by the University of Washington.

The analysis was performed using Apache Pig script utilizing AWS EMR (Amazon Web Services Elastic Map Reduce) with 20 parallel nodes.

The visualization powered by D3.js Javascript library shows the distribution of node out-degrees. It is supposed to follow a power law (1/d^k for some constant k (where d is node's degree) which should look roughly like a straight-line on a graph with logarithmic scales on both the x and y axes).

In this repository you will find 2 files:

webgraph_analysis.pig: a Pig script computing the histogram.

webgraph_ana_vis.html: an html file showing visualization of the histogram. It utilizes D3.js Javascript library.



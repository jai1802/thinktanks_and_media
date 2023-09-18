# thinktanks_and_media

[Paper available here](https://github.com/jai1802/thinktanks_and_media/blob/master/Think_Tank_Citations.pdf)

The independence of the media and its insulation from political activity is a critical
characteristic of a healthy democracy. This paper assesses the independence of modern
U.S. news and reporting by investigating the effect of shifts in political power on media
bias in the United States. Using an event study model, we analyze whether news
publications began to cite conservative and libertarian think tanks more frequently after
the 2016 election and assess whether the Republican Party victory led to an increased
right-wing bias in the following years. Our findings show that there are no significant
shifts in media bias or partisanship over the 2014-2018 period. On the individual
publication level, we discover that the New York Times, Washington Post, and Wall
Street Journal show no changes in the frequency with which they cite right-leaning think
tanks. We find similar results for topic-specific citations, with no significant changes in
bias for reporting on politics, economics, health, or education.


## Script Overview
### 1. Citation Extraction
./scripts/Citation Extraction from Newspapers.ipynb: 

This notebook creates the dataset of citations to think tanks extracted from articles from the New York Times, Wall Street Journal, and Washington Post between 2014 and 2018. As TDM Studio does not allow articles to be exported directly, the path to the directory containing the articles has been replaced with a placeholder. Uses ./data/thinktank_data/tt_names.json, a dictionary of think tank names and aliases to extract mentions of think tanks in articles. Output of citations data is to ./data/citations/thinktank_citations_tdm.csv 

### 2. Cleaning Citation Data and Classifying Topics
./scripts/Data Cleaning, Keyword Search.ipynb: 

Reads the dataset of citations (thinktank_citations_tdm.csv), cleans the extracted citation sentences and think tank names. Then, uses a keyword search to tag each citation with a topic. Output saved to ./data/citations_data/thinktank_citations_tagged.csv

### 3. Transforming Citation and Think Tank Data into Panels
./scripts/Merging Features, Making Panels.ipynb:

Uses ./data/thinktank_data/thinktank_features.csv and thinktank_citations_tagged.csv to create a year-thinktank-publication level panel based on citation data.Panel includes think tank specific features such as operating budget by year, age, and political leaning. Each row in the panel corresponds to think tank _i_ at year _t_ and publication _p_, and indicates how many citations _t_ received from _p_ at year _t_. Also creates topic-specific panels, with output saved to ./data/panels/*

### 4. Running Main Regression
./regressions/Main Regression.do: Stata file that executes the main regression in the paper (Table 5). Output saved to ./output/Main Regression.tex
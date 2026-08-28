# Module 3: Portfolio Exercise

*Published 28 August 2026*

## Objective

This module tasks me with choosing a visualisation from HowMuch.net and exploring the original data source that was used to create it. The goal is to examine and verify if the data
used in HowMuch.net holds up to the original data source, which is the Bureau of Economic Analysis (BEA) US. 

## The visualisation
![Regional Price Parities by State, visualized by HowMuch.net](rpp_chart.jpg)
Source: [(Irena. (2021, April 21). Visualized: Regional price parity for each state. HowMuch)]

## Response to step 4: Investigating the original sources and examining the accuracy

## I.	Tracking original data source(s) 
The original data source comes from the U.S Bureau of Economic Analysis (BEA), where HowMuch.net stated they’ve got their figures as of December of 2020. Under Price & Inflation section, where it is named as “Regional Price Parities by State and Metro Area”, this can be accessed directly from the link provided by HowMuch.net. To get the exact downloadable 2020 dataset, I’ve clicked on “Current Release”, and “All items RPP” below the graph titled “Regional Price Parities for States, 2024 (United States = 100)”. Inside the link is an Interactive Data Tables page where I can filter Area = All Areas, Time Period = 2020, Statistics = RPPs: All Items. Additionally, per Dr. James Baglin’s suggestion, I’ve used the way-back machine (internet archive website) to trace the BEA link back to the exact time frame of 2020. I was able to access the 2020 version of the BEA website; I found that the exact data used for the visualisation by HowMuch.net is based on the 2019 RPP report by BEA as the data points matched perfectly. Unfortunately, I couldn’t access further links inside the 2020 website version of the way back machine. Since the 2019 visualisation titled “Regional Price Parities for States, 2019” matched perfectly with the visualisation from HowMuch.net, I’ve decided to use the 2019 XLXS file as the original data source instead of the 2020 version referenced on HowMuch.net’s website. 


## II.	References: APA style reference of original data source(s)

•	Bureau of Economic Analysis US. (2019). Real personal income by state and metropolitan area, 2019 | U.S. Bureau of Economic Analysis (BEA). Archive.Org. https://web.archive.org/web/20210115225140/https://www.bea.gov/news/2020/real-personal-income-state-and-metropolitan-area-2019

•	Bureau of Economic Analysis US. (2026). BEA interactive data application. Bea.Gov. https://apps.bea.gov/itable/?ReqID=70&step=1#eyJhcHBpZCI6NzAsInN0ZXBzIjpbMSwyOSwyNSwzMSwyNiwyNywzMCwzMF0sImRhdGEiOltbIlRhYmxlSWQiLCIxMDEiXSxbIk1ham9yX0FyZWEiLCIwIl0sWyJTdGF0ZSIsWyIwIl1dLFsiQXJlYSIsWyJYWCJdXSxbIlN0YXRpc3RpYyIsIjEiXSxbIlVuaXRfb2ZfbWVhc3VyZSIsIkxldmVscyJdLFsiWWVhciIsWyIyMDE5Il1dLFsiWWVhckJlZ2luIiwiLTEiXSxbIlllYXJfRW5kIiwiLTEiXV19

•	Bureau of Economics Analysis US. (2024). Real personal consumption expenditures by state and real personal income by state, 2024 | U.S. Bureau of Economic Analysis (BEA). Bea.Gov. https://www.bea.gov/news/2026/real-personal-consumption-expenditures-state-and-real-personal-income-state-2024

•	Irena. (2021, April 21). Visualized: Regional price parity for each state. HowMuch. https://howmuch.net/articles/regional-price-parities-by-state 


## III.	List the variables visually encoded in the original
The original dataset contains three usable fields per state: GeoFIPS (state code), GeoName (state name), and the 2019 RPP, pertaining to All Items index (a value where the U.S. average = 100), RPP measures the purchasing power of each state by combining the costs of goods compared with income. 

## IV.	Evaluating the alignment of the data (D) and the question (Q) posed by the original 
However, the exact numbers differ from the one posted on HowMuch, for example, in December of 2020, New York’s (NY) RPP is visualised as 116.3 by HowMuch whereas the 2019 dataset from BEA shows the RPP is actually 109.4, that’s a gap nearly 7 points--a very significant discrepancy between the two sources.

## V.	Verifying the source data with the visually encoded values/data tables reported on HowMuch.net.
Upon cross-checking the chart against the values from the BEA 2019 XLXS file, I’ve found that the discrepancy between NY example is systemic, not a one-off case. Of 19 states checked, 16 are overstated on HowMuch’s chart and only 3 understated, with an average gap of +2.6 points. Distortion is largest where its most visually promiment, the 5 states with an RPP value of 115 or more (HI, CA, NY NJ, D.C.) carry the largest gaps, between +4.8 to +7.5 points. Therefore, the chart doesn’t just misrepresent individual values, but it exaggerates the states it already flags as more expensive, undermining the visusalisation’s integrity to its stated source. However, as I stated earlier, the data points do match perfectly to the 2019 version of the BEA source, the XLSX file is just not downloaded from the archive website. This could be a case of government databases being updated with time, since the HowMuch.net chart doesn’t specify which release date or vintage version of BEA data it drew from, its plausible the figures reflect an earlier (or since-revised) version of the RPP data rather than a deliberate misrepresentation. Even if that’s the case, this doesn’t fully absolve the visualisation, without a stated source date, the general audience has no way to verify or reconcile the numbers themselves, thus creates a limitation of the chart’s transparency. 

## VI.	Examine the quality of the original data source(s). Discuss if you consider the source to be reputable. Are there any limitations to the data that the audience should be aware of?

BEA’s Regional Price Parities come from a federal statistical agency with a well-documented, peer-reviewed methodology and regular release schedule, making the original source highly reputable. On the other hand, HowMuch.net is a secondary publisher whose figures don’t trace cleanly back to BEA’s cited data, additionally the link to their methodology page is no longer available. There are no revised updates or footnotes informing the audience the numbers could be outdated. The general audience should be aware of limitations such as RPPs are modelled estimates, not precise observed prices. BEA revises figures across releases and no exact year is stated on the chart itself, the general audience has no way of verifying if the numbers are credible. State-level values don’t account for significant variance of intra-state cost-of-living; some states are densely populated around 1-2 major cities and the RPP might not be reflective for other parts of the state itself. 










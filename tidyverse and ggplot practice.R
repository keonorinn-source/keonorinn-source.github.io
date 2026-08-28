#install gapminder package and dplyr
#note: install.packages() downloads a package from CRAN onto your computer.
#note: You only ever need to run this ONCE per machine - not every session.
#note: Once installed, comment these two lines out so they don't re-download every run.
install.packages("gapminder")  
install.packages("dplyr")

# Load the gapminder package
#note: library() takes an installed package and makes it active in THIS session.
#note: Unlike install.packages(), you DO need to re-run library() every time you restart R.
#note: gapminder is a data package - it contains no functions, just a dataset.
library(gapminder)

# Load the dplyr package
#note: dplyr is the data-manipulation package of the tidyverse.
#note: It gives you the five "verbs": filter, arrange, mutate, summarize, group_by.
#note: It also brings in the pipe operator %>% that you use below.
library(dplyr)

# Look at the gapminder dataset
#note: Typing a dataset's name just prints it to the console.
#note: gapminder is a "tibble" (tidyverse's version of a data frame) with 1,704 rows.
#note: 142 countries x 12 years (1952 to 2007, every 5 years).
#note: Columns: country, continent, year, lifeExp, pop, gdpPercap.
gapminder

#note: %>% is the PIPE. Read it out loud as "and then".
#note: It takes whatever is on the left and feeds it into the first argument on the right.
#note: So gapminder %>% filter(...) is identical to filter(gapminder, ...).
#note: filter() keeps only the ROWS that meet your condition - it never touches columns.
#note: The double == is a COMPARISON ("is it equal to?"). A single = would be an assignment
#note: and would throw an error here. This is the single most common beginner mistake.
gapminder %>%
  filter(year == 2007)

#note: Same idea, but filtering on a text (character) column.
#note: Text values MUST be in quotes. year == 2007 needs no quotes because it's a number.
#note: The spelling has to match the dataset exactly - "USA" would return 0 rows.
gapminder %>%
  filter(country == "United States") 

#note: Multiple conditions separated by a comma act as AND.
#note: This keeps rows where country is China AND year is 2000... which returns nothing,
#note: because gapminder only has years in 5-year steps (1997, 2002, 2007 - no 2000).
#note: A 0-row result usually means your filter is wrong, not that the data is broken.
gapminder %>%
  filter(country == "China", year == 2000)

#note: arrange() sorts the ROWS. Default is ascending (smallest first).
#note: Here the poorest country-years float to the top.
gapminder %>%
  arrange(gdpPercap)

#note: desc() wraps a column to flip the sort to descending (largest first).
#note: Now the richest country-years are at the top - Kuwait in the 1950s dominates.
gapminder %>%
  arrange(desc(gdpPercap))

#note: This is where the pipe earns its keep - chaining verbs into a pipeline.
#note: Read it as: take gapminder, AND THEN keep only 2007, AND THEN sort richest first.
#note: ORDER MATTERS. Filtering first means you're only sorting 142 rows, not 1,704.
gapminder %>%
  filter(year == 2007) %>%
  arrange(desc(gdpPercap))

#note: mutate() adds or changes COLUMNS (filter does rows, mutate does columns).
#note: Because the new name (pop) matches an existing column, this OVERWRITES pop.
#note: Population is now expressed in millions instead of raw headcount.
gapminder %>%
  mutate(pop = pop/1000000) 

#note: Here the name on the left (gdp) is new, so mutate CREATES a new column
#note: instead of overwriting one. Same function, two behaviours - the name decides which.
#note: gdpPercap is GDP *per person*, so multiplying by pop gives total national GDP.
gapminder %>%
  mutate(gdp = gdpPercap * pop)

#note: All three verbs chained together - this is the core dplyr workflow.
#note: Create total GDP, AND THEN keep only 2007, AND THEN sort by biggest economy.
#note: Result: USA, China, Japan at the top - a very different ranking to gdpPercap alone.
#note: Note that mutate() comes first because filter/arrange can use the column it creates.
gapminder %>%
  mutate(gdp = gdpPercap * pop) %>%
  filter(year == 2007) %>%
  arrange(desc(gdp))

# Use mutate to change lifeExp to be in months
#note: Reusing the existing name overwrites it - lifeExp is now months, not years.
#note: Slightly risky in practice: the column is still CALLED lifeExp, so the unit change
#note: is invisible to anyone reading your code later.
gapminder %>%
  mutate(lifeExp = 12 * lifeExp)

# Use mutate to create a new column called lifeExpMonths
#note: The safer version of the line above - a new name keeps the original intact.
#note: You now have both lifeExp (years) and lifeExpMonths (months) side by side.
gapminder %>%
  mutate(lifeExpMonths = 12 * lifeExp)

### visualising with ggplot2 ####
#note: The four #### at each end make this a collapsible section header in RStudio.
#note: Click the little arrow in the gutter, or use the outline pane (top-right of the
#note: script window) to jump between sections. Handy once a script gets long.

#install package
#note: Same as before - run once, then comment out.
install.packages("ggplot2")

#load ggplot2
#note: ggplot2 is the tidyverse's plotting package, built on the "grammar of graphics".
#note: The idea: every chart = data + aesthetic mappings + geometric shapes + scales.
library(ggplot2)

#note: The <- is the ASSIGNMENT arrow - it SAVES the result into an object.
#note: This is the key difference from everything above: all those earlier pipelines
#note: just printed to the console and vanished. Nothing was stored.
#note: Here the filtered 142-row snapshot is saved as gapminder2007 so you can reuse it.
gapminder2007 <- gapminder %>%
  filter(year == 2007)

#note: Printing the saved object to confirm it worked - 142 rows, one per country.
gapminder2007

#note: Your first plot. Three parts to unpack:
#note:   1. gapminder2007 - the data
#note:   2. aes() - the AESTHETIC MAPPING, i.e. which column drives which visual property
#note:   3. geom_point() - the GEOM, the shape actually drawn (points = scatterplot)
#note: Critical: ggplot2 layers with + , NOT %>%. Mixing them up is a classic error.
#note: aes() alone draws an empty canvas - you always need at least one geom.
ggplot(gapminder2007, aes(x = gdpPercap, y = lifeExp)) + geom_point()

#note: scale_x_log10() puts the x-axis on a log10 scale: each step is 10x, not +10.
#note: Why bother? gdpPercap is heavily right-skewed - most countries bunch near zero
#note: while a few outliers stretch the axis. Log spreads them out and turns the
#note: curved relationship into a near-straight line. Standard move for income data.
ggplot(gapminder2007, aes(x = gdpPercap, y = lifeExp)) + geom_point() + scale_x_log10() 

#note: Same trick applied to the y-axis instead.
#note: Honestly this one does very little - lifeExp only ranges ~40 to ~82, so there's
#note: no skew to fix. Worth seeing so you know when log ISN'T the answer.
ggplot(gapminder2007, aes(x = gdpPercap, y = lifeExp)) + geom_point() + scale_y_log10() 

#note: Adding a third variable by mapping it to COLOUR.
#note: continent is categorical, so ggplot assigns a discrete palette and auto-builds
#note: a legend. You get this for free - no legend code required.
#note: Note color = continent sits INSIDE aes() because it's driven by data.
#note: If you wanted every point blue regardless of data, it'd go outside:
#note: geom_point(color = "blue"). Inside vs outside aes() is the distinction to hold onto.
ggplot(gapminder2007, aes(x = gdpPercap, y = lifeExp, color = continent)) + geom_point() + scale_x_log10()

#note: Now four variables on one chart: x, y, colour AND size.
#note: size = pop scales each dot by population - China and India become huge bubbles.
#note: ggplot maps size to AREA, not radius, which is the perceptually correct choice.
#note: This is the classic Hans Rosling gapminder bubble chart.
ggplot(gapminder2007, aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) + 
  geom_point() + 
  scale_x_log10() 

#note: facet_wrap() splits one crowded chart into a grid of small ones - "small multiples".
#note: The ~ (tilde) means "by", so ~continent = "one panel per continent".
#note: The tilde is required; facet_wrap(continent) will error.
#note: All panels share the same axes, so comparisons across them are honest.
#note: Trade-off: easier to read within a continent, harder to compare across them,
#note: since the points are no longer overlaid. The colour legend is now redundant too.
ggplot(gapminder2007, aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) + 
  geom_point() + 
  scale_x_log10() +
  facet_wrap(~continent)


gapminder %>%
  summarize(meanlifeExp = mean(lifeExp))

gapminder %>%
  filter(year == 2007) %>%
  summarize(meanlifeExp = mean(lifeExp), totalPop = sum(pop))

gapminder %>%
  summarize(median(lifeExp))

gapminder %>%
  filter(year == 1957) %>%
  summarize(medianlifeExp = median(lifeExp),maxGdpPerCap = max(gdpPercap))

gapminder %>%
  filter(year == 1957) %>%
  summarize(medianLifeExp = median(lifeExp),
            maxGdpPercap = max(gdpPercap))

gapminder %>%
  group_by(year) %>%
  summarize(meanLifeExp = mean(lifeExp),
            totalPop = sum(pop)) 

gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarize(meanLifeExp = mean(lifeExp),
            totalPop = sum(pop)) 

gapminder %>%
  group_by(year, continent) %>%
  summarize(meanLifeExp = mean(lifeExp),
            totalPop = sum(pop)) 

by_year <- gapminder %>%
  group_by(year) %>%
  summarize(meanLifeExp = mean(lifeExp),
            totalPop = sum(pop))

by_year

ggplot(by_year, aes(x = year, y = totalPop)) + geom_point()

ggplot(by_year, aes(x = year, y = totalPop)) + geom_line() + expand_limits(y = 0)

by_continent <- gapminder %>%
  group_by(continent) %>%
  summarize(medianGdpPerCap = median(gdpPercap), meanLifeExp = mean(lifeExp))

ggplot(by_continent, aes(x = medianGdpPerCap, y = meanLifeExp, color = continent)) + geom_point()

by_year_continent <- gapminder %>%
  group_by(year, continent) %>%
  summarize(meanLifeExp = mean(lifeExp),
            totalPop = sum(pop))

by_year_continent

ggplot(by_year_continent, aes(x = year, y = totalPop, color = continent)) + 
  geom_point() + expand_limits(y = 0) + scale_y_log10()

# Filter for observations in the Oceania continent in 1952

oceania_1952 <- gapminder %>%
  filter(continent == "Oceania", year == 1952) 

# Create a bar plot of gdpPercap by country

ggplot(oceania_1952, aes(x = country, y = gdpPercap)) + geom_col()

ggplot(gapminder, aes(x = pop, color = continent)) + 
  geom_histogram(bins = 50) + scale_x_log10()


# Set the color scale
palette <- brewer.pal(5, "RdYlBu")[-(2:4)]



# Set the color scale
palette <- brewer.pal(5, "RdYlBu")[-(2:4)]

# Set the color scale
palette <- brewer.pal(5, "RdYlBu")[-(2:4)]

# Add a geom_segment() layer
ggplot(gm2007, aes(x = lifeExp, y = country, color = lifeExp)) +
  geom_point(size = 4) +
  geom_segment(aes(xend = 30, yend = country), size = 2)

# Add a geom_text() layer
ggplot(gm2007, aes(x = lifeExp, y = country, color = lifeExp)) +
  geom_point(size = 4) +
  geom_segment(aes(xend = 30, yend = country), size = 2) +
  geom_text(aes(label = lifeExp), color = "white", size = 1.5)

# Set the color scale
palette <- brewer.pal(5, "RdYlBu")[-(2:4)]

# Modify the scales
ggplot(gm2007, aes(x = lifeExp, y = country, color = lifeExp)) +
  geom_point(size = 4) +
  geom_segment(aes(xend = 30, yend = country), size = 2) +
  geom_text(aes(label = round(lifeExp,1)), color = "white", size = 1.5) +
  scale_x_continuous("", expand = c(0,0), limits = c(30,90), position = "top") +
  scale_color_gradientn(colors = palette)



# Add a title and caption
ggplot(gm2007, aes(x = lifeExp, y = country, color = lifeExp)) +
  geom_point(size = 4) +
  geom_segment(aes(xend = 30, yend = country), size = 2) +
  geom_text(aes(label = round(lifeExp,1)), color = "white", size = 1.5) +
  scale_x_continuous("", expand = c(0,0), limits = c(30,90), position = "top") +
  scale_color_gradientn(colors = palette) +
  labs(title = "Highest and lowest life expectancies, 2007", caption = "Source: gapminder")

# Define the theme
plt_country_vs_lifeExp +
  theme_classic() +
  theme(axis.line.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text = element_text(color = "black"),
        axis.title = element_blank(),
        legend.position = "none")

# Add text
plt_country_vs_lifeExp +
  step_1_themes +
  geom_vline(xintercept = global_mean, color = "grey40", linetype = 3) +
  annotate(
    "text",
    x = x_start, y = y_start,
    label = "The\nglobal\naverage",
    vjust = 1, size = 3, color = "grey40"
  )

# Add a curve
plt_country_vs_lifeExp +  
  step_1_themes +
  geom_vline(xintercept = global_mean, color = "grey40", linetype = 3) +
  step_3_annotation +
  annotate(
    "curve",
    x = x_start, y = y_start,
    xend = x_end, yend = y_end,
    arrow = arrow(length = unit(0.2, "cm"), type = "closed"),
    color = "grey40"
  )

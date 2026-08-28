library(dplyr)
library(ggplot2)

# installing the packages I need for the analysis
install.packages("forcats")
install.packages("janitor")
install.packages("showtext")
install.packages("sysfonts")
install.packages("ggtext")
install.packages("jsonlite")

# loading the packages
library(forcats)
library(janitor)
library(showtext)
library(sysfonts)
library(ggtext)
library(jsonlite)

#renaming the dataset for simplicity
meat_data <- FAOSTAT_data_2026

#checking the original names of columns 
names(meat_data)

#cleaning out the original names for simplicity
# this just makes the column names easier to work with
meat_data <- meat_data %>% clean_names()
names(meat_data)

# importing the fonts I want to use later
# playfair is for the title and lato is mostly for the other text
font_add_google("Playfair Display", "playfair")
font_add_google("Lato", "lato")
showtext_auto()
showtext_opts(dpi = 96)
showtext_opts()

# checking the data before I start filtering anything
# basically making sure the dataset has what I expect
n_distinct(meat_data$area)     # needs 10 countries, valid
unique(meat_data$item)         # needs 6 meat options, valid
unique(meat_data$element)      # needs 1 quantitative variable, valid
table(meat_data$area, meat_data$year) # 2022 and 2023 both needs 6 meat options, valid


# getting the most recent year available for each meat type in each country
# then calculating how much of the total meat supply each type makes up
meat_share <- meat_data %>%
  group_by(area, item) %>% #grouping dataset by area and item
  slice_max(year, n = 1) %>% # latest available year per country-item
  ungroup() %>%
  select(area, item, value) %>%
  group_by(area) %>%
  mutate(share = value / sum(value, na.rm = TRUE) * 100) %>%
  ungroup() %>%
  #using mutate function to rename countries for simplicity and renaming protein to match the OWID's dataset 
  mutate(
    area = recode(area,
                  "United States of America" = "US",
                  "Republic of Korea"        = "South Korea"
    ),
    item = recode(item,
                  "Poultry Meat"       = "Poultry",
                  "Bovine Meat"        = "Beef & buffalo",
                  "Mutton & Goat Meat" = "Sheep & goat",
                  "Pigmeat"            = "Pork",
                  "Fish, Seafood"      = "Fish & seafood",
                  "Meat, Other"        = "Other"
    )
  )


# setting the order that the meat types will appear in the bars
# the order matters because this is a stacked bar chart
# Segment order: controls left-to-right stacking
meat_levels <- c("Poultry", "Beef & buffalo", "Sheep & goat",
                 "Pork", "Fish & seafood", "Other")


# getting the countries into the order I want
# sorting them based on their poultry share
# World is added separately so it stays at the top
# Derive country order from poultry share, World pinned first
country_order <- meat_share %>%
  filter(item == "Poultry", area != "World") %>%
  arrange(desc(share)) %>%
  pull(area)

country_order <- c("World", country_order)


# turning the meat and country names into factors
# rev() is needed here so they display in the right visual order
plot_data <- meat_share %>%
  mutate(
    item = factor(item, levels = rev(meat_levels)), #rev() puts Poultry first then the rest 
    area = factor(area, levels = rev(country_order))   # rev() puts World on top 
  )


# making the basic stacked bar chart first
# no colours/text formatting yet, just checking that the bars look right
p <- ggplot(plot_data, aes(x = share, y = area, fill = item)) +
  geom_col(width = 0.72, colour = "white", linewidth = 0.4)

p


# saving a basic test version so I can check how it looks
ggsave("test.png", p, width = 9, height = 7, dpi = 150, bg = "white")


# adding the percentage labels onto the bars
# only the bigger sections get labels so the chart doesn't get too crowded
p2 <- p + geom_text(
  aes(
    label = ifelse(
      share >= 8, #only shows percentages worth displaying, values below 8% are ignored
      paste0(round(share), "%"), #rounds the number to the nearest integer and converts to percentage
      "" #anything below 8% is ignored and displayed as an empty string, hence "" 
    )
  ),
  position = position_stack(vjust = 0.5), #positions the text according to the stacked sections, 0.5 puts displays it halfway in the middle
  colour = "white" #colours each text displayed as white 
) 

p2


# creating the colour palette for the final chart
# each meat type gets its own colour
palette_new <- c(
  "Poultry"        = "#986d3a",
  "Beef & buffalo" = "#ad336c",
  "Sheep & goat"   = "#7087B0",
  "Pork"           = "#C5523F",
  "Fish & seafood" = "#33547D",
  "Other"          = "#8A919B"
)


# putting the colours and other formatting onto the chart
# this is basically where the chart starts looking like the final version
p_final <- p2 + scale_fill_manual(values = palette_new) + 
  scale_x_continuous(
    expand = expansion(mult = c(0, 0))
  ) + 
  labs(
    title = "Meat preferences vary a lot across\ndifferent countries", #adds the title
    subtitle = "Breakdown of meat supply in a given country by type, 2022–2023", #adds the subtitle
    caption = "Data source: Food and Agriculture Organization of the United Nations (2025)" #adds the caption/source
  ) +
  theme_minimal() +
  theme(
    # removes the X-axis, grid-lines and title of Y axis
    panel.grid = element_blank(),
    axis.title.x = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    axis.title.y = element_blank(),
    
    # formatting the Country labels
    axis.text.y = element_text(
      family = "lato",
      size = 11,
      colour = "#5C5C5C",
    ),
    
    # formatting the Title of the graph
    plot.title = element_text(
      family = "playfair",
      size = 22,
      face = "bold",
      colour = "#333333",
      hjust = 0,
      lineheight = 0.95,
      margin = margin(b = -10)
    ),
    
    # formatting the subtitle
    plot.subtitle = element_text(
      family = "lato",
      size = 12,
      colour = "#666666",
      hjust = 0,
    ),
    
    # formatting the caption at the bottom
    plot.caption = element_text(
      family = "lato",
      size = 11,
      colour = "#777777",
      hjust = 0,
      margin = margin(t = 12)
    )
  )

# displaying the finished reproduction
p_final

# saving the finished reproduction
ggsave("meat_chart_original.png", p_final,
       width = 9, height = 7, dpi = 150, bg = "white")




# colour blind safe version of the meat chart
# basically same chart but changed colours + text colours
# data stuff before this stays the same


# colours
# using okabe ito colours since they work better for colour blindness
# changed the pink a bit darker and grey a bit lighter
# delta E is just a number for how different two colours look
# under 10 = basically identical, 20ish = ok, 30+ = clearly different

palette_cvd <- c(
  "Poultry"        = "#E69F00",  # orange
  "Beef & buffalo" = "#9B4B77",  # darker purple/pink
  "Sheep & goat"   = "#56B4E9",  # light blue
  "Pork"           = "#D55E00",  # red/orange
  "Fish & seafood" = "#0072B2",  # blue
  "Other"          = "#DDDDDD"   # light grey
)


# these ones are too light for white text
# white on orange is only 2.2:1 contrast, want 4.5:1 minimum
# so these three get dark text instead

light_fills <- c("Poultry", "Sheep & goat", "Other")


# base chart
# same as before basically

p_cvd <- ggplot(plot_data, aes(x = share, y = area, fill = item)) +
  geom_col(width = 0.72, colour = "white", linewidth = 0.4)


# add the % labels
# only showing labels if the section is 8% or bigger
# colour changes depending on which meat type it is
# light colours = dark text, darker colours = white text
# note the colour is INSIDE aes() now, not hard coded to white like before

p2_cvd <- p_cvd + geom_text(
  aes(
    label = ifelse(
      share >= 8,                    # only show bigger sections
      paste0(round(share), "%"),     # round number + %
      ""                             # otherwise leave blank
    ),
    colour = ifelse(item %in% light_fills, "grey15", "white")
  ),
  position = position_stack(vjust = 0.5)  # puts text in middle
)


# final chart

p_final_cvd <- p2_cvd +
  scale_fill_manual(values = palette_cvd) +
  scale_colour_identity() +                     # makes the text colours work
  scale_x_continuous(expand = expansion(mult = c(0, 0))) +
  
  # flip legend around so it matches the bar order
  guides(fill = guide_legend(reverse = TRUE)) +
  
  labs(
    title    = "Meat preferences vary a lot across\ndifferent countries",
    subtitle = "Breakdown of meat supply in a given country by type, 2022-2023",
    caption  = "Data source: Food and Agriculture Organization of the United Nations (2025)"
  ) +
  theme_minimal() +
  theme(
    # remove axis stuff and gridlines
    panel.grid   = element_blank(),
    axis.title.x = element_blank(),
    axis.text.x  = element_blank(),
    axis.ticks.x = element_blank(),
    axis.title.y = element_blank(),
    
    # country names
    axis.text.y = element_text(
      family = "lato",
      size   = 11,
      colour = "#5C5C5C"
    ),
    
    # title
    plot.title = element_text(
      family     = "playfair",
      size       = 22,
      face       = "bold",
      colour     = "#333333",
      hjust      = 0,
      lineheight = 0.95,
      margin     = margin(b = -10)
    ),
    
    # subtitle
    plot.subtitle = element_text(
      family = "lato",
      size   = 12,
      colour = "#666666",
      hjust  = 0
    ),
    
    # caption at bottom
    plot.caption = element_text(
      family = "lato",
      size   = 11,
      colour = "#777777",
      hjust  = 0,
      margin = margin(t = 12)
    )
  )


# displaying the finished colour blind safe chart
p_final_cvd


# saving it out so I have a file version
ggsave("meat_chart_cvd_safe.png", p_final_cvd,
       width = 9, height = 7, dpi = 150, bg = "white")


# optional check
# this shows the finished chart through 3 types of colour blindness at once
# good for checking it actually worked instead of just trusting the numbers

# install.packages("remotes")
# remotes::install_github("clauswilke/colorblindr")
# colorblindr::cvd_grid(p_final_cvd)

################################################################################
# Packages to read
# Author: GNN
# Date: 2025-07-21
################################################################################

# Core packages
library(tidyverse)
library(lubridate)
library(here)
library(janitor)
library(furrr)
library(tidymodels)
library(gnnlab)
# library(tidymodels)
# library(furrr)

# Read xlsx files
# library(readxl)

# For ecological data analysis
# library(vegan)
# library(ggvegan)

# For NEP data analysis
# library(marelac)
# library(suntools)
# library(seacarb)

# For Bayesian modeling.
# library(brms)
# library(tidybayes)
# library(emmeans)

# For GAM
# library(mgcv)
# library(gratia)

# For plotting and image handling
library(ggpubr)
library(ggtext)
library(ggnewscale)
library(patchwork)
library(magick)
library(showtext)

# For tables
# library(gt)
# library(gtsummary)

################################################################################
# Set up plotting theme for consistency
################################################################################
# Add a specific font from Google Fonts to be used in plots.
font_add_google(family = "notosans-en", "Noto Sans")
font_add_google(family = "notosans-jp", "Noto Sans JP")

# Set the default theme for all subsequent ggplot plots using the ggpubr theme and the Noto Sans font.
theme_pubr(base_family = "notosans-en", base_size = 10) |> theme_set()

# Further customize the default ggplot theme for a clean, professional look.
theme_replace(
  panel.background = element_rect(fill = "white", color = "black", linewidth = 1),
  axis.line.x = element_blank(),
  axis.line.y = element_blank(),
  axis.title.x = element_markdown(family = "notosans-jp", lineheight = 1.5, margin = unit(c(0.5, 0, 0, 0), "lines")),
  axis.title.y = element_markdown(family = "notosans-jp", angle = 90, linewidth = 1.5, margin = unit(c(0, 0.5, 0, 0), "lines")),
  legend.background = element_blank(),
  legend.title = element_markdown(family = "notosans-jp"),
  legend.text = element_markdown(family = "notosans-jp", size = 8)
)
# Automatically use the showtext library to render fonts in plots.
showtext_auto()
################################################################################

# Functions declarations #######################################################

save_plots <- function(filename, plot = last_plot(), width = 80, height = 80, units = "mm", density = 300) {
  # Slides: Use 200 x 112.5 mm2 for 16:9 (Font size should be > 5 mm or > 14 pt)
  # Manuscripts:
  #   Use 80 to 90 mm for width and 120 to 150 mm for height (Single column width)
  #   Use 170 to 180 mm and 230 to 240 mm foe height (Double column width)
  #   Font size should be 2.5 to 3.5 mm (8 to 10 pt)
  pdfname <- tools::file_path_sans_ext(basename(fname)) |> str_c(".pdf")
  pngname <- str_replace(pdfname, "pdf", "png")
  tifname <- str_replace(pdfname, "pdf", "tif")
  ggsave(pdfname, plot = plot, width = width, height = height, density = density)
  image_read_pdf(pdfname, density = density) |> image_write(pngname)
  image_read_pdf(pdfname, density = density) |> image_write(tifname)
}


################################################################################

##Intersect municipalities & AHO water catchments (intermediary level) in QGIS
#Using GRASS v.overlay function (ignore minor topology problems)
#Use R to obtain fractions per of water catchment per municipality
#wide table 308 rows (municipalities) x 562 columns (water catchments)
#subsequently converted to long format for easy input in GDX

#Read in data
SB_Gem <- read.csv("Overlay_Gem_AHO.csv")

aggregate(SB_Gem, by=list(SB_Gem$b_NISCODE), FUN=sum)

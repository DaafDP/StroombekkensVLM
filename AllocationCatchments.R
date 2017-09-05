##Intersect municipalities & AHO water catchments (intermediary level) in QGIS
#Using GRASS v.overlay function (ignoring minor topology problems)
#Use R to obtain fractions per of water catchment per municipality

#Clear environment
rm(list=ls())

#Read in data
SB_Gem <- read.csv("Overlay_Gem_AHO.csv")

#Sum together pieces of same catchment per municipality
CatchmentAreas <- aggregate(SB_Gem$Area, by = list(SB_Gem$a_AHO, SB_Gem$b_NISCODE), FUN=sum)
colnames(CatchmentAreas) <- c("Catchment", "NIS", "Area")

#Calculate total area 
TotalArea <- aggregate(CatchmentAreas$Area, by=list(CatchmentAreas$NIS), FUN=sum)
colnames(TotalArea) <- c("NIS", "MunArea")

#Merge TotalArea with SB_Gem
CatchmentAreas <- merge(CatchmentAreas, TotalArea, by="NIS")

#AreaShare
CatchmentAreas$AreaShare <- CatchmentAreas$Area /CatchmentAreas$MunArea

#Add Municipality names to dataframe
Names <- unique(SB_Gem[,c("b_NISCODE", "b_NAAM")])
colnames(Names) <- c ("NIS", "Name")
CatchmentAreas <- merge(Names, CatchmentAreas, by="NIS")

#Write csv
write.csv(CatchmentAreas, "CatchmentAreas_AHO.csv")



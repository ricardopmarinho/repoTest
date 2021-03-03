library(maptools)

kmzs<-list.files(path = "[ARQS] Busca Ativa anfíbios e squamata/trilhas/",pattern = "*.kmz",full.names = FALSE)

# LonLat<-sapply(
#   kmzs, function(x) getKMLcoordinates(kmlfile = unzip(
#     zipfile = paste0("[ARQS] Busca Ativa anfíbios e squamata/trilhas/",x),
#     exdir = "[ARQS] Busca Ativa anfíbios e squamata/trilhas/kml"),
#     ignoreAltitude = TRUE
#   )[[1]])

# name<-'2021-01-14-C1-ADA5-D_trace_H01_2.kmz'
# 
# newname<-stringr::str_split(string = name, pattern = "_")

# names(LonLat)<-gsub(pattern=".kmz", replacement="", x=names(LonLat))

coord<-getKMLcoordinates(kmlfile = unzip(zipfile = paste0("[ARQS] Busca Ativa anfíbios e squamata/trilhas/",kmzs[1]),
                                         exdir = "[ARQS] Busca Ativa anfíbios e squamata/trilhas/kml"))
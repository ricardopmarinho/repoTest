library(maptools)

kmzs<-list.files(path = "[ARQS] Busca Ativa anfíbios e squamata/trilhas/",pattern = "*.kmz",full.names = FALSE)
LonLat<-sapply(
  kmzs, function(x) getKMLcoordinates(kmlfile = unzip(
    zipfile = paste0("[ARQS] Busca Ativa anfíbios e squamata/trilhas/",x),
    exdir = "[ARQS] Busca Ativa anfíbios e squamata/trilhas/kml"),
    ignoreAltitude = TRUE
  )[[1]])

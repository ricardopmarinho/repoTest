library(openxlsx)
library(magrittr)

printResults<-function(found,not_found){
  cat(crayon::bgCyan("====== Results ======\n"))
  cat(crayon::green("--------------------------------------\n"))
  cat(crayon::green("Taxons found\n"))
  cat(crayon::green("--------------------------------------\n"))
  if(length(found)==0){
    cat(crayon::bgRed("NO TAXON FOUND"))
  }else{
    for(i in 1:length(found)){
      cat(crayon::green(found[i]),"\n")
    }
  }
  
  cat(crayon::red("\n--------------------------------------\n"))
  cat(crayon::red("Taxons not found\n"))
  cat(crayon::red("--------------------------------------\n"))
  if(length(not_found)==0){
    cat(crayon::bgGreen("EVERY TAXON FOUND"))
  }else{
    for(i in 1:length(not_found)){
      cat(crayon::red(not_found[i]),"\n")
    }
  }
}

kpitoolkit::set_script_wd()

data_name<-read.csv("../BT_FLORA_LENHOS/_temp_/processamento-FLORA_LENHOS/dimensions_csv/authors.csv")
data<-read.xlsx("../BT_FLORA_LENHOS/_temp_/processamento-FLORA_LENHOS/output_xlsx/FLORA_LENHOS-C1_Dados-de-campo(update_2021-04-07 18h17).xlsx")

taxa<-vector()
for(i in 1:nrow(data)){
  if(!is.na(data$Gênero[i]) & !is.na(data$Epíteto[i]) & data$Epíteto[i] != "sp.")
    taxa%<>%append(paste0(data$Gênero[i]," ",data$Epíteto[i]))
}

data<-read.csv("../formularios_ODK_BT/FLORA_LENHOS/media_odk/epitetos.csv")
for(i in 1:nrow(data)){
  if(data$genero[i] != "outro" & data$genero[i] != "sp")
    taxa%<>%append(paste0(data$genero[i]," ",data$name[i]))
}

occ<-occurrence(states = "MG",taxa = taxa,type = "any")
taxa<-occ$search.str
taxa%<>%unique()

taxa<-taxa[!taxa %in% NA]

dframe<-flora::get.taxa(taxa,establishment = TRUE, drop = FALSE)

found<-vector()
not_found<-vector()
for(i in 1:nrow(dframe)){
  percent<-round(i/nrow(dframe)*100,digits = 0)
  print(paste0(percent,"%"))
  if(dframe$notes[i]=="")
    found%<>%append(dframe$original.search[i])
  else
    not_found%<>%append(dframe$original.search[i])
}
found<-found[!found %in% NA]
not_found<-not_found[!not_found %in% NA]
found%<>%sort()
not_found%<>%sort()
printResults(found = found,not_found = not_found)


frame<-data.frame(nome=not_found)
write.csv(frame,file = "../BT_FLORA_LENHOS/_temp_/processamento-FLORA_LENHOS/nEncontrados.csv",row.names = FALSE,fileEncoding = "UTF-8")

library(flora)
library(rlist)
library(stringr)
library(magrittr)

kpitoolkit::set_script_wd()

data<-read.csv("generos.csv")
familias<-unique(data$familia)

taxas<-lower.taxa(familias)

spl<-stringr::str_split(taxas, "\\svar\\.\\s|\\ssubsp\\.\\s")
listVar<-vector()
listEp<-vector()
authors_name<-matrix(ncol = 3)
colnames(authors_name)<-c("Specie","Author1","Author2")

index<-1
for(i in spl){
  print(index)
  find_family<-i[1]
  family_spl<-str_split(find_family,"\\s")
  if(length(family_spl[[1]])>1){
    print(i)
    if(length(i)==1){
      specie_name<-get.taxa(taxas[index],drop = FALSE)
      aut1<-specie_name$authorship
      if(!is.na(aut1))
        Encoding(aut1)<-'UTF-8'
      authors_name%<>%rbind(c(taxas[index],aut1,NA))
    }else if(length(i)==2){
      specie<-str_split(i[1],"\\s")
      epithet<-specie[[1]][2]
      if(epithet==i[2]){
        specie_name<-get.taxa(i[1],drop = FALSE)
        aut1<-specie_name$authorship
        if(!is.na(aut1))
          Encoding(aut1)<-'UTF-8'
        authors_name%<>%rbind(c(taxas[index],aut1,NA))
      }else{
        specie_name<-get.taxa(i[1],drop = FALSE)
        infra_name<-get.taxa(taxas[index],drop = FALSE)
        aut1<-specie_name$authorship
        aut2<-infra_name$authorship
        if(!is.na(aut1))
          Encoding(aut1)<-'UTF-8'
        if(!is.na(aut2))
          Encoding(aut2)<-'UTF-8'
        authors_name%<>%rbind(c(taxas[index],aut1,aut2))
      }
    }
  }else{
    authors_name%<>%rbind(c(taxas[index],NA,NA))
  }
  index%<>%+1
}
authors_name<-authors_name[-1,]

varFrame<-data.frame(authors_name)

write.csv(varFrame,file = "authors.csv",row.names = FALSE,fileEncoding = "UTF-8")
# 
# spl<-stringr::str_split(taxas, "subsp\\.")
# listSubsp<-vector()
# listEp<-vector()
# l<-vector()
# for(i in spl){
#   if(length(i)>1){
#     print(i)
#     l<-append(l,i)
#     for(j in 2:length(i)){
#       # subspl<-str_split(i[1]," ")
#       # if(length(subspl)>1)
#       #   listEp<-append(listEp,subspl[[1]][2])
#       # else
#       #   listEp<-append(listEp,subspl[[1]][1])
#       
#       listEp<-append(listEp,i[1])
#       listSubsp<-append(listSubsp,i[j])
#     }
#   }
# }
# 
# varFrame<-data.frame(especie=listEp,
#                      subespecie=listSubsp)

# write.csv(varFrame,file = "subsp.csv",row.names = FALSE)
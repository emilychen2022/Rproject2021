data<-read.csv("~/Downloads/Notre Dame/Biocomputing/Rproject2021/allData.csv")
finaldata <- data.frame(data)
print(finaldata)

Xinfections <- 0

for(row in 1:length(finaldata)){
  if((finaldata$marker01[row]=="1") && (finaldata$country=="X") && (finaldata$dayofYear=="120")){
    Xinfections <- Xinfections  + 1
  }else if((finaldata$marker02[row]=="1") && (finaldata$country=="X") && (finaldata$dayofYear=="120")){
    Xinfections <- Xinfections  + 1
  }else if((finaldata$marker03[row]=="1") && (finaldata$country=="X") && (finaldata$dayofYear=="120")){
    Xinfections <- Xinfections  + 1
  }else if((finaldata$marker04[row]=="1") && (finaldata$country=="X") && (finaldata$dayofYear=="120")){
    Xinfections <- Xinfections  + 1
  }else if((finaldata$marker05[row]=="1") && (finaldata$country=="X") && (finaldata$dayofYear=="120")){
    Xinfections <- Xinfections  + 1
  }else if((finaldata$marker06[row]=="1") && (finaldata$country=="X") && (finaldata$dayofYear=="120")){
    Xinfections <- Xinfections  + 1
  }else if((finaldata$marker07[row]=="1") && (finaldata$country=="X") && (finaldata$dayofYear=="120")){
    Xinfections <- Xinfections + 1
  }else if((finaldata$marker08[row]=="1") && (finaldata$country=="X") && (finaldata$dayofYear=="120")){
    Xinfections <- Xinfections + 1
  }else if((finaldata$marker09[row]=="1") && (finaldata$country=="X") && (finaldata$dayofYear=="120")){
    Xinfections <- Xinfections + 1
  }else if((finaldata$marker10[row]=="1") && (finaldata$country=="X") && (finaldata$dayofYear=="120")){
    Xinfections <- Xinfections + 1
  } 
}

Yinfections <- 0

for(row in 1:length(finaldata)){
  if((finaldata$marker01[row]=="1") && (finaldata$country=="Y") && (finaldata$dayofYear=="120")){
    Yinfections <- Yinfections  + 1
  }else if((finaldata$marker02[row]=="1") && (finaldata$country=="Y") && (finaldata$dayofYear=="120")){
    Yinfections <- Yinfections  + 1
  }else if((finaldata$marker03[row]=="1") && (finaldata$country=="Y") && (finaldata$dayofYear=="120")){
    Yinfections  <- Yinfections  + 1
  }else if((finaldata$marker04[row]=="1") && (finaldata$country=="Y") && (finaldata$dayofYear=="120")){
    Yinfections  <- Yinfections  + 1
  }else if((finaldata$marker05[row]=="1") && (finaldata$country=="Y") && (finaldata$dayofYear=="120")){
    Yinfections  <- Yinfections  + 1
  }else if((finaldata$marker06[row]=="1") && (finaldata$country=="Y") && (finaldata$dayofYear=="120")){
    Yinfections  <- Yinfections  + 1
  }else if((finaldata$marker07[row]=="1") && (finaldata$country=="Y") && (finaldata$dayofYear=="120")){
    Yinfections <- Yinfections + 1
  }else if((finaldata$marker08[row]=="1") && (finaldata$country=="Y") && (finaldata$dayofYear=="120")){
    Yinfections <- Yinfections + 1
  }else if((finaldata$marker09[row]=="1") && (finaldata$country=="Y") && (finaldata$dayofYear=="120")){
    Yinfections <- Yinfections + 1
  }else if((finaldata$marker10[row]=="1") && (finaldata$country=="Y") && (finaldata$dayofYear=="120")){
    Yinfections <- Yinfections + 1
  } 
}
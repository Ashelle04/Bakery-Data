

class(BakeryData)
setDT(BakeryData)
library(data.table)

#Clean the data table as the First few columns in the data set is blank 
BakeryData[,1:4]
bd= BakeryData[, !1:4]
bd
bd[,mon:=month(Date)]

##ANALYSIS WITHOUT GGPLOT AND MELT FUNCTION


#1) Which dessert had the biggest difference in averages from the 2 groups?

###Take the average of each individual dessert from Monday - Thursday. 
###Then take the average of each individual dessert from Friday to Sunday. 


bd[daywk %in% c('Friday','Saturday','Sunday'), weekend:= 'yes']
bd
bd[!daywk %in% c('Friday','Saturday','Sunday'), weekend:= 'no']
bd

###individually for both weekend and weekday
w.end=bd[weekend=='yes',.(mean(Cakes),mean(Pies),mean(Cookies),mean(Smoothies),mean(Coffee))]
names(w.end)=c('cakes','pies','cookies','smoothie','coffee')
w.end
w.day=bd[weekend=='no',.(mean(Cakes),mean(Pies),mean(Cookies),mean(Smoothies),mean(Coffee))]
names(w.day)=c('cakes','pies','cookies','smoothie','coffee')
w.day
abs(w.end-w.day) #abs- use if you dont know which one is bigger or smaller 

### group by 2
w=bd[,.(ca=mean(Cakes),p=mean(Pies),coo= mean(Cookies),s=mean(Smoothies),cof=mean(Coffee)), by= weekend]
w[,.(diff(ca),diff(p),diff(coo),diff(s),diff(cof))]



#2)  Which dessert had the highest monthly average sales?  
###Take the average of the monthly sales and then identify the month and the desert

bd[,mon:=month(Date)]
b= bd[,.(ca=mean(Cakes),p=mean(Pies), co=mean(Cookies),s= mean(Smoothies),cof= mean(Coffee)), by = mon]
b
names(b)= c('mon','cake','pies','cookies','smoothies','coffee')
mb = max(b)
b[cake==mb]
b[pies==mb]
b[cookies==mb]

#3) Take the average of each individual dessert, by month,  from June - August.  Then take the average of each individual dessert, by month, for the remaining months. 
#Which dessert had the biggest difference in averages from the 2 groups?  Which dessert had the least difference?
bd[mon %in% 6:8 , summer:= 'yes']
bd
bd[!mon %in% 6:8, summer:= 'no']
bd
s=bd[,.(ca=mean(Cakes),p=mean(Pies),coo= mean(Cookies),s=mean(Smoothies),cof=mean(Coffee)), by= summer]
s[,.(abs(diff(ca)),abs(diff(p)),abs(diff(coo)),abs(diff(s)),abs(diff(cof)))]
s   


##ANALYSIS WITH GGPLOT AND MELT FUNCTION

library(data.table)
setDT(BakeryData)
BakeryData[,1:4]
bd= BakeryData[, !1:4]
bd
#1) Do this question again, using the melt function!
# Take the average of each individual dessert, by month,  from June - August.  
#Then take the average of each individual dessert, by month, for the remaining months. 
#Which dessert had the biggest difference in averages from the 2 groups?  Which dessert had the least difference?  
bd[,mon:=month(Date)]
bd[mon %in% 6:8 , summer:= 'yes']
bd[!mon %in% 6:8, summer:= 'no']
bd
bd.m=melt(bd,id.vars='summer', measure.vars = c('Cakes','Pies','Cookies','Smoothies','Coffee'))
b=bd.m[,mean(value),by=.(variable,summer)]
b[,abs(diff(V1)), by = variable]

#Which dessert had the highest monthly average sales?  

bd.m=melt(bd,id.vars='mon', measure.vars = c('Cakes','Pies','Cookies','Smoothies','Coffee'))
c=bd.m[,mean(value),by=.(variable,mon)]
c[which.max(V1)]


#2) Show the bar graph of the monthly averages of the desserts (x axis is the desserts)

#TOTAL AVG FOR EACH TABLE
d= bd.m[,mean(value), by = variable]
ggplot(d, aes(x = variable, y = V1, fill = variable)) +
  geom_bar(stat = 'identity') +
  scale_fill_brewer(palette = "Set3") +  # Using the Set3 color palette from RColorBrewer package
  theme_bw()

#graph averages of all deserts by month, place deserts on x-axis
#box-plot

e=bd.m[,mean(value), by =. (variable,mon)]
ggplot(e,aes(x= variable ,y=V1)) + geom_boxplot()  
# BAR_GRAPH 
ggplot(e,aes(x= variable ,y=V1)) + geom_bar(stat= 'identity')+ facet_wrap(~mon) + theme_bw()


#3)  Show the line graph of the average sales of the desserts across the 12 months.
e[,mon:=factor(mon,ordered=T)]
str(e)
ggplot(e,aes(x=mon,y=V1,group= variable, color=variable))+geom_line() 

#Promotion Analysis - Check the Data to see if the promotions were a sucess or fail

bd
bd.m =melt(bd,id.vars= c('mon','promotion'),measure.vars =c('Cakes','Pies','Cookies','Smoothies', 'Coffee'))

bd.m

d =bd.m[,mean(value),by = .(promotion,variable)]
d
ggplot(d, aes(x= variable ,y= V1)) + geom_bar(stat='identity')+theme_bw()
ggplot(d, aes(x= variable ,y= V1,fill =promotion)) + geom_bar(stat='identity')+theme_bw()

ggplot(d, aes(x= variable ,y= V1,fill =promotion)) + geom_bar(stat='identity',position = 'dodge')+theme_bw()

bd.m
e = bd.m[,mean(value),by = .(mon,promotion,variable)]
e
ggplot(e, aes(x= variable ,y= V1,fill =promotion)) + geom_bar(stat='identity',position = 'dodge')+theme_bw()+facet_wrap(~mon)

# for change in axis
ggplot(e, aes(x= variable ,y= V1,fill =promotion)) + geom_bar(stat='identity',position = 'dodge')+theme_bw()+facet_wrap(~mon)+scale_x_discrete(guide = guide_axis(angle = 45))
     
#Jesse Brown
#CPSC 4910
#Submer Project
#Data Visualization

#Functionality: This script address p04 and p06 and takes the CSV files from the extracted_metrics command under the utils folder
# on the server and plots the data within.

rm(list = ls ())


#required libraries
library(ggplot2)
library(quantmod)
library(gifski)
library(gganimate)
library(devtools)

###############################################################################SPEC TEMP####################################

#read in CSVS for freq - change to your path of CSV's
p06_swim_2.00GHz_freqs <- read.csv("E:/4910/extracted_data/newformat/p06_swim_2.00GHz_freqs.csv", header=FALSE)
p06_swim_2.33GHz_freqs <- read.csv("E:/4910/extracted_data/newformat/p06_swim_2.33GHz_freqs.csv", header=FALSE)
p06_swim_2.66GHz_freqs <- read.csv("E:/4910/extracted_data/newformat/p06_swim_2.66GHz_freqs.csv", header=FALSE)
p04_swim_1.60_freqs <- read.csv("E:/4910/extracted_data/newformat/p04_swim_1.60_freqs.csv", header=FALSE)

#create data frames for each test and each core


#p06 has 4 cores and p04 has 8 cores, changed data frames accordingly, can also do one large data frame
#these values are divided by 1000 to convert from khz to megahertz
p6Swim2ghz <- data.frame(
  c1 = as.numeric(p06_swim_2.00GHz_freqs$V3[1:nrow(p06_swim_2.00GHz_freqs)]) / 1000,
  c2 = as.numeric(p06_swim_2.00GHz_freqs$V5[1:nrow(p06_swim_2.00GHz_freqs)]) / 1000,
  c3 = as.numeric(p06_swim_2.00GHz_freqs$V7[1:nrow(p06_swim_2.00GHz_freqs)]) / 1000,
  c4 = as.numeric(p06_swim_2.00GHz_freqs$V9[1:nrow(p06_swim_2.00GHz_freqs)]) / 1000
)

p6Swim233ghz <- data.frame(
  c1 = as.numeric(p06_swim_2.33GHz_freqs$V3[1:nrow(p06_swim_2.00GHz_freqs)]) / 1000,
  c2 = as.numeric(p06_swim_2.33GHz_freqs$V5[1:nrow(p06_swim_2.00GHz_freqs)]) / 1000,
  c3 = as.numeric(p06_swim_2.33GHz_freqs$V7[1:nrow(p06_swim_2.00GHz_freqs)]) / 1000,
  c4 = as.numeric(p06_swim_2.33GHz_freqs$V9[1:nrow(p06_swim_2.00GHz_freqs)]) / 1000
)
p6Swim266ghz <- data.frame(
  c1 = as.numeric(p06_swim_2.66GHz_freqs$V3[1:nrow(p06_swim_2.00GHz_freqs)]) / 1000,
  c2 = as.numeric(p06_swim_2.66GHz_freqs$V5[1:nrow(p06_swim_2.00GHz_freqs)]) / 1000,
  c3 = as.numeric(p06_swim_2.66GHz_freqs$V7[1:nrow(p06_swim_2.00GHz_freqs)]) / 1000,
  c4 = as.numeric(p06_swim_2.66GHz_freqs$V9[1:nrow(p06_swim_2.00GHz_freqs)]) / 1000
)


p4Swim1.60ghz <- data.frame(
  c1 = as.numeric(p04_swim_1.60_freqs$V3[1:nrow(p06_swim_2.00GHz_freqs)]) / 1000,
  c2 = as.numeric(p04_swim_1.60_freqs$V5[1:nrow(p06_swim_2.00GHz_freqs)]) / 1000,
  c3 = as.numeric(p04_swim_1.60_freqs$V7[1:nrow(p06_swim_2.00GHz_freqs)]) / 1000,
  c4 = as.numeric(p04_swim_1.60_freqs$V9[1:nrow(p06_swim_2.00GHz_freqs)]) / 1000,
  c5 = as.numeric(p04_swim_1.60_freqs$V11[1:nrow(p06_swim_2.00GHz_freqs)]) / 1000,
  c6 = as.numeric(p04_swim_1.60_freqs$V13[1:nrow(p06_swim_2.00GHz_freqs)]) / 1000,
  c7 = as.numeric(p04_swim_1.60_freqs$V15[1:nrow(p06_swim_2.00GHz_freqs)]) / 1000,
  c8 = as.numeric(p04_swim_1.60_freqs$V17[1:nrow(p06_swim_2.00GHz_freqs)]) / 1000
)

#data frame for acessibility
specfreqdf <- data.frame(
  freq1 = p6Swim2ghz,
  freq2 = p6Swim233ghz,
  freq3 = p6Swim266ghz
  )

#this set of colors address the colors associated with 4 different tests with the 4 cores
#adjust colors based on core count and how many tests
lineColorsAll <- setNames(c('lightcoral','lightcoral','lightcoral','lightcoral','steelblue2','steelblue2','steelblue2','steelblue2',
                         'palegreen3','palegreen3','palegreen3','palegreen3','plum4','plum4','plum4','plum4'),
                       levels(specfreqdf))
#this set of colors was used for one test of all 4 cores as different colors
lineColorsOne <- setNames(c('lightcoral','steelblue2','palegreen3','plum4'), levels(specfreqdf))

#plot with geom_line
#have to add each line to graph for each core - the values are restricted by the least amount of data entries
#this can be changed to show how tests run shorter/longer than others
specfreq <- ggplot(specfreqdf) +
  geom_line(mapping=aes(y=freq1.c1,x=1:nrow(p06_swim_2.00GHz_freqs),color='2.00GHZ C0'),size = 1)+
  geom_line(mapping=aes(y=freq1.c2,x=1:nrow(p06_swim_2.00GHz_freqs),color='2.00GHZ C1'),size = 1)+
  geom_line(mapping=aes(y=freq1.c3,x=1:nrow(p06_swim_2.00GHz_freqs),color='2.00GHZ C2'),size = 1)+
  geom_line(mapping=aes(y=freq1.c4,x=1:nrow(p06_swim_2.00GHz_freqs),color='2.00GHZ C3'),size = 1)+
  
  #each core to be graphed separately
  #geom_line(mapping=aes(y=freq2.c1,x=1:nrow(p06_swim_2.00GHz_freqs),color='2.33GHZ C0'),size = 1)+
  #geom_line(mapping=aes(y=freq2.c2,x=1:nrow(p06_swim_2.00GHz_freqs),color='2.33GHZ C1'),size = 1)+
  #geom_line(mapping=aes(y=freq2.c3,x=1:nrow(p06_swim_2.00GHz_freqs),color='2.33GHZ C2'),size = 1)+
  #geom_line(mapping=aes(y=freq2.c4,x=1:nrow(p06_swim_2.00GHz_freqs),color='2.33GHZ C3'),size = 1)+
  #geom_line(mapping=aes(y=freq3.c1,x=1:nrow(p06_swim_2.00GHz_freqs),color='2.66GHZ C0'),size = 1)+
  #geom_line(mapping=aes(y=freq3.c2,x=1:nrow(p06_swim_2.00GHz_freqs),color='2.66GHZ C1'),size = 1)+
  #geom_line(mapping=aes(y=freq3.c3,x=1:nrow(p06_swim_2.00GHz_freqs),color='2.66GHZ C2'),size = 1)+
  #geom_line(mapping=aes(y=freq3.c4,x=1:nrow(p06_swim_2.00GHz_freqs),color='2.66GHZ C3'),size = 1)+
  #scale_color_manual(name = "Frequencies",values = lineColorsAll)
  scale_color_manual(name = "Frequencies",values = lineColorsOne)


#prints plot with labels
print(specfreq + labs(x="Time (seconds)", y="Frequency KHz") + ggtitle("Freq Over Time SPEC P06 2.00GHz"))

#add plot and info to new plot
anim <- specfreq + transition_reveal(1:nrow(p06_swim_2.00GHz_freqs)) + labs(x="Time (seconds)", y="Frequency MHz") + ggtitle("Freq Over Time SPEC P06 2.00GHz")
#animates graph
animate(anim, height= 1200, width = 1200)
#saves animation at specified path
anim_save("p06swim2ghzfreq.gif", animation = last_animation(), path = "/Users/Jesse/Documents/prelim/these3")

###############################################################################SPEC TEMP####################################

#most of the comments above relate to the temperature as well

#read in CSVS for temp
p06_swim_2.00GHz_temps <- read.csv("E:/4910/extracted_data/newformat/p06_swim_2.00GHz_temps.csv", header=FALSE)
p06_swim_2.33GHz_temps <- read.csv("E:/4910/extracted_data/newformat/p06_swim_2.33GHz_temps.csv", header=FALSE)
p06_swim_2.66GHz_temps <- read.csv("E:/4910/extracted_data/newformat/p06_swim_2.66GHz_temps.csv", header=FALSE)
p04_swim_1.60_temps <- read.csv("E:/4910/extracted_data/newformat/p04_swim_1.60_temps.csv", header=FALSE)


p6Swim200temp <- data.frame(
  t0 = p06_swim_2.00GHz_temps$V3[1:nrow(p06_swim_2.00GHz_temps)],
  t1 = p06_swim_2.00GHz_temps$V5[1:nrow(p06_swim_2.00GHz_temps)],
  t2 = p06_swim_2.00GHz_temps$V7[1:nrow(p06_swim_2.00GHz_temps)],
  t3 = p06_swim_2.00GHz_temps$V9[1:nrow(p06_swim_2.00GHz_temps)]
)
p6Swim233temp <- data.frame(
  t0 = p06_swim_2.33GHz_temps$V3[1:nrow(p06_swim_2.00GHz_temps)],
  t1 = p06_swim_2.33GHz_temps$V5[1:nrow(p06_swim_2.00GHz_temps)],
  t2 = p06_swim_2.33GHz_temps$V7[1:nrow(p06_swim_2.00GHz_temps)],
  t3 = p06_swim_2.33GHz_temps$V9[1:nrow(p06_swim_2.00GHz_temps)]
)
p6Swim266temp <- data.frame(
  t0 = p06_swim_2.66GHz_temps$V3[1:nrow(p06_swim_2.00GHz_temps)],
  t1 = p06_swim_2.66GHz_temps$V5[1:nrow(p06_swim_2.00GHz_temps)],
  t2 = p06_swim_2.66GHz_temps$V7[1:nrow(p06_swim_2.00GHz_temps)],
  t3 = p06_swim_2.66GHz_temps$V9[1:nrow(p06_swim_2.00GHz_temps)]
)

#use this
p4Swim160temp <- data.frame(
  t0 = p04_swim_1.60_temps$V3[1:nrow(p04_swim_1.60_temps)],
  t1 = p04_swim_1.60_temps$V5[1:nrow(p04_swim_1.60_temps)],
  t2 = p04_swim_1.60_temps$V7[1:nrow(p04_swim_1.60_temps)],
  t3 = p04_swim_1.60_temps$V9[1:nrow(p04_swim_1.60_temps)],
  t4 = p04_swim_1.60_temps$V11[1:nrow(p04_swim_1.60_temps)],
  t5 = p04_swim_1.60_temps$V13[1:nrow(p04_swim_1.60_temps)],
  t6 = p04_swim_1.60_temps$V15[1:nrow(p04_swim_1.60_temps)],
  t7 = p04_swim_1.60_temps$V17[1:nrow(p04_swim_1.60_temps)]
)
p4Swim160temp <- data.frame(
  t0 = p04_swim_1.60_temps$V3[1:nrow(p06_swim_2.00GHz_temps)],
  t1 = p04_swim_1.60_temps$V5[1:nrow(p06_swim_2.00GHz_temps)],
  t2 = p04_swim_1.60_temps$V7[1:nrow(p06_swim_2.00GHz_temps)],
  t3 = p04_swim_1.60_temps$V9[1:nrow(p06_swim_2.00GHz_temps)],
  t4 = p04_swim_1.60_temps$V11[1:nrow(p06_swim_2.00GHz_temps)],
  t5 = p04_swim_1.60_temps$V13[1:nrow(p06_swim_2.00GHz_temps)],
  t6 = p04_swim_1.60_temps$V15[1:nrow(p06_swim_2.00GHz_temps)],
  t7 = p04_swim_1.60_temps$V17[1:nrow(p06_swim_2.00GHz_temps)]
)
#data frame for acessibility
spectempdf <- data.frame(
  temp1 = p6Swim200temp,
  temp2 = p6Swim233temp,
  temp3 = p6Swim266temp,
  temp4 = p4Swim160temp
)

#specify colors for plotting and legend
#lineColors <- setNames(c('steelblue2','steelblue4','brown1','brown4','palegreen3','palegreen4'), levels(spectempdf))
lineColorsAll <- setNames(c('lightcoral','lightcoral','lightcoral','lightcoral','steelblue2','steelblue2','steelblue2','steelblue2',
                            'palegreen3','palegreen3','palegreen3','palegreen3','plum4','plum4','plum4','plum4','plum4','plum4','plum4','plum4'),
                          levels(specfreqdf))

lineColorsOne <- setNames(c('lightcoral','steelblue2','palegreen3','plum4','lightpink4','lightseagreen','tomato3','tan3'), levels(spectempdf))

lineColorsOnep4 <- setNames(c('lightcoral','steelblue2','palegreen3','plum4','lightpink4','lightseagreen','tomato3','tan3'), levels(p4Swim160temp))

#this is an example of what it looks like plotting p04 and p06 on the same graph
#plot with geom_line
spectemp <- ggplot(spectempdf)+
  geom_line(mapping=aes(y=temp1.t0,x=1:nrow(p06_swim_2.00GHz_temps),color='2.00GHZ C 0'),size = 1)+
  geom_line(mapping=aes(y=temp1.t1,x=1:nrow(p06_swim_2.00GHz_temps),color='2.00GHZ C 1'),size = 1)+
  geom_line(mapping=aes(y=temp1.t2,x=1:nrow(p06_swim_2.00GHz_temps),color='2.00GHZ C 2'),size = 1)+
  geom_line(mapping=aes(y=temp1.t3,x=1:nrow(p06_swim_2.00GHz_temps),color='2.00GHZ C 3'),size = 1)+
  geom_line(mapping=aes(y=temp2.t0,x=1:nrow(p06_swim_2.00GHz_temps),color='2.33GHZ C 0'),size = 1)+
  geom_line(mapping=aes(y=temp2.t1,x=1:nrow(p06_swim_2.00GHz_temps),color='2.33GHZ C 1'),size = 1)+
  geom_line(mapping=aes(y=temp2.t2,x=1:nrow(p06_swim_2.00GHz_temps),color='2.33GHZ C 2'),size = 1)+
  geom_line(mapping=aes(y=temp2.t3,x=1:nrow(p06_swim_2.00GHz_temps),color='2.33GHZ C 3'),size = 1)+
  geom_line(mapping=aes(y=temp3.t0,x=1:nrow(p06_swim_2.00GHz_temps),color='2.66GHZ C 0'),size = 1)+
  geom_line(mapping=aes(y=temp3.t1,x=1:nrow(p06_swim_2.00GHz_temps),color='2.66GHZ C 1'),size = 1)+
  geom_line(mapping=aes(y=temp3.t2,x=1:nrow(p06_swim_2.00GHz_temps),color='2.66GHZ C 2'),size = 1)+
  geom_line(mapping=aes(y=temp3.t3,x=1:nrow(p06_swim_2.00GHz_temps),color='2.66GHZ C 3'),size = 1)+
  geom_line(mapping=aes(y=temp4.t0,x=1:nrow(p06_swim_2.00GHz_temps),color='p04 1.60GHZ C 0'),size = 1)+
  geom_line(mapping=aes(y=temp4.t1,x=1:nrow(p06_swim_2.00GHz_temps),color='p04 1.60GHZ C 1'),size = 1)+
  geom_line(mapping=aes(y=temp4.t2,x=1:nrow(p06_swim_2.00GHz_temps),color='p04 1.60GHZ C 2'),size = 1)+
  geom_line(mapping=aes(y=temp4.t3,x=1:nrow(p06_swim_2.00GHz_temps),color='p04 1.60GHZ C 3'),size = 1)+
  geom_line(mapping=aes(y=temp4.t4,x=1:nrow(p06_swim_2.00GHz_temps),color='p04 1.60GHZ C 4'),size = 1)+
  geom_line(mapping=aes(y=temp4.t5,x=1:nrow(p06_swim_2.00GHz_temps),color='p04 1.60GHZ C 5'),size = 1)+
  geom_line(mapping=aes(y=temp4.t6,x=1:nrow(p06_swim_2.00GHz_temps),color='p04 1.60GHZ C 6'),size = 1)+
  geom_line(mapping=aes(y=temp4.t7,x=1:nrow(p06_swim_2.00GHz_temps),color='p04 1.60GHZ C 7'),size = 1)+
  #to run p04 by itself
  #geom_line(mapping=aes(y=t0,x=1:nrow(p04_swim_1.60_temps),color='1.60GHZ C 0'),size = 1)+
  #geom_line(mapping=aes(y=t1,x=1:nrow(p04_swim_1.60_temps),color='1.60GHZ C 1'),size = 1)+
  #geom_line(mapping=aes(y=t2,x=1:nrow(p04_swim_1.60_temps),color='1.60GHZ C 2'),size = 1)+
  #geom_line(mapping=aes(y=t3,x=1:nrow(p04_swim_1.60_temps),color='1.60GHZ C 3'),size = 1)+
  #geom_line(mapping=aes(y=t4,x=1:nrow(p04_swim_1.60_temps),color='1.60GHZ C 4'),size = 1)+
  #geom_line(mapping=aes(y=t5,x=1:nrow(p04_swim_1.60_temps),color='1.60GHZ C 5'),size = 1)+
  #geom_line(mapping=aes(y=t6,x=1:nrow(p04_swim_1.60_temps),color='1.60GHZ C 6'),size = 1)+
  #geom_line(mapping=aes(y=t7,x=1:nrow(p04_swim_1.60_temps),color='1.60GHZ C 7'),size = 1)+

  #scale_color_manual(name = "cores",values = lineColorsOne)
  scale_color_manual(name = "cores",values = lineColorsAll)

#prints plot with labels
print(spectemp + labs(x="Time (seconds)", y="Temperature C") + ggtitle("Temp Over Time SPEC p6 and p04"))
 
#for p04 bc of different scale
#anim <- spectemp + transition_reveal(1:nrow(p04_swim_1.60_temps)) + labs(x="Time (seconds)", y="Temperature C") + ggtitle("Temp Over Time SPEC p04 1.60GHz")
anim <- spectemp + transition_reveal(1:nrow(p06_swim_2.00GHz_temps)) + labs(x="Time (seconds)", y="Temperature C") + ggtitle("Temp Over Time SPEC p06 and p04")
animate(anim, height=1200, width =1200)
anim_save("allswimtemp.gif", animation = last_animation(), path = "/Users/Jesse/Documents/prelim/these3")

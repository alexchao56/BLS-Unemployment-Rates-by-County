county = read.table("output.txt", header=T, sep='\t')
code = read.table("codes.txt", sep='\n') #Get all the relevant BLS ID codes
county = county[,1:4] #Drop the Footnote Code

#subset out the M13 months which I'm assuming is the annual unemployment rate average
county = county[county[,3] != 'M13',]

#Grab only the LAUCN, LAUPS, and LAUPA series_ids
breaks = grep("^LAUCN[0-9]{7}[3]{1} *$|^LAUPS[0-9]{7}[3]{1} *$|^LAUPA[0-9]{7}[3]{1} *$", county$series_id)
county = county[breaks,]

#Get rid of the tabs for the series_ids so that they can be compared with the codes
b = as.character(county[,1])
b = strsplit(b, " +") #split on the spaces
b = unlist(b)
county[,1] = b

#Grab only the LAUCNs and create a separate data frame
toMatch1 = grep("^LAUCN[0-9]{7}[3]{1}", county[,1])
county1 = county[toMatch1,]

#Grab the relevant LAUPS and LAUPA series_ids
toMatch = as.character(code[,1])
toMatch2 = grep("^LAUPS[0-9]{7}[3]{1}|^LAUPA[0-9]{7}[3]{1}", toMatch)
toMatch2 = toMatch[toMatch2]

#match the list of LAUPS and LAUPA codes to the IDs in the county data frame
matches2 = unique(grep(paste(toMatch2, collapse="|"),county[,1]))
county2 = county[matches2,]

#Combine the two data frames to get the adjusted data frame containing only the relevant counties
county = merge(county1, county2, all.x=TRUE, all.y=TRUE)

#To do a sanity check, look at the number of unique counties in county. This should be the same as the length of the code data frame, the number of relevant counties
length(unique(county[,1]))

county$state_FIPS = substr(county$series_id, 6, 7) #grab the state FIPS code
county$county_FIPS = substr(county$series_id,8, 10) #grab the county code

county$period = (sapply(county$period, switch, 'M01'= "January" , 'M02'="February", 'M03'= "March", 'M04'= "April",
                       'M05'= "May", 'M06'="June", 'M07'="July", 'M08'="August", 'M09'="September",
                       'M10'="October", 'M11'="November" , 'M12'="December" ))

#Write the data out as txt first then open in excel
write.table(county, file="county.txt", sep=",", col.names=colnames(county), row.names=FALSE)


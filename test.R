state = read.table("output.txt", header=T, sep='\t')
code = read.table("codes.txt", sep='\n') #Get all the relevant BLS ID codes
state = state[,1:4] #Drop the Footnote Code

#subset out the M13 months which I'm assuming is the annual unemployment rate average
state = state[state[,3] != 'M13',]

state$period = (sapply(state$period, switch, 'M01'= "January" , 'M02'="February", 'M03'= "March", 'M04'= "April",
                       'M05'= "May", 'M06'="June", 'M07'="July", 'M08'="August", 'M09'="September",
                       'M10'="October", 'M11'="November" , 'M12'="December" ))

breaks = grep("^LAUCN[0-9]{7}[3]{1} *$|^LAUPS[0-9]{7}[3]{1} *$|^LAUPA[0-9]{7}[3]{1} *$", state$series_id)
state = state[breaks,]
b = as.character(state[,1])
b = strsplit(b, " +") #split on the spaces
b = unlist(b)
state[,1] = b

toMatch = as.character(code[,1])
#match the list of codes to the IDs in the state data frame
matches = unique(grep(paste(toMatch, collapse="|"),state[,1], value=TRUE)


breaks = grep("^LAUCN[0-9]{7}[3]{1} *$|^LAUPA06273003|^LAUPA06355003|^LAUPA06360003|^LAUPA06375003|^LAUPA06420003|^LAUPA06500003|^LAUPA06510003|^LAUPS06015003|^LAUPS06030003|^LAUPS06035003|^LAUPS06040003|^LAUPS06055003|^LAUPS06060003|^LAUPS06062003|^LAUPS06067003|^LAUPS06085003|^LAUPS06090003|^LAUPS06100003|^LAUPS06101003|^LAUPS06103003|^LAUPS06105003|^LAUPS06106003|^LAUPS06107003|^LAUPS06108003|^LAUPS06121003|^LAUPS06122003|^LAUPS06135003|^LAUPS06145003|^LAUPS06150003", state$series_id)
state = state[breaks,]

state$state_FIPS = substr(state$series_id, 6, 7) #grab the state FIPS code
state$county_FIPS = substr(state$series_id,8, 11) #grab the county code

#Write the data out as txt first then open in excel
write.table(state, "Cali.txt")


#Find out how many unique IDs there are
b = as.character(unique(state[,1]))
b = as.character(state[,1])
b = strsplit(b, " +")
b = unlist(b)
b = unique(b)

a = as.character(code[,1])


#Obtain the relevant state ID codes from the BLS site and then subset them again.

# LAUPS
# LAUPA

#LAUPA and LAUPS need to be searched 
#Assume that LAUCNs are fine

#Obtain the Relevant county codes. Paste them into a text file and make them tab-delimited

a = strsplit(a, "\t")
a = unlist(a)
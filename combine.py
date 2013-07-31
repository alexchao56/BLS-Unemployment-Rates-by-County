import os

dirLoc = "C:\Users\pvt-bobbito56-tmp\Desktop\BLS Unemployment Rate (Danny)\States"
files = os.listdir(dirLoc)
for f in files:
    if f.endswith(".txt"):
        data = open(f, "r")
        out = open("outPut.txt", 'a')
        for line in data:
            out.write(line)
        data.close()
        out.close()

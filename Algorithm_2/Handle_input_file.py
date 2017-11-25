import os
path = "./data"
files= os.listdir(path)
for name in files:
    file = open(path + '/'+ name)
    new_line = []
    source = ''
    sink = ''
    n = ''
    m = ''
    supply = ''
    for line in file:
        new = line.split('\n')[0].split(' ')
        if new[0] != 'c':
            if new[0] == 'p':
                n = new[2]
                m = new[3]
                new_line.append(n + " " + m + "\n")
            if new[0] == 'n':
                if new[1] == '1':
                    source = new[1]
                    supply = new[2]
                else:
                    sink = new[1]
                    new_line.append(source+" "+sink+" "+ supply+ "\n")

            if new[0] == 'a':
                content = new[1] + " " + new[2] + " " + new[4] + " " + new[5] + "\n"
                new_line.append(content)

    with open("./NewData/New_"+name, "a") as f:
        for item in new_line:
            f.write(item)
        f.close()
    print("Finish "+ name)
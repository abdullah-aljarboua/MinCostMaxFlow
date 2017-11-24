file = open("256_2048.ini")
new_line = []
source = '257'
sink = '258'
for line in file:
    new = line.split('\n')[0].split(' ')
    if new[1] == source:
        new[1] = '0'

    if new[2] == sink:
        new[2] = '257'
    content = new[1] + " " + new[2] + " " + new[4] + " " + new[5] + "\n"
    new_line.append(content)

with open("Formatted_Data.txt", "a") as f:
    for item in new_line:
        f.write(item)
    f.close()

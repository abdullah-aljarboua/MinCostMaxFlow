file = open("256_2048.ini")
new_line = []
for line in file:
    new = line.split('\n')[0].split(' ')
    content = new[1] + " " + new[2] + " "+ new[4]+ " "+ new[5]+ "\n"
    new_line.append(content)

with open("Formatted_Data.txt", "a") as f:
    for item in new_line:
        f.write(item)

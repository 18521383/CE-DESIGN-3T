import colorsys
file = open("rgb.txt","r")
filee = open("hsl.txt","w")
x = file.read()
x = x.splitlines()
def format(value):
    return "%.3f" % value
for i in range(len(x)):
    r = int(x[i][16:24],2)/255.0
    g = int(x[i][16:24],2)/255.0
    b = int(x[i][0:8],2)/255.0
    h, l, s = colorsys.rgb_to_hls(r, g, b)
    filee.write(str(round(h*360,2))+'\t')

    filee.write(str(round(s * 100, 2))+'\t')

    filee.write(str(round(l * 100, 2))+'\n')
filee.close()


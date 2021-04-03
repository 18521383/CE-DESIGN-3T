import colorsys
file = open("/home/ngocthai18521383/CE434.L21/week4/binary.txt","r")
filee = open("/home/ngocthai18521383/CE434.L21/week4/HSL_python.txt","w")
x = file.read()
x = x.splitlines()
for i in range(len(x)):
    b = int(x[i][16:24],2)/255.0
    g = int(x[i][8:16],2)/255.0
    r = int(x[i][0:8],2)/255.0
    h, l, s = colorsys.rgb_to_hls(r, g, b)
    filee.write(str(round(h,5))+'\t')

    filee.write(str(round(s * 255))+'\t')

    filee.write(str(round(l * 255))+'\n')
filee.close()

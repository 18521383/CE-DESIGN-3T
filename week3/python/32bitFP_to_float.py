import struct
global i
def FloatingPoint_to_Float(value_hex,x):
    f = int(value_hex, 16)
    if (i>0):
        return (round(100*(struct.unpack('f', struct.pack('I', f))[0]),x))
    elif (i==0):
        return (round((struct.unpack('f', struct.pack('I', f))[0])))
f=open ('rgb_hex.txt','r')
temp =''
for line in f:
    check =0
    i=0
    lines =line.split()
    for column in lines:
        if (column=='xxxxxxxx'):
            check=1
            break
        if (i==0):
            temp+= str(FloatingPoint_to_Float(column,0)) +'\t'
            i+=1
        elif(i>0):
            temp+= str(FloatingPoint_to_Float(column,2)) +'\t'
    if (check ==1):
        break
    elif(check==0):
        temp+='\n'
#print (temp)
with open('FP32bit_float.txt', 'w') as f:
    f.write(temp)




    


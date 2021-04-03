import difflib
import re
#open output python and handling
f=open ('HSL_python.txt','r')
result1 =''
for lines in f:
    data = re.sub(r'\s+', '', lines)
    result1 += data +"\n"
text1liness =result1.splitlines(1)
#open output hdl and handling
f1=open ('OutputHSL_HDL.txt','r')
result2 =''
for lines in f1:
    data = re.sub(r'\s+', '', lines)
    result2 +=data +'\n'
text2liness =result2.splitlines(1)

counter_line =0 #count line
line_err=0  #Line numbers different between text1 and text2
diffInstance = difflib.Differ()
diffList = list(diffInstance.compare(text1liness, text2liness))
for line in diffList:
    counter_line +=1
    if line[0] == '-':
        line_err+=1
print ('-'*50)
print ("Comparison results (exact):",)
result=((counter_line-line_err)/counter_line)*100
print(round(result,2),"%")

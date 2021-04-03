# Read the image file.
import imageio
data = imageio.imread('/home/ngocthai18521383/CE434.L21/week4/input.jpg')

# Make a string with the format you want.
text = ''
for row in data:
    for e in row:
        text += '{}{}{}\n'.format(f'{e[0]:08b}', f'{e[1]:08b}', f'{e[2]:08b}')

# Write the string to a file.
with open('/home/ngocthai18521383/CE434.L21/week4/binary.txt', 'w') as f:
    f.write(text)

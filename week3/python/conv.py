# Read the image file.
from scipy import misc
import imageio
data = imageio.imread('hoahong.jpg')

# Make a string with the format you want.
text = ''
for row in data:
    for e in row:
        text += '{}{}{}\n'.format(f'{e[0]:08b}', f'{e[1]:08b}', f'{e[2]:08b}')


# Write the string to a file.
with open('rgb.txt', 'w') as f:
    f.write(text)

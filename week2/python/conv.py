# Read the image file.
import imageio
data = imageio.imread('image.jpg')

# Make a string with the format you want.
text = ''
for row in data:
    for e in row:
        text += '{}{}{}\n'.format(f'{e[0]:08b}', f'{e[1]:08b}', f'{e[2]:08b}')


# Write the string to a file.
with open('binary.txt', 'w') as f:
    f.write(text)

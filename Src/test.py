import os
import time

# Define letter A pattern (5x5 pixels)
A = [
    [0,1,1,1,0],  # First row
    [1,0,0,0,1],  # Second row
    [1,1,1,1,1],  # Third row
    [1,0,0,0,1],  # Fourth row
    [1,0,0,0,1]   # Fifth row
]

# Create multiple row buffers (320 pixels wide)
SCREEN_WIDTH = 20
y1 = [0] * SCREEN_WIDTH
y2 = [0] * SCREEN_WIDTH
y3 = [0] * SCREEN_WIDTH
y4 = [0] * SCREEN_WIDTH
y5 = [0] * SCREEN_WIDTH

screen = [y1, y2, y3, y4, y5]

def cls():
    os.system('cls')

def draw_letter(x_pos=10):
    # Draw the letter A at specified x position
    for y in range(5):
        for x in range(5):
            screen[y][x + x_pos] = A[y][x]

def render_buffer():
    cls()
    for row in screen:
        line = ''
        for pixel in row:
            if pixel == 0:
                line += ' '
            else:
                line += '█'
        print(line)

def main():
    while True:
        # Clear buffer
        for row in screen:
            for i in range(SCREEN_WIDTH):
                row[i] = 0
        
        # Draw letter A
        draw_letter()
        
        # Render the buffer
        render_buffer()
        break

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\nExiting...")
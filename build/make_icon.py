#!/usr/bin/env python3
"""
Archi app icon generator — Instagram-style gradient rounded square
Colors: #5b8fff (blue) → #a259ff (purple) gradient, white "A" symbol
"""
from PIL import Image, ImageDraw, ImageFont
import math, os

def make_rounded_rect_mask(size, radius):
    mask = Image.new("L", (size, size), 0)
    d = ImageDraw.Draw(mask)
    d.rounded_rectangle([0, 0, size - 1, size - 1], radius=radius, fill=255)
    return mask

def hex_to_rgb(h):
    h = h.lstrip("#")
    return tuple(int(h[i:i+2], 16) for i in (0, 2, 4))

def make_gradient(size, color1, color2, color3):
    """Diagonal gradient from top-left (color1) to bottom-right (color3)"""
    img = Image.new("RGBA", (size, size))
    c1 = hex_to_rgb(color1)
    c2 = hex_to_rgb(color2)
    c3 = hex_to_rgb(color3)
    pixels = []
    for y in range(size):
        for x in range(size):
            # diagonal mix 0..1
            t = (x + y) / (2 * (size - 1))
            if t < 0.5:
                s = t * 2
                r = int(c1[0] + s * (c2[0] - c1[0]))
                g = int(c1[1] + s * (c2[1] - c1[1]))
                b = int(c1[2] + s * (c2[2] - c1[2]))
            else:
                s = (t - 0.5) * 2
                r = int(c2[0] + s * (c3[0] - c2[0]))
                g = int(c2[1] + s * (c3[1] - c2[1]))
                b = int(c2[2] + s * (c3[2] - c2[2]))
            pixels.append((r, g, b, 255))
    img.putdata(pixels)
    return img

def draw_letter_A(draw, size, color=(255, 255, 255)):
    """Draw a bold stylized 'A' centered in the icon"""
    stroke = max(2, size // 18)
    pad = size * 0.18
    top_x, top_y = size * 0.5, size * 0.14
    bl_x, bl_y = size * 0.13, size * 0.84
    br_x, br_y = size * 0.87, size * 0.84

    # Left leg
    draw.line([(top_x, top_y), (bl_x, bl_y)], fill=color, width=stroke)
    # Right leg
    draw.line([(top_x, top_y), (br_x, br_y)], fill=color, width=stroke)
    # Crossbar at ~55% height
    cx_y = top_y + (bl_y - top_y) * 0.52
    # left edge of left leg at cx_y
    t = 0.52
    lx = top_x + t * (bl_x - top_x)
    rx = top_x + t * (br_x - top_x)
    draw.line([(lx, cx_y), (rx, cx_y)], fill=color, width=stroke)

def draw_film_strip(draw, size, color=(255, 255, 255, 180)):
    """Subtle film strip decoration in lower portion"""
    # Small dots/holes at bottom
    dot_r = max(2, size // 38)
    y = size * 0.87
    for i in range(5):
        x = size * (0.15 + i * 0.175)
        draw.ellipse([x - dot_r, y - dot_r, x + dot_r, y + dot_r], fill=color)

def make_icon(size, path):
    corner_radius = int(size * 0.23)  # Instagram-style ~23%

    # Gradient: blue (#5b8fff) → purple (#a259ff) → pink/red (#ff6b8a)
    img = make_gradient(size, "#4a7aff", "#8a4fff", "#ff5f8a")

    # Apply rounded corners mask
    mask = make_rounded_rect_mask(size, corner_radius)
    img.putalpha(mask)

    draw = ImageDraw.Draw(img)

    # Draw bold "A"
    stroke_w = max(3, size // 12)
    pad = size * 0.17
    top_x, top_y = size * 0.5, size * 0.12
    bl_x, bl_y = size * 0.11, size * 0.86
    br_x, br_y = size * 0.89, size * 0.86

    white = (255, 255, 255, 255)

    # Anti-aliased thick lines by drawing multiple offsets
    for dx in range(-stroke_w // 2, stroke_w // 2 + 1):
        for dy in range(-stroke_w // 2, stroke_w // 2 + 1):
            if dx * dx + dy * dy <= (stroke_w // 2) ** 2:
                draw.line([(top_x + dx, top_y + dy), (bl_x + dx, bl_y + dy)], fill=white, width=2)
                draw.line([(top_x + dx, top_y + dy), (br_x + dx, br_y + dy)], fill=white, width=2)

    # Crossbar at 54% of height
    t = 0.54
    lx = top_x + t * (bl_x - top_x)
    rx = top_x + t * (br_x - top_x)
    cx_y = top_y + t * (bl_y - top_y)
    for dx in range(-stroke_w // 2, stroke_w // 2 + 1):
        for dy in range(-stroke_w // 2, stroke_w // 2 + 1):
            if dx * dx + dy * dy <= (stroke_w // 2) ** 2:
                draw.line([(lx + dx, cx_y + dy), (rx + dx, cx_y + dy)], fill=white, width=2)

    # Small star/sparkle in top-right area (decorative)
    sx, sy = size * 0.78, size * 0.22
    sr = max(2, size // 22)
    sparkle = (255, 255, 255, 200)
    draw.ellipse([sx - sr, sy - sr, sx + sr, sy + sr], fill=sparkle)
    tiny = max(1, size // 40)
    draw.ellipse([sx - sr * 2.5 - tiny, sy - tiny, sx - sr * 2.5 + tiny, sy + tiny], fill=sparkle)
    draw.ellipse([sx + sr * 1.5 - tiny, sy - tiny, sx + sr * 1.5 + tiny, sy + tiny], fill=sparkle)

    # Save with white bg for the PNG
    final = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    final.paste(img, (0, 0), img)
    final.save(path, "PNG")
    print(f"  {path} ({size}x{size})")

os.makedirs("res/mipmap-mdpi",    exist_ok=True)
os.makedirs("res/mipmap-hdpi",    exist_ok=True)
os.makedirs("res/mipmap-xhdpi",   exist_ok=True)
os.makedirs("res/mipmap-xxhdpi",  exist_ok=True)
os.makedirs("res/mipmap-xxxhdpi", exist_ok=True)

print("Generating Archi icons...")
make_icon(48,  "res/mipmap-mdpi/ic_launcher.png")
make_icon(72,  "res/mipmap-hdpi/ic_launcher.png")
make_icon(96,  "res/mipmap-xhdpi/ic_launcher.png")
make_icon(144, "res/mipmap-xxhdpi/ic_launcher.png")
make_icon(192, "res/mipmap-xxxhdpi/ic_launcher.png")
print("Done!")

from PIL import Image, ImageDraw, ImageFont
import math, os

def make_icon(size, out_path):
    img = Image.new("RGBA", (size, size), (0,0,0,0))
    draw = ImageDraw.Draw(img)
    r = int(size * 0.23)

    # Instagram-style gradient: mavi → mor → pembe
    for y in range(size):
        t = y / size
        red   = int(91  + (255-91)  * t)
        green = int(143 + (100-143) * t)
        blue  = int(255 + (150-255) * t)
        for x in range(size):
            dx, dy = x - size//2, y - size//2
            in_rect = (-size//2 + r <= dx <= size//2 - r) or (-size//2 + r <= dy <= size//2 - r)
            corner_ok = True
            for cx, cy in [(-size//2+r, -size//2+r),(size//2-r,-size//2+r),
                           (-size//2+r,size//2-r),(size//2-r,size//2-r)]:
                if (dx-cx)**2 + (dy-cy)**2 > r**2:
                    if dx < cx - (size//2-r) or dx > cx + (size//2-r):
                        continue
                    if dy < cy - (size//2-r) or dy > cy + (size//2-r):
                        continue
                    corner_ok = False
                    break
            # rounded rect check
            ax, ay = abs(dx), abs(dy)
            half = size//2
            in_shape = (ax <= half - r or ay <= half - r) and \
                       not ((ax > half - r) and (ay > half - r) and
                            (ax - (half-r))**2 + (ay - (half-r))**2 > r**2)
            if in_shape:
                img.putpixel((x, y), (red, green, blue, 255))

    # Beyaz "A" harfi (büyük, bold)
    draw2 = ImageDraw.Draw(img)
    font_size = int(size * 0.52)
    try:
        font = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf", font_size)
    except:
        font = ImageFont.load_default()

    text = "A"
    bbox = draw2.textbbox((0,0), text, font=font)
    tw = bbox[2] - bbox[0]
    th = bbox[3] - bbox[1]
    tx = (size - tw) // 2 - bbox[0]
    ty = (size - th) // 2 - bbox[1] - int(size * 0.03)
    draw2.text((tx, ty), text, font=font, fill=(255,255,255,255))

    # Küçük parlama noktası (sağ üst)
    sx = int(size * 0.72)
    sy = int(size * 0.18)
    sr = int(size * 0.06)
    draw2.ellipse([sx-sr, sy-sr, sx+sr, sy+sr], fill=(255,255,255,200))

    img.save(out_path, "PNG")
    print(f"  {out_path} ({size}x{size})")

sizes = {
    "mipmap-mdpi":    48,
    "mipmap-hdpi":    72,
    "mipmap-xhdpi":   96,
    "mipmap-xxhdpi":  144,
    "mipmap-xxxhdpi": 192,
}

base = "/home/user/Newapk/build2/res"
for folder, size in sizes.items():
    path = os.path.join(base, folder, "ic_launcher.png")
    make_icon(size, path)

print("Tüm ikonlar oluşturuldu.")

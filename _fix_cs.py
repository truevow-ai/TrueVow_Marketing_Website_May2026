import os, re

md = r"c:\Users\yasha\OneDrive\Documents\TrueVow\Cursor\2025_TrueVow_Website\marketing"
ld = r"c:\Users\yasha\OneDrive\Documents\TrueVow\Cursor\2025_TrueVow_Website\legal"
af = [os.path.join(md,f) for f in os.listdir(md) if f.endswith('.html') and f!='case-studies.html'] + [os.path.join(ld,f) for f in os.listdir(ld) if f.endswith('.html')]
t=0
for fp in af:
    try:
        c=open(fp,'r',encoding='utf-8').read(); o=c
        c=re.sub(r'[ \t]*<a href="case-studies\.html"[^>]*>Case Studies</a>\n?','',c)
        if c!=o:
            open(fp,'w',encoding='utf-8').write(c)
            n=o.count('case-studies.html')-c.count('case-studies.html'); t+=n
            print(f'{os.path.basename(fp)}:{n}')
    except Exception as e: print(f'ERR {os.path.basename(fp)}:{e}')
print(f'Total:{t}')

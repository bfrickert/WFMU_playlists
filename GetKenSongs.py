import requests
from BeautifulSoup import BeautifulSoup
import pandas as pd
import re
import time

def scrapeWFMUPlaylist(url):
    response = requests.get(url)

    soup = BeautifulSoup(response.text)
    tables = soup.findAll("table", {'border':'1'})
    rows = tables[0].findAll('tr') 
    values = []
    dt = soup.findAll(text=re.compile('Playlist for (.*)$'))
    mdt = re.match('Playlist for (.*)$', dt[0].strip(), re.M|re.I)
    str_dt = '%s %s, %s' % (re.match('([0-3][0-9]) (\w*) (20[0-1][0-9])',mdt.group(1)).group(2), re.match('([0-3][0-9]) (\w*) (20[0-1][0-9])',mdt.group(1)).group(1), re.match('([0-3][0-9]) (\w*) (20[0-1][0-9])',mdt.group(1)).group(3))
    fdt = "%s/%s/%s" % (time.strptime(str_dt, '%B %d, %Y')[1], time.strptime(str_dt, '%B %d, %Y')[2], time.strptime(str_dt, '%B %d, %Y')[0])

    for row in rows:
        cells = row.findAll('td')
        
        if len(cells) >= 4:
            try:
                song = cells[1].find("font").find(text=True).strip().encode('ascii', 'ignore')
                artist = cells[0].find("font").find(text=True).strip().encode('ascii', 'ignore')
            except:
                song = 'FAIL'
                artist = 'FAIL'
            values.append([artist, song, fdt])
            
    df = pd.DataFrame(values)
    return df

df = pd.DataFrame()
url_df = pd.read_csv('data/ken_playlists.tsv', sep='\t')


urls = [row[1] for index, row in url_df.iterrows()]
i = 0
for url in urls:
    i += 1
    print str(i) + url
    df = df.append(scrapeWFMUPlaylist(url))


df.columns = ['artist','song','date']
df.to_csv('data/ken_songs.tsv', sep='\t')

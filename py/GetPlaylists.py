import requests
from bs4 import BeautifulSoup
import pandas as pd
import sys

def scrapeKenPlaylists(i, initials):
    url = "http://www.wfmu.org/playlists/%s%s" % (initials,i)
    try: 
        response = requests.get(url)

        soup = BeautifulSoup(response.text)
        playlists = soup.findAll('a')        
        values = []
        for playlist in playlists:
            text = playlist.find(text=True)
            if text == 'See the playlist' and playlist['href'][-4:] != 'html':
                values.append("http://www.wfmu.org%s" % playlist['href'])
        df = pd.DataFrame(values)
        return df
    except: pass

df = pd.DataFrame()

for n in range(2001,2016):
    df = df.append(scrapeKenPlaylists(n, sys.argv[1]))

df = df.append(scrapeKenPlaylists('',sys.argv[1]))
df.drop_duplicates()
df.to_csv('data/{0}/playlists.tsv'.format(sys.argv[1]), sep='\t')

import requests
from bs4 import BeautifulSoup
import pandas as pd
import sys

def scrapeKenPlaylists(i, initials):
    url = "http://www.wfmu.org/playlists/%s%s" % (initials,i)
    response = requests.get(url)

    soup = BeautifulSoup(response.text)
    playlists = soup.findAll('a')        
    values = []
    for playlist in playlists:
        text = playlist.find(text=True)
        try:
            if '/playlists/shows/' in playlist['href']:
                values.append("http://www.wfmu.org%s" % playlist['href'])
        except: pass
    df = pd.DataFrame(values)
    return df

df = pd.DataFrame()

for n in range(2001,2017):
    df = df.append(scrapeKenPlaylists(n, sys.argv[1]))

df = df.append(scrapeKenPlaylists('',sys.argv[1]))
df.to_csv('data/{0}/playlists.tsv'.format(sys.argv[1]), sep='\t')

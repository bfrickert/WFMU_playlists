import requests
from bs4 import BeautifulSoup
import pandas as pd
import re
import time
import datetime
import sys

def scrapeWFMUPlaylist(url):
    response = requests.get(url)

    soup = BeautifulSoup(response.text)
    table = soup.find(id='comments-table')
    rows = table.findAll('tr')
    cell = table.findAll('td')

    values = []
    try:
        table = soup.find(id='comments-table')
        rows = table.findAll('tr')
        cell = table.findAll('td')
        l = list()
        for i in range(0, len(cell), 2):
            txt = cell[i].findAll(text=True)
            values.append(str.replace("".join(txt[6:len(txt)]).encode('ascii','ignore'),'\n',''))
    except:
        pass
 
    df = pd.DataFrame(values[1:(len(values)-4)])
    return df

df = pd.DataFrame()
url_df = pd.read_csv('data/{0}/playlists.tsv'.format(sys.argv[1]), sep='\t')


urls = [row[1] for index, row in url_df.iterrows()]
i = 0
for url in urls:
    try:
        i += 1
        print str(i) + url
        df = df.append(scrapeWFMUPlaylist(url))
    except:
        pass

df.to_csv('data/{0}/comments.txt'.format(sys.argv[1]), sep='\t')

import pandas as pd
import nltk as nltk
import warnings
warnings.filterwarnings('ignore')
import random
import numpy as np
import StringIO
import sys


df = pd.read_table("data/ken_songs.tsv", sep='\t')

songs = df['song'].dropna().values
txt = ' '.join(songs.tolist())


artists = df['artist'].dropna().values
atxt = ' '.join(artists.tolist())

tokens = nltk.word_tokenize(txt)

a_tokens = nltk.word_tokenize(atxt)


text = nltk.Text(tokens)
atext = nltk.Text(a_tokens)

foo = [0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3,4,4,4,4,4,4,5,5,5,5]
t_songs = []
for i in range (0,39):
    content_model = nltk.NgramModel(2,tokens)
    #print(content_model)
    starting_words = content_model.generate(100)[-2:]
    content = content_model.generate(random.choice(foo), starting_words)
    t_songs.append(content)


foo = [0,0,0,0,0,0,1,1,1,1,1,2,2,2,2,2,2,3,3,3,]
t_artists = []
for i in range (0,39):
    a_content_model = nltk.NgramModel(2, a_tokens)
    starting_words = a_content_model.generate(100)[-2:]
    a_content = a_content_model.generate(random.choice(foo), starting_words)
    t_artists.append(a_content)


amp = []
for x in t_songs:
    amp.append(' '.join(x))

tamp = []
for x in t_artists:
    tamp.append(' '.join(x))


s1 = pd.Series(amp, name='song')
s2 = pd.Series(tamp, name='artist')
final = pd.concat([s1, s2], axis=1)

final.to_csv("data/playlist.tsv", "\t")


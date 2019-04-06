import pandas as pd
df = pd.read_csv('data/ken_songs.tsv', sep='\t')

cnts = df.groupby(['artist'])['song'].nunique().reset_index().sort('song', ascending=0)

print cnts.head(100)
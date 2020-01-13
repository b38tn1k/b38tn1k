import os
import random
from pydub import AudioSegment

files = []

def load_files():
    for file in os.listdir():
        if file.endswith(".wav") or file.endswith(".WAV"):
            files.append(file)

def get_random_wav():
    return(random.choice(files))

def get_random_chop(length):

    track = get_random_wav()
    print(track)
    song = AudioSegment.from_wav(track)

    start = random.random() * (((song.duration_seconds) * 1000) - length)
    chop = song[start: start+length]
    if (random.random() > 0.5):
        chop = chop.reverse()
        print("flip")
    return chop

def make_chop(tempo, count):
    length = (60.0/tempo) * 1000
    song = get_random_chop(length)
    for i in range(count):
        song = song.append(get_random_chop(length))
    song.export(str(random.random()) + ".wav", format="wav")

for j in range(50):
    load_files()
    make_chop(240, 16)

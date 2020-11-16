import numpy as np
import matplotlib.pyplot as plt
import sys

loadfile = str(sys.argv[1])
savefile = str(sys.argv[2])

#load data
T = np.loadtxt(loadfile)

def forceAspect(ax,aspect=1):
    im = ax.get_images()
    extent =  im[0].get_extent()
    ax.set_aspect(abs((extent[1]-extent[0])/(extent[3]-extent[2]))/aspect)

#make plot
fig, ax = plt.subplots()
heatmap = ax.imshow(T, cmap="hot")

#fix 1:1 aspect ratio of plot
forceAspect(ax)

#add labels
ax.set_xlabel("Time (seconds)")
ax.set_ylabel("Soul depth (meters)")
ax.set_title("Temperature (Kelvin)")

#add colorbar
plt.colorbar(heatmap)

#save plot
plt.savefig(savefile, bbox_inches="tight")
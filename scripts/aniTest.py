from matplotlib import pyplot as plt  
import matplotlib.patches as patches
from matplotlib import animation  
import numpy as np  
import pandas as pd  

box_size = 50  
radius = 1

df = pd.DataFrame(np.array([np.arange(50),np.arange(50),np.arange(50)]).T,
                          columns = ['x','y','frame'])

#set up the figure
fig = plt.figure()
plt.axis([0,box_size,0,box_size])
ax = plt.gca()
time_text = ax.text(5, 5,'')

circle = plt.Circle((1.0,1.0), radius,color='b', alpha=0.5, facecolor='orange', lw=2)


#initialization of animation, plot empty array of patches
def init():
    time_text.set_text('initial')
    ax.add_patch( circle )
    return time_text, ax

def animate(i):
    #data for this frame only
    data = df[df.frame == i]
    time_text.set_text('frame' + str(i) )

    #plot circles at particle positions
    for idx,row in data.iterrows():
        circle.center = row.x,row.y

    return time_text, ax

anim = animation.FuncAnimation(fig, animate, init_func=init, repeat = False,
                               frames=int(df.frame.max()), interval=200, blit=True)

plt.show()

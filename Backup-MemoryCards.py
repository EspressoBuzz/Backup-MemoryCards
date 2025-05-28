#  https://pypi.org/project/py-robocopy/

import os
# Import robocopy module
# pip install py-robocopy
from robocopy import robocopy

source = "I:"                # Change this to your source drive letter
destination = "D:\\Temp\\"   # Change this to your destination folder
options = "/s"

# Read card to find CardID.txt and what to call the destination
f = open(source + "\\CardID.txt")
cardID = f.readlines()
destination += cardID[0]
f.close()

# Create destination folder
if not os.path.exists(destination):
    os.makedirs(destination)

# Copy the card to the destination
# print(f"CardID = {cardID}")
# print(f"Source = {source}")
# print(f"Destination = {destination}")
robocopy.copy(source, destination, options)


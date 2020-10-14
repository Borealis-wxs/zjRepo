# Name: SetNull_Ex_02.py
# Description: Returns NoData if a conditional evaluation is 
#              true and returns the value specified by another
#              raster if it is false, on a cell-by-cell basis.
# Requirements: Spatial Analyst Extension

# Import system modules
import arcpy
import os
from arcpy import env
from arcpy.sa import *

# Set environment settings
env.workspace = "D:\\workststion\\MRT\\mod16a2_vap\\TIFF"

filepath = env.workspace
filelist = os.listdir(filepath)
file_raw_list = filter(lambda filename:filename[-4:] == '.tif', filelist)     

resultpath= "D:\\workststion\\MRT\\mod16a2_vap\\TIFF\\SetNull\\"
# Set local variables
for i in range(len(file_raw_list)): 
    inRaster = file_raw_list[i]
    inFalseRaster = inRaster
    whereClause = "VALUE > 10000"
    # Check out the ArcGIS Spatial Analyst extension license
    arcpy.CheckOutExtension("Spatial")
 
    # Execute SetNull
    outSetNull = SetNull(inRaster, inFalseRaster, whereClause)

    out = resultpath + inRaster[0:19] + '.tif'
    # Save the output 
    outSetNull.save(out)
    print out

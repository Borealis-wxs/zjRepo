# Name: Con_Ex_02.py
# Description: Performs a conditional if/else evaluation 
#              on each cell of an input raster.
# Requirements: Spatial Analyst Extension

# Import system modules
import arcpy
import os
from arcpy import env
from arcpy.sa import *

# Set environment settings
env.workspace = "D:\\workststion\\matlab\\data_20200704\\th\\gwrmp_day\\tif1"

filepath = env.workspace
filelist = os.listdir(filepath)
file_raw_list = filter(lambda filename:filename[-4:] == '.tif', filelist)     

resultpath= "D:\\workststion\\matlab\\data_20200704\\th\\gwrmp_day_con01\\tif\\"
# Set local variables
for i in range(len(file_raw_list)): 
    inRaster = file_raw_list[i]
    inTrueRaster= inRaster
    inFalseConstant = 0
    whereClause = "VALUE >= 0"


    # Check out the ArcGIS Spatial Analyst extension license
    arcpy.CheckOutExtension("Spatial")

    # Execute Con
    outCon = Con(inRaster, inTrueRaster, inFalseConstant, whereClause)

    # Execute Con
    # outCon = Con(inRaster >= 0, inTrueRaster, inFalseConstant)
    out = resultpath + inRaster[0:16] + '.tif'
    # Save the output 
    outCon.save(out)
    print out

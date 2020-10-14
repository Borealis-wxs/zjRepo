
# Name: ExtractByMask_Ex_02.py
# Description: Extracts the cells of a raster that correspond with the areas
#    defined by a mask.
# Requirements: Spatial Analyst Extension

# Import system modules
import arcpy
import os
from arcpy import env
from arcpy.sa import *

# Set environment settings
env.workspace = "D:\\workststion\\python\\20201010_idw_55station\\output"
arcpy.env.outputCoordinateSystem = "D:\\workststion\\matlab\\data\\mswep\\mswep0.1\\tif\\mswep19790501.tif"
arcpy.env.extent = "D:\\workststion\\matlab\\data\\mswep\\mswep0.1\\tif\\mswep19790501.tif"
filepath = env.workspace
filelist = os.listdir(filepath)
file_raw_list = filter(lambda filename:filename[-4:] == '.tif', filelist)     #只选取文件夹中的.tif文件
#mask= "D:\\workststion\\arcgis\\基础地理信息\\基础地理信息\\太湖流域\\GIS图\\gcsw1984\\太湖水利分区\\regions.shp"
mask= "D:\\workststion\\matlab\\data\\mswep\\mswep0.1\\tif\\mswep19790501.tif"
#mask= "D:\\workststion\\arcgis\\基础地理信息\\基础地理信息\\太湖流域\\太湖流域边界.shp"
resultpath=  "D:\\workststion\\python\\20201010_idw_55station\\output\\taihu\\"
# Set local variables
for i in range(len(file_raw_list)): 
    inRaster = file_raw_list[i]
    inMaskData = mask
    # Check out the ArcGIS Spatial Analyst extension license
    arcpy.CheckOutExtension("Spatial")

    # Execute ExtractByMask
    outExtractByMask = ExtractByMask(inRaster, inMaskData)
   # out = resultpath + inRaster[0:8] + '.tif'
    out = resultpath + inRaster
    # Save the output 
    outExtractByMask.save(out)
    print out

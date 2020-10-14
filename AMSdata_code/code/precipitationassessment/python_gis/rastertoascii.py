# Name: RasterToASCII_Ex_02.py
# Description: Converts a raster dataset to an ASCII file representing 
#    raster data. 
# Requirements: None

# Import system modules
import arcpy
import os
from arcpy import env

# Set environment settings
env.workspace = "D:\\workststion\\python\\20201010_idw_55station\\output\\taihu"
filepath = env.workspace
filelist = os.listdir(filepath)
file_raw_list = filter(lambda filename:filename[-4:] == '.tif', filelist)     #只选取文件夹中的.tif文件
resultpath =  "D:\\workststion\\python\\20201010_idw_55station\\output\\taihu\\txt\\"
# Set local variables
for i in range(len(file_raw_list)): 
    inRaster = file_raw_list[i]
    #outASCII = resultpath + inRaster[0:8]+ ".txt"
    outASCII = resultpath + inRaster+ ".txt"
    # Execute RasterToASCII
    arcpy.RasterToASCII_conversion(inRaster, outASCII)
    print outASCII


# Resample TIFF image to a higher resolution

import arcpy
import os
from arcpy import env
from arcpy.sa import *

# Set environment settings
arcpy.env.workspace = "D:\\workststion\\MRT\\mod16a2_vap\\TIFF\\SetNull"
filepath = env.workspace
filelist = os.listdir(filepath)
file_raw_list = filter(lambda filename:filename[-4:] == '.tif', filelist)     #只选取文件夹中的.tif文件
resultpath = "D:\\workststion\\MRT\\mod16a2_vap\\TIFF\\SetNull\\30m\\"
#arcpy.env.outputCoordinateSystem = "D:\\workststion\\MRT\\mod16a2_vap\\TIFF\\MOD16A2.A2000049.ET_500m.tif"
#arcpy.env.extent = "D:\\workststion\\matlab\\extent_raster\\GWR19790503.tif"
# Set local variables
for i in range(len(file_raw_list)): 
    inraster = file_raw_list[i]
#  outRaster = resultpath + inraster + ".tif"
    outRaster = resultpath + inraster
    # Execute ASCIIToRaster
    arcpy.Resample_management(inraster, outRaster, "30", "NEAREST")
     #arcpy.Resample_management(inraster, outRaster, "0.1", "NEAREST")
    print outRaster

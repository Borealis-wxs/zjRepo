
# Name: ZonalStatisticsAsTable_Ex_02.py
# Description: Summarizes values of a raster within the zones of 
#              another dataset and reports the results to a table.
# Requirements: Spatial Analyst Extension

# Import system modules
import arcpy
import os
from arcpy import env
from arcpy.sa import *

# Set environment settings
env.workspace = "D:\\workststion\\matlab\\delaytime_gwrmp20201011\\result_output\\expand_meiyu_max\\meiyu\\tif"
filepath = env.workspace
filelist = os.listdir(filepath)
file_raw_list = filter(lambda filename:filename[-4:] == '.tif', filelist)     #只选取文件夹中的.shp文件
#resultpath = "D:\\workststion\\matlab\\data\\regions\\dbftotxt\\sq_py_hq\\max_daypre20200628\\basedata\\dbf\\sq_hq_py\\idw\\sum\\sq_hq_py\\idw"
resultpath = "D:\\workststion\\matlab\\data\\regions\\dbftotxt\\regions\\dbf\\expand_gwrmp_max\\max_regions1\\meiyu_"
#arcpy.env.outputCoordinateSystem = "D:\\workststion\\matlab\\data\\result0512\\mswep\\tif\\mswep19790501.shp"
# Set local variables
for i in range(len(file_raw_list)): 
    #inZoneData = "region_sq_py_hq_6.shp"
    inZoneData = "regions1.shp"
    zoneField = "HNCD"
    inValueRaster = file_raw_list[i]
    outTable = resultpath + inValueRaster[0:4] + ".dbf"

# Execute ZonalStatisticsAsTable
    outZSaT = ZonalStatisticsAsTable(inZoneData, zoneField, inValueRaster, outTable, "DATA", "MEAN")
    print outTable

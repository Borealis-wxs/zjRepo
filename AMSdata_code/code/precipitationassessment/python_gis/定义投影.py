
import arcpy
from arcpy import env
import os
from arcpy.sa import *
# set workspace environment
arcpy.env.workspace = "D:\\workststion\\python\\20201010_idw_55station\\output"
filepath = env.workspace
filelist = os.listdir(filepath)
file_raw_list = filter(lambda filename:filename[-4:] == '.tif', filelist)     #只选取文件夹中的.tif文件
    # set local variables
for i in range(len(file_raw_list)): 
    in_dataset = file_raw_list[i]
    # get the coordinate system by describing a feature class
    dsc = arcpy.Describe("D:\\workststion\\matlab\\extent_raster\\th_gwrmp19790501.tif")
    coord_sys = dsc.spatialReference
    
    # run the tool
    arcpy.DefineProjection_management(in_dataset, coord_sys)
    
    # print messages when the tool runs successfully
    print(arcpy.GetMessages(0))
    

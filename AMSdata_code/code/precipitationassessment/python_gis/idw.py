# Name: IDW_3d_Ex_02.py
# Description: Interpolate a series of point features onto a
#    rectangular raster using Inverse Distance Weighting (IDW).
# Requirements: 3D Analyst Extension

# Import system modules
import arcpy
import os
from arcpy import env

# Set environment settings
env.workspace = "E:/all_station_pre/point/day"
resultpath =  "e:/idw/idw_"       #输出文件路径
filepath = env.workspace
filelist = os.listdir(filepath)
file_raw_list = filter(lambda filename:filename[-4:] == '.shp', filelist)     #只选取文件夹中的.shp文件 

arcpy.env.extent = "D:/zj/基础地理信息/太湖流域/太湖流域边界.shp"
arcpy.env.outputCoordinateSystem = "E:/all_station_pre/TP/regions/PCSsample/11.shp"
# Set local variables
for i in range(len(file_raw_list)): 
    infeatures = file_raw_list[i]
    zField = "pre"
    outRaster = resultpath + infeatures[0:8]  
    cellSize = 10239.16639
    power = 2
    searchRadius = ""
    #searchRadius = 150000

    
    # Check out the ArcGIS 3D Analyst extension license
    arcpy.CheckOutExtension("3D")

    # Execute IDW
    arcpy.Idw_3d(infeatures, zField, outRaster, cellSize, 
             power, searchRadius)

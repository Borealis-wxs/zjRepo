
#==================================
#Mosaic To New Raster
import arcpy
import os
from arcpy import env
# Set environment settings
env.workspace = "D:/workststion/python/20200114_benchmark"
resultpath =  "D:/workststion/python/20200114_benchmark/"       #输出文件路径
filepath1 = "D:/workststion/python/20190508_idw/redo/output_idw_1_12/recpy_0.1/"
filepath2 = "D:/workststion/matlab/20190430-gwr/gwr1979-2016_0.1/tif/GWRXYH1979-2016_0.1/tif/reczx_0.1/"
filelist1 = os.listdir(filepath1)
filelist2 = os.listdir(filepath2)
file_raw_list1 = filter(lambda filename:filename[-4:] == '.tif', filelist1)     #只选取文件夹中的.txt文件 
file_raw_list2 = filter(lambda filename:filename[-4:] == '.tif', filelist2)
sr = arcpy.ListSpatialReferences(spatial_reference_type="GCS") 
arcpy.CheckOutExtension("Spatial") 
# Set local variables
for i in range(len(file_raw_list1)):
    for j in range(len(file_raw_list2)):
        if i!=j:
            continue
        infeatures1_name=file_raw_list1[i]
        infeatures1=os.path.join(filepath1,file_raw_list1[i])
        infeatures2=os.path.join(filepath2,file_raw_list2[i])
        outRaster_str = infeatures1_name[9:17] + ".tif"
        outRaster_name=os.path.join(resultpath,outRaster_str)  
        str_tif=infeatures1+";"+infeatures2
        ##Mosaic several TIFF images to a new TIFF image
        arcpy.MosaicToNewRaster_management(str_tif,resultpath,outRaster_str,"","32_BIT_FLOAT", "0.1", "1", "LAST","FIRST")
        print arcpy.GetMessages()
 

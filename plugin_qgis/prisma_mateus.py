!pip install --upgrade pip
!pip install rtree
!pip install geopandas

import pandas as pd
import geopandas as gpd
import rtree

from shapely.geometry import Point, LineString, Polygon

area_militar = gpd.read_file("Area_Militar_A.shp")
area_uniao = gpd.read_file("Area_Uniao_Homologada_A.shp")

area_floripa = gpd.read_file("Lotes_15_Florianopolis_SIRGAS2000.shp")

area_floripa

area_floripa.iloc[0]['geometry']

area_floripa.iloc[0]['geometry'].area

area_floripa.overlay(area_militar)

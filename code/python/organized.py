from scrape_noaa import scrape_noaa

import json
import os
import pandas as pd
import requests
import time


def organized():
    """
    """

    print("running organized")

    tasks = [0]

    if 0 in tasks: query_noaa()

    #if 1 in tasks:


    print("completed organized")


def query_noaa():
    """
    copied from online
    """


    src_locations = "locations.json"
    with open(src_locations) as json_data:
        locations = json.load(json_data)

    print(locations)

    for key in locations.keys(): 

        location = locations[key]

        print(location)  
        
        
        url = 'https://gml.noaa.gov/grad/solcalc/table.php'
        headers = {
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/109.0'
        }

        # Fill this table with your counties
        counties = {
            'NY': {'lat': 40.72, 'lon': -74.02},
            'LA': {'lat': 37.77, 'lon': -122.42},
            'OD': {'lat': 41.414059, 'lon': -73.303711},
            'SF': {'lat': 37.77557277844762, 'lon': -122.46884808939886} 
        }



    
    for county, params in counties.items():

        dataset = []
        for year in range(2023, 2025):
            print(year, county)
            payload = params | {'year': year}
            r = requests.get(url, headers=headers, params=payload)
            dfs = pd.read_html(r.text)

            # Reshape your data
            dfs = (pd.concat(dfs, keys=['Sunrise', 'Sunset', 'SolarNoon']).droplevel(1)
                    .assign(Year=year, Lat=params['lat'], Lon=params['lon'])
                    .set_index(['Lat', 'Lon', 'Year', 'Day'], append=True)
                    .rename_axis(columns='Month').stack('Month')
                    .unstack(level=0).reset_index())
            
            print("dfs = ")
            print(dfs)

            print(type(dfs)) 
    
    
    
    """



if __name__ == "__main__":
    organized()
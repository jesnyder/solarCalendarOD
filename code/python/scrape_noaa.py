import json
import os
import pandas as pd
import requests
import time

# Import Meteostat library and dependencies
from datetime import datetime
import matplotlib.pyplot as plt
from meteostat import Point, Daily


def scrape_noaa():
    """
    """

    print("running scrape_noaa")

    tasks = [2, 3]

    if 0 in tasks: query_noaa()
    if 1 in tasks: query_meterostat()


    location_names = ["SF", "OD"] 
    for location_name in location_names: 
        if 2 in tasks: coregister_data(location_name)
        if 3 in tasks: write_openscad(location_name)

    print("completed scrape_noaa")



def write_openscad(location_name):
    """
    
    """

    src_filename = "refs_" + location_name + ".csv"
    df = pd.read_csv(src_filename)

    src_fil = os.path.join("code", "openscad", "mobile.scad")
    src_fil = os.path.join("mobile.scad")

    dst_fil = "mobile_" + location_name + ".scad"
 
    f = open(src_fil, "r")
    lines = f.readlines()
    f.close()
    
    dst = []
    found = False
    for line in lines: 

        if "// end python script insertion of variable " in line: found = False

        if found == True: continue 

        dst.append(line)

        if "// begin python script inserts variables" in line: 

            found = True


            for i in range(len(list(df["time"]))): 

                time = df.loc[i, "time"]
                angle = df.loc[i, "angles"]
                noon = df.loc[i, "noon"]
                day = df.loc[i, "day"]
                month = df.loc[i, "month"]
                precipi = df.loc[i, "avg_precipi"]
                tempi = df.loc[i, "avg_tempi"]


                temp = "\n// " + str(time) + " \n"
                dst.append(temp)

                temp = "// Temperature = " + str(df.loc[i, "avg_temp"]) + " | i = " + str(df.loc[i, "avg_tempi"]) +  " | Max = " + str(max(list(df["avg_temp"]))) +  " | Min = " + str(min(list(df["avg_temp"]))) +  "  \n"
                dst.append(temp)

                temp = "// Precipitation = " + str(df.loc[i, "precip"]) + " | i = " + str(df.loc[i, "precipi"]) +  " | Max = " + str(max(list(df["precip"]))) +  " | Min = " + str(min(list(df["precip"]))) +  "  \n"
                dst.append(temp)

                temp = "// Noon , Day , Month , Precip , Temp \n"
                dst.append(temp)

                temp = "rotate([0 , 0 , " +  str(angle) + "])" + "\n"
                dst.append(temp)

                temp = "web(x, y, z, " + str(noon) + " , " + str(day) + " , " + str(month) + " ,  " + str(precipi) + " , " + str(tempi) + " ); " + "\n" + "\n"
                dst.append(temp)
        


    dst_fil = os.path.join(dst_fil)
    f = open(dst_fil, "w")
    for line in dst: 
        f.write(line)
    f.close()



def coregister_data(location_name):
    """
    single dataframe saved as .csv 
    """

    temp_filename = location_name + "_temp.csv"
    #filename = "temp.csv"
    df_temp = pd.read_csv(temp_filename)
    #df_temp = trim_by_date(df_temp)
    print(df_temp)
    
    solar_filename = "solarCalendar_" + location_name + ".csv"
    #filename = "solarCalendar_OD.csv"
    df_solar = pd.read_csv(solar_filename)
    #df_solar = trim_by_date(df_solar)
    print(df_solar)


    df = pd.DataFrame()
    df["time"] = df_temp["time"]
    df["year"] = df_temp["Year"]
    df["month"] = df_temp["Month"]

    df["precip"] = df_temp["prcp"]
    df["precipi"] = index_df(list(df["precip"]))

    df["temp"] = df_temp["tavg"]
    df["tempi"] = index_df(list(df["temp"]))


    df["noon"] = [0]*len(list(df["time"]))
    df["day"] = [0]*len(list(df["time"]))

    for i in range(len(list(df["time"]))):

        for j in range(len(list(df_solar["time"]))):

            if df_solar.loc[j, "time"] != df.loc[i, "time"]: continue 

            #df.loc[i, "noon"] = df_solar.loc[j, "SolarNoon"]
            #df.loc[i, "sunrise"] = df_solar.loc[j, "Sunrise"]
            #df.loc[i, "sunset"] = df_solar.loc[j, "Sunset"]

            sunrise = (df_solar.loc[j, "Sunrise"]).split(":")
            sunrise = float(sunrise[0]) + float(sunrise[1])/60

            sunset = (df_solar.loc[j, "Sunset"]).split(":")
            sunset = float(sunset[0]) + float(sunset[1])/60

            noon = (df_solar.loc[j, "SolarNoon"]).split(":")
            noon = float(noon[0]) + float(noon[1])/60

            df.loc[i, "day"] = round((sunset - sunrise)/24, 4)
            df.loc[i, "noon"] = round((noon)/24, 4)



    df2023 = df[(df['year'] == 2023) & (df['month'] >= 10)]
    df2024 = df[(df['year'] == 2024) & (df['month'] < 10)]
    df = pd.concat([df2023, df2024])

    df = df.sort_values(by='time')


    
    counter = []
    week_counters = []
    avg_temps = []
    avg_precips = []

    for i in range(len(list(df["time"]))): 

        counter.append(i)

        week_counter = i%7 
        week_counters.append(week_counter)

        if week_counter == 0: 
            temp_short_list = list(df["temp"])[i:i+7]
            avg_temp = sum(temp_short_list)/len(temp_short_list)

            precip_short_list = list(df["precip"])[i:i+7]
            avg_precip = sum(precip_short_list)/len(precip_short_list)
            
            #print("len precip short list = ")
            #print(len(temp_short_list))

            avg_temps.append(avg_temp)
            avg_precips.append(avg_precip)
        
        else: 
            avg_temps.append(0)
            avg_precips.append(0)


        
    df["index"] = counter
    df["week_counter"] = week_counters
    df["avg_precip"] = avg_precips
    df["avg_temp"] = avg_temps

    df = df[(df['week_counter'] == 0)]
    df = df[(df['index'] < 364)]


    df["tempi"] = index_df(list(df["tempi"]))
    df["precipi"] = index_df(list(df["precipi"]))
    df["avg_tempi"] = index_df(list(df["avg_temp"]))
    df["avg_precipi"] = index_df(list(df["avg_precip"]))

    angles = []
    for i in range(len(list(df["index"]))): 

        angle = round(i*360/52, 4)
        angles.append(angle)

    df["angles"] = angles


    dst_filename = "refs_" + location_name + ".csv"
    df.to_csv(dst_filename)


    
def index_df(df_list):
    """
    index a list 
    """

    indexed = []

    for i in range(len(df_list)): 

        value = df_list[i]

        normalized = round((value - min(df_list)) / (max(df_list) - min(df_list)), 4)

        #print(normalized)

        assert normalized <= 1 
        assert normalized >= 0 

        #assert max(normalized) > .9 
        #assert min(normalized) < 0.1


        indexed.append(normalized)


    return(indexed)



def trim_by_date(df):
    """
    take timestamped dataframe 
    return dataframe trimmed to specific date range 
    """

    begin_year = 2023 
    begin_month = 10 
    begin_day = 1 
    end_year = 2024 
    end_month = 9 
    end_day = 30 

    #df_trimmed = pd.DataFrame()
    #df_trimmed = df.loc[(df['Year'] >= begin_year) & (df['Year'] <= end_year)]

    dropped = []
    for i in range(len(list(df["Year"]))):

        date_original = list(df["time"])[i]
        date = date_original.split("-")

        print(date)

        if int(date[0]) <= begin_year: continue 
        #if int(date[0])  > end_year: continue 

        #if int(date[0]) == begin_year & int(date[1]) > begin_month: continue 
        #if int(date[0]) == end_year & int(date[1]) > end_month: continue 

        #dropped.append(i)
        #df_trimmed = df.drop(i)
        print("dropped: " + str(date_original))

    df.drop(dropped)

    print("len of trimmed dataframe = ")
    print(len(list(df["time"])))

    return(df)



def read_json():
    """
    read json
    """

    filename = "locations.json"

    # Open and read the JSON file
    with open(filename, 'r') as file:
        data = json.load(file)

    # Print the data
    print(data)

    return(data)



def query_noaa():
    """
    copied from online
    """

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

    url = 'https://gml.noaa.gov/grad/solcalc/table.php'


    locations = read_json()

    for key in locations.keys():

        location = locations[key]

        print(location)


    
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

            #dataset.append(dfs)
            #dataset = pd.concat([dataset, dfs], axis=1)
            if type(dataset) == list: 
                dataset = dfs
            else: 
                #dataset = dataset.append(dfs)
                dataset = pd.concat([dataset, dfs])

            print("dataset = ")
            print(dataset)
            time.sleep(10)  # Wait at least 10 seconds not to be banned

        print("dataset = ")
        print(dataset)
        dataset["time"] = ["0000-00-00"]*len(list(dataset["Lat"]))        
        

        filename = "solarCalendar_" + str(county) +  str(".csv")
        #out = pd.concat(dataset, ignore_index=True)
        dataset.to_csv(filename, index=False)


        dataset = pd.read_csv(filename)

        for i in range(len(list(dataset["Year"]))):
            tim = str(int(list(dataset["Year"])[i])) + "-"

            month = str(list(dataset["Month"])[i])
            month_index = str(datetime.strptime(month, '%b')).split("-")[1]
            print(month)
            print(month_index)

            tim = tim + str(month_index).zfill(2) + "-"
            tim = tim + str(int(list(dataset["Day"])[i])).zfill(2)
            print(tim)

            dataset.loc[i, "time"] = tim
        
        dataset = dataset.sort_values(by='time')
        
        dataset.to_csv(filename, index=False)
        



def query_meterostat():
    """
    copied from online
    """

    # Set time period
    start = datetime(2023, 1, 1)
    end = datetime(2024, 10, 1)

    # Create Point for Newtown, Connecticut
    location_name = "OD"
    location = Point(41.414059, -73.303711, 70)

    # San Francisco 
    #location_name = "SF"
    #location = Point(37.77557277844762, -122.46884808939886) 

    # Get daily data for 2018
    data = Daily(location, start, end)
    data = data.fetch()

    # Plot line chart including average, minimum and maximum temperature
    #data.plot(y=['tavg', 'tmin', 'tmax'])
    #plt.show()

    print(data)
    dst_filename = location_name + "_temp.csv"
    data.to_csv(dst_filename)

    data = pd.read_csv(dst_filename)
    print(data)

    data["Year"] = [0]*len(list(data["time"]))
    data["Month"] = [0]*len(list(data["time"]))
    data["Day"] = [0]*len(list(data["time"]))

    for i in range(len(list(data["time"]))):

        date = list(data["time"])[i] 
        data.loc[i, "Year"] = int(date.split("-")[0])
        data.loc[i, "Month"] = int(date.split("-")[1])
        data.loc[i, "Day"] = str(date.split("-")[2])

    
    data.to_csv(dst_filename)




if __name__ == "__main__":
    scrape_noaa()


import pandas as pd
def loaddata():
    df_empty = pd.DataFrame()
    numrange = ["01","02","03","04","05","06","07","08","09","10","11","12"]
    for num in numrange:
        url = f"https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-{num}.parquet"
        df = pd.read_parquet(url)
        print(f"url {num} and the length of the original dataframe is {len(df_empty)} and the monthly load is {len(df)}")
        df_empty = pd.concat([df_empty,df])
    df_empty.to_excel("NYC Taxi Data.xlsx",index=False)

    loaddata()
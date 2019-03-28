import json
import pandas as pd

with open('predictors.json') as f:
    PREDICTORS = json.load(f)

#### fake data

DF = pd.DataFrame(
    {
        'customer_id': range(500),
        'height': pd.np.random.normal(70, 20, size=500),
        'is_male': pd.np.random.normal(1, 0.5, size=500)
    }
)

DF['income'] = 30 + .1*DF['height'] + 5*DF['is_male']

### define functions

def query_to_pandas(query):
    return DF[[p["name"] for p in PREDICTORS] + ['income']]

def query_to_table(query):
    pass
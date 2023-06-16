# # !pip install numpy
# # !pip install pandas
# # !pip install matplotlib
# # !pip install seaborn
# # !pip install sklearn
# # !pip install lazypredict
#
# import numpy as np
# import pandas as pd
# import seaborn as sns
# import matplotlib.pyplot as plt
# import pickle
# import warnings
# warnings.warn('ignore')
# # from lazypredict.Supervised import LazyClassifier
# from sklearn.metrics import accuracy_score, precision_score, f1_score, recall_score, confusion_matrix
# from sklearn.model_selection import train_test_split
# from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
# from sklearn.preprocessing import MinMaxScaler
# from flask import Flask, request, jsonify
#
# app = Flask(__name__)
#
# def inference(age, sex, chestpain, bp, cholestrol, fbs, ekg, hr, exercise, depression, slope, vessels, thallium):
#     data = {'age': age,
#         'sex': sex,
#         'chestpain': chestpain,
#         'bp': bp,
#         'cholestrol': cholestrol,
#         'fbs': fbs,
#         'ekg': ekg,
#         'hr': hr,
#         'exercise': exercise,
#         'depression': depression,
#         'slope': slope,
#         'vessels': vessels,
#         'thallium': thallium}
#
#     data = pd.DataFrame(data, index=[0])
#
#     with open('MinMaxScaler.pkl', 'rb') as f:
#         MMSclaer = pickle.load(f)
#         data = MMSclaer.transform(data)
#
#     with open('LDA.pkl', 'rb') as f:
#         xyz = pickle.load(f)
#
#     y_pred = xyz.predict(data)
#     print("***********",y_pred)
#     return y_pred[0]
#
#
# @app.route("/", methods=["POST"])
# def compute_result():
#     print(request)
#     age        = np.float(request.args["age"])
#     sex        = np.float(request.args["sex"])
#     chestpain  = np.float(request.args["chestpain"])
#     bp         = np.float(request.args["bp"])
#     cholestrol = np.float(request.args["cholestrol"])
#     fbs        = np.float(request.args["fbs"])
#     ekg        = np.float(request.args["ekg"])
#     hr         = np.float(request.args["hr"])
#     exercise   = np.float(request.args["exercise"])
#     depression = np.float(request.args["depression"])
#     slope      = np.float(request.args["slope"])
#     vessels    = np.float(request.args["vessels"])
#     thallium   = np.float(request.args["thallium"])
#
#     result = inference(age, sex, chestpain, bp, cholestrol, fbs, ekg, hr, exercise, depression, slope, vessels, thallium)
#     return jsonify({"result": result})
#
# if __name__ == "__main__":
#     app.run(debug=True)

import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import pickle
import warnings
from flask import Flask, request, jsonify

warnings.filterwarnings('ignore')

app = Flask(__name__)

def inference(age, sex, chestpain, bp, cholestrol, fbs, ekg, hr, exercise, depression, slope, vessels, thallium):
    data = {
        'age': age,
        'sex': sex,
        'chestpain': chestpain,
        'bp': bp,
        'cholestrol': cholestrol,
        'fbs': fbs,
        'ekg': ekg,
        'hr': hr,
        'exercise': exercise,
        'depression': depression,
        'slope': slope,
        'vessels': vessels,
        'thallium': thallium
    }

    data = pd.DataFrame(data, index=[0])

    with open('MinMaxScaler.pkl', 'rb') as f:
        scaler = pickle.load(f)
        data = scaler.transform(data)

    with open('LDA.pkl', 'rb') as f:
        lda = pickle.load(f)

    y_pred = lda.predict(data)
    return y_pred[0]

@app.route("/", methods=["POST"])
def compute_result():
    data = request.get_json()

    age = data["age"]
    sex = data["sex"]
    chestpain = data["chestpain"]
    bp = data["bp"]
    cholestrol = data["cholestrol"]
    fbs = data["fbs"]
    ekg = data["ekg"]
    hr = data["hr"]
    exercise = data["exercise"]
    depression = data["depression"]
    slope = data["slope"]
    vessels = data["vessels"]
    thallium = data["thallium"]
    print(age, sex, chestpain, bp, cholestrol, fbs, ekg, hr, exercise, depression, slope, vessels, thallium)
    result = inference(age, sex, chestpain, bp, cholestrol, fbs, ekg, hr, exercise, depression, slope, vessels, thallium)
    return jsonify({"result": result})

if __name__ == "__main__":
    app.run(debug=True)

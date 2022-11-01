import tensorflow as tf
import tensorflow_probability as tfp
import numpy as np
from flask import Flask, jsonify, request, session
# from userModel import User
from userProfileModel import UserProfile
import pyrebase
from datetime import datetime
from ConnectionModel import Connection
from Account import Account
configuration = tf.compat.v1.ConfigProto(device_count={"GPU": 0})
session = tf.compat.v1.Session(config=configuration)
config = {
    'apiKey': "AIzaSyC-xfcBy-1gr8ok35jJR3N8rMRcSEeigwU",
    'authDomain': "friend-finder-69982.firebaseapp.com",
    'databaseURL': "https://friend-finder-69982.firebaseio.com",
    'projectId': "friend-finder-69982",
    'storageBucket': "friend-finder-69982.appspot.com",
    'messagingSenderId': "612450494062",
    'appId': "1:612450494062:web:b6b5b116183c5c1021687f",
    'measurementId': "G-DJF7WQG0EF"
}
firebase = pyrebase.initialize_app(config)
database = firebase.database()
storage = firebase.storage()
auth = firebase.auth()

def get_user_matches(user_index, li, classes):
#   x = np.zeros((len(li),classes), dtype = "int")
#   for index,i in enumerate(li):
#     x[index,i] = 1
      x = np.array(li)
      print(x)
      # with tf.Session() as sess:
      #       with tf.device("/cpu:0"):
      tensor = tf.convert_to_tensor(x, dtype = "float")
      corr = tfp.stats.correlation(tensor, tensor, sample_axis= 1, event_axis = 0)

      ind = tf.math.top_k(
      corr[0], k=x.shape[0], sorted=True, name=None
      ).indices
      arr = ind.numpy()

      index = np.argwhere(arr==user_index)
      return np.delete(arr, index)

# @app.route('/get_match_users', methods=['POST', 'GET'])
def get_match_users():
      users=[]
      interest_vectors= ["Music", "Dance", "Act", "Sports", "TV", "Travelling"]
      users = database.child("users").get().val()
      user_list=[]
      vectors = []
      final = []
      for i, user in enumerate(users.values()):
            # print(request.json)
            if(request.json["user_id"] == user["user_id"]):
                  index = i
            user_active = user.copy()
            vector_list=[]
            # print(user)
            for inter in interest_vectors:
                  if(inter in user["user_profile"]["interest"]):
                        vector_list.append('1')
                  else:
                        vector_list.append('0')
            vectors.append(vector_list)
            user_list.append(user_active)
      print(vectors)
      indices = get_user_matches(index, vectors, len(interest_vectors))
      for i in indices:
            final.append(user_list[i])
      return jsonify(final)
                        
                  
            
      

  
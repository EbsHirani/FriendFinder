from userProfileModel import UserProfile
from flask import Flask, jsonify, request, session
import tensorflow as tf
import tensorflow_probability as tfp
import numpy as np
import pyrebase

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

class Message:
    def __init__(self,message,timestamp,receiver,sender,status):
        self.message = message
        self.timestamp = timestamp
        self.receiver = receiver
        self.sender = sender
        self.status = status

    def send message(self):
        message = Message(request.json["message"], request.json["timestamp"], request.json["receiver"], request.json["sender"], 1)
        database.child("messages").update(message.__dict__)
        return jsonify(message.__dict__)


    def delete_message(self):
        database.child("messages").child(request.json["message_id"]).update({"status":-1})
        return "Message Deleted Successfully"

from flask import Flask, jsonify, request, session
from userModel import User
from userProfileModel import UserProfile
import pyrebase
from datetime import datetime
from ConnectionModel import Connection

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


class Admin:
    def __init__(self, name, age,dob):
        self.user_id = user_id
        self.email_id = email_id
        self.password = password
        self.role = role

    def view_account(self):
        if request.method == 'POST':
            users =[]
            users = database.child("users").get().val()
            for user in users.values():
                if(user["user_id"] == request.json["user_id"]):
                    user_login = user.copy()
            return jsonify(user_login)

    def delete_account(self):
        if request.method == 'POST':
            user = database.child("users").child(request.json["user_id"]).get().val()
            user["delete"] = 1
            database.child("users").child(request.json["user_id"]).update(jsonify(user))
    def complaint_handling(self):
        reports = database.child("reports").get().val()
        return jsonify(reports)
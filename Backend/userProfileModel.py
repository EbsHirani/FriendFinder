from flask import Flask, jsonify, request, session
import pyrebase
from datetime import datetime


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


class UserProfile:
    def __init__(self):
        pass

    def getter(self):
        users = []
        users = database.child("users").get().val()
        for user in users.values():
            if(user['user_id'] == request.json["user_id"]):
                user_login_profile = user.copy()
                return jsonify(user_login_profile)

    def setter(self, name, dob, profile_picture, languages, bio, interest):
        self.name = name
        self.dob = dob
        self.profile_picture = profile_picture
        self.languages = languages
        self.bio = bio
        self.interest = interest

    def update_profile(self):
        user_Profile = UserProfile()
        user_Profile.setter(
            request.json['name'], request.json['dob'], request.json['profile_picture'], request.json['languages'], request.json['bio'], request.json['interest'])
        users = []
        users = database.child("users").get().val()
        for user in users.values():
            if(user['user_id'] == request.json["user_id"]):
                user_login_profile = user.copy()
        database.child("users").child(
            user_login_profile["user_id"]).update({'user_profile': user_Profile.__dict__})
        user_login_profile["user_profile"] = user_Profile.__dict__
        return jsonify(user_login_profile)

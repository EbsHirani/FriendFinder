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


class Account:
    def __init__(self):
        pass

    def setter(self, user_id, email_id, password, role):
        self.user_id = user_id
        self.email_id = email_id
        self.password = password
        self.role = role

    def register(self):
        if request.method == 'POST':
            # pyrebase functionality for register
            now = datetime.now()
            current_time = now.strftime("%H:%M:%S")

            user = auth.create_user_with_email_and_password(
                request.json['email'], request.json['password'])

            # Unique User ID
            user_profile = {'name': request.json['name']}
            user_id = str(auth.get_account_info(
                user['idToken'])['users'][0]['localId'])
            connection = [{
                'user_id_sender': 0,
                'user_id_receiver': 0,
                'status': 0
            }]
            userobj = User()
            userobj.setvalues(request.json['email'],
                           user_id, request.json['name'], last_login=current_time, user_profile=user_profile, connection=connection)
            print(userobj.__dict__)

            # Puttting into Realtime DB
            if(user):
                print(user_id)
                database.child("users").child(
                    user_id).update(userobj.__dict__)
                return jsonify(userobj.__dict__)
            else:
                return jsonify({'msg': 'Register Unsuccessfull'})
        return "Login Screen"

    def login(self):
        if request.method == 'POST':
            now = datetime.now()
            current_time = now.strftime("%H:%M:%S")
            print("Current Time =", current_time)
            # pyrebase functionality for login
            user_login = auth.sign_in_with_email_and_password(
                request.json['email'].strip(), request.json['password'])

            users = []
            users = database.child("users").get().val()
            for user in users.values():
                if(user['user_id'] == str(auth.get_account_info(user_login['idToken'])['users'][0]['localId'])):
                    user_login = User()
                    user_login.setvalues(user['email_id'],
                                      user['user_id'], user['name'], current_time, user['user_profile'], user['connection'])
                    database.child("users").child(
                        user["user_id"]).update({'login_status': True})
                    user_login.login_status = True
                    return jsonify(user_login.__dict__)

from flask import Flask, jsonify, request, session
from userModel import User
from userProfileModel import UserProfile
import pyrebase
from datetime import datetime
from ConnectionModel import Connection
from Account import Account
from matching import get_match_users

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


app = Flask(__name__)
app.secret_key = "SAD"


firebase = pyrebase.initialize_app(config)
database = firebase.database()
storage = firebase.storage()
auth = firebase.auth()


app.add_url_rule(
    '/register', methods=['POST', 'GET'], view_func=Account().register)


app.add_url_rule('/login', methods=['POST', 'GET'], view_func=Account().login)


app.add_url_rule('/set_user_profile',
                 methods=['POST', 'GET'], view_func=UserProfile().update_profile)

app.add_url_rule('/get_user_profile',
                 methods=['POST', 'GET'], view_func=UserProfile().getter)


app.add_url_rule('/create_connection', methods=["GET", "POST"],
                 view_func=Connection().send_request)


app.add_url_rule('/accept_connection',
                 methods=['POST', 'GET'], view_func=Connection().accept_request)


app.add_url_rule('/reject_connection',
                 methods=['POST', 'GET'], view_func=Connection().reject_request)

app.add_url_rule('/get_match_users',
                 methods=['POST', 'GET'], view_func=User().matching)


@app.route('/get_all_users', methods=['POST', 'GET'])
def get_users():
    users = []
    users = database.child("users").get().val()
    return jsonify(users)


@app.route('/get_all_friends', methods=['POST', 'GET'])
def get_friends():
    users =[]
    users = database.child("users").get().val()
    for user in users.values():
        if(user["user_id"] == request.json["user_id"]):
            user_login = user.copy()
    connection_list = user_login['connection']
    friends = []
    for user in users.values():
        flag = 0
        for connection in connection_list:
            if((user["user_id"] == connection["user_id_receiver"] or user["user_id"] == connection["user_id_sender"]) and user["user_id"] != user_login["user_id"]):
                if(connection["status"] == 1):
                    flag = 1
                    break
        if(flag == 1):
            friends.append(user)
    sorted(friends, key=lambda i: i['name' ])
    print(friends)
    return jsonify(friends)


@app.route('/report_user', methods=['POST', 'GET'])
def report_user():
    database.child('reports').update({
        'complainer': request.json["complainer"],
        'complainee': request.json["complainee"],
        'message': request.json['message']
    })

@app.route('/pending_request', methods=['POST', 'GET'])
def get_pending_request():
    users =[]
    users = database.child("users").get().val()
    for user in users.values():
        if(user["user_id"] == request.json["user_id"]):
            user_login = user.copy()
    connection_list = user_login['connection']
    friends_pending = []
    for user in users.values():
        flag = 0
        for connection in connection_list:
            if(user["user_id"] == connection["user_id_sender"] and user["user_id"] != user_login["user_id"]):
                print(user["user_id"])
                if(connection["status"] == 0):
                    flag = 1
                    break
        if(flag == 1):
            friends_pending.append(user)
    sorted(friends_pending, key=lambda i: i['name' ])
    return jsonify(friends_pending)




if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True,)

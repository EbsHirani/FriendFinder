from flask import Flask, jsonify, request, session
import pyrebase

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


class Connection:
    def __init__(self):
        pass

    def setter(self, user_id_sender, user_id_receiver, status):
        self.user_id_sender = user_id_sender
        self.user_id_receiver = user_id_receiver
        self.status = status

    def send_request(self):
        connection = Connection()
        connection.setter(
            request.json['user_id_sender'], request.json['user_id_receiver'], 0)
        users = []
        users = database.child("users").get().val()
        for user in users.values():
            if((user['user_id'] == request.json["user_id_sender"]) or (user['user_id'] == request.json["user_id_receiver"])):
                connection_list = user['connection']
                connection_list.append(connection.__dict__)
                database.child("users").child(user["user_id"]).update(
                    {"connection": connection_list})
        return 'Connection Established Successfully'

    def accept_request(self):
        users = []
        users = database.child("users").get().val()
        print(request.json["user_id_sender"])
        print(request.json["user_id_receiver"])
        for user in users.values():
            if((user['user_id'] == request.json["user_id_sender"]) or (user['user_id'] == request.json["user_id_receiver"])):
                connection_list = []

                for connection in user['connection']:
                    if((connection['user_id_sender'] == request.json["user_id_sender"]) and (connection['user_id_receiver'] == request.json["user_id_receiver"])):
                        connection['status'] = 1
                        connection_list.append(connection)
                    else:
                        connection_list.append(connection)
                database.child("users").child(user["user_id"]).update(
                    {"connection": connection_list})
        return 'Connection Accepted Successfully'

    def reject_request(self):
        users = []
        users = database.child("users").get().val()
        for user in users.values():
            if((user['user_id'] == request.json["user_id_sender"]) or (user['user_id'] == request.json["user_id_receiver"])):
                connection_list = []
                for connection in user['connection']:
                    if((connection['user_id_sender'] == request.json["user_id_sender"]) and (connection['user_id_receiver'] == request.json["user_id_receiver"])):
                        connection['status'] = -1
                        connection_list.append(connection)
                    else:
                        connection_list.append(connection)
                database.child("users").child(user["user_id"]).update(
                    {"connection": connection_list})
        return 'Connection Rejected Successfully'

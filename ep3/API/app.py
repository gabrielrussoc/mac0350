from flask import Flask
from flask_jwt_extended import JWTManager
import access.api
import people.api
import curriculum.api
import os

app = Flask(__name__)

app.config['JWT_SECRET_KEY'] = os.environ['JWT_SECRET_KEY']
jwt = JWTManager(app)

app.register_blueprint(access.api.blueprint, url_prefix='/access')
app.register_blueprint(people.api.blueprint, url_prefix='/people')
app.register_blueprint(curriculum.api.blueprint, url_prefix='/curriculum')


@app.route('/')
def index():
    return 'REACT'

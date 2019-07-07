from flask import Flask
from flask_jwt_extended import JWTManager
from flask_cors import CORS
import access.api
import curriculum.api
import access_people.api
import os

app = Flask(__name__)

app.config['JWT_SECRET_KEY'] = os.environ['JWT_SECRET_KEY']
jwt = JWTManager(app)

app.register_blueprint(access.api.blueprint, url_prefix='/access')
app.register_blueprint(curriculum.api.blueprint, url_prefix='/curriculum')
app.register_blueprint(access_people.api.blueprint, url_prefix='/access_people')

CORS(app)

@app.route('/')
def index():
    return 'ROOT'

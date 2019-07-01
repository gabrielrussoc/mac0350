from flask import Flask
import access.api
import people.api
import curriculum.api

app = Flask(__name__)

app.register_blueprint(access.api.blueprint, url_prefix='/access')
app.register_blueprint(people.api.blueprint, url_prefix='/people')
app.register_blueprint(curriculum.api.blueprint, url_prefix='/curriculum')

@app.route('/')
def index():
    return 'REACT'

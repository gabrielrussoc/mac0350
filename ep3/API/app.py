from flask import Flask
import acesso.api
import pessoas.api
import curriculo.api

app = Flask(__name__)

app.register_blueprint(acesso.api.blueprint, url_prefix='/acesso')
app.register_blueprint(pessoas.api.blueprint, url_prefix='/pessoas')
app.register_blueprint(curriculo.api.blueprint, url_prefix='/curriculo')

@app.route('/')
def index():
    return 'REACT'

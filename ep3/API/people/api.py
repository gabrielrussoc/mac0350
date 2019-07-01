from flask import Blueprint

blueprint = Blueprint('people', __name__)

@blueprint.route('/')
def index():
    return 'pessoas'


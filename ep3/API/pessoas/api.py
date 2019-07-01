from flask import Blueprint

blueprint = Blueprint('pessoas', __name__)

@blueprint.route('/')
def index():
    return 'pessoas'
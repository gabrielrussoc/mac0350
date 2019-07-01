from flask import Blueprint

blueprint = Blueprint('curriculum', __name__)

@blueprint.route('/')
def index():
    return 'curriculo'
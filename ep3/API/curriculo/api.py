from flask import Blueprint

blueprint = Blueprint('curriculo', __name__)

@blueprint.route('/')
def index():
    return 'curriculo'
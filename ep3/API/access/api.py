from flask import Blueprint
from . import db

blueprint = Blueprint('access', __name__)

@blueprint.route('/')
def index():
    return db.calldb()
    return 'acesso'
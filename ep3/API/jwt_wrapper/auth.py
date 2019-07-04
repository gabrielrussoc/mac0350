from flask_jwt_extended import jwt_required, get_jwt_identity, create_access_token
from access.db import authorize
from http import HTTPStatus
from flask import jsonify

def service(service):
    def service_decorator(func):
        @jwt_required
        def func_wrapper(*args, **kwargs):
            user_id = get_jwt_identity()
            if authorize(user_id, service):
                return func(*args, **kwargs)
            return jsonify({ 'msg': 'Forbidden' }), HTTPStatus.FORBIDDEN
        func_wrapper.__name__ = func.__name__
        return func_wrapper
    return service_decorator

def create_token(user_id):
    return create_access_token(identity=user_id)

def get_user_id():
    return get_jwt_identity()



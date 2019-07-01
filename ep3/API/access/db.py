from db.Postgres import Postgres

db = Postgres(database='postgres')

def calldb():
    with db.cursor() as cursor:
        cursor.execute('SELECT 1')
        return str(cursor.fetchone())


import psycopg2.pool

class Postgres:

    class __CursorWrapper:
        def __init__(self, pool):
            self.pool = pool
            self.conn = pool.getconn()
        def __enter__(self):
            self.cursor = self.conn.cursor()
            return self.cursor
        def __exit__(self, type, value, traceback):
            self.cursor.close()
            self.pool.putconn(self.conn)

    def __init__(self, database, user, host, minConn=2, maxConn=5, port='5432'):
        self.__pool = psycopg2.pool.ThreadedConnectionPool(minConn, maxConn,
                                        user = user,
                                        host = host,
                                        port = port,
                                        database = database)

    def cursor(self):
        return self.__CursorWrapper(self.__pool)

    def __del__(self):
        self.__pool.closeall()
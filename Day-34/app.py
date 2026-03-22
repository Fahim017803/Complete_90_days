from flask import Flask
import psycopg2
import redis
import os

app = Flask(__name__)

@app.route("/")
def home():

    db_msg = "Database not connected"
    redis_msg = "Redis not connected"

    try:
        conn = psycopg2.connect(
            host=os.getenv("DB_HOST"),
            dbname=os.getenv("DB_NAME"),
            user=os.getenv("DB_USER"),
            password=os.getenv("DB_PASSWORD")
        )
        db_msg = "Connected to PostgreSQL"
        conn.close()
    except Exception as e:
        db_msg = f"DB error: {e}"

    try:
        r = redis.Redis(host=os.getenv("REDIS_HOST"), port=6379)
        r.ping()
        redis_msg = "Connected to Redis cache"
    except Exception as e:
        redis_msg = f"Redis error: {e}"

    return f"""
    <h1>Hello from Flask Web App</h1>
    <h1>Hello from Fahim's devops lab</h1>
    <p>{db_msg}</p>
    <p>{redis_msg}</p>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
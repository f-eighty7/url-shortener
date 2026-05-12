import os
from dotenv import load_dotenv
from flask import Flask, request, redirect, render_template
import secrets
from models import db, Link

load_dotenv()

app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = os.environ["DATABASE_URL"]

db.init_app(app)

with app.app_context():
    db.create_all()


@app.route("/")
def home():
    return render_template("index.html")


@app.get("/<short_code>")
def redirect_url(short_code):
    link = Link.query.filter_by(short_code=short_code).first_or_404()
    return redirect(link.long_url)


@app.post("/shorten")
def shorten_url():
    long_url = request.form["url"]
    short_url = secrets.token_urlsafe(6)
    new_link = Link(short_code=short_url, long_url=long_url)
    db.session.add(new_link)
    db.session.commit()
    return render_template("index.html", short_url=request.host_url + short_url)

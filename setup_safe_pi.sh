#!/bin/bash

echo "🔧 [SafePi Setup] Δημιουργία project structure..."

BASE=~/safe-pi

# Create folders
mkdir -p $BASE/app/templates
mkdir -p $BASE/app/static/css
mkdir -p $BASE/app/static/js
mkdir -p $BASE/app/static/fonts
mkdir -p $BASE/app/static/img

cd $BASE

# Create __init__.py
cat <<EOF > app/__init__.py
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
import os

app = Flask(__name__)

basedir = os.path.abspath(os.path.dirname(__file__))
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + os.path.join(basedir, '../cassandra.db')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

from app import routes, models
EOF

# Create routes.py
cat <<EOF > app/routes.py
from app import app
from flask import render_template

@app.route('/')
def home():
    return "Welcome to SafePi"
EOF

# Create models.py
echo "from app import db" > app/models.py

# Create run.py
cat <<EOF > run.py
from app import app

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
EOF

# Create requirements.txt
echo -e "flask\nflask_sqlalchemy" > requirements.txt

# Create empty cassandra.db
sqlite3 cassandra.db "VACUUM;"

echo "✅ [SafePi Setup] Ολοκληρώθηκε. Project folder δημιουργήθηκε στο $BASE"

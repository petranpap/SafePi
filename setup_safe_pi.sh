#!/bin/bash

echo "🔧 [SafePi Setup] Ξεκινάει η εγκατάσταση..."

BASE=~/safe-pi

# Install python3-venv & sqlite3 if not installed
sudo apt update
sudo apt install -y python3-venv sqlite3

# Create folders
mkdir -p $BASE/app/templates
mkdir -p $BASE/app/static/css
mkdir -p $BASE/app/static/js
mkdir -p $BASE/app/static/fonts
mkdir -p $BASE/app/static/img
mkdir -p $BASE/app/games
mkdir -p $BASE/app/assets
mkdir -p $BASE/app/sync

cd $BASE

# Create virtual environment
python3 -m venv venv

# Activate venv within script
source venv/bin/activate

# Upgrade pip
pip install --upgrade pip

# Create requirements.txt
cat <<EOF > requirements.txt
flask
flask_sqlalchemy
EOF

# Install requirements
pip install -r requirements.txt

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

@app.route('/portal')
def portal():
    return render_template('portal.html')

@app.route('/watch')
def watch():
    return "Video player coming soon"
EOF

# Create models.py
cat <<EOF > app/models.py
from app import db
# Models will be defined here (SQLAlchemy)
EOF

# Create templates/portal.html
cat <<EOF > app/templates/portal.html
<!DOCTYPE html>
<html>
<head>
  <title>SafePi Portal</title>
</head>
<body>
  <h1>SafePi Portal</h1>
  <p>Approved videos will appear here.</p>
</body>
</html>
EOF

# Create run.py
cat <<EOF > run.py
from app import app

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
EOF

# Create placeholder cassandra.db
sqlite3 cassandra.db "VACUUM;"

# Deactivate venv
deactivate

echo "✅ [SafePi Setup] Ολοκληρώθηκε!"
echo "👉 Για να ξεκινήσεις: cd ~/safe-pi && source venv/bin/activate && python run.py"

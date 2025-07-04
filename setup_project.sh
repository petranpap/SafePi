#!/bin/bash

echo "🔧 [SafePi Project Setup] Ξεκινάει η αρχική εγκατάσταση..."

# Create project folder
mkdir -p ~/safe-pi/app/templates
mkdir -p ~/safe-pi/app/static
mkdir -p ~/safe-pi/games
mkdir -p ~/safe-pi/assets
mkdir -p ~/safe-pi/sync

cd ~/safe-pi

# Install python3-venv if not installed
sudo apt install -y python3-venv sqlite3

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

# Create app/__init__.py
cat <<EOF > app/__init__.py
from flask import Flask

app = Flask(__name__)

from app import routes
EOF

# Create app/routes.py
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

# Create app/models.py
cat <<EOF > app/models.py
# Models will be defined here (SQLAlchemy)
EOF

# Create app/templates/portal.html
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

# Create main run.py
cat <<EOF > run.py
from app import app

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
EOF

# Create placeholder cassandra.db
sqlite3 cassandra.db "VACUUM;"

# Deactivate venv
deactivate

echo "✅ [SafePi Project Setup] Ολοκληρώθηκε η αρχική δομή!"
echo "👉 Για να ξεκινήσεις: cd ~/safe-pi && source venv/bin/activate && python run.py"

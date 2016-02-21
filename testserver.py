# Name: testserver.py
# Author: Dan Frese
# Written: 2/20/2016
# Modified: 2/20/2016
#
# Prerequisites: Must have root access (sudo will not work) and a C compiler
#
# Summary: This script will automatically download & install the Fortran compiler,
#	download and configure MPI source.

from flask import flask
import subprocess

app = Flask (__name__)

@app.route("/")# Site root

def hello():
    cmd = ["ls", " -l"]
    p = subprocess.Popen(cd,
                     stdout=subprocess.PIPE,
                     stderr=subprocess.PIPE,
                     stdin=subprocess.PIPE)
    out,err = p.communicate()
    return out

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')

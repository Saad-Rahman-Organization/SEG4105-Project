from flask import Flask,request, jsonify

app = Flask(__name__)

@app.route('/', methods=['GET'])
def home():
    content = request.json
    print(content['mytext'])
    return jsonify({"uuid":content})
   # return "Welcome to Flask with Docker!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
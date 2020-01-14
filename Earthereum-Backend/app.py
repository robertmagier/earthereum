from flask import Flask, request,send_from_directory,jsonify,send_file
from employee import Employee
import names
import threading
import requests
import time
import logging, os
import os
import json
from flask_cors import CORS
from web3 import Web3, HTTPProvider
from web3.contract import ConciseContract
from web3.auto import w3
from web3.middleware import geth_poa_middleware
from web3.gas_strategies.time_based import fast_gas_price_strategy
from eth_account import Account
from flask_marshmallow import Marshmallow
from flask_sqlalchemy import SQLAlchemy
from io import BytesIO
import base64
from PIL import Image
import ast




app = Flask(__name__)
app.logger.setLevel(logging.DEBUG)
CORS(app)
app.config.from_object(os.environ['APP_SETTINGS'])
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)
ma = Marshmallow(app)
print()
print ("  STARTING EARTHEREUM BACKEND")
print ("  ^^^^^^^^^^^^^^^^^^^^^^^^^^^")
print ("  ETHEREUM PROVIDER:",app.config['PROVIDER'])
print ("  ETHEREUM CONTRACT:",app.config['ETHEREUM_CONTRACT'])
print ("  DATABASE:",app.config['SQLALCHEMY_DATABASE_URI'])
print()

from models import Countries


class CountriesSchema(ma.ModelSchema):
    class Meta:
        model = Countries

PROJECT_HOME = os.path.dirname(os.path.realpath(__file__))
FLAGS_IMG_FOLDER = '{}/img/flags/'.format(PROJECT_HOME)
COUNTRY_IMG_FOLDER = '{}/img/Countries/'.format(PROJECT_HOME)
app.config['COUNTRY_IMG_FOLDER'] = COUNTRY_IMG_FOLDER
app.config['FLAGS_IMG_FOLDER'] = FLAGS_IMG_FOLDER

@app.before_first_request
def activate_job():
    def run_job():
        w3.eth.enable_unaudited_features()
        we3 = Web3(HTTPProvider(app.config['PROVIDER']))
        we3.eth.enable_unaudited_features()
        we3.middleware_stack.inject(geth_poa_middleware, layer=0)

        file = open('contractdef.js',"r")
        abiData = json.loads(file.read())
        # print(abi)
        # contract = w3.eth.contract(abi=abi,address='0x3d430e234fab0619544f9eB891A30FE8241f18aa')
        # eathereumc = contract.at('0x3d430e234fab0619544f9eB891A30FE8241f18aa')
        contract_address = we3.toChecksumAddress(app.config['ETHEREUM_CONTRACT'])
        contract_instance = we3.eth.contract(contract_address,abi=abiData)
        # print(contract_instance.functions)
        # print (contract_instance.GetCountryPrice)
        # print(w3.version)

        #
        # res = contract_instance.functions.GetCountryPrice(_CR=bytes('MX','utf-8')).call();
        # print (res)
        # print(res)
        while True:
            try:
                res = contract_instance.functions.ReadyToSwitch().call();
            except:
                print("ReadyToSwitch problem")
                time.sleep(15)
                continue
            # print(res[0])
            # print('ReadyToSwitch value: {}'.format(res[0]));
            # # print('ReadyToSwitch value: {}'.format(res));
            if res[0]==False:
                print('Not ready yet', res[0], res[1])
            else:
                print('Ready',res[0])
                # print(we3.eth.getBalance('0x33F52bA16e21CB0FD0c9B9d428C3EC00c43Ca451'))
                we3.eth.setGasPriceStrategy(fast_gas_price_strategy)
                try:
                    egasprice = w3.fromWei(we3.eth.generateGasPrice(),"ether")
                except:
                    egasprice = 10
                    print("Failed to establish Gas Price")
                try:
                    nonce = we3.eth.getTransactionCount(we3.toChecksumAddress('0x5fbc8dB242257DCf8A0A57f026982256f6B3e0bE'))
                # try:
                except:
                    print("GetTransactionCount failed")
                try:
                    estimate = contract_instance.functions.ProtectedStateSwitch().estimateGas()
                    print("estimated gas",estimate)
                    print("Gas balance: ",we3.eth.getBalance('0x5fbc8dB242257DCf8A0A57f026982256f6B3e0bE'))
                    egasprice =  w3.toWei('10', 'gwei');
                    eprice = egasprice *estimate
                    print("Estimated price:",eprice )

                except:
                    print("Problem connecting to network")
                    estimate = 1000000000000000000000000
                    eprice = egasprice * estimate

                txn = contract_instance.functions.ProtectedStateSwitch().buildTransaction({
                'from':'0x5fbc8dB242257DCf8A0A57f026982256f6B3e0bE',
                'chainId':4,
                # 'networkId':4,
                'gas': estimate,
                'gasPrice': egasprice,
                'nonce': nonce,
                })
                # print(txn)
                private_key="e7ea1e49007cf978ea60ba32129a3b94efa8db1758dbacb8104161c54c829575"
                try:
                    signed_txn = we3.eth.account.signTransaction(txn, private_key=private_key)
                    print (signed_txn.rawTransaction)
                except:
                    print("Problem with SignTransaction")
                    continue

                tx = None
                # try:277abeac53c306a536e7b3aab0b16b1cea70bd234ba76c415fae3612d147b392
                # print(w)
                try:
                    tx = we3.eth.sendRawTransaction(signed_txn.rawTransaction)
                    print("Sending raw transaction.")
                except:
                    print("SendRawTransction problem")
                    time.sleep(10)
                    continue
                # except:
                    # print ("Transaction failed")
                    # print(signed_txn)


                receipt=None
                while receipt==None and tx !=None:
                    try:
                        receipt = we3.eth.getTransactionReceipt(tx)
                        tra = we3.eth.getTransaction(tx)
                        print (we3.toHex(tx),receipt)

                    except:
                        print("Connection problem. Can't check Transaction")
                        continue;
                    # print("Tra:",w3.toHex(tra))
                    time.sleep(3)


            time.sleep(3)

    thread = threading.Thread(target=run_job)
    thread.start()

@app.route('/')
def hello_world():
    return 'Hello, World!',200


@app.route("/getFlag",methods=['GET'])
def getFlag():
    print('GET FLAG')

    print(request)
    try:
        ccode = request.args['ccode']
    except:
        return "Parameter ccode is missing. Unable to return country flag picture.",406

    if (request.args['ccode'] != None):
        ccode = request.args['ccode']
        country = Countries.query.filter_by(ccode=ccode).first()
        if(country != None):
            if(country.flag_picture !=None):
                picData = BytesIO(country.flag_picture)
                return send_file(picData,mimetype='image')
                # return send_file(BytesIO(country.flag_picture),mimetype='image')
            else:
                return "There is no flag picture for this country",404
        else:
            return "Country doesn't exists",404
    else:
        return "Invalid query",406


@app.route("/getCountryPicture")
def getCountryPicture():
    print('GET FLAG')

    print(request)
    try:
        ccode = request.args['ccode']
    except:
        return "Parameter ccode is missing. Unable to return country picture.",406

    if (request.args['ccode'] != None):
        ccode = request.args['ccode']
        country = Countries.query.filter_by(ccode=ccode).first()
        if(country != None):
            if(country.country_picture !=None):
                picData = BytesIO(country.country_picture)
                # pic = Image.open(picData)

                # return base64.b64encode(country.country_picture)
                # return send_file(pic.tobytes,mimetype='image')
                return send_file(picData,mimetype='image')
                # return send_file(BytesIO(country.flag_picture),mimetype='image')
            else:
                return "There is no country picture for this country",404
        else:
            return "Country doesn't exists",404
    else:
        return "Invalid query",406

@app.route("/deleteCountry", methods=['GET'])
def deleteCountry():
    errCode = 0
    okCode = 0
    resultString = ''

    try:
        ccode = request.args['ccode']
    except:
        return "Ccode parameter is missing",404

    country = Countries.query.filter(Countries.ccode==ccode).first()

    if (country == None):
        print("Country doesn't exist in db")
        return 'No such country exist in database',404
    else:
        db.session.delete(country)
        db.session.commit()
        return "Country has been deleted",200

    # app.logger.debug("Inside add route")

    # print (json.dumps(data['cflag'].filename))
    # print json.dumps(data, sort_keys=True, indent=4)
    # print vars(data);
    # print request.form['ccode'];
    # print request.form['cflag'];
    # print request.files['cflag'].filename

@app.route("/NewCountry", methods = ['POST'])
def NewCountry():
    # print(request.method,request.text)
    errCode = 0
    okCode = 0
    resultString = ''

    dataIn = request.form
    if dataIn:

        # Get flag and country pictures file data and create their names. Files are saved
        #  with png extension and name is country's code - ccode.
        ccode = dataIn['ccode']
        country = Countries.query.filter(Countries.ccode==ccode).first()
        if(country != None):
            return "This country already exists in database. Change country code.",409


        cname = dataIn['cname']
        ccap = dataIn['ccap']
        clang = dataIn['clang']
        ccur = dataIn['ccur']
        if(dataIn['cpop']==''):
            cpop = 0
        else:
            cpop = dataIn['cpop']

        # cpop = int(float(dataIn['cpop']))
        cpres = dataIn['cpres']

        try:
            flagPicture = request.files['cflag'].read()
        except:
            print("Flag Picture wasn't sent")
            flagPicture=None

        try:
            countryPicture = request.files['cpic'].read()
        except:
            print("Country Picture wasn't sent")
            countryPicture = None

        country = Countries(cname,ccode, cpres, ccap, clang, cpop, ccur,flagPicture,countryPicture)
        try:
            db.session.add(country)
            db.session.commit()
        except:
            return "Internal server error. Couldn't insert new entry to database.",500
        # country = Countries()

        errCode = 0
        okCode = 201;
        resultString = 'Your Majesty Imperator: Central Spying Agency discovered new country - ' + dataIn['cname']
        return resultString, okCode

@app.route("/UpdateCountry", methods = ['POST'])
def UpdateCountry():
    print(request.method,request)
    errCode = 0
    okCode = 0
    resultString = ''

    dataIn = request.form
    print(dataIn)

    if (dataIn!=None):

        # Get flag and country pictures file data and create their names. Files are saved
        #  with png extension and name is country's code - ccode.
        cname = dataIn['cname']
        ccode = dataIn['ccode']
        ccap = dataIn['ccap']
        clang = dataIn['clang']
        ccur = dataIn['ccur']

        if(dataIn['cpop']==''):
            cpop = 0
        else:
            cpop = dataIn['cpop']

        cpres = dataIn['cpres']

        try:
            flagPicture = request.files['cflag'].read()
        except:
            print("Flag Picture wasn't sent")
            flagPicture=None

        try:
            countryPicture = request.files['cpic'].read()
        except:
            print("Country Picture wasn't sent")
            countryPicture = None


        country = Countries.query.filter(Countries.ccode==ccode).first()

        if (country == None):
            print("Country doesn't exist in db")
            return 'No such country exist in database',404
        else:
            country.cname = cname
            country.ccap = ccap
            country.clang = clang
            country.ccur = ccur
            country.cpop = cpop
            country.cpres = cpres
            if(flagPicture != None):
                country.flag_picture = flagPicture
            if(countryPicture != None):
                country.country_picture = countryPicture

            try:
                db.session.commit()
            except:
                return "Internal server error. Couldn't insert new entry to database.",500

            return "Country has been updated",200

    # app.logger.debug("Inside add route")

    # print (json.dumps(data['cflag'].filename))
    # print json.dumps(data, sort_keys=True, indent=4)
    # print vars(data);
    # print request.form['ccode'];
    # print request.form['cflag'];
    # print request.files['cflag'].filename

@app.route("/getCountries")
def getCountries():
    try:
        countries = Countries.query.with_entities(Countries.cname,Countries.ccode,Countries.cpres,Countries.clang,Countries.cpop,Countries.ccur).all()
    except:
        return "Internal server error. Couldn't connect to database server",500
    countries_schema = CountriesSchema(many=True)
    output = countries_schema.dump(countries).data
    return jsonify({'countries': output})

def start_runner():
    def start_loop():
        not_started = True
        r = ""
        while not_started:
            try:
                r = requests.get('http://127.0.0.1:5000/')
                if r.status_code == 200:
                    print('Server started, quiting start_loop')
                    not_started = False
                print(r.status_code)
            except:
                print(r.status_code)
                print('Server not yet started')
            time.sleep(2)

    print('Started runner')

        #
    thread = threading.Thread(target=start_loop)
    thread.start()



if __name__ == "__main__":
    start_runner()
    app.run(debug=True)

from flask import Flask, request,send_from_directory
from employee import Employee
import names
import threading
import requests
import time
import logging, os
import json
from flask_cors import CORS
from web3 import Web3, HTTPProvider
from web3.contract import ConciseContract
from web3.auto import w3
from web3.middleware import geth_poa_middleware
from web3.gas_strategies.time_based import fast_gas_price_strategy
from eth_account import Account

app = Flask(__name__)
app.logger.setLevel(logging.DEBUG)
CORS(app)
PROJECT_HOME = os.path.dirname(os.path.realpath(__file__))
FLAGS_IMG_FOLDER = '{}/img/flags/'.format(PROJECT_HOME)
COUNTRY_IMG_FOLDER = '{}/img/Countries/'.format(PROJECT_HOME)
app.config['COUNTRY_IMG_FOLDER'] = COUNTRY_IMG_FOLDER
app.config['FLAGS_IMG_FOLDER'] = FLAGS_IMG_FOLDER

@app.before_first_request
def activate_job():
    def run_job():
        w3.eth.enable_unaudited_features()
        # we3 = Web3(HTTPProvider('https://rinkeby.infura.io/FiZkooYHIsk3keP6qjT7'))
        we3 = Web3(HTTPProvider('http://localhost:8545'))
        we3.eth.enable_unaudited_features()
        we3.middleware_stack.inject(geth_poa_middleware, layer=0)

        file = open('aegisdef.js',"r")
        abiData = json.loads(file.read())
        # print(abi)
        # contract = w3.eth.contract(abi=abi,address='0x3d430e234fab0619544f9eB891A30FE8241f18aa')
        # eathereumc = contract.at('0x3d430e234fab0619544f9eB891A30FE8241f18aa')
        contract_address = we3.toChecksumAddress("0xd4831401b2af032b487c8133dffe0a970d84a2cc")
        contract_instance = we3.eth.contract(contract_address,abi=abiData)
        # print(contract_instance.functions)
        # print (contract_instance.GetCountryPrice)
        # print(w3.version)

        #
        # res = contract_instance.functions.GetCountryPrice(_CR=bytes('MX','utf-8')).call();
        # print (res)
        # print(res)
        while True:
            res = contract_instance.functions.GetBalanceTest().call();

            try:
                res = contract_instance.functions.GetBalanceTest().call();
            except:
                print("GetBalanceTest problem")
                time.sleep(5)
                continue

            print (res);

    thread = threading.Thread(target=run_job)
    thread.start()

@app.route('/')
def hello_world():
    return 'Hello, World!',200


@app.route("/getFlag")
def getFlag():
    if request.method == 'GET' and request.args['ccode']:
        img = request.args['ccode']+".png";
        app.logger.info(img)
        app.logger.info(PROJECT_HOME)
        # return (PROJECT_HOME)
        return send_from_directory(app.config['FLAGS_IMG_FOLDER'],img,as_attachment=False),200

@app.route("/getCountryPicture")
def getCountryPicture():
    if request.method == 'GET' and request.args['ccode']:
        img = request.args['ccode']+".png";
        app.logger.info(img)
        app.logger.info(PROJECT_HOME)
        # return (PROJECT_HOME)
        return send_from_directory(app.config['COUNTRY_IMG_FOLDER'],img,as_attachment=False),200


@app.route("/deleteCountry", methods=['GET'])
def deleteCountry():
    errCode = 0
    okCode = 0
    resultString = ''

    countryCode = request.args.get('ccode')
    if countryCode:
        # Read country data from the file.
        file = open('countries.json',"r")
        data = json.load(file)
        file.close();
        countryExist=False
        for k,v in enumerate(data):
            print (json.dumps(data[k]['ccode']))
            if countryCode == data[k]['ccode']:
                countryExist=True
                print ("{} exist in the database. So I can delete it !!!".format(countryCode))
                data.pop(k)

                file = open('countries.json',"wb")
                json.dump(data,file)
                file.close()

                errCode = 0
                okCode = 200;
                resultString = 'Country {} has been deleted.'.format(countryCode)

                return resultString, okCode
                break

        if not countryExist:
            errCode = 404
            resultString = 'Country {} doesn\'t exist in database'.format(countryCode)
            return resultString,errCode


@app.route("/NewCountry", methods = ['POST'])
def NewCountry():
    # print(request.method,request.text)
    errCode = 0
    okCode = 0
    resultString = ''

    dataIn = request.form
    if dataIn:

        # Read country data from the file.
        file = open('countries.json',"r")
        data = json.load(file)
        file.close();
        # Check if country with this code already exist in the file.
        countryExist=False
        for k,v in enumerate(data):
            print (json.dumps(data[k]['ccode']))
            if dataIn['ccode'] == data[k]['ccode']:
                countryExist=True
                print ("{} already exist in the database".format(dataIn['ccode']))
                errCode = 409
                okCode = 0;
                resultString = 'Country already exist in database. Please change country code.'
                return resultString, errCode
                break

        # Country wasn't found and can be addded to the file.
        if not countryExist:
            # Add new data to old data.
            data.append(dataIn)

            # Get flag and country pictures file data and create their names. Files are saved
            #  with png extension and name is country's code - ccode.
            flagImage = request.files['cflag']
            countryImage = request.files['cpic']
            flagImageName = dataIn['ccode']+".png"
            countryImageName = dataIn['ccode']+".png"
            savedPathFlag = os.path.join(app.config['FLAGS_IMG_FOLDER'],flagImageName)
            savedPathCountry = os.path.join(app.config['COUNTRY_IMG_FOLDER'],countryImageName)
            flagImage.save(savedPathFlag)
            countryImage.save(savedPathCountry)
            file = open('countries.json',"w")
            json.dump(data,file)
            file.close()

            errCode = 0
            okCode = 201;
            resultString = 'Your Majesty Imperator: Central Spying Agency discovered new country - ' + dataIn['cname']
            return resultString, okCode

@app.route("/UpdateCountry", methods = ['POST'])
def UpdateCountry():
    # print(request.method,request.text)
    errCode = 0
    okCode = 0
    resultString = ''
    app.logger.debug("Request Params: {}".format(request))
    app.logger.debug("Values: {}".format(request.values))
    app.logger.debug("Form: {}".format(request.form))
    app.logger.debug("Files: {}".format(request.files))

    dataIn = request.form
    if dataIn:
        # Read country data from the file.
        file = open('countries.json',"r")
        data = json.load(file)
        file.close();
        # Check if country with this code already exist in the file.
        print (json.dumps(dataIn))
        print (json.dumps(request.values))

        countryExist=False
        for k,v in enumerate(data):
            print (json.dumps(data[k]['ccode']))
            if dataIn['ccode'] == data[k]['ccode']:
                countryExist=True
                print ("{}  exist in the database.Can Update. So Great. ".format(dataIn['ccode']))
                data[k]['cname']=dataIn['cname']
                data[k]['ccode']=dataIn['ccode']
                data[k]['ccap']=dataIn['ccap']
                data[k]['clang']=dataIn['clang']
                data[k]['ccur']=dataIn['ccur']
                data[k]['cpop']=dataIn['cpop']
                data[k]['cpres']=dataIn['cpres']
                file = open('countries.json',"w")
                json.dump(data,file)
                file.close()
                print('Updated {} country information'.format(dataIn['ccode']))

                try:
                # print request.files['cflag'].filename

                    if request.files:
                        print (vars(request.files))
                        if request.method == 'POST' and 'cflag' in request.files:
                            flagImage = request.files['cflag']
                            flagImageName = dataIn['ccode']+".png"
                            savedPathFlag = os.path.join(app.config['FLAGS_IMG_FOLDER'],flagImageName)
                            flagImage.save(savedPathFlag)
                            print("Save Flag File {}".format(savedPathFlag))

                            # print flagImage.filename
                        if request.method == 'POST' and 'cpic' in request.files:
                            countryImage = request.files['cpic']
                            countryImageName = dataIn['ccode']+".png"
                            savedPathCountry = os.path.join(app.config['COUNTRY_IMG_FOLDER'],countryImageName)
                            countryImage.save(savedPathCountry)
                            print("Save Country File {}".format(savedPathCountry))
                    errCode = 0
                    okCode = 200
                    resultString = '{} has been updated.'.format(dataIn['ccode'])
                    return resultString, okCode
                        # return "OK"
                except:
                    return "ERR",400

                break

        # Country wasn't found and can be addded to the file.
        if not countryExist:


            errCode = 404
            okCode = 0;
            resultString = '{} doesn\'t exist in database.'.format(dataIn['ccode'])
            return resultString, errCode
    # app.logger.debug("Inside add route")

    # print (json.dumps(data['cflag'].filename))
    # print json.dumps(data, sort_keys=True, indent=4)
    # print vars(data);
    # print request.form['ccode'];
    # print request.form['cflag'];
    # print request.files['cflag'].filename

@app.route("/getCountries")
def getCountries():
    fp = open('countries.json',"r+")
    data = json.load(fp)
    # for k,v in enumerate(data):
        # print json.dumps(data[k]['ccode'])

    return json.dumps(data),200


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
    thread = threading.Thread(target=start_loop)
    thread.start()



if __name__ == "__main__":
    start_runner()
    app.run(debug=True)

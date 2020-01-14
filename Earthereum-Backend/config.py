import os
basedir = os.path.abspath(os.path.dirname(__file__))

class Config(object):
    DEBUG = False
    TESTING = False
    CSRF_ENABLED = True
    SECRET_KEY = 'this-really-needs-to-be-changed'
    SQLALCHEMY_DATABASE_URI = os.environ['DATABASE_URL']
    ETHEREUM_CONTRACT = os.environ['ETHEREUM_CONTRACT']

    # SQLALCHEMY_DATABASE_URI ='postgresql://localhost/earthereum2'

class ProductionConfig(Config):
    DEBUG = False
    PROVIDER = 'https://rinkeby.infura.io/FiZkooYHIsk3keP6qjT7'



class StagingConfig(Config):
    DEVELOPMENT = True
    DEBUG = True


class DevelopmentConfig(Config):
    DEVELOPMENT = True
    DEBUG = True
    PROVIDER = 'http://localhost:8545'
    ETHEREUM_CONTRACT = '0x7FF316fb41eBE6AE984dA893CBA4fda28214590A'


class TestingConfig(Config):
    TESTING = True

from app import db
from sqlalchemy.dialects.postgresql import JSON
from sqlalchemy.dialects.postgresql import BYTEA
from sqlalchemy.dialects.mysql import BIGINT


#

class Countries(db.Model):
        __tablename__='countries'

        id = db.Column(db.Integer, primary_key=True)
        cname = db.Column(db.String())
        flag_picture = db.Column(BYTEA)
        country_picture = db.Column(BYTEA)
        ccode = db.Column(db.String,nullable=False,unique=True)
        cpres = db.Column(db.String)
        ccap = db.Column(db.String)
        clang = db.Column(db.String)
        cpop = db.Column(BIGINT)
        ccur = db.Column(db.String)

        def __init__(self, cname, ccode, cpres,ccap, clang, cpop, ccur, flag_picture, country_picture):
            self.cname = cname
            self.flag_picture = flag_picture
            self.country_picture = country_picture
            self.ccode = ccode
            self.cpres = cpres
            self.clang = clang
            self.cpop = cpop
            self.ccur = ccur

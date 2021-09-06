import bson

#método para gerar automaticamente um identificador em python no mongo db
def get_unique_id():
    return bson.objectid.ObjectId()
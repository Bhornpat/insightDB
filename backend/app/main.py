from fastapi import FastAPI
from app import db
from bson import ObjectId
from pydantic import BaseModel
from datetime import date

app = FastAPI()

class CustomerIn(BaseModel):
    name: str
    email: str

@app.post("/customers/")
async def create_customer(customer: CustomerIn):
    result = await db.customers.insert_one(customer.dict())
    return {"id": str(result.inserted_id)}

@app.get("/customers/")
async def list_customers():
    docs = await db.customers.find().to_list(100)
    return [{**doc, "_id": str(doc["_id"])} for doc in docs]


from fastapi import FastAPI
from bson import ObjectId
from app import db, models

app = FastAPI()

@app.post("/customers/")
async def create_customer(customer: models.CustomerIn):
    result = await db.customers.insert_one(customer.dict())
    return {"id": str(result.inserted_id)}

@app.get("/customers/")
async def list_customers():
    data = await db.customers.find().to_list(100)
    return [{**doc, "_id": str(doc["_id"])} for doc in data]

@app.post("/movies/")
async def create_movie(movie: models.MovieIn):
    result = await db.movies.insert_one(movie.dict())
    return {"id": str(result.inserted_id)}

@app.post("/rentals/")
async def rent_movie(rental: models.RentalIn):
    data = rental.dict()
    data["customer_id"] = ObjectId(data["customer_id"])
    data["movie_id"] = ObjectId(data["movie_id"])
    result = await db.rentals.insert_one(data)
    return {"id": str(result.inserted_id)}


from motor.motor_asyncio import AsyncIOMotorClient

client = AsyncIOMotorClient("mongodb://localhost:27017")
db = client["moviedb"]

customers = db["customers"]
movies = db["movies"]
rentals = db["rentals"]


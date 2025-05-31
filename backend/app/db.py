from motor.motor_asyncio import AsyncIOMotorClient

MONGO_URI = "mongodb://mongo_admin:mongo_pass@localhost:27017/?authSource=admin"

client = AsyncIOMotorClient(MONGO_URI)
db = client["movie_admin"]

customers = db["customers"]
movies = db["movies"]
rentals = db["rentals"]


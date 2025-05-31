from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import date

class CustomerIn(BaseModel):
    name: str
    email: EmailStr

class MovieIn(BaseModel):
    title: str
    genre: Optional[str]
    available_copies: int

class RentalIn(BaseModel):
    customer_id: str
    movie_id: str
    rent_date: Optional[date]
    return_date: Optional[date]


from fastapi import FastAPI, HTTPException
from config import *

app = FastAPI()

@app.get("/")
async def root():
    firebase_message = "Firebase error"
    cloudinary_message = "Cloudinary error"
    
    try:
        # Firebase 
        db = initialize_firebase()
        firebase_message = "Firebase Connected!"
    except Exception as e:
        firebase_message = f"Firebase error: {e}"

    try:
        # Cloudinary
        initialize_cloudinary()
        cloudinary_message = "Cloudinary Connected!"
    except Exception as e:
        cloudinary_message = f"Cloudinary error: {e}"
    
    return {
        "firebase_message": firebase_message,
        "cloudinary_message": cloudinary_message
    }

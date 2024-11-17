import firebase_admin
from firebase_admin import credentials, firestore
from fastapi import HTTPException
from dotenv import load_dotenv
import cloudinary
import cloudinary.uploader
import os

load_dotenv()

def initialize_firebase():
    try:
       
        firebase_cred_path = os.getenv('FIREBASE_CREDENTIALS_PATH')

        if not firebase_cred_path:
            raise HTTPException(status_code=500, detail="Firebase credentials are missing")
        
        if not firebase_admin._apps:
            cred = credentials.Certificate(firebase_cred_path)
            firebase_admin.initialize_app(cred)
        
        db = firestore.client()
        return db 
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error: {e}")

def initialize_cloudinary():
    try:
        
        cloud_name = os.getenv('CLOUDINARY_CLOUD_NAME')
        api_key = os.getenv('CLOUDINARY_API_KEY')
        api_secret = os.getenv('CLOUDINARY_API_SECRET')

        if not cloud_name or not api_key or not api_secret:
            raise HTTPException(status_code=500, detail="Cloudinary credentials are missing.")
        
        
        cloudinary.config(
            cloud_name=cloud_name,
            api_key=api_key,
            api_secret=api_secret
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error: {e}")
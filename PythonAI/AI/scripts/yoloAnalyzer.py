import numpy as np
from ultralytics import YOLO
import cv2
import cvzone

cap = cv2.VideoCapture("../Videos/cars.mp4")
model = YOLO("yolov8l.pt")


def parseData(data):
    nparr = np.frombuffer(data, np.uint8)
    image = cv2.imdecode(nparr, cv2.IMREAD_COLOR)

    if image is None:
        raise ValueError("Image decoding failed.")
    results = model(image, stream=True)
    cv2.imshow("Image", image)
    return True
import numpy as np
from ultralytics import YOLO
import cv2
import cvzone

# Load the YOLO model
# model = YOLO("yolov8m.pt")
model = YOLO("customModel(25iulie).pt")
classNames = ["car", "numberplate"]
bestCroppedPlate = {}

def parseData(data1, data2):
    nparr1 = np.frombuffer(data1, np.uint8)
    image1 = cv2.imdecode(nparr1, cv2.IMREAD_UNCHANGED)

    nparr2 = np.frombuffer(data2, np.uint8)
    image2 = cv2.imdecode(nparr2, cv2.IMREAD_UNCHANGED)

    # Check if the image has an alpha channel
    if image1.shape[2] == 4:
        image1 = cv2.cvtColor(image1, cv2.COLOR_BGRA2BGR)

    if image2.shape[2] == 4:
        image2 = cv2.cvtColor(image2, cv2.COLOR_BGRA2BGR)

    results1 = model(image1, stream=True)
    results2 = model(image2, stream=True)

    # Draw the bounding boxes on the images
    for result1 in results1:
        for box1 in result1.boxes:
            x1, y1, x2, y2 = box1.xyxy[0]
            x1, y1, x2, y2 = int(x1), int(y1), int(x2), int(y2)
            confidence = round(float(box1.conf[0]), 2)
            cls = int(box1.cls[0])

            cv2.rectangle(image1, (x1, y1), (x2, y2), (0, 255, 0))

            if classNames[cls] == 'numberplate':
                cropped_plate = image1[y1:y2, x1:x2]
                

            else:
                cvzone.putTextRect(image1, f'Confidence: {confidence} {classNames[cls]}', (x1, y1), scale=1, thickness=1)





    for result2 in results2:
        for box2 in result2.boxes:
            x1, y1, x2, y2 = box2.xyxy[0]
            x1, y1, x2, y2 = int(x1), int(y1), int(x2), int(y2)
            confidence = round(float(box2.conf[0]), 2)
            cls = int(box2.cls[0])

            cvzone.putTextRect(image2, f'Confidence: {confidence} {classNames[cls]}', (x1, y1), scale=1, thickness=1)
            cv2.rectangle(image2, (x1, y1), (x2, y2), (0, 255, 0))

    # Display the images in separate windows
    #cv2.imshow("Image1", image1)
    #cv2.imshow("Image2", image2)
    #cv2.waitKey(0)
    #cv2.destroyAllWindows()
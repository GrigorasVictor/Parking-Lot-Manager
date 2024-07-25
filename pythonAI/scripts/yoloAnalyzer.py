import numpy as np
from ultralytics import YOLO
import cv2
import cvzone

# Load the YOLO model
#model = YOLO("yolov8m.pt")
model = YOLO("customModel(25iulie).pt")

classNames = ["car", "numberplate"]
def parseData(data):
    nparr = np.frombuffer(data, np.uint8)
    image = cv2.imdecode(nparr, cv2.IMREAD_UNCHANGED)

    # Check if the image has an alpha channel
    if image.shape[2] == 4:
        image = cv2.cvtColor(image, cv2.COLOR_BGRA2BGR)

    results = model(image, stream=True)

    # Draw the bounding boxes on the image
    for result in results:
        for box in result.boxes:
            x1, y1, x2, y2 = box.xyxy[0]
            x1, y1, x2, y2 = int(x1), int(y1), int(x2), int(y2)
            confidence = round(float(box.conf[0]), 2)
            cls = int(box.cls[0])

            cvzone.putTextRect(image, f'Confidence: {confidence} {classNames[cls]}', (x1, y1), scale=1, thickness=1)
            cv2.rectangle(image, (x1, y1), (x2, y2), (0, 255, 0))

    # Display the image using OpenCV
    cv2.imshow("Image", image)
    #cv2.waitKey(0)
    cv2.destroyAllWindows()

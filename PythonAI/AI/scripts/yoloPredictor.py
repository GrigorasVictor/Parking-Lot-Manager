from ultralytics import YOLO

# Load a model
model = YOLO("yolov8n.pt")  # pretrained YOLOv8n model
# print(model.names)

# Run batched inference on a list of images
# results = model("bus.jpg")  # return a list of Results objects

result = model.predict("bus.png", conf=0.7)[0]
result.show()

for box in result.boxes:
    if(box.cls[0] == 0): print("la " + str(box.xyxy) + " e om")
    else: print("la " + str(box.xyxy) + "  nu  e om")


















# Process results list
def processResults(results):
    for result in results:
        boxes = result.boxes  # Boxes object for bounding box outputs
        masks = result.masks  # Masks object for segmentation masks outputs
        keypoints = result.keypoints  # Keypoints object for pose outputs
        probs = result.probs  # Probs object for classification outputs
        obb = result.obb  # Oriented boxes object for OBB outputs
        result.show()  # display to screen
        # result.save(filename="result.jpg")  # save to disk

# processResults(results)
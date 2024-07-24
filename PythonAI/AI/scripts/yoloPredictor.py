from ultralytics import YOLO

# Load a model
model = YOLO("yolov8x.pt")  # pretrained YOLOv8n model
print(model.names)

# Run batched inference on a list of images
# results = model("bus.jpg")  # return a list of Results objects

# results = model.predict("bus.jpg", conf=0.7, classes = 0)
# results[0].show()


















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
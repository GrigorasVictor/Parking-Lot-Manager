if __name__ == "__main__":
    from ultralytics import YOLO
    import torch

    # Clear CUDA cache
    torch.cuda.empty_cache()

    model = YOLO('yolov8m.pt')
    results = model.train(data="trainingModel.yaml", epochs=20, batch=3)
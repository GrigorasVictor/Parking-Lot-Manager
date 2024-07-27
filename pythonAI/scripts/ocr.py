import warnings
warnings.simplefilter(action='ignore', category=FutureWarning)
import easyocr

reader = easyocr.Reader(['en']) # specify the language  


def parseNumPlate(encodedCroppedPlate):
    result = reader.readtext(encodedCroppedPlate)

    returnString = ""
    for (bbox, text, prob) in result:
        returnString += text
        # print(f'Text: {text}, Probability: {prob}')
    return returnString
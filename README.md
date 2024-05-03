# Interaction Recorder and Animator

https://github.com/KamilBourouiba/interakt/assets/107642625/aa7af66a-bb78-4d63-8689-b822f7743adb

This project consists of two parts:

1. **Interaction Recorder:** A SwiftUI app that records user interactions (taps and drags) on an iPhone screen and saves them to a JSON file.
2. **Interaction Animator:** A Python script that reads the recorded interactions from the JSON file and animates them to create a video representation of the user's actions on the screen.

## Interaction Recorder (SwiftUI App)

### Description
The Interaction Recorder app allows users to interact with the screen by tapping or dragging. It records these interactions along with their timestamps and positions and saves them to a JSON file upon exiting the app.

### Usage
1. Open the app on an iPhone device.
2. Interact with the screen by tapping or dragging.
3. The app records these interactions and saves them to a JSON file upon exiting.

### File Location
The recorded interactions are saved to the device's Documents directory.

## Interaction Animator (Python Script)

### Description
The Interaction Animator Python script reads the recorded interactions from the JSON file and animates them to create a video representation of the user's actions on the screen.

### Usage
1. Run the Python script providing the path to the recorded interactions JSON file.
2. The script will generate a video file representing the user's interactions.

### Requirements
- Python 3.x
- Matplotlib library

## Example Usage
```bash
python animate_interactions.py interactions.json output_video.mp4
```


# Interaction Recorder and Animator

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
File Location
The output video file will be saved to the same directory as the Python script.

Sample Output
Link to sample video

You can copy and paste this content into your README.md file. Let me know if you need any further assistance!

vbnet
Copy code

You can copy this entire block and paste it into your README.md file. Let me know if you need further assistance!
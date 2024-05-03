import json
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
from datetime import datetime, timedelta

# Load interactions from JSON file
def load_interactions(file_path):
    with open(file_path, 'r') as f:
        interactions = json.load(f)
    return interactions

# Animate interactions and save as video
def animate_interactions(interactions, output_file):
    fig, ax = plt.subplots(figsize=(3, 6))  # Adjust figsize to match iPhone screen aspect ratio
    start_time = interactions[0]['timestamp']
    end_time = interactions[-1]['timestamp']
    time_window = 0.1  # Time window for displaying interactions (0.1 seconds)

    def update(frame):
        ax.clear()
        ax.set_xlim(0, 375)  # iPhone screen width
        ax.set_ylim(0, 812)  # iPhone screen height
        ax.set_aspect('equal')
        ax.set_title('Screen Interactions')

        current_time = start_time + (frame / len(interactions)) * (end_time - start_time)
        interactions_to_display = [interaction for interaction in interactions if current_time - interaction['timestamp'] <= time_window and current_time >= interaction['timestamp']]

        for interaction in interactions_to_display:
            x, y = interaction['position']
            action = interaction['action']
            alpha = max(0, min(1, (current_time - interaction['timestamp']) / time_window))  # Calculate alpha (transparency)
            if action == 'tap':
                ax.scatter(x, y, color='blue', alpha=1-alpha, label='Tap')
            elif action == 'drag':
                ax.scatter(x, y, color='red', alpha=1-alpha, label='Drag')

    ani = FuncAnimation(fig, update, frames=len(interactions), interval=1000*(end_time - start_time)/len(interactions))
    ani.save(output_file, writer='ffmpeg', fps=10)  # Adjust fps as needed

if __name__ == "__main__":
    file_path = "1714770462_interactions.json"  # Update with your file path
    output_file = "output_video.mp4"  # Update with desired output file name
    interactions = load_interactions(file_path)
    animate_interactions(interactions, output_file)

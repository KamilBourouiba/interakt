//
//  ContentView.swift
//  Interakt
//
//  Created by Bourouiba Kamil on 03/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var interactions: [Interaction] = []
    @State private var lastInteractionTime: Date?
    @State private var isRecording = true

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                if value.startLocation == value.location {
                                    // It's a tap gesture
                                    recordInteraction(action: .tap, location: value.startLocation)
                                } else {
                                    // It's a drag gesture
                                    recordDrag(value: value)
                                }
                            }
                    )
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .onReceive(Timer.publish(every: 1, on: .main, in: .default).autoconnect(), perform: { _ in
            checkAndSaveFileIfNeeded()
        })
    }

    private func recordDrag(value: DragGesture.Value) {
        guard isRecording else { return }
        let location = value.location
        let startPoint = value.startLocation
        let endPoint = value.location
        let duration = Date().timeIntervalSinceReferenceDate - value.time.timeIntervalSinceReferenceDate
        recordInteraction(action: .drag, location: location, startPoint: startPoint, endPoint: endPoint, duration: duration)
    }

    private func recordInteraction(action: Interaction.ActionType, location: CGPoint, startPoint: CGPoint? = nil, endPoint: CGPoint? = nil, duration: TimeInterval? = nil) {
        guard isRecording else { return }
        let interaction = Interaction(action: action, timestamp: Date().timeIntervalSinceReferenceDate, position: location, startPoint: startPoint, endPoint: endPoint, duration: duration)
        interactions.append(interaction)
        lastInteractionTime = Date()
        printInteraction(interaction)
    }

    private func checkAndSaveFileIfNeeded() {
        guard let lastInteractionTime = lastInteractionTime, isRecording else {
            // No interactions recorded yet or recording stopped
            return
        }
        
        let currentTime = Date()
        let timeElapsed = currentTime.timeIntervalSince(lastInteractionTime)
        
        if timeElapsed >= 10 {
            saveInteractionsToFile()
            isRecording = false // Stop recording interactions
        }
    }

    private func saveInteractionsToFile() {
        // Convert interactions to JSON data and save to file
        do {
            let jsonData = try JSONEncoder().encode(interactions)
            let timestamp = Int(Date().timeIntervalSince1970)
            let fileName = "\(timestamp)_interactions.json"
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            try jsonData.write(to: fileURL)
            print("Interactions saved to file: \(fileURL)")
            print("Timestamp: \(timestamp)")
        } catch {
            print("Error saving interactions: \(error)")
        }
    }

    private func printInteraction(_ interaction: Interaction) {
        print("Interaction: \(interaction.action.rawValue) - Timestamp: \(interaction.timestamp) - Position: \(interaction.position)")
    }
}

struct Interaction: Codable {
    enum ActionType: String, Codable {
        case tap
        case drag
    }
    
    let action: ActionType
    let timestamp: TimeInterval
    let position: CGPoint
    let startPoint: CGPoint?
    let endPoint: CGPoint?
    let duration: TimeInterval?
}


#Preview {
    ContentView()
}

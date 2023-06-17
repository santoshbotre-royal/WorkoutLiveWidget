//
//  ContentView.swift
//  WorkoutLiveWidgetPOC
//
//  Created by santoshbo on 14/06/23.
//

import SwiftUI
import ActivityKit

enum WorkoutStatus {
  case InProgress
  case Stopped
  case NotDetermined
  
  var workoutStatus : String {
    switch self {
    case .InProgress:
      "User is working out..."
    case .Stopped:
      "User has stopped the workout..."
    case .NotDetermined:
      "Not Determined..."
    }
  }
  
  var color : Color {
    switch self {
    case .InProgress:
      .green
    case .Stopped:
      .blue
    case .NotDetermined:
      .gray
    }
  }
}
struct ContentView: View {
  
  @State private var selectedActivity = Workout.Aerobics
  @State private var workoutViewModel = WorkoutViewModel()
  @State private var currentActivityStatus: WorkoutStatus = .NotDetermined
  
  var body: some View {
    VStack {
      Picker("What activity you want to start?", selection: $selectedActivity) {
        Text(Workout.Aerobics.workoutName).tag(Workout.Aerobics)
        Text(Workout.Jogging.workoutName).tag(Workout.Jogging)
        Text(Workout.Yoga.workoutName).tag(Workout.Yoga)
      }
      .pickerStyle(.segmented)
      .padding()
      
      GenericButton(title: "START", tint: .green, action: {
        print(selectedActivity)
        workoutViewModel.startWorkout(workout: selectedActivity)
        workoutViewModel.keepTrackOfWorkoutUpdates()
        currentActivityStatus = .InProgress
      })
      
      GenericButton(title: "STOP", tint: .red, action: {
        workoutViewModel.endWorkout()
        currentActivityStatus = .Stopped
      })
      
      Text("\(currentActivityStatus.workoutStatus)")
        .font(.title3)
        .foregroundColor(currentActivityStatus.color)
        .padding()
      
    }
    .onOpenURL { (url) in
      print(url)
      if url.absoluteString.hasPrefix("workout://stop") {
        workoutViewModel.endWorkout()
        currentActivityStatus = .Stopped
      } 
    }.onAppear {
      if workoutViewModel.anyWorkoutInProgress() {
        currentActivityStatus = .InProgress
      }
    }
  }
  
  struct GenericButton: View {
    var title: String
    var tint: Color
    var action: () async -> ()
    
    var body: some View {
      Button(action: {
        Task {
          await action()
        }
      }, label: {
        Text(title)
          .bold()
          .font(.caption)
      })
      .buttonStyle(.borderedProminent)
      .tint(tint)
    }
  }
}
  
#Preview {
    ContentView()
}

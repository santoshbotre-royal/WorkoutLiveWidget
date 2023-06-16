//
//  ContentView.swift
//  WorkoutLiveWidgetPOC
//
//  Created by santoshbo on 14/06/23.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
  
  @State private var selectedActivity = Workout.Aerobics
  @State private var workoutViewModel = WorkoutViewModel()
  
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
      })
      
      GenericButton(title: "STOP", tint: .red, action: {
        workoutViewModel.endWorkout()
      })
      
    }
    .onOpenURL { (url) in
      print(url)
      workoutViewModel.endWorkout()
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

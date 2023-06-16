//
//  WorkoutViewModel.swift
//  WorkoutLiveWidgetPOC
//
//  Created by santoshbo on 16/06/23.
//

import Foundation
import ActivityKit

class WorkoutViewModel {
  func startWorkout(workout: Workout) {

    if ActivityAuthorizationInfo().areActivitiesEnabled {
      // Duration
      var future = Calendar.current.date(byAdding: .minute, value: 1, to: Date())!
      future = Calendar.current.date(byAdding: .second, value: 10, to: future)!
      let date = Date.now...future
      
      // Content State
      let initialContentState = WorkoutWidgetAttributes.ContentState(workoutTimer:date)
      // Fixed Attributes
      let activityAttributes = WorkoutWidgetAttributes(workout: workout)
        
      let activityContent = ActivityContent(state: initialContentState, staleDate: Calendar.current.date(byAdding: .minute, value: 1, to: Date())!)
      
      do {
        _ = try Activity.request(attributes: activityAttributes, content: activityContent)
        print("Requested Workout Live Activity \(String(describing:workout.workoutName)).")
      } catch (let error) {
        print("Error requesting workout Live Activity \(error.localizedDescription).")
      }
    } else {
      // In case, the user chooses the "Don't Allow" option 1st time.
      // After we start the workout activity and lock the phone.
      print("Error requesting workout Live Activity.")
    }
  }
  
  func endWorkout() {

    let finalActivityStatus = WorkoutWidgetAttributes.ContentState(workoutTimer: Date.now...Date())
    let finalContent = ActivityContent(state: finalActivityStatus, staleDate: nil)

    Task {
        for activity in Activity<WorkoutWidgetAttributes>.activities {
          await activity.end(finalContent, dismissalPolicy: .immediate)
            print("Ending the Live Activity: \(activity.id)")
        }
    }
  }
  
  func keepTrackOfWorkoutUpdates() {
    Task {
      // Observe updates for ongoing Live Activities.
      for await activity in Activity<WorkoutWidgetAttributes>.activityUpdates {
          print("Workout details: \(activity.attributes)")
      }
    }
  }
}


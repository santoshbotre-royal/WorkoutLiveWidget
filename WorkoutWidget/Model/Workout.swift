//
//  Workout.swift
//  WorkoutLiveWidgetPOC
//
//  Created by santoshbo on 16/06/23.
//

import Foundation

enum Workout: Int, Codable {
  case Jogging = 0
  case Aerobics = 1
  case Yoga = 2
  
  // Workout Icon
  var workoutIcon: String {
    switch self {
    case .Jogging:
      "figure.run"
    case .Aerobics:
      "figure.dance"
    case .Yoga:
      "figure.yoga"
    }
  }
  
  // Workout name
  var workoutName: String {
    switch self {
    case .Jogging:
      "Jogging"
    case .Aerobics:
      "Aerobics"
    case .Yoga:
      "Yoga"
    }
  }
}

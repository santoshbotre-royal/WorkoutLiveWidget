//
//  LockScreenWorkoutLiveActivityView.swift
//  WorkoutWidgetExtension
//
//  Created by santoshbo on 16/06/23.
//

import SwiftUI
import ActivityKit
import WidgetKit

struct LockScreenWorkoutLiveActivityView: View {
  let context: ActivityViewContext<WorkoutWidgetAttributes>
  
  var body: some View {
    VStack {
      HStack(alignment: .center){
        ZStack {
          HStack(alignment: .center) {
            Text("\(context.attributes.workout.workoutName)")
              .font(.custom("Georgia", size: 24, relativeTo: .headline))
              .italic()
              .fontWeight(.bold)
              .foregroundColor(.black)
              .padding()
          }
        }
        
        VStack {
          Text(timerInterval: context.state.workoutTimer, countsDown: true)
            .multilineTextAlignment(.center)
            .monospacedDigit()
            .font(.title)
        }
        
        Image(systemName: context.attributes.workout.workoutIcon)
          .font(.title2)
          .foregroundColor(.black)
          .padding()
        
        Spacer()
      }
      
      Text("Keep it going!!!")
        .font(.custom("Georgia", size: 14, relativeTo: .headline))
        .italic()
        .foregroundColor(.accentColor)
        .padding()
    }
  }
}


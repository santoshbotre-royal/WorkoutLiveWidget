//
//  WorkoutWidgetLiveActivity.swift
//  WorkoutWidget
//
//  Created by santoshbo on 14/06/23.
//

import ActivityKit
import WidgetKit
import SwiftUI



struct WorkoutWidgetAttributes: ActivityAttributes {
  public struct ContentState: Codable, Hashable {
    // Dynamic stateful properties about your activity go here!
    var workoutTimer: ClosedRange<Date>
  }

  // Fixed non-changing properties about your activity go here!
  var workout: Workout
}

struct WorkoutWidgetLiveActivity: Widget {
  var body: some WidgetConfiguration {
    ActivityConfiguration(for: WorkoutWidgetAttributes.self) { context in
      // Lock screen/banner UI goes here
      LockScreenWorkoutLiveActivityView(context: context)
        .activitySystemActionForegroundColor(Color.white)
        .activityBackgroundTint(Color.cyan)
  } dynamicIsland: { context in
    DynamicIsland {
      /// Leading - Workout Icon
      DynamicIslandExpandedRegion(.leading) {
        Image(systemName: context.attributes.workout.workoutIcon)
          .foregroundColor(.indigo)
          .font(.title2)
      }
      /// Trailing - Countdown timer
      DynamicIslandExpandedRegion(.trailing) {
        Label {
          Text(timerInterval: context.state.workoutTimer, countsDown: true)
              .multilineTextAlignment(.trailing)
              .frame(width: 50)
              .monospacedDigit()
        } icon: {
            Image(systemName: "timer")
                .foregroundColor(.indigo)
        }
        .font(.title2)
      }
      /// Center - Workout name
      DynamicIslandExpandedRegion(.center) {
        Text("\(context.attributes.workout.workoutName)")
            .lineLimit(1)
            .font(.custom("Georgia", size: 24, relativeTo: .headline))
            .foregroundColor(.indigo)
            .padding()
      }
      /// Bottom - Stop action button
      DynamicIslandExpandedRegion(.bottom) {
        // Deep link into your app.
        Link(destination: URL(string: "workout://stop")!, label: {
          Label("STOP", systemImage: "xmark")
            .bold()
            .padding(6)
            .foregroundColor(.white)
            .background(.red)
            .clipShape(
              Capsule()
            )
          }).environment(\.openURL, OpenURLAction { url in
            print("The the action to the app with \(url)")
            return .handled
          })
        }
      } compactLeading: {
        Text("\(context.attributes.workout.workoutName)")
      } compactTrailing: {
        Text(timerInterval: context.state.workoutTimer, countsDown: true)
            .multilineTextAlignment(.trailing)
            .frame(width: 50)
            .monospacedDigit()
      } minimal: {
          Text(context.state.workoutTimer)
      }
      ///Sets the URL that opens the corresponding app of a Live Activity when a user taps on the Live Activity.
      .widgetURL(URL(string: "workout://"))
      ///Applies a subtle tint color to the surrounding border of a Live Activity that appears in the Dynamic Island.
      .keylineTint(Color.red)
    }
  }
}


extension WorkoutWidgetAttributes {
  fileprivate static var preview: WorkoutWidgetAttributes {
    WorkoutWidgetAttributes(workout: .Jogging)
  }
}

extension WorkoutWidgetAttributes.ContentState {
    fileprivate static var jogging: WorkoutWidgetAttributes.ContentState {
      var future = Calendar.current.date(byAdding: .minute, value: 20, to: Date())!
      future = Calendar.current.date(byAdding: .second, value: 10, to: future)!
      let date = Date.now...future
        return WorkoutWidgetAttributes.ContentState(workoutTimer: date)
     }
     
     fileprivate static var running: WorkoutWidgetAttributes.ContentState {
       var future = Calendar.current.date(byAdding: .minute, value: 20, to: Date())!
       future = Calendar.current.date(byAdding: .second, value: 10, to: future)!
       let date = Date.now...future
       return WorkoutWidgetAttributes.ContentState(workoutTimer: date)
     }
}

#Preview("Notification", as: .content, using: WorkoutWidgetAttributes.preview) {
   WorkoutWidgetLiveActivity()
} contentStates: {
    WorkoutWidgetAttributes.ContentState.jogging
}

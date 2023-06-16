//
//  WorkoutWidgetBundle.swift
//  WorkoutWidget
//
//  Created by santoshbo on 14/06/23.
//

import WidgetKit
import SwiftUI

@main
struct WorkoutWidgetBundle: WidgetBundle {
    var body: some Widget {
        WorkoutWidget()
        WorkoutWidgetLiveActivity()
    }
}

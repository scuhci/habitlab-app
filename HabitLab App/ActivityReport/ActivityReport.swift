//
//  ActivityReport.swift
//  ActivityReport
//
//  Created by Andrew Collins on 3/4/24.
//

import DeviceActivity
import SwiftUI

@main
struct ActivityReport: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(totalActivity: totalActivity)
        }
        // Add more reports here...
    }
}

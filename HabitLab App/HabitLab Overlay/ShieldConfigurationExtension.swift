//
//  ShieldConfigurationExtension.swift
//  HabitLabOverlay
//
//  Created by Husain Unwalla on 6/6/23.
//

import ManagedSettings
import ManagedSettingsUI
import UIKit

// Override the functions below to customize the shields used in various situations.
// The system provides a default appearance for any methods that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        // Customize the shield as needed for applications.
        return ShieldConfiguration(
                        backgroundBlurStyle: UIBlurEffect.Style.extraLight,
                        backgroundColor: UIColor.white.withAlphaComponent(0.1),
                        title: ShieldConfiguration.Label(text: "Habitlab", color: .black),
                        subtitle: ShieldConfiguration.Label(
                            text: "Habitlab",
                            color: .black
                        ),
                        secondaryButtonLabel: nil
                    )
    }
    
    override func configuration(shielding application: Application, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for applications shielded because of their category.
        return ShieldConfiguration(
            backgroundBlurStyle: UIBlurEffect.Style.regular,
                        backgroundColor: UIColor.white.withAlphaComponent(0.5),
                        icon: UIImage(named: "hour-glass"),
                        title: ShieldConfiguration.Label(text: "Time Limit", color: .black),
                        subtitle: ShieldConfiguration.Label(text: "You're done here, loser", color: .black),
                        secondaryButtonLabel: nil
                    )
    }
    
    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        // Customize the shield as needed for web domains.
        ShieldConfiguration()
    }
    
    override func configuration(shielding webDomain: WebDomain, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for web domains shielded because of their category.
        ShieldConfiguration()
    }
}

import ManagedSettings

extension ManagedSettingsStore.Name{
    static let discouragedApps = Self("discouragedApps")
}

func storeRestrictions(selectionToDiscourage: FamilyActivitySelection) {
    let discouragedAppsStore = ManagedSettingsStore(named: .discouragedApps)
    discouragedAppsStore.shield
}


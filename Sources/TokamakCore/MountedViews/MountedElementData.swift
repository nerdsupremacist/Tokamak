//
//  File.swift
//
//
//  Created by Carson Katri on 8/12/20.
//

/// A container for `EnvironmentValues`, `PreferenceStore`, and other future
/// data associated with a `MountedElement`
struct MountedElementData {
  var environmentValues: EnvironmentValues
  var preferenceStore: PreferenceStore

  init(environmentValues: EnvironmentValues,
       preferenceStore: PreferenceStore)
  {
    (self.environmentValues, self.preferenceStore) = (environmentValues, preferenceStore)
  }

  func branch() -> Self {
    .init(
      environmentValues: environmentValues,
      preferenceStore: preferenceStore.branch()
    )
  }
}

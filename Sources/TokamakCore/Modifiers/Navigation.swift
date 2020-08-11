// Copyright 2020 Tokamak contributors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

struct NavigationTitleKey: PreferenceKey {
  static let defaultValue: String? = nil
  static func reduce(value: inout String?, nextValue: () -> String?) {
    value = nextValue()
  }
}

extension View {
  @available(*, deprecated, renamed: "navigationTitle(_:)")
  public func navigationBarTitle<S>(_ title: S) -> some View where S: StringProtocol {
    navigationTitle(title)
  }

  public func navigationTitle<S>(_ title: S) -> some View where S: StringProtocol {
    preference(key: NavigationTitleKey.self, value: String(title))
  }
}

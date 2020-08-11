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
//
//  Created by Carson Katri on 8/11/20.
//

protocol PreferenceWriter {
  func setPreference(_ store: PreferenceStore)
}

struct _PreferenceWritingModifier<Key>: ViewModifier where Key: PreferenceKey {
  let value: Key.Value

  init(key: Key.Type = Key.self, value: Key.Value) {
    self.value = value
  }

  typealias Body = Never
}

extension _PreferenceWritingModifier: PreferenceWriter {
  func setPreference(_ store: PreferenceStore) {
    store.setValue(value, forKey: Key.self)
  }
}

extension ModifiedContent: PreferenceWriter where Modifier: PreferenceWriter {
  func setPreference(_ store: PreferenceStore) {
    modifier.setPreference(store)
  }
}

extension _PreferenceWritingModifier: Equatable where Key.Value: Equatable {
  static func == (lhs: _PreferenceWritingModifier<Key>,
                  rhs: _PreferenceWritingModifier<Key>) -> Bool
  {
    lhs.value == rhs.value
  }
}

extension View {
  public func preference<K>(key: K.Type = K.self, value: K.Value) -> some View
    where K: PreferenceKey
  {
    modifier(_PreferenceWritingModifier<K>(value: value))
  }
}

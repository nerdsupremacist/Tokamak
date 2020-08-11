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

import CombineShim

protocol PreferenceReader {
  mutating func setupSubscription(on store: PreferenceStore)
}

public struct _PreferenceActionModifier<Key>: ViewModifier
  where Key: PreferenceKey, Key.Value: Equatable
{
  public let action: (Key.Value) -> ()
  private var cancellable: AnyCancellable?

  public init(action: @escaping (Key.Value) -> ()) {
    self.action = action
  }

  public func body(content: Content) -> some View {
    content
  }
}

extension _PreferenceActionModifier: PreferenceReader {
  mutating func setupSubscription(on store: PreferenceStore) {
    cancellable = store.subscribe(to: Key.self)?
      .compactMap { $0 }
      .sink(receiveValue: action)
  }
}

extension View {
  public func onPreferenceChange<K>(_ key: K.Type = K.self,
                                    perform action: @escaping (K.Value) -> ()) -> some View
    where K: PreferenceKey, K.Value: Equatable
  {
    modifier(_PreferenceActionModifier<K>(action: action))
  }
}

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

public struct _PreferenceTransformModifier<Key>: ViewModifier
  where Key: PreferenceKey
{
  public var transform: (inout Key.Value) -> ()

  public init(key _: Key.Type = Key.self,
              transform: @escaping (inout Key.Value) -> ())
  {
    self.transform = transform
  }

  public func body(content: Content) -> some View {
    content
  }
}

extension _PreferenceTransformModifier: PreferenceWriter {
  func setPreference(_ store: PreferenceStore) {
    var value = store.value(forKey: Key.self) ?? Key.defaultValue
    transform(&value)
    store.setValue(value, forKey: Key.self)
  }
}

extension View {
  public func transformPreference<K>(_ key: K.Type = K.self,
                                     _ callback: @escaping (inout K.Value) -> ()) -> some View
    where K: PreferenceKey
  {
    modifier(_PreferenceTransformModifier<K>(transform: callback))
  }
}

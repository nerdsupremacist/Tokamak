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

struct _NavigationTitleWriting<Title, Content>: View
  where Title: StringProtocol, Content: View
{
  @Environment(\.navigationTitle) var context
  let title: Title
  let content: Content

  var body: Content {
    context?.wrappedValue = Text(title)
    return content
  }
}

extension View {
  public func navigationBarTitle<S>(_ title: S) -> some View where S: StringProtocol {
    navigationTitle(title)
  }

  public func navigationTitle<S>(_ title: S) -> some View where S: StringProtocol {
    _NavigationTitleWriting(title: title, content: self)
  }
}

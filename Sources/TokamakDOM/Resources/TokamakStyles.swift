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

let tokamakStyles = """
._tokamak-stack > * {
  flex-shrink: 0;
}
._tokamak-scrollview-hideindicators {
  scrollbar-color: transparent;
  scrollbar-width: 0;
}
._tokamak-scrollview-hideindicators::-webkit-scrollbar {
  width: 0;
  height: 0;
}
._tokamak-list {
  list-style: none;
  overflow-y: auto;
  width: 100%;
  height: 100%;
  padding: 0;
}

._tokamak-disclosuregroup-label {
  cursor: pointer;
}
._tokamak-disclosuregroup-chevron-container {
  width: .25em;
  height: .25em;
  padding: 10px;
  display: inline-block;
}
._tokamak-disclosuregroup-chevron {
  width: 100%;
  height: 100%;
  transform: rotate(45deg);
  border-right: solid 2px rgba(0, 0, 0, 0.25);
  border-top: solid 2px rgba(0, 0, 0, 0.25);
}
._tokamak-disclosuregroup-content {
  display: flex;
  flex-direction: column;
  margin-left: 1em;
}

._tokamak-toolbar-container {
  width: 100%;
  height: 100%;
}
._tokamak-toolbar-container-toolbar {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 38px;
  padding: 10px;
  box-sizing: border-box;
  background-color: rgba(255, 255, 255, 0.5);
  backdrop-filter: blur(10px);
  border-bottom: 1px solid rgba(0, 0, 0, 0.1);
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: flex-end;
}
._tokamak-toolbar-container-toolbar-item {
  flex-shrink: 1;
  flex-grow: 0;
}
._tokamak-toolbar-container-toolbar > ._tokamak-toolbar-container-toolbar-item {
  margin-left: auto;
}
._tokamak-toolbar-container-toolbar > ._tokamak-toolbar-container-toolbar-item ~ ._tokamak-toolbar-container-toolbar-item {
  margin-left: unset;
}
/*._tokamak-toolbar-container-toolbar > ._tokamak-toolbar-container-toolbar-item:last-child {
  margin-right: auto;
}*/
._tokamak-toolbar-container-content > *:first-child:not(._tokamak-scrollview) {
  margin-top: 38px;
}
._tokamak-toolbar-container-content > ._tokamak-scrollview:first-of-type:before {
  content: '';
  height: 38px;
  display: block;
}
"""

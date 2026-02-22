//
//  SampleView_ReferenceTypeData.swift
//  SwiftUI-StateAndDataManagement
//
//  Created by Anand Kumar on 2/21/26.
//

import SwiftUI

@Observable
class SampleReferenceType {
    var temperature: Int
    var isHigh: Bool {
        get {
            temperature >= 30
        }
        set {
            if newValue == false {
                temperature = 29
            } else if temperature < 30 {
                temperature = 30
            }
        }
    }
    
    init(temperature: Int) {
        self.temperature = temperature
    }
}

struct ParentView_ReferenceTypeData: View {
    @State var data = SampleReferenceType(temperature: 20)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Parent")
                .font(.headline)
            
            Text("Weather (a 'Reference type' Source of Truth) - \(data.temperature)")
            
            Button("Parent increments") {
                data.temperature += 1
            }
            
            ChildViewThatNeedsToTrackOnly_ReferenceTypeData(data: data)
            
            ChildViewThatNeedsToUpdateToo_ReferenceTypeData(data: data)
        }
        .styledView(
            backgroundColor: Color.green.opacity(0.12),
            strokeColor: Color.green.opacity(0.25)
        )
    }
}

struct ChildViewThatNeedsToTrackOnly_ReferenceTypeData: View {
    let data: SampleReferenceType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Child that only tracks")
                .bold()
            
            Text("Weather - \(data.temperature)")
        }
        .styledView(
            backgroundColor: Color.yellow.opacity(0.18),
            strokeColor: Color.yellow.opacity(0.28)
        )
    }
}

struct ChildViewThatNeedsToUpdateToo_ReferenceTypeData: View {
    @Bindable var data: SampleReferenceType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Child that modifies too")
                    .bold()
            Text("Weather - \(data.temperature)")
            Toggle("Is High", isOn: $data.isHigh)
            Button("Child increments") {
                data.temperature += 1
                /* N.B. -
                 You can't do the below as data is a @Bindable, but you would have been able to if data was a  @Binding instead. That is why @Bindable is preferable over @Binding, its safer. A child should not be able to change the parent source of truth reference itself, changing odd properties in it is fine.
                 ```
                    data = NewReferenceType(temperature: 35)
                 ```
                 */
            }
            
            GrandchildViewThatNeedsToUpdateToo_ReferenceTypeData(data: data)
        }
        .styledView(
            backgroundColor: Color.yellow.opacity(0.18),
            strokeColor: Color.yellow.opacity(0.28)
        )
    }
}

struct GrandchildViewThatNeedsToUpdateToo_ReferenceTypeData: View {
    @Bindable var data: SampleReferenceType
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Grandchild that modifies too")
                    .bold()
            Text("Weather - \(data.temperature)")
            Button("Grandchild increments") {
                data.temperature += 1
            }
            
        }
        .styledView(
            backgroundColor: Color.red.opacity(0.14),
            strokeColor: Color.red.opacity(0.22)
        )

    }
}

#Preview {
    ParentView_ReferenceTypeData()
}

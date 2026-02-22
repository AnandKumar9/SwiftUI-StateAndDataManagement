//
//  SampleViews_ValueTypeData.swift
//  SwiftUI-StateAndDataManagement
//
//  Created by Anand Kumar on 2/21/26.
//

import SwiftUI

struct ParentView_ValueTypeData: View {
    @State var temperature = 20
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Parent")
                .font(.headline)
            
            Text("Weather (a 'Value type' Source of Truth) - \(temperature)")
            
            Button("Parent increments") {
                temperature += 1
            }
            
            ChildViewThatNeedsToTrackOnly_ValueTypeData(temperature: temperature)
            
            ChildViewThatNeedsToUpdateToo_ValueTypeData(temperature: $temperature)
        }
        .styledView(
            backgroundColor: Color.green.opacity(0.12),
            strokeColor: Color.green.opacity(0.25)
        )
        .padding()
    }
}

struct ChildViewThatNeedsToTrackOnly_ValueTypeData: View {
    let temperature: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Child that only tracks")
                .bold()
            Text("Weather - \(temperature)")
        }
        .styledView(
            backgroundColor: Color.yellow.opacity(0.18),
            strokeColor: Color.yellow.opacity(0.28)
        )
    }
}

struct ChildViewThatNeedsToUpdateToo_ValueTypeData: View {
    @Binding var temperature: Int
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Child that modifies too")
                .bold()
            Text("Weather - \(temperature)")
            Button("Child increments") {
                temperature += 1
            }
            
            GrandchildView(temperature: $temperature)
        }
        .styledView(
            backgroundColor: Color.orange.opacity(0.18),
            strokeColor: Color.orange.opacity(0.28)
        )
    }
}

struct GrandchildView: View {
    @Binding var temperature: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Grandchild that modifies too")
                    .bold()
            Text("Weather - \(temperature)")
            Button("Grandchild increments") {
                temperature += 1
            }
        }
        .styledView(
            backgroundColor: Color.red.opacity(0.14),
            strokeColor: Color.red.opacity(0.22)
        )
    }
}

#Preview {
    ParentView_ValueTypeData()
}

import SwiftUI

struct TimeComponentsView: View {
    var years: Int
    var months: Int
    var days: Int
    var hours: Int
    var minutes: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if years > 0 {
                Text("\(years) år")
            }
            if months > 0 {
                Text("\(months) månader")
            }
            if days > 0 || (years == 0 && months == 0) {
                Text("\(days) dagar")
            }
            Text("\(hours) timmar")
            Text("\(minutes) minuter")
        }
        .font(.title2)
        .fontWeight(.bold)
        .padding(.bottom)
    }
}

#Preview {
    TimeComponentsView(years: 1, months: 2, days: 3, hours: 4, minutes: 5)
}

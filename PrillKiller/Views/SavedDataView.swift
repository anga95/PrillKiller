import SwiftUI

struct SavedDataView: View {
    var savedPrillor: Double
    var savedDosor: Double
    var savedMoney: Double
    
    var body: some View {
        Section(header: Text("Sparade data")) {
            HStack {
                Text("Sparade prillor")
                Spacer()
                Text("\(Int(savedPrillor))")
            }
            HStack {
                Text("Sparade dosor")
                Spacer()
                Text("\(String(format: "%.2f", savedDosor))")
            }
            HStack {
                Text("Sparade pengar")
                Spacer()
                Text("\(String(format: "%.2f", savedMoney)) kr")
            }
        }
    }
}

#Preview {
    SavedDataView(savedPrillor: 24, savedDosor: 1.2, savedMoney: 60.0)
}

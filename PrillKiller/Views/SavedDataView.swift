import SwiftUI

struct SavedDataView: View {
    var savedPrillor: Double
    var savedDosor: Double
    var savedMoney: Double
    
    var body: some View {
        Section(header: Text("Sparade data").foregroundColor(.orange)) {  // Accentfärg för rubrik
            HStack {
                Text("Sparade prillor")
                Spacer()
                Text("\(Int(savedPrillor))")
            }
            .foregroundColor(.white)  // Vit text för data
            .listRowBackground(Color.gray.opacity(0.3))  // Mörk bakgrund för raderna
            
            HStack {
                Text("Sparade dosor")
                Spacer()
                Text("\(String(format: "%.2f", savedDosor))")
            }
            .foregroundColor(.white)
            .listRowBackground(Color.gray.opacity(0.3))
            
            HStack {
                Text("Sparade pengar")
                Spacer()
                Text("\(String(format: "%.2f", savedMoney)) kr")
            }
            .foregroundColor(.white)
            .listRowBackground(Color.gray.opacity(0.3))
        }
    }
}

#Preview {
    SavedDataView(savedPrillor: 24, savedDosor: 1.2, savedMoney: 60.0)
}

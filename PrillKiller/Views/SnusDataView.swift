import SwiftUI

struct SnusDataView: View {
    var prillorPerDag: Int
    var prillorPerDosa: Int
    var dosaPris: Double
    
    var body: some View {
        Section(header: Text("Snusdata").foregroundColor(.orange)) {  // Accentfärg för rubrik
            HStack {
                Text("Prillor per dag")
                Spacer()
                Text("\(prillorPerDag)")
            }
            .foregroundColor(.white)  // Vit text för data
            .listRowBackground(Color.gray.opacity(0.3))  // Mörk bakgrund för raderna
            
            HStack {
                Text("Prillor per dosa")
                Spacer()
                Text("\(prillorPerDosa)")
            }
            .foregroundColor(.white)
            .listRowBackground(Color.gray.opacity(0.3))
            
            HStack {
                Text("Dosa pris")
                Spacer()
                Text("\(String(format: "%.2f", dosaPris)) kr")
            }
            .foregroundColor(.white)
            .listRowBackground(Color.gray.opacity(0.3))
        }
    }
}

#Preview {
    SnusDataView(prillorPerDag: 30, prillorPerDosa: 20, dosaPris: 50.0)
}

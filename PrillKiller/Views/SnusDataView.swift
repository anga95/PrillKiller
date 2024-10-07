import SwiftUI

struct SnusDataView: View {
    var prillorPerDag: Int
    var prillorPerDosa: Int
    var dosaPris: Double
    
    var body: some View {
        Section(header: Text("Snusdata")) {
            HStack {
                Text("Prillor per dag")
                Spacer()
                Text("\(prillorPerDag)")
            }
            HStack {
                Text("Prillor per dosa")
                Spacer()
                Text("\(prillorPerDosa)")
            }
            HStack {
                Text("Dosa pris")
                Spacer()
                Text("\(String(format: "%.2f", dosaPris)) kr")
            }
        }
    }
}

#Preview {
    SnusDataView(prillorPerDag: 30, prillorPerDosa: 20, dosaPris: 50.0)
}

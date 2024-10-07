import SwiftUI

struct SnusSettingsView: View {
    @Binding var prillorPerDag: Int
    @Binding var prillorPerDosa: Int
    @Binding var dosaPris: Double
    @Binding var stoppedToSnus: Date  // Nytt binding för datum och tid
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Snusinställningar")) {
                    Stepper("Prillor per dag: \(prillorPerDag)", value: $prillorPerDag, in: 1...100)
                    
                    Stepper("Prillor per dosa: \(prillorPerDosa)", value: $prillorPerDosa, in: 1...50)
                    
                    HStack {
                        Text("Dosa pris: ")
                        TextField("Pris", value: $dosaPris, format: .currency(code: "SEK"))
                            .keyboardType(.decimalPad)
                    }
                    
                    // DatePicker för att välja när man slutade snusa
                    DatePicker("När slutade du snusa?", selection: $stoppedToSnus, displayedComponents: [.date, .hourAndMinute])
                }
                
                Button("Spara") {
                    dismiss()  // Stäng vyn när du sparar
                }
            }
            .navigationTitle("Ställ in snusdata")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Avbryt") {
                        dismiss()  // Stäng vyn utan att spara
                    }
                }
            }
        }
    }
}

#Preview {
    SnusSettingsView(prillorPerDag: .constant(24), prillorPerDosa: .constant(20), dosaPris: .constant(50.0), stoppedToSnus: .constant(Date()))
}

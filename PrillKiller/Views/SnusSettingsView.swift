import SwiftUI

struct SnusSettingsView: View {
    @Binding var prillorPerDag: Int
    @Binding var prillorPerDosa: Int
    @Binding var dosaPris: Double
    @Binding var stoppedToSnus: Date

    // Lokala temporära variabler
    @State private var tempPrillorPerDag: Int
    @State private var tempPrillorPerDosa: Int
    @State private var tempDosaPris: Double
    @State private var tempStoppedToSnus: Date
    @State private var isDatePickerVisible = false  // Ny flagga för att styra DatePicker-visibility

    @Environment(\.dismiss) var dismiss

    init(prillorPerDag: Binding<Int>, prillorPerDosa: Binding<Int>, dosaPris: Binding<Double>, stoppedToSnus: Binding<Date>) {
        _prillorPerDag = prillorPerDag
        _prillorPerDosa = prillorPerDosa
        _dosaPris = dosaPris
        _stoppedToSnus = stoppedToSnus
        
        _tempPrillorPerDag = State(initialValue: prillorPerDag.wrappedValue)
        _tempPrillorPerDosa = State(initialValue: prillorPerDosa.wrappedValue)
        _tempDosaPris = State(initialValue: dosaPris.wrappedValue)
        _tempStoppedToSnus = State(initialValue: stoppedToSnus.wrappedValue)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Snusinställningar")) {
                    Stepper("Prillor per dag: \(tempPrillorPerDag)", value: $tempPrillorPerDag, in: 1...100)
                    
                    Stepper("Prillor per dosa: \(tempPrillorPerDosa)", value: $tempPrillorPerDosa, in: 1...50)
                    
                    HStack {
                        Text("Dosa pris: ")
                        TextField("Pris", value: $tempDosaPris, format: .currency(code: "SEK"))
                            .keyboardType(.decimalPad)
                    }

                    // DatePicker med autominimering
                    DatePicker("När slutade du snusa?", selection: $tempStoppedToSnus, displayedComponents: [.date, .hourAndMinute])
                        .onChange(of: tempStoppedToSnus) {  // Uppdaterad användning av onChange
                            isDatePickerVisible = false  // Minimera DatePicker när ett nytt datum väljs
                        }
                        .datePickerStyle(.graphical) // För att visa den grafiska kalendern
                }
                
                Button("Spara") {
                    prillorPerDag = tempPrillorPerDag
                    prillorPerDosa = tempPrillorPerDosa
                    dosaPris = tempDosaPris
                    stoppedToSnus = tempStoppedToSnus
                    dismiss()
                }
            }
            .navigationTitle("Ställ in snusdata")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Avbryt") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SnusSettingsView(
        prillorPerDag: .constant(30),
        prillorPerDosa: .constant(20),
        dosaPris: .constant(50.0),
        stoppedToSnus: .constant(Date())
    )
}

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var snusSituations: [SnusSituation]
    
    @State private var prillorPerDag: Int = 30
    @State private var prillorPerDosa: Int = 20
    @State private var dosaPris: Double = 50.0
    @State private var stoppedToSnus: Date = Date()
    
    @State private var showSettings = false
    @State private var timer: Timer?

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if let situation = snusSituations.first {
                    // Hämta tidskomponenterna
                    let time = situation.timeComponents()
                    
                    // Använd TimeComponentsView för att visa tidskomponenterna
                    TimeComponentsView(
                        years: time.years,
                        months: time.months,
                        days: time.days,
                        hours: time.hours,
                        minutes: time.minutes
                    )

                    Form {
                        SnusDataView(
                            prillorPerDag: situation.prillorPerDag,
                            prillorPerDosa: situation.prillorPerDosa,
                            dosaPris: situation.dosaPris
                        )
                        
                        SavedDataView(
                            savedPrillor: situation.savedPrillor(),
                            savedDosor: situation.savedDosor(),
                            savedMoney: situation.savedMoney()
                        )
                    }

                    Button("Ställ in snusdata") {
                        showSettings = true
                    }
                    .sheet(isPresented: $showSettings) {
                        SnusSettingsView(
                            prillorPerDag: $prillorPerDag,
                            prillorPerDosa: $prillorPerDosa,
                            dosaPris: $dosaPris,
                            stoppedToSnus: $stoppedToSnus
                        )
                        .onDisappear {
                            updateSnusSituation()
                        }
                    }

                    Button("Nollställ databasen") {
                        resetDatabase()
                    }
                    .foregroundColor(.red)

                } else {
                    Text("Ange din snusinformation")
                    Button(action: addSnusSituation) {
                        Label("Lägg till snusdata", systemImage: "plus")
                    }
                }
            }
            .padding()
            .onAppear {
                startTimer()
            }
            .onDisappear {
                stopTimer()
            }
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            // Timer-logik för att uppdatera UI
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func updateSnusSituation() {
        if let firstSituation = snusSituations.first {
            withAnimation {
                firstSituation.stoppedToSnus = stoppedToSnus
                firstSituation.prillorPerDag = prillorPerDag
                firstSituation.prillorPerDosa = prillorPerDosa
                firstSituation.dosaPris = dosaPris

                do {
                    try modelContext.save()
                    print("Snusdata uppdaterad korrekt")
                } catch {
                    print("Misslyckades med att uppdatera snusdata: \(error.localizedDescription)")
                }
            }
        }
    }

    private func addSnusSituation() {
        withAnimation {
            let newSituation = SnusSituation(
                stoppedToSnus: stoppedToSnus,
                prillorPerDag: prillorPerDag,
                prillorPerDosa: prillorPerDosa,
                dosaPris: dosaPris
            )
            modelContext.insert(newSituation)

            do {
                try modelContext.save()
                print("Data sparad korrekt")
            } catch {
                print("Misslyckades med att spara data: \(error.localizedDescription)")
            }
        }
    }

    private func resetDatabase() {
        withAnimation {
            for situation in snusSituations {
                modelContext.delete(situation)
            }
            
            do {
                try modelContext.save()
                print("Databasen har nollställts")
            } catch {
                print("Misslyckades med att nollställa databasen: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: SnusSituation.self, inMemory: true)
}

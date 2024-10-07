import Foundation
import SwiftData

@Model
final class SnusSituation {
    var stoppedToSnus: Date
    var prillorPerDag: Int
    var prillorPerDosa: Int
    var dosaPris: Double
    
    init(stoppedToSnus: Date, prillorPerDag: Int, prillorPerDosa: Int, dosaPris: Double) {
        self.stoppedToSnus = stoppedToSnus
        self.prillorPerDag = prillorPerDag
        self.prillorPerDosa = prillorPerDosa
        self.dosaPris = dosaPris
    }
    
    // Beräkna antal sparade prillor baserat på timmar som gått
    func savedPrillor() -> Double {
        let hoursSinceQuit = Calendar.current.dateComponents([.hour], from: stoppedToSnus, to: Date()).hour ?? 0
        let prillorPerHour = Double(prillorPerDag) / 24.0
        return Double(hoursSinceQuit) * prillorPerHour
    }
    
    // Beräkna antal dosor som inte köpts
    func savedDosor() -> Double {
        return savedPrillor() / Double(prillorPerDosa)
    }
    
    func timeSinceQuit() -> String {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: stoppedToSnus, to: Date())
        
        let years = components.year ?? 0
        let months = components.month ?? 0
        let days = components.day ?? 0
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        
        // Bygg upp en sträng baserat på vilka komponenter som är relevanta
        var timeString = ""
        
        if years > 0 {
            timeString += "\(years) år "
        }
        
        if months > 0 {
            timeString += "\(months) mån "
        }
        
        if days > 0 || (years == 0 && months == 0) {  // Visa dagar om inga år eller månader
            timeString += "\(days) dagar "
        }
        
        timeString += String(format: "%02d:%02d", hours, minutes)  // Visa alltid timmar och minuter
        
        return timeString.trimmingCharacters(in: .whitespaces)
    }
    
    func timeComponents() -> (years: Int, months: Int, days: Int, hours: Int, minutes: Int) {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: stoppedToSnus, to: Date())
        
        let years = components.year ?? 0
        let months = components.month ?? 0
        let days = components.day ?? 0
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        
        return (years, months, days, hours, minutes)
    }
    
    // Beräkna pengar som sparats
    func savedMoney() -> Double {
        return savedDosor() * dosaPris
    }
}

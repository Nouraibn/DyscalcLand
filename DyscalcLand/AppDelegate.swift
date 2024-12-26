import UIKit
import SwiftData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var modelContainer: ModelContainer? // Shared model container
    var modelContext: ModelContext? // Shared model context

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        // Initialize the model container for SwiftData
        do {
            modelContainer = try ModelContainer(for: GameProgress.self, LevelProgress.self) // Pass models directly
            modelContext = modelContainer?.mainContext
        } catch {
            print("Failed to initialize the ModelContainer: \(error.localizedDescription)")
            return false
        }

        // Initialize the main window and root view controller
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = GameViewController() // Replace with your main game view controller
        viewController.modelContext = modelContext // Pass the context
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Pause the game or any ongoing tasks if needed.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Save the data when the app enters the background.
        do {
            try modelContext?.save()
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Refresh the user interface if needed.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Resume paused tasks or game state.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Save data before the app terminates.
        do {
            try modelContext?.save()
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
    }
}

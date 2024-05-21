class AppDataContext {
  static Map<int, String> getMedicines() {
    Map<int, String> medecines = {};
    medecines[1] = "Paracetamol-Fever";
    medecines[2] = "Mefenamic Acid-Toothache";
    medecines[3] = "Dicycloverine-Stomachache";
    medecines[4] = "Antihistamine-Allergies";
    medecines[5] = "Loperamide-Lbm";

    return medecines;
  }

  // Corrected method to filter medicines by a keyword in their descriptions.
  static Map<int, String> filterMedicinesByKeyword(String keyword) {
    var allMedicines = getMedicines();
    // Filtering using Map entries
    Map<int, String> filteredMedicines = Map.fromEntries(allMedicines.entries
        .where((entry) =>
            entry.value.toLowerCase().contains(keyword.toLowerCase())));
    return filteredMedicines;
  }
}

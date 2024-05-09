require '../lib/term_note'

# https://www.ssl.com/el/Συχνές-ερωτήσεις/ψηφιακές-υπογραφές-και-υπογραφή-εγγράφων/
class Presentation < Presenter
  define_slide { [
    "ΑΣΦΑΛΕΙΑ ΔΕΔΟΜΕΝΩΝ ΣΤΗΝ ΚΟΙΝΩΝΙΑ ΤΗΣ ΠΛΗΡΟΦΟΡΙΑΣ (8οΕξ.)", "",
    "Ψηφιακά Πιστοποιητικά και Ψηφιακές Υπογραφές",
    "16 Μαΐου 2024"
  ] }

  define_slide { ["Παντελέλης Μιχάλης#light_magenta",
                  "email: mpantel@aegean.gr#magenta", "",
                  "Ηλεκτρολόγος Μηχανικός & Μηχανικός Η/Υ#magenta", "",
                  "Πανεπιστήμιο Αιγαίου",
                  "Μονάδα Μεταφοράς Τεχνολογίας και Καινοτομίας"]
  }

  define_slide do
    ["Περίγραμμα Διάλεξης", "",
     "Α. Ψηφιακά Πιστοποιητικά",
     "Β. Ψηφιακές Υπογραφές",
     "Γ. Διαχείριση Κωδικών Πρόσβασης",
     "Δ. Προγραμματισμός και Προστασία Προσωπικών Δεδομένων (Έρευνα)",

    ]
  end

  define_slide do
    [
      "Α. Ψηφιακά Πιστοποιητικά",
      "Τί είναι οι ψηφιακά πιστοποιητικά",
      "Πώς εκδίδονται",
      "Πως εγκαθίστανται",
      "Πως εγκαθίστανται"
    ]
    end
    define_slide do
      [
        "Β. Ψηφιακές Υπογραφές", "",
        "Τί είναι οι ψηφιακές υπογραφές",
        "Πώς εκδίδονται",
        "Πώς υπογράφουμε",
        "Πώς επιβεβαιώνουμε την εγκυρότητα ενός εγγράφου",

      ]
    end
    define_slide do
      [
        "Γ. Διαχείριση Κωδικών Πρόσβασης", "",
        "Αναγκαιότητα",
        "Λογισμικά Διαχείρισης Κωδικών Πρόσβασης",
        "Κεντρική Διαχείριση Κωδικών Πρόσβασης",
      ]
    end

    define_slide do
      ["https://keepassxc.org/download/#SNAPSHOT"]
    end
    define_slide do
      ["https://bitwarden.com/products/personal/#SNAPSHOT"]
    end
    define_slide do
      ["https://1password.com#SNAPSHOT"]
    end
    define_slide do
      ["https://www.lastpass.com#SNAPSHOT"]
    end
    define_slide do
      ["https://www.passbolt.com#SNAPSHOT"]
    end

  # check leaks
    define_slide do
      ["https://www.malwarebytes.com/digital-footprint#SNAPSHOT"]
    end

    define_slide do
      [
        "Δ. Προγραμματισμός και Προστασία Προσωπικών Δεδομένων (Έρευνα)", "",
        "Τί είναι προσωπικά δεδομένα",
       "Γενικός Κανονισμός για την Προστασία Δεδομένων (GDPR)",
       "Προγραμματισμός και Πρόσβαση σε Δεδομένα",
        "Αντιστοίχιση πρόσβασης και προστασίας δεδομένων (Έρευνα)"
      ]
    end

    define_slide { ["harica#PNG"] }
    define_slide do
      [

        "https://aped.gov.gr#URL"
      ]
    end

    define_slide do
      ["Ψηφιακή βεβαίωση εγγράφου", "",
       "Η ψηφιακή βεβαίωση που θα εκδώσετε είναι νομικά ισοδύναμη ", "με έγγραφο που φέρει το γνήσιο της υπογραφής",
       " και μπορείτε είτε να την αποστείλετε ηλεκτρονικά, ", " είτε να την εκτυπώσετε και να την καταθέσετε σε έντυπη μορφή."]
    end
    define_slide { ["https://www.gov.gr/ipiresies/polites-kai-kathemerinoteta/psephiaka-eggrapha-gov-gr/psephiake-bebaiose-eggraphou#URL"] }
    define_slide { ["HARICA", "", "Ψηφιακά Πιστοποιητικά προσαρμοσμένα στις ανάγκες σας"] }
    define_slide do
      ["H HARICA είναι μια Διεθνώς \"Έμπιστη Τρίτη Οντότητα\" (Trusted Third Party) ",
       "που συμμετέχει ταυτόχρονα στα μεγαλύτερα διεθνή \"ROOT CA\" προγράμματα εμπιστοσύνης ",
       "(360, Adobe, Apple, Microsoft, Mozilla, Oracle) ",
       "με αποτέλεσμα να λειτουργεί ως \"σημείο εμπιστοσύνης\" (Trust Anchor) ",
       "σε Διεθνείς οίκους λογισμικού και Λειτουργικά Συστήματα (Adobe, Apple, Google, Microsoft, Mozilla, Linux, Oracle)."]
    end
    define_slide { ["https://www.harica.gr#URL"] }

    define_slide { ["https://www.in.gr#URL"] }
    self.present

  end
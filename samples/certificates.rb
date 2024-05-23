require '../lib/term_note'

# https://www.ssl.com/el/Συχνές-ερωτήσεις/ψηφιακές-υπογραφές-και-υπογραφή-εγγράφων/
class Presentation < Presenter
  define_slide { [
    "ΑΣΦΑΛΕΙΑ ΔΕΔΟΜΕΝΩΝ ΣΤΗΝ ΚΟΙΝΩΝΙΑ ΤΗΣ ΠΛΗΡΟΦΟΡΙΑΣ (8οΕξ.)", "",
    "Ψηφιακά Πιστοποιητικά και Ψηφιακές Υπογραφές","",
    "16 & 23 Μαΐου 2024"
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
      "Χρησιμότητα",
      "Τί είναι οι ψηφιακά πιστοποιητικά",
      "Πώς εκδίδονται - Υποδομή Δημόσιου Κλειδιού",
      "Πως εγκαθίστανται"
    ]
  end

  define_slide { ["dioik-real#PNG"] }
  define_slide { ["dioik-fake#PNG"] }
  define_slide { ["dioik-response#PNG"] }
  define_slide { ["dioik-address-real#PNG"] }
  define_slide { ["dioik-address-fake#PNG"] }
  define_slide { ["mail-with-signature#PNG"] }

  define_slide(record: false) do
    [
      "Α. Ψηφιακά Πιστοποιητικά",
      "Τί είναι οι ψηφιακά πιστοποιητικά","",
    ]
  end
  define_slide(include: -1) do
    [
      "Kρυπτογραφικά ζεύγη κλειδιών με ενσωματωμένη ταυτότητα",
      "Χαρακτηρίζουν: ιστότοπους, άτομα ή οργανισμούς",
    ]
  end
  define_slide(include: -2) do
    [

      "SSL/TLS HTTPS",
      "Υπογεγραμμένο και κρυπτογραφημένο email",
      "Υπογραφή Εγγράφου",
      "Έλεγχος ταυτότητας",

    ]
  end

  define_slide(include: -3) do
    [

      "Κρυπτογράφηση - Ταυτοποίηση - Εγκυρότητα",
      "Encryption - Authentication - Integrity",

    ]
  end
  define_slide(include: -4) do
    [
      "Πιστοποιητικό Χ.509 1988",
      "PGP - 1991",
      "SSL 1995",
      "OpenPGP - 1997 - IETF standard",
      "OpenSSL 1998",
      "GPG (GNU Privacy Guard) 1999",
      "TLS 1999",
    ]
  end

  define_slide(include: -5) do
    [
      "https://www.openpgp.org",
      "https://gpgtools.org",
      "https://www.openssl.org",
      "https://www.feistyduck.com/library/openssl-cookbook/online/",
    ]
  end

  define_slide(record: false) do
    [
      "Α. Ψηφιακά Πιστοποιητικά",
      "Πώς εκδίδονται - Υποδομή Δημόσιου Κλειδιού (PKI)", ""
    ]
  end

  define_slide(include: -1) do
    [
      "Αρχή Πιστοποίησης -  Certification Authority","",
      "Διεθνώς \"Έμπιστη Τρίτη Οντότητα\" (Trusted Third Party)",
      "Συμμετέχει σε διεθνή \"ROOT CA\" προγράμματα εμπιστοσύνης",
      "(Adobe, Apple, Microsoft, Mozilla, Oracle,Google,Linux)",
      "Λειτουργούν ως \"σημείο εμπιστοσύνης\" (Trust Anchor)",
    ]

  end

  define_slide(include: -2) do
    [
      "Αρχή Πιστοποίησης - Certification Authority","",
      "Εκδίδει Πιστοποιητικά",
      "Διατηρεί Λίστες Ανάκλησης Πιστοποιητικών",
      "Παρέχει Υπηρεσίες Χρονοσήμανσης"
    ]

  end
  define_slide(include: -3) do
    [
      "Αρχή Πιστοποίησης -  Certification Authority","",
      "ROOT Certificate",
      "Intermediate Certificates",
      "Certificate Chains"
    ]

  end

  define_slide(include: -4) do
    [
      "Self Signed Certificates",
      "Δοκιμές",
      "Περιορισμένα Περιβάλλοντα",
    ]

  end

  define_slide(include: -5) do
    [
      "Αρχή Πιστοποίησης -  Certification Authority","",
      "https://www.harica.gr",
      "https://aped.gov.gr",
      "https://www.sectigo.com",
      "https://letsencrypt.org",
    ]
  end

  define_slide { ["certmanager_1#PNG"] }
  define_slide { ["certmanager_3#PNG"] }
  define_slide { ["certmanager_2#PNG"] }

  define_slide(record: false) do
    [
      "Α. Ψηφιακά Πιστοποιητικά",
      "Πως εγκαθίστανται", ""
    ]
  end
  define_slide(include: -1) do
    [
      "Πιστοποιητικό Διακομιστή","",
    ]
  end

  define_slide { ["certmanager_4#PNG"] }
  define_slide { ["certmanager_5#PNG"] }

  define_slide(include: -4) do
    [
      "Πιστοποιητικό Πρόσβασης","",
      "https://docs.github.com/en/authentication/connecting-to-github-with-ssh"
    ]
  end
  define_slide { ["github_keys#PNG"] }

  define_slide do
    [
      "Β. Ψηφιακές Υπογραφές", "",
      "Τί είναι οι ψηφιακές υπογραφές",
      "Πώς εκδίδονται",
      "Πώς υπογράφουμε",
      "Πώς επιβεβαιώνουμε την εγκυρότητα ενός εγγράφου",

    ]
  end

  define_slide(record: false) do
    [
      "Β. Ψηφιακές Υπογραφές", "",
      "Τί είναι οι ψηφιακές υπογραφές", "",
    ]
  end

  define_slide(include: -1) do
    [
      "Νομοθεσία:", "",
      "ΗΠΑ: e-sign (2000)",
      "EU: eIDAS (2014)"
    ]
  end

  define_slide(include: -2) do
    ["Αυθεντικότητα - Ακεραιότητα - Μη αποκήρυξη",
    ]
  end
  define_slide(include: -3) do
    [
      "Ηλεκτρονική (ΗΠΑ)","",
      "Ψηφιακή Υπογραφή:","",
      "Προηγμένη (Advanced) Ηλεκτρονική Υπογραφή",
      "Εγκεκριμένη (Qualified) Ηλεκτρονική Υπογραφή",
    ]

  end

  define_slide do
    [

      "Προηγμένη (Advanced) Ηλεκτρονική Υπογραφή", "",

      "Συνδέει με μοναδικό τρόπο την υπογραφή με τον υπογράφοντα","",
      "Δημιουργείται με τρόπο που το πρόσωπο που υπογράφει, ",
      "ελέγχει το μηχανισμό υπογραφής (γνωρίζει πότε υπογράφει)","",
      "Συνδέεται με το ηλεκτρονικό έγγραφο με τρόπο που οποιαδήποτε",
      "αλλαγή στα δεδομένα είναι ανιχνεύσιμη (διασφάλιση ακεραιότητας)"
    ]
  end

  define_slide do
    [

      "Εγκεκριμένη (Qualified) Ηλεκτρονική Υπογραφή", "",
      "Είναι ηλεκτρονική υπογραφή η οποία έχει όλα τα παραπάνω και επιπλέον:","",
      "Δημιουργείται μόνο μέσω “Εγκεκριμένης” Διάταξης Δημιουργίας Υπογραφής (ΕΔΔΥ*)","",
      "Βασίζεται σε “Εγκεκριμένο” Ψηφιακό Πιστοποιητικό για ηλεκτρονική υπογραφή",

    ]
  end



  define_slide do
    [

    "Ανάλογα με την περίπτωση μπορεί να","επιλεγεί η ανάλογη μορφή eSignature",
    "αλλά μόνο η “Εγκεκριμένη” ηλεκτρονική υπογραφή","αναγνωρίζεται ρητά ως",
    "νομικά ισοδύναμη με την ιδιόχειρη υπογραφή,",
    "σε όλα τα Κράτη Μέλη της Ευρωπαϊκής Ένωσης.",

    ]
  end
  define_slide do
    [

      "Εγκεκριμένη Διάταξης Δημιουργίας Υπογραφής (ΕΔΔΥ).", "",
      "Υπάρχουν σε διάφορες μορφές ",
      "(έξυπνες κάρτες, κάρτες SIM, κρυπτοσυσκευές USB κ.α.),",
      "έχουν ειδική Πιστοποίηση Ασφάλειας και έχουν σαν στόχο ",
      "να προστατέψουν με ασφάλεια τα δεδομένα δημιουργίας υπογραφής.",

    ]
  end

  define_slide { ["aped_token#PNG"] }
  define_slide { ["aped_yubikey#PNG"] }

  define_slide do
    [

    "Εγκεκριμένη Διάταξης Δημιουργίας Υπογραφής (ΕΔΔΥ).", "",

    "Υπάρχουν και “Εξ αποστάσεως” ΕΔΔΥ οι οποίες δεν είναι στην κατοχή",
    "των υπογραφόντων αλλά υπό τη διαχείριση/εποπτεία ενός",
    "Παρόχου Υπηρεσιών Εμπιστοσύνης όπως η HARICA.",
    ]
  end

  define_slide do
    [
      "Β. Ψηφιακές Υπογραφές", "",
      "Πώς εκδίδονται", "",
      "Από μία αρχή Πιστοποίησης",
      "μετά από επιβεβαίωση ταυτότητας",
    ]
  end

  define_slide { ["harica#PNG"] }

  define_slide do
    ["Ψηφιακή βεβαίωση εγγράφου GOV.gr", "",
     "Η ψηφιακή βεβαίωση που θα εκδώσετε είναι νομικά ισοδύναμη ",
     "με έγγραφο που φέρει το γνήσιο της υπογραφής",
     "και μπορείτε είτε να την αποστείλετε ηλεκτρονικά, ",
     "είτε να την εκτυπώσετε και να την καταθέσετε σε έντυπη μορφή."]
  end
  define_slide { ["https://www.gov.gr/ipiresies/polites-kai-kathemerinoteta/psephiaka-eggrapha-gov-gr/psephiake-bebaiose-eggraphou#URL"] }

  define_slide do
    [
      "Β. Ψηφιακές Υπογραφές", "",
      "Πώς υπογράφουμε", "",

      "Μέσα από εφαρμογή (Acrobat, Word, LibreOffice)",
      "Μέσω διαδικτύου (Harica, gov.gr)",
      "Μέσω API"

    ]
  end

  define_slide do
    [
      "Β. Ψηφιακές Υπογραφές", "",
      "Πώς επιβεβαιώνουμε την εγκυρότητα ενός εγγράφου",

    ]
  end

  define_slide { ["aped_signed#PNG"] }
  define_slide { ["aped_sig_panel#PNG"] }
  define_slide { ["aped_cert#PNG"] }

  define_slide { ["aped_root_cert#PNG"] }
  define_slide { ["aped_cert_509#PNG"] }
  define_slide { ["aped_key_usage#PNG"] }

  define_slide { ["gov_footer#PNG"] }
  define_slide { ["gov_verification_link#PNG"] }

  define_slide { ["gov_sig_panel#PNG"] }
  define_slide { ["gov_key_usage#PNG"] }
  define_slide { ["gov_root_cert#PNG"] }


  define_slide do
    [ "Bonus:",
    "Ψηφοφορία με την ψηφιακή κάλπη ΖΕΥΣ",
      "https://zeus.grnet.gr/zeus/resources/"]

  end

  define_slide do
    [
      "Γ. Διαχείριση Κωδικών Πρόσβασης", "",
      "Αναγκαιότητα",
      "Λογισμικά Διαχείρισης Κωδικών Πρόσβασης",
      "Πιστοποίηση Πολλαπλών Παραγώντων (MFA)",
      "Κεντρική Διαχείριση Κωδικών Πρόσβασης",
    ]
  end

  define_slide do
    ["https://www.malwarebytes.com/digital-footprint#SNAPSHOT"]
  end
  define_slide do
    [
      "Γ. Διαχείριση Κωδικών Πρόσβασης", "",
      "Αναγκαιότητα", "",
      "Πολλές υπηρεσίες"

    ]
  end
  define_slide do
    [
      "Γ. Διαχείριση Κωδικών Πρόσβασης", "",
      "Αναγκαιότητα", "",
      "Διαφορετικές πολιτικές ασφαλείας"

    ]
  end
  define_slide do
    [
      "Γ. Διαχείριση Κωδικών Πρόσβασης", "",
      "Αναγκαιότητα", "",
      "Απειλές και Συνέπειες"

    ]
  end
  define_slide do
    [
      "Γ. Διαχείριση Κωδικών Πρόσβασης", "",
      "Λογισμικά Διαχείρισης Κωδικών Πρόσβασης","",
      "Φυλλομετρητές - Browsers"
    ]
  end

  define_slide { ["firefox_1#PNG"] }
  define_slide { ["firefox_2#PNG"] }

  define_slide do
    ["Γ. Διαχείριση Κωδικών Πρόσβασης", "",
     "Λογισμικά Διαχείρισης Κωδικών Πρόσβασης", "",

     "https://keepassxc.org/download/",
     "https://bitwarden.com/products/personal/",
     "https://1password.com",
     "https://www.lastpass.com",
     "https://www.passbolt.com"]
  end

  define_slide do
    [
      "Γ. Διαχείριση Κωδικών Πρόσβασης", "",
      "Πιστοποίηση Πολλαπλών Παραγώντων (MFA)","",
      "Κάτι που ξέρεις",
      "Κάτι που είσαι",
      "Κάτι που έχεις",
    ]
  end
  define_slide do
    [
      "Γ. Διαχείριση Κωδικών Πρόσβασης", "",
      "Κεντρική Διαχείριση Κωδικών Πρόσβασης","",
      "Κεντρικός έλεγχος",
    ]
  end
  define_slide { ["passbolt_1#PNG"] }
  define_slide { ["passbolt_2#PNG"] }
  define_slide { ["passbolt_3#PNG"] }
  define_slide { ["passbolt_4#PNG"] }
  define_slide { ["passbolt_5#PNG"] }
  define_slide { ["passbolt_6#PNG"] }
  define_slide do
    [
      "Γ. Διαχείριση Κωδικών Πρόσβασης", "",
      "Κεντρική Διαχείριση Κωδικών Πρόσβασης","",
      "Ασφαλές Μοίρασμα",
    ]
  end
  define_slide { ["passbolt_7#PNG"] }
  define_slide do
    [
      "Γ. Διαχείριση Κωδικών Πρόσβασης", "",
      "Κεντρική Διαχείριση Κωδικών Πρόσβασης","",
      "Πρόσβαση Εφαρμογών/Διακομιστών",
    ]
  end
  define_slide { ["passbolt_8#PNG"] }
  define_slide { ["passbolt_9#PNG"] }

  define_slide do
    [
      "Δ. Προγραμματισμός και Προστασία Προσωπικών Δεδομένων (Έρευνα)", "",
      "Τί είναι προσωπικά δεδομένα",
      "Γενικός Κανονισμός για την Προστασία Δεδομένων (GDPR)",
      "Προγραμματισμός και Πρόσβαση σε Δεδομένα",
      "Αντιστοίχιση πρόσβασης και προστασίας δεδομένων (Έρευνα)"
    ]
  end
  define_slide do
    [
      "Δ. Προγραμματισμός και Προστασία Προσωπικών Δεδομένων (Έρευνα)", "",
      "Τί είναι προσωπικά δεδομένα",

    ]
  end
  define_slide { ["crud-graduate#PNG"] }

  define_slide do
    [
      "Δ. Προγραμματισμός και Προστασία Προσωπικών Δεδομένων (Έρευνα)", "",
      "Γενικός Κανονισμός για την Προστασία Δεδομένων (GDPR)", "",
      "Νομιμότητα, Αμεροληψία, Διαφάνεια",
      "Περιορισμός σκοπού",
      "Ελαχιστοποίηση δεδομένων",
      "Ακρίβεια - Ορθότητα",
      "Περιορισμός διατήρησης",
      "Ακεραιότητα",
      "Εμπιστευτικότητα",
      "Λογοδοσία",
    ]
  end
  define_slide do
    [
      "Δ. Προγραμματισμός και Προστασία Προσωπικών Δεδομένων (Έρευνα)", "",
      "Προγραμματισμός και Πρόσβαση σε Δεδομένα", "",
      "Create",
      "Read",
      "Update",
      "Delete"
    ]
  end
  define_slide do
    [
      "Δ. Προγραμματισμός και Προστασία Προσωπικών Δεδομένων (Έρευνα)", "",
      "Προγραμματισμός και Πρόσβαση σε Δεδομένα", "",
      "Βάσεις Δεδομένων (Data Access Layer)",
      "Υπηρεσίες Web (REST, GraphQL, SOA)",
      "Πρόσβαση βασισμένη σε ρόλους (RBAC)",
    ]
  end
  define_slide do
    [
      "Δ. Προγραμματισμός και Προστασία Προσωπικών Δεδομένων (Έρευνα)", "",
      "Αντιστοίχιση πρόσβασης και προστασίας δεδομένων", "",
      "Μεθοδολογίες αποτύπωσης απαιτήσεων ιδιωτικότητας (PriS)","",
      "Βασίζονται σε στόχους(goals) ","που πρέπει να πληροί ένα σύστημα"

    ]
  end
  define_slide do
    [
      "Δ. Προγραμματισμός και Προστασία Προσωπικών Δεδομένων (Έρευνα)", "",
      "Αντιστοίχιση πρόσβασης και προστασίας δεδομένων (Έρευνα)", "",
      "Καταγραφή των απαιτήσεων με συστηματικό τρόπο,",
      "στο επίπεδο που απαιτεί η νομοθεσία,",
      "με τη μορφή ενός χρήσιμου εργαλείου υλοποίησης,",
      "για τον προγραμματιστή.",
    ]
  end
  define_slide { ["crud-table_1#PNG"] }
  define_slide { ["crud-table_2#PNG"] }
  define_slide { ["crud-table_3#PNG"] }
  define_slide { ["crud-table_4#PNG"] }

  define_slide do
    [
      "Ευχαριστώ για τη προσοχή σας...",
    ]
  end
  self.present

end
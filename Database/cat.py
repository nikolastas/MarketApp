categories = [["Δημητριακά","Φρυγανίες", "Ζαχαρί", "Ρύζια","Αλευρια & Ειδη Ζαχαροπλαστικής","Ψωμί", "Ζυμαρικά" ,"Όσπρια", "Παντοπολείο", "Αλλαντικά", "Κρέας κά", "Προιόντα Ζύμης", "Κατεψυγμένα Λαχανικά", "Φρέσκα Φρούτα & Λαχανικά", "Ψάρια & Θαλάσσινά"], 
["Γάλα", "Γιαούρτια & Επιδόρπια", "Κρέμες γάλακτος & Βούτυρα", "Παγωτά", "Τυριά", "Αλλα είδη Γάλακτος"], 
["Μπύρες", "Κρασιά","Ποτά" , "Νερά", "Φρεσκοι χυμοί" ,"Χυμοί εκτος ψυγείου & Αναψυκτικά","Μπισκότα", "Ξηροί καρποί","Σοκολάτες", "Αλλα Σνακς", "Καφές & Ροφήματα"],
["Γυναικεία Περιποίηση", "Ανδρική περιποίηση", "Καθαριότητα & Προσωπική Υγειίνή", "Απορρυπαντικά","Περιποίηση Μαλλιών", "Στοματική Υγιεινή", "Ένδυση & Υπόδηση","Προιόντα Περιποιήσης"], 
["Κουζίνα & Μπάνιο","Καθαριστικά Σπιτιού", "Ρούχα", "Εξοπλισμός Σπιτιού"], 
["Βρεφική περιποίηση", "Βρεφικές κρέμες", "Πάνες & Μωρομάντηλα", "Βρεφικά Απορρυπαντικά", "Αξεσουάρ για το μωρό"], 
["Προϊόντα για κατοικίδια", "Βιολογικά Προϊόντα","Άλλα προιόντα"]]

correct_list = ["Ψωμί","Φρέσκα Φρούτα & Λαχανικά", "Ψάρια & Θαλάσσινά","Δημητριακά","Φρεσκοι χυμοί", "Γάλα", 
"Γιαούρτια & Επιδόρπια", "Κρέμες γάλακτος & Βούτυρα", "Καφές & Ροφήματα", "Μπισκότα", "Σοκολάτες",    
"Ξηροί καρποί", "Κρέας κά", "Τυριά", "Αλλαντικά", "Κρασιά" , "Μπύρες", "Αλλα Σνακς", "Φρυγανίες", "Ζαχαρί" , "Αλλα είδη Γάλακτος", "Αλευρια & Ειδη Ζαχαροπλαστικής",
"Ρύζια", "Όσπρια", "Ζυμαρικά" , "Παντοπολείο","Ποτά" ,"Νερά", "Χυμοί εκτος ψυγείου & Αναψυκτικά","Προιόντα Ζύμης", "Κατεψυγμένα Λαχανικά","Παγωτά",  
"Κουζίνα & Μπάνιο","Καθαριστικά Σπιτιού", "Προϊόντα για κατοικίδια", "Απορρυπαντικά", "Βρεφικά Απορρυπαντικά", "Βιολογικά Προϊόντα", "Ρούχα", "Εξοπλισμός Σπιτιού", 
"Γυναικεία Περιποίηση", "Ανδρική περιποίηση", "Καθαριότητα & Προσωπική Υγειίνή", "Περιποίηση Μαλλιών", "Στοματική Υγιεινή", "Ένδυση & Υπόδηση","Προιόντα Περιποιήσης", 
"Βρεφική περιποίηση", "Βρεφικές κρέμες", "Πάνες & Μωρομάντηλα", "Αξεσουάρ για το μωρό",  "Άλλα προιόντα"]
 
for item in categories :
    if(item not in categories):
        print(item)
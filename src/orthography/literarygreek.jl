
"""Mappings of pairs of words written as a single word.
Includes crasis and attached enclitic forms.
"""
crasis = (
    
    knormal("ἔγωγε") => ["ἔγω", "γε"],

    knormal("κἀγὼ") => ["καὶ", "ἐγώ"],
    knormal("κἀκεῖ") => ["καὶ", "ἐκεῖ"],
    knormal("κἀκεῖνος") => ["καὶ", "ἐκεῖνος"],
    
    knormal("τἀληθῆ") => ["τὰ", "ἀληθῆ"],
    knormal("τἆλλα") => ["τὰ", "ἄλλα"]
    
)
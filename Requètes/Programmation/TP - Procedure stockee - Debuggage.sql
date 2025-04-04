-- DEBUGGAGE
-- Selectionner le code à débugger
-- Appuyer sur button Debug
-- F11 => Rentrer dans le code d'une procedure ou fonction
-- F10 => Passer à la ligne suivante

-- Commande qui existe pas
AddArticleToCommande 10,15,2

-- Commande qui existe mais livree
AddArticleToCommande 10248,15,2

-- Commande qui existe non livrée, produit discontinued
AddArticleToCommande 11074,5,2

-- Commande qui existe non livrée, produit non discontinued, montant commande depassé
AddArticleToCommande 11074,15,1000

-- Commande qui existe non livrée, produit non discontinued
AddArticleToCommande 11074,15,2





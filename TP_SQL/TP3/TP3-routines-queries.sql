-- Pour ce TP, nous travaillerons sous MySQL à partir de la BD Employes.
-- Créez-là à partir du script du TD1.

-- Fonctions et procédures

-- 1-Créer une fonction REVENU qui affiche le revenu (salaire + commission)
-- d’un employé donné.


-- 2-Créer une fonction MOYSAL qui affiche la moyenne des revenus mensuels
-- (salaire + commission) des employés d’un département donné.


-- 3-Créer une procédure INSERT_RECAP_EMP qui insère dans une table RECAP_EMP (à créer)
-- une ligne avec la date courant,
-- le nombre d'employés
-- et la somme totale des revenus mensuels (salaire + commission) des employés.



-- Triggers

-- 4-Traduire avec des triggers le fait que le nom d’un département ne peut être
-- que ACCOUNTING, RESEARCH, SALES, OPERATIONS ou HR.
-- Faire tous les tests possibles.


-- 5-Traduire avec des triggers le fait que la commission affectée à un employé
-- doit être inférieure à la moitié de son salaire.
-- Si elle est supérieure, lui affecter la valeur salaire/2.
-- Faire tous les tests possibles.


-- 6-Traduire avec des triggers le fait que tous les employés du département 30
-- doivent avoir une commission. Si un employé n’en a pas, la fixer à 0.
-- Faire tous les tests possibles.


-- 7-Traduire avec des triggers le fait qu'il est interdit d’attribuer une
-- commission à un CLERK sauf s'il appartient au département 20.
-- Faire tous les tests possibles.


-- 8-Regrouper les triggers des questions 5, 6, 7.


-- 9-Traduire avec des triggers le fait qu'il est interdit d’attribuer une
-- commission à un CLERK sauf s'il appartient au département RESEARCH.
-- Réfléchissez-bien aux triggers qu'il faut créer.
-- Faire tous les tests possibles.



-- Curseurs

-- 10-Créer une fonction AFFICH_EMP qui affiche les noms (séparés par une virgule)
-- des employés d'un manager (nom donné en argument).
-- Puis tester la fonction pour KING et pour CLARK.


-- 11-Créer une fonction retournant les noms (séparés par une virgule)
-- des 2 employés les mieux payés (sans utiliser LIMIT, on peut utiliser ORDER BY
-- et sans utiliser de LOOP).


-- 12-Reprendre la fonction précédente et ajouter le cas où la table est vide et
-- le cas où il n’y a qu’un employé.


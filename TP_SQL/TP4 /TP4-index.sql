-- Pour ce TP, nous travaillerons sous MySQL.

-- ********************************************************************************
-- Partie 1 - BD Enseignants (plus d'un million de lignes)
-- ********************************************************************************
-- ********************************************************************************
-- Index sur nomEnseignant
-- ********************************************************************************

-- 1-Sous PhpMyAdmin, créez la base de données BDEnseignants.

-- 2-Puis créez la table suivante :
CREATE TABLE ENSEIGNANTS(
	idEnseignant INT(4) PRIMARY KEY,
	nomEnseignant VARCHAR(50) NOT NULL,
	prenomEnseignant VARCHAR(50) NOT NULL,
	type ENUM('A','B','C')
);

-- 3-Importez le fichier ENSEIGNANTS.sql en ligne de commande.
-- Pour cela, lancer la commande suivante dans un terminal :
docker exec -i mysql-phpmyadmin-db-1 mysql -uroot -pisima BDEnseignants < '/chemin/ENSEIGNANTS.sql'
-- (durée : ~5 minutes, warning normal)
-- Pendant ce temps, réfléchissez à la question suivante :
-- A votre avis, si on crée un index sur nomEnseignant, les requêtes suivantes 
-- seront-elles optimisées ? (ne rien tester pour le moment)
SELECT *
FROM ENSEIGNANTS
WHERE nomEnseignant='Ens29';

SELECT *
FROM ENSEIGNANTS
WHERE prenomEnseignant='Ens29';

SELECT *
FROM ENSEIGNANTS
WHERE nomEnseignant LIKE 'Ens2943%';

SELECT *
FROM ENSEIGNANTS
WHERE nomEnseignant LIKE '%9999';

SELECT *
FROM ENSEIGNANTS
WHERE nomEnseignant='Ens29' OR nomEnseignant='Ens3456';

SELECT *
FROM ENSEIGNANTS
WHERE UPPER(nomEnseignant)='ENS29';

-- 4-Nous allons maintenant faire les tests.
-- Nous travaillerons en ligne de commande pour avoir des temps d'exécution plus fiables :
docker exec -it mysql-phpmyadmin-db-1 bash
mysql -u root -p
Enter password: isima
USE BDEnseignants
-- Lancez les requêtes précédentes en ligne de commande
-- et relevez les temps d'exécution (sans index sur le nom des enseignants).

-- 5-Créez maintenant un index sur le nom des enseignants.

-- 6-Lancez à nouveau les requêtes précédentes cette fois avec l'index.
-- Notez et comparez les temps d'exécution. Vérifiez vos réponses.

-- 7-Supprimez l'index créé précédemment.

-- ********************************************************************************
-- Index sur nomEnseignant, prenomEnseignant
-- ********************************************************************************

-- 8-Lancez les requêtes suivantes (sans index) 
-- en ligne de commande et relevez les temps d'exécution :
SELECT *
FROM ENSEIGNANTS
WHERE nomEnseignant='Ens29';

SELECT *
FROM ENSEIGNANTS
WHERE prenomEnseignant='Ens29';

SELECT *
FROM ENSEIGNANTS
WHERE nomEnseignant='Ens29' AND prenomEnseignant='Ens29';

-- 9-Créez maintenant un index multi-colonnes sur le nom et le prénom des enseignants.

-- 10-Lancez à nouveau les 3 premières requêtes cette fois avec l'index.
-- Notez et comparez les temps d'exécution.

-- 11-Supprimez l'index créé précédemment.

-- ********************************************************************************
-- Index sur UPPER(nomEnseignant)
-- ********************************************************************************

-- 12-Lancez la requête suivante (sans index) 
-- en ligne de commande et relevez le temps d'exécution :
SELECT *
FROM ENSEIGNANTS
WHERE UPPER(nomEnseignant)='ENS29';

-- 13-Observez le plan d'éxécution de la requête
-- en ajoutant EXPLAIN au début de la requête.

-- 14-Créez maintenant un index de fonction sur le nom des enseignants et la fonction UPPER.
CREATE INDEX idx_upper_nom ON ENSEIGNANTS( (UPPER(nomEnseignant)) );

-- 15-Lancez à nouveau la requête cette fois avec l'index.
-- Notez et comparez les temps d'exécution.

-- 16-Observez le nouveau plan d'éxécution et commentez.

-- 17-Supprimez l'index créé précédemment.

-- 18-Supprimez la table ENSEIGNANTS.


-- ********************************************************************************
-- Partie 2 - BD Employes
-- ********************************************************************************

-- 19-Sous PhpMyAdmin, observez les index créés automatiquement par MySQL
-- pour la BD Employes. Qu'en pensez-vous ?

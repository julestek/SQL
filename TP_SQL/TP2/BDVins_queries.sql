-- Q1-Créer les tables VIN et INSPECTEUR de la base de données BDVins :
-- (Créer d'abord la BDVins.)
CREATE TABLE VIN(
  VNUM INT CONSTRAINT PK_VNUM PRIMARY KEY,
  VNOM VARCHAR(30) NOT NULL,
  CEPAGE VARCHAR(30));

CREATE TABLE INSPECTEUR(
  INUM INT CONSTRAINT PK_INUM PRIMARY KEY,
  INOM VARCHAR(30) NOT NULL);

-- Q2-Créer maintenant la table TEST, vous nommerez les contraintes de clés étrangères :
CREATE TABLE TEST(
VNUM INT ,
INUM INT ,
NOTE INT NOT NULL,
TDATE DATE, 
PRIMARY KEY ( VNUM, INUM),
CONSTRAINT VNUM_ETR FOREIGN KEY (VNUM) REFERENCES VIN(VNUM),
CONSTRAINT INUM_ETR FOREIGN KEY (INUM) REFERENCES INSPECTEUR(INUM) );

-- Q3-Ajouter (avec ALTER TABLE) une contrainte dans la table TEST pour indiquer que la note doit être comprise entre 0 et 10.
-- Nommer la contrainte.
ALTER TABLE TEST 
ADD CONSTRAINT NT_NOTE CHECK(0<=NOTE AND NOTE<=10);
-- Q4-Insérer les données des tables VIN, INSPECTEUR puis TEST.
INSERT INTO VIN VALUES (1, 'Cave de Macon', 'Chardonnay');
INSERT INTO VIN VALUES (2, 'Merlot', 'Cabernet Sauvignon');
INSERT INTO VIN VALUES (3, 'Pinot Noir', 'Pinot Noir');
INSERT INTO INSPECTEUR VALUES (1 , 'Magouille');
INSERT INTO INSPECTEUR VALUES (2, 'Intransigeant');
INSERT INTO INSPECTEUR VALUES (3, 'Sympa');
INSERT INTO INSPECTEUR VALUES (4, 'Cool');
INSERT INTO TEST VALUES (1, 1, 7, '2019-04-10');
INSERT INTO TEST VALUES (2, 1, 8, '2019-05-15');
INSERT INTO TEST VALUES (2, 2, 4, '2019-05-20');
INSERT INTO TEST VALUES (2, 3, 9, NULL);
-- Q5-Vérifier le contenu des tables.
SELECT * FROM VIN;
SELECT * FROM INSPECTEUR;
SELECT * FROM TEST;
-- Q6-Insérer le tuple (2, Rigolo) dans la table INSPECTEUR.
INSERT INTO inspecteur VALUES (2, 'Rigolo');
-- Que se passe-t-il ? Pourquoi ?
--Cela ne marche pas car la clé 2 est déjà utilisé.
-- Q7-Insérer le tuple (5, 2, 8, '2020-01-01') dans la table TEST.
INSERT INTO TEST VALUES (5, 2, 8, '2020-01-01');
-- Que se passe-t-il ? Pourquoi ?
--Cela ne marche pas car la clé VNUM=5 n'existe pas dans la table VIN.
-- Q8-Insérer un nouvel inspecteur dans la table INSPECTEUR,
-- à savoir l’inspecteur de numéro 5 et dont on a égaré le nom.
INSERT INTO INSPECTEUR VALUES (5, NULL);
-- Que se passe-t-il ? Pourquoi ?
-- Cela ne marche pas car le nom ne peut pas être null. C'est une contrainte qui a été etabli lors de la création de la table.
-- Q9-Supprimer le vin n°2. Que se passe-t-il ?  Pourquoi ?  
DELETE FROM VIN WHERE VNUM=2 ; 
-- On ne peut pas supprimer le vin n°2 car la table utilise le vnum de vin comme clé etrangère en tant que clé primaire. 

-- Q10-Modifier les contraintes d’intégrité définies sur la table TEST pour
-- obtenir la suppression des tests d’un vin lorsque celui-ci est supprimé de la table VIN.
-- (Pour modifier une contrainte, il faut la supprimer puis la recréer).
ALTER TABLE TEST 
DROP CONSTRAINT VNUM_ETR; 
ALTER TABLE TEST 
ADD CONSTRAINT VNUM_ETR FOREIGN KEY (VNUM) REFERENCES VIN(VNUM) ON DELETE CASCADE;

-- Q11-Supprimer à nouveau le vin n°2 et vérifier la suppression de ses tests.
DELETE FROM VIN WHERE VNUM=2 ; 
-- Q12-Réinsérer le vin 2 ainsi que ses tests dans les tables associées.
INSERT INTO VIN VALUES (2, 'Merlot', 'Cabernet Sauvignon');
INSERT INTO TEST VALUES (2, 1, 8, '2019-05-15');
INSERT INTO TEST VALUES (2, 2, 4, '2019-05-20');
INSERT INTO TEST VALUES (2, 3, 9, NULL);
-- Q13-Faire les modifications de structure pour permettre l’insertion du numéro
-- de téléphone ’03-85-44-12-09’ pour l’inspecteur n°3.
-- Que se passe t-il pour les autres inspecteurs ?
ALTER TABLE INSPECTEUR 
ADD COLUMN NUMEROTEL VARCHAR(60);
UPDATE INSPECTEUR SET NUMEROTEL='03-85-44-12-09' WHERE INUM=3;
-- Le numero des autres inspecteurs est mis à NULL

-- Q14-Faire les modifications de structure pour réduire la longueur de INOM à 6 caractères.
-- Prévoir la récupération des valeurs de cette colonne en les tronquant à 6 caractères.
UPDATE INSPECTEUR
SET INOM=SUBSTRING(INOM,0,7);

ALTER TABLE INSPECTEUR
ALTER COLUMN INOM TYPE VARCHAR(6);
-- Vues
-- Q15-Créer la vue SYNTHESE19 regroupant les attributs CEPAGE, VNUM, VNOM, INOM, NOTE et TDATE pour tous les tests effectués en 2009.
-- Afficher le contenu de cette vue.

CREATE VIEW SYNTHESE19 AS
SELECT CEPAGE, VNUM, VNOM, INOM, NOTE, TDATE
FROM VIN V
JOIN TEST T ON T.VUM = V.VUM
JOIN INSPECTEUR I ON I.INUM = T.INUM
WHERE TO_CHAR(TDATE, 'YYYY') = '2019'

-- Q16-Donner la note moyenne de chaque vin en 2019. On précisera le nom du vin.

SELECT DISTINCT VNOM, AVG(NOTE) AS Moyenne
FROM SYNTHESE19
GROUP BY VNOM

-- Transactions
-- Q17-Commencer une transaction avec BEGIN; (syntaxe PostgreSQL, MySQL)
-- Insérer les trois tuples (10, Relax), (11, Pointu) et (12, Odieux) dans la table INSPECTEUR.
-- Vérifier que tout s’est bien passé.
-- Annuler la dernière transaction et vérifier à nouveau le contenu de la table INSPECTEUR.BEGIN 

BEGIN;

INSERT INTO INSPECTEUR (ID, NOM) VALUES 
(10, 'Relax'),
(11, 'Pointu'),
(12, 'Odieux');

SELECT * FROM INSPECTEUR;

ROLLBACK;

SELECT * FROM INSPECTEUR;
-- Q18-Modifier les instructions de Q17 de manière à ce que la table INSPECTEUR
-- contienne les inspecteurs Pointu et Relax suite à l’annulation de la dernière transaction.
-- Vous devez conserver les 3 ordres INSERT. 

BEGIN;

INSERT INTO INSPECTEUR (INUM, INOM) VALUES 
(10, 'Relax'),
(11, 'Pointu');

COMMIT;

BEGIN;

INSERT INTO INSPECTEUR (INUM, INOM) VALUES (12, 'Odieux');

SELECT * FROM INSPECTEUR;

ROLLBACK;

SELECT * FROM INSPECTEUR;
-- Suppressions
-- Q19-Supprimer la table INSPECTEUR. Que se passe-t'il ? Pourquoi ?
---Les valeurs INUM sont utilisées dans d'autres tables


-- Q20-Supprimer la table TEST.
-- Que se passe-t'il ? Faites-le nécessaire pour supprimer la table.
---On ne peut pas pour la même raison
DROP TABLE TEST CASCADE;
-- Q21-Vider la table VIN. Vérifier que tout s’est bien passé.
DELETE FROM VIN;
-- Q22-Supprimer les tables VIN et INSPECTEUR. Vérifier que tout s’est bien passé.
DROP TABLE VIN;
DROP TABLE INSPECTEUR;

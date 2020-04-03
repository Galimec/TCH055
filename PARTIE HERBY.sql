
--======================================
--===========Question 3=================
--Fonction: f_actif
--Description:
--Fonction qui recçoit en argument le codepermanent d'un étudiant et indique son statut comme étant actif si il
--suit au moins un cours dans la session courante ou bien non actif si les conditions précédentes ne sont pas respecté
--Écris par: Herby Régis
--=======================================

CREATE OR REPLACE FUNCTION f_actif /* La fonction f_actif est créé ici*/

(codepermanent  VARCHAR)
RETURN VARCHAR2 IS

BEGIN
     SELECT COUNT (sigle), dateinscription  /* Ici se produit la sélection des paramètre à évaluer */
     FROM inscription
     WHERE COUNT (sigle) >= 1 AND sysdate BETWEEN dateincription AND  dateabandon  /* le script compte le nombre de sigle auxquelles l'étudiant est inscrit pour valider que l'étudiant est au moins
                                                                                    inscrit a 1 cours et évalue la date actuelle pour voir si elle est inclue entre la date d'inscription et la date
                                                                                    d'abandon de la session*/
     GROUP BY  dateinscription

     IF COUNT (sigle) >= 1 AND sysdate BETWEEN dateincription AND  dateabandon THEN  /* Ici est instancié l'évalution conditionnel de la fonction pour indiquer le statut de l'étudiant*/
     DBMS_OUTPUT.PUT_LINE ('Etudiant actif');
     ELSE
     DBMS_OUTPUT.PUT_LINE ('Etudiant inactif'); 

     END IF;

END f_actif;  /* Fin de la fonction8*/
/

--======================================
--===========Question 8=================
--Trigger: nouvelleCote
--Description:
--Trigger qui fait une mise à jour de la cote d'un étudiant si celui-ci à une note qui est modifié dans son dossier
--Écris par: Herby Régis
--=======================================
CREATE OR REPLACE TRIGGER nouvelleCote   /* Ici on initialise le trigger nouvelleCote*/
AFTER UPDATE ON inscription

DECLARE                                               /* À cette endroit est déclaré une instance considérant les tables mutante généré par
                                                         la fonction f_cotepournote */
    TABLE_MUTANTE EXCEPTION;
    PRAGMA EXCEPTION_INIT(TABLE_MUTANTE,-4091);

BEGIN
     IF NEW.note <> OLD.note THEN                  /* Ici est fait l'évaluation de l'état de la note si elle a été modifié ou non pour ensuite appeler la fonction  f_cotepournote
                                                      et l'instancier avec la nouvelle note mise à jour dans le bu d'avoir une nouvelle cote*/
     f_cotepournote(NEW.note);
     END IF;

EXCEPTION
        WHEN TABLE_MUTANTE THEN                      /* À cette endroit est déclaré une instance considérant les tables mutante généré par la fonction f_cotepournote */
        DBMS_OUTPUT.PUT_LINE('Alerte');
END;
/

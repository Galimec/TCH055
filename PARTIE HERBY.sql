
--======================================
--===========Question 3=================
--Fonction: f_actif
--Description:
--Fonction qui rec�oit en argument le codepermanent d'un �tudiant et indique son statut comme �tant actif si il
--suit au moins un cours dans la session courante ou bien non actif si les conditions pr�c�dentes ne sont pas respect�
--�cris par: Herby R�gis
--=======================================

CREATE OR REPLACE FUNCTION f_actif /* La fonction f_actif est cr�� ici*/

(codepermanent  VARCHAR)
RETURN VARCHAR2 IS

BEGIN
     SELECT COUNT (sigle), dateinscription  /* Ici se produit la s�lection des param�tre � �valuer */
     FROM inscription
     WHERE COUNT (sigle) >= 1 AND sysdate BETWEEN dateincription AND  dateabandon  /* le script compte le nombre de sigle auxquelles l'�tudiant est inscrit pour valider que l'�tudiant est au moins
                                                                                    inscrit a 1 cours et �value la date actuelle pour voir si elle est inclue entre la date d'inscription et la date
                                                                                    d'abandon de la session*/
     GROUP BY  dateinscription

     IF COUNT (sigle) >= 1 AND sysdate BETWEEN dateincription AND  dateabandon THEN  /* Ici est instanci� l'�valution conditionnel de la fonction pour indiquer le statut de l'�tudiant*/
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
--Trigger qui fait une mise � jour de la cote d'un �tudiant si celui-ci � une note qui est modifi� dans son dossier
--�cris par: Herby R�gis
--=======================================
CREATE OR REPLACE TRIGGER nouvelleCote   /* Ici on initialise le trigger nouvelleCote*/
AFTER UPDATE ON inscription

DECLARE                                               /* � cette endroit est d�clar� une instance consid�rant les tables mutante g�n�r� par
                                                         la fonction f_cotepournote */
    TABLE_MUTANTE EXCEPTION;
    PRAGMA EXCEPTION_INIT(TABLE_MUTANTE,-4091);

BEGIN
     IF NEW.note <> OLD.note THEN                  /* Ici est fait l'�valuation de l'�tat de la note si elle a �t� modifi� ou non pour ensuite appeler la fonction  f_cotepournote
                                                      et l'instancier avec la nouvelle note mise � jour dans le bu d'avoir une nouvelle cote*/
     f_cotepournote(NEW.note);
     END IF;

EXCEPTION
        WHEN TABLE_MUTANTE THEN                      /* � cette endroit est d�clar� une instance consid�rant les tables mutante g�n�r� par la fonction f_cotepournote */
        DBMS_OUTPUT.PUT_LINE('Alerte');
END;
/

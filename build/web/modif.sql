ALTER TABLE public.recette ALTER COLUMN idcaisse TYPE integer;

-- Column: idcaisse

-- ALTER TABLE public.membrecycle DROP COLUMN idcaisse;

ALTER TABLE public.membrecycle ADD COLUMN idcaisse integer;

-- Foreign Key: public.fk_caisse_membrecycle

-- ALTER TABLE public.membrecycle DROP CONSTRAINT fk_caisse_membrecycle;

ALTER TABLE public.membrecycle
  ADD CONSTRAINT fk_caisse_membrecycle FOREIGN KEY (idcaisse)
      REFERENCES public.caisse (idcaisse) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL;


ALTER TABLE public.mouchard
  ADD CONSTRAINT fk_mouchard_idcompte_utilisateur FOREIGN KEY (idcompte_utilisateur)
      REFERENCES public.compteutilisateur (idcompte) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


-- Foreign Key: public.fk_depense_idcaisse

-- ALTER TABLE public.depense DROP CONSTRAINT fk_depense_idcaisse;

ALTER TABLE public.depense
  ADD CONSTRAINT fk_depense_idcaisse FOREIGN KEY (idcaisse)
      REFERENCES public.caisse (idcaisse) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;



-- Foreign Key: public.fk_privilege_idcompte_utilisateur

-- ALTER TABLE public.privilege DROP CONSTRAINT fk_privilege_idcompte_utilisateur;

ALTER TABLE public.privilege
  ADD CONSTRAINT fk_privilege_idcompte_utilisateur FOREIGN KEY (idcompte_utilisateur)
      REFERENCES public.compteutilisateur (idcompte) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


-- Foreign Key: public.fk_recette_idcaisse

-- ALTER TABLE public.recette DROP CONSTRAINT fk_recette_idcaisse;

ALTER TABLE public.recette
  ADD CONSTRAINT fk_recette_idcaisse FOREIGN KEY (idcaisse)
      REFERENCES public.caisse (idcaisse) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;



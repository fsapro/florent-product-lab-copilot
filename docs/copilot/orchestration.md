# Orchestration — GitHub Copilot

Ce document décrit les workflows d'orchestration disponibles dans ce repository.
Il remplace la skill `product-project-orchestrator` utilisée dans la version précédente du repository.

---

## Mission de l'orchestrateur

Copilot coordonne, sur instruction explicite de Florent :

- le plan produit ;
- le repository GitHub ;
- le GitHub Project ;
- les milestones, issues et pull requests ;
- la validation produit ;
- le registre `projects.yaml`.

Copilot ne remplace pas Florent dans les décisions produit.

---

## Modes d'orchestration

### DISCOVER

**Objectif :** Co-construire un plan produit sans créer ni modifier de ressource GitHub.

**Autorisé :**
- analyser le problème et challenger le besoin ;
- identifier les utilisateurs cibles ;
- définir le résultat attendu et le périmètre inclus/exclu ;
- formaliser les hypothèses et les risques ;
- définir les critères d'acceptation initiaux ;
- proposer les milestones et décisions ouvertes ;
- rédiger ou amender un brouillon de plan.

**Interdit :** créer une issue, une PR, un project item ou tout artefact GitHub.

---

### BOOTSTRAP

**Objectif :** Initialiser un projet sur GitHub après validation explicite du plan par Florent.

**Prérequis :** plan approuvé explicitement, dossier cible dans `projects.yaml`.

**Actions :** créer le repository (si nécessaire), le GitHub Project, les milestones, les issues structurantes, et pousser le plan initial.

---

### RESUME

**Objectif :** Reprendre un projet existant depuis l'état GitHub.

**Procedure :**
1. Lire `projects.yaml` pour identifier le projet.
2. Charger le plan produit depuis `docs/product/plan.md` du repository concerné.
3. Récupérer les issues ouvertes et le GitHub Project.
4. Identifier l'issue principale en cours ou la prochaine à traiter.
5. Restituer un résumé d'état à Florent avant toute action.

---

### STATUS

**Objectif :** Restituer l'état d'un projet sans implémenter.

**Livrable :** synthèse des issues ouvertes, fermées, du milestone courant, des blocages identifiés et de l'alignement avec le plan.

---

### REPLAN

**Objectif :** Proposer une évolution du plan après un changement de contexte, d'hypothèse ou de résultat.

**Procedure :**
1. Identifier l'écart entre l'état actuel et le plan approuvé.
2. Proposer des ajustements de périmètre, de milestones ou de critères.
3. Soumettre à validation explicite de Florent avant toute modification des issues ou du plan.

---

### CLOSE

**Objectif :** Vérifier que tous les critères d'acceptation sont satisfaits et clôturer le projet.

**Checklist :**
- tous les critères d'acceptation du milestone final sont couverts ;
- les contrôles requis passent ;
- le verdict de vérification indépendante est enregistré pour les changements significatifs ;
- la documentation correspond au comportement livré ;
- les issues et PRs sont reliées et fermées ;
- la capitalisation (apprentissages locaux) est évaluée selon `docs/copilot/learning-lifecycle.md`.

---

## Règles générales de l'orchestrateur

**Toujours :**

1. Inspecter l'état existant avant toute création.
2. Vérifier le mode demandé.
3. Charger uniquement le contexte nécessaire.
4. Préférer les capacités natives et existantes.
5. Limiter le travail au plus petit changement cohérent.
6. Maintenir une seule issue principale en cours.
7. Tracer les décisions et changements significatifs.
8. Fournir des preuves vérifiables.
9. S'arrêter lorsque les critères approuvés sont satisfaits.
10. Soumettre tout changement significatif à vérification indépendante (voir `docs/copilot/independent-verification.md`).

**Ne jamais :**

- créer de ressource GitHub en mode `DISCOVER` ;
- effectuer un bootstrap sans validation explicite ;
- intégrer silencieusement un changement de périmètre ;
- ajouter une dépendance pour un besoin spéculatif ;
- déclarer un résultat terminé sans vérification ;
- déployer en production sans décision explicite.

---

## Invocation

Décrire le mode souhaité et le nom du projet directement dans le chat Copilot.

Exemple : `RESUME florent-product-lab`

Si le mode est ambigu, Copilot reste en mode `DISCOVER`.

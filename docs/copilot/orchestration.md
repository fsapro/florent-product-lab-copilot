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

**Objectif :** Initialiser un projet sur GitHub après validation explicite du plan par Florent, avec un repository immédiatement exploitable — jamais un repository vide de contenu.

**Prérequis :** plan approuvé explicitement, dossier cible dans `projects.yaml`.

**Principe directeur :** le contenu du repository (scaffold) est poussé **avant** toute métadonnée GitHub qui le référence (issues, milestones). L'ordre inverse produit un repository dont le clone local est vide au moment où Florent l'ouvre, alors que des issues y font déjà référence — état incohérent et facilement manqué.

**Séquence obligatoire :**

1. **Pré-vol.** Vérifier les scopes `gh auth status` (au minimum `repo`, `project`, `read:project`). Rafraîchir (`gh auth refresh -s project,read:project`) avant de commencer plutôt qu'au milieu de la séquence.
2. **Registre.** Ajouter ou mettre à jour l'entrée du projet dans `projects.yaml` (nom, repository cible, ressources externes connues).
3. **Repository.** Créer le repository GitHub (confirmation avant création).
4. **Scaffold — étape non-sautable.** Copier le contenu de `templates/product-agent-template/` (README, `.github/copilot-instructions.md`, `.github/PULL_REQUEST_TEMPLATE.md`, `docs/product/plan.md`, `docs/decisions/`, `docs/learnings/`, `docs/independent-verification.md`, `docs/learning-lifecycle.md`) vers le nouveau repository, en adaptant `docs/product/plan.md` au plan réellement approuvé. Pousser ce contenu en un ou plusieurs commits initiaux.
5. **Vérification anti-repo-vide.** Confirmer via l'API (`gh api repos/<repo>/contents` ou équivalent) que le repository contient au minimum `README.md` et `docs/product/plan.md` avant de passer à l'étape suivante. Ne jamais annoncer le bootstrap terminé sans cette vérification.
6. **Vérification de complétude du scaffold.** Comparer la liste des fichiers du template (`templates/product-agent-template/`, récursivement) à la liste des fichiers effectivement présents dans le nouveau repository. Un fichier manquant (ex. `.github/PULL_REQUEST_TEMPLATE.md`, `docs/learnings/learning-log.yaml`) bloque le passage à l'étape suivante — le compléter avant de continuer.
7. **Vérification anti-indirection.** Confirmer que `.github/copilot-instructions.md` du nouveau repository contient directement (inline) les règles non-négociables — rôles, règles fondamentales, protection du périmètre, fin de tâche — et non un simple renvoi vers un autre fichier (type `COPILOT.md`). Seul `.github/copilot-instructions.md` est nativement chargé par GitHub Copilot ; toute règle non-négociable qui vivrait uniquement ailleurs ne sera pas fiablement appliquée.
8. **Milestones.** Créer les milestones depuis les phases du plan approuvé.
9. **Issues.** Créer les issues structurantes du **premier milestone uniquement** (pas toutes les phases d'un coup), rattachées au milestone correspondant.
10. **GitHub Project.** Créer le Project et y rattacher les issues créées.
11. **Confirmation.** Restituer à Florent : repository, contenu poussé, milestones, issues, Project — avec liens directs.

**Pièges connus (ne pas reproduire) :**

- Créer les métadonnées GitHub (issues/milestones) avant le scaffold laisse un repository vide au clone — toujours scaffold d'abord.
- `gh repo create` sans `--add-readme` ne crée aucun commit initial : le repository n'a pas de branche par défaut tant qu'aucun fichier n'est poussé.
- Les scopes `project`/`read:project` ne sont pas inclus par défaut dans un token `gh auth login` existant ; les demander en pré-vol évite une interruption en cours de séquence.
- En PowerShell, `gh api ... -f title=$hashtable.title` ne s'interpole pas correctement (sérialise l'objet au lieu de la valeur) — préférer un script Python ou des chaînes explicites pour tout appel `gh api` scripté avec des variables structurées.
- Ne pas créer les issues de toutes les phases dès le bootstrap si le plan en comporte plusieurs : seul le premier milestone est instancié en issues ; les suivants sont créés au fil de l'avancement (mode `RESUME`/`REPLAN`).
- Un scaffold partiel (fichiers du template non copiés en intégralité) et une architecture d'indirection (règles non-négociables déportées hors de `.github/copilot-instructions.md`) sont les deux causes racines identifiées d'un drift de gouvernance déjà observé sur un projet enfant — d'où les étapes 6 et 7 ci-dessus.

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

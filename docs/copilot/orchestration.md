# Orchestration — GitHub Copilot

Ce document décrit les workflows d'orchestration disponibles dans ce repository.
Il remplace la skill `product-project-orchestrator` utilisée dans la version précédente du repository.

---

## Mission de l'orchestrateur

Copilot coordonne, sur instruction explicite du PM :

- le plan produit ;
- le repository GitHub ;
- le GitHub Project ;
- les milestones, issues et pull requests ;
- la validation produit ;
- le registre `projects.yaml`.

Copilot ne remplace pas le PM dans les décisions produit.

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

### ADOPT

**Objectif :** Inscrire un projet existant (brownfield) dans le framework — repository avec du code, un historique, et éventuellement une gouvernance ou des issues déjà en place — sans jamais remettre en question le travail déjà réalisé.

**Prérequis :** aucun plan à valider au sens DISCOVER. Le travail existant du repository cible est traité comme une baseline validée par défaut.

**Différence structurelle avec BOOTSTRAP :** BOOTSTRAP suppose un repository greenfield (vide, scaffold = premier commit, écrasement sans risque). ADOPT suppose un repository dans un état **inconnu et quelconque** (aucune gouvernance, gouvernance custom divergente, issues/PRs actives, historique long). Le scaffold y est donc **idempotent** (n'ajoute que ce qui manque, ne remplace jamais sans confirmation explicite) et la livraison se fait par défaut via **PR** plutôt que par push direct.

**Séquence obligatoire :**

1. **Découverte read-only.** Avant tout geste d'écriture : README, historique git, `.github/copilot-instructions.md` existant, `docs/` existants, issues/PRs ouvertes, milestones, protection de branche, CI existante.
2. **Aucune remise en question de l'existant.** Ne jamais proposer de refonte ni challenger les choix déjà faits — seulement identifier ce qui manque pour l'inscription dans le framework.
3. **Détection de conflit de gouvernance.** Si `.github/copilot-instructions.md` existe déjà et diverge du template, présenter le diff au PM et obtenir une décision explicite (garder / remplacer / fusionner).
4. **Scaffold idempotent.** Copier uniquement les fichiers du template absents du repository cible ; ne jamais écraser un fichier existant sans confirmation explicite.
5. **Reconstitution minimale du plan.** Générer `docs/product/plan.md` depuis l'existant, en marquant explicitement les sections reconstituées comme « à confirmer ».
6. **Registre.** Ajouter/compléter l'entrée `projects.yaml` avec `status: active`, `origin: adopted`, `adopted_at: <date>`, phases inférées des milestones existants sinon `phase-0 — Adoption`. Vérifier au préalable qu'une entrée `origin: adopted` n'existe pas déjà (garde-fou anti double-exécution).
7. **Aucune issue rétroactive.** Ne créer aucune issue pour du travail déjà fait.
8. **Aucune opération git destructive.** Jamais de force-push, de réécriture d'historique, ou de suppression de branche.
9. **Livraison via PR par défaut.** Sauf confirmation explicite du PM que le repository est mono-contributeur sans protection de branche.
10. **Vérification finale.** Mêmes garde-fous que BOOTSTRAP (contenu réellement présent, scaffold complet, gouvernance inline non indirecte).
11. **Confirmation au PM.** Repository, fichiers ajoutés, entrée `projects.yaml`, lien PR (ou commit), plan reconstitué à valider.

**Pièges connus (spécifiques au brownfield) :**

- Un `.github/copilot-instructions.md` existant mais incomplet peut sembler « déjà présent » sans contenir les règles inline requises — toujours comparer le contenu, pas seulement la présence du fichier.
- Des issues actives existantes ne doivent jamais être réorganisées pour coller au modèle `phases`/`milestones` sans décision explicite du PM (relève de `REPLAN`, pas d'ADOPT).
- Une branche par défaut protégée empêche un push direct : la découvrir en amont (étape 1) évite un échec en fin de séquence.
- Reconstituer un plan trop détaillé à partir de peu d'éléments donne une fausse impression de validation — toujours marquer les sections reconstituées comme « à confirmer ».

---

### BOOTSTRAP

**Objectif :** Initialiser un projet sur GitHub après validation explicite du plan par le PM, avec un repository immédiatement exploitable — jamais un repository vide de contenu.

**Prérequis :** plan approuvé explicitement, dossier cible dans `projects.yaml`.

**Principe directeur :** le contenu du repository (scaffold) est poussé **avant** toute métadonnée GitHub qui le référence (issues, milestones). L'ordre inverse produit un repository dont le clone local est vide au moment où le PM l'ouvre, alors que des issues y font déjà référence — état incohérent et facilement manqué.

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
11. **Confirmation.** Restituer au PM : repository, contenu poussé, milestones, issues, Project — avec liens directs.

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
5. Restituer un résumé d'état au PM avant toute action.

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
3. Soumettre à validation explicite du PM avant toute modification des issues ou du plan.

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
11. Avant tout commit (quel que soit le mode), inspecter explicitement l'état git (`git status`, `git diff --stat`) et ne stager que les fichiers attendus pour la tâche en cours.

**Ne jamais :**

- créer de ressource GitHub en mode `DISCOVER` ;
- effectuer un bootstrap sans validation explicite ;
- intégrer silencieusement un changement de périmètre ;
- ajouter une dépendance pour un besoin spéculatif ;
- déclarer un résultat terminé sans vérification ;
- déployer en production sans décision explicite.
- utiliser `git add -A` (ou équivalent) sans avoir revu au préalable la liste des fichiers stagés — quel que soit le mode.

Deux niveaux d'invocation sont disponibles :

- **User-level (cross-repo)** : si la skill `product-orchestrator` est installée
  (`setup/install.ps1`), décrire le mode et le projet directement dans le chat
  Copilot depuis n'importe quel repository. La skill détecte le contexte (repository
  meta ou repository enfant) et route en conséquence — voir
  `setup/user-skills/product-orchestrator/SKILL.md`.
- **Local (ce repository uniquement)** : décrire le mode et le projet directement
  dans le chat Copilot en ayant ce workspace ouvert ; les prompts `.github/prompts/`
  sont invocables via `/discover`, `/bootstrap`, `/adopt`, etc.

Exemple : `RESUME florent-product-lab`

Si le mode est ambigu, Copilot reste en mode `DISCOVER`.

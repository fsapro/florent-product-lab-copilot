---
agent: agent
description: Initialiser un projet sur GitHub après validation explicite du plan
---

# BOOTSTRAP — Initialisation de projet

Mode : BOOTSTRAP
Projet : [nom du projet]

Prérequis : plan produit validé explicitement par le PM. Le Solution Design sera produit
dans le repository projet après bootstrap ; aucune issue de développement ne peut être
marquée `Ready` avant `Solution Design: Approved`.

Principe directeur : le repository ne doit jamais être laissé vide pendant que des métadonnées GitHub (issues, milestones) y font déjà référence. Le contenu (scaffold) est toujours poussé avant les métadonnées.

## Instructions pour Copilot

1. Vérifier que le plan est approuvé explicitement (ne pas assumer).
2. Vérifier les scopes `gh auth status` (`repo`, `project`, `read:project`). Si absents, exécuter `gh auth refresh -s project,read:project` maintenant plutôt qu'en cours de séquence.
3. Lire `projects.yaml` pour vérifier si le projet existe déjà ; l'ajouter ou le mettre à jour sinon.
4. Créer le repository GitHub si nécessaire. Ne demander confirmation que si le nom, la visibilité, l'organisation ou le périmètre du repository ne sont pas déterminés par le plan approuvé.
5. **Scaffold et initialisation spec-kit** :
   a. Copier `templates/product-agent-template/` (README, `.github/copilot-instructions.md`, `.github/PULL_REQUEST_TEMPLATE.md`, `docs/product/plan.md` adapté au plan réel, `docs/decisions/`, `docs/learnings/`, `docs/independent-verification.md`) et pousser ce contenu en commit initial — avant toute création d'issue ou de milestone.
   b. Exécuter `specify init` dans le repository pour créer `.specify/` et initialiser la constitution spec-kit. Coller le Principe VI (voir `docs/spec-kit-adoption.md` du repo méta) dans `.specify/memory/constitution.md`.
   c. Pousser le résultat avant de continuer.
6. **Vérifier** que le repository contient effectivement ce contenu (lecture API ou `git ls-remote` / `gh api repos/<repo>/contents`) avant de continuer. Ne jamais déclarer le bootstrap terminé sans cette vérification explicite.
7. **Vérifier la complétude** : comparer la liste des fichiers du template à ceux effectivement copiés. Compléter tout fichier manquant avant de continuer.
8. **Vérifier l'absence d'indirection** : `.github/copilot-instructions.md` du nouveau repository doit contenir directement (inline) les règles non-négociables (rôles, règles fondamentales, protection du périmètre, fin de tâche) — pas un renvoi vers un autre fichier. C'est le seul fichier nativement chargé par GitHub Copilot.
9. Créer les milestones depuis les phases du plan approuvé.
10. Créer les issues structurantes du **premier milestone uniquement**, rattachées à ce milestone, limitées à Solution Design et préparation. Aucune issue de développement ne doit être `Ready` avant `Solution Design: Approved`.
11. Créer le GitHub Project et y rattacher les issues créées.
12. Confirmer l'état initial au PM avec liens directs (repo, milestones, issues, Project).

## Contraintes

- Ne pas bootstrapper sans validation explicite du plan.
- Ne pas demander de validation PM ressource par ressource lorsque le plan est approuvé et que les repositories, milestones, issues et Project sont déterministes.
- Demander une décision PM uniquement en cas d'ambiguïté, conflit avec une ressource existante, nouveau coût/service, changement de périmètre ou décision difficile à inverser.
- Ne créer que les issues du premier milestone, pas toutes les phases.
- Les issues créées au bootstrap préparent le Solution Design et le delivery ; elles ne déclenchent pas de développement tant que le Solution Design n'est pas `Approved`.
- Ne jamais annoncer un bootstrap "terminé" sans avoir vérifié que le repository contient du contenu réel (pas seulement des métadonnées GitHub).
- Avant tout commit, inspecter explicitement `git status` / `git diff --stat` et ne stager que les fichiers du scaffold attendu. Ne jamais utiliser `git add -A` sans cette revue — un artefact d'une autre session ou d'un autre projet ne doit jamais se retrouver inclus.
- Appliquer la gestion Git/PR autonome définie dans `.github/copilot-instructions.md` du repository cible : Copilot prépare, publie et fusionne si le périmètre est respecté, les contrôles passent et aucun arbitrage produit n'est requis.

## Pièges connus

- `gh repo create` sans `--add-readme` ne crée aucune branche par défaut tant qu'aucun fichier n'est poussé — un clone immédiat après création paraîtra vide, ce qui est normal seulement si le scaffold n'a pas encore été poussé.
- Les scopes `project`/`read:project` manquent souvent sur un token `gh` existant : les vérifier en amont évite une interruption au milieu de la séquence (auth device flow).
- En PowerShell, éviter `gh api ... -f champ=$objet.propriete` pour des valeurs structurées (sérialisation incorrecte) ; préférer un script Python ou des littéraux de chaîne explicites.
- Ne jamais créer un fichier de gouvernance narratif (type `COPILOT.md`) supposé être lu à chaque session : seul `.github/copilot-instructions.md` est nativement chargé par GitHub Copilot. Toute règle non-négociable doit y vivre directement.

## Output attendu

Repository initialisé **avec contenu poussé et vérifié**, GitHub Project créé,
milestones du plan créés, issues de Solution Design/préparation du premier milestone
créées et rattachées, état confirmé au PM avec liens directs.

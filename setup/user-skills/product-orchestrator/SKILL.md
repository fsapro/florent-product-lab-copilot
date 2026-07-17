---
name: product-orchestrator
description: 'Orchestrateur produit multi-projets, installe au niveau utilisateur (cross-repo). Detecte l etat reel (projects.yaml, GitHub issues, Project, PRs) et route vers le mode approprie : DISCOVER (cadrer un nouveau projet), BOOTSTRAP (initialiser apres validation), ADOPT (inscrire un projet existant/brownfield sans remettre en question le travail deja fait), RESUME (reprendre un projet existant), STATUS (etat sans implementer), REPLAN (faire evoluer le plan), CLOSE (verifier et cloturer). Use when: orchestrer un projet produit, cadrer un projet, initialiser un projet, inscrire un projet existant dans le framework, reprendre un projet, ou quand le PM decrit un mode (DISCOVER/BOOTSTRAP/ADOPT/RESUME/STATUS/REPLAN/CLOSE) et un nom de projet sans preciser explicitement quel prompt utiliser.'
argument-hint: '<MODE optionnel> <nom-du-projet>'
---

# Orchestrateur produit (user-level)

Point d'entree cross-repo de l'orchestration multi-projets. Cette skill vit dans le
profil utilisateur (`~/.copilot/skills/`), pas dans un repository : elle est donc
disponible quel que soit le workspace ouvert.

Source versionnee de ce fichier : `setup/user-skills/product-orchestrator/SKILL.md`
du repository meta `florent-product-lab-copilot`. Toute modification doit etre faite
sur la source puis re-deployee via `setup/install.ps1` (voir `setup/README.md`).

## Regle absolue — anti-implementation prematuree

Cette regle prime sur toute autre consideration, y compris l'instinct par defaut
d'un agent a etre proactif et a livrer directement du code :

- **Ne jamais creer le moindre fichier, dossier, scaffold ou code** pour une demande
  du type « je veux creer un nouveau projet » tant que le mode `DISCOVER` n'a pas
  ete explicitement traverse (ou qu'une baseline `ADOPT` n'a pas ete confirmee) et
  qu'un plan n'a pas ete valide explicitement par le PM.
- Cette regle s'applique **quel que soit le mode d'invocation** de cette skill —
  installation active (`~/.copilot/skills/`) ou simple reference de fichier
  (`@file:`) — et **quel que soit le workspace ouvert**, y compris un dossier vide
  ou un repository totalement hors du registre `projects.yaml`.
- Avant de creer quoi que ce soit, s'auto-verifier explicitement :
  1. Le mode a-t-il ete confirme explicitement par le PM (pas seulement devine) ?
  2. Si le mode est `BOOTSTRAP` ou `ADOPT`, le plan ou la baseline sont-ils valides
     explicitement ?
  Si l'une des deux reponses est non, s'arreter et proposer `DISCOVER` (ou
  completer la validation manquante) plutot que d'implementer quoi que ce soit.
- Une demande formulee sans nom de projet ni plan prealable (ex. « je veux creer un
  nouveau projet ») declenche TOUJOURS une collecte d'etat puis `DISCOVER` en
  premier — jamais une generation directe de fichiers ou d'architecture.

## Etape 0 — Collecte d'etat (obligatoire avant tout routage)

Ne jamais choisir un mode par supposition. Avant de router :

1. Determiner si le workspace courant est le repository meta (presence d'un fichier
   `projects.yaml` a la racine), un repository projet enfant (presence de
   `.github/skills/project-orchestrator/SKILL.md` et `docs/product/plan.md`), ou un
   **workspace ambigu** (ni l'un ni l'autre — dossier vide, nouveau repository local,
   ou projet totalement hors du framework). Dans ce troisieme cas, ne jamais assumer
   un mode ni commencer a creer des fichiers : le point d'entree par defaut est
   `DISCOVER`, a mener depuis le repository meta `florent-product-lab-copilot`.
2. Si repository meta : lire `projects.yaml` pour verifier l'etat d'enregistrement du
   projet cite.
3. Si repository enfant : verifier la presence d'une skill locale
   `.github/skills/project-orchestrator/SKILL.md` et de `docs/product/plan.md`.
4. Executer `gh issue list --state open` et verifier le GitHub Project associe avant
   de conclure sur l'etat d'avancement.

## Procedure de routage

1. **Identifier le projet** depuis l'argument fourni, ou le demander si ambigu.
2. **Determiner le contexte** (etape 0) : repository meta ou repository enfant.
3. **Si le mode demande est DISCOVER, BOOTSTRAP ou ADOPT** :
   - Ces modes necessitent `projects.yaml` (cross-projets). Si le workspace courant
     n'est pas le repository meta, indiquer d'ouvrir `florent-product-lab-copilot`
     plutot que d'improviser une creation de ressource GitHub locale.
   - Si c'est bien le repository meta, executer `.github/prompts/discover.prompt.md`,
     `.github/prompts/bootstrap.prompt.md` ou `.github/prompts/adopt.prompt.md` selon
     le mode demande.
4. **Si le mode demande est RESUME, STATUS, REPLAN ou CLOSE** :
   - Si une skill locale `project-orchestrator` existe dans le repository courant,
     la deleguer (elle a le contexte complet du plan et des issues locales).
   - Sinon, executer directement le prompt correspondant du repository courant
     (`.github/prompts/<mode>.prompt.md`) s'il existe, ou l'equivalent du
     repository meta si on y travaille.
5. **Si aucun mode n'est donne** : deduire le mode le plus probable a partir de
   l'etat detecte (voir arbre de decision ci-dessous), puis le proposer avant de
   l'executer — ne jamais executer un mode devine sans confirmation explicite.

## Arbre de decision (etat -> mode probable)

| Etat detecte | Mode probable |
|---|---|
| Projet absent de `projects.yaml`, aucun plan approuve | `DISCOVER` |
| Workspace ambigu (ni meta, ni enfant bootstrappe), demande de type « nouveau projet » sans nom ni plan | `DISCOVER` (a mener dans le repository meta, jamais localement) |
| Projet dans `projects.yaml`, plan approuve, mais aucun repository/issue GitHub cree | `BOOTSTRAP` |
| Repository existant (code/historique) sans gouvernance Copilot ni entree `projects.yaml` | `ADOPT` |
| Repository existant, issues ouvertes, pas de session recente | `RESUME` |
| Demande d'etat sans intention d'agir | `STATUS` |
| Ecart constate entre le plan approuve et la realite observee | `REPLAN` |
| Tous les criteres d'acceptation du milestone final semblent couverts | `CLOSE` |

## References

- Documentation complete de chaque mode : `docs/copilot/orchestration.md` du repository meta.
- Procedures executables : `.github/prompts/*.prompt.md` du repository meta ou du repository enfant selon le contexte.
- Registre multi-projets : `projects.yaml` du repository meta.

## Contraintes

- Ne jamais executer un mode sans avoir explicite l'etat detecte et obtenu confirmation
  si ce n'est pas l'utilisateur qui a nomme le mode lui-meme.
- Ne jamais creer de fichier, dossier, scaffold ou code pour un « nouveau projet »
  avant d'avoir traverse `DISCOVER` (ou confirme une baseline `ADOPT`) et obtenu une
  validation explicite du PM — y compris si cette skill est invoquee par simple
  reference de fichier plutot que par installation active.
- Ne jamais creer de ressource GitHub en dehors des modes `BOOTSTRAP` ou `ADOPT` valides,
  et jamais sans que le workspace courant soit le repository meta.
- Avant tout commit, quel que soit le mode, inspecter explicitement `git status` /
  `git diff --stat` et ne stager que les fichiers attendus pour la tache en cours.
  Ne jamais utiliser `git add -A` (ou equivalent) sans cette revue prealable : un
  repository embarque, un fichier de registre modifie par une autre session, ou tout
  artefact inattendu doit etre signale au PM avant d'etre inclus dans un commit.
- En mode `ADOPT`, ne jamais remettre en question le travail deja realise dans le
  repository cible, ne jamais ecraser un fichier existant sans confirmation explicite,
  et ne jamais creer d'issue retroactive pour du travail deja fait.
- Reprendre l'etat depuis GitHub et `projects.yaml`, jamais depuis la memoire du chat
  seule.

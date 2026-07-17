---
name: project-orchestrator
description: 'Orchestrateur de ce projet. Detecte l etat reel (docs/product/plan.md, GitHub issues, Project, PRs) et route vers le mode approprie : RESUME (reprendre le travail), STATUS (etat sans implementer), REPLAN (faire evoluer le plan), CLOSE (verifier et cloturer). Use when: reprendre ce projet, orchestrer ce projet, ou quand le PM decrit un mode (RESUME/STATUS/REPLAN/CLOSE) sans preciser explicitement quel prompt utiliser.'
argument-hint: '<MODE optionnel>'
---

# Orchestrateur de projet

Point d'entree unique pour reprendre ce projet. Ce skill ne duplique pas la logique de
chaque mode (elle vit dans `.github/prompts/*.prompt.md`) — il **detecte l'etat** et
route vers le bon mode avant de l'executer.

`DISCOVER` et `BOOTSTRAP` n'existent pas ici : ce sont des modes du repository meta
(creation de ressources GitHub cross-projets, registre `projects.yaml`). Ce repository
a deja ete bootstrappe.

## Etape 0 — Collecte d'etat (obligatoire avant tout routage)

Ne jamais choisir un mode par supposition. Avant de router :

1. Lire `docs/product/plan.md` (plan approuve).
2. Executer `gh issue list --state open` pour ce repository.
3. Verifier le GitHub Project associe et les pull requests ouvertes (`gh pr list`).
4. Identifier l'unique issue `In progress`, s'il y en a une.

## Procedure de routage

1. **Si le mode est explicitement donne** (RESUME/STATUS/REPLAN/CLOSE) : verifier sa
   coherence avec l'etat detecte a l'etape 0 avant d'executer (voir tableau ci-dessous).
   Si incoherent, le signaler et demander confirmation avant de continuer.
2. **Si aucun mode n'est donne** : deduire le mode le plus probable a partir de l'etat
   detecte (issues ouvertes, PRs en cours, ecart plan/realite), puis le proposer avant
   de l'executer — ne jamais executer un mode devine sans confirmation.
3. **Executer** le mode retenu en suivant `.github/prompts/<mode>.prompt.md`.

## Arbre de decision (etat -> mode probable)

| Etat detecte | Mode probable |
|---|---|
| Reprise de session, issues ouvertes ou en cours | `RESUME` |
| Demande d'etat sans intention d'agir | `STATUS` |
| Ecart constate entre le plan approuve (`docs/product/plan.md`) et la realite observee | `REPLAN` |
| Tous les criteres d'acceptation du milestone final semblent couverts | `CLOSE` |

## Tableau de coherence (mode demande vs etat reel)

| Mode demande | Bloquant si... |
|---|---|
| `CLOSE` | des issues du milestone final sont encore ouvertes, ou aucune PR ne les couvre, ou aucun verdict de verification independante n'est enregistre |
| `REPLAN` | aucun ecart reel n'a ete identifie et documente |

## References

- Procedures executables : [.github/prompts/resume.prompt.md](../../prompts/resume.prompt.md), [status.prompt.md](../../prompts/status.prompt.md), [replan.prompt.md](../../prompts/replan.prompt.md), [close.prompt.md](../../prompts/close.prompt.md)
- Contrat de gouvernance : [.github/copilot-instructions.md](../../copilot-instructions.md)
- Vérification indépendante : [docs/independent-verification.md](../../../docs/independent-verification.md)

## Contraintes

- Ne jamais executer un mode sans avoir explicite l'etat detecte et obtenu confirmation
  si ce n'est pas le PM qui a nomme le mode lui-meme.
- Reprendre l'etat depuis GitHub, jamais depuis la memoire du chat seule.
- Une seule issue principale en cours d'implementation a la fois.

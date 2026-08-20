---
name: project-orchestrator
description: 'Orchestrateur de ce projet. Detecte l etat reel (docs/product/plan.md, GitHub issues, Project, PRs) et route vers le mode approprie : RESUME (reprendre le travail), STATUS (etat sans implementer), REPLAN (faire evoluer le plan), CLOSE (verifier et cloturer). Use when: reprendre ce projet, orchestrer ce projet, ou quand le PM decrit un mode (RESUME/STATUS/REPLAN/CLOSE) sans preciser explicitement quel prompt utiliser.'
argument-hint: '<MODE optionnel>'
---

# Orchestrateur de projet

Point d'entree unique pour reprendre ce projet. Ce skill ne duplique pas la logique de
chaque mode (elle vit dans `.github/prompts/*.prompt.md`) — il **detecte l'etat** et
route vers le bon mode.

Les prompt files `.github/prompts/*.prompt.md` sont des entrees natives dans VS Code
quand cette surface les prend en charge. Dans Copilot CLI, cette skill porte elle-meme
le routage ; elle peut consulter les prompt files comme ressources textuelles
accessibles, mais ne les execute pas nativement comme commandes de prompt.

`DISCOVER` et `BOOTSTRAP` n'existent pas ici : ce sont des modes du repository meta
(creation de ressources GitHub cross-projets, registre `projects.yaml`). Ce repository
a deja ete bootstrappe.

## Etape 0 — Collecte d'etat (obligatoire avant tout routage)

Ne jamais choisir un mode par supposition. Avant de router :

1. Lire `docs/product/plan.md` (plan approuve).
2. Verifier le statut de `docs/solution-design/solution-design.md`.
3. Executer `gh issue list --state open` pour ce repository.
4. Verifier le GitHub Project associe et les pull requests ouvertes (`gh pr list`).
5. Identifier l'unique issue `In progress`, s'il y en a une.

## Procedure de routage

1. **Si le mode est explicitement donne** (RESUME/STATUS/REPLAN/CLOSE) : verifier sa
   coherence avec l'etat detecte a l'etape 0 avant de continuer (voir tableau ci-dessous).
  Si incoherent, le signaler et demander une decision PM avant de continuer.
2. **Si aucun mode n'est donne** : deduire le mode le plus probable a partir de l'etat
  detecte (issues ouvertes, PRs en cours, ecart plan/realite). L'executer sans confirmation
  PM si l'etat GitHub le rend objectif et qu'aucun arbitrage produit n'est ouvert. Demander
  une decision uniquement si le mode reste ambigu, incoherent ou risque.
3. Traiter le mode retenu en consultant `.github/prompts/<mode>.prompt.md` comme
   procedure textuelle en Copilot CLI, ou comme prompt file natif dans VS Code.

## Autonomie operationnelle GitHub

Cette skill route le travail local ; elle ne redemande pas au PM de valider les evenements
GitHub routiniers lorsque les criteres objectifs sont couverts. Copilot peut fermer une
issue deterministe, passer a l'issue `Ready` suivante, ouvrir et fusionner une PR eligible,
nettoyer une branche, mettre a jour un Project ou un milestone si le plan approuve, le
Solution Design, les criteres d'acceptation et les controles le permettent.

En cas d'hesitation operationnelle sur `merge_pr`, `close_issue`, `start_next_issue`,
`update_project` ou `cleanup_branch`, deleguer la decision a
`.github/agents/orchestrator-automation.agent.md` et suivre son verdict.

Solliciter le PM uniquement pour un arbitrage produit, un changement de perimetre, une
ambiguite non resolue par GitHub, un risque significatif, une decision difficile a
inverser, un conflit de gouvernance, une operation destructive ou un nouveau cout/service.

La verification independante et les decisions de gouvernance doivent rester dans les
surfaces GitHub Copilot approuvees. Un verdict Claude CLI, Claude Code, Anthropic API
direct ou autre LLM externe n'est pas valide et doit etre refait par une session GitHub
Copilot independante.

## Arbre de decision (etat -> mode probable)

| Etat detecte | Mode probable |
|---|---|
| Reprise de session, issues ouvertes ou en cours | `RESUME` |
| Plan approuve, Solution Design absent ou non approuve | skill `solution-design` |
| Demande d'etat sans intention d'agir | `STATUS` |
| Ecart constate entre le plan approuve (`docs/product/plan.md`) et la realite observee | `REPLAN` |
| Tous les criteres d'acceptation du milestone final semblent couverts | `CLOSE` |

## Tableau de coherence (mode demande vs etat reel)

| Mode demande | Bloquant si... |
|---|---|
| `CLOSE` | des issues du milestone final sont encore ouvertes, ou aucune PR ne les couvre, ou aucun verdict de verification independante n'est enregistre |
| `REPLAN` | aucun ecart reel n'a ete identifie et documente |

## References

- Procedures VS Code natives et ressources textuelles pour Copilot CLI : [.github/prompts/resume.prompt.md](../../prompts/resume.prompt.md), [status.prompt.md](../../prompts/status.prompt.md), [replan.prompt.md](../../prompts/replan.prompt.md), [close.prompt.md](../../prompts/close.prompt.md)
- Contrat de gouvernance : [.github/copilot-instructions.md](../../copilot-instructions.md)
- Vérification indépendante : [docs/independent-verification.md](../../../docs/independent-verification.md)
- Politique de modèles et outils : voir `docs/copilot/tooling-policy.md` du repository méta `florent-product-lab-copilot`

## Autonomie Copilot CLI

Cette skill est autonome pour la collecte d'etat locale, la verification de coherence
et le routage entre RESUME, STATUS, REPLAN et CLOSE. Elle depend encore des prompt
files pour le detail operationnel de chaque mode ; en Copilot CLI, ces fichiers doivent
donc etre lus comme ressources textuelles accessibles et non comme prompt files
executes nativement.

## Contraintes

- Ne jamais executer un mode sans avoir explicite l'etat detecte et obtenu confirmation
  si ce n'est pas le PM qui a nomme le mode lui-meme.
- Ne jamais demarrer de developpement fonctionnel tant que
  `docs/solution-design/solution-design.md` n'est pas au statut `Approved`.
- Pour les branches, commits, push, Pull Requests, corrections et fusions, appliquer
  la regle de gestion autonome de Git et des Pull Requests de
  `.github/copilot-instructions.md`.
- Reprendre l'etat depuis GitHub, jamais depuis la memoire du chat seule.
- Une seule issue principale en cours d'implementation a la fois.

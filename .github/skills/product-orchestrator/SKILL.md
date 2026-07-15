---
name: product-orchestrator
description: 'Orchestrateur produit multi-projets. Detecte l etat reel (projects.yaml, GitHub issues, Project, PRs) et route vers le mode approprie : DISCOVER (cadrer un nouveau projet), BOOTSTRAP (initialiser apres validation), RESUME (reprendre un projet existant), STATUS (etat sans implementer), REPLAN (faire evoluer le plan), CLOSE (verifier et cloturer). Use when: orchestrer un projet produit, cadrer un projet, initialiser un projet, reprendre un projet, ou quand Florent decrit un mode (DISCOVER/BOOTSTRAP/RESUME/STATUS/REPLAN/CLOSE) et un nom de projet sans preciser explicitement quel prompt utiliser.
argument-hint: '<MODE optionnel> <nom-du-projet>'
---

# Orchestrateur produit

Point d'entree unique de l'orchestration multi-projets. Ce skill ne duplique pas la
logique de chaque mode (elle vit dans `.github/prompts/*.prompt.md` et
`docs/copilot/orchestration.md`) — il **detecte l'etat** et **route** vers le bon mode
avant de l'executer, pour eviter d'invoquer un mode incoherent avec l'etat reel.

## Procedure de routage

1. **Identifier le projet** depuis l'argument fourni par Florent, ou le demander si
   ambigu.
2. **Lire `projects.yaml`** pour savoir si ce projet existe deja dans le registre.
3. **Si le mode est explicitement donne** par Florent (DISCOVER/BOOTSTRAP/RESUME/
   STATUS/REPLAN/CLOSE) : verifier sa coherence avec l'etat detecte avant d'executer
   (voir tableau de coherence ci-dessous). Si incoherent, le signaler et demander
   confirmation avant de continuer plutot que d'executer aveuglement.
4. **Si aucun mode n'est donne** : deduire le mode le plus probable a partir de l'etat
   detecte (voir arbre de decision ci-dessous), puis le proposer a Florent avant de
   l'executer — ne jamais executer un mode devine sans confirmation explicite.
5. **Executer** le mode retenu en suivant `.github/prompts/<mode>.prompt.md`.

## Arbre de decision (etat -> mode probable)

| Etat detecte | Mode probable |
|---|---|
| Projet absent de `projects.yaml`, aucun plan approuve | `DISCOVER` |
| Projet dans `projects.yaml`, plan approuve, mais aucun repository/issue GitHub cree | `BOOTSTRAP` |
| Repository existant, issues ouvertes, pas de session recente | `RESUME` |
| Florent demande un etat sans intention d'agir | `STATUS` |
| Ecart constate entre le plan approuve et la realite observee | `REPLAN` |
| Tous les criteres d'acceptation du milestone final semblent couverts | `CLOSE` |

## Tableau de coherence (mode demande vs etat reel)

| Mode demande | Bloquant si... |
|---|---|
| `BOOTSTRAP` | le plan n'est pas explicitement approuve, ou le projet n'a pas d'entree dans `projects.yaml` |
| `RESUME` | aucun repository GitHub n'existe encore pour ce projet (renvoyer vers `BOOTSTRAP`) |
| `CLOSE` | des issues du milestone final sont encore ouvertes, ou aucune PR ne les couvre |

## References

- Documentation complete de chaque mode : [docs/copilot/orchestration.md](../../../docs/copilot/orchestration.md)
- Procedures executables : [.github/prompts/discover.prompt.md](../../prompts/discover.prompt.md), [bootstrap.prompt.md](../../prompts/bootstrap.prompt.md), [resume.prompt.md](../../prompts/resume.prompt.md), [status.prompt.md](../../prompts/status.prompt.md), [replan.prompt.md](../../prompts/replan.prompt.md), [close.prompt.md](../../prompts/close.prompt.md)
- Registre multi-projets : [projects.yaml](../../../projects.yaml)

## Contraintes

- Ne jamais executer un mode sans avoir explicite l'etat detecte et obtenu confirmation
  si ce n'est pas Florent qui a nomme le mode lui-meme.
- Ne jamais creer de ressource GitHub en dehors du mode `BOOTSTRAP` valide.
- Reprendre l'etat depuis GitHub et `projects.yaml`, jamais depuis la memoire du chat
  seule.

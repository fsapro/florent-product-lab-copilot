# Prompts Copilot — Index (projet)

Ce dossier contient les prompts réutilisables pour ce projet. Emplacement natif
(`.github/prompts/`) : chaque fichier est invocable directement en tapant `/nom-du-fichier`
dans Copilot Chat (VS Code), en plus du copier-coller manuel ou de la référence `#file:`.

## Prompts disponibles

| Fichier | Slash-command | Mode | Usage |
|---|---|---|---|
| `resume.prompt.md` | `/resume` | RESUME | Reprendre l'état du projet depuis GitHub |
| `status.prompt.md` | `/status` | STATUS | Restituer l'état du projet sans implémenter |
| `replan.prompt.md` | `/replan` | REPLAN | Proposer une évolution du plan |
| `close.prompt.md` | `/close` | CLOSE | Vérifier et clôturer le projet |

## Portée

`DISCOVER` et `BOOTSTRAP` n'existent pas ici : ce sont des modes du repository méta
`florent-product-lab-copilot` (création de ressources GitHub cross-projets, registre
`projects.yaml`). Ce repository projet a déjà été bootstrappé — le travail continue avec
`resume`, `status`, `replan` et `close`.

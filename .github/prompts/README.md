# Prompts Copilot — Index

Ce dossier contient les prompts réutilisables pour déclencher les workflows d'orchestration depuis GitHub Copilot. Emplacement natif (`.github/prompts/`) : chaque fichier est invocable directement en tapant `/nom-du-fichier` dans Copilot Chat (VS Code), en plus du copier-coller manuel ou de la référence `#file:`.

## Prompts disponibles

| Fichier | Slash-command | Mode | Usage |
|---|---|---|---|
| `discover.prompt.md` | `/discover` | DISCOVER | Cadrer un nouveau projet |
| `bootstrap.prompt.md` | `/bootstrap` | BOOTSTRAP | Initialiser un projet après validation |
| `resume.prompt.md` | `/resume` | RESUME | Reprendre un projet existant |
| `status.prompt.md` | `/status` | STATUS | Restituer l'état d'un projet |
| `replan.prompt.md` | `/replan` | REPLAN | Proposer une évolution du plan |
| `close.prompt.md` | `/close` | CLOSE | Vérifier et clôturer un projet |

## Portée

Ces 6 prompts sont spécifiques au repository méta (`florent-product-lab-copilot`) : `discover` et `bootstrap` créent des ressources GitHub cross-projets et lisent `projects.yaml`, qui n'existe que dans ce repo.

Les projets enfants (créés depuis `templates/product-agent-template/`) disposent de leur propre `.github/prompts/` avec une version adaptée de `resume`, `status`, `replan` et `close` — sans dépendance à `projects.yaml` puisque le repo enfant connaît déjà son propre plan et ses propres issues.

## Documentation complète

Voir `docs/copilot/orchestration.md` pour la description détaillée de chaque mode.

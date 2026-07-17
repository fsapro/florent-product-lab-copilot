# Installation — skill utilisateur

Ce dossier contient les ressources a installer au niveau utilisateur pour que
l'orchestration soit disponible depuis n'importe quel repository (cross-repo),
pas seulement depuis ce repository meta.

## Contenu

- `user-skills/product-orchestrator/SKILL.md` — source versionnee de la skill
  d'orchestration multi-projets. C'est un fichier de reference : tant qu'il n'est
  pas copie vers `~/.copilot/skills/`, il n'est lu par GitHub Copilot dans aucun
  contexte (ni auto-invocation repo-level, puisqu'il n'est pas dans
  `.github/skills/`, ni invocation user-level, puisqu'il n'est pas encore a
  l'emplacement attendu).
- `install.ps1` — copie `user-skills/product-orchestrator/` vers
  `~/.copilot/skills/product-orchestrator/`.

## Installation

```powershell
./setup/install.ps1
```

Idempotent : le script ecrase toujours la copie existante (pas de fusion). A
relancer apres tout `git pull` qui modifie `setup/user-skills/`, sous peine de
drift entre la source versionnee du repository et la copie active installee sur
la machine.

## Deux etats a distinguer

1. **Avant installation** : le fichier existe dans le repository mais n'est une
   skill active nulle part. C'est un artefact a installer.
2. **Apres installation** : seule la copie dans `~/.copilot/skills/` est utilisee
   par Copilot, dans tous les workspaces. Le fichier source du repository n'a plus
   aucun role runtime — il ne sert qu'a re-installer ou mettre a jour.

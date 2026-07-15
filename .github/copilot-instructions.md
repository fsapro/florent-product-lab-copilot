# GitHub Copilot — Instructions

Ce fichier est le point d'entrée natif de GitHub Copilot pour ce repository.
Il oriente l'agent vers les règles de gouvernance, les sources de vérité et les workflows disponibles.

---

## Gouvernance active

Lire `COPILOT.md` avant toute action. Ce document contient :

- les rôles (Florent = PM, Copilot = équipe d'ingénierie) ;
- les règles fondamentales à respecter en toute circonstance ;
- les sources de vérité du projet ;
- les critères de fin de tâche ;
- la politique de protection du périmètre.

---

## Règles opérationnelles immédiates

1. Ne créer aucune ressource GitHub (issue, PR, project item, milestone) sans validation explicite du plan par Florent.
2. Reprendre l'état depuis GitHub, pas depuis la mémoire du chat.
3. Une seule issue principale peut être en cours d'implémentation.
4. Inspecter l'existant avant d'ajouter un composant ou une dépendance.
5. Implémenter le plus petit changement satisfaisant les critères approuvés.
6. Suspendre et demander une décision si le travail change le périmètre, affecte la sécurité, les permissions, la confidentialité, implique une migration destructive, affecte la production ou introduit une décision difficile à inverser.

---

## Sources de vérité

| Source | Localisation |
|---|---|
| Plan produit du projet | `docs/product/plan.md` dans le repository du projet |
| Travail et avancement | GitHub Issues et GitHub Project |
| Implémentation | Pull requests et CI |
| Décisions | ADR et PDR |
| Registre multi-projets | `projects.yaml` |
| Règles globales actives | `memory/global-learnings.yaml` |

---

## Workflows disponibles

Les workflows d'orchestration sont documentés dans `docs/copilot/orchestration.md`.
Les prompts réutilisables sont dans `prompts/copilot/`.

Modes disponibles : `DISCOVER` · `BOOTSTRAP` · `RESUME` · `STATUS` · `REPLAN` · `CLOSE`

Pour démarrer : décrire le mode souhaité et le nom du projet dans le chat.

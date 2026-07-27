# Politique de modèles et outils

Cette politique complète `.github/copilot-instructions.md` pour les choix de surfaces,
modèles et outils dans ce repository projet.

---

## Principe

La gouvernance du framework est GitHub Copilot-first. Le critère d'acceptation n'est pas
le fournisseur du modèle, mais la surface qui contrôle l'exécution, les outils, les traces
et les décisions.

Un modèle Anthropic est autorisé s'il est sélectionné et exécuté dans GitHub Copilot. Un
outil externe comme Claude CLI, Claude Code, un appel direct Anthropic API, ChatGPT ou un
autre assistant LLM externe ne peut pas produire de verdict de gouvernance opposable.

---

## Surfaces approuvées

| Surface | Usage approuvé |
|---|---|
| VS Code Copilot Chat | Orchestration, implémentation, vérification indépendante, décisions Git/GitHub routinières. |
| Copilot CLI avec skills installées | Routage local, reprise d'état, exécution des modes via prompts lus comme ressources textuelles. |
| GitHub.com | Repositories, issues, Projects, pull requests, checks, commentaires et traces. |

GitHub.com est une source de vérité et une surface de collaboration. Les décisions de
gouvernance restent prises par Copilot selon les instructions du repository.

---

## Surfaces interdites pour la gouvernance

Les surfaces suivantes ne peuvent pas exécuter un mode d'orchestration, produire une
vérification indépendante, arbitrer le périmètre ou décider d'un merge dans ce framework :

- Claude CLI ;
- Claude Code ;
- appels directs Anthropic API ;
- ChatGPT ou autres assistants LLM externes ;
- scripts ou outils externes qui reformulent un verdict LLM hors Copilot.

Un verdict produit par une surface interdite est invalide. Il doit être remplacé par une
vérification indépendante réalisée dans une session GitHub Copilot distincte.

---

## Exceptions documentaires

Les outils documentaires externes, dont Context7, sont autorisés pour récupérer une
documentation technique actuelle sur une bibliothèque, une API, un SDK, un CLI ou un
service cloud.

Cette exception ne couvre pas :

- les arbitrages produit ;
- les décisions de périmètre ;
- les verdicts de vérification indépendante ;
- les décisions de merge, clôture ou promotion globale.

---

## Autonomie GitHub

Copilot peut exécuter les opérations Git et GitHub routinières sans validation PM lorsque
les critères approuvés sont couverts, les contrôles requis passent et aucun arbitrage
produit n'est ouvert.

Le PM est sollicité uniquement pour les décisions produit, les changements de périmètre,
les risques significatifs, les conflits de gouvernance et les actions difficiles à
inverser.
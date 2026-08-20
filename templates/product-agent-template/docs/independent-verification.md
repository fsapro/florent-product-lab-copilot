# Verification independante

Un changement significatif est confronte au goal et aux criteres par une session Copilot
distincte de l'implementeur avant validation PM.

## Niveaux

| Niveau | Quand | Exigence |
|---|---|---|
| 0 | Documentation seule, formatage, aucun comportement modifie | Aucun verificateur |
| 1 | Comportement visible, regle metier, API, refactoring | Session Copilot distincte |
| 2 | Securite, migration destructive, production, gate release | Session reconstruite depuis GitHub |

En cas de doute entre deux niveaux, retenir le plus eleve.

## Verificateur

Session ou agent GitHub Copilot distinct de l'implementeur. Claude CLI, Claude Code et
autres LLM externes ne produisent pas de verdict opposable.

Le verdict enregistre : surface, contexte recu, niveau, verdict
(pass / pass_with_reservations / fail / not_verifiable), preuves, reserves.

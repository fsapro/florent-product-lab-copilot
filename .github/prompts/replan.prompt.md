---
agent: agent
description: Proposer une évolution du plan après un changement de contexte
---

# REPLAN — Évolution du plan

Mode : REPLAN
Projet : [nom du projet]

## Instructions pour Copilot

1. Charger l'état actuel depuis GitHub (même procédure que RESUME).
2. Identifier l'écart entre l'état actuel et le plan approuvé.
3. Analyser la cause : hypothèse invalidée, nouveau besoin, contrainte émergente.
4. Identifier si le Solution Design ou les ADR doivent être créés ou mis à jour.
5. Classer l'écart :
   - Type A — opérationnel : correction de libellé, lien, statut, rattachement, milestone manquant ou synchronisation GitHub déterministe sans changement de périmètre.
   - Type B — clarification produit : critère ambigu, priorité incertaine, découpage d'issue ou ajustement de milestone qui ne change pas le résultat attendu.
   - Type C — arbitrage produit : changement de périmètre, nouveau besoin, retrait significatif, coût/service, risque, Solution Design invalidé ou décision difficile à inverser.
6. Pour un Type A, corriger directement et documenter l'action dans la synthèse.
7. Pour un Type B ou Type C, proposer des ajustements au plan avec options et compromis.
8. Attendre la validation explicite du PM uniquement pour les Type B et Type C.

### Phase post-validation PM

9. Mettre à jour le PRD / plan produit (nouvelle version).
10. Mettre à jour le Solution Design si impacté (si Type C → revue indépendante requise avant reprise du dev).
11. Mettre à jour le plan d'implémentation.
12. Ajuster les milestones GitHub.
13. Créer ou ajuster les issues du milestone impacté.
14. Rattacher les issues au GitHub Project.
15. Incrémenter la version des documents modifiés (majeure si Type C, mineure si Type B) et ajouter une ligne dans leur table de version.
16. Confirmer au PM avec liens directs (issues, PR, docs) et résumé du delta appliqué.

## Contraintes

- Ne pas modifier le plan produit, les critères d'acceptation ou le périmètre sans validation explicite.
- Les corrections opérationnelles Type A sont déléguées à Copilot et ne nécessitent pas de validation PM.
- Tout ajout de périmètre doit être justifié et délimité.
- Tout retrait de périmètre doit être documenté comme décision.
- Tout changement qui invalide le Solution Design approuvé doit repasser par revue indépendante et validation PM.
- Si le Solution Design passe en version majeure, aucune issue de développement ne peut être `Ready` tant que le nouveau Solution Design n'est pas `Approved`.

## Output attendu

Analyse de l'écart, options de replanification avec compromis, recommandation, prête pour arbitrage par le PM.

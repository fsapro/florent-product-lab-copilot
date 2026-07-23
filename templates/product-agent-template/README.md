# Product Agent Template

Template minimal utilise par le systeme d'execution produit multi-projets.

## Objectif

Fournir a chaque projet :

- un contexte GitHub Copilot configure ;
- un plan produit canonique ;
- un jalon Solution Design obligatoire avant developpement ;
- une structure documentaire minimale ;
- une tracabilite GitHub ;
- des regles communes d'execution et de validation.

## Sources de verite

- Produit : docs/product/plan.md
- Solution Design : docs/solution-design/solution-design.md
- Plan d'implementation : docs/implementation-plan.md
- Travail : GitHub Issues et GitHub Project
- Implementation et preuves : pull requests et CI
- Decisions structurantes : docs/decisions/

## Principe

Le template reste independant de la stack technique.

Les dossiers, dependances, workflows et controles specifiques sont ajoutes uniquement lorsqu'un projet reel les necessite.

Aucun developpement fonctionnel ne demarre tant que le Solution Design n'est pas au
statut `Approved` apres revue independante et validation PM.

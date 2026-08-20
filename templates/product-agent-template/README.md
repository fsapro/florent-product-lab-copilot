# Product Agent Template

Template minimal utilise par le systeme d'execution produit multi-projets.

## Objectif

Fournir a chaque projet :

- un contexte GitHub Copilot configure ;
- un plan produit canonique ;
- un jalon Solution Design obligatoire avant developpement ;
- une structure documentaire minimale ;
- une tracabilite GitHub ;
- des regles communes d'execution et de validation ;
- une politique de surfaces Copilot-only pour la gouvernance ;
- un agent d'automation pour les operations GitHub routinieres.

## Sources de verite

- Produit : docs/product/plan.md
- Solution Design : docs/solution-design/solution-design.md
- Plan d'implementation : docs/implementation-plan.md
- Travail : GitHub Issues et GitHub Project
- Implementation et preuves : pull requests et CI
- Decisions structurantes : docs/decisions/
- Verification independante : docs/independent-verification.md

## Autonomie operationnelle

Le PM delegue a Copilot les operations Git et GitHub routinieres : passer a l'issue
`Ready` suivante, ouvrir ou fusionner une PR eligible, fermer une issue couverte,
mettre a jour un Project/milestone et nettoyer une branche.

L'agent `.github/agents/orchestrator-automation.agent.md` tranche ces decisions lorsque
les criteres sont objectifs. Le PM reste sollicite uniquement pour les arbitrages produit,
changements de perimetre, risques significatifs et decisions difficiles a inverser.

## Principe

Le template reste independant de la stack technique.

Les dossiers, dependances, workflows et controles specifiques sont ajoutes uniquement lorsqu'un projet reel les necessite.

Aucun developpement fonctionnel ne demarre tant que le Solution Design n'est pas au
statut `Approved` apres revue independante et validation PM.

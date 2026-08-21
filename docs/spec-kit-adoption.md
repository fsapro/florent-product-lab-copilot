# Adoption de spec-kit

Depuis le test d'adoption (2026-08), spec-kit est le moteur d'exécution des projets.
Ce document décrit ce qui change, comment travailler, et ce que ce repository apporte
en complément.

---

## Workflow spec-kit dans l'ordre

```
speckit-specify   → PRD structuré (depuis un brief ou une idée)
speckit-clarify   → résolution des ambiguïtés avant design
speckit-plan      → research.md, data-model.md, contracts/ (Solution Design)
speckit-analyze   → Constitution Check : incohérences, gaps, violations CRITICAL
speckit-checklist → checklist de validation du plan avant implémentation
speckit-tasks     → tasks.md découpé en tâches avec critères d'acceptation
speckit-implement → exécution d'une tâche (boucle itérative)
speckit-converge  → reprise d'une tâche bloquée ou à réconcilier
```

Gates inchangés depuis ce repository :
- `speckit-plan` ne démarre qu'après validation PM du PRD.
- `speckit-implement` ne démarre qu'après `speckit-analyze` pass et validation PM.
- La vérification indépendante reste obligatoire (spec-kit ne la prend pas en charge).

---

## Politique de modèles

Le modèle de raisonnement sert à concevoir et arbitrer, pas à exécuter. Une fois le plan
validé par le PM, tout passe en cost-efficient : `speckit-analyze`, `speckit-checklist`,
`speckit-tasks`, `speckit-implement` et `speckit-converge`.

Détail et justification : [`docs/copilot/tooling-policy.md`](copilot/tooling-policy.md).

---

## Complément obligatoire : Principe VI

Coller ce texte dans `.specify/memory/constitution.md` de tout projet initialisé avec
spec-kit. `speckit-analyze` et `speckit-tasks` l'appliquent et classent toute violation
en CRITICAL.

```
### VI. Tracabilite des decisions, des risques et de la completion

Trois obligations s'appliquent a toute fonctionnalite :

1. Decisions structurantes — toute decision qui engage la stack, la securite, un contrat
   expose, une dependance nouvelle ou un contournement DOIT produire une ADR dans
   docs/adr/, numerotee a la suite du corpus existant, avec : contexte, decision, statut
   (Proposed / Accepted / Superseded), consequences. Une decision consignee uniquement en
   prose dans research.md NE compte PAS comme tracee.
   Granularite : une ADR par decision. Statut : nait Proposed, passe Accepted au Gate PM.
   Une fonctionnalite NE DOIT PAS etre fusionnee avec une ADR restee Proposed.

2. Risques et retour arriere — le plan DOIT comporter une section "Risques et rollback"
   listant, pour chaque risque : impact, mitigation, procedure de retour arriere.
   Un plan sans cette section est incomplet.

3. Criteres de completion — chaque tache de tasks.md DOIT porter un critere d'acceptation
   verifiable, sur une ligne dediee immediatement sous la tache, au format :
   -> AC : <condition observable> (FR-xxx / SC-xxx)
   Une simple reference a FR-xxx dans le libelle ne satisfait pas cette obligation.
```

---

## Ce que ce repository apporte en complement de spec-kit

| Responsabilite | Ou c'est |
|---|---|
| Portefeuille multi-projets : DISCOVER, BOOTSTRAP, ADOPT | `.github/prompts/`, `projects.yaml` |
| Registre des projets suivis | `projects.yaml` |
| Apprentissages cross-projets | `memory/global-learnings.yaml`, `memory/README.md` |
| Vérification indépendante (session distincte de l'implémenteur) | `docs/copilot/independent-verification.md` |
| Surfaces Copilot valides pour la gouvernance et la VI | `docs/copilot/tooling-policy.md` |
| Installation de la skill cross-repo | `setup/install.ps1`, `setup/user-skills/` |
| Template de gouvernance pour un nouveau projet | `templates/product-agent-template/` |

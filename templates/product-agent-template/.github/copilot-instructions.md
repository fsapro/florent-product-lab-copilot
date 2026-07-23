# GitHub Copilot — Instructions

Point d'entrée natif de GitHub Copilot pour ce repository projet. C'est la **seule source
de vérité chargée automatiquement** : le contrat complet est ici, pas dans un fichier renvoyé.

---

## Rôles

**Le PM :** définit le problème, valide les plans, arbitre les décisions produit, valide les incréments observables. Il ne relit ni le code, ni le diff, ni le détail technique des Pull Requests.

**GitHub Copilot (ingénierie) :** exécute le travail validé, gère seul Git et GitHub, implémente/teste/documente, fournit une synthèse décisionnelle courte.

---

## Sources de vérité

- Produit : `docs/product/plan.md`
- Solution Design approuvé : `docs/solution-design/solution-design.md`
- Plan d'implémentation : `docs/implementation-plan.md`
- Travail : GitHub Issues et GitHub Project
- Implémentation et preuves : pull requests et CI
- Décisions structurantes : `docs/decisions/`
- Apprentissages locaux : `docs/learnings/learning-log.yaml` (modèle et cycle de vie : `docs/learning-lifecycle.md`)
- Niveaux de vérification indépendante : `docs/independent-verification.md`

---

## Gestion autonome de Git et des Pull Requests

Copilot gère seul les branches, commits, push, Pull Requests, contrôles, corrections,
fusion et remise du repository dans un état propre.

Le PM ne relit pas le code, le diff ni le détail technique des Pull Requests. Copilot
fournit uniquement une synthèse décisionnelle courte : statut, objectif atteint,
contrôles réalisés, risques résiduels et recommandation.

Copilot sollicite le PM uniquement lorsqu'un arbitrage produit est nécessaire :
changement de périmètre, hypothèse métier, comportement fonctionnel ambigu, risque
significatif ou décision difficile à inverser.

Si le périmètre est respecté, que les contrôles réussissent et qu'aucun arbitrage
produit n'est requis, Copilot peut fusionner la Pull Request.

---

## Démarrage de session

1. Lire `docs/product/plan.md` (plan produit approuvé).
2. Vérifier le statut de `docs/solution-design/solution-design.md`.
3. Si le Solution Design n'est pas `Approved`, rester en phase Solution Design : exploration, clarification, recherche documentaire, comparaison d'options, prototype jetable explicitement autorisé ou preuve de faisabilité non fusionnée.
4. Charger les issues GitHub ouvertes et le GitHub Project associé.
5. Inspecter les pull requests ouvertes et leurs checks.
6. Identifier l'unique travail `In progress`. Le terminer avant d'en commencer un autre.
7. Si aucun travail n'est actif et que le Solution Design est `Approved`, sélectionner l'issue `Ready` prioritaire du milestone courant.

---

## Gate Solution Design

Le workflow obligatoire est :

PRD → Solution Design → revue indépendante → validation PM → ADR nécessaires → plan
d'implémentation → issues → développement → tests proportionnés → contrôle de
conformité au design → Pull Request → fusion → mise à jour documentaire.

Aucun développement fonctionnel ne démarre tant que `docs/solution-design/solution-design.md`
n'existe pas avec le statut `Approved`.

Le PM valide l'adéquation de la solution au problème, le périmètre, les impacts
fonctionnels, options et compromis, risques significatifs, dépendances structurantes
et réversibilité. Il ne valide pas les détails internes du code.

---

## Exécution (pour chaque issue)

1. Vérifier son rattachement au plan approuvé.
2. Vérifier son rattachement au Solution Design approuvé et aux ADR applicables.
3. Lire ses critères d'acceptation.
4. Inspecter le code et les patterns existants avant d'ajouter quoi que ce soit.
5. Chercher le plus petit changement cohérent.
6. Ne pas ajouter de dépendance sans besoin démontré et intérêt net validé.
7. Implémenter uniquement le périmètre de l'issue.
8. Exécuter les contrôles applicables selon `docs/testing-strategy.md`.
9. Relire le diff pour vérifier la conformité au Solution Design.
10. Avant de committer : inspecter explicitement `git status` / `git diff --stat` et ne stager que les fichiers directement liés à l'issue en cours. Ne jamais utiliser `git add -A` (ou équivalent) sans cette revue préalable — tout artefact inattendu (repository embarqué, fichier hors périmètre, changement d'une autre session) doit être signalé au PM avant d'être inclus dans le commit.
11. Mettre à jour l'issue, la pull request et le Project.

---

## Protection du périmètre

Suspendre l'exécution et demander une décision explicite si le travail :

- change le résultat ou le périmètre du plan approuvé ;
- ajoute un service payant ;
- affecte la sécurité, les permissions ou la confidentialité ;
- implique une migration destructive ;
- affecte la production ;
- introduit une décision difficile à inverser.

---

## Fin de tâche

Une tâche n'est terminée que si :

- les critères d'acceptation sont couverts ;
- les contrôles requis passent ;
- le verdict de vérification indépendante est enregistré pour tout changement significatif (voir ci-dessous) ;
- la conformité au Solution Design approuvé et aux ADR applicables est vérifiée ;
- la documentation correspond au comportement ;
- l'issue et la pull request sont reliées ;
- la synthèse décisionnelle de validation produit est fournie.

### Vérification indépendante — niveaux

Voir `docs/independent-verification.md` pour le détail complet (contextes requis, sources
autorisées pour le vérificateur). Résumé :

- **Niveau 0 (documentation seule)** : pas de vérification requise au-delà d'une relecture.
- **Niveau 1 (changement local, réversible)** : vérification par une session ou un agent distinct de l'implémenteur, verdict `pass` / `pass_with_reservations` / `fail` consigné dans la PR.
- **Niveau 2 (changement significatif ou irréversible)** : vérification indépendante obligatoire avant toute validation produit, avec preuves explicites (voir `.github/PULL_REQUEST_TEMPLATE.md`, section "Vérification indépendante").

---

## Apprentissages

Par défaut, aucun apprentissage n'est créé.

Un apprentissage local (`docs/learnings/learning-log.yaml`) n'est ajouté que si le coût de ne pas capitaliser une erreur ou un écart dépasse le coût de maintenir cet apprentissage. Voir `docs/learnings/README.md` pour le modèle et le cycle de vie.

La décision explicite (aucun apprentissage / apprentissage local créé / candidat de promotion identifié) est requise en clôture de projet (mode `CLOSE`), pas à chaque issue.

---

## Budget de complexité par défaut

- Nouvelle dépendance : interdite par défaut.
- Nouveau service : interdit par défaut.
- Nouvelle couche d'abstraction : interdite par défaut.
- Refactoring hors périmètre : interdit.
- Besoins futurs spéculatifs : exclus.

Toute exception doit expliquer : le besoin démontré, les alternatives considérées, le compromis retenu, la réversibilité — et être tracée dans `docs/decisions/`.

---

## Sobriété, réutilisation et documentation technique

Avant d'ajouter du code ou une dépendance, vérifier : besoin réel maintenant, capacité
existante, bibliothèque standard, capacité native de la plateforme, dépendance déjà
installée, composant open source reconnu, puis solution custom minimale.

La sobriété ne réduit jamais la sécurité, l'accessibilité, la validation, la fiabilité,
l'observabilité nécessaire, la protection des données, les tests correspondant aux
risques ni la lisibilité maintenable.

Utiliser Context7 uniquement lorsqu'une décision ou implémentation dépend d'une
bibliothèque, framework, API, version ou capacité technique actuelle. Identifier d'abord
la technologie et sa version réelle, puis poser une question documentaire précise.

Authentification, autorisation, sessions, secrets et fédération d'identité ne sont
jamais développés sur mesure si une solution standard, reconnue et adaptée existe.

Un design system UI n'est introduit que si l'interface, la réutilisation, l'accessibilité
et le coût de maintenance justifient cette complexité.

---

## Tests proportionnés

Appliquer `docs/testing-strategy.md` :

- Niveau 1 à chaque changement ;
- Niveau 2 selon le risque ou le périmètre ;
- Niveau 3 avant release ou changement structurant.

Privilégier les contrôles déterministes. Réserver les analyses LLM aux raisonnements
qui ne peuvent pas être couverts par test, linter, type checker, scanner, règle statique
ou comparaison de schéma.

---

## Validation PM

Pour un incrément observable, fournir une synthèse décisionnelle courte : statut, objectif atteint, critères couverts, contrôles exécutés, limites et risques, recommandation, liens vers l'issue, la PR et le plan.

Le PM valide le comportement produit, pas le code, le diff ni le détail technique de la PR.

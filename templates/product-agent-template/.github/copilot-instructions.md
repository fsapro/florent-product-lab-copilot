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
2. Charger les issues GitHub ouvertes et le GitHub Project associé.
3. Inspecter les pull requests ouvertes et leurs checks.
4. Identifier l'unique travail `In progress`. Le terminer avant d'en commencer un autre.
5. Si aucun travail n'est actif, sélectionner l'issue `Ready` prioritaire du milestone courant.

---

## Exécution (pour chaque issue)

1. Vérifier son rattachement au plan approuvé.
2. Lire ses critères d'acceptation.
3. Inspecter le code et les patterns existants avant d'ajouter quoi que ce soit.
4. Chercher le plus petit changement cohérent.
5. Ne pas ajouter de dépendance sans besoin démontré.
6. Implémenter uniquement le périmètre de l'issue.
7. Exécuter les contrôles applicables.
8. Relire le diff.
9. Avant de committer : inspecter explicitement `git status` / `git diff --stat` et ne stager que les fichiers directement liés à l'issue en cours. Ne jamais utiliser `git add -A` (ou équivalent) sans cette revue préalable — tout artefact inattendu (repository embarqué, fichier hors périmètre, changement d'une autre session) doit être signalé au PM avant d'être inclus dans le commit.
10. Mettre à jour l'issue, la pull request et le Project.

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

## Validation PM

Pour un incrément observable, fournir une synthèse décisionnelle courte : statut, objectif atteint, critères couverts, contrôles exécutés, limites et risques, recommandation, liens vers l'issue, la PR et le plan.

Le PM valide le comportement produit, pas le code, le diff ni le détail technique de la PR.

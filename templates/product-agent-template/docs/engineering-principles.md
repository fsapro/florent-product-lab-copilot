# Principes d'ingénierie sobres

## Avant d'ajouter du code ou une dépendance

1. Vérifier si le besoin est réellement nécessaire maintenant.
2. Rechercher une capacité déjà présente dans le repository.
3. Privilégier la bibliothèque standard.
4. Privilégier les capacités natives de la plateforme.
5. Réutiliser une dépendance déjà installée lorsqu'elle convient.
6. Évaluer un composant open source reconnu.
7. Développer seulement ensuite la solution minimale, claire et correcte.

## Ce que la sobriété ne réduit jamais

- sécurité ;
- validation des entrées et sorties ;
- gestion utile des erreurs ;
- accessibilité ;
- fiabilité ;
- observabilité nécessaire ;
- protection contre la perte de données ;
- tests correspondant aux risques ;
- lisibilité nécessaire à la maintenance.

## Open source

Avant tout développement custom significatif, comparer les options crédibles selon :
adéquation, maintenance, adoption, documentation, sécurité, licence, compatibilité,
poids, dépendances transitives, accessibilité si UI, configuration, coût d'intégration,
verrouillage, réversibilité et coût de maintenance.

Une dépendance ne doit être ajoutée qu'après validation de son intérêt net.

## Authentification et fonctions sensibles

Authentification, autorisation, sessions, secrets et fédération d'identité ne doivent
pas être développés sur mesure si une solution standard adaptée existe.

Documenter toute décision structurante dans le Solution Design et créer un ADR.

## Design system UI

Évaluer le design system pendant le Solution Design, après clarification des parcours
et avant le développement détaillé de l'interface.

Ordre attendu :

besoin utilisateur → parcours et interactions → vérification du design system existant
→ décision de réutilisation ou d'extension → maquette ou spécification UI utile
→ validation PM → développement.

Ne pas créer de design system complet pour une interface simple ou ponctuelle.

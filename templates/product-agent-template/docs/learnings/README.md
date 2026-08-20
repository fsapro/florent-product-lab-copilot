# Apprentissages locaux

Registre local des erreurs et ecarts observes sur ce projet.

Par defaut, aucun apprentissage n'est cree. Un apprentissage n'est cree que si
cout(non-capitalisation) > cout(maintenance). Decision prise en cloture de projet.

## Format : learning-log.yaml

```yaml
id: LRN-YYYY-NNN
status: observed   # observed | qualified | applied_locally | rejected | superseded
project: project-slug
category: verification_gap
  # requirement_gap | implementation_error | verification_gap | regression
observation: ""
impact: ""
root_cause:
  status: confirmed   # suspected | confirmed
  description: ""
correction: ""
scope_candidate: project   # project | portfolio
evidence:
  issue: null
  pull_request: null
created_at: "<ISO-8601>"
created_by: copilot
```

`learning-log.yaml` reste `[]` tant qu'aucun apprentissage n'est justifie.

## Quand creer un apprentissage

En cloture de projet, pas a chaque issue. Pour chaque ecart notable :
1. L'ecart a-t-il une valeur de reutilisation credible ?
2. Le cout de non-capitalisation depasse-t-il le cout de maintenance ?

Si la reponse 2 est non ou incertaine : ne rien creer.

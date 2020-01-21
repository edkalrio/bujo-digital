#!/usr/bin/env bash

echo "Introduce el Año: "
read -r YEAR

header="#+TITLE: Bullet Journal Digital
#+AUTHOR: Angel
#+DATE: $YEAR
#+LANGUAGE: es
#+SEQ_TODO: TODO(t) NEXT(n) WAIT(w) | CANCELLED (c) DONE(d)
#+INFOJS_OPT: view:t toc:t ltoc:t mouse:underline buttons:0 path:https://ugeek.github.io/style-css-org-mode/org-info.min.js
#+HTML_HEAD: <link rel='stylesheet' type='text/css' href='https://ugeek.github.io/style-css-org-mode/bjm.css' />
#+STARTUP: inlineimages
* INDICE
** CLAVES
*** Tarea Normal
*** *Tarea Importante*
*** / Tarea Empezada
*** > Tarea Viene de Otro Día
*** < Tarea Migra a Otro Día
*** +Hecho+
*** # Nota
* REGISTRO FUTURO"

function bujo_cal() {
    for (( i = 1; i <= 12; i++ )); do
        ncal -hb $i $YEAR
    done
}

function bujo() {
    for (( i = 1; i <= 12; i++ )); do
        date -d "$YEAR-$i-01" +'** %B'
        for (( j = 1; j <= $(date -d "$YEAR-$i-01 +1 month -1 day" +%d); j++ )); do
            date -d "$YEAR-$i-$j" +"$1"
        done
    done
}

{
echo "$header"
bujo_cal
echo "* AGENDA"
bujo '*** %d %A'
echo "* DIARIO"
bujo '*** %d de %B del %Y, %A'
} > bujo-$YEAR.org
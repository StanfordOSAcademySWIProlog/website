:- module(main, []).

:- use_module(library(arouter)).
:- use_module(library(docstore)).
:- use_module(library(bc/bc_main)).
:- use_module(library(bc/bc_view)).

:- bc_main('site.docstore').

:- route_get(/, send_front).

send_front:-
    (   ds_find(entry, (slug=intro, type=page), [Intro])
    ->  bc_view_send(views/page, _{
            html: Intro.html,
            title: Intro.title
        })
    ;   bc_view_not_found).

:- route_get(page/Slug, send_page(Slug)).

send_page(Slug):-
    (   ds_find(entry, (slug=Slug, type=page), [Page])
    ->  bc_view_send(views/page, _{
            html: Page.html,
            title: Page.title
        })
    ;   bc_view_not_found).


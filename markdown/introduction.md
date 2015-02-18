Introduction to Planning and Story Generation in SWI-Prolog
-----------------------------------------------------------

This page is to quickly introduce the planner aspect of Prolog.
Knowledge of Prolog is not required

A prolog planner is a sequence of actions that would allow the
end user to reach the desired goal produced by a system.  

Planners are a subset of expert systems that apply artificial intelligence programming techniques to problems that involve narrow, clearly defined subject areas. 

They differ from conventional programs in which facts and rules are separated from a program's underlying control structure and a program's reasoning can be explained simply to the user.    
  
#### Consider the following example problem:

>A hungry monkey is in a room. Suspended from the roof,<br> 
>just out of his reach, is a bunch of bananas. <br>
>In the corner of the
>room is a box. The monkey desperately wants the bananas
>but he can’t reach them. <br>What shall he do?<br>
>After several unsuccessful attempts to reach the bananas, the
>monkey walks to the box,<br> pushes it under the bananas, climbs
>on the box, picks the bananas and eats them.<br>
>The hungry monkey is now a happy monkey.

**To solve this problem the monkey needed to devise a plan, a
sequence of actions that would allow him to reach the desired
goal.**

To be able to plan, a system needs to be able to reason about
the individual and cumulative effects of a series of actions.

* Actions change the current state of the planning world, thereby
causing transitions to new states.

* However an action does not normally change everything in the
current state, just some components of the state.

* A good planning representation should therefore take into account
this locality of the effects of actions.



*We need to define a representation for two things:*

 - How will we represent the state of the world?

 - How will we represent actions and their local effect on the world?



Actions change the current state of the planning world, thereby
causing transitions to new states.

 - However an action does not normally change everything in the
current state, just some components of the state.

 - A good planning representation should therefore take into
account this locality of the effects of actions.



*Therefore, we need to be able to represent three states of the world:*


- initial state

- current state

- goal state



With these 3 states, anyone can construct a planner that produces a outcome based on the input of the user.


There are many kind of planners, such as STRIPS, CLP(FD)and FRAME. This website will cover and walk through 
some STRIPS style, and also briefly cover the implementaions of CLP(FD) and FRAME.



##### Credit to Dr. John. Kelleher of DIT for example and info. Complete slides and examples can be found [here](http://www.comp.dit.ie/jkelleher/ai1labs/Tut12-Planning1/Tut12.pdf)
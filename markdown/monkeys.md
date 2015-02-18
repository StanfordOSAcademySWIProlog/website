<html>
	<body BGCOLOR="FFFFFF">
	<h1>Monkey and Bananas Problem</h1>
	<hr>
	<p>Monkey and Bananas Problem is a good example of a problem that can be solved by planner.</p>
	<p>We mentioned in the Introduction section the basics of Monkey and Banana problem. Now after we know about the Graphplanner, we can try use the graphplanner to solve the problem.</p>
	<p>First of all, we need to find out the initial condition and the goal we want to achieve.</p>
	<p>Following is an example of the initial state:</p>
	<p>
	Initial State:
	<pre>
on(monkey, floor),
on(box, floor),
at(monkey, a),
at(box, b),
at(bananas, c),
status(bananas, hanging).
	</pre></p>
	<p>The goal will then be:</p>
	<p>
	Goal State:
	<pre>
on(monkey, box),
on(box, floor),
at(monkey, c),
at(box, c),
at(bananas, c),
status(bananas, grabbed).
	</pre></p>
	<p>There are a few actions availble for monkey to do: go(Monkey, X, Y), push(Monkey, X, Y), climb_on(Monkey, Box), and grab(Monkey, Bananas).</p>
	<p>What go/3 predicate does is the action of the monkey to move from X to Y. We need to define when we can do this action and what this action adds and deletes from the states.</p>
	<p><pre>
% go(Monkey,X,Y)
can(go(Monkey,X,Y), 
[at(Monkey, X), on(Monkey, floor), at(Box, Y), on(Box, floor)], monkey):-
	location(X),
	location(Y),
	location(Z),
	monkey(Monkey),
	box(Box),
	X \= Y.<br>
adds(go(Monkey,_X,Y), [at(Monkey, Y)], _, monkey):-
	monkey(Monkey),
	location(Y).<br>
deletes(go(Monkey,X,_Y), [at(Monkey, X)], monkey):-
	monkey(Monkey),
	location(X).
	</pre></p>
	<p>The condition when a monkey can move from X to Y is when the monkey is on the floor and there is a Box at Y so that the monkey wants to move there to get to the box. Also, we want to make sure that X and Y are different.</p>
	<p>The add predicate adds the new state to the current states. In this case, it adds at(Monkey, Y) indicating that the monkey is at Y now. The delete predicate deletes the old state that is no longer true, which is at(Monkey, X) as the Monkey moves to Y.</p>
	<p>The other actions follow the similar logic</p>
	<p>For push/3:</p>
	<p><pre>
% push(Monkey,X,Y)
can(push(Monkey,X,Y), [at(Monkey,X), at(Box, X), at(Bananas, Y), on(Monkey, floor), on(Box, floor)], monkey):-
	location(X),
	location(Y),
	bananas(Bananas),
	box(Box),
	monkey(Monkey),
	X \= Y.<br>
adds(push(Monkey,_X,Y), [at(Monkey,Y), at(Box, Y)], _, monkey):-
	location(Y),
	monkey(Monkey),
	box(Box).<br>
deletes(push(Monkey,X,_Y), [at(Monkey,X), at(Box,X)], monkey):-
	location(X),
	monkey(Monkey),
	box(Box).
	</pre></p>
	<p>When using push, we need to make sure both the Monkey and the Box are at the same place so that the Monkey can push the box. After pushing, we want to delete the original location for both Monkey and Box and add the new location.</p>
	<br>
	<p>For climb_on/2:</p>
	<p><pre>
% climb_on(Monkey, Box)
can(climb_on(Monkey,Box), [at(Monkey,X), at(Box, X), at(Bananas, X)], monkey):-
	location(X),
	bananas(Bananas),
	box(Box),
	monkey(Monkey).<br>
adds(climb_on(Monkey,Box), [on(Monkey,Box)], _, monkey):-
	monkey(Monkey),
	box(Box).<br>
deletes(climb_on(Monkey,Box), [on(Monkey,floor)], monkey):-
	monkey(Monkey),
	box(Box).
	</pre></p>
	<p>When using climb_on, we need to make sure that the Monkey, the Box and the Bananas are at the same place, so that the monkey should climb on the box. We add and delete states to indicate that monkey is no longer on the floor but on the box. </p>
	<br>
	<p>For grab/2:</p>
	<p><pre>
% grab(Monkey,Bananas)
can(grab(Monkey,Bananas), [at(Monkey,X), at(Box, X), at(Bananas, X), on(Monkey,Box)], monkey):-
	location(X),
	bananas(Bananas),
	box(Box),
	monkey(Monkey).<br>
adds(grab(Monkey,Bananas), [status(Bananas, grabbed)], _, monkey):-
	monkey(Monkey),
	bananas(Bananas).<br>
deletes(grab(Monkey,Bananas), [status(Bananas, hanging)], monkey):-
	monkey(Monkey),
	bananas(Bananas).
	</pre></p>
	<p>When using grab, we need to make sure that the Monkey and the Box are at the same location as the Bananas. Also, the Monkey should already be on the Box. We change the status of the Bananas to grabbed from hanging.</p>
	<p>We know have the preconditions, the actions and the goals. It is time to run the test to find a solution for our little monkey!</p>
	<p><pre>
	test(P):-
	plan([on(monkey1, floor),on(box1, floor),
		at(monkey1, a),at(box1, b),at(bananas1, c),status(bananas1, hanging)],
		[on(monkey1, box1),on(box1, floor),
		at(monkey1, c),at(box1, c),at(bananas1, c),status(bananas1, grabbed)],
		monkey, P).
	</pre></p>
	<p>The output of P will be:</p>
	<p><pre>
Step 1:
        go(monkey1,a,b)<br>
Step 2:
        push(monkey1,b,c)<br>
Step 3:
        climb_on(monkey1,box1)<br>
Step 4:
        grab(monkey1,bananas1)<br>
P = [[go(monkey1, a, b)], [push(monkey1, b, c)],
[climb_on(monkey1, box1)], [grab(monkey1, bananas1)]] .</pre></p>
	<p>This is how we can solve a simple version of the Monkey and Bananas Problem. You can use this graph planner to solve a lot of different kinds of problems. The key things are to correctly define the intial states, actions and the goals. You can try doing a scheduling problem by yourself after you understand this process! Good luck and have fun learning!</p>
	</body>
</html>
<html>
	<body BGCOLOR="FFFFFF">
		<hr>
		<h1>STRIPS-style planner</h1>
		<p>STRIPS stands for Stanford Research Institute Problem Solver, which is an automated planner popular in artificial intelligence.</p>
		<p>Let's take a look at one of a large amount of different implementation of the STRIPS planner.</p>
		<p>This implementation is provided by Dr. Suresh Manandhar from the University of York Computer Science department and slightly modified by Dr. Pierre Andrews.This is an open source implementation, which is why we are able to use it for this tutorial. </p>
<p>Complete source code can be found <a href="https://github.com/Mortimerp9/Prolog-Graphplan">here</a> on Github.</p>
		<hr>
		<p>Let's start with the main predicate plan/4. There are InitialState, FinalState, Domain, Plan in the predicate. </p>
		<p>InitialState contains the initial conditions and the FinalState contains the states after the final goal is reached. Domain contains the available actions and the Plan consists the set of actions to get from the InitialState to FinalState.</p>
		<p><pre>
		plan(InitialState, FinalState, Domain, Plan):-
			retractall(no_op_count(_)),
			retractall(mutex_action(_, _, _)),
			retractall(mutex_condition(_, _, _)),<br>
			retractall(plan_graph_del(_, _, _)),
			retractall(plan_graph_add(_, _, _)),
			retractall(plan_graph_pre(_, _, _)),<br>
			assert(no_op_count(0)),
			add_initial_conditions(InitialState),
			generate_graph_nodes(1, FinalState, FinalLevel, Domain),
			find_plan(FinalLevel, FinalState, InitialState, [], PlanT),
			remove_no_ops(PlanT, Plan),
			nl, nl, write_plan(Plan), nl.
		</pre></p>
		<p>All the retractall statemnets are used to remove the data currently stored in the database. Firstly, we need to add the initial conditions to the graph, which is included in the InitialState. Then we can generate the graph of mapping from InitialState to FinalState with a given domain. We can then find the plan on the graph.</p>
		<p>Adding the initial conditions stores the initialstate as nodes in the database. </p>
		<pre>
		add_initial_conditions([]).
		add_initial_conditions([Pred|Conditions]):-
			add_plan_graph(0, add, Pred, start),
			add_initial_conditions(Conditions).</pre>
		<p>We can see that add_plan_graph/4 actually calls assert, which insert the nodes as facts to the prolog database. </p>
		<p>Generate_graph_nodes search for the available actions under the current states and add the next states under the new actions as nodes into the graph. </p>
		<pre>
		generate_graph_nodes( N, FinalState, N1, _Domain):-
			N1 is N-1,
			%% Check if FinalState Conditions have been satisfied 
		        %%    and no mutual exclusion conditions have been violated
			get_nonmutex_addconds(FinalState, N1, []),
			nl, write('Feasible Plan found at level '), write(N1),
			!.<br>
		generate_graph_nodes(N, _, _, _Domain):-
			% Add no-ops
			add_no_op_nodes(N),
			fail.<br>
		generate_graph_nodes(N, _, _, Domain):-
			can(Action, PreConditions, Domain),
			NPrev is N-1,<br>
			get_nonmutex_addconds(PreConditions, NPrev, []),				
			deletes(Action, DelPreConditions, Domain),
			%% Instantiation Check
			( ground(DelPreConditions) 
		           -> true
		            ; ( 
			        nl, 
				write('Action not fully instantiated '), write(Action),
				nl,
				write('Del Conditions: '), write(DelPreConditions), nl
			    )
			),<br>		
			adds(Action, AddConditions, _, Domain),
			%% Instantiation Check
			( ground(AddConditions) 
		           -> true
		            ; ( 
			        nl, 
				write('Action not fully instantiated '), write(Action),
				nl,
				write('Add Conditions: '), write(AddConditions), nl
			    )
			),<br
			add_graph_nodes(PreConditions, Action, N, pre),
			add_graph_nodes(DelPreConditions, Action, N, del),
			add_graph_nodes(AddConditions, Action, N, add),
		%	nl, write("Added Action: "), write(Action),
		%	nl,
			fail.<br>
		generate_graph_nodes(N, FinalState, FinalLevel, Domain):-
			% Propagate mutual exclusions
			mutex(N),
			N1 is N+1,
			!,
			generate_graph_nodes(N1, FinalState, FinalLevel, Domain),
			!.
			</pre>
		<p>The generate_graph_nodes/4 predicates also ensure mutual exclusion, which makes sure that the graph does not contain loops. The process stops when we reaches the final states. </p>
		<p>The generate_graph_nodes/4 predicates also ensure mutual exclusion, which makes sure that the graph does not contain loops. The process stops when we reaches the final states. </p>
		<pre>
		PrevActions, Plan):-
			N > 0,
			find_current_level_actions(N, CurrentState,  [], CurLevelNActions, []),	
			findall(Cond,(member(Action,CurLevelNActions), plan_graph(N, pre, Cond, Action)), PreConds),
			list_to_set(PreConds, MidState),
			nl, write(' Level  '), write(N),
			nl, write('Actions : '), nl, write(CurLevelNActions),
			nl, write('State   : '), nl, write(CurrentState), nl,nl,
			N1 is N-1,
			find_plan(N1, MidState, InitialState, [CurLevelNActions|PrevActions], Plan).
			</pre>
		<p>The predicates search for available actions at the current level and list the next states in parallel. Then they try to find the next level actions by call on find_plan/4 again.</p>
		<p>The predicates use the built-in predicates provided by Prolog - findall/4 and list_to_set/2.</p>
		<p>There can be no_op(X) inserted in the plan because at some level there is no possible moves. As a result, we want to remove the no_ops.</p>
		<p>Finally, we can write the plan out to the screen by write_plan/1. </p>
		<hr>
		<p>We now have the planner. Let's look at a demostration of the planner using one of the graph provided by graphplanner.
		The rocket_graph contains the defintion of domain and the available actions.
		This example wants to move the cargos from one city to another.
		We first define the knowledge base of rocket, place and cargo.</p>
		<pre>
		place(london).
		place(paris).
		cargo(a).
		cargo(b).
		cargo(c).
		cargo(d).
		cargo(e).
		</pre>
		<p>Then we define the available actions of move, unload and load the rocket.
		For each action, we define the condition when the action can take place and then the conditions that can be added or deleted from the conditions current conditions after performing the action.
		So move(Rocket, From, To) would look like the following.</p>
		<pre>
		%move(Rocket, From, To).
		can(move(Rocket,From,To),[at(Rocket,From), has_fuel(Rocket)], rocket) :- %vehicle move only within city
			rocket(Rocket),
			place(From),
			place(To),
			From \= To.<br>
		adds(move(Rocket,_From,To),[at(Rocket, To)], at(Rocket,To), rocket):-
			rocket(Rocket),
			place(To).<br>
		deletes(move(Rocket,From,_To),[at(Rocket,From)], rocket):-
			rocket(Rocket),
			place(From).
		Let's test out the planner
		test(P) :-
			plan([at(a, london), at(rocket1, paris), has_fuel(rocket1)],
			     [at(a, paris)], rocket,
			     P).
		</pre>
		<p>We provide the planner with the initial conditions of [at(a, london), at(rocket1, paris), has_fuel(rocket1)], the final condition of [at(a, paris)], the domain(rocket), and the planner should fill in the plan P.</p>
		<p>The output is
		<pre>?- test(P).
		Feasible Plan found at level 4
		 Level  4
		Actions :
		[unload(rocket1,paris,a)]
		State   :
		[at(a,paris)]<br>
		 Level  3
		Actions :
		[no_op(11),move(rocket1,london,paris)]
		State   :
		[at(rocket1,paris),in(a,rocket1)]<br>
		 Level  2
		Actions :
		[no_op(5),no_op(6),load(rocket1,london,a)]
		State   :
		[in(a,rocket1),at(rocket1,london),has_fuel(rocket1)]<br>
		 Level  1
		Actions :
		[no_op(0),move(rocket1,paris,london),no_op(2)]
		State   :
		[has_fuel(rocket1),at(rocket1,london),at(a,london)]<br><br>
		Step 1:
		        move(rocket1,paris,london)<br>
		Step 2:
		        load(rocket1,london,a)<br>
		Step 3:
		        move(rocket1,london,paris)<br>
		Step 4:
		        unload(rocket1,paris,a)<br><br>
		P = [[move(rocket1, paris, london)], [load(rocket1, london, a)], [move(rocket1, london, paris)], [unload(rocket1, paris, a)]].
		</pre></p>
                <p>This is the example provided by the author of the planner. Next, let's see how we can apply the things we have known and solve a problem with the graph planner. Application: <a href="/page/problem">Monkey and Bananas Problem</a></p>
	</body>
</html>
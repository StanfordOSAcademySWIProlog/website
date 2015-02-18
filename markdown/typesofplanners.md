<p>There are many applications of planners that are being used in the world today. Examples use of planners range from space missions, medical diagnosis, vacation planners, project management and  artificial intelligence. There are different kind of planners, each with their own strengths and characteristics.</p>    

<h3>STRIPS Planning</h3>

---------------


<p>STRIPS, also known as Stanford Research Institute Problem Solver, is one of the most used automated planners. <br>Most planners incorporate some style of STRIPS into their planning scheme. A STRIPS planner instance is composed of 3 major components:</p>

* Initial state
* Specification of goal states-situation where the planner is trying to reach
* Set of actions which include a precondition and postcondition

<p> In strips, the initial state, is the starting initial set of conditions that are all true. In order to reach the goal state, there are world states that are represented as a set of facts. World states can be thought as options for the planner to take to reach the goal. In STRIPS, the closed world assumption states that any fact not listed in a state is assumed to be false<p>

<p> Goals are also represented as a set of facts. The goal state is any state that contains all the goal facts for the condition to be met.</p>

<p> Actions in STRIPS are represented in 3 phases.

* PRE of preconditions of facts
* ADD of add effects facts
* DEL of delete effect facts

An action is only allowed in a new state when the preconditions are contained in the old state. Once the action has been executed, the planner enters a new state with a given set of new facts. From there , the planner either checks if it has reached its goal state, or repeats and continues on to reach the goal state.</p>

<p> In short, the objective of a STRIPS planner is to find a short action sequence reaching a goal state, or report that the goal is unachievable.</p>

<b>Credit to <a href="http://en.wikipedia.org/wiki/STRIPS">Wikipedia</a> and <a href="http://web.engr.oregonstate.edu/~afern/classes/cs533/notes/strips-intro.pdf"> Alan Fern</a> of Oregon State for information</b>

<br>
<br>

<h3> Hierarchical Network Planners </h3>

---------------

<p> HTN are another type of planners used in automated planning. Similar to strips, HTN differ from STRIPS in which dependency among actions can be given in the form of networks

In HTN, tasks are broken into 3 categories:

* Primitive tasks, which roughly correspond to actions of STRIPS
* Compound tasks, which can be seen as composed of a set of simpler tasks
* goal tasks, which roughly correspond to the goals of STRIPS, but are more general

<p> A primitive task by definition is an action that can be executed, a compound task is a complex task composed of a sequence of actions,<br> and a goal task is the task of satisfying a condition. <br>Primitive actions can be executed directly while compound and goal tasks require a sequence of primitive actions to be formed. <br>Goal tasks however are specified in terms of conditions that to be made true,<br> while compound tasks can only be specified in terms of other tasks through the task network. </p>

<p> Constraints among tasks are expressed in form of networks called task networks. A task network is a set of tasks and constraints among them,<br> and can be used as a precondition for another compound task or goal to be attainable. <br>With this setup, one can express a given task is doable only if a set of other actions within the network are done,<br> and done with such a way that the constraints are satisfied. </p>

<p>An example would be that a condition is necessary for a specific primitive action to be executed.<br> When this is used as the precondition for a compound task or goal, it means that the compound or goal task requires the primitive action to be executed,<br> and that the condition must be true for its execution to successfully achieve the compound or goal task.</p>

<br>

<h3> Planning Domain Definition Language </h3>

---------------------------------------------

<p> The PDDL was a attempt to be the standard for classical programming tasks. PDDL is composed of the following components:

* Objects- Things in the world that interest us
* Predicates- Properties of objects that we are interested in; can be true or false
* Initial State- The state of the world that we start in
* Goal specification- Things that we want to be true
* Actions/Operators- Ways of changing the state of the world

In PDDL, planning tasks are separated into 2 files

* A domain file for predicates and actions
* A problem file for objects, initial state and goal specification

<p>In the Domain file, the title of the file specifies the domain name, followed by the Objects and the predicates. After this are the list of actions with parameters, with preconditions and effects, similar to STRIPS. The effects of actions could also be conditional</p>

<p>In the problem file, the title of the file specifies the problem name. Followed by the problem name is the domain name, which must match the corresponding domain with the corresponding domain file. The file then specifies the initial state, followed by the goal specification.</p>

<p> As described above, PDDL is very similar to STRIPS with the preconditions, effects, initial state and goal state. The only major difference is that the problem is separated into a different file. Nevertheless, PDDL is a excellent planner to use when deciding to choose a planner.</p>

<b> Credit to Malte Helmert of <a href="http://www.cs.toronto.edu/~sheila/2542/s14/A1/introtopddl2.pdf">University of Toronto</a> and <a href= "http://en.wikipedia.org/wiki/Planning_Domain_Definition_Language">Wikipedia</a> for sources and information</b>

<br>
<br>

<h3> Narrative Generation </h3>

-------------------------------

<p>Narrative generation is interesting type of planning, in which the made plan simulates deviations as the plan is executed. The planner replans based on the new state, and continues on its way to its goal. Sometimes, the end goal is changed in order make the specific goal achievable.</p>

<p>For example, a plane takes off from a certain airport, all is going well after take off until a passenger gets extremely sick. The planner simulates the sick passenger deviation, as a regular trip would just end with nothing significantly happening. From there, the planner can decide  to change the end destination, continue on to the designated end designation, or fly back to the starting airport. The narrative generator has many options as this point, and can simulate the different goal endings at well!</p>

<p>You can check out a great example called <a href="https://github.com/Anniepoo/prolog-examples/blob/master/talespin2.pl">Talespin</a> written by Anne Ogborn, a active prolog user in the prolog community. The only requirement is to have prolog installed on your system, and once that is set up, simply run the file and the planner will run different deviations of the journey!</p>
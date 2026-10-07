% ============================================================
% SWC2623 SOFTWARE DEVELOPMENT PARADIGMS
% PART B - LOGIC PROGRAMMING
% MODULE ADVISORY AND CERTIFICATION SYSTEM
% ============================================================

% ============================================================
% LEARNERS
% learner(LearnerID, Name).
% ============================================================

learner(l001, leman).
learner(l002, wan).
learner(l003, ahmad).
learner(l004, ali).
learner(l005, abu).

% ============================================================
% MODULES
% module(ModuleID, ModuleName).
% ============================================================

module(m01, programming_fundamentals).
module(m02, database_systems).
module(m03, web_development).
module(m04, data_structures).
module(m05, software_engineering).
module(m06, advanced_programming).

% ============================================================
% COMPLETED MODULES
% completed(LearnerID, ModuleID).
% ============================================================

% Leman
completed(l001, m01).
completed(l001, m02).

% Wan
completed(l002, m01).
completed(l002, m02).
completed(l002, m03).
completed(l002, m04).
completed(l002, m05).
completed(l002, m06).

% Ahmad
completed(l003, m01).

% Ali
completed(l004, m01).
completed(l004, m02).
completed(l004, m03).

% Abu
% Abu has not completed any module.

% ============================================================
% MODULE PREREQUISITES
% prerequisite(ModuleID, RequiredModuleID).
% ============================================================

% Web Development requires Programming Fundamentals
prerequisite(m03, m01).

% Data Structures requires Programming Fundamentals
prerequisite(m04, m01).

% Software Engineering requires Programming Fundamentals
% and Database Systems
prerequisite(m05, m01).
prerequisite(m05, m02).

% Advanced Programming requires Data Structures
prerequisite(m06, m04).

% M01 and M02 have no prerequisites.

% ============================================================
% PROGRAMME REQUIRED MODULES
% All six modules are required for certification.
% ============================================================

required_module(m01).
required_module(m02).
required_module(m03).
required_module(m04).
required_module(m05).
required_module(m06).

% ============================================================
% CHECK WHETHER LEARNER HAS COMPLETED A MODULE
% ============================================================

has_completed(LearnerID, ModuleID) :-
    completed(LearnerID, ModuleID).

% ============================================================
% CHECK WHETHER ALL PREREQUISITES ARE COMPLETED
% ============================================================

prerequisites_satisfied(LearnerID, ModuleID) :-
    forall(
        prerequisite(ModuleID, RequiredModule),
        has_completed(LearnerID, RequiredModule)
    ).

% ============================================================
% CHECK MODULE ELIGIBILITY
%
% A learner is eligible when:
% 1. Learner exists
% 2. Module exists
% 3. Learner has not completed the module
% 4. All prerequisites are completed
% ============================================================

eligible(LearnerID, ModuleID) :-
    learner(LearnerID, _),
    module(ModuleID, _),
    \+ completed(LearnerID, ModuleID),
    prerequisites_satisfied(LearnerID, ModuleID).

% ============================================================
% RECOMMEND MODULES
%
% Returns modules that the learner has not completed
% and is currently eligible to take.
% ============================================================

recommend_modules(LearnerID, Modules) :-
    findall(
        ModuleID,
        eligible(LearnerID, ModuleID),
        Modules
    ).

% ============================================================
% CHECK CERTIFICATION ELIGIBILITY
%
% Learner must complete every required module.
% ============================================================

certification_eligible(LearnerID) :-
    learner(LearnerID, _),
    forall(
        required_module(ModuleID),
        completed(LearnerID, ModuleID)
    ).

% ============================================================
% CERTIFICATION STATUS
% ============================================================

certification_status(LearnerID, eligible) :-
    certification_eligible(LearnerID).

certification_status(LearnerID, not_eligible) :-
    learner(LearnerID, _),
    \+ certification_eligible(LearnerID).

% ============================================================
% DISPLAY LEARNER NAME
% ============================================================

learner_name(LearnerID, Name) :-
    learner(LearnerID, Name).

% ============================================================
% DISPLAY MODULE NAME
% ============================================================

module_name(ModuleID, Name) :-
    module(ModuleID, Name).

% ============================================================
% DISPLAY RECOMMENDED MODULE NAMES
% ============================================================

recommended_module_names(LearnerID, Names) :-
    recommend_modules(LearnerID, ModuleIDs),
    findall(
        Name,
        (
            member(ModuleID, ModuleIDs),
            module(ModuleID, Name)
        ),
        Names
    ).

% ============================================================
% MAIN PROGRAM
% ============================================================

:- initialization(main).

main :-
    write('Smart Learning Pathway and Certification System'), nl,
    write('================================================'), nl, nl,

    % Query 1 - Successful eligibility
    write('Query 1: Is Leman eligible for Web Development?'), nl,
    ( eligible(l001, m03) ->
        write('Result: Yes'), nl
    ;
        write('Result: No'), nl
    ),
    nl,

    % Query 2 - Unsuccessful eligibility
    write('Query 2: Is Ahmad eligible for Advanced Programming?'), nl,
    ( eligible(l003, m06) ->
        write('Result: Yes'), nl
    ;
        write('Result: No'), nl
    ),
    nl,

    % Query 3 - Recommendations for Leman
    write('Query 3: Recommended modules for Leman:'), nl,
    recommend_modules(l001, Modules1),
    write(Modules1), nl, nl,

    % Query 4 - Recommendations for Abu
    write('Query 4: Recommended modules for Abu:'), nl,
    recommend_modules(l005, Modules2),
    write(Modules2), nl, nl,

    % Query 5 - Successful certification
    write('Query 5: Is Wan eligible for certification?'), nl,
    ( certification_eligible(l002) ->
        write('Result: Yes'), nl
    ;
        write('Result: No'), nl
    ),
    nl,

    % Query 6 - Unsuccessful certification
    write('Query 6: Is Ali eligible for certification?'), nl,
    ( certification_eligible(l004) ->
        write('Result: Yes'), nl
    ;
        write('Result: No'), nl
    ),
    nl.
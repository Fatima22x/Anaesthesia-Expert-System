/*****************************************************************************

Copyright (c) Zahra, Shahad, Fatima from CS17

  Project: ANAESTHESIA_EXPERT_SYSTEM
  FileName: ANAESTHESIA_EXPERT_SYSTEM.PRO
  Purpose: This is an expert system that aims to help anesthesiologists
  in choosing the right type of anesthesia, the right dose and other related decisions.
  Written by: Visual Prolog
  Comments: The project is delivered as part of CPCS 331 : Artificial Intelligence 1 course
during fall semester 2019
******************************************************************************/
Domains %Domains that are NOT prolog standard domains
  type_of_anaesthesia = symbol
  fullname = fullname(string,string,string)
  age = integer
  gender = char
  weight = integer
  operation_type = symbol
  patient_id = integer
  anesthetic_type = string
  special_cases = string
  pressure = integer

Predicates %Functions or prosedures that return true/false
  anaesthesia_expert_system(integer).
  exists(integer).
  print_record(integer).
  appropriate_dose(patient_id).
  type_of_anesthesia(operation_type).
  patient(patient_id,fullname,age,gender,weight,operation_type,special_cases).
  special_instructions(string).
  type_of_anesthetic(symbol).
  blood_pressure(pressure).
  temperature(integer).
 
Clauses %Rules or Queries
  %Patient 1
  patient(32323,fullname("Zahra","Ahmad","Al Safwan"),22,'f',65,skin,"Anemia").
  %Patient 2
  patient(13134,fullname("Nahed","Abdulaziz","AlOwidi"),40,'f',60,caesareanBirths,"Breathing issues").
  %Patient 3
  patient(34244,fullname("Fatimah","Mohammad","Falath"),22,'f',65,nose,"Kidney problems").
  %Patient 4
  patient(65365,fullname("Ghadeer","Ahmad","Al Safwan"),25,'f',55,teeth,"Heart problems").
  %Patient 5
  patient(00392,fullname("Yousef","Mohammad","Al Jawad"),7,'m',35,cruciateLigament,"").
  %Patient 6
  patient(02759,fullname("Fai","Ghanim","Asiri"),18,'f',45,gallbladder,"").
  %Patient 7
  patient(84378,fullname("Fatimah","Mohammad","AlMajid"),14,'f',40,teeth,"").
 
  anaesthesia_expert_system(1):-
  write("------------------------Welcome to Anaesthesia Expert System------------------------"),nl,
  %Prompt the user to enter patient Id
  write("Enter patient_id: "),
  %Read Id from the user
  readInt(Id),
  %Check if the patient record exists
  exists(Id),
  write("***********************************Report******************************************"),nl,
  patient(Id,_,_,_,_,Op,Special_case),
  type_of_anesthesia(Op),
  appropriate_dose(Id),
  special_instructions(Special_case),
  write("Enter the blood pressure:"),
  readInt(BP),
  blood_pressure(BP),
  write("***********************************************************************************"),nl,
  write("Do you want to continue (1 yes / 0 no):"),
  readInt(Input),
  %Continue program until the user
  anaesthesia_expert_system(Input).
  anaesthesia_expert_system(0):-write("Thank you for using Anaesthesia Expert System."),nl.

 %Checks the existance of the patient Id
  exists(X):-
   patient(X,_,_,_,_,_,_),
   write("The patient with id ",X," registered in the system"),nl,
   write("---------------------------------------------------------------------------------"),nl,
   write("Id FullName"),nl,
   print_record(X).
  exists(_):- write("Wrong patient Id"),nl.

  %Print patient record (Id and Name)
  print_record(X):-
   patient(X,fullname(F,M,L),_,_,_,_,_),
   write(X," ",F," ",M," ",L),nl,
   write("---------------------------------------------------------------------------------"),nl.
 
  %Specify the appropriate dose for the patient
  %when age: 0< age <= 18
  appropriate_dose(X):-patient(X,_,A,_,W,_,_),A>=1, A<=18 , ! ,Opr = W/2,
  write("The appropriate Amount of Anesthesia is: " , Opr , "ml."), nl.
  %when age: 18< age <= 50
  appropriate_dose(X):- patient(X,_,A,_,W,_,_), A>18 , A<= 50 , ! ,
  write("The appropriate Amount of Anesthesia is: " , W , "ml."),nl.
  % when age > 50
  appropriate_dose(X):- patient(X,_,A,_,W,_,_),A>50 , ! ,Opr = W/4,
  write("The appropriate Amount of Anesthesia is: " , Opr , "ml."),nl.
 
  %determine type of anesthesia
  type_of_anesthesia(skin):-
  write("Type of Anesthesia is: local Anesthesia"), nl , type_of_anesthetic(local),nl.
  type_of_anesthesia(teeth):-
  write("Type of Anesthesia is: local Anesthesia"), nl , type_of_anesthetic(local),nl.
  type_of_anesthesia(limbs):-
  write("Type of Anesthesia is: local Anesthesia"), nl , type_of_anesthetic(local),nl.
  type_of_anesthesia(caesareanBirths):-
  write("Type of Anesthesia is: regional Anesthesia"), nl , type_of_anesthetic(regional),nl.
  type_of_anesthesia(cruciateLigament):-
  write("Type of Anesthesia is: regional Anesthesia"), nl, type_of_anesthetic(regional),nl.
  type_of_anesthesia(gallbladder):-
  write("Type of Anesthesia is: genral Anesthesia"), nl, type_of_anesthetic(general),nl.
  type_of_anesthesia(appendicitis):-
  write("Type of Anesthesia is: genral Anesthesia"), nl, type_of_anesthetic(general),nl.
  type_of_anesthesia(nose):-
  write("Type of Anesthesia is: genral Anesthesia"), nl, type_of_anesthetic(general),nl.
 
  %determine type of anesthetic
  type_of_anesthetic(regional):-
   write("The Appropriate medicatin is: fentanyl & sufentanil.").
  type_of_anesthetic(general):-
   write("The Appropriate medicatin is: Propofol & diazepam.").
  type_of_anesthetic(local):-
    write("The Appropriate medicatin is: Lidcaine & bupivacaine.").
 
  special_instructions("Anemia"):- write("The patient may need more blood during the operation."),nl.
  special_instructions("Breathing issues"):- write("The patient may need more oxygen during the operation."),nl.
  special_instructions("Kidney problems"):- write("Avoid using sodium-containing medications for the patient."),nl.
  special_instructions("Heart problems"):- write("Avoid using Anticoagulants for the patient."),nl.
  special_instructions(_):-write("No special instructions for this patient."),nl.

  %Check on blood pressure
  blood_pressure(BP):- BP >= 80 , BP <= 120
  , write("The operation can be done"), nl,
  write("Enter the temprature of the patient: "),
  readInt(T),
  temperature(T),nl.
  blood_pressure(BP):-
   write("CAUTION: The operation CANNOT be done, blood pressure is",BP), nl.
   
   temperature(T):- T>39 ,
   write("Should use a medicine to reduce body temperature before start surgery").
   temperature(T):- T>=37 , T<= 39 ,
   write("").
 
Goal %Goal that need to be tested
anaesthesia_expert_system(1).
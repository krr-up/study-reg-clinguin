% program({program_abbr},"{details["program_full_name"]}",{program_degree},{program_code},{program_version}).
% module_program({module["id"]},"{module["title"]}",{module["abbreviation"]},{module["credits"]},{program_abbr}).
% examination({exam["id"]},"{exam["form"]}","{exam["title"]}",{exam["type"]},{exam["module_abbreviation"]},{program_abbr}).

program("COG","Cognitive Systems: Language, Learning and Reasoning","MS","H","20142").
module_program("55580","Machine Learning and Data Analysis",bm2,9,"COG").
examination("555802","MP","Mündliche Prüfung","PL",bm2,"COG").
examination("555812","V","Intelligent Data Analysis","SL",bm2,"COG").
examination("555813","U","Intelligent Data Analysis","PNL",bm2,"COG").
module_program("55590","Advanced Problem Solving Techniques",bm3,9,"COG").
examination("555901","MP","Klausur","PL",bm3,"COG").
examination("555911","V","Vorlesung","SL",bm3,"COG").
examination("555912","U","Übung","SL",bm3,"COG").
examination("555913","PR","Praktisches Arbeiten","PNL",bm3,"COG").
examination("555914","PJ","Projekt","PNL",bm3,"COG").
module_program("55600","Foundations of Computer Science",fm2,6,"COG").
examination("556001","MP","Mündliche Prüfung","PL",fm2,"COG").
examination("556011","V","Video-Vorlesung","SL",fm2,"COG").
examination("556012","U","Übung","PNL",fm2,"COG").
module_program("55610","Current Topics in Computational Intelligence 1",am31,6,"COG").
examination("556111","V1","Vorlesung oder Seminar","PL",am31,"COG").
module_program("55620","Current Topics in Computational Intelligence 2",am32,6,"COG").
examination("556211","V1","Vorlesung oder Seminar","PL",am32,"COG").
module_program("55630","Project in Computational Intelligence",pm3,12,"COG").
examination("556311","S","Seminar","PL",pm3,"COG").
module_program("82190","Advanced Natural Language Processing",bm1,9,"COG").
examination("821901","MP","Klausur","PL",bm1,"COG").
examination("821902","MP","Abschlussprojekt","PL",bm1,"COG").
examination("821911","V","Vorlesung","SL",bm1,"COG").
examination("821912","U","Übung","PNL",bm1,"COG").
module_program("82200","Foundations of Mathematics",fm1,6,"COG").
examination("822001","MP","Mündliche Prüfung","PL",fm1,"COG").
examination("822011","V","Video-Vorlesung","SL",fm1,"COG").
examination("822012","U","Übung","PNL",fm1,"COG").
module_program("82210","Foundations of Linguistics",fm3,6,"COG").
examination("822101","MP","Mündliche Prüfung","PL",fm3,"COG").
examination("822111","V","Video-Vorlesung","SL",fm3,"COG").
examination("822112","U","Übung","PNL",fm3,"COG").
module_program("82220","Current Topics in Computational Linguistics 1",am11,6,"COG").
examination("822211","V1","Vorlesung oder Seminar","PL",am11,"COG").
module_program("82230","Current Topics in Computational Linguistics 2",am12,6,"COG").
examination("822311","V1","Vorlesung oder Seminar","PL",am12,"COG").
module_program("82240","Current Topics in Machine Learning 1",am21,6,"COG").
examination("822411","V1","Vorlesung oder Seminar","PL",am21,"COG").
module_program("82250","Current Topics in Machine Learning 2",am22,6,"COG").
examination("822511","V1","Vorlesung oder Seminar","PL",am22,"COG").
module_program("82260","Project in Computational Linguistics",pm1,12,"COG").
examination("822611","S","Seminar","PL",pm1,"COG").
module_program("82270","Project in Machine Learning",pm2,12,"COG").
examination("822711","S","Seminar","PL",pm2,"COG").
module_program("82280","Individual Research Module",im,15,"COG").
examination("822811","PJ","Forschungsprojekt","PL",im,"COG").
module_program("","Master's Thesis",msc,30,"COG").
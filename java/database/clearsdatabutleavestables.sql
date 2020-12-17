/*structure notes:

== ROLE_USER == a student, or anybody who is not a teacher or admin
== ROLE_TEACHER == create assignments and curriculum
== ROLE_ADMIN == database owner. creates courses, enrolls all other users to their respective courses


== COURSES == 

'Math 241'
--teachers: useruser10, useruser11 , teacher
--students: UU1,UU3,UU4,UU6,UU8,UU17, user , student
--THERE SHOULD BE 3 ASSIGNMENTS associated with this course. named 'Fundamentals 1' - text , 'Fundamentals 2' - multiple choice, 'Fundamentals 3' - text
--All students have turned in these assignments BESIDES username 'user' and 'useruser1'
--'Fundamentals 1' should be fully graded, accurately
--'Fundamentals 2' is identical, but a multiple choice version (I am referring to the test questions NOT the answers given)
--'Fundamentals 3', only username:'student' has been graded.

'Relational Databases'
--teachers: useruser14 
--students: student,UU4,UU7,UU9,UU18 (exactly the class limit)
--THERE SHOULD BE 2 ASSIGNMENTS : 'First Week Quiz' And 'Second Week Quiz'
--All students BESIDES useruser18 have turned in 'First Week Quiz', all are ungraded for this assignment.
--ONLY 'student' and useruser7 have turned in 'Second Week Quiz', both of those have been graded.


'Sea as in Cnidarian: Spelling 101'
--teachers: useruser15, useruser10 
--students: UU1,UU8,UU9,UU17, student
--No assignments, embed youtube video in link

'Object Oriented Programming'
--teachers: useruser13, teacher
--students: UU1,UU3,UU4,UU6, user, student
--tech elevator book as the lesson plan. to add more, save the html, and post into a curriculum object. 
---------------(first open in notepad and delete all single quote marks -- jdbc handles these things for us, dont worry)

'Ancient Roman Literature: Catullus'
--teachers: useruser10, teacher 
--students: UU1,UU3,UU4,UU6,UU18,UU19

==Assignments==
Specifically Math 241 and Relational Databases are the courses with assignments added in. Look at the comments on those course to see what's graded^

==grade==
keep in mind the only column that gills out "date submitted" is grade. meaning this value should be captured once the assignment has no remaining questions, 
NOT when the teacher chooses to grade it.

==multiple choice== 
may need some tweaking
Currently I am associating A-1, B-2, C-3, D-4, and assuming that the question statement will list the options next to (a,b,c,d)

*/
BEGIN TRANSACTION;

DELETE FROM  mcchoice;
DELETE FROM  grade;
DELETE FROM  message;
DELETE FROM  question;
DELETE FROM  curriculum;
DELETE FROM  teacher;
DELETE FROM  student;
DELETE FROM  answer;
DELETE FROM  assignment;
DELETE FROM  course;
DELETE FROM  users;

INSERT INTO users (username,password_hash,role) VALUES ('user','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('admin','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_ADMIN');
INSERT INTO users (username,password_hash,role) VALUES ('student','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('teacher','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_TEACHER');

--let's add a good amount of users. (username: useruser(x) password: useruser(x))
--ROLE_USER==1-9
INSERT INTO users (username,password_hash,role) VALUES ('useruser1', '$2a$10$hsT5LuA.um/H2ZBR4ghlk.VOhSwDBT9hJbmRBjkWRY7gwbZzc6ILa','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('useruser2','$2a$10$Y.rBo.jfOFZjp8Zz4Ee9GO3dXXhsg5H/f2IoovgG7RithsNTGA5Fa','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('useruser3','$2a$10$x6g5TMbsOUemXMQ081.kJu18TBz6dfOA5yhI4TRI2tEjDhrsnTDj6','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('useruser4','$2a$10$413Hc.XI1nSsCboSw4F4GOGuxtH1zxxHaKoIMPq9oeoZ3xJCYhIau','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('useruser5','$2a$10$z/a1Eiz4NaHG7jMpXom2/OiNzonPzKJ75K0DxGqecCQUrCU4aks5S','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('useruser6','$2a$10$/HL6uK7jvhG2dZFX.AprEOfEep10MnYVJV4xZV6FLnGDM03L4lKfa','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('useruser7','$2a$10$md1WskSfhowCSzWFZoF98uTS1srboESTVDGvhEciSbB8KwyoiOOmu','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('useruser8','$2a$10$j36nCVabXLzPaQQui6iqOeMeNndjAZcz5UIZARpzEWi4fU5UoDCQK','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('useruser9','$2a$10$Z.LweTLrqx0g741CNYUbiOXyVjD9hBzybFwn0g7sY5K6/XF3VjEOW','ROLE_USER');
--ROLE_TEACHER==10-15
INSERT INTO users (username,password_hash,role) VALUES ('useruser10','$2a$10$dxbaN0byAX1twFEkijan5eE2PrMlmjBtP9aoosqZhhZP/wF12sXL2','ROLE_TEACHER');
INSERT INTO users (username,password_hash,role) VALUES ('useruser11','$2a$10$KkCz/Y2RMgOL5lnENkwye.nRQTWl1u6edks4JAKi2e7w2rod/kaqq','ROLE_TEACHER');
INSERT INTO users (username,password_hash,role) VALUES ('useruser12','$2a$10$0Jt1BjIWN/VNembTywzm.u2hfOEuWdAsdjkwSectyno75M5V/4Hoq','ROLE_TEACHER');
INSERT INTO users (username,password_hash,role) VALUES ('useruser13','$2a$10$HLP9NYwDVhU02KcDk0sddO9Nj/HdoV3kDo4GaVIZAYgqpQmLqH0n6','ROLE_TEACHER');
INSERT INTO users (username,password_hash,role) VALUES ('useruser14','$2a$10$0ZToUV0k9C3Ke.KXbEbeFeCx82Bi9FiHH0tGsAjp1M5OvwDIlzOWe','ROLE_TEACHER');
INSERT INTO users (username,password_hash,role) VALUES ('useruser15','$2a$10$wQJkLZ4iC2jYWCOM/AikIuVrzbd7xfvXiE7rXFjI3D86IlODFTfXy','ROLE_TEACHER');
--ROLE_USER==16-19
INSERT INTO users (username,password_hash,role) VALUES ('useruser16','$2a$10$MI7QwCluywUjp3V9TX4w6Op.LdIrkdE/5KRa2jLVaftka.wrPDwkO','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('useruser17','$2a$10$HoXX7UIQ6SgRK/ialUGdkegnUfXmNcjQTJKnVHYcBpHf/y5qrrwTS','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('useruser18','$2a$10$BV3XE6FxHsKnV0L3r4l9UuK3h4v7NBMCBRYLJPeYOeU7lFwFcpGvq','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('useruser19','$2a$10$r51.KwmZwQppY8S.g3jTVejcp4AQPfpmarwuUEziR2sWM/gJtOtnO','ROLE_USER');

INSERT INTO course (name,description,class_size,cost) VALUES ('Math 241','Explore the mysterious world of addition and subtraction', 15, 400);
--teachers: useruser10, useruser11, teacher
--students: UU1,UU3,UU4,UU6,UU8,UU17, user , student
INSERT INTO teacher (teacher, course) VALUES 
((SELECT user_id FROM users WHERE username='teacher'), (SELECT id FROM course WHERE name = 'Math 241')),
((SELECT user_id FROM users WHERE username='useruser10'), (SELECT id FROM course WHERE name = 'Math 241')),
((SELECT user_id FROM users WHERE username='useruser11'), (SELECT id FROM course WHERE name = 'Math 241')); 
INSERT INTO student (student, course) VALUES 
((SELECT user_id FROM users WHERE username='useruser1') , (SELECT id FROM course WHERE name = 'Math 241')) , ((SELECT user_id FROM users WHERE username='useruser6' ), (SELECT id FROM course WHERE name = 'Math 241')),
((SELECT user_id FROM users WHERE username='useruser3') , (SELECT id FROM course WHERE name = 'Math 241')) , ((SELECT user_id FROM users WHERE username='useruser8' ), (SELECT id FROM course WHERE name = 'Math 241')), 
((SELECT user_id FROM users WHERE username='user') , (SELECT id FROM course WHERE name = 'Math 241'))      , ((SELECT user_id FROM users WHERE username='student') , (SELECT id FROM course WHERE name = 'Math 241')) ,
((SELECT user_id FROM users WHERE username='useruser4') , (SELECT id FROM course WHERE name = 'Math 241')) , ((SELECT user_id FROM users WHERE username='useruser17'), (SELECT id FROM course WHERE name = 'Math 241')); 

INSERT INTO course (name,description,class_size,cost) VALUES ('Relational Databases','Scientists have recently conducted research indicating that relational databases may lead to prolonged bouts of brain fog. What does this tell us about the heretofore unquestioned hegemony of data-driven table design?', 5, 1000);
--teachers: useruser14 
--students: student,UU4,UU7,UU9,UU18 (exactly the class limit)
INSERT INTO teacher (teacher, course) VALUES 
((SELECT user_id FROM users WHERE username='useruser14') ,(SELECT id FROM course WHERE name = 'Relational Databases'));
INSERT INTO student (student, course) VALUES 
((SELECT user_id FROM users WHERE username='student' ), (SELECT id FROM course WHERE name = 'Relational Databases')) , ((SELECT user_id FROM users WHERE username='useruser9' ), (SELECT id FROM course WHERE name = 'Relational Databases')),
((SELECT user_id FROM users WHERE username='useruser4' ), (SELECT id FROM course WHERE name = 'Relational Databases')) , ((SELECT user_id FROM users WHERE username='useruser18'), (SELECT id FROM course WHERE name = 'Relational Databases')), 
((SELECT user_id FROM users WHERE username='useruser7' ), (SELECT id FROM course WHERE name = 'Relational Databases')) ;


INSERT INTO course (name,description,class_size,cost) VALUES ('Sea as in Cnidarian: Spelling 101','Is it possible to get better at scrabble? Most likely, no, but it is still a fun game!', 5, 600);
--teachers: useruser15, useruser10 
--students: UU1,UU8,UU9,UU17, student
INSERT INTO teacher (teacher, course) VALUES 
((SELECT user_id FROM users WHERE username='useruser15'), (SELECT id FROM course WHERE name = 'Sea as in Cnidarian: Spelling 101')),
((SELECT user_id FROM users WHERE username='useruser10'), (SELECT id FROM course WHERE name = 'Sea as in Cnidarian: Spelling 101')); 
INSERT INTO student (student, course) VALUES 
((SELECT user_id FROM users WHERE username='useruser1') , (SELECT id FROM course WHERE name = 'Sea as in Cnidarian: Spelling 101')),((SELECT user_id FROM users WHERE username='useruser9' ),(SELECT id FROM course WHERE name = 'Sea as in Cnidarian: Spelling 101')),
((SELECT user_id FROM users WHERE username='student') , (SELECT id FROM course WHERE name = 'Sea as in Cnidarian: Spelling 101')),
((SELECT user_id FROM users WHERE username='useruser8') , (SELECT id FROM course WHERE name = 'Sea as in Cnidarian: Spelling 101')),((SELECT user_id FROM users WHERE username='useruser17'),(SELECT id FROM course WHERE name = 'Sea as in Cnidarian: Spelling 101')); 

INSERT INTO course (name,description,class_size,cost) VALUES ('Object Oriented Programming','You may have heard OOP is easy as P.I.E.! Well... that is not true.', 20, 750);
--teachers: useruser13 , teacher
--students: UU1,UU3,UU4,UU6, user, student
INSERT INTO teacher (teacher, course) VALUES 
((SELECT user_id FROM users WHERE username='useruser13'), (SELECT id FROM course WHERE name = 'Object Oriented Programming')),
((SELECT user_id FROM users WHERE username='teacher'), (SELECT id FROM course WHERE name = 'Object Oriented Programming'));
INSERT INTO student (student, course) VALUES 
((SELECT user_id FROM users WHERE username='useruser1') , (SELECT id FROM course WHERE name = 'Object Oriented Programming')), ((SELECT user_id FROM users WHERE username='useruser4'),( SELECT id FROM course WHERE name = 'Object Oriented Programming')),
((SELECT user_id FROM users WHERE username='student') , (SELECT id FROM course WHERE name = 'Object Oriented Programming')), ((SELECT user_id FROM users WHERE username='user'),( SELECT id FROM course WHERE name = 'Object Oriented Programming')),
((SELECT user_id FROM users WHERE username='useruser3') , (SELECT id FROM course WHERE name = 'Object Oriented Programming')), ((SELECT user_id FROM users WHERE username='useruser6'), ( SELECT id FROM course WHERE name = 'Object Oriented Programming')); 


INSERT INTO course (name,description,class_size,cost) VALUES ('Ancient Roman Literature: Catullus','The irreverent poet Catullus wrote in a style that remains modern even into today!', 25, 2000);
--teachers: useruser13, teacher 
--students: UU1,UU3,UU4,UU6,UU18,UU19
INSERT INTO teacher (teacher, course) VALUES 
((SELECT user_id FROM users WHERE username='teacher'),(SELECT id FROM course WHERE name = 'Ancient Roman Literature: Catullus')),
((SELECT user_id FROM users WHERE username='useruser10'),(SELECT id FROM course WHERE name = 'Ancient Roman Literature: Catullus')); 
INSERT INTO student (student, course) VALUES 
((SELECT user_id FROM users WHERE username='useruser1'), (SELECT id FROM course WHERE name = 'Ancient Roman Literature: Catullus')) , ((SELECT user_id FROM users WHERE username='useruser6' ) , (SELECT id FROM course WHERE name = 'Ancient Roman Literature: Catullus')),
((SELECT user_id FROM users WHERE username='useruser3'), (SELECT id FROM course WHERE name = 'Ancient Roman Literature: Catullus')) , ((SELECT user_id FROM users WHERE username='useruser18') , (SELECT id FROM course WHERE name = 'Ancient Roman Literature: Catullus')), 
((SELECT user_id FROM users WHERE username='useruser4'), (SELECT id FROM course WHERE name = 'Ancient Roman Literature: Catullus')) , ((SELECT user_id FROM users WHERE username='useruser19') , (SELECT id FROM course WHERE name = 'Ancient Roman Literature: Catullus'));

INSERT INTO curriculum (course, date, lesson) VALUES
((SELECT id FROM course WHERE (name='Ancient Roman Literature: Catullus')), '12-21-2020', 
'Gaius Valerius Catullus : Very little is objectively known of the life of Gaius Valerius Catullus. It is believed that he was born in Verona in 84 B.C. to a wealthy and well-connected family. His father was a friend of Julius Caesar. He died in Rome in 54 B.C. at the age of thirty. From his poems it is known that he went to Bithynia as an aide to the governor of that province in 57-56 B.C. We also know from Cicero that Catullus was one of the "neoteric" or new poets. Whereas the majority of poets in Rome at that time produced epic poems, often commissioned by aristocratic families, Catullus and other neoteric rejected the epic and its public themes. The neoteric poets used colloquial language to write about personal experience. Their poems are mostly smaller lyrics that are characterized by wit and erudition. Aside from these facts, what is known of the life of Catullus comes from the thoughts expressed in his poems.
The knowledge of Catullus poems comes from a single manuscript that survived the Dark Ages. This manuscript was discovered in Verona in around 1305 and disappeared again at the end of the century. Two copies of it, however, were made and one survives in the Bodleian Library in Oxford. The other copy, which was believed to be owned by Petrarch, was also lost. The surviving copy contains 116 poems in three sections: sixty shorter poems written mostly in Greek lyric meters, primarily hendecasyllabic or eleven-syllable lines; eight long poems; and a set of short epigrams.
The shorter poems are often extremely playful and personal. Catullus speaks directly to his friends in a casual voice. For instance, the dedication poem begins with the lines "To whom am I giving my charming, new, little book / polished just now with the dry pumice stone? / Cornelius, to you: for you were the one / who thought this rubbish was something . . ." The short lyrics are often funny, and on occasion extremely crude. He also used these poems to explore the limits of friendship and love. He wrote twenty-five poems to a woman he named Lesbia, offering both erotic banter as well as heartbreak at her infidelity and their eventual breakup. English poets such as Ben Jonson and Christopher Marlowe wrote imitations of these poems, particularly poem five, which begins "Let us live, my Lesbia, and let us love."
The longer poems deal with many of the same concerns. They also chronicle the death of his brother at Troy and Catullus visit to his grave. In this poem, Catullus speaks frankly of loss and the inability to express such a loss. Many people consider it to be one of the finest elegies ever written. The remaining group of poems consists of short epigrams that offer satiric observations on the life in Rome. Although nearly lost, Catullus poems had a profound impact on later poets. This influence can be seen not only in Latin love poets such as Horace or Ovid, but also in English Renaissance poets such as Robert Herrick. John Milton spoke Catullus "Satyirical sharpness, or naked plainness." Catullus has also been praised as a lyricist by twentieth century poets, and translated by writers as diverse as Thomas Campion, William Wordsworth, and Louis Zukofsky.');

INSERT INTO curriculum (course, date, lesson) VALUES
((SELECT id FROM course WHERE (name='Ancient Roman Literature: Catullus')), '12-22-2020', 
'Intellectual influences
Lesbia, 1878 painting by John Reinhard Weguelin inspired by the poems of Catullus
Catulluss poetry was influenced by the innovative poetry of the Hellenistic Age, and especially by Callimachus and the Alexandrian school, which had propagated a new style of poetry that deliberately turned away from the classical epic poetry in the tradition of Homer. Cicero called these local innovators neoteroi (????????) or "moderns" (in Latin poetae novi or "new poets"), in that they cast off the heroic model handed down from Ennius in order to strike new ground and ring a contemporary note. Catullus and Callimachus did not describe the feats of ancient heroes and gods (except perhaps in re-evaluating and predominantly artistic circumstances, e.g. poems 63 and 64), focusing instead on small-scale personal themes. Although these poems sometimes seem quite superficial and their subjects often are mere everyday concerns, they are accomplished works of art. Catullus described his work as expolitum, or polished, to show that the language he used was very carefully and artistically composed.
Catullus was also an admirer of Sappho, a female poet of the seventh century BC. Catullus 51 partly translates, partly imitates and transforms Sappho 31. Some hypothesize that 61 and 62 were perhaps inspired by lost works of Sappho but this is purely speculative. Both of the latter are epithalamia, a form of laudatory or erotic wedding-poetry that Sappho was famous for. Catullus twice used a meter that Sappho developed, called the Sapphic strophe, in poems 11 and 51, perhaps prompting his successor Horaces interest in the form.
Catullus, as was common to his era, was greatly influenced by stories from Greek and Roman myth. His longer poems—such as 63, 64, 65, 66, and 68—allude to mythology in various ways. Some stories he refers to are the wedding of Peleus and Thetis, the departure of the Argonauts, Theseus and the Minotaur, Ariadnes abandonment, Tereus and Procne, as well as Protesilaus and Laodamia.
Style
Catullus wrote in many different meters including hendecasyllabic verse and elegiac couplets (common in love poetry). A great part of his poetry shows strong and occasionally wild emotions, especially in regard to Lesbia. His love poems are very emotional and ardent, and we can relate to them even today. Catullus describes his Lesbia as having multiple suitors and often showing little affection towards him. He also demonstrates a great sense of humour such as in Catullus 13.');
INSERT INTO curriculum (course, date, lesson) VALUES
((SELECT id FROM course WHERE (name='Ancient Roman Literature: Catullus')), '12-24-2020', 
'Catullus as Poet. 
It is not often that so great a poet as Catullus has risked extinction, 
and been preserved almost by miracle. All our MSS are derived from 
a single imperfect copy discovered, we do not know where, at the begin- 
ing of the xivth century : no complete poem, with the exception of LXII 
which is included in the Thuanean Anthology of the Paris Library, 
and the quatrain to Priapus cited by Terentianus Maurus 2755-2758 
Lachm., has come down to us in any other collection. Yet only the 
loss of Alcaeus and Sappho in Greek literature could compare with the 
loss of the lyrics of Catullus ; and we may estimate the barbarism which 
followed the decline of the Roman empire by nothing more signally 
than the absence of even one copy of the two Greek poets, and the 
almost casual preservation of the Veronese in a single mutilated MS, the 
parent of all our extant MSS. During the long period which elapsed 
between Isidorus of Hispalis and lulianus of Toletum^ in the seventh 
century and the re-discovery of the poems at the beginning of the four- 
teenth, only one writer is known to have read Catullus, Rather, bishop of 
Verona circ. 930-970 : though LXII may have been copied into the 
Thuanean Anthology from a complete MS of the poems, and traces of 
possible imitation, as well as glossarial extracts, are not wanting, as I have 
shown in my former volume. Prolegomena pp. viii, ix, Cf. Schwabe ed. 
1886, pp. xiii-xiv. These may be and, in the existing ardour for 
mediaeval study, are perhaps likely to be supplemented by new dis- 

* luliani Art. ed. Lorenzana, Romae 1 797, p. 63 Da propriae qualitatis nomen. Sol : 
et quia dicit soles ire et redire possunt, pro diebus hoc dicit. Excerpta cod. Bern. 207 
ap. Hageni Anecdot. Heluetica p. ccxx Quomodo dicis solem propriae qualitatis esse 
cum dicatur : Soles ire et redire possunt. Pro diebus hoc dictum est. 

* G. Amsel Rhein. Mus. for 1888, p. 309, quotes from Notker, a monk of St. Gallen 
(died 1022), the following passage from Notkers translation of Boetius de Consol. iii. 4. 
Unde Catullus nonium licet sedentem in curuli tamen strumam appellat. Fone diu 
uuard taz Catullus nonium gutter hiez. doh er an demo herstuole saze. Catullus uuas 
ueronensis poeta. nobilis pe diu uuas imo nonius unuuerd. ter fone gallia ze Roma 
chomenSr. mit gothorum suffragio ze consulatu gesteig. Thus translated by Prof. 
Napier. From that ( = thence) it was that Catullus called ^^ovivis, gutter i}. guttur=ba 



XX PROLEGOMENA. 

coveries : still it remains true that Catullus was for a long time an almost 
unknown book: a singular fate if we think of the popularity which greeted 
him almost from the first amongst his countrymen. He himself tells us 
that his early attempts had been countenanced by Cornelius Nepos ; 
Cicero, who nowhere mentions him by name, seems to have borrowed 
two of his expressions (ad Q. Fr. ii. 15. 4, Att. xvi. 6. 2 auricula infima 
tnolliorem, ocellos Italiae) ; the parallelisms between him and Lucretius 
cannot be shown to spring from our poets imitation of the latter, and 
may with equal probability be ascribed to Lucretius knowledge of Catullus : 
he is classed with Lucretius by Corn. Nepos as representing the literary 
epoch which preceded the rise of Vergil (Att. xii) ; J. Caesar considered 
his attack upon himself (probably XXIX) to have branded him for all 
time (Suet. lul. 73); and his general popularity is attested not only by the 
undisguised imitations of the greatest poets who followed him, Vergil, 
Horace, Propertius^, Statins. Juvenal, above all Martial, or the various 
parodies of him found in the Catalepta ^ Priapea ^ or elsewhere, but even 
more in the sneer of Horace that he and his friend Calvus were sung to 
the exclusion of every other poet by the fashionable singer of the day 
(S. i. 10. 19). Horaces sneer no doubt expresses the position of the 
Augustan poets to Catullus ; they belonged to an epoch which, greatly 
as it was influenced by the era which preceded it, was in the main ant- 
agonistic to its chief representatives, and this for literary no less than 
political reasons. On the one hand the son and successor of J. Caesar 
could not forget that Catullus had aimed his bitterest shafts at his prede- 
cessor and adoptive father ; on the other the Augustan poets, aiming as 

struma) although he sat on the honour seat. Catullus was Veronensis poeta nobilis : 
therefore Nonius was disliked by him. He having come from Gallia to Rome rose 
to the consulship by the suffragio Gothorum. It is noticeable that the three words 
Veronensis poeta nobilis are also found in a twelfth century MS Commentary on this 
passage of Boetius (Digby MSS 174, p. 85) Catulus poeta nobilis ueronensis nonium 
dignitatem consularem deturpantem in presentia populi strumam despectiue appellauit 
siue quod gibosus esset sine quod sicut gibbus dorsum totumque hominem ita ille 
dignitatem turpiter uiuendo deturparet. The same MS, in the glosses which 
accompany the text of the de Co. solatione, gives the following, p. 33. Catullus 
indignatus est de nonio, et quia indignatus est non appellauit eum consulari nomine .s. 
nonium sed strumam. Possibly there was an early collection of short glosses on the 
de Consolatione, which was worked up and amplified in the course of the Middle Age. 

The parallels in Tibullus are mainly in Book III which since Lachmann is usually 
ascribed to Lygdamus. Haupt cites Lygd. 6. 27, 28 ; 39-42 ; 50 : add 4. 85-96 which 
is a direct imitation of Cat. LXIV. 153-156, LXVIII. 159, XXX. 10. 

* Cat. iii. 5, 6 F^ ille uersus usquequaque pertinet, Gener socerque, perdidistis 
omnia, viii Sabinus ille, quern uidetis, hospites, a parody of the Phasellus ille. xiii. 
II Quare illud satis est si te permittis amari, cf. CatuU. LXVIII. 147. 

Priap. 52. 12, 61. 13, 64. I, 69. 4. The author of the epyllion Ciris is full of 
direct imitations of Catullus. 



PROLEGOMENA. xxi 

they did at the suppression of the older and ruder literature of Rome, 
either consciously ignored the great poets of the immediately preceding 
era, as in the well-known assertion of Horace that he was the first who 
had shown the iambi of Paros to Latium, or silently disparaged them as 
having their own aim, but not attaining it adequately. But Horace whose 
satires drove Lucilius out of the field, did not supplant the lyrics of 
Catullus by his odes and epodes ; the allusions scattered through the 
writings of the post-Augustan and subsequent periods, though they cannot 
be called numerous, are enough to show that Catullus remained a 
familiar book to the Romans, that he was read and read through \ Thus 
references to the poems on the Sparrow are found in Seneca, Juvenal^ and 
Martial ^ ; the elder Pliny quotes some words from the dedicatory hende- 
casyllables to Cornelius Nepos in the first sentence of his Natural History, 
and takes pride in calling the poet his countryman {conterraneum) ; the 
elder Seneca corrects our MSS of LHI. 5, which he cites as in hendeca- 
syllabis, Controu. vii. 7 ; Quintilian, who only once cites Tibullus, once 
Propertius, has seven references to Catullus ^ ; the younger Pliny was a 
diligent student (iv. 14. 5, 27. 4), as well as an accurate critic, at least of 
the hendecasyllables (i. 16. 5); A. Gellius discusses at length two 
passages of Catullus (VII. 16, VI. 20) and indirectly proves how much 
he was read by the variety of readings which he found in the MSS then 
in circulation ; Hyginus P. A. ii. 24 explains, perhaps wrongly, the word 
7nagnanima?n in the Coma Berenices ; and extracts from Catullus are 
found in Apuleius*, Porphyrion® the Horatian scholiast, Censorinus "^j 
Nonius Marcellus '', Ausonius ^ Servius ^ the commentator on Vergil, 
Macrobius ^^ Apollinaris Sidonius ", Martianus Capella ^^ the Christian 
writers Hieronymus and Augustine, and the Grammarians^*. Whether 
commentaries were written upon him, as upon Cinnas Zmyrna, we do 
not know ; Haupt argued from a passage of Charisius i. p. 97 Keil that 
Asinius PoUio wrote on the diction of Catullus ; but the interpretation is 
doubtful.');

INSERT INTO curriculum (course, date, lesson) VALUES
((SELECT id FROM course WHERE (name='Object Oriented Programming')), '12-23-2020', 
'<!DOCTYPE html>
  <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" x="0px" y="0px" viewBox="0 0 100 100" width="15" height="15" class="icon outbound"><path fill="currentColor" d="M18.8,85.1h56l0,0c2.2,0,4-1.8,4-4v-32h-8v28h-48v-48h28v-8h-32l0,0c-2.2,0-4,1.8-4,4v56C14.8,83.3,16.6,85.1,18.8,85.1z"></path> <polygon fill="currentColor" points="45.7,48.7 51.3,54.3 77.2,28.5 77.2,37.2 85.2,37.2 85.2,14.9 62.8,14.9 62.8,22.9 71.5,22.9"></polygon></svg></a></div> <!----></nav>  <ul class="sidebar-links"><li><a href="https://book.techelevator.com/" class="sidebar-link">Introduction</a></li><li><section class="sidebar-group collapsable depth-0"><p class="sidebar-heading open"><span>Module 1</span> <span class="arrow down"></span></p> <ul class="sidebar-links sidebar-group-items" style=""><li><a href="https://book.techelevator.com/content/introduction-to-tools.html" class="sidebar-link">Introduction to Tools</a></li><li><a href="https://book.techelevator.com/content/introduction-to-programming-ool.html" class="active sidebar-link">Introduction to Programming</a><ul class="sidebar-sub-headers"><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/introduction-to-programming-ool.html#variables" class="active sidebar-link">Variables</a></li><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/introduction-to-programming-ool.html#data-types" class="sidebar-link">Data types</a><ul class="sidebar-sub-headers"><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/introduction-to-programming-ool.html#common-data-types" class="sidebar-link">Common data types</a></li><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/introduction-to-programming-ool.html#declaring-a-variable" class="sidebar-link">Declaring a variable</a></li><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/introduction-to-programming-ool.html#naming-variables" class="sidebar-link">Naming variables</a></li><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/introduction-to-programming-ool.html#giving-values-to-variables" class="sidebar-link">Giving values to variables</a></li><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/introduction-to-programming-ool.html#constants" class="sidebar-link">Constants</a></li></ul></li><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/introduction-to-programming-ool.html#expressions" class="sidebar-link">Expressions</a><ul class="sidebar-sub-headers"><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/introduction-to-programming-ool.html#arithmetic-expressions" class="sidebar-link">Arithmetic expressions</a></li></ul></li><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/introduction-to-programming-ool.html#type-conversion" class="sidebar-link">Type conversion</a><ul class="sidebar-sub-headers"><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/introduction-to-programming-ool.html#literal-suffixes" class="sidebar-link">Literal suffixes</a></li></ul></li></ul></li><li><a href="https://book.techelevator.com/content/logical-branching-ool.html" class="sidebar-link">Logical Branching</a></li><li><a href="https://book.techelevator.com/content/arrays-and-loops-ool.html" class="sidebar-link">Arrays and Loops</a></li><li><a href="https://book.techelevator.com/content/command-line-programs.html" class="sidebar-link">Building Command Line Programs</a></li><li><a href="https://book.techelevator.com/content/introduction-to-objects-ool.html" class="sidebar-link">Introduction to Objects</a></li><li><a href="https://book.techelevator.com/content/linear-data-structures-ool.html" class="sidebar-link">Collections: Part 1</a></li><li><a href="https://book.techelevator.com/content/non-linear-data-structures-ool.html" class="sidebar-link">Collections: Part 2</a></li><li><a href="https://book.techelevator.com/content/classes-encapsulation-ool.html" class="sidebar-link">Classes and Encapsulation</a></li><li><a href="https://book.techelevator.com/content/inheritance-ool.html" class="sidebar-link">Inheritance</a></li><li><a href="https://book.techelevator.com/content/polymorphism-ool.html" class="sidebar-link">Polymorphism</a></li><li><a href="https://book.techelevator.com/content/unit-testing-ool.html" class="sidebar-link">Unit Testing</a></li><li><a href="https://book.techelevator.com/content/file-io-ool.html" class="sidebar-link">File I/O</a></li><li><a href="https://book.techelevator.com/content/exception-handling-ool.html" class="sidebar-link">Error Handling</a></li></ul></section></li><li><section class="sidebar-group collapsable depth-0"><p class="sidebar-heading"><span>Module 2</span> <span class="arrow right"></span></p> <!----></section></li><li><section class="sidebar-group collapsable depth-0"><p class="sidebar-heading"><span>Module 3</span> <span class="arrow right"></span></p> <!----></section></li><li><section class="sidebar-group collapsable depth-0"><p class="sidebar-heading"><span>After the Cohort</span> <span class="arrow right"></span></p> <!----></section></li></ul> </aside> <main class="page"> <div class="theme-default-content content__default"><h1 id="an-introduction-to-variables-data-types"><a href="https://book.techelevator.com/content/introduction-to-programming-ool.html#an-introduction-to-variables-data-types" class="header-anchor">#</a> An Introduction to Variables &amp; Data Types</h1> <p>By the end of this chapter, you should understand:</p> 
  <ul><li>How variables are declared and used in code</li> <li>How arithmetic expressions are evaluated in code</li> <li>How data types can be converted</li></ul> <h2 id="variables"><a href="https://book.techelevator.com/content/introduction-to-programming-ool.html#variables" class="header-anchor">#</a> Variables</h2> <p>Typical programs like web applications need to store and manipulate data. For example, many websites can send a password reset e-mail. Programmers try to write these applications with as little repetitive code as possible.</p> <p>For example, building a password reset flow for every single user is time consuming. So, to save time, programmers use variables to store the users email address. This allows them to write their code in a generic and reusable manner.</p> <p>This next section addresses three characteristics of variables:</p> <ul><li>A variable must identify what type of data it stores</li> <li>A variable must be declared before it is used</li> <li>A variable must be given a unique name when it is declared</li></ul> <h2 id="data-types"><a href="https://book.techelevator.com/content/introduction-to-programming-ool.html#data-types" class="header-anchor">#</a> Data types</h2> <p>Every variable, when created, is defined with a data type. A data type classifies the variable and indicates the type of data that a particular variable holds.</p> <p>In Java and C#, there are two classifications of data types: primitive (Java) / value (C#) data types and reference data types. A primitive data type stores a simple value like <code>42</code>, <code>true</code>, or <code>a</code>, that consumes a fixed amount of memory. A reference type allows complex, unknown structures of data to be created by the program.</p> <h3 id="common-data-types"><a href="https://book.techelevator.com/content/introduction-to-programming-ool.html#common-data-types" class="header-anchor">#</a> Common data types</h3> <table><thead><tr><th>C#</th> <th>Range</th> <th></th> <th>Java</th> <th>Range</th></tr></thead> <tbody><tr><td><code>bool</code></td> <td>true or false</td> <td></td> <td><code>boolean</code></td> <td>true or false</td></tr> <tr><td><code>byte</code></td> <td>0 to 255</td> <td></td> <td><code>byte</code></td> <td>-127 to 127</td></tr> <tr><td><code>char</code></td> <td>U+0000 to U+FFFF ("a", "b", etc.)</td> <td></td> <td><code>char</code></td> <td>\u000 to \uffff ("a", "b", etc.)</td></tr> <tr><td><code>int</code></td> <td>-2^31 to 2^31</td> <td></td> <td><code>int</code></td> <td>-2^31 to 2^31</td></tr> <tr><td><code>float</code></td> <td>-3.4×10^38 to 3.4×10^38</td> <td></td> <td><code>float</code></td> <td>-3.4<em>10^38 to 3.4</em>10^38</td></tr> <tr><td><code>double</code></td> <td>±5.0 × 10^?324 to ±1.7 × 10^308</td> <td></td> <td><code>double</code></td> <td>±5.0 × 10^?324 to ±1.7 × 10^308</td></tr> <tr><td><code>long</code></td> <td>-2^63 to 2^63</td> <td></td> <td><code>long</code></td> <td>-2^63 to 2^63</td></tr> <tr><td><code>decimal</code></td> <td>(-7.9×10^28 to 7.9×1028) / (10^0 to 10^28)</td> <td></td> <td></td> <td></td></tr></tbody></table> <p>Many of these data types deal with similar types of data, such as integer, boolean, and floating point. Their difference is in the ranges of values they hold. For example:</p> <ul><li><code>int</code> and <code>long</code> both deal with integers, but <code>long</code> can hold significantly larger numbers</li> <li><code>float</code> and <code>double</code> both store decimal points, but <code>double</code> offers higher precision</li></ul> <div class="custom-block tip"><p class="custom-block-title">Strings</p> <p><code>string</code> isnt considered a primitive type. Its considered a reference type.</p></div> <p>For a reference of all C# value types, view the <a href="https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/value-types" target="_blank" rel="noopener noreferrer">MSDN documentation<svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" x="0px" y="0px" viewBox="0 0 100 100" width="15" height="15" class="icon outbound"><path fill="currentColor" d="M18.8,85.1h56l0,0c2.2,0,4-1.8,4-4v-32h-8v28h-48v-48h28v-8h-32l0,0c-2.2,0-4,1.8-4,4v56C14.8,83.3,16.6,85.1,18.8,85.1z"></path> <polygon fill="currentColor" points="45.7,48.7 51.3,54.3 77.2,28.5 77.2,37.2 85.2,37.2 85.2,14.9 62.8,14.9 62.8,22.9 71.5,22.9"></polygon></svg></a>.</p> <p>For a reference of all Java primitive types, view the <a href="https://docs.oracle.com/javase/tutorial/java/nutsandbolts/datatypes.html" target="_blank" rel="noopener noreferrer">Java Docs<svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" x="0px" y="0px" viewBox="0 0 100 100" width="15" height="15" class="icon outbound"><path fill="currentColor" d="M18.8,85.1h56l0,0c2.2,0,4-1.8,4-4v-32h-8v28h-48v-48h28v-8h-32l0,0c-2.2,0-4,1.8-4,4v56C14.8,83.3,16.6,85.1,18.8,85.1z"></path> <polygon fill="currentColor" points="45.7,48.7 51.3,54.3 77.2,28.5 77.2,37.2 85.2,37.2 85.2,14.9 62.8,14.9 62.8,22.9 71.5,22.9"></polygon></svg></a>.</p> <h3 id="declaring-a-variable"><a href="https://book.techelevator.com/content/introduction-to-programming-ool.html#declaring-a-variable" class="header-anchor">#</a> Declaring a variable</h3> <p>Before using a variable, you must declare it first. The declaration statement for a variable looks like:</p> <div class="language- extra-class"><pre class="language-text"><code>data-type identifier;
</code></pre></div><p><strong>Example:</strong></p> <div class="language- extra-class"><pre class="language-text"><code>int numberOfPeople;             //declare an integer called numberOfPeople
double gallonsOfGas;            //declare a double called gallonsOfGas
bool isRaining;                 //declare a bool(ean) called isRaining
char firstLetter;               //declare a char called firstLetter
</code></pre></div><p>Once a variable has been declared within a given scope, it cant be redeclared. The following code creates a compilation error:</p> <div class="language- extra-class"><pre class="language-text"><code>{
    int numberOfPeople;     //legal

    //...

    int numberOfPeople;     //numberOfPeople is already in scope and cant be declared again
}
</code></pre></div><h3 id="naming-variables"><a href="https://book.techelevator.com/content/introduction-to-programming-ool.html#naming-variables" class="header-anchor">#</a> Naming variables</h3> <blockquote><p>The Golden Rule of Programming:</p> <p><em>Always give your variables meaningful names.</em></p></blockquote> <p>Code that has complex variable names or confusing abbreviations isnt well-received in the developer community. Keeping your variable names consistent and easy to understand benefits your colleagues <em>and</em> yourself. Theres a chance you wont remember what you meant while fixing an error in production on a codebase you worked on over a year ago.</p> <p>While variable naming is an art, when it comes to creating names, there are some best practices:</p> <ul><li>Follow camel-casing conventions: the first word is lowercase, and subsequent words have the first letter capitalized</li> <li>Use pronounceable names for variables</li> <li>Use names over single characters</li> <li>Avoid creating multiple variables that are variations of the same name, as this creates confusion</li> <li>Use names that describe WHAT the variable does, not HOW it does it</li> <li>With booleans, use names that start with is, has, was, and so on; avoid using a double negative</li></ul> <p><strong>Good Variable Names</strong></p> <ul><li><code>numberOfStudents</code> for an int</li> <li><code>averageCostOfGas</code> for a double</li> <li><code>isAvailable</code> for a boolean</li></ul> <p><strong>Not Good Variable Names</strong></p> <ul><li><code>nbr</code></li> <li><code>name</code> followed by <code>name2</code>, <code>name3</code>, etc.</li> <li><code>numberOfStudents</code> followed by <code>number_of_students_</code></li></ul> <h3 id="giving-values-to-variables"><a href="https://book.techelevator.com/content/introduction-to-programming-ool.html#giving-values-to-variables" class="header-anchor">#</a> Giving values to variables</h3> <p>After youve declared a variable, you can assign it a value. Variables can be assigned three different types of values:</p> <ul><li>Literal values, like <code>42</code>, <code>true</code>, or <code>a</code>, depending on the data type</li> <li>Variable values where the value of one variable is given to the value of another variable</li> <li>Evaluated values from an <em>expression</em></li></ul> <p>The assignment operator <code>=</code> is used when giving a value in an assignment statement.</p> <div class="language-csharp extra-class"><pre class="language-csharp"><code><span class="token keyword">int</span> numberOfPeople<span class="token punctuation">;</span>             <span class="token comment">//declare an integer called numberOfPeople</span>
<span class="token keyword">double</span> gallonsOfGas<span class="token punctuation">;</span>            <span class="token comment">//declare a double called gallonsOfGas</span>
<span class="token keyword">bool</span> isRaining<span class="token punctuation">;</span>                 <span class="token comment">//declare a bool(ean) called isRaining</span>
<span class="token keyword">bool</span> isCloudy<span class="token punctuation">;</span>


numberOfPeople <span class="token operator">=</span> <span class="token number">16</span><span class="token punctuation">;</span>            <span class="token comment">//assign the integer 16 to the numberOfPeople variable</span>
gallonsOfGas <span class="token operator">=</span> <span class="token number">3.26</span><span class="token punctuation">;</span>            <span class="token comment">//assign the double 3.26 to the gallonsOfGas variable</span>
isRaining <span class="token operator">=</span> <span class="token keyword">true</span><span class="token punctuation">;</span>               <span class="token comment">//assign the boolean true to the isRaining variable</span>
firstLetter <span class="token operator">=</span> <span class="token string">"a"</span><span class="token punctuation">;</span>              <span class="token comment">//assign the character "a" to the firstLetter variable</span>

isCloudy <span class="token operator">=</span> isRaining<span class="token punctuation">;</span>           <span class="token comment">//copy the value from isRaining into the isCloudy variable</span>
</code></pre></div><p>If the variable appears on the right-hand side of the operator, then its value is retrieved and copied into another variable.</p> <div class="custom-block tip"><p class="custom-block-title">Reading Code</p> <p>When reading code, it might help to read the right-hand side of the assignment statement first. Once youve determined what value will be used, use the <code>=</code> to indicate you are assigning a value to the variable on the left-hand side.</p></div> <p>You may often see variables declared <em>and</em> assigned within the same line of code.</p> <div class="language- extra-class"><pre class="language-text"><code>int numberOfPeople = 16;
double gallonsOfGas = 3.26;
bool isRaining = true;
</code></pre></div><p><strong>Remember that there is a difference between declaring and assigning a value</strong>.</p> <h3 id="constants"><a href="https://book.techelevator.com/content/introduction-to-programming-ool.html#constants" class="header-anchor">#</a> Constants</h3> <p>Consider the following program where two variables, days and seconds, are declared and used later in an arithmetic expression:</p> <div class="language-csharp extra-class"><pre class="language-csharp"><code><span class="token keyword">int</span> days <span class="token operator">=</span> <span class="token number">2</span><span class="token punctuation">;</span>
<span class="token keyword">int</span> seconds <span class="token operator">=</span> <span class="token number">40</span><span class="token punctuation">;</span>

<span class="token comment">// ....</span>

<span class="token keyword">int</span> numberOfHoursAwake <span class="token operator">=</span> <span class="token number">24</span> <span class="token operator">*</span> days<span class="token punctuation">;</span>
<span class="token keyword">int</span> numberOfFrames <span class="token operator">=</span> <span class="token number">24</span> <span class="token operator">*</span> seconds<span class="token punctuation">;</span>
</code></pre></div><p>Although 24 is the same number in both statements, they serve different meanings. In programming, 24 is considered a <em>magic number</em>. A magic number in programming is a unique value whose meaning is based upon its context. Above, 24 refers to the number of hours in a day and the number of frames per second.</p> <p>When writing a program, youre encouraged to use constants so other programmers dont have to try to figure out what 24 means. This constant allows you to give the number a name so you can reference it throughout your code.</p> <p>Using that same idea above, consider the following program that uses constants to clearly indicate the meaning of 24 in a block of code:</p> <div class="tabs-component"><ul role="tablist" class="tabs-component-tabs"><li role="presentation" class="tabs-component-tab is-active"><a aria-controls="#c#" aria-selected="true" href="https://book.techelevator.com/content/introduction-to-programming-ool.html#c#" role="tab" class="tabs-component-tab-a">C#</a></li><li role="presentation" class="tabs-component-tab"><a aria-controls="#java" href="https://book.techelevator.com/content/introduction-to-programming-ool.html#java" role="tab" class="tabs-component-tab-a">Java</a></li></ul> <div class="tabs-component-panels"><section id="c#" role="tabpanel" class="tabs-component-panel" style=""><div class="language-csharp extra-class"><pre class="language-csharp"><code><span class="token keyword">int</span> days <span class="token operator">=</span> <span class="token number">2</span><span class="token punctuation">;</span>
<span class="token keyword">int</span> seconds <span class="token operator">=</span> <span class="token number">40</span><span class="token punctuation">;</span>
<span class="token keyword">const</span> <span class="token keyword">int</span> NumberOfHoursPerDay <span class="token operator">=</span> <span class="token number">24</span><span class="token punctuation">;</span>
<span class="token keyword">const</span> <span class="token keyword">int</span> NumberOfFramesPerSecond <span class="token operator">=</span> <span class="token number">24</span><span class="token punctuation">;</span>

<span class="token comment">// ....</span>

<span class="token keyword">int</span> numberOfHoursAwake <span class="token operator">=</span> NumberOfHoursPerDay <span class="token operator">*</span> days<span class="token punctuation">;</span>
<span class="token keyword">int</span> numberOfFrames <span class="token operator">=</span> NumberOfFramesPerSecond <span class="token operator">*</span> seconds<span class="token punctuation">;</span>
</code></pre></div></section> <section aria-hidden="true" id="java" role="tabpanel" class="tabs-component-panel" style="display: none;"><div class="language-java extra-class"><pre class="language-java"><code><span class="token keyword">int</span> days <span class="token operator">=</span> <span class="token number">2</span><span class="token punctuation">;</span>
<span class="token keyword">int</span> seconds <span class="token operator">=</span> <span class="token number">40</span><span class="token punctuation">;</span>
<span class="token keyword">final</span> <span class="token keyword">int</span> NUMBER_OF_HOURS_PER_DAY <span class="token operator">=</span> <span class="token number">24</span><span class="token punctuation">;</span>
<span class="token keyword">final</span> <span class="token keyword">int</span> NUMBER_OF_FRAMES_PER_SECOND <span class="token operator">=</span> <span class="token number">24</span><span class="token punctuation">;</span>

<span class="token comment">// ....</span>

<span class="token keyword">int</span> numberOfHoursAwake <span class="token operator">=</span> NUMBER_OF_HOURS_PER_DAY <span class="token operator">*</span> days<span class="token punctuation">;</span>
<span class="token keyword">int</span> numberOfFrames <span class="token operator">=</span> NUMBER_OF_FRAMES_PER_SECOND <span class="token operator">*</span> seconds<span class="token punctuation">;</span>
</code></pre></div></section></div></div> <h2 id="expressions"><a href="https://book.techelevator.com/content/introduction-to-programming-ool.html#expressions" class="header-anchor">#</a> Expressions</h2> <p>You now know one way to assign values to a variable: use literals and other variables. Another way to assign values to a variable is to use an expression. Expressions are statements that get evaluated and produce a single result, which can then be used in another statement.</p> <p>An example that you may be familiar with could be:</p> <div class="language- extra-class"><pre class="language-text"><code>200 / 10
</code></pre></div><p>You know that this arithmetic expression yields a single value: 20. In a program, it could be used in a similar way.</p> <div class="language- extra-class"><pre class="language-text"><code>int milesPerGallon = 200 / 10;      //200 / 10 is evaluated to 20 which is then saved into the variable.
</code></pre></div><p>As you continue reading, expressions will take on many forms. Next, youll see how arithmetic expressions can be used with variables in programs.</p> <h3 id="arithmetic-expressions"><a href="https://book.techelevator.com/content/introduction-to-programming-ool.html#arithmetic-expressions" class="header-anchor">#</a> Arithmetic expressions</h3> <p>There is usually a need for simple calculations when your programs run. To do that, you have access to the following arithmetic operators:</p> <p>Assume: A is equal to 15 and B is equal to 2.</p> <table><thead><tr><th>Operator</th> <th>Description</th> <th>Example</th></tr></thead> <tbody><tr><td><code>+</code></td> <td>Adds two operands</td> <td>A + B = 17</td></tr> <tr><td><code>-</code></td> <td>Subtracts two operands</td> <td>A - B = 13</td></tr> <tr><td><code>*</code></td> <td>Multiplies two operands</td> <td>A * B = 30</td></tr> <tr><td><code>/</code></td> <td>Divides two operands</td> <td>A / B = 7</td></tr> <tr><td><code>%</code></td> <td>Finds the remainder after division</td> <td>A % B = 1</td></tr></tbody></table> <p>These operators can be combined with <code>()</code> to group parts of the expression together.</p> <div class="language-csharp extra-class"><pre class="language-csharp"><code><span class="token keyword">int</span> a <span class="token operator">=</span> <span class="token number">15</span><span class="token punctuation">;</span>
<span class="token keyword">int</span> b <span class="token operator">=</span> <span class="token number">2</span><span class="token punctuation">;</span>
<span class="token keyword">int</span> result<span class="token punctuation">;</span>

result <span class="token operator">=</span> a <span class="token operator">+</span> b<span class="token punctuation">;</span>     <span class="token comment">//expression is evaluated to 17 and copied into result</span>
result <span class="token operator">=</span> a <span class="token operator">-</span> b<span class="token punctuation">;</span>     <span class="token comment">//expression is evaluated to 13 and copied into result</span>
result <span class="token operator">=</span> a <span class="token operator">*</span> b<span class="token punctuation">;</span>     <span class="token comment">//expression is evaluated to 30 and copied into result</span>
result <span class="token operator">=</span> a <span class="token operator">/</span> b<span class="token punctuation">;</span>     <span class="token comment">//expression is evaluated to 7 and copied into result</span>
result <span class="token operator">=</span> a <span class="token operator">%</span> b<span class="token punctuation">;</span>     <span class="token comment">//expression is evaluated to 1 and copied into result</span>

<span class="token comment">//In the below statement, a is multiplied with b first. The output is divided</span>
<span class="token comment">//by the current value of the result variable. This final value is assigned</span>
<span class="token comment">//into the result value.</span>
result <span class="token operator">=</span> <span class="token punctuation">(</span>a <span class="token operator">*</span> b<span class="token punctuation">)</span> <span class="token operator">/</span> result<span class="token punctuation">;</span>

<span class="token comment">// Translates to</span>
<span class="token comment">//  result = (15 * 2) / result;</span>
<span class="token comment">//      result = 30 / result;</span>
<span class="token comment">//      result = 30 / 1;</span>
<span class="token comment">//      result = 30;</span>
</code></pre></div><h2 id="type-conversion"><a href="https://book.techelevator.com/content/introduction-to-programming-ool.html#type-conversion" class="header-anchor">#</a> Type conversion</h2> <p>When you move a value from one type to another, the compiler becomes interested in what youre doing. It worries about whether or not the operation being performed might result in a loss of data. Each conversion operation is considered in terms of <em>widening</em> (smaller data type to larger data type) and <em>narrowing</em> (larger data type to smaller data type) of value ranges.</p> <p>As an example, converting from an <code>int</code> into a <code>long</code> can take place implicitly and requires no additional code. When a value is narrowed, like <code>double</code> to <code>int</code>, you must explicitly indicate this in your code.</p> <p>The code block below shows how to perform type conversion. In this example, the code block doesnt compile because it lacks an explicit type conversion:</p> <div class="language-csharp extra-class"><pre class="language-csharp"><code><span class="token keyword">double</span> calculatedScore <span class="token operator">=</span> <span class="token number">87.6</span><span class="token punctuation">;</span>
<span class="token keyword">int</span> finalGrade <span class="token operator">=</span> calculatedScore<span class="token punctuation">;</span>
</code></pre></div><p>The syntax for a type conversion is:</p> <div class="language-csharp extra-class"><pre class="language-csharp"><code>datatype identifier <span class="token operator">=</span> <span class="token punctuation">(</span>dataType<span class="token punctuation">)</span>valueToConvert<span class="token punctuation">;</span>

<span class="token keyword">double</span> calculatedScore <span class="token operator">=</span> <span class="token number">87.6</span><span class="token punctuation">;</span>
<span class="token keyword">int</span> finalGrade <span class="token operator">=</span> <span class="token punctuation">(</span><span class="token keyword">int</span><span class="token punctuation">)</span>calculatedScore<span class="token punctuation">;</span>
</code></pre></div><div class="custom-block tip"><p class="custom-block-title">Inferring Data Types</p> <p>Realistically, youll run into type conversions the most when youre trying to perform arithmetic between two data types. As a rule, the runtime tries its best to be efficient despite what data type you use on the left-hand side of the statement.</p> <div class="language-csharp extra-class"><pre class="language-csharp"><code><span class="token keyword">int</span> score1 <span class="token operator">=</span> <span class="token number">85</span><span class="token punctuation">;</span>
<span class="token keyword">int</span> score2 <span class="token operator">=</span> <span class="token number">93</span><span class="token punctuation">;</span>
<span class="token keyword">int</span> score3 <span class="token operator">=</span> <span class="token number">75</span><span class="token punctuation">;</span>

<span class="token comment">// (score1 + score2 + score3) / 3;    yields the integer 84</span>
<span class="token comment">// (score1 + score2 + score3) / 3.0;  yields the double 84.33333</span>

<span class="token keyword">double</span> averageScore <span class="token operator">=</span> <span class="token punctuation">(</span>score1 <span class="token operator">+</span> score2 <span class="token operator">+</span> score3<span class="token punctuation">)</span> <span class="token operator">/</span> <span class="token number">3</span><span class="token punctuation">;</span>   <span class="token comment">//84</span>
<span class="token keyword">double</span> averageScore <span class="token operator">=</span> <span class="token punctuation">(</span>score1 <span class="token operator">+</span> score2 <span class="token operator">+</span> score3<span class="token punctuation">)</span> <span class="token operator">/</span> <span class="token number">3.0</span><span class="token punctuation">;</span> <span class="token comment">//84.33339</span>
</code></pre></div></div> <h3 id="literal-suffixes"><a href="https://book.techelevator.com/content/introduction-to-programming-ool.html#literal-suffixes" class="header-anchor">#</a> Literal suffixes</h3> <p>Java and C# can identify which data type is used during an assignment operation. However, there are some scenarios where the compiler becomes stuck and isnt sure what to do. This normally happens when youre working with floating point numbers. The example below shows code that doesnt compile:</p> <div class="language-csharp extra-class"><pre class="language-csharp"><code><span class="token comment">//float f = 3.26;       //wont compile, compiler assumes 3.26 is a double and wants an explicit conversion</span>
<span class="token keyword">float</span> f <span class="token operator">=</span> <span class="token number">3.26F</span><span class="token punctuation">;</span>        <span class="token comment">//adding 
"F" tells the compiler this is a literal float value</span>
</code></pre></div><p>For a reference to other literal suffixes used in Java and C#, see <a href="https://www.codeproject.com/Articles/689009/Numeric-Literals-in-Java-and-in-Csharp" target="_blank" rel="noopener noreferrer">Numeric Literals in Java and in C#<svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" x="0px" y="0px" viewBox="0 0 100 100" width="15" height="15" class="icon outbound"><path fill="currentColor" d="M18.8,85.1h56l0,0c2.2,0,4-1.8,4-4v-32h-8v28h-48v-48h28v-8h-32l0,0c-2.2,0-4,1.8-4,4v56C14.8,83.3,16.6,85.1,18.8,85.1z"></path> <polygon fill="currentColor" points="45.7,48.7 51.3,54.3 77.2,28.5 77.2,37.2 85.2,37.2 85.2,14.9 62.8,14.9 62.8,22.9 71.5,22.9"></polygon></svg></a>.</p></div> <footer class="page-edit"><!----> <!----></footer> <div class="page-nav"><p class="inner"><span class="prev">
      ?
      <a href="https://book.techelevator.com/content/introduction-to-tools.html" class="prev">
        Introduction to Tools
      </a></span> <span class="next"><a href="https://book.techelevator.com/content/logical-branching-ool.html" class="">
        Logical Branching
      </a>
      ?
    </span></p></div> </main></div><div class="global-ui"><!----></div></div>
    <script src="./An Introduction to Variables &amp; Data Types _ Student Book_files/app.08764f16.js.download" defer=""></script><script src="./An Introduction to Variables &amp; Data Types _ Student Book_files/2.fcd05e6e.js.download" defer=""></script><script src="./An Introduction to Variables &amp; Data Types _ Student Book_files/19.f646b03d.js.download" defer=""></script>
  

</body></html>');

INSERT INTO curriculum (course, date, lesson) VALUES

((SELECT id FROM course WHERE (name='Object Oriented Programming')), '12-28-2020', 
'<!DOCTYPE html>
  Tech Elevator
  <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" x="0px" y="0px" viewBox="0 0 100 100" width="15" height="15" class="icon outbound"><path fill="currentColor" d="M18.8,85.1h56l0,0c2.2,0,4-1.8,4-4v-32h-8v28h-48v-48h28v-8h-32l0,0c-2.2,0-4,1.8-4,4v56C14.8,83.3,16.6,85.1,18.8,85.1z"></path> <polygon fill="currentColor" points="45.7,48.7 51.3,54.3 77.2,28.5 77.2,37.2 85.2,37.2 85.2,14.9 62.8,14.9 62.8,22.9 71.5,22.9"></polygon></svg></a></div> <!----></nav></div></header> <div class="sidebar-mask"></div> <aside class="sidebar"><nav class="nav-links"><div class="nav-item"><a href="https://book.techelevator.com/" class="nav-link">
  Home
</a></div><div class="nav-item"><a href="https://book.techelevator.com/content/language.html" class="nav-link">
  Language
</a></div><div class="nav-item"><a href="https://book.techelevator.com/content/glossary.html" class="nav-link">
  Glossary
</a></div><div class="nav-item"><a href="https://techelevator.com/" target="_blank" rel="noopener noreferrer" class="nav-link external">
  Tech Elevator
  <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" x="0px" y="0px" viewBox="0 0 100 100" width="15" height="15" class="icon outbound"><path fill="currentColor" d="M18.8,85.1h56l0,0c2.2,0,4-1.8,4-4v-32h-8v28h-48v-48h28v-8h-32l0,0c-2.2,0-4,1.8-4,4v56C14.8,83.3,16.6,85.1,18.8,85.1z"></path> <polygon fill="currentColor" points="45.7,48.7 51.3,54.3 77.2,28.5 77.2,37.2 85.2,37.2 85.2,14.9 62.8,14.9 62.8,22.9 71.5,22.9"></polygon></svg></a></div> <!----></nav>  <ul class="sidebar-links"><li><a href="https://book.techelevator.com/" class="sidebar-link">Introduction</a></li><li><section class="sidebar-group collapsable depth-0"><p class="sidebar-heading open"><span>Module 1</span> <span class="arrow down"></span></p> <ul class="sidebar-links sidebar-group-items" style=""><li><a href="https://book.techelevator.com/content/introduction-to-tools.html" class="sidebar-link">Introduction to Tools</a></li><li><a href="https://book.techelevator.com/content/introduction-to-programming-ool.html" class="sidebar-link">Introduction to Programming</a></li><li><a href="https://book.techelevator.com/content/logical-branching-ool.html" class="active sidebar-link">Logical Branching</a><ul class="sidebar-sub-headers"><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/logical-branching-ool.html#boolean-expressions" class="sidebar-link">Boolean expressions</a><ul class="sidebar-sub-headers"><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/logical-branching-ool.html#comparison-operators" class="sidebar-link">Comparison operators</a></li><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/logical-branching-ool.html#logical-operators" class="sidebar-link">Logical operators</a></li><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/logical-branching-ool.html#reading-complex-expressions" class="sidebar-link">Reading complex expressions</a></li></ul></li><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/logical-branching-ool.html#conditional-code" class="sidebar-link">Conditional code</a><ul class="sidebar-sub-headers"><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/logical-branching-ool.html#single-conditions-with-if" class="sidebar-link">Single conditions with if</a></li><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/logical-branching-ool.html#two-paths-with-if-else" class="sidebar-link">Two paths with if/else</a></li><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/logical-branching-ool.html#multiple-paths-using-if-else-if-else" class="sidebar-link">Multiple paths using if/else if/else</a></li><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/logical-branching-ool.html#choosing-between-two-values" class="sidebar-link">Choosing between two values</a></li></ul></li><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/logical-branching-ool.html#blocks" class="sidebar-link">Blocks</a><ul class="sidebar-sub-headers"><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/logical-branching-ool.html#scope" class="sidebar-link">Scope</a></li><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/logical-branching-ool.html#nested-blocks" class="sidebar-link">Nested blocks</a></li></ul></li><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/logical-branching-ool.html#methods" class="sidebar-link">Methods</a><ul class="sidebar-sub-headers"><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/logical-branching-ool.html#return-type" class="sidebar-link">Return type</a></li><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/logical-branching-ool.html#method-name" class="sidebar-link">Method name</a></li><li class="sidebar-sub-header"><a href="https://book.techelevator.com/content/logical-branching-ool.html#parameter-list" class="sidebar-link">Parameter list</a></li></ul></li></ul></li><li><a href="https://book.techelevator.com/content/arrays-and-loops-ool.html" class="sidebar-link">Arrays and Loops</a></li><li><a href="https://book.techelevator.com/content/command-line-programs.html" class="sidebar-link">Building Command Line Programs</a></li><li><a href="https://book.techelevator.com/content/introduction-to-objects-ool.html" class="sidebar-link">Introduction to Objects</a></li><li><a href="https://book.techelevator.com/content/linear-data-structures-ool.html" class="sidebar-link">Collections: Part 1</a></li><li><a href="https://book.techelevator.com/content/non-linear-data-structures-ool.html" class="sidebar-link">Collections: Part 2</a></li><li><a href="https://book.techelevator.com/content/classes-encapsulation-ool.html" class="sidebar-link">Classes and Encapsulation</a></li><li><a href="https://book.techelevator.com/content/inheritance-ool.html" class="sidebar-link">Inheritance</a></li><li><a href="https://book.techelevator.com/content/polymorphism-ool.html" class="sidebar-link">Polymorphism</a></li><li><a href="https://book.techelevator.com/content/unit-testing-ool.html" class="sidebar-link">Unit Testing</a></li><li><a href="https://book.techelevator.com/content/file-io-ool.html" class="sidebar-link">File I/O</a></li><li><a href="https://book.techelevator.com/content/exception-handling-ool.html" class="sidebar-link">Error Handling</a></li></ul></section></li><li><section class="sidebar-group collapsable depth-0"><p class="sidebar-heading"><span>Module 2</span> <span class="arrow right"></span></p> <!----></section></li><li><section class="sidebar-group collapsable depth-0"><p class="sidebar-heading"><span>Module 3</span> <span class="arrow right"></span></p> <!----></section></li><li><section class="sidebar-group collapsable depth-0"><p class="sidebar-heading"><span>After the Cohort</span> <span class="arrow right"></span></p> <!----></section></li></ul> </aside> <main class="page"> <div class="theme-default-content content__default"><h1 id="logical-branching"><a href="https://book.techelevator.com/content/logical-branching-ool.html#logical-branching" class="header-anchor">#</a> Logical branching</h1> <p>As a programmer, you may come across a situation where your program must decide what to do next based on the data available to it:</p> <ul><li>A healthcare portal might display different pages based on the age of the website visitor - think senior citizen vs. young adult</li> <li>If a user hasnt logged in, show them the login page; otherwise allow them to proceed</li> <li>If a username is already taken, tell the user to select another username</li></ul> <p>This section discusses concepts that enable code to make decisions and determine what to do next.</p> <p>By the end of this chapter, you should:</p> <ul><li>Understand how to build boolean expressions using arithmetic, comparison, and logical operators</li> <li>Understand how to write conditional code using boolean expressions</li> <li>Be able to read and understand complex code expressions</li> <li>Be able to demonstrate an understanding of code blocks and variable scope</li> <li>Be familiar with the components of a method signature</li></ul> <h2 id="boolean-expressions"><a href="https://book.techelevator.com/content/logical-branching-ool.html#boolean-expressions" class="header-anchor">#</a> Boolean expressions</h2> <p>In the previous chapter, you learned an expression always evaluates to a single value. Outside of arithmetic expressions, another common expression is a <strong>boolean expression</strong>. This expression always evaluates to <code>true</code> or <code>false</code>.</p> <p>There are two common ways that boolean expressions are built:</p> <ul><li>Comparison operators (to compare two values)</li> <li>Logical operators (to create relationships between one or more boolean values)</li></ul> <h3 id="comparison-operators"><a href="https://book.techelevator.com/content/logical-branching-ool.html#comparison-operators" class="header-anchor">#</a> Comparison operators</h3> <p>As programmers, when you create applications, you often deal with simple arithmetic comparisons to allow your website visitors to make a choice or present them with different options. For example, you may want to:</p> <ul><li>Calculate if a number is odd or even to create alternating row colors in web pages</li> <li>Validate that there are enough tickets available before allowing a user to reserve a seat for an event</li> <li>Check to see if the user hasnt been to the site within 90 days to show them a reminder</li></ul> <p>The following comparison operators allow you to make these comparisons.</p> <table><thead><tr><th>Operator</th> <th>Meaning</th></tr></thead> <tbody><tr><td><code>==</code></td> <td>Equal To</td></tr> <tr><td><code>!=</code></td> <td>Not Equal To</td></tr> <tr><td><code>&gt;</code></td> <td>Greater Than</td></tr> <tr><td><code>&lt;</code></td> <td>Less Than</td></tr> <tr><td><code>&gt;=</code></td> <td>Greater Than or Equal To</td></tr> <tr><td><code>&lt;=</code></td> <td>Less Than or Equal To</td></tr></tbody></table> <p>When used in an expression, these comparison operators always evaluate to a boolean <code>true</code> or <code>false</code> value. For example:</p> <div class="code-block"><div class="language-java extra-class"><pre class="language-java"><code><span class="token keyword">int</span> number <span class="token operator">=</span> <span class="token number">5</span><span class="token punctuation">;</span>

<span class="token keyword">boolean</span> isItFive <span class="token operator">=</span> <span class="token punctuation">(</span>number <span class="token operator">==</span> <span class="token number">5</span><span class="token punctuation">)</span><span class="token punctuation">;</span>      <span class="token comment">//true if number is "5"</span>
<span class="token keyword">boolean</span> isItEven <span class="token operator">=</span> <span class="token punctuation">(</span>number <span class="token operator">%</span> <span class="token number">2</span><span class="token punctuation">)</span> <span class="token operator">==</span> <span class="token number">0</span><span class="token punctuation">;</span>  <span class="token comment">//true if number is evenly divisible by "2"</span>
<span class="token keyword">boolean</span> isItNegative <span class="token operator">=</span> <span class="token punctuation">(</span>number <span class="token operator">&lt;</span> <span class="token number">0</span><span class="token punctuation">)</span><span class="token punctuation">;</span>   <span class="token comment">//true if number is less than but not equal to 0</span>
</code></pre></div></div> <div class="code-block"><!----></div> <h3 id="logical-operators"><a href="https://book.techelevator.com/content/logical-branching-ool.html#logical-operators" class="header-anchor">#</a> Logical operators</h3> <p>The comparison operators are limited in their ability to compare values between two different types. When a boolean expression needs to take two or more considerations into account to evaluate a boolean value—for example, is the number negative AND is it even—then the logical operators are used.</p> <p>The logical operators are AND (<code>&amp;&amp;</code>), OR (<code>||</code>), XOR (<code>^</code>), and NOT (<code>!</code>). These operators work with one or more boolean operands to evaluate a boolean expression and yield <code>true</code> or <code>false.</code></p> <h4 id="not"><a href="https://book.techelevator.com/content/logical-branching-ool.html#not" class="header-anchor">#</a> NOT <code>!</code></h4> <p>When placed in front of a boolean value, the logical not operator negates the value of the boolean operand.</p> <h4 id="and"><a href="https://book.techelevator.com/content/logical-branching-ool.html#and" class="header-anchor">#</a> AND <code>&amp;&amp;</code></h4> <p>If both of the operands on each side of the <code>&amp;&amp;</code> are <code>true</code>, the result of the expression is <code>true</code>. If one of them is <code>false</code>, the result is <code>false</code>. Consider the variable called <code>width</code> used in the following expression:</p> <div class="language- extra-class"><pre class="language-text"><code>(width &gt;= 0.5) &amp;&amp; (width &lt;= 5.0)
</code></pre></div><p>This expression is true if the <code>width</code> is between 0.5 and 5.0.</p> <h4 id="or"><a href="https://book.techelevator.com/content/logical-branching-ool.html#or" class="header-anchor">#</a> OR <code>||</code></h4> <p>If either of the operands on each side of the <code>||</code> are <code>true</code>, then the result of the expression is also <code>true</code>. The expression is only <code>false</code> when both operands are <code>false</code>. For example, consider the variable called <code>width</code> used in the following expression:</p> <div class="language- extra-class"><pre class="language-text"><code>width &lt; 0.5 || width &gt; 5.0
</code></pre></div><p>This expression is true if the <code>width</code> is less than 0.5 or greater than 5.0.</p> <h4 id="xor"><a href="https://book.techelevator.com/content/logical-branching-ool.html#xor" class="header-anchor">#</a> XOR <code>^</code></h4> <p>This operator is called exclusive-or. If one operand in the expression is <code>true</code> and the other operand is <code>false</code>, then the result of the expression is <code>true</code>. In an exclusive-or, whenever both operands have the same value, the expression is <code>false</code>.</p> <p>This expression isnt used as often as the logical AND and logical OR.</p> <h4 id="logical-operator-table"><a href="https://book.techelevator.com/content/logical-branching-ool.html#logical-operator-table" class="header-anchor">#</a> Logical operator table</h4> <p>The following table sums up the different logical operators:</p> <table><thead><tr><th><code>A</code></th> <th><code>B</code></th> <th><code>!A</code></th> <th><code>A &amp;&amp; B</code></th> <th><code>A || B</code></th> <th><code>A ^ B</code></th></tr></thead> <tbody><tr><td><strong>TRUE</strong></td> <td><strong>TRUE</strong></td> <td>FALSE</td> <td>TRUE</td> <td>TRUE</td> <td>FALSE</td></tr> <tr><td><strong>TRUE</strong></td> <td><strong>FALSE</strong></td> <td>FALSE</td> <td>FALSE</td> <td>TRUE</td> <td>TRUE</td></tr> <tr><td><strong>FALSE</strong></td> <td><strong>TRUE</strong></td> <td>TRUE</td> <td>FALSE</td> <td>TRUE</td> <td>TRUE</td></tr> <tr><td><strong>FALSE</strong></td> <td><strong>FALSE</strong></td> <td>TRUE</td> <td>FALSE</td> <td>FALSE</td> <td>FALSE</td></tr></tbody></table> <p>Using one of the previous examples, if you wanted to find out if a number was negative AND even, you could write it like this:</p> <div class="code-block"><div class="language-java extra-class"><pre class="language-java"><code><span class="token keyword">int</span> number <span class="token operator">=</span> <span class="token number">5</span><span class="token punctuation">;</span>

<span class="token keyword">boolean</span> isItEven <span class="token operator">=</span> <span class="token punctuation">(</span>number <span class="token operator">%</span> <span class="token number">2</span> <span class="token operator">==</span> <span class="token number">0</span><span class="token punctuation">)</span><span class="token punctuation">;</span>      <span class="token comment">//true if number is even</span>
<span class="token keyword">boolean</span> isItNegative <span class="token operator">=</span> <span class="token punctuation">(</span>number <span class="token operator">&lt;</span> <span class="token number">0</span><span class="token punctuation">)</span><span class="token punctuation">;</span>       <span class="token comment">//true if number is less than but not equal to 0</span>

<span class="token keyword">boolean</span> answer <span class="token operator">=</span> isItEven <span class="token operator">&amp;&amp;</span> isItNegative<span class="token punctuation">;</span> <span class="token comment">//true if isItEven is true and isItNegative is true</span>
</code></pre></div></div> <div class="code-block"><!----></div> <h3 id="reading-complex-expressions"><a href="https://book.techelevator.com/content/logical-branching-ool.html#reading-complex-expressions" class="header-anchor">#</a> Reading complex expressions</h3> <p>In programming, you may encounter many different combinations of comparison and logical operators used in an expression. Boolean expressions can be combined.</p> <p>Assume two integers <code>a</code> and <code>b</code> are used in the following expression:</p> <div class="code-block"><div class="language-java extra-class"><pre class="language-java"><code><span class="token keyword">int</span> a<span class="token punctuation">,</span> b<span class="token punctuation">;</span>
<span class="token keyword">boolean</span> output <span class="token operator">=</span> <span class="token punctuation">(</span>a <span class="token operator">&gt;=</span> <span class="token number">10</span> <span class="token operator">&amp;&amp;</span> a <span class="token operator">&lt;=</span> <span class="token number">20</span><span class="token punctuation">)</span> <span class="token operator">||</span> <span class="token punctuation">(</span>b <span class="token operator">&gt;=</span> <span class="token number">10</span> <span class="token operator">&amp;&amp;</span> b <span class="token operator">&lt;=</span> <span class="token number">20</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre></div></div> <div class="code-block"><!----></div> <p>In the above expression, <code>output</code> is only true if <code>a</code> or <code>b</code> is between 10 and 20. What if you give <code>a</code> the value of 8 and <code>b</code> the value of 13? Below, you can see how the expression is simplified step-by-step.</p> <p>First, the values for the variables are replaced within the expressions.</p> <div class="code-block"><div class="language-java extra-class"><pre class="language-java"><code><span class="token keyword">boolean</span> output <span class="token operator">=</span> <span class="token punctuation">(</span><span class="token number">8</span> <span class="token operator">&gt;=</span> <span class="token number">10</span> <span class="token operator">&amp;&amp;</span> <span class="token number">8</span> <span class="token operator">&lt;=</span> <span class="token number">20</span><span class="token punctuation">)</span> <span class="token operator">||</span> <span class="token punctuation">(</span><span class="token number">13</span> <span class="token operator">&gt;=</span> <span class="token number">10</span> <span class="token operator">&amp;&amp;</span> <span class="token number">13</span> <span class="token operator">&lt;=</span> <span class="token number">20</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre></div></div> <div class="code-block"><!----></div> <p>Next, the following comparison operations are evaluated, simplifying the expression:</p> <ul><li><code>8 &gt;= 10</code> is <code>false</code></li> <li><code>8 &lt;= 20</code> is <code>true</code></li> <li><code>13 &gt;= 10</code> is <code>true</code></li> <li><code>13 &lt;= 20</code> is <code>true</code></li></ul> <div class="code-block"><div class="language-java extra-class"><pre class="language-java"><code><span class="token keyword">boolean</span> output <span class="token operator">=</span> <span class="token punctuation">(</span><span class="token boolean">false</span> <span class="token operator">&amp;&amp;</span> <span class="token boolean">true</span><span class="token punctuation">)</span> <span class="token operator">||</span> <span class="token punctuation">(</span><span class="token boolean">true</span> <span class="token operator">&amp;&amp;</span> <span class="token boolean">true</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre></div></div> <div class="code-block"><!----></div> <p>After the comparison operations, the logical expressions are evaluated:</p> <ul><li><code>false &amp;&amp; true</code> yields <code>false</code></li> <li><code>true &amp;&amp; true</code> yields <code>true</code>.</li></ul> <div class="code-block"><div class="language-java extra-class"><pre class="language-java"><code><span class="token keyword">boolean</span> output <span class="token operator">=</span> <span class="token punctuation">(</span><span class="token boolean">false</span><span class="token punctuation">)</span> <span class="token operator">||</span> <span class="token punctuation">(</span><span class="token boolean">true</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre></div></div> <div class="code-block"><!----></div> <p>Lastly, <code>false || true</code> is evaluated, and the final value is <code>true</code>. The complex expression from a few steps back is simplified into:</p> <div class="code-block"><div class="language-java extra-class"><pre class="language-java"><code><span class="token keyword">boolean</span> output <span class="token operator">=</span> <span class="token boolean">true</span><span class="token punctuation">;</span>
</code></pre></div></div> <div class="code-block"><!----></div> <h2 id="conditional-code"><a href="https://book.techelevator.com/content/logical-branching-ool.html#conditional-code" class="header-anchor">#</a> Conditional code</h2> <p>There are many different choices available to programmers who want their code to take various paths based on a <code>true</code> or <code>false</code> condition.</p> <p>The most common approach developers use to allow their code to take various paths is <code>if</code>, <code>if/else</code>, or <code>if/else if/else</code>.</p> <p>With each of the following examples, any usage of the word <code>condition</code> can be replaced by a boolean expression that can consist of a simple boolean variable or a more complex one evaluated from comparison and logical operators.</p> <h3 id="single-conditions-with-if"><a href="https://book.techelevator.com/content/logical-branching-ool.html#single-conditions-with-if" class="header-anchor">#</a> Single conditions with <code>if</code></h3> <p>The format for an <code>if</code> condition follows:</p> <div class="language- extra-class"><pre class="language-text"><code>if (condition) {
    statement or block performed if condition is true
}
</code></pre></div><h3 id="two-paths-with-if-else"><a href="https://book.techelevator.com/content/logical-branching-ool.html#two-paths-with-if-else" class="header-anchor">#</a> Two paths with <code>if/else</code></h3> <p>The format for an <code>if/else</code> condition follows:</p> <div class="language- extra-class"><pre class="language-text"><code>if (condition) {
    statement or block performed if condition is true
} else {
    statement or block performed if condition is not true
}
</code></pre></div><div class="custom-block warning"><p class="custom-block-title">Dont add conditions for else</p> <p>Notice that theres no condition after the else keyword. You dont need to add a condition because <code>else</code> always executes if the condition in the <code>if</code> section is <code>false</code>.</p></div> <h3 id="multiple-paths-using-if-else-if-else"><a href="https://book.techelevator.com/content/logical-branching-ool.html#multiple-paths-using-if-else-if-else" class="header-anchor">#</a> Multiple paths using <code>if/else if/else</code></h3> <p>If you need to provide more than two paths for the code to take, you can use an <code>if/else if</code> code branch. With the <code>if/else if</code>, each time you write <code>if</code>, you need to supply an additional condition that indicates if the following code block should execute.</p> <p>Once Java or C# runs into the first true condition, it executes the following block of code. After that block, the program resumes after the last conditional block:</p> <div class="language- extra-class"><pre class="language-text"><code>if (condition) {
    statement or block you do if the first condition is true
} else if (other condition) {
    statement or block you do if the first condition is false
    and the second condition is true
} else if (other condition 2) {
    statement or block you do if the first two conditions are false
    and the third condition is true
} else {
    statement or block you do if all the above conditions are false
}
</code></pre></div><div class="custom-block tip"><p class="custom-block-title">`Else` not required</p> <p>The <code>else</code> isnt required. Its only useful if you want a default option if all the conditions before it are <code>false</code>.</p></div> <p></p> <div class="custom-block tip"><p class="custom-block-title">Prioritize your conditional checks</p> <p>When chaining multiple <code>if/else if</code> blocks, make sure to put your most exclusive option first. Programs stop at the first condition they find to be true. If there are less exclusive options first, then there is a risk that the code block you thought would run does not. Consider the classic FizzBuzz problem which has programmers return "Fizz" if a number is divisible by 3, "Buzz" if the number is divisible by 5, and "FizzBuzz" if the number is divisible by 3 and 5.</p> <div class="language- extra-class"><pre class="language-text"><code>int n = 15;

if (n % 5 == 0) {
  // Fizz
} else if (n % 3 == 0) {
  // Buzz
} else if (n % 3 == 0 &amp;&amp; n % 5 == 0) {
  // FizzBuzz
}
</code></pre></div><p>The program will never find FizzBuzz. As soon as <code>15 % 5 == 0</code> is evaluated and true, the remaining conditions are never evaluated and the result will be Fizz.</p></div> <h3 id="choosing-between-two-values"><a href="https://book.techelevator.com/content/logical-branching-ool.html#choosing-between-two-values" class="header-anchor">#</a> Choosing between two values</h3> <p>Theres another type of conditional operator that acts a lot like an if statement but is just used to select between two different values. This operator is called a Ternary Operator. It looks like this:</p> <div class="language-java extra-class"><pre class="language-java"><code>    conditional <span class="token operator">?</span> true_value <span class="token operator">:</span> false_value
</code></pre></div><p>This may look odd at first, but this <code>if</code> shorthand comes in handy when formatting data to print to a user.</p> <p>The way the ternary works is that first the condition is checked. If the condition is true, the operator returns the value after the <code>?</code>, but if its false, it returns the value after the <code>:</code>. You wont use this often, but its useful in these situations:</p> <div class="code-block"><div class="language-java extra-class"><pre class="language-java"><code>    <span class="token keyword">int</span> numOfBananas <span class="token operator">=</span> <span class="token punctuation">.</span><span class="token punctuation">.</span><span class="token punctuation">.</span><span class="token punctuation">;</span>
    <span class="token class-name">String</span> message <span class="token operator">=</span>
        <span class="token string">"We have "</span> <span class="token operator">+</span> numOfBananas <span class="token operator">+</span> <span class="token string">" banana"</span> <span class="token operator">+</span> <span class="token punctuation">(</span>numOfBananas <span class="token operator">!=</span> <span class="token number">1</span> <span class="token operator">?</span> <span class="token string">"s"</span> <span class="token operator">:</span> <span class="token string">""</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
</code></pre></div></div> <div class="code-block"><!----></div> <p>This puts an "s" on banana if theres more than one banana.</p> <h2 id="blocks"><a href="https://book.techelevator.com/content/logical-branching-ool.html#blocks" class="header-anchor">#</a> Blocks</h2> <p>Each of the sections of code that follow an <code>if</code> or an <code>else</code> statement are called <strong>blocks</strong>. Blocks use a pair of braces <strong>{..}</strong> to enclose single or multiple lines of code. Although it may seem that blocks exist to make your life difficult, they enhance code readability and deal with something called variable scope.</p> <p>The below code is enclosed in a block that only executes when the condition is true. <strong>Note the indentation that occurs when you write code inside of a code block.</strong></p> <div class="language- extra-class"><pre class="language-text"><code>if (condition) {
    //statement or block of code to run when condition is true
}
</code></pre></div><h3 id="scope"><a href="https://book.techelevator.com/content/logical-branching-ool.html#scope" class="header-anchor">#</a> Scope</h3> <p>In C# and Java, you can declare a variable at any point in a block, but you <strong>must</strong> declare it before you use it. Once declared, the variable is <em>in scope</em>. Variables are in scope until the end of the block when theyre discarded and go <em>out of scope</em>.</p> <h3 id="nested-blocks"><a href="https://book.techelevator.com/content/logical-branching-ool.html#nested-blocks" class="header-anchor">#</a> Nested blocks</h3> <p>Whether you have complex conditional logic or youre mixing multiple loops with conditions, blocks are often nested. Each nested block can declare and use its own set of local variables:</p> <div class="language-csharp extra-class"><pre class="language-csharp"><code><span class="token punctuation">{</span> <span class="token comment">//outer block</span>
    <span class="token keyword">int</span> i<span class="token punctuation">;</span>
    <span class="token punctuation">{</span> <span class="token comment">//inner block</span>
        <span class="token keyword">int</span> j<span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span>
</code></pre></div><p>The variable <code>j</code> has the scope of the inner block. Statements within the inner block can use both <code>i</code> and <code>j</code>. Statements in the outer block can only use <code>i</code>. If you write the following code, a compilation error occurs because <code>j</code> is out of scope:</p> <div class="language-csharp extra-class"><pre class="language-csharp"><code><span class="token punctuation">{</span>
    <span class="token keyword">int</span> i<span class="token punctuation">;</span>
    <span class="token punctuation">{</span>
        <span class="token keyword">int</span> j<span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
    j <span class="token operator">=</span> <span class="token number">33</span><span class="token punctuation">;</span> <span class="token comment">//&lt;--- not allowed, variable out of scope</span>
<span class="token punctuation">}</span>
</code></pre></div><p>C# and Java also wont allow a variable in an inner block to have the same name as a variable in an outer block. This also creates a compilation error.</p> <div class="language-csharp extra-class"><pre class="language-csharp"><code><span class="token punctuation">{</span>
    <span class="token keyword">int</span> i<span class="token punctuation">;</span>
    <span class="token punctuation">{</span>
        <span class="token keyword">int</span> i<span class="token punctuation">;</span>  <span class="token comment">//&lt;-- not allowed, variable already in scope</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span>
</code></pre></div><h2 id="methods"><a href="https://book.techelevator.com/content/logical-branching-ool.html#methods" class="header-anchor">#</a> Methods</h2> <p>In programming, methods break programs up into small, repeatable units of code. They allow programmers to create blocks of code that perform a single action or calculation where the answer only changes based on the inputs provided to it. Later lessons explore this further.</p> <p>For now, its important that you begin to read and understand the two parts of a method: the method signature and the method body.</p> <p>The components of a method signature are:</p> <ul><li>The return type</li> <li>The method name</li> <li>The parameter list</li></ul> <p></p><figure><img src="./Logical branching _ Student Book_files/method-signature.d791326e.png" class="medium-zoom-image"><figcaption>Image - Method Signature</figcaption></figure><p></p> <h3 id="return-type"><a href="https://book.techelevator.com/content/logical-branching-ool.html#return-type" class="header-anchor">#</a> Return type</h3> <p>Methods return to the code that invoked it when it completes all the statements in the method, reaches a return statement, or runs into an error, also called an <strong>exception</strong>, whichever occurs first.</p> <p>You declare a methods return type in the method signature. Within the body of the method, the return statement returns a value of that type.</p> <p>Youll see this later, but any method declared <code>void</code> doesnt return a value. It doesnt need to contain a return statement, but it can have one so the method ends early, as shown below:</p> <div class="language- extra-class"><pre class="language-text"><code>return;
</code></pre></div><p>If you try to return a value from a method thats declared <code>void</code>, you get a compiler error.</p> <p>Any method that isnt declared void must contain a return statement with a corresponding return value, like this:</p> <div class="language- extra-class"><pre class="language-text"><code>return returnValue;
</code></pre></div><p>The data type of <code>returnValue</code> must match the data type declared in the method signature.</p> <h3 id="method-name"><a href="https://book.techelevator.com/content/logical-branching-ool.html#method-name" class="header-anchor">#</a> Method name</h3> <p>The method name is a clear name indicating what type of action or calculation the method performs when invoked.
Its important that you write method names that clearly indicate to other programmers what the method does.</p> <p>In Java, method names are camel case, whereas C# methods are pascal case.</p> <h3 id="parameter-list"><a href="https://book.techelevator.com/content/logical-branching-ool.html#parameter-list" class="header-anchor">#</a> Parameter list</h3> <p>Parameters act like variables. They have a data type, a name, and their value can be obtained by using it in a code statement or expression. When you create a method, parameter lists indicate what inputs are required for the method to run.</p> <p>When writing method bodies, you dont necessarily know the values of the parameters like you do with variables. This is challenging because you have to think of the parameters as their data type without knowing their specific value. Consider the following method:</p> <div class="language- extra-class"><pre class="language-text"><code>public int MultiplyBy(int multiplicand, int multiplier) {
    int result = multiplicand * multiplier;

    return result;
}
</code></pre></div><p>This method indicates that it accepts two parameters and returns an integer. The first parameter acts as the multiplicand and the second, the multiplier.</p> <p>As youll see in later parts of the cohort, you invoke these methods by calling their name and passing in parameters.</p> <div class="language- extra-class"><pre class="language-text"><code>int output = MultiplyBy(3, 4);  //invokes MultiplyBy method. 3 is the multiplicand, 4 is multiplier
// ...
// ...
output = MultiplyBy(9, 2);      //invokes MultiplyBy method. 9 is the multiplicand, 2 is multiplier
</code></pre></div><p>Each time a program calls the <code>MultiplyBy</code> method, it <em>passes</em> values for the multiplicand and the multiplier. The <code>MultiplyBy</code> method uses those values to calculate a new result.</p></div> <footer class="page-edit"><!----> <!----></footer> <div class="page-nav"><p class="inner"><span class="prev">
      ?
      <a href="https://book.techelevator.com/content/introduction-to-programming-ool.html" class="prev">
        Introduction to Programming
      </a></span> <span class="next"><a href="https://book.techelevator.com/content/arrays-and-loops-ool.html" class="">
        Arrays and Loops
      </a>
      ?
    </span></p></div> </main></div><div class="global-ui"><!----></div></div>
    <script src="./Logical branching _ Student Book_files/app.08764f16.js.download" defer=""></script><script src="./Logical branching _ Student Book_files/2.fcd05e6e.js.download" defer=""></script><script src="./Logical branching _ Student Book_files/19.f646b03d.js.download" defer=""></script>
  

</body></html>');
INSERT INTO curriculum (course, date, lesson) VALUES

((SELECT id FROM course WHERE (name='Object Oriented Programming')), '12-25-2020', 
'<!DOCTYPE html>
<div class="nav-item"><a href="/" class="nav-link">
  Home
</a></div><div class="nav-item"><a href="/content/language.html" class="nav-link">
  Language
</a></div><div class="nav-item"><a href="/content/glossary.html" class="nav-link">
  Glossary
</a></div><div class="nav-item"><a href="https://techelevator.com" target="_blank" rel="noopener noreferrer" class="nav-link external">
  Tech Elevator
  <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" x="0px" y="0px" viewBox="0 0 100 100" width="15" height="15" class="icon outbound"><path fill="currentColor" d="M18.8,85.1h56l0,0c2.2,0,4-1.8,4-4v-32h-8v28h-48v-48h28v-8h-32l0,0c-2.2,0-4,1.8-4,4v56C14.8,83.3,16.6,85.1,18.8,85.1z"></path> <polygon fill="currentColor" points="45.7,48.7 51.3,54.3 77.2,28.5 77.2,37.2 85.2,37.2 85.2,14.9 62.8,14.9 62.8,22.9 71.5,22.9"></polygon></svg></a></div> <!----></nav></div></header> <div class="sidebar-mask"></div> <aside class="sidebar"><nav class="nav-links"><div class="nav-item"><a href="/" class="nav-link">
  Home
</a></div><div class="nav-item"><a href="/content/language.html" class="nav-link">
  Language
</a></div><div class="nav-item"><a href="/content/glossary.html" class="nav-link">
  Glossary
</a></div><div class="nav-item"><a href="https://techelevator.com" target="_blank" rel="noopener noreferrer" class="nav-link external">
  Tech Elevator
  <svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" x="0px" y="0px" viewBox="0 0 100 100" width="15" height="15" class="icon outbound"><path fill="currentColor" d="M18.8,85.1h56l0,0c2.2,0,4-1.8,4-4v-32h-8v28h-48v-48h28v-8h-32l0,0c-2.2,0-4,1.8-4,4v56C14.8,83.3,16.6,85.1,18.8,85.1z"></path> <polygon fill="currentColor" points="45.7,48.7 51.3,54.3 77.2,28.5 77.2,37.2 85.2,37.2 85.2,14.9 62.8,14.9 62.8,22.9 71.5,22.9"></polygon></svg></a></div> <!----></nav>  <ul class="sidebar-links"><li><a href="/" class="sidebar-link">Introduction</a></li><li><section class="sidebar-group collapsable depth-0"><p class="sidebar-heading open"><span>Module 1</span> <span class="arrow down"></span></p> <ul class="sidebar-links sidebar-group-items"><li><a href="/content/introduction-to-tools.html" class="sidebar-link">Introduction to Tools</a></li><li><a href="/content/introduction-to-programming-ool.html" class="sidebar-link">Introduction to Programming</a></li><li><a href="/content/logical-branching-ool.html" class="sidebar-link">Logical Branching</a></li><li><a href="/content/arrays-and-loops-ool.html" class="sidebar-link">Arrays and Loops</a></li><li><a href="/content/command-line-programs.html" class="sidebar-link">Building Command Line Programs</a></li><li><a href="/content/introduction-to-objects-ool.html" class="sidebar-link">Introduction to Objects</a></li><li><a href="/content/linear-data-structures-ool.html" class="sidebar-link">Collections: Part 1</a></li><li><a href="/content/non-linear-data-structures-ool.html" class="sidebar-link">Collections: Part 2</a></li><li><a href="/content/classes-encapsulation-ool.html" class="sidebar-link">Classes and Encapsulation</a></li><li><a href="/content/inheritance-ool.html" class="sidebar-link">Inheritance</a></li><li><a href="/content/polymorphism-ool.html" class="active sidebar-link">Polymorphism</a><ul class="sidebar-sub-headers"><li class="sidebar-sub-header"><a href="/content/polymorphism-ool.html#what-is-polymorphism" class="sidebar-link">What is polymorphism?</a></li><li class="sidebar-sub-header"><a href="/content/polymorphism-ool.html#polymorphism-and-inheritance" class="sidebar-link">Polymorphism and inheritance</a></li><li class="sidebar-sub-header"><a href="/content/polymorphism-ool.html#other-ways-of-polymorphism" class="sidebar-link">Other ways of polymorphism</a></li><li class="sidebar-sub-header"><a href="/content/polymorphism-ool.html#interfaces" class="sidebar-link">Interfaces</a></li><li class="sidebar-sub-header"><a href="/content/polymorphism-ool.html#building-a-real-application" class="sidebar-link">Building a real application</a></li></ul></li><li><a href="/content/unit-testing-ool.html" class="sidebar-link">Unit Testing</a></li><li><a href="/content/file-io-ool.html" class="sidebar-link">File I/O</a></li><li><a href="/content/exception-handling-ool.html" class="sidebar-link">Error Handling</a></li></ul></section></li><li><section class="sidebar-group collapsable depth-0"><p class="sidebar-heading"><span>Module 2</span> <span class="arrow right"></span></p> <!----></section></li><li><section class="sidebar-group collapsable depth-0"><p class="sidebar-heading"><span>Module 3</span> <span class="arrow right"></span></p> <!----></section></li><li><section class="sidebar-group collapsable depth-0"><p class="sidebar-heading"><span>After the Cohort</span> <span class="arrow right"></span></p> <!----></section></li></ul> </aside> <main class="page"> <div class="theme-default-content content__default"><h1 id="polymorphism"><a href="#polymorphism" class="header-anchor">#</a> Polymorphism</h1> <p>In this chapter, youll learn about the last principle of object-oriented programming: polymorphism.</p> <p>Specifically, youll learn about:</p> <ul><li>What polymorphism is and how its useful when writing software</li> <li>Where inheritance can help you write polymorphic code</li> <li>Interfaces and how they are used</li></ul> <h2 id="what-is-polymorphism"><a href="#what-is-polymorphism" class="header-anchor">#</a> What is polymorphism?</h2> <blockquote><p><em>The word polymorphism, derived from the Greek language, means &quot;the ability to have multiple forms.&quot;</em></p> <p><em>In object-oriented programming, polymorphism is the idea that something can be assigned a different meaning or usage based on its context. This specifically allows variables and objects to take on more than one form.</em></p></blockquote> <p>Heres an analogy to help you understand this term. Suppose someone told you, &quot;go to the store and buy your favorite food for dinner.&quot;</p> <p>What happens next depends on some context:</p> <ul><li>If the request were made to your 14 year-old self, itd consist of you riding your bike to the store and using the cash in your pocket to pay for a pizza and a 2-liter bottle of pop.</li> <li>As an adult, you might <em>drive to the store</em> and using the credit card in your wallet, pay for pecan chicken and pinot noir.</li></ul> <p>In both cases, the person making the request said the same thing: &quot;go to the store and buy your favorite food for dinner.&quot; However, the result differed depending on the subject receiving the request.</p> <hr> <p>Often, you want to write code that can make a basic request, and based on context, allow different behaviors to take place. You can write code once that refers to many different things.</p> <p>As youll see, polymorphism supports code extensibility. If you write polymorphic code, you have code that functions independent of the objects class type. This allows programmers to incorporate changes through new object types in the system without modifying existing code.</p> <h2 id="polymorphism-and-inheritance"><a href="#polymorphism-and-inheritance" class="header-anchor">#</a> Polymorphism and inheritance</h2> <p>Recall that in the last chapter, you added subclasses that inherit from the Clock class:</p> <div class="code-block"><!----></div> <div class="code-block"><!----></div> <p>Suppose you needed to create a Shopkeeper class whose responsibility is to reset all of the different clocks to 7 AM.</p> <div class="code-block"><!----></div> <div class="code-block"><!----></div> <p>Do you notice a <em>code smell</em> here? Youre adding a method for every type of Clock. Your code is <em>tightly coupled</em>. When you want to add a new Clock type, youll add a new SetTime method for it as well.</p> <div class="custom-block tip"><p class="custom-block-title">Code Smells</p> <p>A code smell is any symptom in the code of a program that possibly indicates there is a deeper problem, violation of fundamental design principles, or an impact to design quality. Here are some <a href="https://blog.codinghorror.com/code-smells/" target="_blank" rel="noopener noreferrer">common code smells<svg xmlns="http://www.w3.org/2000/svg" aria-hidden="true" x="0px" y="0px" viewBox="0 0 100 100" width="15" height="15" class="icon outbound"><path fill="currentColor" d="M18.8,85.1h56l0,0c2.2,0,4-1.8,4-4v-32h-8v28h-48v-48h28v-8h-32l0,0c-2.2,0-4,1.8-4,4v56C14.8,83.3,16.6,85.1,18.8,85.1z"></path> <polygon fill="currentColor" points="45.7,48.7 51.3,54.3 77.2,28.5 77.2,37.2 85.2,37.2 85.2,14.9 62.8,14.9 62.8,22.9 71.5,22.9"></polygon></svg></a>:</p> <ul><li>Duplicate code</li> <li>Conditional complexity</li> <li>Long methods</li></ul></div> <p><strong>Polymorphic code</strong> allows you to take advantage of the fact that your different clock classes—AlarmClock, GrandfatherClock, and CuckooClock—have an <em>is-a</em> relationship with a Clock.</p> <p>Given that AlarmClock, GrandfatherClock, and CuckooClock are subclasses of Clock, you can write a single function that accepts a reference to a Clock while allowing any class that inherits from it too.</p> <div class="code-block"><!----></div> <div class="code-block"><!----></div> <p>Now youve written <em>loosely-coupled code</em>. The ShopKeeper doesnt differentiate between the different clocks when it comes to setting time. Think about it—how many times have you said &quot;go reset that cuckoo clock to 7 oclock?&quot; Realistically, youre likely to point at the cuckoo clock and say &quot;go reset that clock to 7 oclock.&quot;</p> <p>The ShopKeeper class is now only dependent on Clock. If you add a new class that inherits from Clock, like a Watch, the code in your ShopKeeper class has no reason to change.</p> <div class="code-block"><!----></div> <div class="code-block"><!----></div> <div class="custom-block tip"><p class="custom-block-title">Polymorphism and Inheritance</p> <p>With respect to inheritance, polymorphism simply means <em>if B is a subclass of A and a function can accept A as a parameter, then it can also accept B</em>.</p></div> <h2 id="other-ways-of-polymorphism"><a href="#other-ways-of-polymorphism" class="header-anchor">#</a> Other ways of polymorphism</h2> <p>Say that you wanted your shopkeeper to be able to set an alarm. It doesnt make sense for them to set an alarm on a grandfather clock or a cuckoo clock, but it does make sense to set it on an alarm clock. While youre at it, you also need the shopkeeper to set the alarm on their phone.</p> <p>Youll add the method directly to the AlarmClock class since the alarm feature doesnt apply to all clocks. You also need a separate Phone class that has support for setting an alarm.</p> <div class="code-block"><!----></div> <div class="code-block"><!----></div> <p>When you add the ability for your Shopkeeper to set the alarm, you need to set up two separate methods again.</p> <div class="code-block"><!----></div> <div class="code-block"><!----></div> <p>This is similar to the situation you were in before. Neither of these classes appear to share anything in common other than the fact that they both can have an alarm set.</p> <div class="custom-block danger"><p class="custom-block-title">Dont Force Inheritance</p> <p>You might think adding inheritance is a quick fix to avoid duplicating code, but be careful. If you cant use the phrase &quot;is-a&quot; when talking about two different types, it isnt a good fit. It doesnt make sense to have Phone inherit from AlarmClock. You wouldnt say &quot;a phone <em>is an</em> alarm clock.&quot;</p></div> <p>In reality, you also interact with different objects based on <em>what they can do</em> and not <em>what they are</em>. With code, you can use something called an interface to indicate what a type can do and reference the object by that.</p> <h2 id="interfaces"><a href="#interfaces" class="header-anchor">#</a> Interfaces</h2> <p>In <span></span>, interfaces force each component to expose specific public members that can be used in a specific way. Interfaces provide you with a way to say what classes can do and as such are an alternative way to define an <em>is a</em> relationship.</p> <p>The code below shows how an interface is defined.</p> <div class="code-block"><!----></div> <div class="code-block"><!----></div> <p>Notice that in the definition of the interface, theres no implementation for the methods. Theres only a method signature, minus the access modifier. Thats what an interface is: a declaration of one or more public methods.</p> <p>After definition, interfaces are implemented by classes. Think of an interface as a contract. If a class wishes to implement an interface, it is required to agree and provide implementations for all methods defined by the interface. A class, if necessary, can implement more than one interface.</p> <div class="code-block"><!----></div> <div class="code-block"><!----></div> <div class="custom-block danger"><p class="custom-block-title">Interface Instantiation</p> <p>Interfaces dont get instantiated.</p></div> <p>Now that the interface has been defined, it is available as a data type that can be used to reference an existing object. In this sense, you can adjust the Shopkeeper class and eliminate the duplicate methods by programming the set alarm method against an interface and not the concrete classes.</p> <div class="code-block"><!----></div> <div class="code-block"><!----></div> <div class="custom-block tip"><p class="custom-block-title">Polymorphism &amp; Interfaces</p> <p>With respect to interfaces, polymorphism means <em>if B is a class that implements interface A and a function can accept A as a parameter, it can also accept B</em>.</p></div> <h2 id="building-a-real-application"><a href="#building-a-real-application" class="header-anchor">#</a> Building a real application</h2> <p>Now youll update the bookstore so that the code takes advantage of polymorphism when dealing with products of all different types.</p> <div class="code-block"><!----></div> <div class="code-block"><!----></div></div> <footer class="page-edit"><!----> <!----></footer> <div class="page-nav"><p class="inner"><span class="prev">
      ?
      <a href="/content/inheritance-ool.html" class="prev">
        Inheritance
      </a></span> <span class="next"><a href="/content/unit-testing-ool.html">
        Unit Testing
      </a>
      ?
    </span></p></div> </main></div><div class="global-ui"><!----></div></div>
    <script src="/assets/js/app.08764f16.js" defer></script><script src="/assets/js/2.fcd05e6e.js" defer></script><script src="/assets/js/75.e2f6694e.js" defer></script><script src="/assets/js/48.b7e745d7.js" defer></script><script src="/assets/js/50.542cd1ab.js" defer></script>
  </body>
</html>');


INSERT INTO curriculum (course, date, lesson) VALUES ((SELECT id FROM course WHERE (name='Sea as in Cnidarian: Spelling 101')), '12-25-2020', 
'Today I will just include a video to watch and discuss: With spelling, you always want to start with the fundamentals!

<div class="video">
        <iframe width="560" height="315" src="//www.youtube.com/embed/EgzHCuzVKb8" frameborder="0" allowfullscreen></iframe>
</div>
<div>I will soon add a homework for this lesson!</div>');
INSERT INTO curriculum (course, date, lesson) VALUES
((SELECT id FROM course WHERE (name='Math 241')), '12-26-2020', 
'You might think of integers as just ordinary numbers, like 3, -12, 17, 0, 7000, or -582 but many people do confuse them as whole numbers. 
Integers are a lot like whole numbers but they also contain their additive inverse and zero. (Note that zero is its own additive inverse.)[1] 
Hence we conclude that whole numbers are a branch or subset of Integers but no fractions and decimals allowed! 
Read this article to learn everything you need to know about adding and subtracting integers, or skip to the section you need help with.
<div>
<img id="image" src="https://www.wikihow.com/images/thumb/8/8b/Add-and-Subtract-Integers-Step-2-Version-3.jpg/aid278360-v4-728px-Add-and-Subtract-Integers-Step-2-Version-3.jpg" alt="this is what we will commonly refer to as a "number line"/>
</div>
<h2>STEP ONE</h1>
Understand what a number line is. Number lines turn basic math into something real and physical that you can see in front of you. By just using a few marks and some common sense, we can use them like calculators to add and subtract numbers.
<h2>STEP TWO</h2>
Draw a basic number line. Imagine or draw a straight, flat line. Make a mark near the middle of your line. Write a 0 or zero next to this mark.
Your math book might call this point the origin, since numbers originate (i.e. "start") from here.
<h2>STEP THREE</h2>
Draw two marks, one on each side of your zero. Write -1 next to the mark on the left and 1 next to the mark on the right. These are the integers closest to zero.
Do not worry about making the spacing perfect - as long as you are close enough that you can tell what it is supposed to mean, the number line will work.
The left side is the side at the beginning of a sentence.
<div>
<img id="image" src="https://www.wikihow.com/images/thumb/0/00/Add-and-Subtract-Integers-Step-4-Version-3.jpg/aid278360-v4-728px-Add-and-Subtract-Integers-Step-4-Version-3.jpg" alt="here is what your number line should look like after step three!"/>
</div>
Well, sorry to leave you with such a cliff hanger but we will have to come back to this next lesson :p ');
INSERT INTO curriculum (course, date, lesson) VALUES
((SELECT id FROM course WHERE (name='Math 241')), '12-27-2020', 
'Today, we will learn how to count to ten in Spanish, in two easy steps!
<h2>STEP ONE</h2>
Start by learning to count to 5. It may be easier for you to learn how to count to 10 (and beyond!) if you split the numbers into chunks. Memorizing shorter sequences is easier than trying to learn all the numbers at once. Repeat the words until you can say them without thinking.[2] [3]
Although not typically included in counting, you can say zero (0) in Spanish as cero (SAY-roh).
One (1) in Spanish is uno (OO-noh).
Two (2) in Spanish is dos (doss).
Three (3) in Spanish is tres (tress).
Four (4) in Spanish is cuatro (KWA-tro).
Five (5) in Spanish is cinco (SEEN-ko).
<h2>STEP TWO</h2>
Learn the numbers for 6 through 10. Once you have committed the Spanish words for numbers one through five to memory, you are ready to move on to the next set of numbers. Repeat the new numbers over and over until you know them as well as you know one through five.
You Learned five numbers in step one. For step two we will increase that rate of learning to . . . five more numbers. GOOD LUCK!
Six (6) in Spanish is seis (SAISS).
Seven (7) in Spanish is siete (SYE-te).
Eight (8) in Spanish is ocho (O-cho).
Nine (9) in Spanish is nueve (NWAI-be).
Ten (10) in Spanish is diez (DYESS).
<h3>STEP THREE</h2>
Practise, practise, practise!! Now that you are fluent, it is important to practise the language with anybody you can!');

INSERT INTO curriculum (course, date, lesson) VALUES
((SELECT id FROM course WHERE (name='Math 241')), '12-28-2020', 
'Lesson 3!
Properties of Set Operations
Just like we have mathematical laws saying that, for example x + y = y + x, there
are also similar laws for set operations. Here is a selection of the most commonly
used laws:
A ? A = A union is idempotent
A ? A = A intersection is idempotent
A.2 Set-Builder Notation 195
A ? B = B ? A union is commutative
A ? B = B ? A intersection is commutative
A ? (B ? C) = (A ? B) ? C union is associative
A ? (B ? C) = (A ? B) ? C intersection is associative
A ? (B ? C) = (A ? B) ? (A ? C) union distributes over intersection
A ? (B ? C) = (A ? B) ? (A ? C) intersection distributes over union
A ??= A the empty set is a unit element of union
A ??=? the empty set is a zero element of intersection
A ? B ? A ? B = B subset related to union
A ? B ? A ? B = A subset related to intersection
A ? B ? A \ B = ? subset related to set difference
A ? B ? B ? A ? A = B subset is antisymmetric
A ? B ? B ? C ? A ? C subset is transitive
A \ (B ? C) = (A \ B) \ C corresponds to x ? (y + z) = (x ? y) ? z
Since ? and ? are associative, we will often omit parentheses and write, e.g, A ?
B ? C or A ? B ? C.
A.2 Set-Builder Notation
We will often build a new set by selecting elements from other sets and doing operations on these elements. We use the very flexible set-builder notation for this.
A set builder has the form {e | p}, where e is an expression and p is a list of predicates separated by commas. Typically, p will contain predicates of the form x ? M,
which defines x to be any element of M. The set builder will evaluate the expression
e for all elements x of M that fulfills the other predicates in p and build a set of the
results. We read {e | p} as “the set of all elements of the form e where p holds”, or
just “e where p”. Some mathematical texts use a colon instead of a bar, i.e, writing
{e : p} instead of {e | p}.
A simple example is
{x3 | x ? {1, 2, 3, 4},x< 3}
which builds the set {13, 23}={1, 8}, as only the elements 1 and 2 from the set
{1, 2, 3, 4} fulfill the predicate x < 3.
We can take elements from more than one set, for example
{x + y | x ? {1, 2, 3}, y ? {1, 2, 3}, x<y}
which builds the set {1 + 2, 1 + 3, 2 + 3}={3, 4, 5}. We use all combinations of
elements from the two sets that fulfill the predicate.
We can separate the predicates in a set builder by ? or “and” instead of commas.
So the example above can, equivalently, be written as
{x + y | x ? {1, 2, 3}, y ? {1, 2, 3} and x<y}
196 Set Notation and Concepts
A.3 Sets of Sets
The elements of a set can be other sets, so we can, for example, have the set
{{1, 2}, {2, 3}} which is a set that has the two sets {1, 2} and {2, 3} as elements.
We can “flatten” a set of sets to a single set which is the union of the element sets
using the “big union” operator:
{{1, 2}, {2, 3}} = {1, 2, 3}
Similarly, we can take the intersection of the element sets using the “big intersection” operator:
{{1, 2}, {2, 3}} = {2}
We can use these “big” operators together with set builders, for example
{{xn | n ? {0, 1, 2}} | x ? {1, 2, 3}}
which evaluates to {{1}, {1, 2, 4}, {1, 3, 9}} = {1}.
When a big operator is used in combination with a set builder, a special abbreviated notation can be used: {e | p} and {e | p}can be written, respectively,
as

p
e and
p
e
For example,
{{xn | n ? {0, 1, 2}} | x ? {1, 2, 3}}
can be written as

x?{1, 2, 3}
{xn | n ? {0, 1, 2}}
A.4 Set Equations
Just like we can have equations where the variables represent numbers, we can have
equations where the variables represent sets. For example, we can write the equation
X = {x2 | x ? X}
This particular equation has several solutions, including X = {0}, X = ? and
X = {0, 1} or even X = [0, 1], where [0, 1] represents the interval of real numbers between 0 and 1. Usually, we have an implied universe of elements that the sets
can draw from. For example, if we only want sets of integers as solutions, we won’t
consider intervals of real numbers as valid solutions.
When there are more than one solution to a set equation, we are often interested
in a solution that has the minimum or maximum possible number of elements. In
A.4 Set Equations 197
the above example (assuming we want sets of integers), there is a unique minimal
(in terms of number of elements) solution, which is X = ? and a unique maximal
solution X = {0, 1}. Not all equations have unique minimal or maximal solutions.
For example, the equation
X = {1, 2, 3} \ X
has no solution at all, and the equation
X = {1, 2, 3}\{6/x | x ? X})
has exactly two solutions: X = {1, 2} and X = {1, 3}, so there are no unique minimal or maximal solutions.
A.4.1 Monotonic Set Functions
The set equations we have seen so far are of the form X = F(X), where F is a
function from sets to sets. A solution to such an equation is called a fixed-point
for F.
As we have seen, not all such equations have solutions, and when they do, there
are not always unique minimal or maximal solutions. We can, however, define a
property of the function F that guarantees a unique minimal and a unique maximal
solution to the equation X = F(X).
We say that a set function F is monotonic if X ? Y ? F(X) ? F(Y).
Theorem A.1 If we draw elements from a finite universe U and F is a monotonic
function over sets of elements from U, then there exist natural numbers m and n, so
the unique minimal solution to the equation X = F(X) is equal to F m(?) and the
unique maximal solution to the equation X = F(X) is equal to Fn(U).
Where Fi
(A) is F applied i times to A. For example, F3(A) = F(F(F(A))).
Proof It is trivially true that ? ? F(?). Since F is monotonic, this implies F(?) ?
F(F(?)). This again implies F(F(?)) ? F(F(F(?))) and, by induction, Fi
(?) ?
Fi+1(?). So we have a chain
? ? F(?) ? F(F(?)) ? F(F(F(?))) ?···
Since the universe U is finite, the sets Fi
(?) can not all be different. Hence, there
exist an m such that F m(?) = F m+1(?), which means X = F m(?) is a solution to
the equation X = F(X). To prove that it is the unique minimal solution, assume that
another solution A exist. Since A = F(A), we have A = F m(A). Since ? ? A and
F is monotonic, we have F m(?) ? F m(A) = A. This implies that F m(?) is a subset
of all solutions to the equation X = F(X), so there can not be a minimal solution
different from F m(?).
The proof for the maximal solution is left as an exercise.
198 Set Notation and Concepts
A.4.1.1 Fixed-Point Iteration
The proof provides an algorithm for finding minimal solutions to set equations of the
form X = F(X), where F is monotonic and the universe is finite: Simply compute
F(?), F2(?), F3(?) and so on until F m+1(?) = F m(?). This is easy to implement
on a computer:
X := ?;
repeat
Y := X;
X := F(X)
until X = Y;
return X
A.4.2 Distributive Functions
A function can have a stronger property than being monotonic: A function F is
distributive if F(X ? Y) = F(X) ? F(Y) for all sets X and Y . This clearly implies
monotonicity, as Y ? X ? Y = X ? Y ? F(Y) = F(X ? Y) = F(X) ? F(Y) ?
F(X).
We also solve set equations over distributive functions with fixed-point iteration,
but we exploit the distributivity to reduce the amount of computation we must do: If
we need to compute F(A ? B) and we have already computed F(A), then we need
only compute F(B) and add the elements from this to F(A). We can implement an
algorithm for finding the minimal solution that exploits this:
X := ?;
W := F(?);
while W 
= ? do
pick x ? W;
W := W\{x};
X := X ? {x};
W := W ? (F({x})\X);
return X
We keep a work set W that by invariant is equal to F(X) \ X. A solution must include
any x ? W, so we move this from W to X while keeping the invariant by adding
F(x) \ X to W. When W becomes empty, we have F(X) = X and, hence, a solution.
While the algorithm is more complex than the simple fixed-point algorithm, we can
compute F one element at a time and we avoid computing F twice for the same
element.
Exercises 199
A.4.3 Simultaneous Equations
We sometimes need to solve several simultaneous set equations:
X1 = F1(X1,...,Xn)
.
.
.
Xn = Fn(X1,...,Xn)
If all the Fi are monotonic in all arguments, we can solve these equations using
fixed-point iteration. To find the unique minimal solution, start with Xi = ? for
i = 1 ...n and then iterate applying all Fi until a fixed-point is reached. The order
in which we do this doesn’t change the solution we find (it will always be the unique
minimal solution), but it might affect how fast we find the solution. Generally, we
need only recompute Xi if a variable used by Fi changes.
If all Fi are distributive in all arguments, we can use a work-set algorithm similar
to the algorithm for a single distributive function.
Exercises
Exercise A.2 What set is built by the set builder
{x2 + y2 | x ? {1, 2, 3, 4}, y ? {1, 2, 3, 4}, x<y2} ?
Exercise A.3 What set is built by the set expression

x?{1, 2, 3}
{xn | n ? {0, 1, 2}} ?
Exercise A.4 Find all solutions to the equation
X = {1, 2, 3}\{x + 1 | x ? X})
Hint: Any solution must be a subset of {1, 2, 3}, so you can simply try using all the
eight possible subsets of {1, 2, 3} as X and see for which the equation holds.
Exercise A.5 Prove that if elements are drawn from a finite universe U and F is a
monotonic function over sets of elements from U, then there exists an n such that
X = Fn(U) is the unique maximal solution to the set equation X = F(X).');


INSERT INTO curriculum (course, date, lesson) VALUES
((SELECT id FROM course WHERE (name='Relational Databases')), '12-24-2020', 
'The Cas? <s>for</s> AGAI?S? RDBMS in the Age of NoSQL Solutions
THE CASE FOR RDBMS IN THE AGE OF NOSQL SOLUTIONS -- 1
The traditional Relational Database Management Systems (RDBMS), and the relational database model (RDM) it supports, 
does not receive the attention it once did; the demand for horizontally scaling database solutions in the age of big data has 
driven the adoption of newer technologies. However, the relational database model still serves a vital role in business and 
financial systems where the need for a high volume of small transactions meeting the ACID standard and polymorphic aggregation is a primary concern.
While RDBMS solutions may still dominate in the market in enterprise software, the shift from fully hosted client-server and n-tier solutions towards 
web-enabled solutions relying on application programming interfaces (APIs) has seen a shift in focus away from the RDM. Some of this shift away from 
RDM can be attributed to the adoption of the Application Programming Interface (API) model of software engineering, which was enabled by the proliferation 
of the internet in business through Software as a service (SaaS) solutions. While an additional impetus to move away from RDM be attributed to a growth 
in demand for analytics to support the large volume of non-structured data generated by users of on-line services such as Alphabet’s Google search engine, 
Amazon’s Alexa, andFacebook’s namesake social media platform (Rana, et al., 2017).To understand the enduring use case for the RDM, it is necessary to understand 
the leading non-SQL (NoSQL) models and their applications. The first NoSQL model to consider, in use across web APIs, is the Document Database Model (DDM). 
The DDM relies on a Key-Value Pair (KVP) to store a primary key value associated with a JavaScript Object Notation (JSON) document object (MongoDB, 2020). Self-documenting, the JSON document does not require a formal schema nor the requisite relationship management of the RDM. 
This document-based entity definition gives the DDM an advantage over the RDM as web APIs and their clients are not required to adhere to a strict schema model or have knowledge of the underlying 
relationships (Davidson & Moss, 2016).Instead, the JSON document is a self-contained representation of the requested record and any children 
associated with it as required and provided by the systems in question. In DDM solutions, the goal is not to provide large scale 
set-based operations as in the RDM, rather it is meant to provide high-speed and high-volume processing of results that may be scaled horizontally across 
servers without the need to re-spec hardware vertically (Davidson & Moss, 2016; MongoDB, 2020). Next to consider is the Object-Oriented Database Model (OODM). 
OODM solutions enhance the schema independence of the DDM by adding native support for Object-Oriented Programming principles of polymorphism, inheritance, 
and encapsulation within the data structures.  Because OODM solutions allow for highly complex modeling of both logical, in definition, and physical, 
in instantiation, data objects, they are especially well suited for engineering and manufacturing solutions where the complexity and abstraction of 
the underlying model is a primary concern in exchange for a moderate transactional capacity (DoD Data & Analysis Center for Software (DACS), 1999). 
This quality of OOP inherent in the OODM allows for abstract and rapid development of evolving data models and solutions much in the same way inheritance 
and abstraction provide contracts of behavior within programming languages such as C-Sharp and Java. Again, as with the ODM, the rigid nature of the RDM’s 
relationships and schema definitions does not allow for such extensible and dynamic data structures.The final model to consider when trying to understand the 
case for RDBMS does not follow the conceptual evolution of the DDM to the OODM. Instead, the Graph Database Model (GDM) extends data-retrieval beyond the entity 
tuple collection to include the relationships between records. In this way, the GDM can be both analytical and relational at the same time by allowing direct access 
to data edge cases as well as the underlying records (Vázquez, 2019). This property of the GDM allows for the assignment of meta-data to, and the analysis and visualization of, 
complex relationships independently of their underlying data structures.');
INSERT INTO curriculum (course, date, lesson) VALUES
((SELECT id FROM course WHERE (name='Relational Databases')), '12-25-2020', 
'THE CASE FOR RDBMS IN THE AGE OF NOSQL SOLUTIONS -- 3
applications that range from marketing to machine learning, 
the GDM provides a level of insight into the data and how that data relates to other unique pieces data that the fixed schema-bound relationships of the 
RDM cannot provide.The schema independence of the DDM and OODM provides a great deal of efficiency and flexibility in both the design of solutions and the 
infrastructure to support them. The ability to query and analyze the relationships between data entities and facts allows the GDM to extend the usefulness 
of data beyond simple retrieval. Together, they each shift thefocus of database engineers away from the strict modeling of physical entities within the schema 
towards the needs of the end-user or API endpoint. However, it is that flexibility and shift in focus that leaves the RDM and RDBMS firmly entrenched in 
the enterprise and financial system landscape.In these systems, strict adherence to business, statutory, and procedural models with high-volume set-based 
transactions must occur following ACID principles while allowing for hierarchical and dynamic aggregation of normalized data to meet system demands. In these cases, 
the RDM and RDBMS are still the solution of choice and remain a persistent pattern for the foreseeable future.<REMAINING EDITS PENDING TO EXPAND ON RDBMS>
References:
Chowdhury, S. (2019, July 18). KnowledgeGraph: The Perfect Complement to Machine Learning. Retrieved from Towards Data Science: 
https://towardsdatascience.com/knowledge-graph-bb78055a7884Davidson, L., & Moss, J. (2016). Pro SQL Server Relational Database Design and 
Implementation(5th ed.). New York: Apress. doi:10.1007/978-1-4842-1973-7DoD Data & Analysis Center for Software (DACS). (1999, January 31). 
Object-Oriented Database Management: An Updated DACS State-of-the-Art Report.Retrieved from https://www.csiac.org/: 
https://www.csiac.org/wp-content/uploads/2016/02/Object-Oriented-Database-Mgmt-Systems-Revisited-SOAR.pdfMongoDB. (2020). MongoDB Document Databases. 
Retrieved from MongoDB: https://www.mongodb.com/document-databasesRana, A., Srinivasan, A., Waral, J., Singh, M., Handraha, S., & Noselli, C. (2017, October 6). 
A new era: Artificial intelligence is now the biggest tech disrupter. Retrieved from Bloomberg Professional Services: 
https://www.bloomberg.com/professional/blog/new-era-artificial-intelligence-now-biggest-tech-disrupter/Vázquez, F. (2019, January 22). Graph Databases. 
What’s the Big Deal?Retrieved from Towards Data Science: https://towardsdatascience.com/graph-databases-whats-the-big-deal-ec310b1bc0ed');


INSERT INTO curriculum (course, date, lesson) VALUES
((SELECT id FROM course WHERE (name='Relational Databases')), '12-28-2020', 
'In 1869, a very large musical celebration took place in Boston, Massachusetts. The National
Peace Jubilee, as it was called, was a gathering of some 11,000 singers from some 100 choral
groups with over a thousand-piece orchestra section. It was then proclaimed to be the
“greatest musical enterprise of modern times.” If that wasn’t quite true, it was still one of the
largest gatherings to showcase a distinct blend of celebratory patriotism and spiritual
revelation. Spectacles such as the “anvil chorus,” which swung one hundred anvils in unison,
reportedly “gave an impression of sublimity more than noise.”2 The massive, sprawling
History of the National Peace Jubilee text referred to the crowd as solemn and oceanic. Fitted
especially for the occasion, its custom-built pipe organ delivered music of “thunderous”
quality. The music amidst the crowds was described as an overwhelming force of divine
power, but also one that invoked storms and madness. Yet the experience was also
perceived by some as a let-down. Despite cannons exploding on cue with the music, as well
as thousands of voices singing to note and anvils clamoring in unison, to some visitors it
was a disappointment of the promise of transcendental power that was not achieved. One
reviewer in attendance remarked on this underwhelming power:
And now rises such a volume of sound as never before greeted
human ears. It has a mystic puissance that cannot be analyzed. Its
extended source destroys the sense of locality. It fills the air with
its new vibrations that bring to us a novel emotion of universality.
It mounts with a grandeur that gives us a new sensation. There are
no favored registers heard, no individual voices; everything
personal, trivial, local, is drowned out in the majestic flow of this
grand chorus. Having felt the first effects of the combination,
having remarked that they have touched the auditory with the new
potency, as the ear becomes accustomed to the surging and
swelling of the tide, we become, too, calm enough to perceive that
it is not the bulk of the sound that is effective; indeed, a very
general disappointment was felt that the united forces produced no
louder music. People had expected a concussion of the air; they
were surprised that the building did not tremble and that the music
could not be heard four or five squares off. They found that in the
ratio of size there was new smoothness, a new solemnity; instead
of being volcanic, it was aerial. They were disappointed in the
loudness, but moved by the majesty.
almost religious character, exalted, pompous and impressive.”4 Another seeking sonic power
was the 17th century Jesuit scholar Athanasius Kircher, one of two people claimed to have
invented the technology of the megaphone. His “tuba stentorophonica” was described in his
publication Phonurgia Nova as a “trumpet with a strong sound” that purportedly had
significant sound emission potential. Kircher’s other interesting work involved the
implementation of acoustic signaling that served as an early system prototype for very fast
network communication.5
 The phenomenon of loud sound was tied up with the possibility
of transcending distance by acoustic force. Through networks of acoustic signaling,
messages could be carried over hundreds of kilometers in just minutes instead of the wilting
lag of ground-based message carriers.
The power of loud sound was appealing for many reasons, be it narcotic,
communicative, or musical. To return for a moment to the expressions of disappointment at
the perceived insufficiencies of the 1869 Jubilee, this thesis picks up on the perception of
lack expressed above. In the image shown in Figure 2, in which the faces in the sky blow
downward into a funnel attached to the festival building, reveals a snapshot of how acoustic
power was characterized by the dreamers involved in the series of Jubilees: the wind of the
heavens which could be channeled into acoustic force. This study charts the transformation
and escalation of that characterization from the romantic wind of the divine to an electromechanical 
force capable of nefarious results. The Jubilee organizers intuited that the power
of sound was not what it could be. Celebrations could be louder. Music could have more
impact. The walls could shake more. Sound could travel farther. This document dedicates
over two hundred pages to the inquiry of this almost mystic quest.
Figure 3. Acoustic Network Signaling in Kirchers Phonurgia Nova (1673 Facsimile)
The Megaphonic
This thesis is primarily interested in examining the question of “megaphonics” roughly
between 1880 and 1930. That is to say it is interested in examining the curiosity, the
obsessions, and the dread surrounding the possibility of loud sound as a productive and
material force. Throughout this study, the term “megaphonics” will be employed to refer to
sound intensity and the perception of that sonic intensity, loudness. “Megaphonics” has
greater precision than the oft-utilized term “noise” which will still be used in limited
contexts when appropriate. The term “megaphonics” was once used by scholar Steven
Connor as a title of a radio essay largely ruminating on the poetics of noise, yet he actually 
14
didn’t use the term in substance.
6 “Megaphonics” has Greek roots in ph?n?, largely denoting
the voice. To shift the discussion surrounding loud sound away from “noise” and towards
the rubric of megaphonics, I seek to open a space for inquiry at a breathable distance from
academic discourse on noise as unwanted sound. Gunpowder, foghorns, and pipe organs
will all be portrayed as megaphonic technologies rather than social blights. In the same light,
massive explosions, infernal organ concerts, and supremely-powered nautical signalling can
all be said to yield megaphonic affect. Megaphonics, for the purposes of this dissertation, are
that which present sound intensity as a productive force.
In discussing megaphonics it is important to delineate “sound intensity” from
“loudness.” “Intensity” is an objective, measurable reading of the power of acoustic
phenomena whereas “loudness” is a subjective and internal experience of external acoustic
phenomena. They do not always necessarily correspond: "Intensity”, notes Greg Milner, “is
what makes our eardrums vibrate, but when those vibrations are translated into electrical
impulses in the cochlea and sent to the brain, the magic of psychoacoustics takes over…
intensity is correlated with what happens outside our ears, but loudness exists only inside
our heads."7 Loudness will generally mean to be the quality of a sound that is essentially a
psychological correlate of physical sound intensity. It is a subjective term through and
through. It suggests the perception of abundance.
Though this dissertation is essentially a cultural history of megaphonics, a separate
history could be conducted on the varying associations with the term “loudness.” For
Hermann von Helmholtz, loudness was the actual physical process of the excitement of a
large area of the basilar membrane in the human ear. Each string or fiber of the membrane
was attuned to a particular frequency of sound wave. A sensation of loudness was produced
when an increased number of fibers were activated: greater the number of fibers activated,
greater would be the experience of sound wave intensity.8 This discussion will be carried
further on in chapter 3, which deals with shock wave theory, the work of Ernst Mach, and
the domain of psychophysics.
There is considerable back-and-forth between the psychological experience of loudness
and the physical process of heavy acoustic wave propagation. However, these terms have
often been used interchangeably and this work on megaphonics recognizes an inherent
degree of slipperiness between the two. “Loudness” can be used to mean intensity. This
study deals with technologies of sound intensity –– pipe organs, foghorns, electrical
amplification and explosions –– in light of both senses of the term, but also the effect of
that intense (or what I often call loud) sound: immersion, dissolution of subjectivity,
experiences of the sublime, transcendentalism, and sensory transmutation. Psychophysics
weighs important in this discussion, as the human experience of loudness also points to the
temporary obliteration of the distinction between inside and out, that of external reality and
the internal psyche.
A strictly external, physical measure of sound intensity is a difficult phenomenon to
objectively measure and quantify. It almost evades metrics. The genesis of the current metric
of sound intensity, the decibel (dB), points to the historical inseparability between loud
sound and early networks of long-distance communication. In the 1920s, researchers at Bell
Telephone Labs were attempting to measure the amount of decay in signals over long
distances of telephone wire. In comparing the power of the input signal to the power of the
output signal, they created a new unit of measure, which was named the “bel” in honor of
Alexander Graham Bell.9 As a standard unit for comparative sound level, it measures the
ratio between two sound intensities. Thus, standard measurements of sound intensity utilize
a relative rather than absolute value. Other metrics exist in an effort to more objectively
measure intensity, but the most ubiquitous one is far from objective. Not only are metrics
for loudness and intensity for the most part relational, the actual experience of loudness also
varies based on tonality. Another seminal piece of work from the Bell Labs from Fletcher
and Munson in 1933, showed that low-frequency sounds are perceived to have a greater
intensity than high-frequency sounds.10 For example, a 1,000Hz tone at 50dB sounds as loud
as a 100Hz tone at 60dB. This discrepancy decreases with increased intensity.11 The history
of acoustic measurement is rife with competing units of measurement, such as the “phon”,
the “sone” or the “wien” and unresolved debates regarding the use of those units raged until
an eventual standardization.12
Part of the work that took place at the Bell Labs during this fruitful period was
dedicated to the science of sound, including work on sonic amplification. Amplification is
the process of making an acoustic signal louder, most commonly through processes of
electrical enhancement. Not only is this the act of megaphonic sound generation by making
something louder, but it is also the rendering of the unheard into the heard. The
achievements of making atoms and electrons audible to the human ear was first reported in
a December, 1924 edition of Science News-Letter. Later, General Electrics laboratory reported
making electrons able to be heard through a “hundred-thousand fold” amplification via
vacuum tube radio amplifiers: "The rain-like blows of many electrons on the plate of the
tube produced a roar that sounded like Niagara in the distance."13
The seduction of amplification was also an interest of the symphonic concert world.
Using the power of amplification and the relay capabilities of telephone lines, 
a Stokowskiconducted performance of Wagners work was given greater range, both in terms of
dynamics and actual physical distance:
Wagnerian music was played with whispering pianissimi and
thunderous crescendos hitherto unheard by human ears. Stokowski
by the turn of a control knob could subdue his orchestra, isolated in
another part of the theater, to a mere trickle of sound or he could
build up their music to the sound of two thousand musicians at a
peak of output.
The idea of taking of one of the great, most emphatically loud pieces ever composed in the
classical canon and broadcasting it, while giving the conductor control over the volume
knob instead of a baton, is an emblematic act of the megaphonic imagination at work. It was
also an intersection between telephone technics and musical megaphonics. Seductions of
sonic powers were widespread. This history of megaphonics covers an era of crowds
seduced by electronic loudspeaker amplification, of dreamers who built the world’s loudest
and largest musical instrument ever made, and philosopher-scientists who built contraptions
to freeze shock-waves as photographic proof of the materiality of invisible waves.
This thesis is not specifically a study of technologies of loud sound propagation nor is
it an examination of its related scientific fields. It is much more a cultural cartography of
idealist and utopian approaches to the power of sound at a time when sound was seen to be
infinitely capable, technologically unbounded, and even mortally dangerous. Specifically, it
examines instances between 1880-1930 where loud sound was viewed as having a generative
or productive power. This productivity was the belief in the power of loud sound as an
agent of transcendence, otherworldliness, safe navigation, hysteria or even death. A history
of megaphonics such as this is not a triumphalist narrative of the immense march of
technology and culture upwards and onwards. It is a snapshot of a rogue consensus that
proposed, albeit for a prolonged moment, the near-limitless nature of acoustic intensity. It is
the documentation of an arc whereby sound’s limits were circumscribed: be it in the
eventual diminution of public interest in live organ concerts before the dawn of recorded
media, or the end of the belief in foghorn trustworthiness at the moment radar navigation
was adopted. This era also points forward towards developments as wide-ranging as the
deployment of acoustic weaponry to the loudness wars in music production.
As noted, this dissertation will primarily focus on a 50-year period between 1880-1930.
The rationale for this periodization is multi-pronged. This era was the period in which an
interest in the power of loud sound formed and took hold across a broad set of domains
and instances. It was not the genesis of interest in megaphonics per se, but a catalytic epoch
where its tenets began to matter significantly for domains as wide as musical expression,
nautical communication, psychology and medicine. This emergence of an interest in
loudness occurred, not surprisingly, alongside modern approaches to noise abatement.
Significant historical work has been done regarding quests to eradicate “unnecessary noise”
but little focus has been given to those who were seduced by its apparent wide-spanning
possibilities.15 Lastly, this timeframe allows for the study of megaphonics to dovetail against
one standard periodization of “modernity”, and thus engage with numerous claims pertinent
to the subject including Gustav Le Bon’s argument that modernity was “the era of crowds”,
Emily Thompson’s qualitative assertions around the “modern sound”, and Hillel Schwartz’s
claims about noise being essentially constitutive of modernity’s “essence”.16 Yet also
quintessentially “modern”, for example, is the brutal reality of early twentieth-century
mechanized warfare. The characterization of the apocalyptic clamor of modern warfare
captures one aspect of the megaphonic sublime through the writing of Ernst Junger:
Ahead of us rumbled and thundered artillery fire of a volume we
had never dreamed of, a thousand quivering lightnings bathed the
western horizon in a sea of flame. A continual stream of wounded,
with pale, sunken faces, made their way back, often barged aside by
clattering guns or munitions columns heading the other way.17
Junger’s work suggests a battlefield landscape of death that was also a miserable world of
sonic shock. ');





INSERT INTO assignment (name, description, created_date, due_date, questions, course) VALUES
( 'Fundamentals 1' , ' This assignment will help practise addition, subtraction, multiplication, and division!' ,
'12-09-2020', '12-15-2020', 5, (SELECT id FROM course WHERE name='Math 241'));
--teachers: useruser10, useruser11 
--students: student,UU3,UU4,UU6,UU8,UU17
--ASSIGNMENT - Fundamentals 1 -- QUESTIONS (All text)
INSERT INTO question (assignment, number, type, statement) VALUES 
((SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 1, 'text', '5 + 3 = ?'),
((SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 2, 'text', '17 - 2 = ?'),
((SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 3, 'text', '5 * 5 = ?'),
((SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 4, 'text', '5 + ? = 3'),
((SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 5, 'text', '16 - 5 + ? = 14');
--Fundamentals 1 , question 1
INSERT INTO answer (student, assignment, question, answer) VALUES 
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 1, '8'), 
--student+1
((SELECT user_id FROM users WHERE username = 'useruser3'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 1, '6'),
((SELECT user_id FROM users WHERE username = 'useruser4'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 1, '2'),
((SELECT user_id FROM users WHERE username = 'useruser6'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 1, 'eight'),
((SELECT user_id FROM users WHERE username = 'useruser8'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 1, '8'),
--UU8+1
((SELECT user_id FROM users WHERE username = 'useruser17'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 1, '90');
--Fundamentals 1 , question 2
INSERT INTO answer (student, assignment, question, answer) VALUES 
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 2, '15'),
--student+1
((SELECT user_id FROM users WHERE username = 'useruser3'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 2, '14'),
((SELECT user_id FROM users WHERE username = 'useruser4'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 2, '15'),
--UU4+1
((SELECT user_id FROM users WHERE username = 'useruser6'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 2, ' 16'),
((SELECT user_id FROM users WHERE username = 'useruser8'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 2, ' 15'),
--UU8+1
((SELECT user_id FROM users WHERE username = 'useruser17'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 2, ' 14');
--Fundamentals 1 , question 3
INSERT INTO answer (student, assignment, question, answer) VALUES 
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 3, '25'),
--student+1
((SELECT user_id FROM users WHERE username = 'useruser3'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 3, '23'),
((SELECT user_id FROM users WHERE username = 'useruser4'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 3, '2'),
((SELECT user_id FROM users WHERE username = 'useruser6'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 3, ' 25'),
--UU6+1
((SELECT user_id FROM users WHERE username = 'useruser8'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 3, '25'),
--UU8+1
((SELECT user_id FROM users WHERE username = 'useruser17'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 3, '26');
--Fundamentals 1 , question 4
INSERT INTO answer (student, assignment, question, answer) VALUES 
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 4, '3'),
((SELECT user_id FROM users WHERE username = 'useruser3'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 4, '-2'),
--UU3+1
((SELECT user_id FROM users WHERE username = 'useruser4'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 4, '2'),
((SELECT user_id FROM users WHERE username = 'useruser6'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 4, 'eight'),
((SELECT user_id FROM users WHERE username = 'useruser8'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 4, '-2'),
--UU8+1
((SELECT user_id FROM users WHERE username = 'useruser17'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 4, '-02');
--UU17+1
--Fundamentals 1 , question 5
INSERT INTO answer (student, assignment, question, answer) VALUES 
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 5, '3'),
--student+1
((SELECT user_id FROM users WHERE username = 'useruser3'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 5, ' 3 '),
--UU3+1
((SELECT user_id FROM users WHERE username = 'useruser4'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 5, '3'),
--UU4+1
((SELECT user_id FROM users WHERE username = 'useruser6'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 5, '3t'),
((SELECT user_id FROM users WHERE username = 'useruser8'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 5, ' 3'),
--UU8+1
((SELECT user_id FROM users WHERE username = 'useruser17'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), 5, '4');

INSERT into mcchoice (assignment, question, choice, answer, correct) VALUES
((SELECT id FROM assignment WHERE name = 'Fundamentals 1'),1,1,'8',TRUE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 1'),1,2,'eight',TRUE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 1'),1,3,' 8 ',TRUE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 1'),2,1,'15',TRUE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 1'),3,1,'25',TRUE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 1'),4,1,'-2',TRUE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 1'),5,1,'3',TRUE);

--teachers: useruser10, useruser11 
--students: student,UU3,UU4,UU6,UU8,UU17
--ASSIGNMENT - Fundamentals 2 -- QUESTIONS (All multiple choice -- actual questions are identical to Fundamentals 1)
INSERT INTO assignment (name, description, created_date, due_date, questions, course) VALUES
( 'Fundamentals 2' , ' In this assignment we will continue to practise addition, subtraction, multiplication, and division!' ,
'12-17-2020', '12-25-2020', 5, (SELECT id FROM course WHERE name='Math 241'));
INSERT INTO question (assignment, number, type, statement) VALUES 
((SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 1, 'mc', '15 - 15 = ? * ( 16 + 42 )'),
((SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 2, 'mc', '9 = ?² '),
((SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 3, 'mc', '16 + 16 =  ?'),
((SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 4, 'mc', '1 + 1 + 1(14 + 5) = ?'),
((SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 5, 'mc', '22 = 6 + ?²');
--Fundamentals 2 , question 1, answer - A
INSERT INTO answer (student, assignment, question, answer) VALUES 
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 1, 'A'),
((SELECT user_id FROM users WHERE username = 'useruser3'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 1, 'A'),
((SELECT user_id FROM users WHERE username = 'useruser4'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 1, 'B'),
((SELECT user_id FROM users WHERE username = 'useruser6'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 1, 'C'),
((SELECT user_id FROM users WHERE username = 'useruser8'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 1, 'A'),
((SELECT user_id FROM users WHERE username = 'useruser17'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 1, 'A');
--Fundamentals 2 , question 2, answer - C
INSERT INTO answer (student, assignment, question, answer) VALUES 
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 2, 'D'),
((SELECT user_id FROM users WHERE username = 'useruser3'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 2, 'C'),
((SELECT user_id FROM users WHERE username = 'useruser4'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 2, 'A'),
((SELECT user_id FROM users WHERE username = 'useruser6'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 2, 'D'),
((SELECT user_id FROM users WHERE username = 'useruser8'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 2, 'B'),
((SELECT user_id FROM users WHERE username = 'useruser17'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 2, 'D');
--Fundamentals 2 , question 3 , answer B
INSERT INTO answer (student, assignment, question, answer) VALUES 
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 3, 'B'),
((SELECT user_id FROM users WHERE username = 'useruser3'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 3, 'A'),
((SELECT user_id FROM users WHERE username = 'useruser4'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 3, 'D'),
((SELECT user_id FROM users WHERE username = 'useruser6'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 3, 'C'),
((SELECT user_id FROM users WHERE username = 'useruser8'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 3, 'B'),
((SELECT user_id FROM users WHERE username = 'useruser17'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 3, 'B');
--Fundamentals 2 , question 4, answer C
INSERT INTO answer (student, assignment, question, answer) VALUES 
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 4, 'C'),
((SELECT user_id FROM users WHERE username = 'useruser3'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 4, 'D'),
((SELECT user_id FROM users WHERE username = 'useruser4'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 4, 'C'),
((SELECT user_id FROM users WHERE username = 'useruser6'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 4, 'E'),
((SELECT user_id FROM users WHERE username = 'useruser8'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 4, 'asdfwef'),
((SELECT user_id FROM users WHERE username = 'useruser17'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 4, 'C');
--Fundamentals 2 , question 5, answer D
INSERT INTO answer (student, assignment, question, answer) VALUES 
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 5, 'A'),
((SELECT user_id FROM users WHERE username = 'useruser3'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 5, 'D'),
((SELECT user_id FROM users WHERE username = 'useruser4'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 5, 'D'),
((SELECT user_id FROM users WHERE username = 'useruser6'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 5, 'A'),
((SELECT user_id FROM users WHERE username = 'useruser8'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 5, 'bee'),
((SELECT user_id FROM users WHERE username = 'useruser17'), (SELECT id FROM assignment WHERE name = 'Fundamentals 2'), 5, 'D');

INSERT into mcchoice (assignment, question, choice, answer, correct) VALUES
((SELECT id FROM assignment WHERE name = 'Fundamentals 2'),1,1,'A',TRUE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 2'),1,2,'B',FALSE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 2'),1,3,'C',FALSE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 2'),1,4,'D',FALSE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 2'),2,1,'A',FALSE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 2'),2,2,'B',FALSE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 2'),2,3,'C',TRUE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 2'),2,4,'D',FALSE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 2'),3,1,'A',FALSE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 2'),3,2,'B',TRUE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 2'),3,3,'C',FALSE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 2'),3,4,'D',FALSE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 2'),4,1,'A',FALSE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 2'),4,2,'B',FALSE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 2'),4,3,'C',TRUE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 2'),4,4,'D',FALSE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 2'),5,1,'A',FALSE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 2'),5,2,'B',FALSE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 2'),5,3,'C',FALSE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 2'),5,4,'D',TRUE);


INSERT INTO assignment (name, description, created_date, due_date, questions, course) VALUES
( 'Fundamentals 3' , ' Yet another assignment!' ,
'12-18-2020', '12-31-2020', 5, (SELECT id FROM course WHERE name='Math 241'));
--teachers: useruser10, useruser11 
--students: student ,UU3,UU4,UU6,UU8,UU17
--ASSIGNMENT - Fundamentals 3 -- QUESTIONS (All text)
INSERT INTO question (assignment, number, type, statement) VALUES 
((SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 1, 'text', 'Spell "vuejs"'),
((SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 2, 'text', 'Again! (spell "vuejs")'),
((SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 3, 'text', 'Does SQL have anything to do with lentil soup?'),
((SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 4, 'text', 'Can you run that word by me, one last time: "vue.js"? Thanks.'),
((SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 5, 'text', 'Is it easy to create online tests?');
INSERT INTO answer (student, assignment, question, answer) VALUES 
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 1, 'vuejs'),
((SELECT user_id FROM users WHERE username = 'useruser3'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 1, 'vue.js'),
((SELECT user_id FROM users WHERE username = 'useruser4'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 1, '"vue.js"'),
((SELECT user_id FROM users WHERE username = 'useruser6'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 1, 'vuejs'),
((SELECT user_id FROM users WHERE username = 'useruser8'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 1, 'VUEJS'),
((SELECT user_id FROM users WHERE username = 'useruser17'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 1, 'vue');
INSERT INTO answer (student, assignment, question, answer) VALUES 
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 2, 'vuejs'),
((SELECT user_id FROM users WHERE username = 'useruser3'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 2, 'vue.js'),
((SELECT user_id FROM users WHERE username = 'useruser4'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 2, '"vue.js"'),
((SELECT user_id FROM users WHERE username = 'useruser6'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 2, 'vuejs'),
((SELECT user_id FROM users WHERE username = 'useruser8'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 2, 'VUEJS'),
((SELECT user_id FROM users WHERE username = 'useruser17'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 2, 'vue');
INSERT INTO answer (student, assignment, question, answer) VALUES 
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 3, 'no'),
((SELECT user_id FROM users WHERE username = 'useruser3'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 3, 'Im not sure'),
((SELECT user_id FROM users WHERE username = 'useruser4'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 3, 'no'),
((SELECT user_id FROM users WHERE username = 'useruser6'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 3, 'YES!!'),
((SELECT user_id FROM users WHERE username = 'useruser8'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 3, 'I remember hearing that, yea'),
((SELECT user_id FROM users WHERE username = 'useruser17'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 3, 'no');
INSERT INTO answer (student, assignment, question, answer) VALUES 
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 4, 'vuejs'),
((SELECT user_id FROM users WHERE username = 'useruser3'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 4, 'vue.js'),
((SELECT user_id FROM users WHERE username = 'useruser4'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 4, '"vue.js"'),
((SELECT user_id FROM users WHERE username = 'useruser6'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 4, 'vuejs'),
((SELECT user_id FROM users WHERE username = 'useruser8'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 4, 'VUEJS'),
((SELECT user_id FROM users WHERE username = 'useruser17'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 4, 'vue');
INSERT INTO answer (student, assignment, question, answer) VALUES 
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 5, 'no'),
((SELECT user_id FROM users WHERE username = 'useruser3'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 5, 'yes'),
((SELECT user_id FROM users WHERE username = 'useruser4'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 5, 'yes'),
((SELECT user_id FROM users WHERE username = 'useruser6'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 5, 'YES!!'),
((SELECT user_id FROM users WHERE username = 'useruser8'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 5, 'nope'),
((SELECT user_id FROM users WHERE username = 'useruser17'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), 5, 'no');

INSERT into mcchoice (assignment, question, choice, answer, correct) VALUES
((SELECT id FROM assignment WHERE name = 'Fundamentals 3'),1,1,'vuejs',TRUE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 3'),1,2,'vue.js',TRUE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 3'),1,3,'vue js',TRUE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 3'),2,1,'vuejs',TRUE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 3'),3,1,'actually, yes',TRUE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 3'),3,2,'I remember hearing that, yea',TRUE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 3'),4,1,'vue.js',TRUE),
((SELECT id FROM assignment WHERE name = 'Fundamentals 3'),5,1,'no',TRUE);

INSERT INTO message (user_id, read, content) VALUES
((SELECT user_id FROM users WHERE username = 'student'), TRUE, 'Hi, We are canelling class next thursday'),
((SELECT user_id FROM users WHERE username = 'admin'), TRUE, 'just a reminder that all classes are cancelled next thursday'),
((SELECT user_id FROM users WHERE username = 'admin'), TRUE, 'Hi, this is username "teacher", you may have heard class is cancelled... well it is not cancelled!');


INSERT INTO assignment (name, description, created_date, due_date, questions, course) VALUES
( 'First Week Quiz' , 'Practise everything we have learned from the lessons' ,
'12-18-2020', '12-31-2020', 5, (SELECT id FROM course WHERE name='Relational Databases'));
--teachers: useruser14 
--students: student,UU4,UU7,UU9,UU18 (exactly the class limit)
--ASSIGNMENT - Fundamentals 3 -- QUESTIONS (All text)
--Intentionally turning nothing in for user 18, maybe eventually have some alert set up for this
INSERT INTO question (assignment, number, type, statement) VALUES 
((SELECT id FROM assignment WHERE name = 'First Week Quiz'), 1, 'text', 'Spell "deja vue"'),
((SELECT id FROM assignment WHERE name = 'First Week Quiz'), 2, 'text', 'Again! (spell "deja vu")'),
((SELECT id FROM assignment WHERE name = 'First Week Quiz'), 3, 'text', 'Does SQL have anything to do with lentil soup?'),
((SELECT id FROM assignment WHERE name = 'First Week Quiz'), 4, 'text', 'Can you run that word be me again, "vuejs"? Thanks.'),
((SELECT id FROM assignment WHERE name = 'First Week Quiz'), 5, 'text', 'Is it easy to create online tests?');
INSERT INTO answer (student, assignment, question, answer) VALUES 
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'First Week Quiz'), 1, 'vuejs'),
((SELECT user_id FROM users WHERE username = 'useruser4'), (SELECT id FROM assignment WHERE name = 'First Week Quiz'), 1, 'vue.js'),
((SELECT user_id FROM users WHERE username = 'useruser7'), (SELECT id FROM assignment WHERE name = 'First Week Quiz'), 1, '"vue.js"'),
((SELECT user_id FROM users WHERE username = 'useruser9'), (SELECT id FROM assignment WHERE name = 'First Week Quiz'), 1, 'vuejs');
INSERT INTO answer (student, assignment, question, answer) VALUES 
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'First Week Quiz'), 2, 'vuejs'),
((SELECT user_id FROM users WHERE username = 'useruser4'), (SELECT id FROM assignment WHERE name = 'First Week Quiz'), 2, 'vue.js'),
((SELECT user_id FROM users WHERE username = 'useruser7'), (SELECT id FROM assignment WHERE name = 'First Week Quiz'), 2, '"vue.js"'),
((SELECT user_id FROM users WHERE username = 'useruser9'), (SELECT id FROM assignment WHERE name = 'First Week Quiz'), 2, 'vuejs');
INSERT INTO answer (student, assignment, question, answer) VALUES 
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'First Week Quiz'), 3, 'no'),
((SELECT user_id FROM users WHERE username = 'useruser4'), (SELECT id FROM assignment WHERE name = 'First Week Quiz'), 3, 'Im not sure'),
((SELECT user_id FROM users WHERE username = 'useruser7'), (SELECT id FROM assignment WHERE name = 'First Week Quiz'), 3, 'no'),
((SELECT user_id FROM users WHERE username = 'useruser9'), (SELECT id FROM assignment WHERE name = 'First Week Quiz'), 3, 'YES!!');
INSERT INTO answer (student, assignment, question, answer) VALUES 
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'First Week Quiz'), 4, 'vuejs'),
((SELECT user_id FROM users WHERE username = 'useruser4'), (SELECT id FROM assignment WHERE name = 'First Week Quiz'), 4, 'vue.js'),
((SELECT user_id FROM users WHERE username = 'useruser7'), (SELECT id FROM assignment WHERE name = 'First Week Quiz'), 4, '"vue.js"'),
((SELECT user_id FROM users WHERE username = 'useruser9'), (SELECT id FROM assignment WHERE name = 'First Week Quiz'), 4, 'vuejs');
INSERT INTO answer (student, assignment, question, answer) VALUES 
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'First Week Quiz'), 5, 'no'),
((SELECT user_id FROM users WHERE username = 'useruser4'), (SELECT id FROM assignment WHERE name = 'First Week Quiz'), 5, 'yes'),
((SELECT user_id FROM users WHERE username = 'useruser7'), (SELECT id FROM assignment WHERE name = 'First Week Quiz'), 5, 'yes'),
((SELECT user_id FROM users WHERE username = 'useruser9'), (SELECT id FROM assignment WHERE name = 'First Week Quiz'), 5, 'YES!!');

INSERT into mcchoice (assignment, question, choice, answer, correct) VALUES
((SELECT id FROM assignment WHERE name = 'First Week Quiz'),1,1,'deja vu',TRUE),
((SELECT id FROM assignment WHERE name = 'First Week Quiz'),2,1,'deja vu',TRUE),
((SELECT id FROM assignment WHERE name = 'First Week Quiz'),3,1,'actually, yes',TRUE),
((SELECT id FROM assignment WHERE name = 'First Week Quiz'),3,2,'I remember hearing that, yea',TRUE),
((SELECT id FROM assignment WHERE name = 'First Week Quiz'),4,1,'vue.js',TRUE),
((SELECT id FROM assignment WHERE name = 'First Week Quiz'),5,1,'no',TRUE);


INSERT INTO assignment (name, description, created_date, due_date, questions, course) VALUES
( 'Second Week Quiz' , 'MORE practise for everything we have learned from the lessons' ,
'12-05-2020', '01-10-2020', 5, (SELECT id FROM course WHERE name='Relational Databases'));
--teachers: useruser14 
--students: student,UU4,UU7,UU9,UU18 (exactly the class limit)
--ASSIGNMENT - Fundamentals 3 -- QUESTIONS (All text)
--ONLY USERS student and useruser7 have turned in this assignment, in this data set. Both of them will have grades, as well.
INSERT INTO question (assignment, number, type, statement) VALUES 
((SELECT id FROM assignment WHERE name = 'Second Week Quiz'), 1, 'text', 'Can you read?'),
((SELECT id FROM assignment WHERE name = 'Second Week Quiz'), 2, 'text', 'How many fingers am I holding up?'),
((SELECT id FROM assignment WHERE name = 'Second Week Quiz'), 3, 'text', 'Thoughts on life?'),
((SELECT id FROM assignment WHERE name = 'Second Week Quiz'), 4, 'text', 'Hey! hows it going?!?!'),
((SELECT id FROM assignment WHERE name = 'Second Week Quiz'), 5, 'text', 'Is this the last question of the test?');

INSERT into mcchoice (assignment, question, choice, answer, correct) VALUES
((SELECT id FROM assignment WHERE name = 'Second Week Quiz'),1,1,'yes',TRUE),
((SELECT id FROM assignment WHERE name = 'Second Week Quiz'),2,1,'5',TRUE),
((SELECT id FROM assignment WHERE name = 'Second Week Quiz'),3,1,'trick question!',TRUE),
((SELECT id FROM assignment WHERE name = 'Second Week Quiz'),4,1,'chillin, you?',TRUE),
((SELECT id FROM assignment WHERE name = 'Second Week Quiz'),5,1,'no; the test goes on, just as time does.',TRUE);


--student ANSWERS
INSERT INTO answer (student, assignment, question, answer) VALUES 
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'Second Week Quiz'), 1, 'no'),
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'Second Week Quiz'), 2, 'uhhhhh.... 5?'),
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'Second Week Quiz'), 3, 'I think it is pretty good, not bad.'),
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'Second Week Quiz'), 4, 'great!'),
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'Second Week Quiz'), 5, 'no?');
--USER 7 ANSWERS
INSERT INTO answer (student, assignment, question, answer) VALUES 
((SELECT user_id FROM users WHERE username = 'useruser7'), (SELECT id FROM assignment WHERE name = 'Second Week Quiz'), 1, 'yes'),
((SELECT user_id FROM users WHERE username = 'useruser7'), (SELECT id FROM assignment WHERE name = 'Second Week Quiz'), 2, 'definitely 6'),
((SELECT user_id FROM users WHERE username = 'useruser7'), (SELECT id FROM assignment WHERE name = 'Second Week Quiz'), 3, 'it is challenging and fun!'),
((SELECT user_id FROM users WHERE username = 'useruser7'), (SELECT id FROM assignment WHERE name = 'Second Week Quiz'), 4, 'eh.. kind of bored'),
((SELECT user_id FROM users WHERE username = 'useruser7'), (SELECT id FROM assignment WHERE name = 'Second Week Quiz'), 5, 'no, this is?');

INSERT INTO grade (student, assignment, turned_in, correct, grade, comment) VALUES
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), '2020-12-13 08:32:43'::TIMESTAMP , 3, 60, 'Turned in: 2020-12-13 08:32:43 Grade: 3/5'),
((SELECT user_id FROM users WHERE username = 'useruser3'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), '2020-12-11 21:53:16'::TIMESTAMP , 2, 40, 'Turned in: 2020-12-11 21:53:16 Grade: 2/5'),
((SELECT user_id FROM users WHERE username = 'useruser4'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), '2020-12-14 18:22:34'::TIMESTAMP , 2, 40, 'Turned in: 2020-12-14 18:22:34 Grade: 2/5'),
((SELECT user_id FROM users WHERE username = 'useruser6'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), '2020-12-13 09:36:15'::TIMESTAMP , 1, 20, 'Turned in: 2020-12-13 09:36:15 Grade: 1/5'),
((SELECT user_id FROM users WHERE username = 'useruser8'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), '2020-12-16 10:17:26'::TIMESTAMP , 5, 100, 'Turned in: 2020-12-16 10:17:26 Grade: 5/5'),
((SELECT user_id FROM users WHERE username = 'useruser17'), (SELECT id FROM assignment WHERE name = 'Fundamentals 1'), '2020-12-13 08:55:12'::TIMESTAMP , 1, 20, 'Turned in: 2020-12-13 08:55:12 Grade: 1/5');


INSERT INTO grade (student, assignment, turned_in, correct, grade, comment) VALUES
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'Fundamentals 3'), '2020-12-13 08:55:13'::TIMESTAMP , 3, 60, 'not bad, but I know you could do a lot better than 60%!');

INSERT INTO grade (student, assignment, turned_in, correct, grade, comment) VALUES
((SELECT user_id FROM users WHERE username = 'student'), (SELECT id FROM assignment WHERE name = 'Second Week Quiz'), '2020-12-16 08:40:36'::TIMESTAMP , 4, 80, 'great work! The one issue was quetsion 5. Actually the answer was yes!');

INSERT INTO grade (student, assignment, turned_in, correct, grade, comment) VALUES
((SELECT user_id FROM users WHERE username = 'useruser7'), (SELECT id FROM assignment WHERE name = 'Second Week Quiz'), '2020-12-16 08:40:36'::TIMESTAMP , 2, 40, 'needs improvement!!');

COMMIT TRANSACTION;
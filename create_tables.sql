drop schema dropmusic;
create database dropmusic;
use dropmusic;

CREATE TABLE artist (
	name	 varchar(200),
	details varchar(5000),
	PRIMARY KEY(name)
);

CREATE TABLE album (
	id		 bigint AUTO_INCREMENT,
	title	 varchar(200),
	description	 varchar(5000),
	genre	 varchar(100),
	launch_date	 date,
	editor_label varchar(100),
	artist_name	 varchar(200) NOT NULL,
	PRIMARY KEY(id),
  UNIQUE KEY(title, artist_name)
);

CREATE TABLE review (
	critic	 varchar(300),
	rating	 int,
	user_email varchar(200),
	album_id	 bigint,
	PRIMARY KEY(user_email,album_id)
);

CREATE TABLE user (
	email	 varchar(200),
	password varchar(50),
	editor	 boolean DEFAULT false,
	PRIMARY KEY(email)
);

CREATE TABLE music (
	id	 bigint AUTO_INCREMENT,
	track	 int,
	title	 varchar(200),
	lyrics	 varchar(5000),
	album_id bigint NOT NULL,
	PRIMARY KEY(id),
  UNIQUE KEY(track, title)
);

CREATE TABLE notification (
	id		 bigint AUTO_INCREMENT,
	notification varchar(100),
	user_email	 varchar(200) NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE upload (
	musicfilename varchar(300),
	music_id	 bigint,
	user_email	 varchar(200),
	PRIMARY KEY(music_id,user_email)
);

CREATE TABLE playlist (
	name	 varchar(512),
	public	 boolean,
	user_email varchar(200),
	PRIMARY KEY(name,user_email)
);

CREATE TABLE shows (
	place	 varchar(512),
	show_date date,
	id	 varchar(512),
	PRIMARY KEY(id)
);

CREATE TABLE allowed (
	upload_music_id	 bigint,
	allowed_email varchar(200),
	user_email	 varchar(200),
	PRIMARY KEY(upload_music_id,allowed_email,user_email)
);

CREATE TABLE editor (
	artist_name varchar(200),
	user_email	 varchar(200),
	PRIMARY KEY(artist_name,user_email)
);

CREATE TABLE music_playlist (
	music_id		 bigint,
	playlist_name	 varchar(512),
	PRIMARY KEY(music_id, playlist_name)
);

CREATE TABLE shows_artist (
	shows_id	 varchar(512),
	artist_name varchar(200),
	PRIMARY KEY(shows_id,artist_name)
);

ALTER TABLE album ADD CONSTRAINT album_fk1 FOREIGN KEY (artist_name) REFERENCES artist(name) ON DELETE CASCADE;
ALTER TABLE review ADD CONSTRAINT review_fk1 FOREIGN KEY (user_email) REFERENCES user(email) ON DELETE CASCADE;
ALTER TABLE review ADD CONSTRAINT review_fk2 FOREIGN KEY (album_id) REFERENCES album(id) ON DELETE CASCADE;
ALTER TABLE music ADD CONSTRAINT music_fk1 FOREIGN KEY (album_id) REFERENCES album(id) ON DELETE CASCADE;
ALTER TABLE notification ADD CONSTRAINT notification_fk1 FOREIGN KEY (user_email) REFERENCES user(email) ON DELETE CASCADE;
ALTER TABLE upload ADD CONSTRAINT upload_fk1 FOREIGN KEY (music_id) REFERENCES music(id) ON DELETE CASCADE;
ALTER TABLE upload ADD CONSTRAINT upload_fk2 FOREIGN KEY (user_email) REFERENCES user(email) ON DELETE CASCADE;
ALTER TABLE playlist ADD CONSTRAINT playlist_fk1 FOREIGN KEY (user_email) REFERENCES user(email) ON DELETE CASCADE;
ALTER TABLE allowed ADD CONSTRAINT allowed_fk1 FOREIGN KEY (upload_music_id) REFERENCES upload(music_id) ON DELETE CASCADE;
ALTER TABLE allowed ADD CONSTRAINT allowed_fk2 FOREIGN KEY (allowed_email) REFERENCES upload(user_email) ON DELETE CASCADE;
ALTER TABLE allowed ADD CONSTRAINT allowed_fk3 FOREIGN KEY (user_email) REFERENCES user(email) ON DELETE CASCADE;
ALTER TABLE editor ADD CONSTRAINT editor_fk1 FOREIGN KEY (artist_name) REFERENCES artist(name) ON DELETE CASCADE;
ALTER TABLE editor ADD CONSTRAINT editor_fk2 FOREIGN KEY (user_email) REFERENCES user(email) ON DELETE CASCADE;
ALTER TABLE music_playlist ADD CONSTRAINT music_playlist_fk1 FOREIGN KEY (music_id) REFERENCES music(id) ON DELETE CASCADE;
ALTER TABLE music_playlist ADD CONSTRAINT music_playlist_fk2 FOREIGN KEY (playlist_name) REFERENCES playlist(name) ON DELETE CASCADE;
ALTER TABLE shows_artist ADD CONSTRAINT shows_artist_fk1 FOREIGN KEY (shows_id) REFERENCES shows(id) ON DELETE CASCADE;
ALTER TABLE shows_artist ADD CONSTRAINT shows_artist_fk2 FOREIGN KEY (artist_name) REFERENCES artist(name) ON DELETE CASCADE;


INSERT into user (email, password, editor) VALUES ('admin', 'admin', true);
INSERT into user (email, password) VALUES ('roman', 'roman');
INSERT into user (email, password) VALUES ('diogo', 'diogo');

INSERT into notification (notification, user_email) VALUES ('You''ve been promoted to Editor', 'admin');


INSERT into artist (name, details)
VALUES ('Tool', 'Tool is an American rock band from Los Angeles, California. Formed in 1990, the group''s line-up includes drummer Danny Carey, guitarist Adam Jones, and vocalist Maynard James Keenan. Justin Chancellor has been the band''s bassist since 1995, replacing their original bassist Paul D''Amour. Tool has won three Grammy Awards, performed worldwide tours, and produced albums topping the charts in several countries.');

insert into album (title, description, genre, launch_date, editor_label, artist_name)
VALUES ('Lateralus', 'Lateralus is the third studio album by American rock band Tool. It was released on May 15, 2001 through Volcano Entertainment. The album was recorded at Cello Studios in Hollywood and The Hook, Big Empty Space, and The Lodge, in North Hollywood, between October 2000 and January 2001. David Bottrill, who had produced the band''s two previous releases Ænima and Salival, produced the album along with the band. On August 23, 2005, Lateralus was released as a limited edition two-picture-disc vinyl LP in a holographic gatefold package.', 'Progressive Metal', '2001-05-15', 'Volcano Entertainment', 'Tool');

insert into review (critic, rating, user_email, album_id) values ('Very nice', 5, 'roman', 1);
insert into review (critic, rating, user_email, album_id) values ('wtf is this?', 3, 'diogo', 1);

insert into music (track, title, album_id, lyrics)
VALUES (1, 'The Grudge', 1, 'Wear the grudge like a crown of negativity
Calculate what we will or will not tolerate
Desperate to control all and everything
Unable to forgive your scarlet lettermen

Clutch it like a cornerstone, otherwise it all comes down
Justify denials and grip ''em to the lonesome end
Clutch it like a cornerstone, otherwise it all comes down
Terrified of being wrong, ultimatum prison cell

Saturn ascends
Choose one or ten
Hang on or be humbled again

Clutch it like a cornerstone, otherwise it all comes down
Justify denials and grip ''em to the lonesome end
Saturn ascends, comes round again
Saturn ascends, the one, the ten
Ignorant to the damage done

Wear the grudge like a crown of negativity
Calculate what we will or will not tolerate
Desperate to control all and everything
Unable to forgive these scarlet lettermen

Wear the grudge like a crown
Desperate to control
Unable to forgive and sinking deeper

Defining
Confining
And sinking deeper
Controlling
Defining
And we''re sinking deeper

Saturn comes back around to show you everything
Let''s you choose what you will not see and then
Drags you down like a stone or lifts you up again
Spits you out like a child, light and innocent

Saturn comes back around.
Lifts you up like a child or
Drags you down like a stone
To consume you till you choose to let this go
Choose to let this go

Give away the stone
Let the oceans take and trans mutate this cold and fated anchor
Give away the stone
Let the waters kiss and trans mutate these leaden grudges into gold

Let go

');

insert into music (track, title, lyrics, album_id)
VALUES (2, 'Eon Blue Apocalypse', '(instrumental)', 1);


INSERT INTO artist (name, details) VALUES ('Kendrick Lamar'
, 'Kendrick Lamar Duckworth (born June 17, 1987) is an American rapper, songwriter, and record producer. He has been branded as the "new king of hip hop" numerous times.
Raised in Compton, California, Lamar embarked on his musical career as a teenager under the stage name K-Dot, releasing a mixtape that garnered local attention and led to his signing with indie record label Top Dawg Entertainment (TDE). He began to gain recognition in 2010, after his first retail release, Overly Dedicated. The following year, he independently released his first studio album, Section.80, which included his debut single, "HiiiPoWeR". By that time, he had amassed a large online following and collaborated with several prominent hip hop artists, including The Game, Busta Rhymes, and Snoop Dogg. Lamar''s major label debut album, good kid, m.A.A.d city, was released in 2012 by TDE, Aftermath, and Interscope Records to critical acclaim. It debuted at #2 on the US Billboard 200 and was later certified platinum by the RIAA. The record contained the top 40 singles "Swimming Pools (Drank)", "Bitch, Don''t Kill My Vibe", and "Poetic Justice". His critically acclaimed third album To Pimp a Butterfly (2015) incorporated elements of funk, soul, jazz, and spoken word. It debuted atop the charts in the US and the UK, and won the Grammy Award for Best Rap Album at the 58th ceremony. In 2016, Lamar released Untitled Unmastered, a collection of unreleased demos that originated during the recording sessions for Butterfly. He released his fourth album Damn in 2017 to further acclaim its lead single "Humble" topped the US Billboard Hot 100 chart.
Aside from his solo career, Lamar is also known as a member of the West Coast hip hop supergroup Black Hippy, alongside his TDE label-mates and fellow South Los Angeles–based rappers Ab-Soul, Jay Rock, and Schoolboy Q.
Lamar has received many accolades over the course of his career, including twelve Grammy Awards. In early 2013, MTV named him the "Hottest MC in the Game", on their annual list. Time named him one of the 100 most influential people in the world in 2016. In 2018, Damn became the first non-classical and non-jazz album to be awarded the Pulitzer Prize for Music.[7] ');

INSERT INTO album (title, description, genre, launch_date, editor_label, artist_name)
VALUES ('To Pimp a Butterfly', 'o Pimp a Butterfly is the third studio album by American rapper Kendrick Lamar. It was released on March 15, 2015, by Aftermath Entertainment, Interscope Records and Top Dawg Entertainment.
The album was recorded in studios throughout the United States, with production from Sounwave, Terrace Martin, Taz "Tisa" Arnold, Thundercat, Rahki, LoveDragon, Flying Lotus, Pharrell Williams, Boi-1da, knxwledge, and several other high-profile hip hop producers, as well as executive production from Dr. Dre and Anthony "Top Dawg" Tiffith. The album incorporates elements of jazz, funk, soul, spoken word, and avant-garde music and explores a variety of political and personal themes concerning African-American culture, racial inequality, depression, and institutional discrimination.', 'Hip-Hop', '2015-03-15', 'Aftermath Entertainment' , 'Kendrick Lamar');

insert into review (critic, rating, user_email, album_id) VALUES ('Best album ever', 5, 'diogo', 2);
insert into review (critic, rating, user_email, album_id) VALUES ('I''ve seen better', 4, 'roman', 2);

INSERT INTO music (track, title, album_id, lyrics)
VALUES (1 , '"Wesley''s Theory" (featuring George Clinton and Thundercat)', 2, 'When the four corners of this cocoon collide
You’ll slip through the cracks hoping that you’ll survive
Gather your wind, take a deep look inside
Are you really who they idolize?
To pimp a butterfly
At first, I did love you
But now I just wanna fuck
Late night thinkin'' of you
Until I got my nut
Tossed and turned, lesson learned
You was my first girlfriend
Bridges burned, all across the board
Destroyed, but what for?
When I get signed, homie I''mma act a fool
Hit the dance floor, strobe lights in the room
Snatch your little secretary bitch for the homies
Blue eyed devil with a fat ass smokey
I''mma buy a brand new Caddy on fours
Trunk the hood up, two times, deuce four
Platinum on everything, platinum on wedding ring
Married to the game, made a bad bitch yours
When I get signed homie I''mma buy a strap
Straight from the CIA, set it on my lap
Take a few M-16s to the hood
Pass ''em all out on the block, what''s good?
I''mma put the Compton swap meet by the White House
Republican, run up, get socked out
Hit the press with a Cuban link on my neck
Uneducated but I got a million dollar check, like that
We should never gave, we should never gave
Niggas money go back home, money go back home
We should never gave, we should never gave
Niggas money go back home, money go back home
At first, I did love you
But now I just wanna fuck
Late night thinkin'' of you
Until I got my nut
Tossed and turned, lesson learned
You was my first girlfriend
Bridges burned, all across the board
Destroyed, but what for?
Yo what''s up? It''s Dre
Remember the first time you came out to the house?
You said you wanted a spot like mine
But remember, anybody can get it
The hard part is keeping it, motherfucker
What you want you? A house or a car?
Forty acres and a mule, a piano, a guitar?
Anything, see, my name is Uncle Sam on your dollar
Motherfucker you can live at the mall
I know your kind (that''s why I''m kind)
Don''t have receipts (oh man, that''s fine)
Pay me later, wear those gators
Cliche and say, fuck your haters
I can see the borrow in you
I can see the dollar in you
Little white lies with a snow white collar in you
But it''s whatever though because I''m still followin'' you
Because you make me feel forever baby, count it all together baby
Then hit the register and make me feel better baby
Your horoscope is a gemini, two sides
So you better cop everything two times
Two coupes, two chains, two c-notes
Too much and enough both we know
Christmas, tell ''em what''s on your wish list
Get it all, you deserve it Kendrick
And when you get the White House, do you
But remember, you ain''t pass economics in school
And everything you buy, taxes will deny
I''ll Wesley Snipe your ass before thirty-five
Lookin'' down is quite a drop (it''s quite a drop, drop)
Lookin'' good when you''re on top (when you''re on top you got it)
A lot of metaphors, leavin'' miracles metaphysically in a state of euphoria
Look both ways before you cross my mind
We should never gave, we should never gave
Niggas money go back home, money go back home
We should never gave, we should never gave
Niggas money go back home, money go back home
Tax man comin''');


INSERT INTO music (track, title, album_id, lyrics)
VALUES (2, 'For Free? (Interlude)', 2, 'I go on and on
Can''t understand how I last so long
I must have the superpowers
Last 223 thousand hours
And it''s cause I''m off of CC
And I''m off the Hennessy
And like your boy from Compton said
You know this dick ain''t free!
I got girls that I shoulda made pay for it
Got girls that I should made wait for it
I got girls that''ll cancel a flight back home
Stay another day for it
You got attitude on na na
And your pussy on agua
And your stomach on flat flat
And your ass on what''s that?
And, yeah, I need it all right now
Last year I had drama, girl not right now
I was never gon'' chat what we talkin'' about
You the only one I know could fit it all in them, man
I always wonder if you ask yourself
Is it just me?
Is it just me?
Or is this sex so good I shouldn''t have to fuck for free?
Is it just me?
Is it just me?
Is this sex so good I shouldn''t have to
Fuck for free
I know you workin'' day and night to get a college degree
Bet nobody that you''ve been with even know you a freak, right?
You know you only do that with me, right?
Yeah, double checkin'' on you
You know I never put the pressure on you
You know that you make your own mind up
You knew what it was when you signed up
Now you gotta run it up
I be out of words, tryna sum it up
Girl you throw it back like one love
Even let me slash on the tour bus
Yeah I talk to her but she don''t do enough
Even though you in the hood I''m still pullin'' up
Dip, dip, straight to your doorstep
This the real thing, can you feel the force yet
I always wonder if you ask yourself
Is it just me?
Is it just me?
Or is this sex so good I shouldn''t have to fuck for free?
Is it just me?
Yeah, is it just me?
Is this sex so good I shouldn''t have to
(Would you fuck me for free?)
Another one
They don''t want me to have another anthem
So I made sure I got another anthem
It''s We The Best OVO
Summers ours
It always has been
Don''t ever play yourself
One time for Future the Prince
One time for 40
One time for Drake
Another one
Bless up');


insert into playlist (name, public, user_email) VALUES ("Funk ao Jantar", 0, "diogo");
insert into playlist (name, public, user_email) VALUES ("Funk ao Almoço", 1, "roman");

insert into music_playlist (music_id, playlist_name)
VALUES (1, "Funk ao Jantar");


insert into music_playlist (music_id, playlist_name)
VALUES (2, "Funk ao Jantar");


insert into music_playlist (music_id, playlist_name)
VALUES (1, "Funk ao Almoço");





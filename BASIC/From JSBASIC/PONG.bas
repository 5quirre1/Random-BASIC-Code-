1 REM Newsgroups: comp.sys.apple2
2 REM From:  mad.scientist.jr@gmail.com
3 REM Message-ID: <1193160910.224728.270640@z24g2000prh.googlegroups.com>
4 REM Subject: Re: woz' original "brick out" - source code , paddles
5 REM Date: Tue, 23 Oct 2007 17:35:10 -0000

10   REM  APPLE II SIMPLE PONG V4
20   REM  PASTE INTO Joshua Bell's EMULATOR AT inexorabletash.github.io/jsbasic/
25   REM  ++++++++++++++++++++++++++++++++++++++++
30   REM  TITLE SCREEN + PROMPT FOR CONTROLS
35   REM  ++++++++++++++++++++++++++++++++++++++++
40   TEXT : PR#0 : HOME : REM ENTER TEXT MODE, CLEAR SCREEN
45   DEF FN pd(k) = (26 * pdl(k)) / 255 + 2 : REM DEFINE PADDLE-READING FUNCTION
46   REM DEF FN pr(k) = SGN(INT((pdl(k) - 55) / 146)) : REM (non-absolute) paddle function
49   PRINT "APPLE II SIMPLE PONG V4.1"
50   PRINT
51   PRINT "version 1 by aiiadict"
52   PRINT "tweaks by Mad Scientist Jr"
53   PRINT "and Alan Ratliff (2020)"
54   PRINT
55   PRINT "During game press Q to quit."
56   PRINT : HTAB 18 : PRINT "^ # ^" SPC(5) "^ # ^"
58   PRINT "TYPE K FOR KEYS" SPC(2) "A/S/D" SPC(5) "J/K/L" : HTAB 19 : PRINT "Z/X" SPC(7) "M/,"
59   PRINT " (# = STOP)" TAB(19) "v v" SPC(7) "v v" : PRINT : PRINT "OR P FOR PADDLES OR Q TO QUIT? ";
60   GET C$ : IF C$ <> "K" AND C$ <> "P" AND C$ <> "Q" GOTO 60
62   IF C$ = "Q" THEN VTAB 22 : GOTO 9000
65   REM
70   REM  ++++++++++++++++++++++++++++++++++++++++
75   REM  DRAW FIELD AND INITIALIZE GAME
80   REM  ++++++++++++++++++++++++++++++++++++++++
85   HOME : GR: REM ENTER GRAPHIC MODE
90   COLOR= 7: VLIN 0,39 AT 0: VLIN 0,39 AT 39
95   HLIN 0,39 AT 0: HLIN 0,39 AT 39
100  bx = 10:by = 10:ox = 10:oy = 10: REM BALL START POSITION
102  dx = 1: dy = - 1: REM BALL DIRECTION
104  p1 = 10: o1 = 10: REM PLAYER 1 START POSITION
106  p2 = 10: o2 = 10: REM PLAYER 2 START POSITION
120  v1 = 0 : v2 = 0 : s1 = 0 : s2 = 0 : u1 = 0 : u2 = 0 :
125  PL = 8: REM PADDLE LENGTH
130  REM
145  REM  ++++++++++++++++++++++++++++++++++++++++
150  REM  BEGIN MAIN GAME LOOP
155  REM  ++++++++++++++++++++++++++++++++++++++++
196  REM  ++++++++++++++++++++++++++++++++++++++++
197  REM  DRAW PADDLE1
198  REM  ++++++++++++++++++++++++++++++++++++++++
200  IF o1 <> p1 THEN COLOR= 0: VLIN o1,o1 + PL AT 3
210  COLOR= 7: VLIN p1,p1 + PL AT 3
296  REM  ++++++++++++++++++++++++++++++++++++++++
297  REM  DRAW PADDLE2
298  REM  ++++++++++++++++++++++++++++++++++++++++
300  IF o2 <> p2 THEN COLOR= 0: VLIN o2,o2 + PL AT 36
310  COLOR= 7: VLIN p2,p2 + PL AT 36
399  REM  ++++++++++++++++++++++++++++++++++++++++
400  REM  DRAW AND MOVE BALL
401  REM  ++++++++++++++++++++++++++++++++++++++++
402  IF ox <> bx OR oy <> by THEN COLOR= 0: VLIN oy,oy + 1 AT ox
410  COLOR= 11: VLIN by,by + 1 AT bx
420  ox = bx : oy = by : bb = 1
470  bx = bx + dx
490  IF SCRN( bx,by) OR SCRN( bx, by + 1) THEN dx = -dx : k = (bx=3)*p1+(bx=36)*p2 : IF bx*2=39-dx*33 AND ((k>0)*by-PL/2-k+1)*dy > 0 THEN bb = 0
500  IF bx = 7 THEN u1 = 1
510  IF bx = 33 THEN u2 = 1
520  IF bx = 1 AND u1 THEN s2 = s2 + 1 : u1 = 0 : VTAB 22 : HTAB 41 - LEN(STR$(s2)) : PRINT s2;
530  IF bx = 38 AND u2 THEN s1 = s1 + 1 : u2 = 0 : VTAB 22 : HTAB 1 : PRINT s1
540  by = by + dy
840  IF (SCRN( bx,by) OR SCRN( bx, by + 1)) AND bb THEN dy = -dy
850  IF bx < 1 THEN bx = 1
860  IF bx > 38 THEN bx = 38
870  IF by < 1 THEN by = 1
880  IF by > 37 THEN by = 37
890  o1 = p1 : o2 = p2
900  REM  ++++++++++++++++++++++++++++++++++++++++
901  REM  GET PLAYER INPUT
902  REM  ++++++++++++++++++++++++++++++++++++++++
903  IF PEEK ( - 16384) > 127 THEN GET K$: IF K$ = "Q" GOTO 9000 : REM SEE IF KEY PRESSED/Q FOR QUIT
904  IF C$ <> "K" THEN GOTO 921
905  REM
906  REM  ----------------------------------------
907  REM  KEYBOARD INPUT
909  REM  ----------------------------------------
912  IF K$ = "A" OR K$ = "D" THEN v1 = -1
913  IF K$ = "S" THEN v1 = 0
914  IF K$ = "Z" OR K$ = "X" THEN v1 = 1
916  IF K$ = "J" OR K$ = "L" THEN v2 = -1
917  IF K$ = "K" THEN v2 = 0
918  IF K$ = "M" OR K$ = "," THEN v2 = 1
920  K$ = "" : p1 = p1 + v1 : p2 = p2 + v2 : GOTO 955
921  IF C$ <> "P" THEN GOTO 947
922  REM
923  REM  ----------------------------------------
925  REM  PADDLE INPUT
927  REM  ----------------------------------------
930 REM simple (non-absolute) paddle input:
932 REM p1 = FN pr(0) + p1
934 REM p2 = FN pr(1) + p2
940 REM realtime (absolute position) paddle input:
944  p1 = FN pd(0)
945  p2 = FN pd(1)
947  REM
955  REM  ++++++++++++++++++++++++++++++++++++++++
956  REM  MAKE SURE PADDLES DON'T GO OFF SCREEN
958  REM  ++++++++++++++++++++++++++++++++++++++++
960  IF p1 < 2 THEN p1 = 2
970  IF p1 > 28 THEN p1 = 28
980  IF p2 < 2 THEN p2 = 2
990  IF p2 > 28 THEN p2 = 28
999  GOTO 150
9000 REM
9010 REM  ++++++++++++++++++++++++++++++++++++++++
9020 REM  QUIT GAME
9030 REM  ++++++++++++++++++++++++++++++++++++++++
9040 TEXT : REM HOME
9045 PRINT
9050 PRINT "FINISHED APPLE II SIMPLE PONG V4.1"
9055 REM I got this from https://www.calormen.com/jsbasic/ <3 wow

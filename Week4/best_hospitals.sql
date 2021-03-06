DROP TABLE IF EXISTS effective_care_score;
CREATE TABLE effective_care_score AS SELECT provider_id, name, avg(score) as ec_score from effective_care_parquet
GROUP BY provider_id, name
ORDER BY ec_score DESC;

-- SELECT * FROM effective_care_score
-- LIMIT 90;


DROP TABLE IF EXISTS readmissions_score;
CREATE TABLE readmissions_score AS SELECT provider_id, name, avg(score) as re_score from readmissions_parquet
group by provider_id, name
order by re_score DESC;

-- SELECT * FROM readmissions_score
-- LIMIT 90;


DROP TABLE IF EXISTS overall_hospital_score;
CREATE TABLE overall_hospital_score AS
SELECT effective_care_score.provider_id, effective_care_score.name, (readmissions_score.re_score + effective_care_score.ec_score) AS t_score
FROM readmissions_score FULL OUTER JOIN effective_care_score
ON readmissions_score.provider_id = effective_care_score.provider_id
order by t_score DESC; 

SELECT * FROM overall_hospital_score
LIMIT 10;




    > 
    > DROP TABLE IF EXISTS effective_care_score;
OK
Time taken: 0.085 seconds
hive> CREATE TABLE effective_care_score AS SELECT provider_id, name, avg(score) as ec_score from effective_care_parquet
    > GROUP BY provider_id, name
    > ORDER BY ec_score DESC;
Query ID = w205_20161008060000_64c8780e-b1cc-4473-b6cb-74a5ca023b5e
Total jobs = 2
Launching Job 1 out of 2
Number of reduce tasks not specified. Estimated from input data size: 1
In order to change the average load for a reducer (in bytes):
  set hive.exec.reducers.bytes.per.reducer=<number>
In order to limit the maximum number of reducers:
  set hive.exec.reducers.max=<number>
In order to set a constant number of reducers:
  set mapreduce.job.reduces=<number>
Starting Job = job_1475607266406_0088, Tracking URL = http://ip-172-31-6-204.ec2.internal:8088/proxy/application_1475607266406_0088/
Kill Command = /usr/lib/hadoop/bin/hadoop job  -kill job_1475607266406_0088
Hadoop job information for Stage-1: number of mappers: 1; number of reducers: 1
2016-10-08 06:00:09,731 Stage-1 map = 0%,  reduce = 0%
2016-10-08 06:00:18,200 Stage-1 map = 100%,  reduce = 0%, Cumulative CPU 3.93 sec
2016-10-08 06:00:25,546 Stage-1 map = 100%,  reduce = 100%, Cumulative CPU 6.19 sec
MapReduce Total cumulative CPU time: 6 seconds 190 msec
Ended Job = job_1475607266406_0088
Launching Job 2 out of 2
Number of reduce tasks determined at compile time: 1
In order to change the average load for a reducer (in bytes):
  set hive.exec.reducers.bytes.per.reducer=<number>
In order to limit the maximum number of reducers:
  set hive.exec.reducers.max=<number>
In order to set a constant number of reducers:
  set mapreduce.job.reduces=<number>
Starting Job = job_1475607266406_0089, Tracking URL = http://ip-172-31-6-204.ec2.internal:8088/proxy/application_1475607266406_0089/
Kill Command = /usr/lib/hadoop/bin/hadoop job  -kill job_1475607266406_0089
Hadoop job information for Stage-2: number of mappers: 1; number of reducers: 1
2016-10-08 06:00:33,289 Stage-2 map = 0%,  reduce = 0%
2016-10-08 06:00:39,558 Stage-2 map = 100%,  reduce = 0%, Cumulative CPU 2.03 sec
2016-10-08 06:00:47,004 Stage-2 map = 100%,  reduce = 100%, Cumulative CPU 4.39 sec
MapReduce Total cumulative CPU time: 4 seconds 390 msec
Ended Job = job_1475607266406_0089
Moving data to: hdfs://localhost:8020/user/hive/warehouse/effective_care_score
Table default.effective_care_score stats: [numFiles=1, numRows=4808, totalSize=239390, rawDataSize=234582]
MapReduce Jobs Launched: 
Stage-Stage-1: Map: 1  Reduce: 1   Cumulative CPU: 6.19 sec   HDFS Read: 56101311 HDFS Write: 295705 SUCCESS
Stage-Stage-2: Map: 1  Reduce: 1   Cumulative CPU: 4.39 sec   HDFS Read: 300097 HDFS Write: 239480 SUCCESS
Total MapReduce CPU Time Spent: 10 seconds 580 msec
OK
Time taken: 45.458 seconds
hive> 
    > SELECT * FROM effective_care_score
    > LIMIT 90;
OK
450348	FALLS COMMUNITY HOSPITAL AND CLINIC	235.58333333333334
051335	BEAR VALLEY COMMUNITY HOSPITAL	175.33333333333334
400079	HOSP COMUNITARIO BUEN SAMARITANO	167.25
451330	MEDINA REGIONAL HOSPITAL	136.0
310002	NEWARK BETH ISRAEL MEDICAL CENTER	134.81578947368422
051318	REDWOOD MEMORIAL HOSPITAL	130.33333333333334
400032	HOSPITAL HERMANOS MELENDEZ INC	130.21052631578948
261317	MERCY HOSPITAL CASSVILLE	128.0
331316	COMMUNITY MEMORIAL HOSPITAL, INC	127.66666666666667
511313	BOONE MEMORIAL HOSPITAL	125.33333333333333
400013	HOSPITAL MENONITA DE CAYEY	125.25
490144	NOVANT HEALTH HAYMARKET MEDICAL CENTER	124.0
140300	PROVIDENT HOSPITAL OF CHICAGO	123.66666666666667
330202	KINGS COUNTY HOSPITAL CENTER	123.1951219512195
341311	CHATHAM HOSPITAL INC	122.8
210002	UNIVERSITY OF MARYLAND MEDICAL CENTER	121.43333333333334
051304	JOHN C FREMONT HEALTHCARE DISTRICT	121.16666666666667
450289	HARRIS HEALTH SYSTEM	121.15384615384616
341324	THE OUTER BANKS HOSPITAL, INC	119.83333333333333
330182	ST FRANCIS HOSPITAL, ROSLYN	119.29729729729729
050060	COMMUNITY REGIONAL MEDICAL CENTER	119.17948717948718
491307	PAGE MEMORIAL HOSPITAL, INC	119.0
140068	ROSELAND COMMUNITY HOSPITAL	117.80952380952381
111336	MOUNTAIN LAKES MEDICAL CENTER	117.75
331315	GOUVERNEUR HOSPITAL	117.25
141334	ST JOSEPH MEMORIAL HOSPITAL	117.0
241302	SANFORD WESTBROOK MEDICAL CENTER	116.5
191302	ST MARTIN HOSPITAL	116.5
050776	COLLEGE MEDICAL CENTER	116.33333333333333
320001	UNM HOSPITAL	115.525
330306	LUTHERAN MEDICAL CENTER	115.25641025641026
050138	KAISER FOUNDATION HOSPITAL - LOS ANGELES	115.2
110079	GRADY MEMORIAL HOSPITAL	115.16216216216216
010087	UNIVERSITY OF SOUTH ALABAMA MEDICAL CENTER	115.11428571428571
261316	MERCY HOSPITAL AURORA	114.4
301302	LITTLETON REGIONAL HEALTHCARE	114.3076923076923
670090	CRESCENT MEDICAL CENTER LANCASTER	114.16666666666667
061301	RIO GRANDE HOSPITAL	114.0
051314	KERN VALLEY HEALTHCARE DISTRICT	114.0
240206	RED LAKE HOSPITAL A	113.8
231338	SPECTRUM HEALTH GERBER MEMORIAL	113.72727272727273
241374	PIPESTONE COUNTY  MEDICAL CENTER	113.5
210016	ADVENTIST HEALTHCARE WASHINGTON ADVENTIST HOSPITAL	112.96666666666667
210013	BON SECOURS HOSPITAL	112.95833333333333
290022	DESERT SPRINGS HOSPITAL	112.86842105263158
050292	RIVERSIDE COUNTY REGIONAL MEDICAL CENTER	112.75
450213	UNIVERSITY HEALTH SYSTEM	112.41463414634147
050492	CLOVIS COMMUNITY MEDICAL CENTER	112.39473684210526
050373	LAC+USC MEDICAL CENTER	112.27027027027027
330141	BROOKHAVEN MEMORIAL HOSPITAL MEDICAL CENTER	112.225
301305	ALICE PECK DAY MEMORIAL HOSPITAL	112.18181818181819
050315	KERN MEDICAL CENTER	112.17647058823529
030078	PHOENIX INDIAN MEDICAL CENTER	112.0
330101	NEW YORK-PRESBYTERIAN HOSPITAL	111.79069767441861
330056	BROOKLYN HOSPITAL CENTER AT DOWNTOWN CAMPUS	111.65
290046	SPRING VALLEY HOSPITAL MEDICAL CENTER	111.28205128205128
261321	HEDRICK MEDICAL CENTER	110.875
320060	ZUNI COMPREHENSIVE COMMUNITY HEALTH CENTER	110.66666666666667
181319	BRECKINRIDGE MEMORIAL HOSPITAL	110.66666666666667
330395	ST JOHN'S EPISCOPAL HOSPITAL AT SOUTH SHORE	110.5
330399	ST BARNABAS HOSPITAL	110.36842105263158
420106	PALMETTO HEALTH BAPTIST PARKRIDGE	109.83333333333333
050709	DESERT VALLEY HOSPITAL	109.68571428571428
521319	EDGERTON HOSPITAL AND HEALTH SERVICES	109.66666666666667
491304	CARILION STONEWALL JACKSON HOSPITAL	109.64285714285714
210009	JOHNS HOPKINS HOSPITAL, THE	109.55172413793103
330128	ELMHURST HOSPITAL CENTER	109.53658536585365
050040	LAC/OLIVE VIEW-UCLA MEDICAL CENTER	109.39473684210526
050376	LAC/HARBOR-UCLA MED CENTER	109.34210526315789
100001	UF HEALTH JACKSONVILLE	109.13513513513513
450024	UNIVERSITY MEDICAL CENTER OF EL PASO	109.1025641025641
110064	MIDTOWN MEDICAL CENTER	108.97368421052632
210038	UNIVERSITY OF MD MEDICAL CENTER MIDTOWN CAMPUS	108.77777777777777
100187	PALMETTO GENERAL HOSPITAL	108.6923076923077
090011	MEDSTAR WASHINGTON HOSPITAL CENTER	108.21052631578948
030010	CARONDELET ST  MARYS HOSPITAL	108.1842105263158
330246	ST CHARLES HOSPITAL	108.0
210051	DOCTORS'  COMMUNITY HOSPITAL	107.96551724137932
450015	PARKLAND HEALTH AND HOSPITAL SYSTEM	107.94736842105263
210012	SINAI HOSPITAL OF BALTIMORE	107.9
151319	GIBSON GENERAL HOSPITAL	107.8
090006	PROVIDENCE HOSPITAL	107.76470588235294
421302	FAIRFIELD MEMORIAL HOSPITAL	107.75
180067	UNIVERSITY OF KENTUCKY HOSPITAL	107.61904761904762
290021	VALLEY HOSPITAL MEDICAL CENTER	107.58974358974359
330286	GOOD SAMARITAN HOSPITAL MEDICAL CENTER	107.58974358974359
210023	ANNE ARUNDEL MEDICAL CENTER	107.54838709677419
190005	CHARITY HOSPITAL & MEDICAL CENTER OF LOUISIANA AT	107.47368421052632
101312	FISHERMEN'S HOSPITAL	107.3076923076923
210048	HOWARD COUNTY GENERAL HOSPITAL	107.19354838709677
Time taken: 0.033 seconds, Fetched: 90 row(s)
hive> 
    > 
    > DROP TABLE IF EXISTS readmissions_score;
OK
Time taken: 0.075 seconds
hive> CREATE TABLE readmissions_score AS SELECT provider_id, name, avg(score) as re_score from readmissions_parquet
    > group by provider_id, name
    > order by re_score DESC;
Query ID = w205_20161008060000_fee60e73-ec40-4c53-9b33-70d7cc1edc52
Total jobs = 2
Launching Job 1 out of 2
Number of reduce tasks not specified. Estimated from input data size: 1
In order to change the average load for a reducer (in bytes):
  set hive.exec.reducers.bytes.per.reducer=<number>
In order to limit the maximum number of reducers:
  set hive.exec.reducers.max=<number>
In order to set a constant number of reducers:
  set mapreduce.job.reduces=<number>
Starting Job = job_1475607266406_0090, Tracking URL = http://ip-172-31-6-204.ec2.internal:8088/proxy/application_1475607266406_0090/
Kill Command = /usr/lib/hadoop/bin/hadoop job  -kill job_1475607266406_0090
Hadoop job information for Stage-1: number of mappers: 1; number of reducers: 1
2016-10-08 06:00:56,031 Stage-1 map = 0%,  reduce = 0%
2016-10-08 06:01:02,476 Stage-1 map = 100%,  reduce = 0%
2016-10-08 06:01:09,868 Stage-1 map = 100%,  reduce = 100%, Cumulative CPU 5.74 sec
MapReduce Total cumulative CPU time: 5 seconds 740 msec
Ended Job = job_1475607266406_0090
Launching Job 2 out of 2
Number of reduce tasks determined at compile time: 1
In order to change the average load for a reducer (in bytes):
  set hive.exec.reducers.bytes.per.reducer=<number>
In order to limit the maximum number of reducers:
  set hive.exec.reducers.max=<number>
In order to set a constant number of reducers:
  set mapreduce.job.reduces=<number>
Starting Job = job_1475607266406_0091, Tracking URL = http://ip-172-31-6-204.ec2.internal:8088/proxy/application_1475607266406_0091/
Kill Command = /usr/lib/hadoop/bin/hadoop job  -kill job_1475607266406_0091
Hadoop job information for Stage-2: number of mappers: 1; number of reducers: 1
2016-10-08 06:01:17,585 Stage-2 map = 0%,  reduce = 0%
2016-10-08 06:01:23,895 Stage-2 map = 100%,  reduce = 0%, Cumulative CPU 1.97 sec
2016-10-08 06:01:31,218 Stage-2 map = 100%,  reduce = 100%, Cumulative CPU 4.31 sec
MapReduce Total cumulative CPU time: 4 seconds 310 msec
Ended Job = job_1475607266406_0091
Moving data to: hdfs://localhost:8020/user/hive/warehouse/readmissions_score
Table default.readmissions_score stats: [numFiles=1, numRows=4785, totalSize=247002, rawDataSize=242217]
MapReduce Jobs Launched: 
Stage-Stage-1: Map: 1  Reduce: 1   Cumulative CPU: 5.74 sec   HDFS Read: 17466586 HDFS Write: 295033 SUCCESS
Stage-Stage-2: Map: 1  Reduce: 1   Cumulative CPU: 4.31 sec   HDFS Read: 299423 HDFS Write: 247090 SUCCESS
Total MapReduce CPU Time Spent: 10 seconds 50 msec
OK
Time taken: 44.084 seconds
hive> 
    > SELECT * FROM readmissions_score
    > LIMIT 90;
OK
030022	MARICOPA MEDICAL CENTER	19.25
400110	HOSPITAL METROPOLITANO DR TITO MATTEI	19.200000000000003
440232	HOUSTON COUNTY COMMUNITY HOSPITAL	19.2
190006	UNIVERSITY HOSPITAL & CLINICS	19.15
241350	MERCY HOSPITAL	19.05
111331	MITCHELL COUNTY HOSPITAL	18.45
241345	MAYO CLINIC HEALTH SYSTEM - WASECA	18.4
400123	HOSPITAL PEREA	18.375
521309	MOUNDVIEW MEMORIAL HOSPITAL AND CLINICS	18.2
441313	WELLMONT HANCOCK COUNTY HOSPITAL	18.1
321304	UNION COUNTY GENERAL HOSPITAL	17.875
251319	HOLMES COUNTY HOSPITAL AND CLINICS	17.85
450243	HAMLIN MEMORIAL HOSPITAL	17.85
180050	HARLAN ARH HOSPITAL	17.71
021312	SAMUEL SIMMONDS MEMORIAL HOSPITAL	17.7
40003F	SAN JUAN VA MEDICAL CENTER	17.483333333333334
271323	CLARK FORK VALLEY HOSPITAL	17.419999999999998
521317	CALUMET MEDICAL CENTER	17.366666666666667
061313	KIT CARSON COUNTY MEMORIAL HOSPITAL	17.339999999999996
171348	NORTON COUNTY HOSPITAL	17.333333333333332
291300	MOUNT GRANT GENERAL HOSPITAL	17.32
431325	MOBRIDGE REGIONAL HOSPITAL - CAH	17.3
161326	MADISON COUNTY MEMORIAL HOSPITAL	17.28
660001	COMMONWEALTH HEALTH CENTER	17.250000000000004
360242	JAMES CANCER HOSPITAL & SOLOVE RESEARCH INSTITUTE	17.2
251330	FRANKLIN COUNTY MEMORIAL HOSPITAL	17.174999999999997
330014	JAMAICA HOSPITAL MEDICAL CENTER	17.172727272727272
251316	H C WATKINS MEMORIAL HOSPITAL INC	17.160000000000004
19048F	OVERTON BROOKS VA MEDICAL CENTER - SHREVEPORT	17.116666666666667
010087	UNIVERSITY OF SOUTH ALABAMA MEDICAL CENTER	17.099999999999998
251332	PIONEER HEALTH SERVICES OF NEWTON	17.083333333333332
181328	KNOX COUNTY HOSPITAL	17.071428571428573
33012F	UPSTATE NEW YORK VA HEALTHCARE SYSTEM - WESTERN NY	17.05
271312	PHILLIPS COUNTY MEDICAL CENTER	17.049999999999997
141306	COMMUNITY MEMORIAL HOSPITAL	17.0
050140	KAISER FOUNDATION HOSPITAL FONTANA	17.0
250168	UNIVERSITY OF MISSISSIPPI MEDICAL CENTER- GRENADA	17.0
521329	ST MARYS HOSPITAL OF SUPERIOR	16.979999999999997
121300	KAUAI VETERANS MEMORIAL HOSPITAL	16.975
330027	NASSAU UNIVERSITY MEDICAL CENTER	16.954545454545453
18007F	LEXINGTON VA MEDICAL CENTER	16.95
05025F	FRESNO VA MEDICAL CENTER - VA CENTRAL CALIFORNIA	16.95
330004	HEALTHALLIANCE HOSPITAL BROADWAY CAMPUS	16.936363636363637
450241	FAITH COMMUNITY HOSPITAL	16.880000000000003
201302	ST ANDREWS HOSPITAL (LINCOLN COUNTY HEALTHCARE)	16.860000000000003
440187	LIVINGSTON REGIONAL HOSPITAL	16.855555555555558
400079	HOSP COMUNITARIO BUEN SAMARITANO	16.849999999999998
511314	POCAHONTAS MEMORIAL HOSPITAL	16.84
031311	LITTLE COLORADO MEDICAL CENTER	16.839999999999996
330221	WYCKOFF HEIGHTS MEDICAL CENTER	16.827272727272724
361303	LODI COMMUNITY HOSPITAL	16.825
191320	BIENVILLE MEDICAL CENTER	16.8
050397	COALINGA REGIONAL MEDICAL CENTER	16.8
030084	CHINLE COMPREHENSIVE HEALTH CARE FACILITY	16.799999999999997
111305	MILLER COUNTY HOSPITAL	16.76
030120	GILBERT HOSPITAL	16.759999999999998
371323	WEATHERFORD REGIONAL HOSPITAL	16.75
161316	PALMER LUTHERAN HEALTH CENTER	16.740000000000002
260070	PEMISCOT COUNTY MEMORIAL HOSPITAL	16.728571428571428
050373	LAC+USC MEDICAL CENTER	16.71
050075	KAISER FOUNDATION HOSPITAL - OAKLAND/RICHMOND	16.700000000000003
28006F	OMAHA VA MEDICAL CENTER - VA NEBRASKA WESTERN IOWA	16.7
181316	MARY BRECKINRIDGE ARH HOSPITAL	16.685714285714287
140103	ST BERNARD HOSPITAL	16.685714285714287
351320	UNITY MEDICAL CENTER	16.674999999999997
170058	MERCY HOSPITAL-FORT SCOTT	16.67142857142857
26023F	COLUMBIA MO VA MEDICAL CENTER	16.650000000000002
111308	CLINCH MEMORIAL HOSPITAL	16.650000000000002
361323	AULTMAN ORRVILLE HOSPITAL	16.633333333333333
330395	ST JOHN'S EPISCOPAL HOSPITAL AT SOUTH SHORE	16.618181818181817
41005F	PROVIDENCE VA MEDICAL CENTER	16.616666666666664
041322	FULTON COUNTY HOSPITAL	16.577777777777776
041331	OZARKS COMMUNITY HOSPITAL OF GRAVETTE	16.575
041300	NORTH LOGAN MERCY HOSPITAL	16.566666666666666
26009F	ST LOUIS-JOHN COCHRAN VA MEDICAL CENTER	16.566666666666666
180106	CLINTON COUNTY HOSPITAL, INC	16.557142857142857
281311	FRANKLIN COUNTY MEMORIAL HOSPITAL	16.55
261334	I-70 COMMUNITY HOSPITAL	16.549999999999997
271341	TRINITY HOSPITAL	16.549999999999997
341314	WASHINGTON COUNTY HOSP INC	16.542857142857144
180139	KENTUCKY RIVER MEDICAL CENTER	16.52857142857143
381324	ST CHARLES - MADRAS	16.525000000000002
041329	MERCY HOSPITAL BERRYVILLE	16.51666666666667
180128	THREE RIVERS MEDICAL CENTER	16.514285714285712
171346	HOSPITAL DISTRICT #6 OF HARPER COUNTY	16.5
171301	ELLINWOOD DISTRICT HOSPITAL	16.5
171345	PAWNEE  VALLEY COMMUNITY HOSPITAL	16.5
040019	FORREST CITY MEDICAL CENTER	16.485714285714288
241357	ESSENTIA HEALTH FOSSTON	16.48333333333333
241346	MAYO CLINIC HEALTH SYSTEM - CANNON FALLS	16.475
Time taken: 0.032 seconds, Fetched: 90 row(s)
hive> 
    > 
    > DROP TABLE IF EXISTS overall_hospital_score;
OK
Time taken: 0.084 seconds
hive> CREATE TABLE overall_hospital_score AS
    > SELECT effective_care_score.provider_id, effective_care_score.name, (readmissions_score.re_score + effective_care_score.ec_score) AS t_score
    > FROM readmissions_score FULL OUTER JOIN effective_care_score
    > ON readmissions_score.provider_id = effective_care_score.provider_id
    > order by t_score DESC;
Query ID = w205_20161008060101_f570ba02-c05b-476b-bcf9-e727313420a9
Total jobs = 2
Launching Job 1 out of 2
Number of reduce tasks not specified. Estimated from input data size: 1
In order to change the average load for a reducer (in bytes):
  set hive.exec.reducers.bytes.per.reducer=<number>
In order to limit the maximum number of reducers:
  set hive.exec.reducers.max=<number>
In order to set a constant number of reducers:
  set mapreduce.job.reduces=<number>
Starting Job = job_1475607266406_0092, Tracking URL = http://ip-172-31-6-204.ec2.internal:8088/proxy/application_1475607266406_0092/
Kill Command = /usr/lib/hadoop/bin/hadoop job  -kill job_1475607266406_0092
Hadoop job information for Stage-1: number of mappers: 2; number of reducers: 1
2016-10-08 06:01:40,319 Stage-1 map = 0%,  reduce = 0%
2016-10-08 06:01:50,107 Stage-1 map = 50%,  reduce = 0%, Cumulative CPU 2.08 sec
2016-10-08 06:01:51,141 Stage-1 map = 100%,  reduce = 0%, Cumulative CPU 4.32 sec
2016-10-08 06:01:58,532 Stage-1 map = 100%,  reduce = 100%, Cumulative CPU 7.8 sec
MapReduce Total cumulative CPU time: 7 seconds 800 msec
Ended Job = job_1475607266406_0092
Launching Job 2 out of 2
Number of reduce tasks determined at compile time: 1
In order to change the average load for a reducer (in bytes):
  set hive.exec.reducers.bytes.per.reducer=<number>
In order to limit the maximum number of reducers:
  set hive.exec.reducers.max=<number>
In order to set a constant number of reducers:
  set mapreduce.job.reduces=<number>
Starting Job = job_1475607266406_0093, Tracking URL = http://ip-172-31-6-204.ec2.internal:8088/proxy/application_1475607266406_0093/
Kill Command = /usr/lib/hadoop/bin/hadoop job  -kill job_1475607266406_0093
Hadoop job information for Stage-2: number of mappers: 1; number of reducers: 1
2016-10-08 06:02:07,431 Stage-2 map = 0%,  reduce = 0%
2016-10-08 06:02:13,808 Stage-2 map = 100%,  reduce = 0%, Cumulative CPU 2.19 sec
2016-10-08 06:02:21,127 Stage-2 map = 100%,  reduce = 100%, Cumulative CPU 4.51 sec
MapReduce Total cumulative CPU time: 4 seconds 510 msec
Ended Job = job_1475607266406_0093
Moving data to: hdfs://localhost:8020/user/hive/warehouse/overall_hospital_score
Table default.overall_hospital_score stats: [numFiles=1, numRows=4808, totalSize=250898, rawDataSize=246090]
MapReduce Jobs Launched: 
Stage-Stage-1: Map: 2  Reduce: 1   Cumulative CPU: 7.8 sec   HDFS Read: 498661 HDFS Write: 294693 SUCCESS
Stage-Stage-2: Map: 1  Reduce: 1   Cumulative CPU: 4.51 sec   HDFS Read: 299133 HDFS Write: 250990 SUCCESS
Total MapReduce CPU Time Spent: 12 seconds 310 msec
OK
Time taken: 49.759 seconds
hive> 
    > SELECT * FROM overall_hospital_score
    > LIMIT 50;
OK
450348	FALLS COMMUNITY HOSPITAL AND CLINIC	251.28333333333333
400079	HOSP COMUNITARIO BUEN SAMARITANO	184.1
451330	MEDINA REGIONAL HOSPITAL	151.25714285714287
310002	NEWARK BETH ISRAEL MEDICAL CENTER	148.61578947368423
400032	HOSPITAL HERMANOS MELENDEZ INC	145.5327485380117
051318	REDWOOD MEMORIAL HOSPITAL	144.48333333333335
261317	MERCY HOSPITAL CASSVILLE	144.1
331316	COMMUNITY MEMORIAL HOSPITAL, INC	141.47916666666666
400013	HOSPITAL MENONITA DE CAYEY	140.675
140300	PROVIDENT HOSPITAL OF CHICAGO	139.96666666666667
511313	BOONE MEMORIAL HOSPITAL	139.87619047619046
330202	KINGS COUNTY HOSPITAL CENTER	138.4051219512195
341311	CHATHAM HOSPITAL INC	138.22
450289	HARRIS HEALTH SYSTEM	136.0811188811189
210002	UNIVERSITY OF MARYLAND MEDICAL CENTER	135.9904761904762
051304	JOHN C FREMONT HEALTHCARE DISTRICT	135.34666666666666
341324	THE OUTER BANKS HOSPITAL, INC	134.25555555555556
140068	ROSELAND COMMUNITY HOSPITAL	134.1345238095238
050060	COMMUNITY REGIONAL MEDICAL CENTER	133.42234432234432
491307	PAGE MEMORIAL HOSPITAL, INC	133.07777777777778
331315	GOUVERNEUR HOSPITAL	132.80714285714285
141334	ST JOSEPH MEMORIAL HOSPITAL	132.4857142857143
111336	MOUNTAIN LAKES MEDICAL CENTER	132.37857142857143
010087	UNIVERSITY OF SOUTH ALABAMA MEDICAL CENTER	132.21428571428572
241302	SANFORD WESTBROOK MEDICAL CENTER	131.5
050776	COLLEGE MEDICAL CENTER	131.43333333333334
110079	GRADY MEMORIAL HOSPITAL	131.2894348894349
330182	ST FRANCIS HOSPITAL, ROSLYN	131.26872586872585
191302	ST MARTIN HOSPITAL	131.16666666666666
050138	KAISER FOUNDATION HOSPITAL - LOS ANGELES	130.35
330306	LUTHERAN MEDICAL CENTER	130.03141025641025
320001	UNM HOSPITAL	129.56666666666666
261316	MERCY HOSPITAL AURORA	129.34285714285716
051314	KERN VALLEY HEALTHCARE DISTRICT	129.17142857142858
240206	RED LAKE HOSPITAL A	129.0
050373	LAC+USC MEDICAL CENTER	128.98027027027027
061301	RIO GRANDE HOSPITAL	128.6142857142857
301302	LITTLETON REGIONAL HEALTHCARE	128.6076923076923
241374	PIPESTONE COUNTY  MEDICAL CENTER	128.5
050315	KERN MEDICAL CENTER	128.3764705882353
290022	DESERT SPRINGS HOSPITAL	128.17556390977444
210013	BON SECOURS HOSPITAL	127.66944444444444
050292	RIVERSIDE COUNTY REGIONAL MEDICAL CENTER	127.27
330395	ST JOHN'S EPISCOPAL HOSPITAL AT SOUTH SHORE	127.11818181818182
330141	BROOKHAVEN MEMORIAL HOSPITAL MEDICAL CENTER	126.98333333333333
181319	BRECKINRIDGE MEMORIAL HOSPITAL	126.86666666666667
330056	BROOKLYN HOSPITAL CENTER AT DOWNTOWN CAMPUS	126.80000000000001
050492	CLOVIS COMMUNITY MEDICAL CENTER	126.74473684210525
450213	UNIVERSITY HEALTH SYSTEM	126.68386491557224
261321	HEDRICK MEDICAL CENTER	126.40357142857142
Time taken: 0.033 seconds, Fetched: 50 row(s)
hive> 


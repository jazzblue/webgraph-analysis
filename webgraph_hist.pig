register s3n://uw-cse-344-oregon.aws.amazon.com/myudfs.jar

-- load data set into Pig
raw = LOAD 's3n://uw-cse-344-oregon.aws.amazon.com/btc-2010-chunk-*' USING TextLoader as (line:chararray);

-- parse each line into ntriples
ntriples = foreach raw generate FLATTEN(myudfs.RDFSplit3(line)) as (subject:chararray,predicate:chararray,object:chararray);

subjects = group ntriples by (subject) PARALLEL 50;

-- compute degree per subject
degree_per_subject = foreach subjects generate flatten($0), COUNT($1) as x_count PARALLEL 50;

-- group subjects by degree
subjects_by_degree = group degree_per_subject by (x_count) PARALLEL 50;

-- compute histogram: count vs degree
hist = foreach subjects_by_degree generate $0, COUNT($1) as y_count PARALLEL 50;

-- store the results in the folder /user/hadoop/results
store hist into '/user/hadoop/results' using PigStorage();

-- count all histogram point
hist_all = GROUP hist ALL PARALLEL 50;
hist_count = foreach hist_all generate COUNT(hist) PARALLEL 50;
--dump hist_count;

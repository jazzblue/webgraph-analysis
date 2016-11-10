register s3n://uw-cse-344-oregon.aws.amazon.com/myudfs.jar

-- load data set into Pig
raw = LOAD 's3n://uw-cse-344-oregon.aws.amazon.com/btc-2010-chunk-*' USING TextLoader as (line:chararray);

-- parse each line into ntriples
ntriples = foreach raw generate FLATTEN(myudfs.RDFSplit3(line)) as (subject:chararray,predicate:chararray,object:chararray);

ntriples_filtered = FILTER ntriples BY subject matches '.*rdfabout\\.com.*';

ntriples_filtered_copy = FOREACH ntriples_filtered GENERATE subject as subject2, predicate as predicate2, object as object2;

distance_2 = DISTINCT (JOIN ntriples_filtered BY object, ntriples_filtered_copy BY subject2 PARALLEL 50) PARALLEL 50;

-- count all chains with distance 2
distance_2_all = group distance_2 ALL PARALLEL 50;
distance_2_count = foreach distance_2_all generate COUNT(distance_2) PARALLEL 50;

dump distance_2_count;


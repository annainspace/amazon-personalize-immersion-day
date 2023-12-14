#!/bin/bash

bucket=$1
echo "Bucket is $bucket"
echo "Domain is $2"

pwd

if [ "$2" == "Retail" ] || [ "$2" == "retail" ]
then
    echo "Preprocess the retail data"
    # this copies and prepares the retail data 

    # THIS SCRIPT IS GENREATED BY EXPORTING /Retail/01_Data_Layer.ipynb
    jupyter nbconvert --to python ../Retail/01_Data.ipynb 
    ipython ../Retail/01_Data.py >./01_Data.out 2>&1
    rm ../Retail/01_Data.py
elif [ "$2" == "Media" ] || [ "$2" == "media" ]

then
    echo "Preprocess the IMDB and Movielens data"
    # this copies and prepares the media data 

    # THIS SCRIPT IS GENREATED BY EXPORTING /Media/01_Data_Layer.ipynb
    jupyter nbconvert --to python ../Media/01_Data.ipynb 
    ipython ../Media/01_Data.py >./01_Data.out 2>&1
    rm ../Media/01_Data.py
fi


sleep 60

echo "Starting the copy to S3 data"
aws s3 cp ./poc_data/users.csv s3://$bucket/train/users.csv
aws s3 cp ./poc_data/interactions.csv s3://$bucket/train/interactions.csv
aws s3 cp ./poc_data/items.csv s3://$bucket/train/items.csv
aws s3 cp ./$2/params.json s3://$bucket/train/params.json


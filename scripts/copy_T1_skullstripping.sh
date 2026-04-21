#!/bin/bash

root="/data03/MRI_hackaton_FR/Data_collection/"

for f in $(find ${root}/bids/ -name "*T1w.nii.gz"); do
  cp "$f" "${f/T1w.nii.gz/ORIG_T1w.nii.gz}"
done


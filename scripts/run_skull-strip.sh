#!/bin/bash

bids_root="/data03/MRI_hackaton_FR/Data_collection/bids"

n_parallel_processes=10

# Exclude *ORIG_T1w.nii.gz so re-runs don't reprocess the backup
find "${bids_root}" -type f -name "*T1w.nii.gz" ! -name "*ORIG*" > T1s_list.txt

xargs -a T1s_list.txt -P ${n_parallel_processes} -I {} bash -c '
    f="{}"

    # Make a cp of the original T1w (only first pass) - in case not done before
    ORIG="${f/T1w.nii.gz/ORIG_T1w.nii.gz}"
    [ ! -f "${ORIG}" ] && cp "${f}" "${ORIG}"

    out_img="${ORIG/.nii.gz/_brain.nii.gz}" #skull stripped image
    out_mask="${ORIG/.nii.gz/_brain_mask.nii.gz}" #skull stripping mask

    ./synthstrip-docker-mod.sh \
        -i "${ORIG}" \
        -o "${out_img}" \
        -m "${out_mask}" \
        -t 10 \
        --no-csf
' # <- note the closing quote

rm T1s_list.txt

# MRI Hackaton - Preprocessing

## 20 - 24 April 2026

Here we will edit and store both documentation and scripts for the MRI hackaton. I made this directory completely open so that everybody can edit everything. 

```bash
chmod 1777 /data00/MRI_hackaton 
setfacl -d -m u::rwx,g::rwx,o::rwx /data00/MRI_hackaton
```

The directory is linked to a [github repo](https://github.com/leonardocerliani/MRI_hackaton) and I will push modifications to the repo frequently.


## Programme and setup

The main steps for the preprocessing for Anouk and I are:
- skullstripping (maybe only Anouk)
- fMRIprep run (generating confounds file with sin and cosine)
nuisance regression with WM+CSF+FD(+6 parameters?) 
- ICA aroma to detect motion components to regress out with the rest
- regress with sin/cosine predictors as temporal filtering step
- gaussian smoothing with https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dTproject.html
- parcellation step to average timeseries according to ROIs

_Iff we have time_, we will also prepare a tool to inspect the results of the preprocessing including a simple ISC like the ones we did with Francisca [here](http://localhost:3838/QA_GUTS/) (open the port 3838 on storm to see it locally on your computer). Ideally this should be able to get the location of your folder with fmriprep+preprocessing and do everything by itself

One big part of the whole feat will **preparing the environment**. Tentatively, we need to have all of the following available

- data in bids (prepared using bidscoin)
- fmriprep docker image
- synthstrip docker
- fsl (for various things including `fsl_regfilt`)
- ICA aroma
- python (of course)
- AFNI for gaussian smoothing (probably the only thing still missing)
- some parcellation schemes (Yeo, Schaefer, Juelich, add your favourite - I already have most of these atlases)

NB: you can inspect docker images with `docker image ls`. I notice that for some tools we have multiple versions, so we will also decide which one to use/keep and which ones to remove.

In addition we need some **sample data**. Tentatively, I will be using a subset of Anouk's data in `/dataGUTS2/GUTS/sample_data`, but let me know if you prefer something else.

It is important to have some sample data for me to start to develop the procedure, and for you so that you can test the procedure on something known to work, and then apply it to your data. If you prefer, you might also proceed to apply the procedure directly to your data, but I would suggest in this case to **start with a subsample of your participants in a folder that you can easily delete and recreate**.


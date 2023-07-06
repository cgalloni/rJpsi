####################
# This is the flatter script
####################

# 
# Location where output files will be stored
#
pnfs="/pnfs/psi.ch/cms/trivcat/store/user/${USER}/RJpsi/"
#pnfs="/pnfs/psi.ch/cms/trivcat/store/user/${USER}/RJpsi/"


#
# analysis to be run runTauDisplay_XXX.py
# XXX is the name here. 
#
analysis="BcJpsiTauNu"
#analysis="JpsiPi"


#
# Write here the "top directory" name of the Ntuplizer files
# The rest of files under this directory will be processed
# 
# You can get it by doing 
# uberftp -ls gsiftp://storage01.lcg.cscs.ch//pnfs/lcg.cscs.ch/cms/trivcat/store/user/ytakahas/
# 
#sigmc="BcToJPsiMuMu_Legacy_2018_20210520"




priority="pt"
nchunk_sig=10
nchunk_bg=1
nchunk_data=4


#priority="multiple"
#nchunk_sig=5
#nchunk_bg=1
#nchunk_data=2






#outdir="job_${priority}_vprobfsigcr"

#########################################
# for signal MC
#########################################
for year in 2016 2017 2018
#for year in 2016
do

#    outdir="job_JpsiPi_${priority}_${year}"
    outdir="job_inv_${priority}_${year}_MuonPhys"


    sigmc="BcToJPsiMuMu_MuonPhys_${year}_20230623"   #"BcToJPsiMuMu_Legacy_2018_20220122"
    bgmc="HbToJPsiMuMu_MuonPhys_${year}_20230623"
    bgmc2="JPsiMuMu_MuonPhys_${year}_20230623"
    dataset="Charmonium_MuonPhys_GJSON_${year}_20230623"

    echo "-------------------------------------"
    echo $year
    echo "-------------------------------------"
    echo $sigmc
    echo $bgmc
    echo $bgmc2
    echo $dataset
    echo "-------------------------------------"

    echo "signal"

    if [ $year = "2016" ]; then
	python getDataset.py --file ${sigmc} --chunk 1 --analysis ${analysis} --type signal --name BcJpsiTau_inclusive --select UL --year $year --priority ${priority} --odir ${pnfs} --jdir ${outdir}
    else
	python getDataset.py --file ${sigmc} --chunk ${nchunk_sig} --analysis ${analysis} --type signal --name BcJpsiTau_inclusive --select UL --year $year --priority ${priority} --odir ${pnfs} --jdir ${outdir}
    fi

    echo "bkg."
    python getDataset.py --file ${bgmc} --chunk ${nchunk_bg} --analysis ${analysis} --type bg --name BJpsiX --year ${year} --priority ${priority} --odir ${pnfs} --jdir ${outdir}

    if [ $year = "2018" ]; then
	echo $year
	python getDataset.py --file ${bgmc2} --chunk ${nchunk_bg} --analysis ${analysis} --type bg --name BJpsiX_inclusive --year ${year} --priority ${priority} --odir ${pnfs} --jdir ${outdir}
    fi

    echo "data", $year
    python getDataset.py --file ${dataset} --chunk ${nchunk_data} --analysis ${analysis} --type data --name Data --priority ${priority} --odir ${pnfs} --jdir ${outdir}

done




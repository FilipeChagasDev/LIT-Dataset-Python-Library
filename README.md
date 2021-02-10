# LIT Dataset Python Library
By Filipe Chagas (filipe.ferraz0@gmail.com)

LIT is a voltage and current dataset for household utensils designed at UTFPR University, in the state of Paraná (Brazil). For more information, visit the official page (https://pessoal.dainf.ct.utfpr.edu.br/douglasrenaux/LIT_Dataset/). I have no connection with the research project team that designed this dataset, but I created this small library to facilitate the use of the dataset with Python.

## Downloading the dataset
To download dataset files, you can use the **download.py** script, but you will be asked for the dataset password at the decompression stage. To obtain this password, you need to register on the official dataset page.

Note: **download.py** will download only the Synthetic subset. You will need to modify this script to download other subsets.

## Preprocessing data with Matlab
Using this dataset requires preprocessing done with Matlab (and no, you will not be able to do this using Octave). For that, there are some Matlab scripts in the **LIT_Dataset/Tools** directory. Run the **LIT_bin2mat.m** script and let it work. 

**IMPORTANT NOTE:** These Matlab scripts were originally developed by the LIT dataset team, but I made some changes so that Scipy was able to load the processed data. Therefore, **the Matlab scripts contained in this repository are not the same as the scripts that are available for download on the official dataset page**.

## Python lit library usage

### Documentation
All non-internal functions of this library are in the **lit.py** file and have description docstrings. Consult this file if you are looking for the documentation for this library.

### Tutorial
The **tutorial.ipynb** file is a jupyter notebook that contains step-by-step explanations of how to use this library. See this file.



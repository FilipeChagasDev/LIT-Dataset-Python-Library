""" 
Description: This script should download the necessary files from the LIT dataset.
            If the download process fails, you must resume the download from the file
            where you left off.

Author: Filipe Chagas (filipe.ferraz0@gmail.com)

November 2020
"""

import requests
import os
from os.path import join as pjoin
import sys
from zipfile import ZipFile
from display.progress_bar import print_progress_bar, end_progress_bar 

dirs = [
    pjoin('LIT_Dataset', 'RAW_Data'),
    pjoin('LIT_Dataset', 'RAW_Data', 'Natural'),
    pjoin('LIT_Dataset', 'RAW_Data', 'Simulated'),
    pjoin('LIT_Dataset', 'RAW_Data', 'Synthetic'),
    pjoin('LIT_Dataset', 'Matlab_Data'),
    pjoin('LIT_Dataset', 'Matlab_Data', 'Natural'),
    pjoin('LIT_Dataset', 'Matlab_Data', 'Simulated'),
    pjoin('LIT_Dataset', 'Matlab_Data', 'Synthetic'),
    pjoin('LIT_Dataset', 'zip')
]

"""
The following list contains the URLs for the zip files.
If these links are broken, you should go to the official website of the LIT-Dataset project and find the download links for the respective zip files.
"""
zip_files = [
    #(ZIP_NAME, ZIP_PATH, DOWNLOAD_URL)
    ('sy1.zip', pjoin('LIT_Dataset', 'zip', 'sy1.zip'), 'https://nuvem.utfpr.edu.br/index.php/s/cFX5sEagGyprLW4/download?path=%2FSynthetic&files=sy1.zip'),
    ('sy2.zip', pjoin('LIT_Dataset', 'zip', 'sy2.zip'), 'https://nuvem.utfpr.edu.br/index.php/s/cFX5sEagGyprLW4/download?path=%2FSynthetic&files=sy2.zip'),
    ('sy3.zip', pjoin('LIT_Dataset', 'zip', 'sy3.zip'), 'https://nuvem.utfpr.edu.br/index.php/s/cFX5sEagGyprLW4/download?path=%2FSynthetic&files=sy3.zip'),
    ('sy8.zip', pjoin('LIT_Dataset', 'zip', 'sy8.zip'), 'https://nuvem.utfpr.edu.br/index.php/s/cFX5sEagGyprLW4/download?path=%2FSynthetic&files=sy8.zip')
]

unzip_paths = [
    #(ZIP_NAME, ZIP_PATH, UNZIP_PATH)
    ('sy1.zip', pjoin('LIT_Dataset', 'zip', 'sy1.zip'), pjoin('LIT_Dataset', 'RAW_Data', 'Synthetic')),
    ('sy2.zip', pjoin('LIT_Dataset', 'zip', 'sy2.zip'), pjoin('LIT_Dataset', 'RAW_Data', 'Synthetic')),
    ('sy3.zip', pjoin('LIT_Dataset', 'zip', 'sy3.zip'), pjoin('LIT_Dataset', 'RAW_Data', 'Synthetic')),
    ('sy8.zip', pjoin('LIT_Dataset', 'zip', 'sy8.zip'), pjoin('LIT_Dataset', 'RAW_Data', 'Synthetic'))
]

def size_to_text(size: int) -> str:
    """
    Converts size in bytes to a string with the size in B, KiB, MiB or GiB.
    Args:
        size (int): Size in bytes.

    Returns:
        str: String with size in B/KiB/MiB/GiB.
    """
    if  size < 1024:
        return f'{size} B'
    elif size >= 1024 and size < 1024**2:
        return f'{size//1024} KiB'
    elif size >= 1024**2 and size < 1024**3:
        return f'{size//(1024**2)} MiB'
    elif size >= 1024**3:
        return f'{size//(1024**3)} GiB'

def download(target_path: str, url: str):
    """
    Download the file showing a progress bar in the terminal.
    The downloaded data is stored in file with '.incomplete' extension until the download is complete.

    Args:
        target_path (str): Path to the target file (where the downloaded data will be in).
        url (str): HTTP(s) URL for the download.
    """
    r = requests.get(url, stream=True)
    size = int(r.headers.get('content-length', 0))

    if os.path.exists(target_path + '.incomplete'):
        print('Removing incomplete download trash of')
        os.remove(target_path + '.incomplete')

    with open(target_path + '.incomplete', 'wb') as target_file:
        size_downloaded = 0
        for data in r.iter_content(1024):
            if size > 1024:
                size_downloaded += 1024 if size - size_downloaded >= 1024 else size - size_downloaded
            else:
                size_downloaded += size

            print_progress_bar(size_downloaded, size, prefix='Progress:', suffix='of '+size_to_text(size), length=50)
            target_file.write(data)
    end_progress_bar() 
    os.rename(target_path + '.incomplete', target_path)

def make_dirs():
    for dir in dirs:
        if not os.path.exists(dir):
            print('Creating', dir)
            os.mkdir(dir)
        else:
            print(dir, 'already created')

def download_zips():
    for name, path, url in zip_files:
        if not os.path.exists(path):
            print('Downloading', name)
            download(path, url)
        else:
            print(name, 'already downloaded')

def extract_zips(password: str):
    for name, path, target in unzip_paths:
        print('Extracting', name)
        with ZipFile(path) as z:
            z.setpassword(pwd = bytes(password, 'utf-8'))

            progress = 0 #quantity of extracted files
            files = z.namelist() #list of files and dirs in the zip
            total = len(files) #quantity of files
            
            #Extract file by file
            for file in files:
                print_progress_bar(progress, total, length=40, suffix=file+'      ')
                z.extract(member=file, path=target)
                progress += 1
            
            print_progress_bar(progress, total, length=40, suffix='               ')
            end_progress_bar()

if __name__ == '__main__':
    print('LIT_Dataset download script')

    if not os.path.exists(pjoin('LIT_Dataset','Tools')):
        print('ISSUE: \'LIT_Dataset/Tools\' dir not found.')
        print('You need to use the modified Matlab scripts present in the NILM-Siamese-Net repository on GitHub.')
        print('Aborting operation...')
        sys.exit()

    print('ATTENTION: You will be asked to enter a password when extracting downloaded zip files. To acquire this password, register on the official website of the LIT-Dataset or contact the authors.')
    
    while True:
        ans = input('Do you want to proceed with this operation? [y/n]: ').lower()
        if ans == 'y':
            break
        elif ans == 'n':
            print('Aborting operation...')
            sys.exit()
        else:
            print('Invalid input!')

    print('--- Build dir tree ---')
    make_dirs()

    print('--- Downloading zip files ---')
    download_zips()

    print('--- Extracting zip files ---')
    password = input('PASSWORD: ')
    extract_zips(password)

    print('All done!')

                

            

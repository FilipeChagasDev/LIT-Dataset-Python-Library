"""
Author: Filipe Chagas

November 2020
"""

import psutil
import sys

def memory_warning(required_memory_GiB: float):
    """
    This function prints a high memory consumption warning and asks the user to free memory if there is not enough memory available.
    Args:
        required_memory_GiB (float): Required memory (in GiB).
    """
    print('WARNING: This operation will consume a lot of memory!')
    print('- It is recommended to have at least {:.2f}GiB of memory available for that.'.format(required_memory_GiB))
    while True:
        gib_available = psutil.virtual_memory().available / (1024**3)
        print('- You currently have {:.2f}GiB of memory available.'.format(gib_available))
        if gib_available < required_memory_GiB:
            if psutil.virtual_memory().total / (1024**3) > required_memory_GiB:
                print('- It is recommended that you free up some memory.')
            else:
                print('- Your computer\'s memory is insufficient and you are likely to have problems. You can try to use PyPy to reduce memory consumption.')

            if input('Do you want to recheck the available memory before proceeding? [y/n]: ').lower() == 'n':
                if input('Do you want to cancel this operation and close the program? [y/n]: ').lower() == 'y':
                    sys.exit()
        else:
            break
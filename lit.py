""" 
Description: This library must load and manipulate data from the LIT dataset.

Author: Filipe Chagas (filipe.ferraz0@gmail.com)

October 2020
"""

import os
from typing import TypeVar, Iterable, Tuple, List
from enum import Enum
from scipy.io import loadmat
import numpy as np

lit_path = os.path.join('LIT_Dataset','Matlab_Data')

def set_dataset_dir_path(path: str):
    """
    When this module is imported by a script in another root dir,
    the path to the dataset dir must be defined with that function.

    Args:
        path (str): Path to the dataset dir.
    """
    globals()['lit_path'] = os.path.join(path, 'LIT_Dataset','Matlab_Data')
    
    globals()['subset_path'] = {
        Subset.SYNTHETIC: os.path.join(lit_path, 'Synthetic'),
        Subset.SIM_IDEAL: os.path.join(lit_path, 'Simulated', 'Sim_Ideal'),
        Subset.SIM_INDUCT: os.path.join(lit_path, 'Simulated', 'Sim_Induct'),
        Subset.SIM_INDUCT_HARMO: os.path.join(lit_path, 'Simulated', 'Sim_Induct_Harmo'),
        Subset.SIM_INDUCT_HARMO_SNR_10: os.path.join(lit_path, 'Simulated', 'Sim_Induct_Harmo_SNR_10'),
        Subset.SIM_INDUCT_HARMO_SNR_30: os.path.join(lit_path, 'Simulated', 'Sim_Induct_Harmo_SNR_30'),
        Subset.SIM_INDUCT_HARMO_SNR_60: os.path.join(lit_path, 'Simulated', 'Sim_Induct_Harmo_SNR_60')
    }

class Subset(Enum):
    SYNTHETIC = 1
    SIM_IDEAL = 2
    SIM_INDUCT = 3
    SIM_INDUCT_HARMO = 4
    SIM_INDUCT_HARMO_SNR_10 = 5
    SIM_INDUCT_HARMO_SNR_30 = 6
    SIM_INDUCT_HARMO_SNR_60 = 7

subset_path = {
    Subset.SYNTHETIC: os.path.join(lit_path, 'Synthetic'),
    Subset.SIM_IDEAL: os.path.join(lit_path, 'Simulated', 'Sim_Ideal'),
    Subset.SIM_INDUCT: os.path.join(lit_path, 'Simulated', 'Sim_Induct'),
    Subset.SIM_INDUCT_HARMO: os.path.join(lit_path, 'Simulated', 'Sim_Induct_Harmo'),
    Subset.SIM_INDUCT_HARMO_SNR_10: os.path.join(lit_path, 'Simulated', 'Sim_Induct_Harmo_SNR_10'),
    Subset.SIM_INDUCT_HARMO_SNR_30: os.path.join(lit_path, 'Simulated', 'Sim_Induct_Harmo_SNR_30'),
    Subset.SIM_INDUCT_HARMO_SNR_60: os.path.join(lit_path, 'Simulated', 'Sim_Induct_Harmo_SNR_60')
}

available_number_of_appliances = {
    Subset.SYNTHETIC: [1,2,3,8],
    Subset.SIM_IDEAL: [1,2,3,4,5],
    Subset.SIM_INDUCT: [1,2,3,4,5],
    Subset.SIM_INDUCT_HARMO: [1,2,3,4,5],
    Subset.SIM_INDUCT_HARMO_SNR_10: [1,2,3,4,5],
    Subset.SIM_INDUCT_HARMO_SNR_30: [1,2,3,4,5],
    Subset.SIM_INDUCT_HARMO_SNR_60: [1,2,3,4,5]
}

def list_loads(subset: Subset, n_appliances: int) -> list:
    """
    Gets a list of loads (appliances combinations) shortnames.

    Args:
        subset (Subset): Data subset which the loads is in.
        n_appliances (int): Number of appliances in the loads.

    Returns:
        list: List of loads shortnames. Ex: '1A0', '1B0', '2A0B0', ... 
    """

    assert n_appliances in available_number_of_appliances[subset]
    return os.listdir(os.path.join(subset_path[subset],str(n_appliances)))

def list_waveforms(subset: Subset, shortname: str) -> Tuple[List[str], str]:
    """
    Lists waveforms filenames.

    Args:
        subset (Subset): Data subset which the waveforms is in.
        shortname (str): Load shortname. Ex: '1A0', '1B0', '2A0B0', ... 

    Returns:
        Tuple[List[str], str]: A pair with [0] a list of waveforms filenames and [1] the path to the root dir of the waveforms.
    """

    load_path = os.path.join(subset_path[subset], shortname[0], shortname)
    assert os.path.exists(load_path)
    return (os.listdir(load_path), load_path)

class Waveform(object):
    class Mode(Enum):
        LOAD=1
        CLONE=2

    # --- Init methods ---

    def __init__(self, mode: Mode = Mode.LOAD, mat_path: str = None, source_obj = None):
        """
        Args:
            mode (Waveform.Mode, optional): Specifies one of two modes: LOAD and CLONE. 
                                  In LOAD mode, a mat file is loaded.
                                  In CLONE mode, the data is cloned from a source Waveform object.
                                  Defaults to LOAD.
            mat_path (str, optional): Path to the mat Waveform file. Defaults to None.
            source_obj (Waveform, optional): Path to the source object. Defaults to None.
        """

        if mode == Waveform.Mode.LOAD:
            self.load_mat(mat_path)
        else: #when mode == Waveform.Mode.CLONE
            self.clone_obj(source_obj)
        
        self.analyze()

    def clone_obj(self, source_obj):
        """
        Internal method. Clone data from the source object.
        Args:
            source_obj (Waveform): Source object.
        """
        assert source_obj != None
        
        #Clone data from de source object
        self.load_short_name = source_obj.load_short_name        
        self.load_description = source_obj.load_description
        self.current = np.copy(source_obj.current)
        self.voltage = np.copy(source_obj.voltage) 
        self.labels = source_obj.labels.copy()
        self.labels_np = np.copy(source_obj.labels_np)
        self.events = np.copy(source_obj.events)
        self.sample_rate = source_obj.sample_rate
        self.frequency = source_obj.frequency
        self.duration = source_obj.duration

    def load_mat(self, path: str):
        """
        Internal Method. Load data from the mat waveform file.
        Args:
            path (str): Mat file path.
        """
        assert path != None
        assert os.path.exists(path)

        # Load data from the mat file
        mat = loadmat(path)
        self.load_short_name = mat['load_descr_short'][0]        
        self.load_description = mat['load_descr'][0]
        self.current = mat['iHall'].transpose()[0]
        self.voltage = mat['vGrid'].transpose()[0] 
        self.labels = [l[0] for l in mat['labels'].transpose()[0]]
        self.labels_np = np.array([l[0] for l in mat['labels'].transpose()[0]])
        self.events = mat['events_r'].transpose()[0]
        self.sample_rate = mat['sps'][0][0]
        self.frequency = mat['mains_freq'][0][0]
        self.duration = mat['duration_t'][0][0]

    def analyze(self):
        """
        Internal method. Gets some informations beyond is in the Mat file.
        """
        # Calculate the Nyquist Frequency
        self.nyquist_frequency = self.sample_rate / 2

        # Number of appliances in the load
        self.n_appliances = int(self.load_short_name[0])
        
        # List short names of the appliances
        self.appliances_short_names = [] #Example: ['A0', 'B0', ...]   
        for i in range(1,len(self.load_short_name),2):
            self.appliances_short_names.append(self.load_short_name[i] + self.load_short_name[i+1])
        
        # Indexes where each appliance turn-on
        self.appliance_turn_on = dict() #format: { appliance-short-name : turn-on-index }
        for i in np.where(self.events == 1)[0]:
            self.appliance_turn_on[self.labels[i]] = i

        # Indexes where each appliance turn-off
        self.appliance_turn_off = dict() #format: { appliance-short-name : turn-off-index }
        for i in np.where(self.events == -1)[0]:
            self.appliance_turn_off[self.labels[i]] = i

    def get_turnon_indexes(self) -> List[Tuple[int,str]]:
        """Returns a list of indexes where the appliances turn-on.

        Returns:
            List[Tuple[int,str]]: List of tuples - [(index_0, shortname_0),(index_1, shortname_1),...]
        """
        indexes = np.where(self.events == 1)[0]
        shortnames = self.labels_np[indexes]
        l = [list(indexes), list(shortnames)]
        return list(map(tuple, zip(*l)))

    def get_turnoff_indexes(self) -> List[Tuple[int,str]]:
        """Returns a list of indexes where the appliances turn-off.

        Returns:
            List[Tuple[int,str]]: List of tuples - [(index_0, shortname_0),(index_1, shortname_1),...]
        """
        indexes = np.where(self.events == -1)[0]
        shortnames = self.labels_np[indexes]
        l = [list(indexes), list(shortnames)]
        return list(map(tuple, zip(*l)))

    def get_turnedon_current(self) -> np.ndarray:
        """Returns the current of all appliances turned-on.

        Returns:
            np.ndarray: 1D current signal
        """
        last_turnon = self.get_turnon_indexes()[-1][0]
        first_turnoff = self.get_turnoff_indexes()[0][0]
        return self.current[last_turnon:first_turnoff]

    def get_turnedon_voltage(self) -> np.ndarray:
        """Returns the current of all appliances turned-on.

        Returns:
            np.ndarray: 1D current signal
        """
        last_turnon = self.get_turnon_indexes()[-1][0]
        first_turnoff = self.get_turnoff_indexes()[0][0]
        return self.voltage[last_turnon:first_turnoff]



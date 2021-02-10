import pandas as pd
import os
import numpy as np

def read_file(path):
	f = open(path,'r')
	txt = f.read()
	lines = txt.split('\n')
	lines = lines[2:10]
	data = [x.split(':') for x in lines]
	out = dict()
	out['shortname'] = path.split('/')[-2]
	for d in data:
		out[d[0]] = [d[1]]
	return out
	
roots = ['1/1A0','1/1B0','1/1C0','1/1D0','1/1E0','1/1F0','1/1G0','1/1H0','1/1I0','1/1J0','1/1K0','1/1L0','1/1M0','1/1N0','1/1O0','1/1P0','1/1Q0','1/1R0','1/1S0','1/1T0','1/1U0','1/1V0','1/1W0','1/1X0','1/1Y0','1/1Z0']


path = os.path.join('RAW_Data','Synthetic',roots[0],'Description.txt')
data = read_file(path)
df = pd.DataFrame(data)

for root in roots[1:]:
	path = os.path.join('RAW_Data','Synthetic',root,'Description.txt')
	data = read_file(path)
	df = df.append(pd.DataFrame(data))
	
print('generating spreadsheet')
df.to_excel('lit_appliances.xlsx')

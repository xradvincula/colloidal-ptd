import sys

# this script extracts the atom description of the timestep of interest (configuration)

def is_timestep_line(line, timestep):
	parts = line.strip().split(' ')
	return len(parts) == 3 and parts[2] == timestep
	
def is_data_column(line):
	parts = line.strip().split(' ')
	return len(parts) == 4

def accum_data(f):
	data = []
	for line in f:
		if is_data_column(line):
			data.append(line)
		else:
			return data
		
def extract(filename, timestep):
	# open file
	with open(filename, 'r') as f:
		accumulate = False
		prev_line = None
		for line in f:
			if 'Timestep' in line:
				if is_timestep_line(line, timestep):
					data = accum_data(f)
					data.insert(0, line)
					data.insert(0, prev_line)
					return data
			prev_line = line
	return None

def print_data(data):
	for d in data:
		sys.stdout.write(d)

if __name__ == '__main__':
	if len(sys.argv) < 3:
		print('need a file and a timestep')
		sys.exit(1)
	filename = sys.argv[1]
	timestep = sys.argv[2]
	data = extract(filename, timestep)
	if data is None:
		print('timestep not found')
		sys.exit(0)
	print_data(data)

import re
import sys

if __name__ == "__main__":
  with open(sys.argv[1]) as fh:
    core = 0
    for line in fh:
      if re.search("([0-2][0-9]:[0-5][0-9]:[0-5][0-9])", line):
        core = 0
        print('\n'+line[:-1],end='')
      elif line[0:4] == 'Core':
        words = line.split()
        print(','+words[0]+str(core)+','+words[2][1:5],end='')
        core+=1

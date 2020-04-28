import sys

if __name__ == "__main__":
  with open(sys.argv[1]) as fh:
    unit='MHz'
    for line in fh:
      if line[0:3] != 'cpu':
        print('\n'+line[:-1], end='')
      else:
        words=line.split(' ')
        print(','+words[0]+','+words[3][:-1],end='')

import time


def yes_or_no(n, m, g, s):
  '''
  We redefine the algorithm function to use it in 'testing' (see below).
  '''
  occurrences = {}                      
  for i in range(1, n + 1):             
    occurrences[i] = s.count(i)
  if (g >= n):
    print("YES")
    return
  else:
    budget = g 
    encountered = []
    for i in range(m):
      if s[i] not in encountered:
        encountered.append(s[i])
        budget -= 1
        occurrences[s[i]] -= 1
        if budget < 0:
          print("NO")
          return
        if occurrences[s[i]] == 0:
          budget += 1
      else:
        occurrences[s[i]] -= 1
        if occurrences[s[i]] == 0:
          budget += 1
    print("YES")
    return


def read_from_file(file_path):
  '''
  This function reads an input from a file.txt splitting the file lines and
  returns the parameters N, M, G and the sequence of students.
  '''
  f = open(file_path, 'r')                      
  lines = f.readlines()
  f.close()
  parameters = lines[0].strip().split(' ')
  sequence = lines[1]
  n = int(parameters[0])
  m = int(parameters[1])
  g = int(parameters[2])
  s = [int(s) for s in sequence.split(' ')]
  return n, m, g, s


#TESTS
#After experimenting a bit, we found some sequences that work well
#with N = 15 and G = 10 for small input sizes:
l_10 = [3, 5, 4, 2, 5, 5, 1, 2, 1, 1]
l_50 = [5, 3, 2, 4, 2, 4, 6, 8, 3, 1,
        2, 9, 9, 8, 5, 8, 8, 2, 6, 9,
        8, 6, 7, 5, 4, 4, 2, 2, 1, 1,
        7, 6, 10, 1, 1, 1, 4, 9, 7, 6,
        4, 9, 10, 9, 1, 5, 5, 1, 6, 5]
l_100 = [5, 4, 14, 12, 8, 9, 4, 6, 15, 9, 15, 9, 5, 14, 6, 9, 6, 10, 10, 6,
        9, 3, 15, 9, 8, 3, 9, 14, 4, 14, 13, 13, 8, 3, 4, 3, 4, 6, 9, 10,
        5, 3, 10, 15, 9, 10, 10, 2, 4, 6, 15, 1, 3, 11, 6, 1, 1, 13, 13, 2,
        14, 1, 8, 3, 13, 6, 6, 10, 10, 3, 10, 7, 7, 14, 2, 10, 11, 3, 13, 3,
        1, 10, 14, 13, 1, 14, 6, 14, 11, 14, 2, 7, 10, 3, 15, 11, 1, 7, 11, 15]
#Starting from these, we define some dumb sequences that will trivially
#make the algorithm return "YES" for bigger input sizes.
l_500 = l_100 + [15] * 400
l_1000 = l_100 + [15] * 900
l_5000 = l_100 + [15] * 4900
l_10000 = l_100 + [15] * 9900


def testing(N, M_list, G):
  '''
  This function runs some tests with the previously defined lists for
  the corrispondend input size, given N and M.
  '''
  l = [l_10, l_50, l_100, l_500, l_1000, l_5000, l_10000]
  y = []
  for i in range(len(M_list)):
    start = time.time()
    yes_or_no(N, M_list[i], G, l[i])
    end = time.time() 
    y.append(end - start)
  return y


def print_results(M_list, y):
  '''
  This function simply reports the results obtained in testings.
  '''
  for i in range(len(y)):
    print("Running time with {} students:".format(M_list[i]), y[i])

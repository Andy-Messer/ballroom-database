import random
import numpy as np

num = 3
couples = open('couples_cat_' + str(num), 'r')
couples_list = couples.read().split()
dances = [
    'S', 'Ch', 'R', 'P', 'J'
]
dances_statistics = {'S': [-random.randrange(1, 101, 1) for i in range(len(couples_list))],
                     'Ch': [-random.randrange(1, 101, 1) for i in range(len(couples_list))],
                     'R': [-random.randrange(1, 101, 1) for i in range(len(couples_list))],
                     'P': [-random.randrange(1, 101, 1) for i in range(len(couples_list))],
                     'J': [-random.randrange(1, 101, 1) for i in range(len(couples_list))]}

for couple_i in range(len(couples_list)):
    for dance in dances:
        print("INSERT INTO ballroom_database.scores\nVALUES (" + str(num) + ", " + couples_list[
            couple_i] + ", '" + dance + "', " + str(-dances_statistics[dance][couple_i]) + ", " +
              str(np.argsort(dances_statistics[dance]).tolist().index(couple_i) + 1) + ");")
couples.close()

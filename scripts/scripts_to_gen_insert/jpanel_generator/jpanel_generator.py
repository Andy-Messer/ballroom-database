import random


def get_judge(ind, jn):
    return "INSERT INTO ballroom_database.judging_panel\nVALUES(" + str(ind) + ", " + str(jn) + ");"


def get_jpanel(id):
    j_ids = random.sample([i for i in range(1, 21)], 5)
    for j in j_ids:
        print(get_judge(id, j))


for i in range(1, 12):
    get_jpanel(i)

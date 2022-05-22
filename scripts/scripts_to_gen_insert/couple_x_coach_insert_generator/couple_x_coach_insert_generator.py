import random

coach_ids = [i for i in range(1, 21)]
couple_ids = [i for i in range(1, 55)]
for couple in couple_ids:
    latin = random.choice(coach_ids)
    standard = latin
    while latin == standard:
        standard = random.choice(coach_ids)
    print('INSERT INTO ballroom_database.couple_x_coach\nVALUES(' + str(couple) + ", " + str(
        standard) + ", '" + 'Standard' + "');")
    print('INSERT INTO ballroom_database.couple_x_coach\nVALUES(' + str(couple) + ", " + str(
        latin) + ", '" + 'Latin' + "');")

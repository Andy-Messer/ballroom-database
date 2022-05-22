from datetime import date, timedelta
import random


def daterange(start_date, end_date):
    for n in range(int((end_date - start_date).days)):
        yield start_date + timedelta(n)


def get_random_date_in_range(start_date=date(2013, 1, 1), end_date=date(2015, 6, 2)):
    dates = []
    for single_date in daterange(start_date, end_date):
        dates.append(single_date)
    return random.choice(dates)


dancers_time_base = {}
for i in range(1, 101):
    dancers_time_base[i] = date(2018, 1, 1)


def get_random_couple_insert(ind):
    end_date = date(2022, 12, 31)
    random_woman = random.randrange(4, 101, 2)
    if random_woman % 2 != 0:
        random_woman += 1
    while dancers_time_base[random_woman] == end_date:
        random_woman += 2
        random_woman %= 101
        if random_woman == 0:
            random_woman = 4
    random_man = random.randrange(3, 101, 2)
    while dancers_time_base[random_man] == end_date:
        random_man += 2
        random_man %= 101
        if random_man == 0:
            random_man = 3
    random_club = random.randrange(1, 11, 1)
    if random_club == 0:
        random_club += 1

    start_date = max(dancers_time_base[random_man], dancers_time_base[random_woman])
    new_start_date = end_date
    while new_start_date == end_date:
        if new_start_date - end_date == 0:
            return 1
        new_start_date = get_random_date_in_range(start_date, end_date)
    new_end_date = new_start_date
    while new_start_date == new_end_date:
        if new_start_date - end_date == 0:
            return 1
        new_end_date = get_random_date_in_range(new_start_date, end_date)
    dancers_time_base[random_man] = new_end_date
    dancers_time_base[random_woman] = new_end_date
    insert = "INSERT INTO ballroom_database.couple\nVALUES (" + str(ind) + ", " + str(random_man) + ", " + str(
        random_woman) + ", " + str(random_club) + ", '" + new_start_date.strftime(
        "%Y-%m-%d") + "', '" + new_end_date.strftime("%Y-%m-%d") + "');"
    return insert

for i in range(2, 101):
    print(get_random_couple_insert(i))


import random
import string


def random_char(char_num):
    return ''.join(random.choice(string.ascii_letters) for _ in range(char_num))


def get_random_email():
    return random_char(7) + "@gmail.com"


def get_new_random_coach_insert(index, club_ids, man_names, man_surnames, judge_categories, ratings):
    return "INSERT INTO ballroom_database.coach\nVALUES (" + str(index) + ", " + str(
        random.choice(club_ids)) + ", '" + get_random_email() + "', '" + random.choice(
        man_names) + " " + random.choice(man_surnames) + "', '" + random.choice(judge_categories) + "', " + str(
        random.choice(ratings)) + ", " + str(random.choice(ratings)) + ");"


man_names = open('man_names', 'r')
list_of_man_names = man_names.read().split()
man_surnames = open('man_surnames', 'r')
list_of_man_surnames = man_surnames.read().split()
growths_m = [i for i in range(170, 191)]
weights_m = [i for i in range(65, 89)]
ages = [i for i in range(19, 23)]
age_categories = ['Взрослые']
classes = ['C', 'D', 'E', 'A', 'B', 'M', 'S']
actives = ['True', 'False']
points = [i for i in range(0, 17)]

woman_names = open('woman_names', 'r')
list_of_woman_names = woman_names.read().split()
woman_surnames = open('woman_surnames', 'r')
list_of_woman_surnames = woman_surnames.read().split()
growths_w = [i for i in range(165, 180)]
weights_w = [i for i in range(50, 70)]
club_ids = [i for i in range(1, 11)]
j_cat = ['Первая', 'Вторая', 'WDSF']
ratings = [i for i in range(1, 101)]
for i in range(1, 21, 1):
    print(get_new_random_coach_insert(i, club_ids, list_of_man_names, list_of_man_surnames, j_cat, ratings))

man_surnames.close()
man_names.close()

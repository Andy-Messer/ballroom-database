import random
import string


def random_char(char_num):
    return ''.join(random.choice(string.ascii_letters) for _ in range(char_num))


def get_random_email():
    return random_char(7) + "@gmail.com"


def get_new_random_man_insert(index, man_names, man_surnames, growths, weights, ages, age_categories, classes, actives,
                              points):
    return "INSERT INTO ballroom_database.dancer\nVALUES (" + str(index) + ", '" + random.choice(
        man_names) + " " + random.choice(man_surnames) + "', " + str(random.choice(growths)) + ", " + str(
        random.choice(weights)) + ", " + str(random.choice(ages)) + ", '" + get_random_email() + "', '" + str(
        random.choice(age_categories)) + "', '" + random.choice(classes) + "', '" + random.choice(
        classes) + "', " + random.choice(actives) + ", " + str(random.choice(points)) + ", " + str(
        random.choice(points)) + ");"


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

for i in range(21, 41, 2):
    print(get_new_random_man_insert(i, list_of_man_names, list_of_man_surnames, growths_m, weights_m, ages,
                                    age_categories,
                                    classes,
                                    actives,
                                    points))
    print(get_new_random_man_insert(i + 1, list_of_woman_names, list_of_woman_surnames, growths_w, weights_w, ages,
                                    age_categories,
                                    classes,
                                    actives,
                                    points))

man_surnames.close()
man_names.close()

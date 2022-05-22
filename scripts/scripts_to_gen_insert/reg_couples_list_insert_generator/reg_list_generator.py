num_of_reg_list = 3
nums = open('couples_num_' + str(num_of_reg_list), 'r')
nums_list = nums.read().split()
for i in nums_list:
    print('INSERT INTO ballroom_database.registered_couples\nVALUES(' + str(num_of_reg_list) + ', ' + str(i) + ');')

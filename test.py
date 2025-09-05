def ask_for_shrubbery(knight):
    if knight == "Ni":
        print("We are the Knights who say... Ni!")
    elif knight == "Nip":
        print("No, no! We are now the Knights who say... Nip!")
    elif knight == "Nee-womm":
        print("You must bring us... another shrubbery!")
    else:
        print("I thought you were the Knights who say Ni?")

who_is_on_first = "Ni"
what_is_on_second = "Nip"
i_dont_know_is_on_third = "Nee-womm"

# The classic confusion begins...
ask_for_shrubbery(who_is_on_first) # Who is on first? Ni!
ask_for_shrubbery(what_is_on_second) # What is on second? Nip!
ask_for_shrubbery(i_dont_know_is_on_third) # I don't know is on third? Nee-womm!

# Bonus: a little recursion never hurt anyone...
def bring_shrubbery(times=2):
    if times > 0:
        print("A Shrubbery!")
        bring_shrubbery(times - 1)
    else:
        print("Now... you must cut down the mightiest tree in the forest... with... a herring!")

bring_shrubbery()

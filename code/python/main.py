from admin import markdown_to_html
from admin import markdown_insert_html
from admin import add_navigation_to_html

from json_records import json_records

from a01_setup_webpage import setup_webpage
from make_records import make_records
from apply_meta import apply_meta
from prepare_ppg import prepare_ppg

from initiailize_records import initialize_records

from name_meta import name_meta 

import os


def main():
    """
    """

    print("running main")

    tasks = [0]


    # create records from metadata 
    # populate records with wearable data 
    if 0 in tasks: json_records()

    #if 0 in tasks: initialize_records()

    #if 0 in tasks: name_meta()

    #if 0 in tasks: setup_webpage()
    #if 1 in tasks: make_records()
    #if 2 in tasks: apply_meta() 
    #if 3 in tasks: prepare_ppg()


    print("completed main")


if __name__ == "__main__":
    main()

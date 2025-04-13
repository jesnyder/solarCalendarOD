from scrape_noaa import scrape_noaa
from organized import organized


def main():
    """
    """

    print("running main")

    tasks = [1]

    if 0 in tasks: scrape_noaa()

    if 1 in tasks: organized()


    print("completed main")


if __name__ == "__main__":
    main()
#!/usr/bin/env python

import pandas as pd
from matplotlib import pyplot as plt

models = {
    "small": "k-",
    "st_venent_kirchhoff": ".",
    "neo_hookean": ".",
    "truesdell": "--",
    "jaumann": "|",
    "green_naghdi": "_",
}

if __name__ == "__main__":
    fig, ax = plt.subplots(1, 2, figsize=(12, 5))

    for model, art in models.items():
        result = pd.read_csv("{}_out.csv".format(model))
        ax[0].plot(result["displacement"], result["force_x"], art, label=model)
        ax[1].plot(result["displacement"], result["force_y"], art, label=model)

    ax[0].set_xlabel("displacement (mm)")
    ax[0].set_ylabel("force in x (N/mm)")
    ax[0].legend()

    ax[1].set_xlabel("displacement (mm)")
    ax[1].set_ylabel("force in y (N/mm)")
    ax[1].legend()

    fig.tight_layout()
    fig.savefig("comparison.png")

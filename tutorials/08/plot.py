#!/usr/bin/env python

import pandas as pd
from matplotlib import pyplot as plt
from pathlib import Path

art = {
    "newmark": "k-",
    "hht": "b--",
    "consistent": "k-",
    "lumped": "b--",
    "lump preconditioned": "r.",
}


def _plot(method):
    fig, ax = plt.subplots()

    for file in Path(".").glob("*_out.csv"):
        tokens = file.stem.split("_")
        if tokens[0] != method:
            continue
        result = pd.read_csv(file)
        disc = " ".join(tokens[1:-1])
        ax.plot(
            result["time"], result["displacement"], art[disc], markersize=3, label=disc
        )

    ax.set_ylim(-0.0015, 0.0015)
    ax.set_xlabel("time (s)")
    ax.set_ylabel("displacement (mm)")
    ax.legend()

    fig.tight_layout()
    fig.savefig("{}.png".format(method))


if __name__ == "__main__":
    _plot("implicit")
    _plot("explicit")

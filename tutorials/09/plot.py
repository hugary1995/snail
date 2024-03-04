#!/usr/bin/env python

import pandas as pd
from matplotlib import pyplot as plt


def _plot(result, constraint, target, add_one=False):
    fig, ax = plt.subplots()

    ax.plot(result["time"][1:], result[constraint + "_A"][1:], "r--", label="A")
    ax.plot(result["time"][1:], result[constraint + "_B"][1:], "b--", label="B")
    ax.plot(result["time"][1:], result[constraint + "_C"][1:], "g--", label="C")
    ax.plot(result["time"][1:], result[constraint + "_D"][1:], "y--", label="D")

    constraint_target = result[target] + 1 if add_one else result[target]
    ax.plot(result["time"], constraint_target, "k-", linewidth=2, label="target")
    ax.plot(
        result["time"][1:],
        result[constraint][1:],
        "ko",
        markersize=5,
        markerfacecolor="none",
        label="homogenized",
    )

    ax.set_xlabel("time (s)")
    ax.set_ylabel(constraint)
    ax.legend()

    fig.tight_layout()
    fig.savefig("{}.svg".format(constraint))


if __name__ == "__main__":
    result = pd.read_csv("RVE_out.csv")
    _plot(result, "Fxx", "exx", True)
    _plot(result, "Pxy", "sxy")
    _plot(result, "Fyx", "eyx")
    _plot(result, "Pyy", "syy")

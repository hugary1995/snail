#!/usr/bin/env python

import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
from pathlib import Path

if __name__ == "__main__":
    fig, ax = plt.subplots()

    # 3D
    result = pd.read_csv("cylindrical_3D.csv")
    ax.plot(result["displacement"], result["force"], "k-", label="3D")

    # 2D RZ
    result = pd.read_csv("cylindrical_2D_RZ.csv")
    ax.plot(result["displacement"], result["force"], "ro--", label="2D Axisymmetric")

    ax.set_xlabel("displacement (mm)")
    ax.set_ylabel("force (N)")
    ax.legend()

    fig.tight_layout()
    fig.savefig("comparison.png")
